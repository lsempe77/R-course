from pathlib import Path
import shutil,zipfile,hashlib,json
root=Path('.').resolve();pre=root.parent/'.preview_day2_publish/docs/preview';qa=root/'review_2026_10_06/qa'
files=['Oct15_session1.html','Oct15_session2_live.html','Oct15_session2.html','Oct15_session1_report.docx','Oct15_session1_rating_sheet.docx','Oct15_session1_materials.docx','Oct15_session1_board_A1.pdf','Oct15_session2_materials.docx','Oct15_session2_findings.docx','Oct15_session2_brief_template.docx','Module2_exercise_plan_v3.docx']
for f in files:shutil.copy2(root/f,pre/f)
for f in ['Oct15_session1_handouts.docx','Oct15_session2_handouts.docx']:shutil.copy2(root.parent/'docs/handouts'/f,pre/f)
for f in ['day4_review.html','week_ready.html','day4_plan.html','day3_review.html','week_review.html']:shutil.copy2(root/'review_2026_10_06'/f,pre/f)
for f in ['room_poll.py','room_poll.html','ROOM_POLL_README.md']:
 if f.endswith('.md'):shutil.copy2(root/f,pre/f)
with zipfile.ZipFile(pre/'GreenWaste_room_poll.zip','w',zipfile.ZIP_DEFLATED) as z:
 for f in ['room_poll.py','room_poll.html','ROOM_POLL_README.md']:z.write(root/f,f)
entries=[]
for day,n in [(12,3),(13,3),(14,3),(15,2)]:
 for session in range(1,n+1):
  stem=f'Oct{day}_session{session}'
  deck=stem+('_live' if (day,session) in [(12,1),(12,3),(13,2),(14,1),(14,3),(15,2)] else '')+'.html'
  entries.extend([(pre/deck,'Decks/'+deck),(pre/(stem+'_handouts.docx'),'ParticipantSheets/'+stem+'_handouts.docx'),(pre/(stem+'_materials.docx'),'TrainerPacks/'+stem+'_materials.docx')])
for f in ['GreenWaste_case_card.docx','GreenWaste_case_brief.docx','Oct14_session3_qa_checklist.docx','Oct15_session1_report.docx','Oct15_session1_rating_sheet.docx','Oct15_session2_findings.docx','Oct15_session2_brief_template.docx']:entries.append((pre/f,'References/'+f))
for f in ['Oct12_session1_board_A1.pdf','Oct13_session2_board_A1.pdf','Oct14_session1_board_A1.pdf','Oct15_session1_board_A1.pdf']:entries.append((pre/f,'Posters/'+f))
for f in ['room_poll.py','room_poll.html','ROOM_POLL_README.md']:entries.append((root/f,'RoomTool/'+f))
entries.extend([(pre/'evaluation_data_GreenWaste_simple.csv','Decks/evaluation_data_GreenWaste_simple.csv'),(root/'Module2_exercise_plan_v3.docx','Module2_exercise_plan_v3.docx')])
readme='''GreenWaste: eleven course-owned sessions, October 2026
Days 1-3: 60/60/75 minutes. Day 4: 60/60 minutes.
The final Day 4 evaluation simulation is prepared by another provider and excluded.

ParticipantSheets: print each two-page sheet double-sided, one per person.
TrainerPacks: separate keys, cards and distribution instructions; keep keys private.
References: Session 1 Day 4 report has deliberate flaws; use the corrected Session 2 findings when writing.
Optional rating sheet duplicates the Session 1 worksheet; optional brief template duplicates Session 2 Sheet 1.
Posters: four files, five A1 landscape sheets; Day 4 wall is two sheets.
Classroom brief specifies group allocations, copies and cutting.

Decks: open the HTML decks in a browser. Browser R trainer demos require internet and access to the corrected CSV; rehearse on the venue network. Embedded teaching assets are bundled, the external R runtime is not. Printed results are the fallback.
RoomTool: follow ROOM_POLL_README.md; Python standard library server, no accounts or paid service. Rehearse facilitator-to-phone network access; labelled cards are the fallback.
All figures are fictional training data. The individual reading check is a teaching check, not validated certification.
'''
with zipfile.ZipFile(pre/'GreenWaste_week_materials.zip','w',zipfile.ZIP_DEFLATED) as z:
 for source,dest in entries:
  assert source.is_file(),source
  assert 'session3' not in dest or 'Oct15' not in dest
  z.write(source,dest)
 z.writestr('README.txt',readme)
 assert len([i for i in z.namelist() if i.startswith('ParticipantSheets/')])==11
 assert len([i for i in z.namelist() if i.startswith('TrainerPacks/')])==11
 assert len([i for i in z.namelist() if i.endswith('.html') and i.startswith('Decks/')])==11
with zipfile.ZipFile(pre/'GreenWaste_week_materials.zip') as z:
 for src,dst in entries:assert hashlib.sha256(z.read(dst)).hexdigest()==hashlib.sha256(src.read_bytes()).hexdigest()
copy_sources=[(root/f,pre/f) for f in files]+[(root.parent/'docs/handouts'/f,pre/f) for f in ['Oct15_session1_handouts.docx','Oct15_session2_handouts.docx']]+[(root/'review_2026_10_06'/f,pre/f) for f in ['day4_review.html','week_ready.html','day4_plan.html','day3_review.html','week_review.html']]
for a,b in copy_sources:assert a.read_bytes()==b.read_bytes()
from bs4 import BeautifulSoup
links={}
for n in ['day4_review','week_ready','day3_review','day4_plan','week_review']:
 s=BeautifulSoup((pre/(n+'.html')).read_text(encoding='utf-8'),'html.parser');hrefs=[a['href'].split('#')[0] for a in s.select('a[href]') if not a['href'].startswith(('http','mailto:','#','data:'))]
 for href in hrefs:assert (pre/href).is_file(),(n,href)
 links[n]=len(hrefs)
checks={'hash_verified_copies':len(copy_sources),'review_links':links,'bundle_files':len(entries)+1,'bundle_bytes':(pre/'GreenWaste_week_materials.zip').stat().st_size}
(qa/'day4_publish_checks.json').write_text(json.dumps(checks,indent=2));print(json.dumps(checks))
temp=qa/'week_generator'
assert len(list((temp/'Module').glob('Oct*_materials.docx')))==11
assert len(list((temp/'docs/handouts').glob('Oct*_handouts.docx')))==11
assert not list(temp.rglob('Oct15_session3*'))
print('Isolated full build: eleven packs and eleven participant sheets; excluded slot absent.')
