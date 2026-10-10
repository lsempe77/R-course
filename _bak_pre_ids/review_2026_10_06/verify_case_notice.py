"""Verify the once-per-deck notice and identical typography across active decks."""
import asyncio,json
from pathlib import Path
from playwright.async_api import async_playwright
ROOT=Path(__file__).resolve().parents[1]
NAMES=['Oct12_session1_live','Oct12_session2','Oct12_session3_live','Oct13_session1','Oct13_session2_live','Oct13_session3','Oct14_session1_live','Oct14_session2','Oct14_session3_live','Oct15_session1','Oct15_session2_live']
async def main():
 out=Path(__file__).parent/'qa/case_notice';out.mkdir(parents=True,exist_ok=True);reports=[]
 async with async_playwright() as pw:
  b=await pw.chromium.launch()
  for name in NAMES:
   p=await b.new_page(viewport={'width':1280,'height':720})
   await p.goto('http://127.0.0.1:8768/'+name+'.html',wait_until='domcontentloaded')
   await p.wait_for_function('window.Reveal && Reveal.isReady()');await p.wait_for_timeout(1000)
   assert await p.locator('.case-notice').count()==1
   assert await p.locator('#title-slide .case-notice').count()==1
   assert await p.locator('.fiction').count()==0
   assert await p.locator('.slides').get_by_text('Fictional GreenWaste case',exact=False).evaluate_all('es=>es.filter(e=>!e.closest(".notes")).length')==0
   style=await p.locator('.case-notice').evaluate('(e)=>{const s=getComputedStyle(e);return {size:s.fontSize,family:s.fontFamily,weight:s.fontWeight,colour:s.color,text:e.textContent}}')
   assert style['size']=='19px';assert style['weight']=='400';assert style['text']=='GreenWaste is a fictional training case.'
   fit=await p.evaluate('''()=>{const s=Reveal.getCurrentSlide(),r=s.getBoundingClientRect(),scale=r.width/1280;let bottom=r.top;s.querySelectorAll('*').forEach(e=>{const t=e.getBoundingClientRect();if(t.height&&!e.closest('.notes'))bottom=Math.max(bottom,t.bottom)});return Math.round((bottom-r.top)/scale-720)}''');assert fit<=2,fit
   await p.screenshot(path=str(out/(name+'.png')))
   await p.evaluate('Reveal.slide(1)');assert await p.locator('section.present .case-notice').count()==0
   reports.append({'deck':name,'title_overflow':fit,**style});await p.close()
  await b.close()
 assert len({json.dumps({k:v for k,v in r.items() if k not in ['deck','title_overflow']},sort_keys=True) for r in reports})==1
 (out/'checks.json').write_text(json.dumps(reports,indent=2));print(json.dumps(reports))
asyncio.run(main())
