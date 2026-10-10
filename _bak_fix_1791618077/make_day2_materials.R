# Approved Day 2. Two sides per participant; cards and answers stay separate.
suppressPackageStartupMessages({library(officer);library(flextable)})
source('day2_case.R',encoding='UTF-8')
reader_day <- 2
source('reader_material_helpers.R')
write_part <- function(d,n) print(d,target=file.path(out_handouts,sprintf('Oct13_session%d_handouts.docx',n)))
write_train <- function(d,n) print(d,target=sprintf('Oct13_session%d_materials.docx',n))
res_table <- function(method) rtable(report_row(method),c(2.6,1.5,2.2))
rule_text <- sprintf('Decision rule: at least %s AED annual saving per business after 12 months. Negative means lower costs. This fictional rule is not a full value-for-money test.',fmt(decision_rule))

d1 <- rdoc() |> rt('Read the extra change',1) |>
  rp('Compare changes in two groups, then decide what evidence you need before accepting the result as an effect.') |> rf() |>
  rh('1 Complete the four numbers') |>
  body_add_flextable(rtable(data.frame(Group=c('Took part','Did not take part'),
    'Before AED'=fmt(means[c(1,3)]),'After AED'=fmt(means[c(2,4)]),'Change AED'=c('',''),check.names=FALSE),c(2.1,1.4,1.4,1.4))) |>
  rp('Change = after minus before. Extra change = participants\' change minus comparison change. The means are rounded.') |>
  rp('Extra change __________________ AED') |> rl(1) |>
  rh('2 Read the result row') |> body_add_flextable(res_table('did')) |>
  rp(rule_text,11) |> rp('What do the estimate and interval say about the rule?') |> rl(2) |>
  rh('3 Question the assumption') |>
  rp('Without GreenWaste, the groups would have changed in similar ways. Reports call this parallel trends. Name one reason this might fail.') |> rl(2) |>
  body_add_break() |> rt('Check the report conclusion',1) |>
  rh('Report extract') |>
  rp(sprintf('The city study compares annual waste costs before and 12 months after GreenWaste in participants and non-participants. The extra change is %s AED per business, with a 95%% confidence interval of %s to %s AED. A causal interpretation assumes that, without GreenWaste, costs would have changed similarly in the two groups. The file contains only one before measure, so it cannot show whether earlier trends were similar.',fmt(case$did),fmt(did_ci[1]),fmt(did_ci[2]))) |>
  rp('Circle the result and units. Underline the assumption. Write your question and explain how its answer could affect your decision.') |> rl(3) |>
  rh('Repair an illustrative AI draft') |>
  rp('"The extra fall proves GreenWaste caused the saving. Parallel trends is satisfied. Scale-up meets the decision rule."',14) |>
  rp('Cross out unsupported claims and rewrite using the extract.') |> rl(3) |>
  rh('Your question from memory') |> rp('Close Sheet 1. Write one question for the evaluator and its purpose. Work alone.') |> rl(2)
write_part(d1,1)
t1 <- d1 |> body_add_break() |> rt('Trainer key for extra change',1) |>
  rp('Print pages 1 and 2 double-sided, one per participant. This page is trainer only.',10) |>
  rh('Calculation and interpretation') |>
  rp(sprintf('Changes using unrounded means: participants %s AED; comparison %s AED; difference %s AED. Allow a one-AED discrepancy from rounded printed means. The estimate and interval imply less saving than the %s AED rule. Parallel trends is an assumption, not a finding established by this file.',fmt(changes[1]),fmt(changes[2]),fmt(case$did),fmt(decision_rule))) |>
  rh('Source and feedback') |> rp('Printed regression: cost ~ after*took_part on two rows per city business, business-clustered robust standard errors (estimatr, se_type stata). The trainer arithmetic gives the same coefficient. Earlier hypothetical pictures are labelled hypothetical, not extra GreenWaste observations. Different levels can coexist with parallel trends; one before measure cannot check earlier trends.') |>
  rh('Reading and AI') |> rp('Keep the estimated extra fall. Remove proof of cause, a satisfied assumption and the claim that the saving rule is met. Useful next requests include earlier periods, other policies or price changes, and stable group composition. Ask how the evidence could change a decision.') |>
  rh('Delivery') |> rp('One trainer demo after prediction; no participant coding. Use the printed result if webR fails. Protect individual reading and pair discussion. No restored AI wall board. Total 60 minutes.')
