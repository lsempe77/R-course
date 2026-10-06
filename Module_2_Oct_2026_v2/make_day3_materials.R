suppressPackageStartupMessages({library(officer);library(flextable)})
source('day3_case.R',encoding='UTF-8')
reader_day<-3;source('reader_material_helpers.R')
write_part<-function(d,n)print(d,target=file.path(out_handouts,sprintf('Oct14_session%d_handouts.docx',n)))
write_train<-function(d,n)print(d,target=sprintf('Oct14_session%d_materials.docx',n))
qa_dir<-'review_2026_10_06/qa/day3_print';dir.create(qa_dir,recursive=TRUE,showWarnings=FALSE)
chart_file<-file.path(qa_dir,'cost_chart.png')
png(chart_file,width=1500,height=650,res=200)
par(mar=c(3,4,2,1),family='sans',cex=1.35,fg='#063360')
pos<-barplot(ba_mean,col='#215a9e',border=NA,ylim=c(0,1650),names.arg=c('Before','12 months after'),ylab='Annual waste cost (AED)')
text(pos,ba_mean+75,fmt(ba_mean),cex=1.2);dev.off()

d1<-rdoc() |> rt('Judge a value for money claim',1) |>
  rp('Read the model inputs, predict what could change the ratio and ask for the evidence you would need before approving spending.') |> rf() |>
  rh('1 Open the inputs behind the headline') |>
  body_add_flextable(rtable(assumptions,c(2.2,1.5,2.6))) |>
  rp(sprintf('Modelled benefits at today\'s value: %s AED per business. Included one-off cost: %s AED. Benefits divided by costs: %.2f.',fmt(model$saving*pv_factor()),fmt(model$cost),ratio())) |>
  rp('A ratio above 1 means modelled benefits exceed included costs. The benefit estimate still needs a credible causal interpretation; duration and costs are assumptions.') |>
  rh('2 What would you ask about the inputs') |> rl(2) |>
  rh('3 What costs might be missing') |> rp('A reviewer asks about staff time, administration and businesses\' time. Request amounts and timing, and check what is already included.') |> rl(2) |>
  body_add_break() |> rt('Test the claim before approving',1) |>
  rh('Your group scenario') |> rp('Card number ______   The assumption changed ______________________________') |> rl(1) |>
  rp('Our prediction ______   The result ______   Above or below 1 ______') |>
  rp('Is the scenario plausible? What evidence would establish that?') |> rl(2) |>
  rh('Repair an illustrative AI recommendation') |>
  rp('"The ratio exceeds 1, so GreenWaste is proven to be good value. The savings will last five years. Approval is justified."',14) |>
  rp('Keep supported claims. Cross out assurances and rewrite with a condition or evidence request.') |> rl(3) |>
  rh('Your question from memory') |> rp('Close Sheet 1. Write one question and explain how its answer could affect your decision. Work alone.') |> rl(2)
write_part(d1,1)
t1<-d1
for(i in 1:5) t1<-t1 |> body_add_break() |> rt(paste('Scenario card',i),1) |>
  rp('Read the changed assumption. Agree a prediction and a reason before opening the result.',10) |> rf() |>
  rp(as.character(i),64,TRUE,colour='#063360',after=20) |> rh(scenarios$name[i]) |>
  rp(scenarios$story[i],18,after=20) |>
  rp('Predict the ratio before the trainer reveals the result.',14) |>
  rp('Prediction __________________',18,after=20) |>
  rp('Write your card number and prediction on a sticky note. Put it above the ratio line. Afterwards put this card in the lower lane at the result.',14) |>
  rp('What evidence would show whether this scenario could happen?',14) |> rl(3)
board3<-make_board('Oct14_session1',list(line_board('Does it still pay for itself?',
  'Before the reveal: post card number and prediction above the line. Afterwards: put your card at the result below.',
  lim=c(0,2),major=seq(0,2,.5),minor=seq(0,2,.1),fmt=function(v)sprintf('%.1f',v),
  marks=list(list(at=1,col=RED,lty='solid',label='Break-even: 1.0'),list(at=ratio(),col=BLUE,lty='dashed',label=sprintf('Headline: %.2f',ratio()))),
  lane_up='Our prediction (sticky note)',lane_down='The model result (put your card here)',
  shade=list(list(from=0,to=1,fill='#F8E9EA'),list(from=1,to=2,fill='#EAF2EC')))))
