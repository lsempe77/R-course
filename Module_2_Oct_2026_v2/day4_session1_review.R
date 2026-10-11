source('day4_case.R', encoding='UTF-8')

d10_sections <- list(
  list(title='1 Executive summary',paragraphs=c(
    'The authority is considering national expansion of GreenWaste, which subsidises waste-management technology and support for businesses. The decision rule is a reduction in annual waste cost of at least 1,000 AED per business. This report brings together a district pilot and three city analyses, and considers whether their results justify expansion and programme spending.',
    sprintf('We select the city matched comparison as the headline: %s AED annual saving per business. The table in Section 5 also reports the pilot lottery, city extra change and local score-cutoff estimates. All four show reductions. Their agreement provides four independent confirmations of programme effectiveness, and the headline exceeds the authority\'s minimum-saving rule.',fmt(-match_A$est)),
    sprintf('Recorded mean annual costs among city participants fell by %s AED. We interpret this average fall as a saving achieved by each participating business. The provisional benefit-cost model gives %.2f under its stated inputs. We therefore recommend national expansion with routine implementation monitoring, rather than waiting for further evidence on the saving rule or costs.',fmt(-case$before_after),ratio()))),
  list(title='2 The programme and outcome',paragraphs=c(
    'GreenWaste supplies subsidised waste-management technology and support intended to reduce businesses\' waste costs. In a separate pilot district, 400 businesses with scores at or below 58 entered a lottery: 200 were assigned to join and 200 to wait. The pilot analysis compares their costs after 12 months. In the city file, businesses scoring at or below 58 took part; businesses above 58 did not.',
    'The outcome is recorded annual waste cost, measured in AED per business before the programme and 12 months after. A positive saving in Table T10 means a reduction in that cost. The pilot describes one district; the city analyses use a different population. The minimum annual-saving rule of 1,000 AED is separate from the question of whether benefits exceed all programme costs.')),
  list(title='3 Evaluation design',paragraphs=c(
    'Pilot lottery: compare annual costs at 12 months for businesses assigned to join and businesses assigned to wait. Lottery assignment reduces systematic starting differences between the groups, making this a stronger comparison than participants before and after alone. Its credibility still depends on the assignment and outcome follow-up; its reach is the pilot district.',
    'City extra change, or difference-in-differences: subtract the nonparticipant cost change from the participant cost change. We regard this as the preferred city analysis. A causal interpretation requires that, without support, both groups would have changed similarly. Since they operate in the same city and face common economic conditions, we consider that requirement satisfied without an earlier cost series.',
    sprintf('Score cutoff, or regression discontinuity: fit a cost jump at score 58 using %s businesses within two score points on either side. The result is local. Attribution requires expected outcomes without support to vary smoothly across the rule, with no sorting or other relevant discontinuity. The reported interval uses HC2 robust uncertainty.',fmt(nrow(near))),
    'Matched comparison: pair city participants with nonparticipants on standardised pre-programme manager age, staff, area and filtration. Area is recorded in units of 100 square metres. Controls may be reused. This comparison requires adequate comparable controls and no remaining outcome-relevant selection after conditioning on these features. It cannot remove unrecorded differences. The three city analyses reuse the same file.')),
  list(title='4 Data and measurement',paragraphs=c(
    sprintf('The supplied synthetic file contains 400 pilot businesses and 10,000 city businesses, with one complete row per business. The city includes %s participants and %s nonparticipants. Each has one before measure and a measure at 12 months. These counts describe the generated training data; no separate national sample is supplied.',fmt(sum(took)),fmt(sum(!took))),
    'Annual cost cells are complete in the generated file. We take this as sufficient assurance that measurement is reliable and follow-up is complete in practice. Fieldwork records, recruitment logs, reasons for unavailable outcomes and measurement-validation documents are not included in the supplied evidence. We have therefore not presented those records in this report.')),
  list(title='5 Results',paragraphs=c(
    'Table T10 reports estimated annual savings on a positive scale, with 95% confidence intervals under each analysis and its assumptions. An interval describes sampling uncertainty; it does not include every possible source of bias. Results concern the stated populations and comparisons. Values are rounded for reading; the calculations use unrounded data.',
    sprintf('The matched estimate of %s AED is the largest point estimate and is therefore selected for the headline. We use that point estimate, rather than the interval, to conclude that the minimum-saving rule is met. The pilot estimate is %s AED and the preferred city extra-change estimate is %s AED. All four intervals lie above zero; we read this as strong agreement on reductions.',fmt(-match_A$est),fmt(-case$rct),fmt(-case$did)),
    sprintf('For a separate descriptive check, recorded participant mean annual costs were %s AED before and %s AED at 12 months, a mean fall of %s AED among the same %s city participants. This is not the extra-change comparison with nonparticipants. The city results share records and compare different groups or local populations; the pilot is a separate district sample.',fmt(ba_mean[1]),fmt(ba_mean[2]),fmt(-case$before_after),fmt(nrow(tp))))),
  list(title='6 Limitations and model inputs',paragraphs=c(
    'The city file has only one before measure, so earlier trends cannot be checked here. The pilot is from one district; the cutoff estimate concerns businesses close to score 58. No evidence establishing transfer to the intended national population or delivery conditions is supplied. These limits matter when deciding how far the results can guide expansion.',
    sprintf('A pre-programme manager-age diagnostic finds a jump of about %s years in a five-point window around the cutoff, with younger managers below it. No score-manipulation audit is supplied. Matching uses %s distinct controls, one reused %s times; a mean age gap of %s years remains. No full distance/support assessment or real fieldwork documentation is supplied.',fmt(abs(case$age_jump),1),fmt(match_A$used),fmt(match_A$max_reuse),fmt(match_A$age_gap,1)),
    sprintf('The limited economic model provisionally uses the city extra-change saving of %s AED. It assumes %s AED one-off cost at year 0, no benefit in year 1, five equal saving years in years 2-6 and a 5%% discount rate. Its ratio is %.2f. Costs, timing and duration are fictional assumptions, not measured programme facts. The mixed-actor boundary is not a complete government-budget or social appraisal.',fmt(model$saving),fmt(model$cost),ratio()))),
  list(title='7 Conclusions and recommendations',paragraphs=c(
    'Approve national expansion with the current eligibility rule, phased through the next delivery cycle. The four confirmations and a headline above 1,000 AED provide sufficient assurance that the programme will achieve the minimum saving nationally. Routine monitoring can address the limitations without delaying approval.',
    'Approve the associated programme budget because the benefit-cost ratio exceeds 1. We acknowledge the model assumptions, but the favourable ratio is sufficient for this spending decision. Further evidence on full costs, persistence of savings and national delivery conditions is not needed before approval.'))
)
d10_section_html <- function(i) {
  paragraphs <- vapply(seq_along(d10_sections[[i]]$paragraphs),function(j)paste0(
    '<p id="R',i,'.',j,'"><strong>R',i,'.',j,'.</strong> ',
    d10_sections[[i]]$paragraphs[j],'</p>'),'')
  body <- if(i==5) paste0(paragraphs[1],
    '<h4 id="T10">Table T10: annual saving per business, AED</h4>',
    d10_results_table(),paste(paragraphs[-1],collapse='')) else
    paste(paragraphs,collapse='')
  paste0('<section class="report-section" id="R',i,'"><h3>',
    d10_sections[[i]]$title,'</h3>',body,'</section>')
}
d10_results_table <- function() html_table(method_rows)
d10_rating_example <- 'R2.2: "The outcome is recorded annual waste cost, measured in AED per business before the programme and 12 months after."'
d10_allocations <- c(3,4,5,6,7,3,5,7)
d10_section_key <- data.frame(
  Section=c(1,3,4,5,6,7),
  'A supported passage'=c(
    'R1.1: names the decision, outcome and minimum-saving rule.',
    'R3.1/R3.3/R3.4: comparisons, local reach and matching requirements.',
    'R4.1: counts, timing and synthetic-data scope.',
    'R5.1 / T10: estimates and intervals; uncertainty is conditional.',
    'R6.1-R6.3: genuine limits and assumed model inputs.',
    'R7.1: a concrete proposed action is identifiable.'),
  'A concern or unsupported claim'=c(
    'R1.2: independent confirmations and settled minimum. R1.3: mean fall as each business saving.',
    'R3.2: common location does not establish parallel untreated change.',
    'R4.2: complete generated cells do not establish real measurement/follow-up.',
    'R5.2: selecting the largest point estimate does not settle the minimum.',
    'No planted error is required here. Disclosure does not resolve the limits or justify R7.',
    'R7.1/R7.2: national assurance and sufficient budget evidence outrun the stated sources.'),
  'Evidence or follow-up'=c(
    'T10/R5.3/R6: shared records, interval crossing, individual changes and reach.',
    'R6.1: one before measure. Request earlier trends and concurrent-change records.',
    'R4.2/R6.2: request recruitment, follow-up and measurement-validation documents.',
    'T10: pilot/matching span 1,000; DiD/RDD lie below it. Request rationale for the preferred analysis.',
    'Request the evidence relevant to the decision; accept Supported for a correct disclosure.',
    'R6.1/R6.3: request target-population/delivery comparisons and full costs/persistence.'),
  check.names=FALSE)
