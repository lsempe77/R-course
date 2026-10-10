"""Verify the separate city DiD review, including its executed trainer calculation."""
import asyncio,csv,json,re,statistics
from pathlib import Path
from PIL import Image,ImageDraw
from playwright.async_api import async_playwright
from verify_session1_review import geometry
ROOT=Path(__file__).resolve().parents[1]
OUT=Path(__file__).parent/'qa'/'day2_session1_review'
BASE='http://127.0.0.1:8768/'

async def main():
    OUT.mkdir(parents=True,exist_ok=True)
    text=(ROOT/'Oct13_session1_review.qmd').read_text(encoding='utf-8')
    times=re.findall(r'::: \{\.notes\}\s*\n(\d+) minutes\.',text)
    assert len(times)==14 and sum(map(int,times))==90,times
    rows=list(csv.DictReader((ROOT/'evaluation_data_GreenWaste_simple.csv').open()))
    city=[r for r in rows if r['setting']=='city']
    tp=[r for r in city if r['took_part']=='1'];other=[r for r in city if r['took_part']=='0']
    mean=lambda rs,c:statistics.mean(float(r[c]) for r in rs)
    changes=[mean(rs,'cost_after')-mean(rs,'cost_before') for rs in [tp,other]]
    assert len(tp)==4794 and len(other)==5206
    assert [round(x) for x in changes]==[-669,143]
    assert round(changes[0]-changes[1])==-812
    assert round(mean(tp,'cost_before')+changes[1])==1575
    reports=[];errors=[]
    async with async_playwright() as pw:
        browser=await pw.chromium.launch()
        page=await browser.new_page(viewport={'width':1280,'height':720})
        page.on('pageerror',lambda e:errors.append(str(e)))
        await page.goto(BASE+'Oct13_session1_review.html',wait_until='domcontentloaded')
        await page.wait_for_function('window.Reveal && Reveal.isReady()')
        assert await page.evaluate('Reveal.getTotalSlides()')==15
        assert await page.locator('.case-notice').count()==1
        for i in range(15):
            await page.evaluate('i=>Reveal.slide(i,0,-1)',i)
            await page.wait_for_timeout(180)
            states=[await geometry(page)]
            for button in await page.locator('section.present button[data-open]').all():
                await button.click();assert await button.get_attribute('aria-expanded')=='true'
                states.append(await geometry(page))
            for button in await page.locator('section.present button[data-table-column]').all():
                await button.click()
                assert await page.locator('section.present td.highlight-cell').count()==4
                await button.click()
            await page.screenshot(path=str(OUT/f'{i:02d}.png'))
            for button in await page.locator('section.present button[data-swap]').all():
                target=await button.get_attribute('data-swap')
                await button.click();assert await button.get_attribute('aria-pressed')=='true'
                assert await page.locator('#'+target+' [data-variant]:not([hidden])').count()==1
                states.append(await geometry(page))
                await page.screenshot(path=str(OUT/f'{i:02d}_alternate.png'))
                await button.click();assert await button.get_attribute('aria-pressed')=='false'
            reports.append({'slide':i,'states':states})
        await page.evaluate('Reveal.slide(4,0,-1)')
        await page.locator('section.present .exercise-editor-btn-run-code').wait_for(timeout=120000)
        await page.wait_for_function("!document.querySelector('section.present .exercise-editor-btn-run-code')?.classList.contains('disabled')",timeout=120000)
        await page.locator('section.present .exercise-editor-btn-run-code').click()
        await page.wait_for_function("document.querySelector('section.present .cell-output-container-webr')?.innerText.includes('-812')",timeout=120000)
        output=await page.locator('section.present .cell-output-container-webr').inner_text()
        reports.append({'trainerOutput':output,'states':[await geometry(page)]})
        assert await page.locator('section.present .cm-scroller').evaluate('(e)=>e.scrollWidth<=e.clientWidth+2')
        await page.screenshot(path=str(OUT/'04_executed.png'))
        await page.goto(BASE+'day2_session1_compare.html',wait_until='domcontentloaded')
        await page.wait_for_function("['current','proposed'].every(id=>document.getElementById(id).contentWindow.Reveal?.isReady())")
        for button in await page.locator('[data-pair]').all():
            pair=list(map(int,(await button.get_attribute('data-pair')).split(',')))
            await button.click()
            for j,id in enumerate(['current','proposed']):
                actual=await page.evaluate('(id)=>document.getElementById(id).contentWindow.Reveal.getIndices().h',id)
                assert actual==pair[j],(id,actual,pair)
        await page.get_by_role('button',name='Regression',exact=True).click()
        assert await page.evaluate("document.getElementById('proposed').contentWindow.Reveal.getCurrentSlide().id")=='d2s1-p05'
        await page.screenshot(path=str(OUT/'comparison.png'))
        await page.set_viewport_size({'width':375,'height':812})
        assert await page.evaluate('document.documentElement.scrollWidth<=innerWidth')
        await page.screenshot(path=str(OUT/'comparison_phone.png'),full_page=True)
        await page.set_viewport_size({'width':850,'height':1120})
        await page.goto(BASE+'Oct13_session1_review_worksheet.html',wait_until='domcontentloaded')
        assert await page.locator('.sheet-page').count()==6
        source=await page.locator('.sheet-page').first.inner_text()
        assert '10,000 businesses' in source and '792-833' in source
        assert all(chr(167)+str(i) in source for i in range(1,5))
        for i,panel in enumerate(await page.locator('.sheet-page').all(),1):
            await panel.screenshot(path=str(OUT/f'worksheet_{i}.png'))
        await page.emulate_media(media='print')
        await page.set_viewport_size({'width':688,'height':1016})
        dimensions=await page.locator('.sheet-page').evaluate_all('(es)=>es.map(e=>({height:e.getBoundingClientRect().height,width:e.getBoundingClientRect().width}))')
        for i,panel in enumerate(await page.locator('.sheet-page').all(),1):
            await panel.screenshot(path=str(OUT/f'print_{i}.png'))
        bad=[r for r in reports if any(s['over']>0 or s['right']>0 or s['logoCollision'] for s in r['states'])]
        result={'slides':15,'timing':90,'reports':reports,'errors':errors,'layoutFailures':bad,'worksheetPrint':dimensions}
        (OUT/'checks.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
        thumbs=[]
        for path in sorted(OUT.glob('[0-9][0-9].png')):
            im=Image.open(path).convert('RGB');im.thumbnail((384,216))
            tile=Image.new('RGB',(384,238),'white');tile.paste(im,(0,0));ImageDraw.Draw(tile).text((8,220),path.stem,fill='black');thumbs.append(tile)
        for start in range(0,len(thumbs),6):
            montage=Image.new('RGB',(1152,476),'#ddd')
            for j,tile in enumerate(thumbs[start:start+6]):montage.paste(tile,((j%3)*384,(j//3)*238))
            montage.save(OUT/f'montage_{start//6+1}.jpg')
        print(json.dumps({'slides':15,'timing':90,'layoutFailures':bad,'errors':errors,'worksheet':dimensions,'trainerOutput':output},indent=2),flush=True)
        assert not bad and not errors
        assert all(d['height']<=1016 for d in dimensions)
        await browser.close()

if __name__=='__main__':asyncio.run(main())
