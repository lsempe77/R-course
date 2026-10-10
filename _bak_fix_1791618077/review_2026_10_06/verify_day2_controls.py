"""Check the final native controls and table columns after the trainer walks."""
import asyncio,json
from pathlib import Path
from playwright.async_api import async_playwright
async def main():
    results=[]
    async with async_playwright() as pw:
        browser=await pw.chromium.launch()
        for name in ['Oct13_session1','Oct13_session2_live','Oct13_session3']:
            page=await browser.new_page(viewport={'width':1280,'height':720})
            await page.goto('http://127.0.0.1:8767/'+name+'.html',wait_until='domcontentloaded')
            await page.wait_for_function('window.Reveal && Reveal.isReady()')
            await page.wait_for_timeout(2000)
            n=await page.evaluate('Reveal.getTotalSlides()');count=0
            for i in range(n):
                await page.evaluate('i=>Reveal.slide(i)',i);await page.wait_for_timeout(200)
                for b in await page.locator('section.present button[data-open]').all():
                    id=await b.get_attribute('data-open');target=page.locator('#'+id)
                    assert await target.get_attribute('hidden') is not None
                    await b.focus();await page.keyboard.press('Space')
                    assert await target.get_attribute('hidden') is None
                    assert await page.evaluate('Reveal.getIndices().h')==i
                    await b.click();assert await target.get_attribute('hidden') is not None;count+=1
                row=page.locator('section.present .reading-table thead tr')
                if await row.count():assert await row.locator('th').count()==3
            if name=='Oct13_session2_live':
                await page.evaluate('Reveal.slide(2)');b=page.locator('section.present button[data-choice]').first
                await b.focus();await page.keyboard.press('Space');assert await b.get_attribute('aria-pressed')=='true'
                assert await page.evaluate('Reveal.getIndices().h')==2
            results.append({'deck':name,'keyboard_and_toggle_reveals':count,'result_columns':3})
            await page.close()
        await browser.close()
    (Path(__file__).parent/'qa/day2_controls.json').write_text(json.dumps(results,indent=2))
    print(json.dumps(results))
asyncio.run(main())