write_train(t1,1)

d2 <- rdoc() |> rt('Read the jump at a score rule',2) |>
  rp('Read your group\'s card, compare it with the reported jump and decide what could explain the difference at score 58.') |> rf() |>
  rh('The comparison') |> rp('City businesses scoring 58 or below took part. Those above 58 did not. The report compares businesses close to 58, after 12 months.') |>
  rh('1 Record your group card') |> rp('Card letter ______   Mean at or below 58 ______ AED   Mean above 58 ______ AED') |>
  rp('Jump = at or below 58 minus above 58: __________________ AED') |>
  rp('Write the jump and card letter on a sticky note. Put it on the wall number line. Why do groups disagree?') |> rl(2) |>
  rh('2 Read the reported jump') |> body_add_flextable(res_table('rdd')) |> rp(rule_text,11) |>
  rp(sprintf('The model uses %s businesses within two score points of 58 and allows costs to slope differently on each side. The estimate is for businesses near the line.',fmt(rdd[4]))) |>
  rp('Who does it describe? What does it say about the saving rule?') |> rl(3) |>
  body_add_break() |> rt('Check the jump before acting',2) |>
  rh('Report extract') |>
  rp(sprintf('All city records follow the score rule. Using a five-point window gives a jump of %s AED. Pre-programme manager age also jumps at 58: managers are about %s years younger just below. The extract supplies no check of whether businesses could influence their score.',fmt(case$rdd5[1]),fmt(abs(case$age_jump),1))) |>
  body_add_flextable(rtable(data.frame(Check=c('Rule followed','Nearby comparison','Something else jumps','Who the result describes'),
    'Supported concern or unknown'=rep('',4),'My reason'=rep('',4),check.names=FALSE),c(2,2.2,2.1)) |> height_all(height=.48,part='body')) |>
  rh('Repair an illustrative AI recommendation') |>
  rp('"The score rule proves GreenWaste saves money for every city business. The result justifies extending it to all eligible businesses."',14) |>
  rp('Cross out unsupported claims and rewrite.') |> rl(2) |>
  rh('Your next question') |> rp('What would you ask before accepting the jump as an effect? Explain why it matters.') |> rl(2)
