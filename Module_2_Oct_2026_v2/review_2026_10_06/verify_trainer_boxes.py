"""Run each commented trainer calculation and check its final slide layout."""
import asyncio,json
from pathlib import Path
from playwright.async_api import async_playwright
NAMES=['Oct12_session1_live','Oct12_session3_live','Oct13_session1','Oct13_session2_live','Oct13_session3','Oct14_session1_live','Oct14_session2','Oct14_session3_live']
EXPECTED=['-669',None,'-812','-721','-1,029','1.86','49.5',None]
async def main():
 out=Path(__file__).parent/'qa/trainer_boxes';out.mkdir(parents=True,exist_ok=True);results=[]
 async with async_playwright() as pw:
  browser=await pw.chromium.launch()
  for name,expected in zip(NAMES,EXPECTED):
   page=await browser.new_page(viewport={'width':1280,'height':720});errors=[]
   page.on('pageerror',lambda e:errors.append(str(e)))
   await page.goto('http://127.0.0.1:8768/'+name+'.html',wait_until='domcontentloaded')
   await page.wait_for_function('window.Reveal && Reveal.isReady()')
   await page.wait_for_selector('.exercise-editor-header',state='attached')
   index=await page.locator('.exercise-editor').first.evaluate('(e)=>Reveal.getSlides().indexOf(e.closest("section"))')
   await page.evaluate('i=>Reveal.slide(i)',index)
   run=page.locator('section.present .exercise-editor-btn-run-code')
   await page.wait_for_function('!!document.querySelector("section.present .exercise-editor-btn-run-code:not(.disabled)")',timeout=120000)
   assert 'Trainer calculation' in await page.locator('section.present .exercise-editor-header').inner_text()
   assert '#' in await page.locator('section.present .cm-content').inner_text()
   before=await page.evaluate('document.querySelector("section.present .cell-output-webr")?.innerText || ""')
   await run.click()
   await page.wait_for_function('(old)=>(document.querySelector("section.present .cell-output-webr")?.innerText || "")!==old',arg=before,timeout=90000)
   await page.wait_for_timeout(1200)
   output=await page.locator('section.present .cell-output-webr').inner_text()
   assert 'Error' not in output,output
   if expected:assert expected.replace(',','') in output.replace(',',''),(name,output)
   info=await page.evaluate('''()=>{
    const s=Reveal.getCurrentSlide(),sr=s.getBoundingClientRect(),scale=sr.width/1280;let maxB=sr.top,maxR=sr.left;
    s.querySelectorAll('*').forEach(e=>{const r=e.getBoundingClientRect(),st=getComputedStyle(e);if(r.height>0&&st.visibility!=='hidden'&&st.display!=='none'&&!e.closest('.notes')){maxB=Math.max(maxB,r.bottom);maxR=Math.max(maxR,r.right)}});
    return {over:Math.round((maxB-sr.top)/scale-720),right:Math.round((maxR-sr.left)/scale-1280),font:getComputedStyle(s.querySelector('.cm-editor')).fontSize,editorOverflow:s.querySelector('.cm-scroller').scrollWidth-s.querySelector('.cm-scroller').clientWidth}
   }''')
   await page.screenshot(path=str(out/(name+'.png')))
   assert await page.locator('section.present .cell-output-container-webr > .sourceCode').evaluate_all('es=>es.every(e=>getComputedStyle(e).display==="none")')
   assert info['over']<=2 and info['right']<=2,(name,info)
   assert info['editorOverflow']<=2,(name,info)
   assert info['font']=='22px';assert not errors,errors
   await page.screenshot(path=str(out/(name+'.png')))
   results.append({'deck':name,'output':output,**info,'errors':errors});print(json.dumps(results[-1]),flush=True)
   await page.close()
  await browser.close()
 (out/'checks.json').write_text(json.dumps(results,indent=2),encoding='utf-8')
asyncio.run(main())
