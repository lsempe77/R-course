"""Exercise the real HTTP lifecycle and phone UI with two anonymous browsers."""
import asyncio
import json
import sys
from pathlib import Path
from threading import Thread
from http.server import ThreadingHTTPServer
from playwright.async_api import async_playwright

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from room_poll import Room,handler_for

async def main():
    room=Room('http://127.0.0.1')
    server=ThreadingHTTPServer(('127.0.0.1',0),handler_for(room))
    url=f'http://127.0.0.1:{server.server_port}'
    room.join_url=url
    thread=Thread(target=server.serve_forever,daemon=True);thread.start()
    out=Path(__file__).parent/'qa'/'room_poll';out.mkdir(parents=True,exist_ok=True)
    async with async_playwright() as pw:
        b=await pw.chromium.launch()
        admin=await b.new_page(viewport={'width':1280,'height':800})
        a=await b.new_page(viewport={'width':375,'height':812})
        c=await b.new_page(viewport={'width':320,'height':700})
        errors=[]
        for p in (admin,a,c):p.on('pageerror',lambda e:errors.append(str(e)))
        await admin.goto(url+'/facilitator#'+room.token)
        await a.goto(url);await c.goto(url)
        await admin.get_by_text('Open Before',exact=True).click()
        await a.wait_for_function("document.querySelector('#phase').textContent.includes('voting open')")
        await c.wait_for_function("document.querySelector('#phase').textContent.includes('voting open')")
        await a.locator('#choices button').nth(0).click()
        await a.locator('#reason').fill('<b>the headline</b>')
        await a.get_by_text('Send my choice',exact=True).click()
        await a.get_by_text('Choice saved.',exact=False).wait_for()
        await c.locator('#choices button').nth(2).click()
        await c.get_by_text('Send my choice',exact=True).click()
        await c.get_by_text('Choice saved.',exact=False).wait_for()
        # A replacement vote must not add a voter.
        await a.locator('#choices button').nth(1).click()
        await a.get_by_text('Send my choice',exact=True).click()
        state=await (await a.request.get(url+'/api/state')).json()
        assert state['results']==[],state
        unauthorized=await a.request.post(url+'/api/control',data={'action':'close'})
        assert unauthorized.status==403
        foreign=await a.request.post(url+'/api/vote',headers={'Origin':'http://elsewhere.invalid'},data={})
        assert foreign.status==403
        await admin.get_by_text('Close and show results',exact=True).click()
        await admin.wait_for_function("document.querySelector('#results').textContent.includes('2 votes')")
        state=await (await a.request.get(url+'/api/state')).json()
        assert state['results'][0]['counts']==[0,1,1],state
        assert 'reasons' not in state
        closed=await a.request.post(url+'/api/vote',data={'voter':'anonymous-closed-voter','round':state['round'],'choice':0})
        assert closed.status==400
        await admin.locator('#reason-list').get_by_text('<b>the headline</b>',exact=True).wait_for()
        assert await admin.locator('#reason-list b').count()==0
        await admin.get_by_text('Open After',exact=True).click()
        await a.wait_for_function("document.querySelector('#phase').textContent.includes('After')")
        await a.locator('#choices button').nth(2).click()
        await a.get_by_text('Send my choice',exact=True).click()
        await admin.get_by_text('Close and show results',exact=True).click()
        await admin.wait_for_function("document.querySelector('#results').textContent.includes('After')")
        state=await (await a.request.get(url+'/api/state')).json()
        assert [r['total'] for r in state['results']]==[2,1],state
        assert (await a.request.get(url+'/qr.svg')).status==200
        overflow=[]
        for p,name in [(admin,'facilitator'),(a,'phone375'),(c,'phone320')]:
            assert await p.evaluate('document.documentElement.scrollWidth <= innerWidth'),name
            await p.screenshot(path=str(out/(name+'.png')),full_page=True)
        await admin.request.post(url+'/api/control',headers={'X-Room-Token':room.token},data={'action':'reset'})
        old_round=state['round']
        await admin.request.post(url+'/api/control',headers={'X-Room-Token':room.token},data={'action':'configure','question':'Which comparison is fair?','options':['Fair','Ask about starting costs']})
        await admin.request.post(url+'/api/control',headers={'X-Room-Token':room.token},data={'action':'open','phase':'Before'})
        stale=await a.request.post(url+'/api/vote',data={'voter':'anonymous-stale-voter','round':old_round,'choice':0})
        assert stale.status==400
        await a.wait_for_function("document.querySelectorAll('#choices button').length===2")
        assert errors==[],errors
        report={'two_browsers':True,'duplicate_replaces':True,'hidden_until_closed':True,
                'before_after_totals':[2,1],'unauthorized_control':403,'cross_origin':403,
                'closed_and_stale_vote':400,'reasons_are_text':True,'qr':True,
                'viewports':[320,375,1280],'configuration_refresh':True,'browser_errors':errors}
        (out/'checks.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
        print(json.dumps(report),flush=True)
        await b.close()
    server.shutdown();server.server_close()

asyncio.run(main())
