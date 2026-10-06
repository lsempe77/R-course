import asyncio,json
from pathlib import Path
from playwright.async_api import async_playwright
async def main():
 out=Path('review_2026_10_06/qa/hubs');out.mkdir(parents=True,exist_ok=True)
 checks=[]
 async with async_playwright() as pw:
  b=await pw.chromium.launch()
  for n in ['day4_review','week_ready']:
   for w in [1280,375]:
    p=await b.new_page(viewport={'width':w,'height':900});errs=[];p.on('pageerror',lambda e:errs.append(str(e)))
    await p.goto((Path('../.preview_day2_publish/docs/preview')/(n+'.html')).resolve().as_uri())
    await p.screenshot(path=str(out/(n+'_'+str(w)+'.png')),full_page=True)
    info=await p.evaluate('({width:innerWidth,scroll:document.documentElement.scrollWidth,title:document.querySelector("h1").innerText})')
    assert info['scroll']<=w,info
    assert not errs,errs
    checks.append(info);await p.close()
  await b.close()
 (out/'checks.json').write_text(json.dumps(checks,indent=2));print(json.dumps(checks))
asyncio.run(main())
