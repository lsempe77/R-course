import asyncio,json
from pathlib import Path
from playwright.async_api import async_playwright

async def main():
    out=Path(__file__).parent/'qa'/'reading_controls';out.mkdir(parents=True,exist_ok=True)
    records=[]
    async with async_playwright() as pw:
        b=await pw.chromium.launch()
        for name,choice_slide,claim_slide in [('Oct12_session1_live',3,10),('Oct12_session2',None,10),('Oct12_session3_live',2,12)]:
            p=await b.new_page(viewport={'width':1280,'height':720})
            await p.goto('http://127.0.0.1:8767/'+name+'.html')
            await p.wait_for_function('window.Reveal && Reveal.isReady()')
            if choice_slide is not None:
                await p.evaluate('i=>Reveal.slide(i)',choice_slide)
                button=p.locator('section.present button[data-choice]').first
                await button.focus();await p.keyboard.press('Space')
                assert await p.evaluate('Reveal.getIndices().h')==choice_slide
                assert await button.get_attribute('aria-pressed')=='true'
            await p.evaluate('i=>Reveal.slide(i)',claim_slide)
            await p.locator('section.present button[data-check]').click()
            assert 'Recheck' in await p.locator('section.present [data-feedback]').inner_text()
            for button in await p.locator('section.present button[data-claim="unsupported"]').all():await button.click()
            await p.locator('section.present button[data-check]').click()
            assert 'Recheck' not in await p.locator('section.present [data-feedback]').inner_text()
            info=await p.evaluate('''()=>{const s=Reveal.getCurrentSlide(),r=s.getBoundingClientRect(),scale=r.width/1280;let bottom=r.top;for(const e of s.querySelectorAll('*')){const x=e.getBoundingClientRect();if(x.height&&getComputedStyle(e).visibility!=='hidden')bottom=Math.max(bottom,x.bottom)}return {slide:s.id,over:Math.round((bottom-r.top)/scale-720),feedback:s.querySelector('[data-feedback]').innerText}}''')
            assert info['over']<=2,info
            await p.screenshot(path=str(out/(name+'.png')))
            # All table headers must contrast with their dark background.
            colours=await p.locator('.reading-table thead th').evaluate_all("els=>els.map(e=>getComputedStyle(e).color)")
            assert all(c=='rgb(255, 255, 255)' for c in colours),colours
            info['table_header_colours']=colours;records.append(info)
            if name=='Oct12_session3_live':
                await p.evaluate('Reveal.slide(9)')
                await p.locator('button[data-open="interval-trial"]').click()
                assert await p.locator('#interval-trial').get_attribute('hidden') is None
                assert await p.locator('#interval-trial').is_visible()
                await p.screenshot(path=str(out/'trial_interval_open.png'))
            await p.close()
        await b.close()
    (out/'checks.json').write_text(json.dumps(records,indent=2),encoding='utf-8')
    print(json.dumps(records),flush=True)

asyncio.run(main())
