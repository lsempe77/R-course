"""Promote the checked week and build its working course hub. Run from any cwd."""
from pathlib import Path
from html import escape
import sys
sys.path.insert(0,str(Path(__file__).resolve().parent))
from reader_titles import CATALOG
import hashlib,json,shutil
ROOT=Path(__file__).resolve().parents[2]
MODULE=ROOT/'Module_2_Oct_2026_v2'
DOCS=ROOT/'docs'
PREVIEW=DOCS/'preview'
BACKUP=MODULE/'backups/live_2026_10_06'
ROWS=[(s['day'],s['session'],s['minutes'],s['deck'],s['title'],s['description']) for s in CATALOG['sessions']]
DAYS={d['day']:(d['date'],d['title']) for d in CATALOG['days']}
COPIES=[]
def protect(dest):
 if dest.exists():
  target=BACKUP/dest.relative_to(ROOT)
  if not target.exists():target.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(dest,target)
def copy(source,dest):
 assert source.is_file(),source
 protect(dest);dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(source,dest)
 assert source.read_bytes()==dest.read_bytes()
 COPIES.append({'from':str(source.relative_to(ROOT)),'to':str(dest.relative_to(ROOT)),'sha256':hashlib.sha256(dest.read_bytes()).hexdigest()})
for day,session,minutes,deck,title,description in ROWS:
 stem='Oct'+str(day+11)+'_session'+str(session)
 copy(PREVIEW/(deck+'.html'),DOCS/(deck+'.html'))
 copy(PREVIEW/(stem+'_handouts.docx'),DOCS/'handouts'/(stem+'_handouts.docx'))
 copy(PREVIEW/(stem+'_materials.docx'),DOCS/'trainer'/(stem+'_materials.docx'))
for f in ['GreenWaste_case_card.docx','GreenWaste_case_brief.docx','Oct14_session3_qa_checklist.docx','Oct15_session1_report.docx','Oct15_session1_rating_sheet.docx','Oct15_session2_findings.docx','Oct15_session2_brief_template.docx']:
 copy(PREVIEW/f,DOCS/'handouts'/f)
for f in ['Oct12_session1_board_A1.pdf','Oct13_session2_board_A1.pdf','Oct14_session1_board_A1.pdf','Oct15_session1_board_A1.pdf']:copy(PREVIEW/f,DOCS/'posters'/f)
for f in ['GreenWaste_week_materials.zip','GreenWaste_decks_days1_2.zip','GreenWaste_decks_days3_4.zip','GreenWaste_room_poll.zip']:copy(PREVIEW/f,DOCS/'downloads'/f)
copy(PREVIEW/'Module2_exercise_plan_v3.docx',DOCS/'trainer/Module2_exercise_plan_v3.docx')
copy(PREVIEW/'ROOM_POLL_README.md',DOCS/'trainer/ROOM_POLL_README.md')
for f in ['evaluation_data_GreenWaste_simple.csv','gw_lab.R']:copy(PREVIEW/f,DOCS/f)
copy(MODULE/'assets/dge_logo_horizontal.svg',DOCS/'assets/dge_logo_horizontal.svg')
# Keep all established session URLs working. The replaced final slot has a notice.
for _,_,_,deck,_,_ in ROWS:
 if deck.endswith('_live'):
  dest=DOCS/(deck[:-5]+'.html');protect(dest)
  dest.write_text('<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta http-equiv="refresh" content="0;url='+deck+'.html"><title>Open session</title></head><body><p><a href="'+deck+'.html">Open the current session</a></p></body></html>',encoding='utf-8')
