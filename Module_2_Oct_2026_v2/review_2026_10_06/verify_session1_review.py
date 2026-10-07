"""Check the separate Session 1 prototype without editing the existing deck."""
import asyncio, json, re
from pathlib import Path
from playwright.async_api import async_playwright
from PIL import Image, ImageOps, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
OUT = Path(__file__).parent / 'qa' / 'session1_review'
BASE = 'http://127.0.0.1:8768/'

async def geometry(page):
    return await page.evaluate('''() => {
      const s=Reveal.getCurrentSlide(),r=s.getBoundingClientRect(),scale=r.width/1280;
      let bottom=r.top,right=r.left;
      s.querySelectorAll('*').forEach(e=>{const b=e.getBoundingClientRect(),c=getComputedStyle(e);
        if(b.width&&b.height&&c.display!=='none'&&c.visibility!=='hidden'&&!e.closest('.notes')){
          bottom=Math.max(bottom,b.bottom);right=Math.max(right,b.right);
        }
      });
      const h=s.querySelector('h2'),logo=document.querySelector('.slide-logo'),lr=logo?.getBoundingClientRect();
      let collision=false;
      if(h&&lr){const q=document.createRange();q.selectNodeContents(h);
        collision=[...q.getClientRects()].some(b=>b.left<lr.right&&b.right>lr.left&&b.top<lr.bottom&&b.bottom>lr.top);}
      return {heading:s.querySelector('h2,h1')?.innerText,over:Math.round((bottom-r.top)/scale-720),right:Math.round((right-r.left)/scale-1280),logoCollision:collision};
    }''')

