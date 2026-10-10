"""Update the Day 1 logistics in the existing partner brief using OOXML.

Preserve the later-day tables until their individual rebuilds; remove the
course-owned Day 4 Session 3 table from the current delivery brief.
"""
from pathlib import Path
from zipfile import ZipFile,ZIP_DEFLATED
from copy import deepcopy
from io import BytesIO
import subprocess
from lxml import etree as ET

ROOT=Path(__file__).resolve().parents[1]
path=ROOT/'Module2_exercise_plan_v3.docx'
source=ROOT/'backups/day1_2026_10_06_approved/Module2_exercise_plan_v3.docx'
archive=source if source.exists() else BytesIO(subprocess.check_output(
    ['git','show','2993d01:Module_2_Oct_2026_v2/Module2_exercise_plan_v3.docx'],cwd=ROOT))
with ZipFile(archive) as z:files={n:z.read(n) for n in z.namelist()}
w='{http://schemas.openxmlformats.org/wordprocessingml/2006/main}'
doc=ET.fromstring(files['word/document.xml'])
body=doc.find(w+'body')
tables=body.findall(w+'tbl')
assert len(tables)==13
def text(el):return ' '.join(t.text or '' for t in el.iter(w+'t'))
def set_text(el,value):
    # Keep paragraph and cell properties; replace the old body content.
    if el.tag==w+'tc':
        for c in list(el):
            if c.tag!=w+'tcPr':el.remove(c)
        p=ET.SubElement(el,w+'p')
    else:
        for c in list(el):
            if c.tag!=w+'pPr':el.remove(c)
        p=el
    r=ET.SubElement(p,w+'r');t=ET.SubElement(r,w+'t');t.text=value

entries=[
 [('Entry reading task','Start of session','Individual reading','Sheet 1','No AI or explanation first. Keep the opening decision and question for later review.','One two-sided participant sheet per person','Built'),
  ('Extension choice and evidence reveal','After case introduction','Choice then reveal','Local deck controls; optional room poll','Choose Extend / Do not extend / Ask first. Reveal the non-participant landfill change only after reasons.','Test room phones; otherwise labelled cards','Built; venue check pending'),
  ('Ten businesses','Before triage','Visual reading','Sheet 1 and ten-business display','Spot the large business and explain why the mean may describe few businesses. No long arithmetic.','Included on Sheet 1','Built'),
  ('Four-claim triage','Main practice','Group cards and reasons','Sheet 2; four claim slips','Preserve Fiona’s four claims. Name the missing question and explain the decision. Discuss two disagreements.','One card page per group, cut; optional existing A1 board','Built'),
  ('AI claim check and individual close','End of session','Source checking then retrieval','Deck and worksheet','Check an authored AI causal claim; finish with one useful question and why it matters.','No AI account required','Built')],
 [('Report mark-up','Main task','Individual then pairs','Two-sided participant sheet','Circle coefficient, box interval, underline comparison. Find units, period and the rule before giving a decision.','One two-sided sheet per person','Built'),
  ('Short trainer calculation','Find its row','Prediction then trainer Run','webR cell; printed result fallback','Run one before/after subtraction. Participants read the output; they do not write or debug code.','Open deck early; no extra print','Built'),
  ('AI summary repair','End of session','Source checking','Sheet 2 and deck','Keep the observed fall; remove an unsupported causal and scale-up conclusion. Verify against source evidence.','Included on Sheet 2','Built'),
  ('Independent decision sentence','Close','Individual reading','Worksheet','State result with units, a limit and next question. Significance does not establish cause or meet the rule.','Included on worksheet','Built')],
 [('Comparison choice and baseline reveal','Opening','Choice before evidence','Deck; optional room poll','Compare two observational claims. Reveal starting costs after participants commit to a reason.','Paper cards as fallback','Built'),
  ('Two lottery draws','Short trainer demo','Predict then trainer Run','One webR cell; age list in trainer key','Twenty businesses, ten places. Compare manager ages in two draws. This is a balance demonstration, not a new effect estimate.','Optional twenty numbered age slips','Built'),
  ('Trial reading and interval reveal','Before and after break','Individual reading','Sheet 1 and interval graphic','Identify randomly assigned pilot groups. Compare estimate and interval with the 1,000 AED rule.','One two-sided sheet per person','Built'),
  ('Decision note','Main practice','Paired writing and feedback','Sheet 2','Write three or four sentences with source evidence. Distinguish threshold uncertainty, pilot reach and value for money.','Included on Sheet 2','Built'),
  ('AI note check and evaluator question','Close','Source checking then individual retrieval','Sheet 2 and deck','Remove unsupported claims that the rule is proven and nationwide rollout is good value. Finish alone with a question and purpose.','No AI account required','Built')]
]
for paragraph in body.findall(w+'p'):
    value=text(paragraph)
    if value.startswith('All twelve sessions now have print materials'):
        set_text(paragraph,'The programme now has eleven course-owned sessions. Day 1 has been rebuilt with two-sided participant sheets and separate trainer keys. Later-day descriptions and files remain historical until their daily rebuild. The final Day 4 slot belongs to an evaluation simulation prepared by someone else.')
    if value.startswith('Revised 6 Oct: a new column'):
        set_text(paragraph,'Print, make or bring gives the practical requirement for each exercise. Quantities assume eight groups and up to forty participants; adjust them to final attendance. Menti is retired. Day 1 uses local deck interactions and optional course-owned room voting, with labelled cards as the fallback.')
    for session,title in [(1,'Question a claim'),(2,'Read a reported result'),(3,'Judge a fair comparison')]:
        if value.startswith(f'Oct 12, Session {session}:'):
            set_text(paragraph,f'Oct 12, Session {session}: {title} ({60 if session<3 else 75} minutes)')
