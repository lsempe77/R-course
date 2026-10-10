"""Walk changed headings, expanded evidence and executed trainer calculations."""
import asyncio,json,sys,time,re,html
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parent))
from reader_titles import CATALOG
from playwright.async_api import async_playwright
async def main():
 out=Path(__file__).parent/'qa/reader_titles';out.mkdir(parents=True,exist_ok=True);start_day=int(sys.argv[1]) if len(sys.argv)>1 else 1
 only=sys.argv[2] if len(sys.argv)>2 else None
 reports=json.loads((out/'checks.json').read_text(encoding='utf-8')) if start_day>1 or only else []
 prior={s['deck'] for s in CATALOG['sessions'] if s['day']<start_day or (only and s['deck']!=only)};reports=[r for r in reports if r['deck'] in prior]
 async with async_playwright() as pw:
  browser=await pw.chromium.launch()
  for item in CATALOG['sessions']:
   if item['day']<start_day or (only and item['deck']!=only):continue
   name=item['deck'];deadline=time.monotonic()+600
   while True:
    source=(Path(__file__).resolve().parents[1]/(name+'.html')).read_text(encoding='utf-8')
    found=re.search(r'<h1[^>]*>(.*?)</h1>',source,re.S)
    if found and html.unescape(re.sub('<[^>]+>','',found[1])).strip()==item['title']:break
    assert time.monotonic()<deadline,name
    await asyncio.sleep(2)
   page=await browser.new_page(viewport={'width':1280,'height':720});errors=[]
   page.on('pageerror',lambda e:errors.append(str(e)))
   await page.goto('http://127.0.0.1:8768/'+name+'.html',wait_until='domcontentloaded')
   await page.wait_for_function('window.Reveal && Reveal.isReady()');await page.wait_for_timeout(700)
   assert await page.locator('#title-slide h1').inner_text()==item['title']
   actual=await page.locator('.slides section h2').all_text_contents();assert [s.strip().replace(chr(8217),chr(39)).replace(chr(8216),chr(39)) for s in actual]==item['headings'],(name,actual)
   count=await page.evaluate('Reveal.getTotalSlides()');assert count==len(item['headings'])+1
   slides=[]
   for i in range(count):
    await page.evaluate('i=>{const s=Reveal.getSlides()[i],ix=Reveal.getIndices(s);Reveal.slide(ix.h,ix.v)}',i);await page.wait_for_timeout(120)
    await page.evaluate("()=>Reveal.getCurrentSlide().querySelectorAll('.fragment').forEach(f=>f.classList.add('visible'))")
    for b in await page.locator('section.present button[data-open]').all():await b.click()
    for b in await page.locator('section.present button[data-claim="unsupported"]').all():await b.click()
    for b in await page.locator('section.present button[data-check]').all():await b.click()
    run=page.locator('section.present .exercise-editor-btn-run-code')
    if await run.count():
     await page.wait_for_function('!!document.querySelector("section.present .exercise-editor-btn-run-code:not(.disabled)")',timeout=120000)
     before=await page.evaluate('document.querySelector("section.present .cell-output-webr")?.innerText || ""')
     await run.click()
     await page.wait_for_function('(old)=>(document.querySelector("section.present .cell-output-webr")?.innerText || "")!==old',arg=before,timeout=90000)
    await page.wait_for_timeout(400)
    info=await page.evaluate('''()=>{
     const s=Reveal.getCurrentSlide(),sr=s.getBoundingClientRect(),scale=sr.width/1280;let maxB=sr.top,maxR=sr.left;
     s.querySelectorAll('*').forEach(e=>{const r=e.getBoundingClientRect(),st=getComputedStyle(e);if(r.height>0&&st.visibility!=='hidden'&&st.display!=='none'&&!e.closest('.notes')){maxB=Math.max(maxB,r.bottom);maxR=Math.max(maxR,r.right)}});
     const h=s.querySelector('h2'),logo=document.querySelector('.slide-logo'),lr=logo?.getBoundingClientRect();let collision=false;
     if(h&&lr){const range=document.createRange();range.selectNodeContents(h);collision=[...range.getClientRects()].some(r=>r.left<lr.right&&r.right>lr.left&&r.top<lr.bottom&&r.bottom>lr.top)}
     return {title:s.querySelector('h2,h1')?.innerText,over:Math.round((maxB-sr.top)/scale-720),right:Math.round((maxR-sr.left)/scale-1280),logoCollision:collision}
    }''')
    await page.screenshot(path=str(out/(name+'_'+str(i).zfill(2)+'.png')))
    assert info['over']<=2 and info['right']<=2 and not info['logoCollision'],(name,i,info)
    slides.append(info)
   assert not errors,errors
   reports.append({'deck':name,'slides':slides,'errors':errors});print(name,len(slides),'screens; no overflow or logo collision',flush=True)
   (out/'checks.json').write_text(json.dumps(reports,indent=2),encoding='utf-8')
   await page.close()
  await browser.close()
asyncio.run(main())