async def main():
    OUT.mkdir(parents=True,exist_ok=True)
    source=(ROOT/'Oct12_session1_review.qmd').read_text(encoding='utf-8')
    times=re.findall(r'::: \{\.notes\}\s*\n(\d+) minutes\.',source)
    assert len(times)==17 and sum(map(int,times))==90,times
    reports=[];errors=[]
    async with async_playwright() as pw:
        browser=await pw.chromium.launch()
        page=await browser.new_page(viewport={'width':1280,'height':720})
        page.on('pageerror',lambda e:errors.append(str(e)))
        await page.goto(BASE+'Oct12_session1_review.html',wait_until='domcontentloaded')
        await page.wait_for_function('window.Reveal && Reveal.isReady()')
        await page.wait_for_timeout(600)
        assert await page.evaluate('Reveal.getTotalSlides()')==18
        assert await page.locator('.case-notice').count()==1
        for index in range(18):
            await page.evaluate('i=>{const ix=Reveal.getIndices(Reveal.getSlides()[i]);Reveal.slide(ix.h,ix.v,-1)}',index)
            await page.wait_for_timeout(180)
            default=await geometry(page)
            if index==4:
                assert not await page.locator('#s1-mean-answer').is_visible()
            for button in await page.locator('section.present button[data-open]').all():
                await button.click()
                assert await button.get_attribute('aria-expanded')=='true'
            for button in await page.locator('section.present button[data-table-column]').all():
                await button.click()
                assert await page.locator('section.present td.highlight-cell').count()==2
                await button.click()
            expanded=await geometry(page)
            await page.screenshot(path=str(OUT/f'{index:02d}.png'))
            states=[]
            for button in await page.locator('section.present button[data-swap]').all():
                await button.click();await page.wait_for_timeout(150)
                states.append(await geometry(page))
                await page.screenshot(path=str(OUT/f'{index:02d}_alternate.png'))
                await button.click()
            reports.append({'index':index,'default':default,'expanded':expanded,'alternates':states})
        # The one optional trainer calculation must execute, not just render.
        await page.evaluate('Reveal.slide(8,0,-1)')
        await page.locator('section.present .exercise-editor-btn-run-code').wait_for(timeout=120000)
        await page.wait_for_function("!document.querySelector('section.present .exercise-editor-btn-run-code')?.classList.contains('disabled')",timeout=120000)
        await page.locator('section.present .exercise-editor-btn-run-code').click()
        await page.wait_for_function("document.querySelector('section.present .cell-output-container-webr')?.innerText.includes('-669')",timeout=120000)
        assert await page.locator('section.present .cm-scroller').evaluate('(e)=>e.scrollWidth<=e.clientWidth+2'), 'Trainer comments require horizontal scrolling'
        await page.screenshot(path=str(OUT/'08_executed.png'))
        code_geometry=await geometry(page)
        assert code_geometry['over']<=0 and code_geometry['right']<=0 and not code_geometry['logoCollision'],code_geometry
        reports.append({'trainerResult':await page.locator('section.present .cell-output-container-webr').inner_text(),'geometry':code_geometry})
        # Compare-page controls target corresponding topics in the two different sequences.
        await page.goto(BASE+'session1_compare.html',wait_until='domcontentloaded')
        await page.wait_for_function("['current','proposed'].every(id=>document.getElementById(id).contentWindow.Reveal?.isReady())")
        await page.get_by_role('button',name='Coefficient',exact=True).click()
        assert await page.evaluate("document.getElementById('current').contentWindow.Reveal.getCurrentSlide().querySelector('h2').innerText")== 'Coefficient: which row is the change?'
        assert await page.evaluate("document.getElementById('proposed').contentWindow.Reveal.getCurrentSlide().id")=='s1-p07'
        await page.screenshot(path=str(OUT/'comparison.png'))
        await page.set_viewport_size({'width':375,'height':812})
        assert await page.evaluate('document.documentElement.scrollWidth <= window.innerWidth')
        await page.screenshot(path=str(OUT/'comparison_phone.png'),full_page=True)
        # Check the worksheet has four identified printable pages and the same cost/table source.
        await page.set_viewport_size({'width':850,'height':1120})
        await page.goto(BASE+'Oct12_session1_review_worksheet.html',wait_until='domcontentloaded')
        assert await page.locator('.sheet-page').count()==4
        assert '13,906' not in await page.locator('.sheet-page').first.inner_text() # mean answer withheld
        for i,panel in enumerate(await page.locator('.sheet-page').all(),1):
            await panel.screenshot(path=str(OUT/f'worksheet_{i}.png'))
        await page.emulate_media(media='print')
        # A4 minus two 14 mm margins: approximately 688 px of printable width.
        await page.set_viewport_size({'width':688,'height':1016})
        dimensions=await page.locator('.sheet-page').evaluate_all('(es)=>es.map(e=>({height:e.getBoundingClientRect().height,width:e.getBoundingClientRect().width}))')
        assert all(d['height']<=1016 for d in dimensions),dimensions
        reports.append({'worksheetPrintDimensions':dimensions})
        await page.goto(BASE+'AI_good_practice_review.html',wait_until='domcontentloaded')
        await page.emulate_media(media='print')
        await page.set_viewport_size({'width':673,'height':1001})
        card=await page.locator('body').bounding_box()
        assert card and card['height']<=1001,card
        assert 'Microsoft Copilot' in await page.locator('body').inner_text()
        await page.screenshot(path=str(OUT/'ai_card.png'),full_page=True)
        reports.append({'aiCardPrintDimensions':card})
        await browser.close()
    bad=[r for r in reports if 'default' in r and any(v['over']>0 or v['right']>0 or v['logoCollision'] for v in [r['default'],r['expanded']]+r['alternates'])]
    result={'timing':90,'slides':18,'reports':reports,'errors':errors,'layoutFailures':bad}
    (OUT/'checks.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
    thumbs=[]
    for path in sorted(OUT.glob('[0-9][0-9].png')):
        pic=Image.open(path).convert('RGB');pic.thumbnail((384,216))
        tile=Image.new('RGB',(384,238),'white');tile.paste(pic,(0,0));ImageDraw.Draw(tile).text((8,220),path.stem,fill='black');thumbs.append(tile)
    for start in range(0,len(thumbs),6):
        montage=Image.new('RGB',(1152,476),'#dddddd')
        for j,tile in enumerate(thumbs[start:start+6]):montage.paste(tile,((j%3)*384,(j//3)*238))
        montage.save(OUT/f'montage_{start//6+1}.jpg')
    print(json.dumps({'slides':18,'timing':90,'layoutFailures':bad,'errors':errors,'worksheet':dimensions},indent=2),flush=True)
    assert not bad and not errors

if __name__=='__main__':asyncio.run(main())
