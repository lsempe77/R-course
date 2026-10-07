# Approved 60/60/75-minute Day 1. Called by make_session_materials.R.
# Participant copies contain exactly two sides; keys/cards stay in trainer packs.
suppressPackageStartupMessages({library(officer); library(flextable)})
source('day1_case.R', encoding='UTF-8')
reader_day <- 1
source('reader_material_helpers.R')
result_df <- function(trial=FALSE) {
  ci <- if(trial) case$rct_ci else ba_ci
  b <- if(trial) case$rct else case$before_after
  p <- if(trial) summary(case_env$rct_fit)$coefficients['took_part','Pr(>|t|)'] else ba_p
  data.frame('Result row'=if(trial) 'Took part (lottery)' else 'After GreenWaste',
             'Coefficient AED'=fmt(b), '95% interval AED'=paste(fmt(ci[1]),'to',fmt(ci[2])),
             'p-value'=if(p<.001) '< 0.001' else fmt(p,3),check.names=FALSE)
}
write_participant <- function(d,n) print(d,target=file.path(out_handouts,sprintf('Oct12_session%d_handouts.docx',n)))
write_trainer <- function(d,n) print(d,target=sprintf('Oct12_session%d_materials.docx',n))

# Session 2 two-sided participant sheet.
d1 <- rdoc() |> rt('Question a claim',2) |>
  rp('Read the claim, make a provisional decision and write the question you would ask before acting.') |>
  rf() |> rh('1 Read alone first') |>
  rp(sprintf('\"Landfill waste from businesses in GreenWaste fell %s%% in a year.\"',fmt(landfill_fall)),14,TRUE) |>
  rp('My decision   [  ] Extend   [  ] Do not extend   [  ] Ask first') |>
  rp('My reason') |> rl(2) |> rp('My question for the evaluator') |> rl(2) |>
  rh('2 What could an average hide') |>
  rp('Landfill before GreenWaste, tonnes per year, for ten businesses') |>
  body_add_flextable(rtable(data.frame(t(ten$landfill_before),check.names=FALSE),rep(.68,10)) |> delete_part('header')) |>
  rp('Circle the business that would most affect the mean. Would the mean describe most of these businesses? Why?') |> rl(2) |>
  body_add_break() |> rt('Triage four claims',2) |>
  rp('Read your group\'s four cards. For each, choose a decision and explain the evidence you still need.') |>
  rp('Decisions: Act / Ask first / Do not act. Questions: Compared to what? / How big? / How sure?')
for(i in 1:4) d1 <- d1 |> rh(paste('Card',i)) |> rp('Decision __________________   Missing question __________________') |>
  rp('My reason or question for the evaluator') |> rl(1)
d1 <- d1 |> rh('My next question from memory') |> rp('Turn the cards over. Write one useful question and why its answer matters.') |> rl(2)
write_participant(d1,2)
t1 <- d1 |> body_add_break() |> rt('Four claim cards',2) |>
  rp('Trainer print instruction: one copy of this page per group. Cut into four slips. Do not give the key to participants.',10) |> rf()
for(i in 1:4) t1 <- t1 |> rh(paste('Card',i)) |> rp(claims[i],14) |>
  rp('What does this claim leave unanswered?',11,after=18)
t1 <- t1 |> body_add_break() |> rt('Trainer key for questioning claims',2) |>
  rp('Print the first two pages double-sided, one per participant. Print page 3 once per group. This page is trainer only.',10) |>
  rh('Entry and comparison') |>
  rp(sprintf('No single opening choice is compulsory. Look for a reason and a concrete missing-evidence question. Landfill among participants fell from %s to %s tonnes; among others from %s to %s. Other changes are possible. This comparison alone does not establish causality.',fmt(landfill[1],1),fmt(landfill[2],1),fmt(landfill[3],1),fmt(landfill[4],1))) |>
  rh('Mean') |> rp(sprintf('Mean %s tonnes. Nine businesses are below it. The largest business is %s tonnes. Accept a request for the distribution or results for different business sizes.',fmt(mean(ten$landfill_before),1),fmt(max(ten$landfill_before)))) |>
  rh('Four claims') |> rp('1: compared to what / ask first. 2: how big / ask first; landfill does not answer the cost rule, and the word \"effect\" needs a credible comparison. 3: do not act on the nationwide recommendation; significance alone does not support it. 4: how sure / ask first. Other justified missing questions are acceptable.') |>
  rh('Wall and phone options') |> rp('Keep Fiona\'s existing Oct12_session2_board_A1.pdf: optional, one A1 landscape print. Give each group a different marker colour and write the four card numbers in the grid. Groups must explain disagreements. Do not restore the reverted AI wall boards.') |>
  rp('Room voting: start room_poll.py, open the private facilitator URL, then use Before and After phases. Close voting before showing totals. Ask which evidence changed a reason. If phones cannot reach the server, use three labelled cards or a show of hands.') |>
  rh('AI check and close') |> rp('The authored AI sentence \"GreenWaste caused the entire fall\" is unsupported. A useful AI prompt asks it to identify missing comparison evidence before concluding. Participants verify against the source. Close with an individual question and reason, without AI.')
