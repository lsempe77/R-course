"""Update Day 4 in the current brief, preserving approved Days 1 to 3."""
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
 [('Independent reading','0-8 min','Individual','Report pages 1 and 3; worksheet','Five abilities, before AI or discussion; collect for scoring','Four-page report, two sheets double-sided per person; participant sheet two-sided','Built'),
 ('Initial judgement and scale','8-16 min','Individual then pairs','Native choices; rating legend','Reason and source; Supported / Concern / Unsupported','Optional room poll Before phase; labelled cards fallback','Built'),
 ('Summary and section reading','16-32 min','Individual then groups','Report; worksheet','Each group finds a strength and a consequential concern','Eight groups: Sections 3/4/5/6/7/3/5/7','Built'),
 ('Credibility wall','32-39 min','Groups','Two-sheet A1 grid; sticky notes','Dedicated summary panel; Sections 3-7 on second sheet','Two landscape A1 sheets; about four small notes per person plus spares','Built'),
 ('Compare and trace headline','39-51 min','Pairs and room','Report and native evidence reveals','Cite passages; recognise supported disclosure; inspect selected estimate','Trainer section key and board preview only','Built'),
 ('AI repair and close','51-60 min','Individual then pairs','Worksheet','Source correction, final judgement and independent request','No external AI account; assess written reading task','Built')],
 [('Corrected evidence','0-10 min','Individual then pairs','One-page findings reference','Saving rule, cause/reach and cost assumptions are separate','One findings reference plus participant two-sided sheet per person','Built'),
 ('Short brief model','10-15 min','Pairs','Four-part example in deck','Finding, recommendation, risk and next evidence','No extra print','Built'),
 ('Draft the brief','15-27 min','Individual','Participant Sheet 1','At most 150 words, sources open, no AI in first draft','Separate one-page template optional; already included in Sheet 1','Built'),
 ('Peer review and repair','27-42 min','Pairs then individual','Participant Sheet 2','Cite finding anchor; identify material limit; revise one sentence','Trainer key only; no number-matching script','Built'),
 ('AI source check and defence','42-54 min','Pairs and room','Authored AI draft; native feedback','Accurate numbers do not establish nationwide approval','No AI account or new model demo','Built'),
 ('Final request and reading retry','54-60 min','Individual','Worksheet; targeted retry if needed','Request and purpose without AI; record revised reading score separately','Use Session 1 trainer retry key; optional scrap slip','Built')]
]
for idx,rows in zip((10,11),entries):
 table=tables[idx];template=deepcopy(table.findall(w+'tr')[1])
 for row in table.findall(w+'tr')[1:]:table.remove(row)
 for values in rows:
  tr=deepcopy(template)
  for cell,value in zip(tr.findall(w+'tc'),values):
   paragraphs=cell.findall(w+'p');set_text(paragraphs[0],value)
   for p in paragraphs[1:]:cell.remove(p)
  table.append(tr)
current=None
for el in body:
 if el.tag!=w+'p':continue
 value=text(el)
 if 'Oct 15, Session ' in value and ('Historical, pending' in value or value.startswith('Oct 15, Session ')):
  current=int(value.split('Session ')[1][0]);title=['Judge a report section by section','Write a defensible recommendation'][current-1]
  set_text(el,f'Oct 15, Session {current}: {title} (60 minutes)')
 elif value.startswith('Oct '):current=None
 elif current and (value.startswith('Historical description') or value.startswith('Revised ') or value.startswith('Approved 6 October')):
  extra=['Print the four-page report separately. Trainer pages contain the assessment rubric, section key, retries and two-sheet board preview.','Print the one-page corrected findings reference separately. The optional brief template duplicates worksheet Sheet 1.'][current-1]
  set_text(el,'Approved 6 October 2026. GreenWaste only, fictional figures. Participant pages 1 and 2 are printed double-sided, one per person. Native evidence reveals and optional room voting replace Menti. No model lab or participant coding. '+extra)
 elif value.startswith('Approved shorter programme:'):
  set_text(el,'Approved shorter programme: Days 1 to 3 use 60, 60 and 75 minutes; Day 4 has two course-owned 60-minute sessions. All eleven sessions are rebuilt. The final Day 4 slot belongs to an evaluation simulation prepared by another provider. Use the course room poll with a labelled-card fallback; no Menti.')
 elif value.startswith('The programme now has eleven'):
  set_text(el,'The programme has eleven course-owned sessions, all rebuilt with shorter explanations, two-sided participant worksheets and separate trainer keys. The final Day 4 slot belongs to an evaluation simulation prepared by someone else. No materials are required from this course for that slot.')
 elif value.startswith('Print, make or bring gives'):
  set_text(el,'Print, make or bring gives the practical requirement for each exercise. Assume eight groups and forty participants; adjust for final attendance. No external AI account is required for the authored source checks. Native deck controls and optional course room voting are ready; test venue phone access and keep labelled cards as the fallback.')
for tr in tables[0].findall(w+'tr'):
 cells=tr.findall(w+'tc')
 if cells and text(cells[0])=='Devices':set_text(cells[1].find(w+'p'),'No AI account required. Optional phones for course room voting; rehearse classroom network access. Open browser calculation decks early. Printed results and labelled cards are the fallback.')
files['word/document.xml']=E.tostring(doc,encoding='UTF-8',xml_declaration=True,standalone=True)
with ZipFile(path,'w',ZIP_DEFLATED) as z:
 for n,b in files.items():z.writestr(n,b)
print('Exercise brief updated for all eleven sessions.')
