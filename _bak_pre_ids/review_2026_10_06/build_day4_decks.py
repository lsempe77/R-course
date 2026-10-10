"""Build the approved two-session Day 4 route with native browser controls."""
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parent))
from trainer_code import annotate_deck
from reader_titles import apply_titles
from build_day2_decks import slide,ask,chunk,raw,open_answer
ROOT=Path(__file__).resolve().parents[1]
def header(title,n):
    return f'''---
title: "{title}"
subtitle: "Module 2 | Day 4 | Session {n}"
author: "3ie"
always_allow_html: true
format:
  revealjs:
    theme: [theme_dge.scss, theme_reader.scss]
    logo: assets/dge_logo_horizontal.svg
    slide-number: true
    width: 1280
    height: 720
    slide-level: 2
    embed-resources: true
    include-after-body: _reader_interactions.html
knitr:
  opts_chunk:
    echo: false
    warning: false
    message: false
---

```{{r setup, include=FALSE}}
source('day4_case.R')
```

'''
def choices():
    return raw('<div data-choices>'+''.join(f'<button data-choice aria-pressed="false">{x}</button>' for x in ['Sign off','With conditions','Request evidence'])+'<p role="status" class="feedback"></p></div>')

s1=header('Judge a report section by section',1)
s1+=slide('Read independently','Read **Pages 1 and 3** of the report.\n\nAnswer the five questions on **Sheet 1**. Work alone.\n\nUse the report as your source. Save discussion for afterwards.\n\n'+ask('What does the evidence support?'),8,'Collect a name or identifier on the individual reading task. No AI or group discussion. Use the unfamiliar report presentation; this is the same GreenWaste case, not a different-programme transfer test. The fictional exercise contains planted overclaims, labelled on the report. Explain its design after this task. Score five abilities 0 to 2 from the trainer key; do not score room votes.')
s1+=slide('Give your initial judgement',choices()+ask('Would you sign off on this report as written?')+'Write a source-based reason before comparing choices.',4,'After eight minutes explain the intentional strengths and faults. Require a section or sentence. Optional course room poll Before phase: hide totals until close; labelled cards work too. Decisions are provisional, not a test with one required vote.')
s1+=slide('Use the rating scale',raw('<div class="rating-options"><div><h3>Supported</h3><p>Source supports the claim within its limits.</p></div><div><h3>Concern</h3><p>Name the uncertainty or missing check.</p></div><div><h3>Unsupported</h3><p>Claim exceeds or contradicts the source.</p></div></div>')+ask('Which passage supports your rating?'),4,'Use words as well as Green/Amber/Red. Rate claims rather than a whole method or person. A section can have strengths and an unsupported conclusion. Record both; justify the overall rating for the claim being discussed.')
s1+=slide('Check the executive summary',chunk("html_out(sprintf('<p class=\"lead\">The matched saving is %s AED. Four independent methods confirm the programme caused the saving. Nationwide expansion meets the standard.</p>%s',fmt(-match_A$est),fiction))")+ask('Which statement most needs checking against the rest of the report?')+'Mark one strength and one concern on **Sheet 2**.',6,'This is a shortened excerpt from the intentionally flawed Section 1. Everybody rates the summary independently before posting. Naming the rule and outcome is a strength. Trace the headline, independence, causal reach and model claims rather than objecting to every sentence.')
s1+=slide('Investigate your report section','Groups read their assigned section: **3, 4, 5, 6 or 7**.\n\nFind one strength and one important concern.\n\nCite the passage. Name evidence that could change your judgement.\n\n'+ask('Which claim can you support, and which needs attention?'),10,'For eight groups assign Sections 3/4/5/6/7/3/5/7. All participants have the same report and two-sided sheet. Groups work on a claim, not a colour competition. Section 6 offers real disclosures that should earn a supported rating. Protect the reading time.')
s1+=slide('Post evidence on the wall','Use the **two-sheet credibility grid**.\n\nPost your executive-summary rating on Sheet 1 of the wall.\n\nPost your group section rating on Sheet 2.\n\nEach note names a section and gives a reason.\n\n'+ask('Could another reader locate the evidence behind your note?'),7,'Retain Fiona\'s dedicated summary grid and five-section grid. About four small sticky notes per person, plus spares. Everyone posts the summary; pairs or groups post the assigned section. Words Supported/Concern/Unsupported match Green/Amber/Red. No names on the wall.')
s1+=slide('Compare the ratings','Choose a disagreement on the wall.\n\nExplain each rating using a source passage.\n\n'+ask('What evidence could resolve the disagreement?')+open_answer('rating-feedback','Open an example','Section 6 discloses meaningful limits. That disclosure is supported; it does not resolve the limits or validate Section 7.'),7,'Use the trainer section key. Accept different overall ratings when the specific claim and reason are clear. Do not treat colour consensus as proof. Bring out a supported disclosure as well as the unsupported summary or recommendation.')
s1+=slide('Follow the headline to its source',chunk("html_out(html_table(method_rows[c(2,4),],compact=TRUE))")+ask('Does selecting the largest point estimate settle the saving rule?')+open_answer('headline-feedback','Open the source check','The selected matching interval spans 1,000. The preferred city interval falls short. City methods share records and have different assumptions.'),5,'Section 5 has all four rows; this screen selects the preferred city analysis and the headline for direct comparison. Positive numbers denote annual saving in AED. Do not count methods as independent votes; do not confuse the saving rule with full value for money. A point estimate above the rule does not guarantee the underlying saving clears it.')
s1+=slide('Repair an AI verdict',chunk("html_out(paste0('<p>',ai_verdict,'</p>'))")+ask('Which claims would you correct against the report?')+open_answer('rating-ai','Open feedback','Complete generated rows do not prove fieldwork quality. City methods share records. A matched point estimate above the rule cannot justify nationwide approval.'),4,'Authored AI draft; no account required. Cross out and repair on Sheet 2 before the reveal. The report already discloses the relevant evidence. Accuracy of one number does not make the verdict sound.')
s1+=slide('Revisit sign-off',choices()+ask('Which evidence changed your reason or kept it the same?')+'Write your final judgement and any evidence still needed.',3,'Optional After phase of the room poll, closed before totals. Discuss reasons rather than the winning vote. A conditional proposal must state its limits. Assess the independent reading responses, not a colour or vote change.')
s1+=slide('Your question from memory',ask('What would you ask the evaluator next, and why?')+'Close the report. Write a specific request independently.',2,'Collect the five-item reading task and the final request. Score 0 missing/wrong, 1 partial, 2 accurate with evidence. Provisional target 8/10 with no causal claim based solely on before/after or significance. Give feedback and a short targeted retry in Session 2. Total 60 minutes.')