write_trainer(t1,2)

# Session 1 five essential terms and a regression-table reading task.
d2 <- rdoc() |> rt('Read a regression table',1) |>
  rp('Read the five terms in the slides, then use this table to state what the report supports.') |> rf() |>
  rh('1 Mean') |> rp('Ten selected businesses sent 3, 4, 5, 5, 6, 7, 7, 8, 9 and 46 tonnes to landfill in one year.',11) |>
  rp('Find the mean. Explain why it does not describe every business.') |> rl(2) |>
  rh('Annual waste cost regression') |>
  rp('The same city participants before and 12 months later. Outcome: annual waste cost in AED per business. The starting mean and the change are different rows.',11) |>
  body_add_flextable(rtable(regression_df(),c(1.8,1.3,2.15,1.55))) |>
  rh('2 Coefficient') |> rp('Circle the change row. Write its number, units and meaning of the sign.') |> rl(2) |>
  body_add_break() |> rt('Explain what the table supports',1) |>
  rh('3 Treatment effect') |> rp('Does the after/before change establish what GreenWaste caused? Explain the missing comparison.') |> rl(2) |>
  rh('4 Confidence interval') |> rp('Box the interval for the change. What does it describe? Does it show the range for individual businesses?') |> rl(2) |>
  rh('5 P value') |> rp('Find the change row p-value. Does it give the probability that GreenWaste works or establish cause?') |> rl(2) |>
  rh('6 Read and repair') |>
  rp('The course rule is at least 1,000 AED annual saving per business. Repair this claim: The tiny p-value proves GreenWaste caused enough saving to expand.',11) |> rl(2) |>
  rh('My independent reading and next question') |>
  rp('State the change, its interval and comparison. Ask for evidence needed before calling it a programme effect.') |> rl(2)
write_participant(d2,1)
t2 <- d2 |> body_add_break() |> rt('Trainer key for the five terms',1) |>
  rp('Print participant pages 1 and 2 double-sided. These key pages are trainer only.',10) |>
  rh('Mean') |> rp('100 tonnes divided by 10 businesses = 10 tonnes. Nine of these selected records are below the mean; one is 46. It is not the value for every business and this teaching selection is not representative of the city.') |>
  rh('Coefficient') |> rp(sprintf('Before GreenWaste is the starting mean, %s AED. After minus before is the change, %s AED. Negative means lower annual costs, not automatically a harmful outcome. A coefficient is a named model result, not automatically a treatment effect.',fmt(ba_mean['before']),fmt(case$before_after))) |>
  rh('Treatment effect') |> rp('The change caused by the programme, relative to what would have happened without it. A before/after change can include other changes over time. Ask for a credible no-programme comparison.') |>
  rh('Confidence interval') |> rp(sprintf('For the change: %s to %s AED. It describes uncertainty around the model estimate under its assumptions, not the spread of individual savings. It does not cover all bias or establish cause. Do not give a 95%% probability interpretation for this fixed interval.',fmt(ba_ci[1]),fmt(ba_ci[2]))) |>
  rh('P value') |> rp('Less than 0.001 for the change. Evidence against the tested no-change model under its assumptions, not the probability that the programme works or that the result is due to chance. It establishes neither cause nor a large enough saving; a non-significant result also does not prove no effect.') |>
  body_add_break() |> rt('Trainer feedback and delivery',1) |>
  rh('Decision rule and source repair') |> rp('The observed saving and its interval are below the invented 1,000 AED rule. Keep the reported fall; remove causal assurance and the assertion that the minimum saving is met. This is not evidence that the programme has no effect.') |>
  rh('Independent reading') |> rp('Require named row, signed coefficient, units, interval and comparison. Accept accurate plain language for all five terms. Collect one independent answer and question. Give brief feedback for any missed term in Session 2.') |>
  rh('Delivery') |> rp('60 minutes. Open with the GreenWaste picture card and the Module 1 theory of change (6 minutes). Participants decide what the minus sign means; a short trainer calculation then reproduces -669 AED. No participant coding. Protect ten minutes for individual reading, paired source check and feedback. Printed results are the fallback.') |>
  rh('Source') |> rp('The actual regression stacks each participant business twice and clusters by business using estimatr::lm_robust with se_type = stata. The intercept is the starting mean and the after coefficient is mean change. Means are rounded for display; do not subtract displayed values to audit the unrounded coefficient. Standard error and sample size can be pointed out if a report uses them, but they are not a replacement for the five core terms.')
