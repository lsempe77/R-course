"""Verify live hub links, day filters, keyboard controls and phone layouts."""
import asyncio,json,urllib.request
from pathlib import Path
from bs4 import BeautifulSoup
from playwright.async_api import async_playwright
ROOT=Path(__file__).resolve().parents[2]
OUT=Path(__file__).parent/'qa/live_hub';OUT.mkdir(parents=True,exist_ok=True)
async def main():
 soup=BeautifulSoup((ROOT/'docs/index.html').read_text(encoding='utf-8'),'html.parser')
 hrefs=[a['href'] for a in soup.select('a[href]') if not a['href'].startswith('#')]
 for href in hrefs:
  assert (ROOT/'docs'/href).is_file(),href
  with urllib.request.urlopen(urllib.request.Request('http://127.0.0.1:8770/'+href,method='HEAD')) as r:assert r.status==200
 assert len(soup.select('article.card'))==11
 assert not soup.select('a[href*="exports/"]')
 assert not soup.select('a[href="Oct15_session3.html"]')
 results=[]
 async with async_playwright() as pw:
  browser=await pw.chromium.launch()
  for width in [1280,768,375,320]:
   page=await browser.new_page(viewport={'width':width,'height':900});errors=[];page.on('pageerror',lambda e:errors.append(str(e)))
   await page.goto('http://127.0.0.1:8770/',wait_until='networkidle')
   await page.screenshot(path=str(OUT/f'week_{width}.png'),full_page=True)
   for day,expected in [('1',3),('2',3),('3',3),('4',2),('all',11)]:
    button=page.locator(f'button[data-day="{day}"]');await button.focus();await page.keyboard.press('Enter')
    assert await button.get_attribute('aria-pressed')=='true'
    assert await page.locator('.day:not([hidden]) article.card').count()==expected
    assert await page.locator('button[aria-pressed=true]').count()==1
   await page.locator('button[data-day="4"]').click()
   await page.screenshot(path=str(OUT/f'day4_{width}.png'),full_page=True)
   await page.reload();assert await page.locator('.day:not([hidden]) article.card').count()==2
   await page.locator('button[data-day="all"]').click()
   await page.locator('#trainer summary').focus();await page.keyboard.press('Enter')
   assert await page.locator('#trainer').get_attribute('open') is not None
   await page.screenshot(path=str(OUT/f'trainer_{width}.png'),full_page=True)
   fit=await page.evaluate('({width:innerWidth,scroll:document.documentElement.scrollWidth})');assert fit['scroll']<=width,fit
   assert not errors,errors
   results.append({'viewport':width,'filters':True,'keyboard':True,'reload_day4':True,'overflow':False,'errors':errors});await page.close()
  await browser.close()
 for entry in json.loads((Path(__file__).parent/'qa/live_copy_manifest.json').read_text()):
  import hashlib
  assert hashlib.sha256((ROOT/entry['to']).read_bytes()).hexdigest()==entry['sha256']
 oversized=[str(p.relative_to(ROOT)) for p in (ROOT/'docs').rglob('*') if p.is_file() and p.stat().st_size>25*1024*1024];assert not oversized,oversized
 report={'landing_links':len(hrefs),'verified_copies':53,'layouts':results,'all_assets_below_25MiB':True}
 (OUT/'checks.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))
asyncio.run(main())