t1<-t1 |> body_add_break() |> rt('Trainer key for the ratio wall',1) |>
  rp('Participant pages 1 and 2 double-sided, one per person. Cards pages 3 to 7, with 3 to 5 repeated for eight groups. Print the A1 board at landscape size; bring eight sticky notes and markers.',10) |>
  body_add_flextable(rtable(data.frame(Card=scenarios$card,Scenario=scenarios$name,Ratio=fmt(scenarios$value,2),
    'Below 1'=ifelse(scenarios$value<1,'Yes','No'),check.names=FALSE),c(.6,2.8,1.3,1.6))) |>
  rh('Source and interpretation') |>
  rp(sprintf('Provisional saving is minus city DiD (%s AED), with the parallel-trends limitation carried forward. One-off cost %s AED, no benefit in year 1, five saving years in years 2 to 6, rate 5%%. Scenario assumptions are fictional, not measured programme facts.',fmt(model$saving),fmt(model$cost))) |>
  rp('Discounting expresses later benefits at today\'s value. The one-year example in the deck is separate from the model\'s first benefit in year 2. Use unrounded values for ratios; printed inputs are rounded. No double counting when adding omitted costs.') |>
  body_add_break() |> rt('Trainer delivery and feedback',1) |>
  rp('Predict once, then one trainer calculation. Scenario results are prepared reveals, not five extra code demonstrations. Keep prediction and result lanes separate. Ask which plausible change matters and what evidence would establish it. Protect the group task and independent close. Total 60 minutes.') |>
  rp('The AI recommendation accurately repeats a ratio above 1 but turns assumptions into facts. Remove proof of value, guaranteed duration and unconditional approval. A saving threshold and a benefit-cost ratio address different questions. No AI account is required.') |>
  body_add_img(src=board3[[1]],width=6.3,height=6.3*A1_H/A1_W)
write_train(t1,1)

d2<-rdoc() |> rt('Read a chart before trusting its story',2) |>
  rp('Mark what the chart actually shows before accepting its caption. Then repair a conclusion that goes beyond the evidence.') |> rf() |>
  body_add_img(src=chart_file,width=6.3,height=6.3*650/1500) |>
  rp('Source: fictional GreenWaste city participants, the same businesses before and 12 months after. Recorded mean annual waste cost per business, AED.',11) |>
  rh('1 Mark the chart') |> rp('Circle the units. Mark where the axis starts. Underline the comparison and period in the source caption.') |>
  rh('2 What can it support') |> rp('Write one supported statement and one conclusion it cannot establish.') |> rl(3) |>
  body_add_break() |> rt('Check the caption and denominator',2) |>
  rh('Two summaries of participant landfill waste') |>
  body_add_flextable(rtable(data.frame(Summary=c('Fall in total tonnes','Mean of business percentage falls'),
    Result=paste0(fmt(c(percent_total,percent_average),1),'%'),Weight=c('Larger starting tonnes count more','Each business has equal weight')),c(2.8,1,2.5))) |>
  rp('Both describe the same participants before and after. They answer different questions. Neither alone establishes cause. Ask what a percentage is a percentage of.') |>
  rh('Repair the cost chart caption') |>
  rp('"The cost chart proves GreenWaste caused the saving for every city business."',14) |>
  rp('Write a caption naming source, units, comparison and one limit. Work with a partner.') |> rl(3) |>
  rh('Repair an illustrative AI caption') |>
  rp('"GreenWaste caused a fall of almost half in every business\'s landfill waste. The before/after chart proves the programme works."',14) |>
  rp('Point to what the landfill summary supports. Cross out unsupported words and rewrite.') |> rl(2) |>
  rh('Your check from memory') |> rp('Close Sheet 1. What would you check first, and why? Work alone.') |> rl(1)
write_part(d2,2)
t2<-d2 |> body_add_break() |> rt('Trainer key for chart reading',2) |>
  rp('Participant pages 1 and 2 double-sided, one per person. This key is trainer only.',10) |>
  rh('Axes and comparison') |>
  rp(sprintf('Recorded costs %s before and %s after, city participants only. The two screen charts have identical values; one starts at 700 AED, the other at zero. The truncated bars exaggerate the visual proportion of the fall. Neither comparison isolates GreenWaste\'s effect or describes every city business.',fmt(ba_mean[1]),fmt(ba_mean[2]))) |>
  rh('Average and denominator') |> rp(sprintf('The ten-business landfill teaching selection has mean %s tonnes, nine below it and one at %s. It is not a representative city distribution. Participant total-tonnes fall %s%%; mean business percentage fall %s%%. The first weights by starting tonnes, the second equally by business.',fmt(mean(ten$landfill_before),1),fmt(max(ten$landfill_before)),fmt(percent_total,1),fmt(percent_average,1))) |>
  rh('Interval and captions') |> rp('Pilot estimate and interval use the canonical lottery model from Day 1. The interval spans the saving rule. Repair the cost caption as an observed mean fall for city participants, without a causal or all-business claim. For landfill, retain the approximate total fall, remove every-business and proof-of-cause assurances.') |>
  rh('Delivery') |> rp('One trainer calculation, prediction before Run; native axis toggle and evidence reveals. No school-zone case, pie-chart detour or discount-rate repeat. Source labels and limits matter more than choosing a visually flattering chart. Total 60 minutes.')
