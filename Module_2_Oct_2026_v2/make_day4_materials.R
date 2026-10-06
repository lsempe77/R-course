suppressPackageStartupMessages({library(officer);library(flextable)})
source('day4_case.R',encoding='UTF-8')
reader_day<-4;source('reader_material_helpers.R')
write_part4<-function(d,n)print(d,target=file.path(out_handouts,sprintf('Oct15_session%d_handouts.docx',n)))
write_train4<-function(d,n)print(d,target=sprintf('Oct15_session%d_materials.docx',n))
ref4<-function(d,title)rt(d,title,1) |> rp('Read the stated evidence, then judge what it can support. Cite a section when you question a claim.') |> rp(report_label,10)
add_section4<-function(d,i){
  d<-d |> rh(report_sections[[i]]$title)
  for(p in report_sections[[i]]$paragraphs)d<-d |> rp(p,12,after=10)
  d
}

# Four deliberate pages keep the results table and recommendations easy to find.
report<-rdoc() |> ref4(report_title) |> add_section4(1) |> add_section4(2)
report<-report |> body_add_break() |> rt('GreenWaste design and data',1) |> rf() |> add_section4(3) |> add_section4(4)
report<-report |> body_add_break() |> rt('GreenWaste results',1) |> rf() |>
  rh(report_sections[[5]]$title) |> rp(report_sections[[5]]$paragraphs[1]) |>
  body_add_flextable(rtable(method_rows,c(2.2,1.7,2.4))) |>
  rp('Source: corrected synthetic GreenWaste file. Annual saving per business in AED, 12 months after the programme.',11)
for(p in report_sections[[5]]$paragraphs[-1])report<-report |> rp(p)
report<-report |> rh('The two city quantities') |>
  rp(sprintf('Recorded mean fall among participants: %s AED. Estimated extra change relative to other city businesses: %s AED. These quantities use different comparisons.',fmt(-case$before_after),fmt(-case$did))) |>
  body_add_break() |> rt('GreenWaste limitations and recommendations',1) |> rf() |> add_section4(6) |> add_section4(7)
print(report,target='Oct15_session1_report.docx')

# Individual opening assessment before discussion or AI.
d1<-rdoc() |> rt('Read the report independently',1) |>
  rp('Name or identifier __________________   Read report Pages 1 and 3. Answer before discussing with anyone or using AI. Cite a section where useful.') |> rf()
for(i in seq_along(assessment_questions)){
  d1<-d1 |> rh(paste(i,assessment_questions[i])) |> rl(if(i==5)2 else 1)
}
d1<-d1 |> rp('My opening judgement   Sign off / With conditions / Request evidence') |>
  rp('My source-based reason') |> rl(1) |> body_add_break() |> rt('Rate the report using its evidence',1) |>
  rp('Supported / Concern / Unsupported. Mark the summary and your assigned section. Identify a strength as well as a concern. Rate a claim, then cite the passage.') |>
  body_add_flextable(rtable(data.frame(Section=rating_sections$section,Rating=rep('',6),'Passage and reason'=rep('',6),check.names=FALSE),c(1.8,1.1,3.4)) |> height_all(height=.48,part='body')) |>
  rh('Our strongest supported passage') |> rl(1) |>
  rh('The concern that matters most') |> rp('What evidence could resolve it?') |> rl(1) |>
  rh('Repair an illustrative AI verdict') |> rp(ai_verdict) |> rp('Cross out unsupported claims. Write the source-based correction.') |> rl(1) |>
  rh('My final judgement and independent request') |> rp('Sign off / With conditions / Request evidence. Name what the evaluator should send and how it could affect your decision.') |> rl(2)
write_part4(d1,1)
print(d1,target='Oct15_session1_rating_sheet.docx')

t1<-d1 |> body_add_break() |> rt('Trainer key for the reading assessment',1) |>
  rp('Participant pages 1 and 2 double-sided, one per person. Also print the four-page report, two sheets double-sided per person. Collect individual Sheet 1 before group discussion or photograph it for scoring; return it for the final judgement. Trainer pages below are not participant copies.',10) |>
  rp('Eight minutes before AI or discussion. Give 0 for missing or wrong, 1 for partly correct, 2 for accurate with evidence. The proposed readiness target is 8/10, with no causal claim based solely on before/after change or significance. This is a teaching check, not validated certification.')
for(i in seq_along(assessment_keys))t1<-t1 |> rh(paste(i,assessment_criteria[i])) |> rp(assessment_keys[i])
t1<-t1 |> body_add_break() |> rt('Trainer key for the credibility wall',1) |>
  rp('Assign Sections 3/4/5/6/7/3/5/7 to eight groups. Everyone rates the summary. Retain two landscape A1 sheets: summary alone, then Sections 3 to 7. Supply about four small sticky notes per person plus spares. Each note cites a passage and explains its rating.',10)
for(i in 1:3)t1<-t1 |> rh(rating_sections$section[i]) |>
  rp(paste('Strength:',rating_sections$strength[i])) |> rp(paste('Concern:',rating_sections$weakness[i])) |>
  rp(paste('Suggested rating for the claim:',rating_sections$suggested[i]),11)
t1<-t1 |> body_add_break() |> rt('Trainer section key continued',1)
for(i in 4:6)t1<-t1 |> rh(rating_sections$section[i]) |>
  rp(paste('Strength:',rating_sections$strength[i])) |> rp(paste('Concern:',rating_sections$weakness[i])) |>
  rp(paste('Suggested rating for the claim:',rating_sections$suggested[i]),11)
