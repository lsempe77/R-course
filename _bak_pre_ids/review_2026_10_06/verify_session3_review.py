"""Check source-linked Session 3 review materials and native interactions."""
import asyncio, csv, json, re, statistics
from pathlib import Path
from PIL import Image, ImageDraw
from playwright.async_api import async_playwright
from verify_session1_review import geometry

ROOT=Path(__file__).resolve().parents[1]
OUT=Path(__file__).parent/'qa'/'session3_review'
BASE='http://127.0.0.1:8768/'

async def main():
    OUT.mkdir(parents=True,exist_ok=True)
    source=(ROOT/'Oct12_session3_review.qmd').read_text(encoding='utf-8')
    times=re.findall(r'::: \{\.notes\}\s*\n(\d+) minutes\.',source)
    assert len(times)==16 and sum(map(int,times))==120,times
    rows=list(csv.DictReader((ROOT/'evaluation_data_GreenWaste_simple.csv').open()))
    city=[r for r in rows if r['setting']=='pilot']
    tp=[r for r in city if r['took_part']=='1'];other=[r for r in city if r['took_part']=='0']
    mean=lambda r,c:statistics.mean(float(x[c]) for x in r)
    assert len(tp)==200 and len(other)==200
    assert round(mean(tp,'cost_before'))==1390 and round(mean(other,'cost_before'))==1411
    assert round(mean(tp,'cost_after')-mean(other,'cost_after'))==-1014
    assert all(float(r['score'])<=58 for r in city)
    reports=[];errors=[]
    async with async_playwright() as pw:
        browser=await pw.chromium.launch()
        page=await browser.new_page(viewport={'width':1280,'height':720})
        page.on('pageerror',lambda e:errors.append(str(e)))
        await page.goto(BASE+'Oct12_session3_review.html',wait_until='domcontentloaded')
        await page.wait_for_function('window.Reveal && Reveal.isReady()')
        assert await page.evaluate('Reveal.getTotalSlides()')==17
        assert await page.locator('.case-notice').count()==1
        for i in range(17):
            await page.evaluate('i=>Reveal.slide(i,0,-1)',i)
            await page.wait_for_timeout(180)
            states=[await geometry(page)]
            for button in await page.locator('section.present button[data-open]').all():
                await button.click();assert await button.get_attribute('aria-expanded')=='true'
                states.append(await geometry(page))
            for button in await page.locator('section.present button[data-table-column]').all():
                await button.click()
                assert await page.locator('section.present td.highlight-cell').count()==2
                await button.click()
            await page.screenshot(path=str(OUT/f'{i:02d}.png'))
            for button in await page.locator('section.present button[data-swap]').all():
                target=await button.get_attribute('data-swap')
                assert await page.locator('#'+target+' [data-variant]:not([hidden])').count()==1
                await button.click();assert await button.get_attribute('aria-pressed')=='true'
                assert await page.locator('#'+target+' [data-variant]:not([hidden])').count()==1
                states.append(await geometry(page))
                await page.screenshot(path=str(OUT/f'{i:02d}_alternate.png'))
                await button.click();assert await button.get_attribute('aria-pressed')=='false'
            reports.append({'slide':i,'states':states})
        await page.evaluate('Reveal.slide(4,0,-1)')
        await page.locator('section.present .exercise-editor-btn-run-code').wait_for(timeout=120000)
        await page.wait_for_function("!document.querySelector('section.present .exercise-editor-btn-run-code')?.classList.contains('disabled')",timeout=120000)
        run=page.locator('section.present .exercise-editor-btn-run-code')
        await run.click()
        await page.wait_for_function("document.querySelector('section.present .cell-output-container-webr')?.innerText.includes('35.2')",timeout=120000)
        first=await page.locator('section.present .cell-output-container-webr').inner_text()
        assert '35.6' in first and 'Join' in first and 'Wait' in first,first
        await page.screenshot(path=str(OUT/'04_draw1.png'))
        await run.click()
        await page.wait_for_function("document.querySelector('section.present .cell-output-container-webr')?.innerText.includes('36.8')",timeout=120000)
        second=await page.locator('section.present .cell-output-container-webr').inner_text()
        assert '34' in second and first!=second,second
        executed=await geometry(page)
        assert await page.locator('section.present .cm-scroller').evaluate('(e)=>e.scrollWidth<=e.clientWidth+2')
        await page.screenshot(path=str(OUT/'04_draw2.png'))
        reports.append({'trainerDraws':[first,second],'states':[executed]})
        await page.goto(BASE+'session3_compare.html',wait_until='domcontentloaded')
        await page.wait_for_function("['current','proposed'].every(id=>document.getElementById(id).contentWindow.Reveal?.isReady())")
        for button in await page.locator('[data-pair]').all():
            await button.click()
            assert await page.locator('#comparison-status').inner_text()== 'Showing '+await button.inner_text()+' in both versions.'
        await page.get_by_role('button',name='Regression',exact=True).click()
        assert await page.evaluate("document.getElementById('proposed').contentWindow.Reveal.getCurrentSlide().id")=='s3-p08'
        await page.screenshot(path=str(OUT/'comparison.png'))
        await page.set_viewport_size({'width':375,'height':812})
        assert await page.evaluate('document.documentElement.scrollWidth<=innerWidth')
        await page.screenshot(path=str(OUT/'comparison_phone.png'),full_page=True)
        await page.set_viewport_size({'width':850,'height':1120})
        await page.goto(BASE+'Oct12_session3_review_worksheet.html',wait_until='domcontentloaded')
        assert await page.locator('.sheet-page').count()==6
        assert '400 businesses' in await page.locator('.sheet-page').first.inner_text()
        for i,panel in enumerate(await page.locator('.sheet-page').all(),1):
            await panel.screenshot(path=str(OUT/f'worksheet_{i}.png'))
        await page.emulate_media(media='print')
        await page.set_viewport_size({'width':688,'height':1016})
        dimensions=await page.locator('.sheet-page').evaluate_all('(es)=>es.map(e=>({height:e.getBoundingClientRect().height,width:e.getBoundingClientRect().width}))')
        reports.append({'worksheetPrint':dimensions})
        await page.goto(BASE+'Oct12_session3_review_slips.html',wait_until='domcontentloaded')
        assert await page.locator('.slip').count()==20
        ages=[await x.inner_text() for x in await page.locator('.slip .age').all()]
        assert ages==['Age '+r['manager_age'] for r in city[:20]],ages
        slips=await page.locator('body').bounding_box()
        assert slips['height']<=1016,slips
        reports.append({'slipsPrint':slips})
        await page.screenshot(path=str(OUT/'age_slips.png'),full_page=True)
        # Save findings before browser cleanup, which can be slow on Windows.
        bad=[r for r in reports if 'states' in r and any(s['over']>0 or s['right']>0 or s['logoCollision'] for s in r['states'])]
        result={'slides':17,'timing':120,'reports':reports,'errors':errors,'layoutFailures':bad}
        (OUT/'checks.json').write_text(json.dumps(result,indent=2),encoding='utf-8')
        thumbs=[]
        for path in sorted(OUT.glob('[0-9][0-9].png')):
            im=Image.open(path).convert('RGB');im.thumbnail((384,216))
            tile=Image.new('RGB',(384,238),'white');tile.paste(im,(0,0));ImageDraw.Draw(tile).text((8,220),path.stem,fill='black');thumbs.append(tile)
        for start in range(0,len(thumbs),6):
            montage=Image.new('RGB',(1152,476),'#ddd')
            for j,tile in enumerate(thumbs[start:start+6]):montage.paste(tile,((j%3)*384,(j//3)*238))
            montage.save(OUT/f'montage_{start//6+1}.jpg')
        print(json.dumps({'slides':17,'timing':120,'layoutFailures':bad,'errors':errors,'worksheet':dimensions,'ageSlips':slips},indent=2),flush=True)
        assert not bad and not errors
        assert all(x['height']<=1016 for x in dimensions)
        await browser.close()

if __name__=='__main__':asyncio.run(main())
