"""Course-owned anonymous classroom voting. Standard-library server + optional QR.

python room_poll.py --host 0.0.0.0 --join-url http://CLASSROOM-IP:8766
Default binding is localhost for rehearsal. Votes live only in memory.
"""
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from threading import Lock
from urllib.parse import urlparse, parse_qs
import argparse
import io
import json
import secrets

ROOT = Path(__file__).resolve().parent

class Room:
    def __init__(self, join_url):
        self.token = secrets.token_urlsafe(24)
        self.join_url = join_url.rstrip('/')
        self.lock = Lock()
        self.question = 'Would you extend GreenWaste on this evidence?'
        self.options = ['Extend', 'Do not extend', 'Ask first']
        self.round_id = 0
        self.rounds = []

    def public(self):
        current = self.rounds[-1] if self.rounds else None
        # Open voting never exposes totals or reasons to participants.
        return {'question': self.question, 'options': self.options,
                'round': self.round_id, 'phase': current['phase'] if current else None,
                'open': bool(current and current['open']),
                'results': [self.summary(r) for r in self.rounds if not r['open']]}

    def summary(self, r):
        counts = [sum(v['choice'] == i for v in r['votes'].values()) for i in range(len(self.options))]
        return {'phase': r['phase'], 'counts': counts, 'total': sum(counts)}

    def action(self, data):
        action = data.get('action')
        if action == 'configure':
            question, options = data.get('question'), data.get('options')
            if self.rounds:
                raise ValueError('Reset this question before changing its wording.')
            if not isinstance(question,str) or not 1 <= len(question.strip()) <= 200:
                raise ValueError('Enter a question of up to 200 characters.')
            if not isinstance(options,list) or not 2 <= len(options) <= 4 or any(not isinstance(o,str) or not 1 <= len(o.strip()) <= 60 for o in options):
                raise ValueError('Enter two to four short choices.')
            self.question = question.strip()
            self.options = [o.strip() for o in options]
            self.round_id += 1
        elif action == 'open':
            phase = data.get('phase')
            if phase not in ('Before','After'):
                raise ValueError('Choose Before or After.')
            if self.rounds and self.rounds[-1]['open']:
                raise ValueError('Close the current vote first.')
            if any(r['phase'] == phase for r in self.rounds):
                raise ValueError('This phase has already been used. Reset to start another question.')
            if phase == 'After' and not any(r['phase']=='Before' for r in self.rounds):
                raise ValueError('Run Before first.')
            self.round_id += 1
            self.rounds.append({'phase': phase, 'open': True, 'votes': {}})
        elif action == 'close':
            if not self.rounds or not self.rounds[-1]['open']:
                raise ValueError('There is no open vote.')
            self.rounds[-1]['open'] = False
        elif action == 'reset':
            self.rounds = []
            self.round_id += 1  # Invalidate stale participant submissions.
        else:
            raise ValueError('Unknown action.')

    def vote(self, data):
        if not self.rounds or not self.rounds[-1]['open']:
            raise ValueError('Voting is closed.')
        if data.get('round') != self.round_id:
            raise ValueError('The question changed. Refresh before voting.')
        voter, choice, reason = data.get('voter'), data.get('choice'), data.get('reason','')
        if not isinstance(voter,str) or not 16 <= len(voter) <= 100:
            raise ValueError('Refresh your page to create an anonymous voting ID.')
        if type(choice) is not int or not 0 <= choice < len(self.options):
            raise ValueError('Choose one answer.')
        if not isinstance(reason,str) or len(reason) > 250:
            raise ValueError('Keep your reason to 250 characters.')
        # One vote per browser ID per phase; resubmitting changes that vote.
        self.rounds[-1]['votes'][voter] = {'choice':choice,'reason':reason.strip()}


