"""Update Day 2 in the current brief, preserving approved Day 1 and later history."""
from pathlib import Path
from copy import deepcopy
from zipfile import ZipFile,ZIP_DEFLATED
from lxml import etree as E
root=Path(__file__).resolve().parents[1];path=root/'Module2_exercise_plan_v3.docx'
with ZipFile(path) as z:files={n:z.read(n) for n in z.namelist()}
doc=E.fromstring(files['word/document.xml']);w='{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'
body=doc.find(w+'body');tables=body.findall(w+'tbl')
def text(el):return ''.join(el.itertext()) if False else ''.join(el.xpath('.//w:t/text()',namespaces={'w':w[1:-1]}))
def set_text(el,value):
    props=deepcopy(el.find(w+'pPr'))
    for child in list(el):el.remove(child)
    if props is not None:el.append(props)
    r=E.SubElement(el,w+'r');t=E.SubElement(r,w+'t');t.text=value
entries=[
 [('Four-number task','7-15 min','Alone then groups','Participant sheet 1; calculators','Compare changes, signs and units','Two-sided participant sheet, one per person','Built'),
  ('Predict and run','15-20 min','Trainer demo','Deck and printed row','One calculation only; paper fallback','Open webR early','Built'),
  ('Trend pictures','26-34 min','Pairs','Native reveal in deck','Hypothetical pictures, not extra case data','No AI wall board','Built'),
  ('Read and repair','39-56 min','Individual then pairs','Participant sheet 2','Mark assumption and missing evidence; repair authored AI draft','Included in two-sided sheet','Built'),
  ('Question from memory','56-60 min','Individual','Worksheet','Question and purpose, no AI','No extra print','Built')],
 [('Predict the jump','4-8 min','Individual','Native choices or room poll','Collect reason before result','Optional course room server; labelled-card fallback','Built'),
  ('Eight jump cards','8-18 min','Groups','Different A-H cards; calculators','Six businesses per side, subtract means','Trainer pages 3-10: one different page per group','Built'),
  ('Number line wall','18-24 min','Groups','A1 board; sticky notes; markers','Preserve Fiona wall; compare raw gaps with model result','One A1 landscape; eight sticky notes','Built'),
  ('Run and inspect evidence','24-41 min','Trainer and pairs','Deck; result sheet','One model demo, two windows, age reveal','Participant pages 1-2, double-sided per person','Built'),
  ('Credibility and AI check','41-56 min','Individual then pairs','Sheet 2','Rule, nearby comparison, other jump, reach; source-based repair','No extra print','Built'),
  ('Question from memory','56-60 min','Individual','Worksheet','Question and purpose, no AI','No extra print','Built')],
 [('Profile matching','0-21 min','Groups','Seven profile fronts','Choose using age and size before opening costs','Trainer pages 3-9: one set per group, two pages per sheet; optional full-size walking set','Built'),
  ('Open outcomes','21-26 min','Groups','Separate cost slips','Hold slips until pairs recorded; do not rematch on costs','Trainer page 10: cut seven slips per group','Built'),
  ('Read result and one demo','26-37 min','Trainer and pairs','Deck; worksheet','Disclose control reuse and imperfect similarity','Participant pages 1-2, double-sided per person','Built'),
  ('Break','37-42 min','Break','None','Protect five-minute break','None','Built'),
  ('Leave age out and read','42-67 min','Individual then pairs','Reveal; report extract','Predict, read source, make provisional judgement','Included in worksheet','Built'),
  ('AI check and independent close','67-75 min','Individual then pairs','Authored AI draft','All matched is true; no-bias and threshold assurances unsupported','No extra print','Built')]
]
for idx,rows in zip((4,5,6),entries):
    table=tables[idx];template=deepcopy(table.findall(w+'tr')[1])
    for row in table.findall(w+'tr')[1:]:table.remove(row)
    for values in rows:
        tr=deepcopy(template)
        for cell,value in zip(tr.findall(w+'tc'),values):
            paragraphs=cell.findall(w+'p');set_text(paragraphs[0],value)
            for p in paragraphs[1:]:cell.remove(p)
        table.append(tr)
for p in body.findall(w+'p'):
    value=text(p)
    if value.startswith('Oct 13, Session '):
        n=int(value.split('Session ')[1][0]);title=['Read the extra change','Read the jump at a score rule','Read a matched comparison'][n-1]
        set_text(p,f'Oct 13, Session {n}: {title} ({60 if n<3 else 75} minutes)')
    elif value.startswith('Approved shorter programme:'):
        set_text(p,'Approved shorter programme: Days 1 to 3 use 60, 60 and 75 minutes; Day 4 has two course-owned 60-minute sessions. Days 1 and 2 are rebuilt. Days 3 and 4 descriptions remain historical pending their daily review. Menti is retired; the course room poll and labelled-card fallback replace it.')
    elif 'Day 1 has been rebuilt with two-sided' in value:
        set_text(p,value.replace('Day 1 has been rebuilt','Days 1 and 2 have been rebuilt').replace('Later-day descriptions','Day 3 and 4 descriptions'))
current=None
for el in body:
    if el.tag!=w+'p':continue
    value=text(el)
    if value.startswith('Oct '):current=int(value.split('Session ')[1][0]) if value.startswith('Oct 13, Session ') else None
    elif current and value.startswith('Revised '):
        extras=['No AI wall board.','Use different cards A to H and the existing A1 number line.','Print the seven profile fronts separately from cost slips; hold outcomes until pairs are recorded. Optional walking version retained.'][current-1]
        set_text(el,f'Approved 6 October 2026. GreenWaste only, fictional figures. Participant pages 1 and 2 are printed double-sided, one per person. The remaining trainer pages contain activities and keys, with page ranges stated in each pack. One trainer demonstration per session; no participant coding. Native deck controls and optional course room voting replace Menti. {extras}')
    elif value.startswith('Print, make or bring gives'):
        set_text(el,value.replace('Day 1 uses','Days 1 and 2 use'))
# Equipment row no longer requires AI accounts for authored source checks.
for tr in tables[0].findall(w+'tr'):
    cells=tr.findall(w+'tc')
    if cells and text(cells[0])=='Devices':
        set_text(cells[1].find(w+'p'),'Days 1 and 2 need no AI account. Optional phones for course room voting; test classroom network. Days 3 and 4 device needs await their daily rebuild.')
files['word/document.xml']=E.tostring(doc,encoding='UTF-8',xml_declaration=True,standalone=True)
with ZipFile(path,'w',ZIP_DEFLATED) as z:
    for n,b in files.items():z.writestr(n,b)
print('Partner brief updated for Day 2.')
