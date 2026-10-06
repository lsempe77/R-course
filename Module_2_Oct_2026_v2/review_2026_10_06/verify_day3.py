"""Walk a rendered deck, run its trainer cell and capture every slide."""
import asyncio
import json
import sys
from pathlib import Path
from playwright.async_api import async_playwright

async def main(name):
    out=Path(__file__).parent/'qa'/name
    out.mkdir(parents=True,exist_ok=True)
    async with async_playwright() as pw:
        browser=await pw.chromium.launch()
        page=await browser.new_page(viewport={'width':1280,'height':720})
        errors=[]
        page.on('pageerror',lambda e:errors.append(str(e)))
        await page.goto('http://127.0.0.1:8768/'+name+'.html',wait_until='domcontentloaded')
        await page.wait_for_function('window.Reveal && Reveal.isReady()')
        await page.wait_for_timeout(40000 if name!='Oct12_session1_live' else 1000)
        n=await page.evaluate('Reveal.getTotalSlides()')
        results=[]
        for i in range(n):
            await page.evaluate('i=>{const s=Reveal.getSlides()[i],ix=Reveal.getIndices(s);Reveal.slide(ix.h,ix.v)}',i)
            await page.wait_for_timeout(300)
            await page.evaluate("()=>Reveal.getCurrentSlide().querySelectorAll('.fragment').forEach(f=>f.classList.add('visible'))")
            # Open evidence and confidence intervals for the fit check.
            for b in await page.locator('section.present button[data-open]').all():
                target=await b.get_attribute('data-open')
                await b.click()
                assert await page.locator('#'+target).get_attribute('hidden') is None
            run=page.locator('section.present .exercise-editor-btn-run-code')
            if await run.count():
                await run.first.click()
                await page.wait_for_timeout(16000)
                if name=='Oct12_session3_live':
                    first=await page.locator('section.present .cell-output-webr').inner_text()
                    await run.first.click()
                    await page.wait_for_timeout(4000)
                    assert await page.locator('section.present .cell-output-webr').inner_text()!=first
            await page.wait_for_timeout(600)
            info=await page.evaluate('''()=>{
              const s=Reveal.getCurrentSlide(),sr=s.getBoundingClientRect(),scale=sr.width/1280;
              let maxB=sr.top,maxR=sr.left;
              s.querySelectorAll('*').forEach(e=>{const r=e.getBoundingClientRect(),st=getComputedStyle(e);if(r.height>0&&st.visibility!=='hidden'&&st.display!=='none'&&!e.closest('.notes')){maxB=Math.max(maxB,r.bottom);maxR=Math.max(maxR,r.right)}});
              return {title:s.querySelector('h2,h1')?.innerText,over:Math.round((maxB-sr.top)/scale-720),right:Math.round((maxR-sr.left)/scale-1280),outputs:[...s.querySelectorAll('.cell-output-webr')].map(e=>e.innerText)}
            }''')
            info['slide']=i
            results.append(info)
            await page.screenshot(path=str(out/f's{i:02}.png'))
            print(json.dumps(info),flush=True)
        (out/'checks.json').write_text(json.dumps({'slides':results,'errors':errors},indent=2),encoding='utf-8')
        assert n==({'Oct12_session1_live':12,'Oct12_session2':12,'Oct12_session3_live':14,'Oct13_session1':11,'Oct13_session2_live':11,'Oct13_session3':14,'Oct14_session1_live':12,'Oct14_session2':11,'Oct14_session3_live':14}[name])
        assert all(r['over']<=2 and r['right']<=2 for r in results),results
        assert not errors,errors
        print('Browser errors:',errors,flush=True)
        await browser.close()

asyncio.run(main(sys.argv[1]))
