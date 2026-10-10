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
 [('Read inputs','0-13 min','Individual then pairs','Participant sheet 1','Saving source, cost, timing and duration; label assumptions','Two-sided participant sheet, one per person','Built'),
 ('Predict and run','13-18 min','Trainer demo','Deck and result row','One benefit-cost calculation only; paper fallback','Open webR early','Built'),
 ('Timing and missing costs','18-29 min','Pairs','Native reveal and worksheet','Later savings and omitted costs; avoid double counting','No extra print','Built'),
 ('Scenario and ratio wall','29-44 min','Eight groups','Five scenario cards; A1 board','Separate prediction and result lanes','Trainer pages 3-7 plus 3-5 again; one landscape A1; eight sticky notes','Built'),
 ('Decision, AI repair and close','44-60 min','Individual then pairs','Participant sheet 2','Question the assumptions; independent evidence request','Trainer pages 8-9 contain results and delivery key','Built')],
 [('Read chart labels and axes','0-10 min','Individual then pairs','Native axis toggle','Same values, different bar baseline','Participant pages 1-2, double-sided per person','Built'),
 ('Mark and inspect average','10-23 min','Individual then pairs','Printed chart and distribution reveal','Units, source, comparison; average can hide spread','No extra print','Built'),
 ('Denominator and interval','23-36 min','Trainer and pairs','Deck; worksheet','One total-tonnes calculation; pilot interval reveal','Trainer page 3 contains key','Built'),
 ('Caption repair and defence','36-56 min','Pairs','Participant sheet 2','Supported description and causal limit; repair AI draft','No drawing software or AI account','Built'),
 ('Question from memory','56-60 min','Individual','Worksheet','Check and purpose, no AI','No extra print','Built')],
 [('Note, evidence and questions','0-20 min','Individual then groups','Note; result table; five-question QA','Opening sign-off; request specific sources','Participant pages 1-2, double-sided; optional one-page QA reference','Built'),
 ('Prepare and break','20-32 min','Groups then break','Worksheet','Rank questions; spokesperson; five-minute break','No extra print','Built'),
 ('Analyst clinic','32-46 min','Eight groups','Fixed answer bank','One question and follow-up per group; disclose absent evidence','Trainer pages 3-4 only; keep bank from participants','Built'),
 ('Requested result','46-52 min','Trainer demo','Pilot interval','One calculation answers the saving-rule question','Paper results for other questions','Built'),
 ('Rate and revisit sign-off','52-68 min','Individual then pairs','Worksheet','Source-backed, partial or unanswered; compare reasons','Optional room poll Before/After, cards fallback','Built'),
 ('AI repair and independent close','68-75 min','Individual then pairs','Worksheet','Correct source claims; write specific request without AI','Trainer page 5 contains key','Built')]
]
for idx,rows in zip((7,8,9),entries):
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
    if value.startswith('Oct 14, Session '):
        n=int(value.split('Session ')[1][0]);title=['Judge a value for money claim','Read a chart before trusting its story','Question the analyst'][n-1]
        set_text(p,f'Oct 14, Session {n}: {title} ({60 if n<3 else 75} minutes)')
    elif value.startswith('Approved shorter programme:'):
        set_text(p,'Approved shorter programme: Days 1 to 3 use 60, 60 and 75 minutes; Day 4 has two course-owned 60-minute sessions. Days 1 to 3 are rebuilt. Day 4 descriptions remain historical pending their daily review. Menti is retired; the course room poll and labelled-card fallback replace it.')
    elif value.startswith('Oct 15, Session ') and 'Historical' not in value:
        set_text(p,'Historical, pending Day 4 review: '+value)
    elif 'have been rebuilt with two-sided' in value:
        set_text(p,value.replace('Days 1 and 2 have been rebuilt','Days 1 to 3 have been rebuilt').replace('Day 3 and 4 descriptions','Day 4 descriptions'))
current=None
for el in body:
    if el.tag!=w+'p':continue
    value=text(el)
    if value.startswith('Historical, pending Day 4 review:'):current=None
    elif value.startswith('Oct '):current=int(value.split('Session ')[1][0]) if value.startswith('Oct 14, Session ') else None
    elif current and (value.startswith('Revised ') or value.startswith('Discussion-heavy')):
        extras=['Retain the five scenario cards and ratio wall; all assumptions are labelled.','Use native axes and distribution reveals.','Use the fixed analyst answer bank; never invent missing fieldwork evidence.'][current-1]
        set_text(el,f'Approved 6 October 2026. GreenWaste only, fictional figures. Participant pages 1 and 2 are printed double-sided, one per person. The remaining trainer pages contain activities and keys, with page ranges stated in each pack. One trainer demonstration per session; no participant coding. Native deck controls and optional course room voting replace Menti. {extras}')
    elif value.startswith('Print, make or bring gives'):
        set_text(el,value.replace('Days 1 and 2 use','Days 1 to 3 use'))
# Equipment row no longer requires AI accounts for authored source checks.
for tr in tables[0].findall(w+'tr'):
    cells=tr.findall(w+'tc')
    if cells and text(cells[0])=='Devices':
        set_text(cells[1].find(w+'p'),'Days 1 to 3 need no AI account. Optional phones for course room voting; test classroom network. Day 4 device needs await its daily rebuild.')
day4_intro=False
for el in body:
    if el.tag!=w+'p':continue
    value=text(el)
    if value.startswith('Historical, pending Day 4 review:'):
        day4_intro=True
    elif day4_intro and value.strip():
        set_text(el,'Historical description retained pending the Day 4 daily review. Existing materials and activity rows below are not the approved shorter route. Menti and the former third-session workshop are excluded from the new programme.')
        day4_intro=False
files['word/document.xml']=E.tostring(doc,encoding='UTF-8',xml_declaration=True,standalone=True)
with ZipFile(path,'w',ZIP_DEFLATED) as z:
    for n,b in files.items():z.writestr(n,b)
print('Partner brief updated for Day 3.')