write_part(d2,2)
t2 <- d2
for(k in names(cards)) {
  t2 <- t2 |> body_add_break() |> rt(paste('Jump card',k),2) |>
    rp('Print one different card per group, eight groups A to H. Give calculators and one sticky note. This page is an activity card, not an answer key.',10) |> rf() |>
    rp('Six businesses on each side, within one point of 58. Costs after 12 months, rounded to the nearest 10 AED.') |>
    body_add_flextable(rtable(cards[[k]]$rows,c(1.75,1.35,1.85,1.35))) |>
    rh('Find the means and subtract') |>
    rp('Mean at or below 58 __________________ AED') |> rl(1) |>
    rp('Mean above 58 __________________ AED') |> rl(1) |>
    rp('Jump = first mean minus second mean __________________ AED') |> rl(1) |>
    rp(paste('Write the jump and card letter',k,'on a sticky note. Place it above the wall number line.')) |>
    rp('What would you need before trusting this small sample?') |> rl(2)
}
t2 <- t2 |> body_add_break() |> rt('Trainer key for the jump',2) |>
  rp('Pages 1 and 2: participant copy, double-sided. Pages 3 to 10: cards A to H, one different page per group. This key stays with the trainer.',10) |>
  body_add_flextable(rtable(data.frame(Card=names(cards),'Below AED'=sapply(cards,function(x)fmt(x$below)),
    'Above AED'=sapply(cards,function(x)fmt(x$above)),'Jump AED'=fmt(jumps),check.names=FALSE),c(.7,1.85,1.85,1.9))) |>
  rp(sprintf('Draw a star at %s AED and interval %s to %s below the A1 line. These are model estimates, unlike the raw card mean gaps. Small samples and costs sloping with score explain differing card answers.',fmt(rdd[1]),fmt(rdd_ci[1]),fmt(rdd_ci[2]))) |>
  rp('Print the existing Oct13_session2_board_A1.pdf at A1 landscape. Its -2,000 to +500 AED line, red saving rule and blank lower lane are retained. Use eight different cards, not eight copies of card A.') |>
  body_add_break() |> rt('Trainer checks and delivery',2) |>
  rh('What the short extract supports') |> rp('Rule followed and nearby comparison disclosed. Manager age jumping is a credibility concern, not proof of which cause explains costs. Score manipulation evidence is not supplied. The estimate is local to 58; it does not establish an effect for every eligible business. Both displayed windows give point estimates below the saving rule.') |>
  rh('Source and interval') |> rp('greenwaste_case.R now uses estimatr::lm_robust HC2 for the RDD interval, matching the original teaching model. The short browser lm gives the same coefficient. Do not combine its ordinary interval with the robust interval on paper. No placebo lab, full sweep or sliders in the teaching route.') |>
  rh('AI and close') |> rp('Remove proof of cause, whole-city reach and automatic extension. Ask for investigation of manager age, score setting and support for use beyond the line. End with an individual question and purpose. One prediction-first trainer demo. Total 60 minutes.')
write_train(t2,2)

d3 <- rdoc() |> rt('Read a matched comparison',3) |>
  rp('Choose comparison businesses before opening costs. Then inspect the full report and decide what could still bias the comparison.') |> rf() |>
  rh('1 Record your pairs before opening costs') |>
  body_add_flextable(rtable(data.frame('Took part'=c('A','B','C'),'Chosen twin'=rep('',3),'Difference AED'=rep('',3),check.names=FALSE),c(1.5,1.8,3))) |>
  rp('Pair on manager age and size. Costs arrive afterwards. Difference = participant cost minus twin cost.') |>
  rp('Mean difference __________________ AED   Unused comparison business __________') |>
  rp('These seven profiles are invented for the activity; they are not the full-city records.') |>
  rh('2 Read the full study result') |> body_add_flextable(res_table('match')) |> rp(rule_text,11) |>
  rp(sprintf('Matched on pre-programme manager age, staff, premises area and filtration. %s participants matched to %s different comparison businesses; some were reused.',fmt(sum(took)),fmt(match_A$used))) |>
  rp('What does the interval say about the rule? What would make the pairs convincing?') |> rl(3) |>
  body_add_break() |> rt('Question the matched result',3) |>
  rh('Report extract') |>
  rp(sprintf('The study chooses one nearest comparison for every participant, using the four recorded characteristics. Comparison businesses can be used more than once. No maximum acceptable distance is set, and no participant is excluded. Matched manager ages remain %s years apart on average. Leaving age out changes the estimate to %s AED. Similar recorded features cannot rule out an unmeasured influence on joining and costs.',fmt(match_A$age_gap,1),fmt(match_B$est))) |>
  rp('Circle the result and interval on Sheet 1. Underline what made the pairs similar. Name a missing check and explain why it matters.') |> rl(2) |>
  rh('Your provisional judgement') |> rp('Act / Act with conditions / Request evidence. Write your reason and what could change your decision.') |> rl(2) |>
  rh('Repair an illustrative AI assurance') |>
  rp('"Every participant has a match, so selection bias is removed. The saving guarantees the minimum saving rule is met."',14) |>
  rp('Keep supported facts. Cross out unsupported claims and rewrite.') |> rl(2) |>
  rh('A question from memory') |> rp('Close Sheet 1. Write a question for the evaluator and its purpose. Work alone.') |> rl(1)