write_train(t2,2)

d3<-rdoc() |> rt('Question the analyst',3) |>
  rp('Read the note, choose useful questions and record which answers would justify a recommendation. Make your opening and closing decisions independently.') |> rf() |>
  rh('The note offered for sign off') |> rp(qa_note,14) |>
  rp('My opening decision   Sign off / With conditions / Request evidence') |> rp('My reason') |> rl(1) |>
  body_add_flextable(rtable(method_rows,c(2.2,1.7,2.4))) |>
  rh('Choose three questions and request evidence')
for(i in seq_along(read_questions))d3<-d3 |> rp(paste(i,read_questions[i]),12,after=4)
d3<-d3 |> rp('My top question and the evidence it requests') |> rl(2) |>
  body_add_break() |> rt('Record and assess the answers',3) |>
  rp('Use Supported / Partial / Unanswered. Cite a source or state the evidence still missing.') |>
  body_add_flextable(rtable(data.frame('Question asked'=rep('',3),'Answer and evidence'=rep('',3),Rating=rep('',3),check.names=FALSE),c(1.6,3.5,1.2)) |> height_all(height=.7,part='body')) |>
  rh('The unresolved issue that matters most') |> rp('What would its answer change?') |> rl(2) |>
  rh('My final decision and reason') |> rp('Sign off / With conditions / Request evidence. Give a source-based reason, then compare with your opening choice.') |> rl(2) |>
  rh('Check an illustrative AI review') |>
  rp('"Four independent studies agree. All intervals clear the rule. No businesses are missing, so data quality is established."',14) |>
  rp('Cross out unsupported claims. Use the source to repair the conclusion.') |> rl(1) |>
  rh('My independent request to the evaluator') |> rp('Name specific evidence and explain its purpose. No AI.') |> rl(1)
write_part(d3,3)
t3<-d3
for(page in 1:2){
  t3<-t3 |> body_add_break() |> rt(paste('Analyst answer bank',page),3) |>
    rp('Trainer only. Answer from this bank or say evidence is not supplied. Do not invent fieldwork, earlier trends or checks. Participants may ask in any order.',10)
  for(i in ((page-1)*4+1):(page*4))t3<-t3 |> rh(answer_bank$Question[i]) |> rp(answer_bank$Answer[i])
}
t3<-t3 |> body_add_break() |> rt('Trainer key for the analyst clinic',3) |>
  rp('Participant pages 1 and 2 double-sided per person. Pages 3 and 4 are the analyst bank; this page is trainer only. The separate shortened QA checklist is an optional desk reference.',10) |>
  rh('Source and answer quality') |> rp('Results share day3_case.R. Pilot OLS interval; city DiD business-clustered interval; RDD robust HC2; matching reported business-clustered interval treating chosen matches as given. Data are synthetic. Complete generated rows do not establish real recruitment, reliable measurement or representative follow-up.') |>
  rp('Supported: stated lottery comparison and its interval; score rule and disclosed age jump. Partial: a point estimate without its interval or a credible assumption. Unanswered: real fieldwork quality, earlier trends or score manipulation evidence. Recognise transparent disclosure as a strength while distinguishing it from resolving the concern.') |>
  rh('Clinic and demonstration') |> rp('One question per group, with a short follow-up, in fourteen minutes. Keep the answer bank visible only to the trainer. Produce the pilot interval once to answer the saving-rule question; other answers use printed evidence. No old neighbourhood lab or repeated live analyses. Protect the five-minute break. Total 75 minutes.') |>
  rh('Sign off and AI') |> rp('The note selects the pilot point estimate and overclaims agreement and approval. City methods share records and describe different comparisons. Two intervals span the rule and two fall short. Repair the AI claim of independent confirmations and of established data quality. Assess the individual evidence request, not a change in room votes alone.')
write_train(t3,3)
q<-rdoc() |> rt('Questions to ask an evaluator',3) |>
  rp('Choose the questions that could change your decision. Request specific evidence and explain how you would use the answer.') |> rf()
for(i in seq_along(read_questions))q<-q |> rh(paste(i,read_questions[i])) |> rp('Evidence I would request') |> rl(1)
q<-q |> rp('After the answer: Supported / Partial / Unanswered. Give a source, or identify the evidence still missing.',11)
print(q,target='Oct14_session3_qa_checklist.docx')
file.copy('Oct14_session3_qa_checklist.docx',file.path(out_handouts,'Oct14_session3_qa_checklist.docx'),overwrite=TRUE)
message('Day 3 participant sheets, trainer packs, QA reference and ratio board written.')
