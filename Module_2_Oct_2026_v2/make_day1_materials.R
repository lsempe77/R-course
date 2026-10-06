# Approved 60/60/75-minute Day 1. Called by make_session_materials.R.
# Participant copies contain exactly two sides; keys/cards stay in trainer packs.
suppressPackageStartupMessages({library(officer); library(flextable)})
source('day1_case.R', encoding='UTF-8')
out_handouts <- '../docs/handouts'
dir.create(out_handouts, recursive = TRUE, showWarnings = FALSE)
set_flextable_defaults(font.family = 'Arial', font.size = 12, padding = 7,
                       border.color = '#D9D9D9')
rdoc <- function() {
  read_docx('reader_template.docx') |> body_set_default_section(prop_section(
    page_size=page_size(width=8.27,height=11.69),
    page_margins=page_mar(top=.65,bottom=.65,left=.7,right=.7)))
}
rp <- function(d, text, size=12, bold=FALSE, colour='black', after=8) {
  body_add_fpar(d, fpar(ftext(text, fp_text(font.family='Arial',font.size=size,bold=bold,color=colour)),
                       fp_p=fp_par(padding.bottom=after)))
}
rt <- function(d, title, session) {
  d <- rp(d, paste('GreenWaste reading workshop | Day 1 | Session', session), 10, colour='#545860',after=3)
  body_add_fpar(d, fpar(ftext(title,fp_text(font.family='Arial',font.size=22,bold=TRUE,color='black'))), style='Title')
}
rh <- function(d, text) rp(d,text,14,TRUE,after=6)
rl <- function(d, n=2) {for (i in seq_len(n)) d <- rp(d,strrep('_',55),12,colour='#B5BEC9',after=12); d}
rf <- function(d) rp(d,'Fictional GreenWaste case | invented figures',9,colour='#545860',after=8)
rtable <- function(df, widths) {
  ft <- flextable(df) |> fontsize(size=12,part='all') |> font(fontname='Arial',part='all') |>
    bg(bg='#063360',part='header') |> color(color='white',part='header') |> bold(part='header') |>
    border_remove() |> border_outer(border=fp_border(color='#D9D9D9',width=.75)) |>
    border_inner(border=fp_border(color='#D9D9D9',width=.75)) |>
    width(width=widths) |> padding(padding=7,part='all') |> valign(valign='center',part='all') |>
    align(align='left',part='all') |> set_table_properties(layout='fixed',align='left')
  if (nrow(df)>1) ft <- bg(ft,i=seq(2,nrow(df),2),bg='#F1F5F9',part='body')
  ft
}
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

# Session 1 two-sided participant sheet.
d1 <- rdoc() |> rt('Question a claim',1) |>
  rp('Read the claim, make a provisional decision and write the question you would ask before acting.') |>
  rf() |> rh('1 Read alone first') |>
  rp(sprintf('\"Landfill waste from businesses in GreenWaste fell %s%% in a year.\"',fmt(landfill_fall)),14,TRUE) |>
  rp('My decision   [  ] Extend   [  ] Do not extend   [  ] Ask first') |>
  rp('My reason') |> rl(2) |> rp('My question for the evaluator') |> rl(2) |>
  rh('2 What could an average hide') |>
  rp('Landfill before GreenWaste, tonnes per year, for ten businesses') |>
  body_add_flextable(rtable(data.frame(t(ten$landfill_before),check.names=FALSE),rep(.68,10)) |> delete_part('header')) |>
  rp('Circle the business that would most affect the mean. Would the mean describe most of these businesses? Why?') |> rl(2) |>
  body_add_break() |> rt('Triage four claims',1) |>
  rp('Read your group\'s four cards. For each, choose a decision and explain the evidence you still need.') |>
  rp('Decisions: Act / Ask first / Do not act. Questions: Compared to what? / How big? / How sure?')
for(i in 1:4) d1 <- d1 |> rh(paste('Card',i)) |> rp('Decision __________________   Missing question __________________') |>
  rp('My reason or question for the evaluator') |> rl(1)
d1 <- d1 |> rh('My next question from memory') |> rp('Turn the cards over. Write one useful question and why its answer matters.') |> rl(2)
write_participant(d1,1)
t1 <- d1 |> body_add_break() |> rt('Four claim cards',1) |>
  rp('Trainer print instruction: one copy of this page per group. Cut into four slips. Do not give the key to participants.',10) |> rf()
for(i in 1:4) t1 <- t1 |> rh(paste('Card',i)) |> rp(claims[i],14) |>
  rp('What does this claim leave unanswered?',11,after=18)