d10_retry <- data.frame(
  Ability=assessment_criteria,
  Task=c(
    'Use R2.1-R2.2 and T10. Name the pilot outcome, units, timing and population.',
    'Use R2.1/R3.1. Name both pilot groups and explain why lottery helps; add one limitation.',
    'Use T10. Explain what the pilot estimate and interval imply for zero and for the 1,000 rule.',
    'Use one precise report paragraph. Identify its consequential concern and a source that supports your judgement.',
    'Use R6 and your concern. Give a bounded action and a document/result request that could change it.'),
  Check=c(
    'Annual waste-cost reduction, AED per business, at 12 months; 400 businesses in one pilot district.',
    '200 assigned to join vs 200 to wait. Lottery reduces systematic starting selection; credible follow-up/reach still matter.',
    'Saving 1,014, interval 862-1,167: above zero, spans 1,000. Neither no reduction nor a settled minimum.',
    'Accept different concerns with precise citation and consequence; no blanket fault finding.',
    'Accept defensible alternatives. Require population/causal/economic limits and a specific request with purpose.'),
  stringsAsFactors=FALSE)
d10_optional_ai <- paste(
  'The report usefully states its outcome, compares several designs and reports uncertainty.',
  'The pilot is district-specific, and Section 6 openly describes untested trends, cutoff balance and assumed costs.',
  'City methods share records, so they should not be called independent replications.',
  'Nevertheless, the matched point estimate exceeds 1,000 and all intervals exclude zero;',
  'these results make the national minimum-saving and budget recommendations defensible with routine monitoring.',
  'The report can be signed with an implementation-monitoring condition.')