for idx,rows in enumerate(entries,1):
    table=tables[idx]
    template=deepcopy(table.findall(w+'tr')[1])
    for row in table.findall(w+'tr')[1:]:table.remove(row)
    for values in rows:
        row=deepcopy(template)
        for c,value in zip(row.findall(w+'tc'),values):set_text(c,value)
        table.append(row)
    prev=table.getprevious()
    while prev is not None and prev.tag!=w+'p':prev=prev.getprevious()
    set_text(prev, f'Approved 6 October 2026. Session length {60 if idx<3 else 75} minutes. GreenWaste only, fictional figures. Print the first two pages of Oct12_session{idx}_materials.docx double-sided for participants. Remaining pages are trainer material'+('; page 3 contains one card set per group.' if idx==1 else '.'))

# Remove former S3 heading, introductory paragraph and exercise table together.
last=tables[12]
prev=last.getprevious()
removed=[]
while prev is not None and prev.tag==w+'p':
    content=text(prev)
    if 'Team working time' in content or not content.strip():removed.append(prev)
    elif 'Session 3' in content or 'Plan Your Own' in content or 'Plan your own' in content:
        removed.append(prev);break
    else:break
    prev=prev.getprevious()
for el in removed:body.remove(el)
body.remove(last)
p=ET.Element(w+'p');set_text(p,'Day 4 final slot: evaluation simulation prepared by another provider. Our former design workshop is excluded; its original files remain in the archive. No course-owned activities or print pack are required for that slot.')
body.insert(len(body)-1,p)

# Add a prominent scope paragraph before the first logistics table.
p=ET.Element(w+'p');set_text(p,'Approved shorter programme: Days 1–3 use 60, 60 and 75 minutes; Day 4 has two course-owned 60-minute sessions. This brief has been rebuilt for Day 1. Later-day descriptions remain historical until their daily review. Menti is retired; the course room poll and labelled-card fallback will replace its activities during each rebuild.')
body.insert(list(body).index(tables[0]),p)
files['word/document.xml']=ET.tostring(doc,encoding='utf-8',xml_declaration=True,standalone=True)
with ZipFile(path,'w',ZIP_DEFLATED) as z:
    for n,b in files.items():z.writestr(n,b)
print('Partner brief: Day 1 updated, former Day 4 S3 removed.')