t1 <- t1 |> body_add_break() |> rt('Trainer key for questioning claims',1) |>
  rp('Print the first two pages double-sided, one per participant. Print page 3 once per group. This page is trainer only.',10) |>
  rh('Entry and comparison') |>
  rp(sprintf('No single opening choice is compulsory. Look for a reason and a concrete missing-evidence question. Landfill among participants fell from %s to %s tonnes; among others from %s to %s. Other changes are possible. This comparison alone does not establish causality.',fmt(landfill[1],1),fmt(landfill[2],1),fmt(landfill[3],1),fmt(landfill[4],1))) |>
  rh('Mean') |> rp(sprintf('Mean %s tonnes. Nine businesses are below it. The largest business is %s tonnes. Accept a request for the distribution or results for different business sizes.',fmt(mean(ten$landfill_before),1),fmt(max(ten$landfill_before)))) |>
  rh('Four claims') |> rp('1: compared to what / ask first. 2: how big / ask first; landfill does not answer the cost rule, and the word \"effect\" needs a credible comparison. 3: do not act on the nationwide recommendation; significance alone does not support it. 4: how sure / ask first. Other justified missing questions are acceptable.') |>
  rh('Wall and phone options') |> rp('Keep Fiona\'s existing Oct12_session1_board_A1.pdf: optional, one A1 landscape print. Give each group a different marker colour and write the four card numbers in the grid. Groups must explain disagreements. Do not restore the reverted AI wall boards.') |>
  rp('Room voting: start room_poll.py, open the private facilitator URL, then use Before and After phases. Close voting before showing totals. Ask which evidence changed a reason. If phones cannot reach the server, use three labelled cards or a show of hands.') |>
  rh('AI check and close') |> rp('The authored AI sentence \"GreenWaste caused the entire fall\" is unsupported. A useful AI prompt asks it to identify missing comparison evidence before concluding. Participants verify against the source. Close with an individual question and reason, without AI.')
write_trainer(t1,1)

# Session 2 one extract, one annotated reading task.
d2 <- rdoc() |> rt('Read a reported result',2) |>
  rp('Read the extract. Circle the estimate, box its interval and underline the comparison. Use these to write a careful decision sentence.') |>
  rf() |> rh('The decision rule') |>
  rp(sprintf('At least %s AED annual saving per business, measured 12 months later. This is an invented course rule; it is not a full value-for-money test.',fmt(decision_rule))) |>
  rh('The report extract') |>
  rp('City businesses that took part: the same businesses before and 12 months after. Outcome: annual waste cost, AED per business.') |>
  body_add_flextable(rtable(result_df(),c(1.9,1.25,2.25,1.4))) |>
  rp('Negative means lower costs. Coefficient means the number beside the named result row. The confidence interval describes statistical uncertainty; it does not cover every source of bias.',11) |>
  rh('1 What does the result say') |> rp('Write the change with its units, group and period.') |> rl(2) |>
  rh('2 Does the reported change meet the rule') |> rp('Explain using the estimate and interval.') |> rl(2) |>
  body_add_break() |> rt('Check the conclusion',2) |>
  rh('3 What does this comparison leave unanswered') |> rp('What could have changed costs without GreenWaste? What would you ask the evaluator?') |> rl(3) |>
  rh('4 Repair this illustrative AI summary') |>
  rp(sprintf('\"City participants\' annual costs fell by %s AED. GreenWaste caused that saving, so scale-up is justified.\"',fmt(abs(case$before_after))),14) |>
  rp('Underline what the extract supports. Cross out what it does not support. Rewrite the conclusion using the source.') |> rl(3) |>
  rh('5 Your decision sentence') |> rp('State the result, one limit and your next question. Work alone before comparing with a partner.') |> rl(3) |>
  rp('A small p-value does not establish cause or a large enough saving. A non-significant result does not prove there is no effect.',11)
write_participant(d2,2)
t2 <- d2 |> body_add_break() |> rt('Trainer key for reading a result',2) |>
  rp('Print pages 1 and 2 double-sided, one per participant. This page is trainer only.',10) |>
  rh('Source and answer') |>
  rp(sprintf('Change %s AED; 95%% interval %s to %s. Annual cost for city participants, after minus before, measured 12 months later. Both the estimate and interval imply a saving below the %s AED rule. The result does not isolate what GreenWaste caused.',fmt(case$before_after),fmt(ba_ci[1]),fmt(ba_ci[2]),fmt(decision_rule))) |>
  rp('The printed regression stacks each business twice and clusters standard errors by business using estimatr::lm_robust with se_type = stata. The trainer\'s short live arithmetic reproduces its coefficient. Displayed means are rounded; subtracting them can differ by one AED.') |>
  rh('Feedback') |> rp('Insist on comparison, units and period. Negative here means lower costs. The interval concerns the reported change, not individual business outcomes. Its precision does not solve causal bias. Statistical significance concerns a no-change model and its assumptions; it is not a probability that the programme works.') |>
  rh('AI and independent close') |> rp('Keep the descriptive fall; remove the causal and scale-up conclusion. Example: the observed fall is below the rule, but this comparison cannot isolate the programme\'s effect. Ask for a credible estimate of what happened without GreenWaste. Review source evidence yourselves, even if a second AI agrees.') |>
  rh('Delivery') |> rp('One trainer-run calculation only. Predict its sign before Run. If webR cannot load, use the printed result. Protect ten minutes for individual mark-up, pair comparison and feedback. Total 60 minutes.')
write_trainer(t2,2)

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