write_part(d3,3)
t3 <- d3
# One page per profile gives space for optional walking; outcomes held separately.
for(i in seq_len(nrow(profiles))) {
  p <- profiles[i,]
  t3 <- t3 |> body_add_break() |> rt(paste('Profile',p$id),3) |>
    rp('One set of seven profiles per group. Table version: print two pages per sheet. Walking version: one full-size set for seven volunteers.',10) |> rf() |>
    rp(p$id,72,TRUE,colour='#063360',after=24) |> rp(p$group,24,TRUE,after=20) |>
    rp(paste('Manager age',p$age),22,after=20) |> rp(paste('Business size',p$size),22,after=20) |>
    rp('Recorded before GreenWaste',14) |>
    rp('Choose a comparison using these features. Keep costs closed until the trainer opens them.',14) |>
    rp('Invented activity profile',10)
}
t3 <- t3 |> body_add_break() |> rt('Cost slips to open after matching',3) |>
  rp('Trainer holds this page until pairs are recorded. Cut seven slips, one per profile. Print one set per group. Invented activity costs, AED per year after GreenWaste.',10)
for(i in seq_len(nrow(profiles))) t3 <- t3 |> rh(paste('Business',profiles$id[i])) |>
  rp(paste(fmt(profiles$cost[i]),'AED'),18,TRUE,after=18)
t3 <- t3 |> body_add_break() |> rt('Trainer key for matching',3) |>
  rp('Pages 1 and 2: participant copy, double-sided. Pages 3 to 9: seven profiles. Page 10: cost slips, withheld. This key stays with the trainer.',10) |>
  rh('Activity answers') |> rp('A with 2, B with 1, C with 3. Differences -1,000, -900 and -1,100 AED; mean -1,000. Business 4 is unused. Record pairs before costs are handed out. Optional walking: seven volunteers, eighth group checks. Do not let groups choose pairs from outcome costs.') |>
  rh('Full study is different from the activity') |>
  rp(sprintf('Every one of %s participants has a nearest neighbour, with replacement. %s different controls are used; the most-used control appears %s times. No distance threshold excludes poor matches. Ask for distances, support, reuse and similarity before claiming a fair comparison.',fmt(sum(took)),fmt(match_A$used),fmt(match_A$max_reuse))) |>
  rp(sprintf('Four-feature estimate %s AED; 95%% interval %s to %s. It spans the saving rule. Without age: %s AED; manager-age gap %s years and pre-programme cost gap %s AED. Four-feature age gap remains %s years; do not call balance perfect.',fmt(match_A$est),fmt(match_A$ci[1]),fmt(match_A$ci[2]),fmt(match_B$est),fmt(match_B$age_gap,1),fmt(match_B$base_gap),fmt(match_A$age_gap,1))) |>
  body_add_break() |> rt('Trainer source and feedback',3) |>
  rh('Estimator') |> rp('One nearest neighbour using Euclidean distance on standardised manager age, staff, area and filtration, with replacement. Matching source agrees exactly with greenwaste_case.R. The reported robust interval clusters by original business ID, allowing repeated comparison records. It treats the selected matches as given and does not fully cover uncertainty from choosing matches; it never covers all bias.') |>
  rh('Reading and AI') |> rp('All participants matched is a true fact, not an assurance of no bias. Recorded balance cannot establish absence of unmeasured influences. Ask about weak matches, omitted causes, baseline outcomes and sensitivity. The threshold guarantee is unsupported because the interval crosses the rule.') |>
  rh('Delivery') |> rp('One trainer calculation after prediction, no participant coding. Protect the five-minute break, individual report reading and provisional judgement. Use the printed result if webR fails. Close with an independent evaluator question. Total 75 minutes.')
write_train(t3,3)
message('Day 2: three two-sided participant sheets, three trainer packs with separate activities.')
