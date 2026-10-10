import asyncio,json
from pathlib import Path
from playwright.async_api import async_playwright
async def main():
 out=Path(__file__).parent/'qa/day3_final';out.mkdir(parents=True,exist_ok=True)
 results=[]
 async with async_playwright() as pw:
  browser=await pw.chromium.launch()
  for name,indices in [('Oct14_session1_live',[4]),('Oct14_session2',[1,2])]:
   page=await browser.new_page(viewport={'width':1280,'height':720})
   await page.goto('http://127.0.0.1:8768/'+name+'.html',wait_until='domcontentloaded')
   await page.wait_for_function('window.Reveal && Reveal.isReady()')
   for i in indices:
    await page.evaluate('i=>Reveal.slide(i)',i);await page.wait_for_timeout(1000)
    for variant in range(2 if i==2 else 1):
     info=await page.evaluate("()=>{\n       const s=Reveal.getCurrentSlide(),h=s.querySelector('h2').getBoundingClientRect(),l=document.querySelector('.slide-logo').getBoundingClientRect();\n       const overlap=h.left<l.right&&h.right>l.left&&h.top<l.bottom&&h.bottom>l.top;\n       const svg=[...s.querySelectorAll('svg')].filter(e=>e.getBoundingClientRect().height>0);\n       const text=svg.flatMap(g=>[...g.querySelectorAll('text')].map(t=>{const b=t.getBBox();return {text:t.textContent,left:b.x,right:b.x+b.width}}));\n       return {heading:s.querySelector('h2').textContent,overlap,text};\n      }")
     assert not info['overlap'],info
     assert all(t['left']>=0 and t['right']<=1000 for t in info['text']),info
     results.append(info)
     await page.screenshot(path=str(out/f'{name}_{i}_{variant}.png'))
     if i==2:await page.locator('section.present button[data-swap]').click()
   await page.close()
  await browser.close()
 (out/'checks.json').write_text(json.dumps(results,indent=2))
 print('Final changed headings and chart labels fit; both axis states inspected.')
asyncio.run(main())