old=DOCS/'Oct15_session3.html';protect(old)
old.write_text('''<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Day 4 evaluation simulation</title><style>body{font:18px/1.6 system-ui;color:#063360;max-width:640px;margin:10vh auto;padding:24px}a{color:#215a9e}</style></head><body><h1>Day 4 evaluation simulation</h1><p>This slot is prepared by the other provider. The former design workshop has been removed from this week's programme.</p><p><a href="index.html#day4">Return to the course hub</a></p></body></html>''',encoding='utf-8')
css='''
:root{--ink:#152d42;--blue:#215a9e;--navy:#063360;--muted:#526576;--rule:#d9e3ed;--pale:#f3f7fb;--white:#fff}
*{box-sizing:border-box}html{scroll-behavior:smooth}body{margin:0;background:#f7f9fc;color:var(--ink);font:16px/1.55 "Segoe UI",system-ui,Arial,sans-serif}a{color:var(--blue);text-underline-offset:3px}a:hover{color:var(--navy)}a:focus-visible,button:focus-visible,summary:focus-visible{outline:3px solid #d58d22;outline-offset:4px}button{font:inherit}header{background:white;border-bottom:1px solid var(--rule)}.shell{max-width:1140px;margin:auto;padding:0 28px}.brand{display:flex;align-items:center;justify-content:space-between;gap:24px;padding-top:20px;padding-bottom:20px}.brand img{width:245px;height:60px;object-fit:contain;object-position:left}.brand p{margin:0;color:var(--muted);font-size:14px}.status{display:inline-block;background:#edf3fb;border:1px solid #cbdced;border-radius:30px;padding:5px 12px;color:var(--navy);font-size:13px;font-weight:600}.hero{padding-top:38px;padding-bottom:26px;max-width:820px}.eyebrow{margin:0 0 10px;color:var(--blue);font-size:13px;font-weight:700;letter-spacing:.08em;text-transform:uppercase}h1{font-size:clamp(30px,4.4vw,48px);line-height:1.14;letter-spacing:-.03em;margin:0 0 16px;color:var(--navy);max-width:780px}.lead{font-size:19px;line-height:1.55;margin:0;max-width:710px;color:var(--muted)}.quick{display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin:8px 0 30px}.download{display:block;text-decoration:none;background:white;border:1px solid var(--rule);border-radius:12px;padding:18px 20px;transition:border-color .15s}.download:hover{border-color:var(--blue)}.download strong{display:block;color:var(--navy);font-size:16px}.download span{display:block;color:var(--muted);font-size:14px;margin-top:4px}.route{display:flex;flex-wrap:wrap;gap:10px;align-items:center;margin-bottom:10px}.route button{border:1px solid var(--rule);border-radius:30px;background:white;color:var(--ink);padding:9px 18px;cursor:pointer;font-weight:600}.route button[aria-pressed=true]{background:var(--navy);color:white;border-color:var(--navy)}.route button:hover{border-color:var(--blue)}.count{color:var(--muted);font-size:14px;margin:10px 0 24px}.day{margin:0 0 34px;scroll-margin-top:20px}.dayhead{display:flex;align-items:baseline;justify-content:space-between;gap:20px;margin-bottom:16px}.dayhead h2{font-size:23px;line-height:1.3;color:var(--navy);margin:0 0 3px}.dayhead p{margin:0;font-size:15px;color:var(--muted)}.cards{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:16px}.card{background:white;border:1px solid var(--rule);border-radius:12px;padding:21px;display:flex;flex-direction:column;min-width:0}.meta{display:flex;justify-content:space-between;gap:10px;font-size:12px;color:var(--muted);font-weight:700;letter-spacing:.04em;text-transform:uppercase}.card h3{font-size:21px;line-height:1.3;margin:13px 0 9px;color:var(--navy)}.card p{color:var(--muted);margin:0 0 20px;font-size:15px}.actions{display:flex;align-items:center;flex-wrap:wrap;gap:12px;margin-top:auto}.open{display:inline-block;text-decoration:none;border-radius:6px;padding:9px 13px;background:var(--blue);color:white;font-weight:600;font-size:14px}.open:hover{background:var(--navy);color:white}.sheet{font-weight:600;font-size:14px}.reference{font-size:14px;border-top:1px solid var(--rule);padding-top:13px;margin-top:15px}.simulation{padding:14px 18px;border-left:3px solid #a3b7ce;background:#edf2f7;border-radius:0 8px 8px 0;margin-top:16px;color:var(--muted);font-size:15px}.simulation strong{color:var(--navy)}.support{background:white;border:1px solid var(--rule);border-radius:12px;margin:32px 0 20px}.support>summary{cursor:pointer;padding:20px 24px;font-size:20px;font-weight:650;color:var(--navy)}.support[open]>summary{border-bottom:1px solid var(--rule)}.supportbody{padding:4px 24px 24px}.supportbody h3{font-size:18px;color:var(--navy);margin:20px 0 8px}.supportbody p{margin:8px 0;color:var(--muted)}.supportgrid{display:grid;grid-template-columns:repeat(2,1fr);gap:20px 36px}.supportgrid ul{padding-left:20px;margin:8px 0}.supportgrid li{margin:8px 0}.guide{padding:24px 0 30px;max-width:710px}.guide h2{font-size:17px;color:var(--navy);margin:0 0 8px}.guide p{margin:0;font-size:14px;color:var(--muted)}kbd{font:12px system-ui;border:1px solid #b9c9d9;background:white;border-radius:4px;padding:1px 5px}footer{border-top:1px solid var(--rule);padding:22px 0 34px;color:var(--muted);font-size:13px}footer p{margin:0}.skip{position:absolute;left:15px;top:-100px;background:white;padding:12px;z-index:10}.skip:focus{top:12px}[hidden]{display:none!important}
@media(max-width:900px){.cards{grid-template-columns:repeat(2,minmax(0,1fr))}.card:last-child:nth-child(3){grid-column:1/-1}.brand img{width:210px}.hero{padding-top:30px}}
@media(max-width:600px){.shell{padding-left:18px;padding-right:18px}.brand{gap:12px;align-items:center}.brand img{width:155px;height:45px}.brand p{display:none}.status{font-size:11px;padding:5px 9px}.hero{padding-top:28px}.lead{font-size:17px}.quick{grid-template-columns:1fr;gap:9px;margin-bottom:25px}.download{padding:13px 16px}.download span{margin-top:2px}.route{gap:7px}.route button{padding:8px 13px;font-size:14px}.cards,.supportgrid,.guide{grid-template-columns:1fr}.card:last-child:nth-child(3){grid-column:auto}.dayhead{align-items:flex-start;gap:12px}.dayhead h2{font-size:21px}.dayhead p{font-size:13px}.card{padding:19px}.support>summary{padding:18px;font-size:18px}.supportbody{padding:0 18px 18px}.guide{gap:22px}h1{font-size:34px}}
@media(prefers-reduced-motion:reduce){html{scroll-behavior:auto}*{transition:none!important}}
'''
parts=['''<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><meta name="robots" content="noindex,nofollow"><title>Module 2 | Course working hub</title><style>''',css,'''</style></head><body>
<a class="skip" href="#sessions">Skip to sessions</a>
<header><div class="shell brand"><img src="assets/dge_logo_horizontal.svg" alt="Department of Government Enablement"><p>Module 2 &middot; Abu Dhabi &middot; 12&ndash;15 October 2026</p><span class="status">Working materials</span></div></header>
<main class="shell"><div class="hero"><p class="eyebrow">Reading evaluation reports</p><h1>What does the evidence support?</h1><p class="lead">Practise reading results, checking claims and asking useful questions before making a recommendation.</p></div>
<div class="quick" aria-label="Whole-week downloads">
<a class="download" href="downloads/GreenWaste_week_materials.zip" download><strong>Print materials &darr;</strong><span>Worksheets, trainer keys, references and posters &middot; 0.8 MB</span></a>
<a class="download" href="downloads/GreenWaste_decks_days1_2.zip" download><strong>Decks: Days 1&ndash;2 &darr;</strong><span>Six browser presentations &middot; 17.2 MB</span></a>
<a class="download" href="downloads/GreenWaste_decks_days3_4.zip" download><strong>Decks: Days 3&ndash;4 &darr;</strong><span>Five browser presentations &middot; 13.7 MB</span></a></div>
<section id="sessions" aria-label="Course sessions"><div class="route" role="group" aria-label="Show sessions by day"><button type="button" data-day="all" aria-pressed="true">Whole week</button>''']
for day in DAYS:parts.append(f'<button type="button" data-day="{day}" aria-pressed="false">Day {day}</button>')
parts.append('</div><p class="count" id="session-count" role="status" aria-live="polite">11 sessions</p>')
for day,(date,aim) in DAYS.items():
 parts.append(f'<section class="day" id="day{day}" data-day-panel="{day}" aria-labelledby="day{day}-title"><div class="dayhead"><div><h2 id="day{day}-title">Day {day} &middot; {escape(aim)}</h2><p>{date}</p></div></div><div class="cards">')
 for d,session,minutes,deck,title,description in ROWS:
  if d!=day:continue
  stem='Oct'+str(day+11)+'_session'+str(session)
  parts.append(f'<article class="card"><div class="meta"><span>Session {session}</span></div><h3>{escape(title)}</h3><p>{escape(description)}</p><div class="actions"><a class="open" href="{deck}.html" aria-label="Open slides: {escape(title)}">Open slides</a><a class="sheet" href="handouts/{stem}_handouts.docx" download aria-label="Worksheet: {escape(title)}">Worksheet &darr;</a></div>')
  if (d,session)==(4,1):parts.append('<div class="reference"><a href="handouts/Oct15_session1_report.docx" download>Report for the reading exercise &darr;</a></div>')
  if (d,session)==(4,2):parts.append('<div class="reference"><a href="handouts/Oct15_session2_findings.docx" download>Corrected findings for the brief &darr;</a></div>')
  parts.append('</article>')
 parts.append('</div>')
 if day==4:parts.append('<div class="simulation"><strong>Final slot: evaluation simulation.</strong> Prepared by the other provider.</div>')
 parts.append('</section>')