s2=header('Write a defensible recommendation',2)
s2+=slide('Start from corrected evidence','Open the **corrected findings reference**.\n\nLocate the pilot interval, city comparison limit and cost assumptions.\n\nUse this source when drafting.\n\n'+ask('Which evidence would most affect the proposed action?'),5,'The reference corrects the exercise report\'s planted claims. Four anchors replace the long six-findings tour and Tariff Shield case. Use the current GreenWaste figures; do not treat yesterday\'s flawed report as an unquestioned source. No coding or model demonstration.')
s2+=slide('What does the decision require?',raw('<div class="decision-checks"><div><h3>Saving rule</h3><p>Estimate and interval against 1,000 AED.</p></div><div><h3>Cause and reach</h3><p>Fair comparison and people described.</p></div><div><h3>Value for money</h3><p>Evidence about costs and duration.</p></div></div>')+ask('Which question remains unanswered for nationwide expansion?'),5,'These are separate decision considerations. Passing a numerical rule would not establish transportability or costs. Use familiar technical terms only as needed and explain them in ordinary language. Do not add a new method catalogue.')
s2+=slide('Read a useful short brief',chunk("html_out(paste0('<div class=\"sample-brief\">',paste(sprintf('<p>%s</p>',example_brief),collapse=''),'</div>'))")+ask('Where are the finding, recommendation, risk and evidence request?'),5,'Read the model as one possible conditional judgement, not the correct vote. Mark its four parts on the source reference. It is under 150 words and names the interval and reach. The request explains how the answer affects scale and budget.')
s2+=slide('Draft your brief','Write **at most 150 words** for a director.\n\nUse **Sheet 1**: finding, recommendation, risk and next evidence.\n\nKeep the corrected source open.\n\n'+ask('Can the director see what you recommend and why?'),12,'Individuals draft their own brief, then may discuss with a partner. Protect twelve minutes. One proportionate action with an explicit condition is enough. Each factual and causal claim must have a source. No AI in the first draft; do not demand jargon or estimator details.')
s2+=slide('Swap and verify','A partner reviews your brief using **Sheet 2**.\n\nPoint to the source for its strongest claim.\n\nCheck the interval, population and missing evidence.\n\n'+ask('What important limit would the director otherwise miss?'),8,'Reviewer cites the finding anchor, not just a tick or a numerical match. Treat unsupported claims and material omissions as review issues. Give one concrete suggested repair. The author retains responsibility for the recommendation.')
s2+=slide('Repair what the review found','Revise one important sentence.\n\nAdd the condition or limit that the evidence requires.\n\nExplain how the edit changes the recommendation.\n\n'+ask('Does the revised action follow from the source?'),7,'Accept different defensible choices. Check that a condition is meaningful, not a generic caveat. A recommendation to gather evidence needs a specific request and purpose. No automated word or number matching can prove faithful interpretation.')
s2+=slide('Check an AI draft',chunk("html_out(paste0('<p>',ai_brief,'</p>'))")+ask('How can an accurate number accompany an unsupported action?')+open_answer('brief-ai','Open the source check','The pilot interval spans the rule and describes one district. The ratio depends on fictional cost and duration inputs. Remove the national approval and no-more-evidence assurances.'),6,'Authored draft includes accurate point and ratio but false threshold, reach and cost conclusions. Mark and repair on Sheet 2 before revealing feedback. No external AI account or script needed. Compare each assertion with a source and a limit.')
s2+=slide('Defend one recommendation','Share the action and its condition.\n\nPoint to the evidence behind it.\n\nName an answer that could change it.\n\n'+ask('Would your recommendation still make sense if that answer changed?'),6,'Invite two or three short defences. Discuss evidence and proportionality rather than persuasive tone. Help participants recognise useful positive evidence as well as reasons to request more. Do not score agreement with the trainer\'s preferred action.')
s2+=slide('Make your final request',ask('What specific evidence should the evaluator send, and how would you use it?')+'Write independently.\n\nIf you received a reading-item retry, answer it now using the source.',6,'Give targeted feedback on the Session 1 reading task and a retry for the missing ability, including a before/after causal trap if needed. Record revised scores separately. The 8/10 target is a teaching check, not validated certification; a new presentation of one case does not demonstrate transfer to a different programme. The other provider owns the final simulation. Total 60 minutes.')

for name,text in [('Oct15_session1.qmd',s1),('Oct15_session2_live.qmd',s2),('Oct15_session2.qmd',s2)]:
    (ROOT/name).write_text(apply_titles(annotate_deck(text),name).rstrip()+'\n',encoding='utf-8')
    print(name,text.count('## '),'content screens')