write_trainer(t2,1)

# Session 3 trial reading and a short decision note.
d3 <- rdoc() |> rt('Judge a fair comparison',3) |>
  rp('Use the pilot trial result to write a provisional recommendation. Explain what it supports and what it leaves uncertain.') |>
  rf() |> rh('The pilot trial') |>
  rp(sprintf('In one district, a lottery assigned %s businesses to join or wait. About half joined. The trial compared their annual waste costs 12 months later.',fmt(nrow(pilot)))) |>
  body_add_flextable(rtable(result_df(TRUE),c(1.9,1.25,2.25,1.4))) |>
  rp(sprintf('Decision rule: annual saving of at least %s AED per business. Negative means lower costs.',fmt(decision_rule))) |>
  rh('1 Name the comparison') |> rl(2) |>
  rh('2 Read the estimate and interval') |> rp('State the saving and explain whether it settles the decision rule.') |> rl(3) |>
  rh('3 How far does this result reach') |> rp('What would you need to know before using this pilot result for the whole city?') |> rl(2) |>
  body_add_break() |> rt('Write a decision note',3) |>
  rp('Write three or four sentences with a partner. Give the result and its comparison, a provisional recommendation, and the evidence you still need.') |> rl(5) |>
  rh('Check an illustrative AI draft') |>
  rp(sprintf('\"The pilot trial estimated an annual saving of %s AED per business. The trial proves the minimum saving is met. Nationwide rollout is good value for money.\"',fmt(abs(case$rct))),14) |>
  rp('Mark each unsupported conclusion. Rewrite it using the result sheet.') |> rl(3) |>
  rh('Your question from memory') |> rp('Close Sheet 1. What would you ask the evaluator, and how could the answer change your recommendation? Work alone.') |> rl(2)
write_participant(d3,3)
t3 <- d3 |> body_add_break() |> rt('Trainer key for a fair comparison',3) |>
  rp('Print pages 1 and 2 double-sided, one per participant. This page is trainer only.',10) |>
  rh('Trial interpretation') |>
  rp(sprintf('Estimated saving %s AED, 95%% interval %s to %s. Randomly assigned pilot groups, compared after 12 months. The interval spans the %s AED rule. Evidence of saving is different from certainty about reaching that rule. The district may differ from other places; programme costs are not supplied.',fmt(abs(case$rct)),fmt(sort(abs(case$rct_ci))[1]),fmt(sort(abs(case$rct_ci))[2]),fmt(decision_rule))) |>
  rp('The canonical pilot result uses lm(cost_after ~ took_part) and its ordinary least-squares interval in greenwaste_case.R. Assignment equals participation in this fictional pilot. In a real trial ask about follow-up, take-up, contamination and whether assignment stayed random.') |>
  rh('Lottery demonstration and paper fallback') |> rp('Only one short trainer demo, two draws. It redraws ten places among the first twenty pilot businesses and compares pre-programme manager ages. It demonstrates chance balance, not a new effect estimate. The groups need not be perfectly alike in any one draw.') |>
  rp(paste('Ages for twenty numbered slips:',paste(pilot$manager_age[1:20],collapse=', '))) |>
  rh('Note and AI feedback') |> rp('Accept differing provisional decisions with evidence and clear limits. The AI draft\'s first sentence is supported; the threshold and nationwide value-for-money conclusions are unsupported. Require source evidence for every claim. Finish individually with a useful evaluator question and its purpose.') |>
  rh('Delivery') |> rp('Protect the five-minute break and ten-minute paired writing task. Keep the full lab and extra sample-size simulations out of the teaching route. Total 75 minutes.')
write_trainer(t3,3)
message('Day 1: three two-sided participant sheets and three trainer packs written.')