t1<-t1 |> rh('The source check') |> rp(rating_decisive) |>
  rp('Accept another colour if the participant specifies a different claim and supports the rating. Section 6 contains useful disclosure; a supported rating does not mean the problems are resolved. Do not reward fault finding without a source.') |>
  body_add_break() |> rt('Trainer feedback and targeted retry',1) |>
  rp('Use written answers to identify a missed ability. Give feedback and one short retry during Session 2, recording the revised score separately. Ask for the outcome/population or comparison too if those were missed. No new case is introduced.')
for(i in seq_along(assessment_retry))t1<-t1 |> rh(paste('Retry',i)) |> rp(assessment_retry[i])
t1<-t1 |> rh('Retry key') |> rp('1 Point above the rule, interval spans it; the minimum is uncertain. 2 A before/after mean change lacks a credible no-programme comparison. 3 Request full cost amounts and timing, omitted costs, saving duration and credible benefit attribution; explain their decision relevance.') |>
  rh('AI and sign off') |> rp('Complete generated rows do not validate real fieldwork. City methods share records. A selected point estimate cannot establish the minimum, nationwide reach or full value for money. Compare reasons before and after; no AI account is required. Total 60 minutes.')

board4<-make_board('Oct15_session1',list(
  grid_board('Sheet 1 The executive summary','Post a section reference and a reason. Recognise strengths as well as unsupported claims.',
    cols=c('1 Executive summary'),rows=c('Supported','Concern','Unsupported'),row_fill=c('#2E7D4F','#A9561F','#B8272C'),label_w=.17),
  grid_board('Sheet 2 Sections 3 to 7','Use the same rating words. Cite the passage behind each note.',
    cols=c('3 Design','4 Data','5 Results','6 Limits','7 Action'),rows=c('Supported','Concern','Unsupported'),row_fill=c('#2E7D4F','#A9561F','#B8272C'),label_w=.17)))
t1<-t1 |> body_add_break() |> rt('Trainer preview of the credibility wall',1) |>
  rp('Print Oct15_session1_board_A1.pdf at A1 landscape, two sheets. Tape them side by side. These small previews are for setup only.',10)
for(f in board4)t1<-t1 |> body_add_img(src=f,width=6.3,height=6.3*A1_H/A1_W)
write_train4(t1,1)

findings<-rdoc() |> rt('Corrected GreenWaste evidence for a brief',2) |>
  rp('Use this reference when writing a recommendation. It corrects the review report\'s planted overclaims. Each numbered finding is a source anchor for peer review.') |> rf()
for(i in 1:4)findings<-findings |> rh(paste(i,finding_titles[i])) |> rp(finding_text[i])
findings<-findings |> rp('Source: corrected synthetic GreenWaste case and the shared cost assumptions. Annual savings are in AED per business, 12 months after. Results describe their stated comparisons and populations.',11)
print(findings,target='Oct15_session2_findings.docx')

d2<-rdoc() |> rt('Write a defensible recommendation',2) |>
  rp('Write at most 150 words for a director. Use the corrected findings reference. Each factual or causal claim needs a source. Draft without AI before peer review.') |> rf()
for(part in brief_parts)d2<-d2 |> rh(part) |> rl(3)
d2<-d2 |> body_add_break() |> rt('Review and repair the brief',2) |>
  rh('Your partner checks the source') |>
  rp('Which action is proposed? Which finding supports its strongest claim? What important uncertainty or limit would the director miss?') |> rl(2) |>
  rp('Specific suggested repair and finding number') |> rl(2) |>
  rh('My revised sentence and its effect') |> rl(2) |>
  rh('Repair an illustrative AI draft') |> rp(ai_brief) |> rp('Mark accurate numbers and unsupported assurances. Write one source-based correction.') |> rl(1) |>
  rh('My independent request and purpose') |> rp('What evidence should the evaluator send, and how would I use it?') |> rl(2) |>
  rp('If assigned a reading retry, write its number and answer on the back or on the trainer\'s retry slip.',11)
write_part4(d2,2)
# Separate one-page writing template uses the same first page as the participant sheet.
template<-rdoc() |> rt('GreenWaste brief for a director',2) |>
  rp('At most 150 words. Use the corrected findings reference and include a source for important claims.') |> rf()
for(part in brief_parts)template<-template |> rh(part) |> rl(3)
print(template,target='Oct15_session2_brief_template.docx')

t2<-d2 |> body_add_break() |> rt('Trainer key for a defensible brief',2) |>
  rp('Participant pages 1 and 2 double-sided plus one-page corrected findings reference per person. The separate one-page brief template is optional: Sheet 1 already contains it. This key is trainer only.',10) |>
  rh('One possible brief')
for(p in example_brief)t2<-t2 |> rp(p)
t2<-t2 |> rh('Judge the source use') |>
  rp('Accept another action if proportionate and explicitly conditional. Check the estimate and interval, population, comparison limits, model assumptions, and a specific request tied to its purpose. A number match or agreement with the trainer is not sufficient.') |>
  rh('AI repair') |> rp('Keep the 1,014 AED point estimate and 1.86 model ratio only with their sources and limits. The pilot interval spans 1,000 and describes one district. The ratio assumes duration and costs and a provisional causal benefit. Remove unconditional national approval and the claim that no more evidence is needed.') |>
  rh('Feedback and retry') |> rp('Return feedback from Session 1. Use a targeted reading retry for a missed ability and record any revised score separately. Check the final individual request without AI. Total 60 minutes; twelve minutes for the first draft and eight for peer review are protected.')
write_train4(t2,2)
for(n in c('Oct15_session1_report.docx','Oct15_session1_rating_sheet.docx','Oct15_session2_findings.docx','Oct15_session2_brief_template.docx'))file.copy(n,file.path(out_handouts,n),overwrite=TRUE)
message('Day 4 report, worksheets, references, trainer packs and two-sheet A1 wall written.')