def handler_for(room):
    class Handler(BaseHTTPRequestHandler):
        def log_message(self, *args):
            pass  # Do not log phone addresses, reasons or the facilitator token.

        def send(self, status, body, content_type='application/json; charset=utf-8'):
            if isinstance(body,dict): body = json.dumps(body).encode()
            if isinstance(body,str): body = body.encode('utf-8')
            self.send_response(status)
            self.send_header('Content-Type', content_type)
            self.send_header('Content-Length', str(len(body)))
            self.send_header('Cache-Control', 'no-store')
            self.send_header('X-Content-Type-Options', 'nosniff')
            self.end_headers()
            self.wfile.write(body)

        def do_GET(self):
            path = urlparse(self.path).path
            if path == '/api/state':
                with room.lock: self.send(200,room.public())
            elif path == '/api/admin':
                if self.headers.get('X-Room-Token') != room.token:
                    return self.send(403,{'error':'Facilitator access required.'})
                with room.lock:
                    state = room.public()
                    current = room.rounds[-1] if room.rounds else None
                    state.update(join_url=room.join_url, received=len(current['votes']) if current else 0,
                                 reasons=[v['reason'] for v in current['votes'].values() if v['reason']] if current and not current['open'] else [])
                    self.send(200,state)
            elif path == '/qr.svg':
                try:
                    import qrcode
                    from qrcode.image.svg import SvgPathImage
                    data=io.BytesIO()
                    qrcode.make(room.join_url,image_factory=SvgPathImage).save(data)
                    self.send(200,data.getvalue(),'image/svg+xml')
                except ImportError:
                    self.send(404,{'error':'QR package is unavailable. Use the displayed join address.'})
            elif path in ('/','/facilitator'):
                self.send(200,(ROOT/'room_poll.html').read_bytes(),'text/html; charset=utf-8')
            elif path.lstrip('/') in ('Oct12_session1_live.html','Oct12_session2.html','Oct12_session3_live.html', 'Oct13_session1.html', 'Oct13_session2_live.html', 'Oct13_session3.html',
                                       'evaluation_data_GreenWaste_simple.csv'):
                file=ROOT/path.lstrip('/')
                if not file.exists(): return self.send(404,{'error':'Render this deck first.'})
                self.send(200,file.read_bytes(),'text/html; charset=utf-8' if path.endswith('.html') else 'text/csv')
            else:
                self.send(404,{'error':'Page not found.'})

        def do_POST(self):
            path = urlparse(self.path).path
            # Browser requests must originate on this server; no permissive CORS.
            origin=self.headers.get('Origin')
            if origin and urlparse(origin).netloc != self.headers.get('Host'):
                return self.send(403,{'error':'Use the room’s join page.'})
            try:
                size=int(self.headers.get('Content-Length','0'))
                if not 0 < size <= 4096: return self.send(413,{'error':'Request is too large.'})
                data=json.loads(self.rfile.read(size))
                if not isinstance(data,dict): raise ValueError('Invalid request.')
                with room.lock:
                    if path == '/api/vote': room.vote(data)
                    elif path == '/api/control':
                        if self.headers.get('X-Room-Token') != room.token:
                            return self.send(403,{'error':'Facilitator access required.'})
                        room.action(data)
                    else: return self.send(404,{'error':'Unknown action.'})
                    self.send(200,{'ok':True})
            except (ValueError,TypeError,json.JSONDecodeError) as error:
                self.send(400,{'error':str(error)})
    return Handler


if __name__ == '__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--host',default='127.0.0.1')
    parser.add_argument('--port',type=int,default=8766)
    parser.add_argument('--join-url',help='Address phones can reach, including http:// and port.')
    args=parser.parse_args()
    room=Room(args.join_url or f'http://127.0.0.1:{args.port}')
    print('Join page:',room.join_url,flush=True)
    print('Private facilitator page:',f'http://127.0.0.1:{args.port}/facilitator#'+room.token,flush=True)
    print('Responses are anonymous browser votes, not a verified attendance count. Closing the server clears them.',flush=True)
    try: ThreadingHTTPServer((args.host,args.port),handler_for(room)).serve_forever()
    except KeyboardInterrupt: pass