parts.append('''</section><details class="support" id="trainer"><summary>Trainer materials and classroom setup</summary><div class="supportbody"><h3>Before teaching</h3><p>Rehearse room voting on the classroom network; labelled cards are the fallback. Unzip both deck downloads to the same folder. All figures are fictional training data. The reading check provides feedback and a targeted retry.</p><p>Press <kbd>S</kbd> for presenter notes. Trainer calculations need internet; open those decks early. Printed results are the fallback.</p><p>Print each two-page participant worksheet double-sided. Trainer packs contain keys and separate cards; keep keys for facilitators.</p><div class="supportgrid"><div><h3>Session keys and activity cards</h3><ul>''')
for day,session,_,_,title,_ in ROWS:
 stem='Oct'+str(day+11)+'_session'+str(session)
 parts.append(f'<li><a href="trainer/{stem}_materials.docx" download>Day {day}, Session {session}: {escape(title)}</a></li>')
parts.append('''</ul></div><div><h3>Print and room instructions</h3><ul><li><a href="trainer/Module2_exercise_plan_v3.docx" download>Classroom brief: copies, cutting and group allocations</a></li><li><a href="downloads/GreenWaste_room_poll.zip" download>Course room-voting tool</a> &middot; <a href="trainer/ROOM_POLL_README.md">Setup instructions</a></li></ul><h3>A1 posters</h3><ul>''')
for stem,title in [('Oct12_session1','Claim triage (optional)'),('Oct13_session2','Score-rule number line'),('Oct14_session1','Value for money wall'),('Oct15_session1','Report credibility wall (two sheets)')]:parts.append(f'<li><a href="posters/{stem}_board_A1.pdf" download>{title}</a></li>')
parts.append('''</ul><h3>Desk references</h3><ul><li><a href="handouts/GreenWaste_case_card.docx" download>GreenWaste picture card</a> &middot; <a href="handouts/GreenWaste_case_brief.docx" download>Case brief</a></li><li><a href="handouts/Oct14_session3_qa_checklist.docx" download>Five questions for the evaluator</a></li></ul><h3>Review the rebuild</h3><p><a href="preview/week_ready.html">Whole-week review and checks</a></p></div></div></div></details>
<div class="guide"><section><h2>Using the slides</h2><p>Use the arrow keys to move through the slides and <kbd>Esc</kbd> to see all slides. Select the options and open evidence when prompted.</p></section></div>
</main><footer class="shell"><p>International Initiative for Impact Evaluation (3ie) &middot; Module 2 working materials &middot; Updated 6 October 2026</p></footer>
<script>
(function(){
 const buttons=[...document.querySelectorAll('[data-day]')],panels=[...document.querySelectorAll('[data-day-panel]')],count=document.getElementById('session-count');
 function select(day){
  if(!['all','1','2','3','4'].includes(day))day='all';
  buttons.forEach(b=>b.setAttribute('aria-pressed',String(b.dataset.day===day)));
  panels.forEach(p=>p.hidden=day!=='all'&&p.dataset.dayPanel!==day);
  count.textContent=day==='all'?'11 sessions':`Day ${day} \u00b7 ${day==='4'?'2 sessions':'3 sessions'}`;
 }
 buttons.forEach(b=>b.addEventListener('click',()=>{select(b.dataset.day);history.replaceState(null,'',b.dataset.day==='all'?location.pathname:'#day'+b.dataset.day)}));
 select(/^#day[1-4]$/.test(location.hash)?location.hash.slice(-1):'all');
 addEventListener('hashchange',()=>select(/^#day[1-4]$/.test(location.hash)?location.hash.slice(-1):'all'));
})();
</script></body></html>''')
protect(DOCS/'index.html');(DOCS/'index.html').write_text(''.join(parts),encoding='utf-8')
qa=MODULE/'review_2026_10_06/qa';qa.mkdir(parents=True,exist_ok=True)
(qa/'live_copy_manifest.json').write_text(json.dumps(COPIES,indent=2),encoding='utf-8')
print(f'Live hub built; {len(COPIES)} copies hash-verified. Backups: {BACKUP.relative_to(ROOT)}')
