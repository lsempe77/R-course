# Day 4 report, corrected findings, rating key and reading assessment.
# Numbers come from the corrected case; report overclaims are planted teaching faults.
source('day3_case.R',encoding='UTF-8')

report_title <- 'GreenWaste evaluation report for review'
report_label <- 'GreenWaste is a fictional training case. This report contains deliberate flaws for review.'
report_sections <- list(
  list(title='1 Executive summary',paragraphs=c(
    'GreenWaste helps businesses reduce annual waste costs. The authority asks whether the evidence supports expansion beyond the pilot district and the city. Its minimum saving rule is 1,000 AED per business per year.',
    sprintf('Our headline is the city matched comparison: a saving of %s AED per business per year. This exceeds the rule. Four independent methods all show lower costs, confirming that GreenWaste caused the saving. The programme therefore meets the standard for nationwide expansion.',fmt(-match_A$est)),
    sprintf('Costs fell by %s AED among city participants. This proves the programme benefited every participating business. The benefit-cost model gives %.2f, which confirms that the programme pays for itself. We recommend approval.',fmt(-case$before_after),ratio()))),
  list(title='2 The programme',paragraphs=c(
    'GreenWaste provides waste-management equipment and support to businesses. In one pilot district, a lottery selected 200 of 400 businesses to join; 200 waited. In the rest of the city, businesses with an efficiency score of 58 or below took part. Those above 58 did not.',
    'The outcome is each business\'s recorded annual waste cost in AED. Each business has one measure before GreenWaste and one 12 months after. A lower annual cost is a saving. The pilot district and city provide different comparisons.')),
  list(title='3 Evaluation design',paragraphs=c(
    'Pilot lottery: compare costs after 12 months for businesses assigned to join and those assigned to wait. Random assignment makes this comparison informative for the pilot district. It does not by itself establish the effect of nationwide expansion.',
    'City extra change, or difference-in-differences: compare the before/after change for city participants with the change for other city businesses. This is our preferred city analysis. It requires that both groups would have changed similarly without GreenWaste. Because both groups are in the same city, that assumption is guaranteed.',
    'Jump near score 58, or regression discontinuity: compare nearby businesses on either side of the rule, within two score points. The result concerns businesses near the cut-off. The approach requires that other relevant factors do not jump at the rule.',
    'Matched comparison: compare city participants with other businesses similar in recorded manager age, staff, area and filtration. Matching cannot remove differences in factors that were not recorded.')),
  list(title='4 Data',paragraphs=c(
    sprintf('The synthetic training file contains 400 pilot businesses and 10,000 city businesses, with one complete row per business. In the city, %s took part and %s did not. Outcomes are annual waste costs before the programme and 12 months after.',fmt(sum(took)),fmt(sum(!took))),
    'There are no empty outcome cells in this generated file. This establishes reliable measurement and complete real-world follow-up. No fieldwork records, recruitment log or measurement validation are supplied.')),
  list(title='5 Results',paragraphs=c(
    'The table reports estimated annual savings as positive amounts. Its 95% confidence intervals show uncertainty under each analysis and its assumptions. They do not include every possible source of bias.',
    'We choose the matched comparison for the headline because its estimate is the largest. We rely on its point estimate to decide that the minimum saving rule is met.',
    sprintf('The pilot point estimate is %s AED. The preferred city extra-change estimate is %s AED. All four point estimates have the same sign, so we regard them as four independent confirmations. The recorded before/after fall among city participants is %s AED; that descriptive fall is separate from the four estimates.',fmt(-case$rct),fmt(-case$did),fmt(-case$before_after)))),
  list(title='6 Limitations',paragraphs=c(
    'There is only one before measure, so earlier city trends cannot be checked here. The pilot comes from one district. The estimate near score 58 concerns nearby businesses, rather than every city business. These limits matter when considering a wider rollout.',
    sprintf('Manager age jumps by about %s years near the score rule in the five-point window. Matching reuses %s different controls, including one used %s times; a manager-age gap of %s years remains. No score-manipulation evidence or real fieldwork documentation is supplied.',fmt(abs(case$age_jump),1),fmt(match_A$used),fmt(match_A$max_reuse),fmt(match_A$age_gap,1)),
    sprintf('The value-for-money model assumes %s AED one-off cost, savings beginning in year 2 and lasting five years, and a 5%% discount rate. It uses the city extra-change saving provisionally. Duration, timing and costs are fictional assumptions, not measured programme facts.',fmt(model$cost)))),
  list(title='7 Recommendations',paragraphs=c(
    'Approve nationwide expansion now, with the same eligibility rule. Four confirmations and a headline above the minimum saving rule provide sufficient evidence for this action.',
    'Approve the programme budget because the benefit-cost ratio exceeds 1. No additional evidence about costs, saving duration or nationwide delivery is needed.'))
)

rating_scale <- data.frame(light=c('Green','Amber','Red'),rating=c('Supported','Concern','Unsupported'),
  meaning=c('The claim is supported by the stated source, within its limits.','A specific uncertainty or missing check could change the judgement.','A claim goes beyond or contradicts the supplied evidence.'))
rating_sections <- data.frame(id=c('summary','design','data','results','limitations','conclusions'),
  section=c('1 Executive summary','3 Evaluation design','4 Data','5 Results','6 Limitations','7 Recommendations'),
  area=c('Recommendation','Comparison and assumptions','Source and missing evidence','Estimate and uncertainty','Limits and reach','Action and conditions'),
  strength=c('Names the outcome, units and minimum saving rule.','Names the comparisons and their different reach.','States counts, timing and the absence of fieldwork records.','Reports all four estimates and intervals in one table.','Discloses specific limitations and fictional cost-model inputs.','States a concrete proposed action.'),
  weakness=c('Treats a selected point estimate, shared analyses and a mean fall as sufficient proof.','Same-city membership cannot guarantee the unobserved parallel change.','Complete generated cells cannot establish real measurement or follow-up.','Selects the largest estimate; the pilot and matching intervals span the rule, while the preferred city interval falls short.','Disclosure helps a reader but does not resolve the problems or justify the recommendation.','Nationwide expansion and unconditional budget approval exceed the evidence.'),
  suggested=c('Unsupported','Concern','Unsupported','Unsupported','Supported','Unsupported'))
rating_decisive <- 'Trace the headline to Section 5. The matched point estimate exceeds the rule, but its interval spans it. The preferred city result falls short. Shared city records are not independent confirmations. None of these facts establishes nationwide value for money.'

assessment_questions <- c(
  'Using the pilot row, name the outcome, units, period and people described.',
  'Who is compared in the pilot? Why might that comparison be fair?',
  'Write the pilot estimate and interval. Does the interval settle the 1,000 AED rule?',
  'Name one important concern and cite its report section or sentence.',
  'Give a recommendation the evidence can support and one specific evaluator question.')
assessment_keys <- c(
  'Recorded annual waste cost saving, AED per business, after 12 months; 400 businesses in one pilot district.',
  '200 assigned to join versus 200 assigned to wait, chosen by lottery. This supports the pilot comparison; it does not establish nationwide reach.',
  sprintf('%s AED; interval %s to %s. The point exceeds 1,000; the interval spans it, so the minimum is not settled.',fmt(-case$rct),fmt(sort(-case$rct_ci)[1]),fmt(sort(-case$rct_ci)[2])),
  'Accept a cited concern: Sections 1/5 select a headline and overclaim confirmation; Section 3 guarantees an untested assumption; Section 4 infers fieldwork quality; Section 7 exceeds reach or cost evidence.',
  'Accept a limited or conditional action with a specific request tied to its purpose: earlier trends, fieldwork evidence, nearby credibility, matching support, delivery reach or cost duration. Do not require one preferred recommendation.')
assessment_criteria <- c('Outcome and scope','Comparison and fairness','Estimate interval and rule','Consequential source-based concern','Recommendation and evaluator request')
assessment_retry <- c(
  'Pilot saving 1,014 AED, interval 862 to 1,167, rule 1,000. What is settled and what remains uncertain?',
  'City participants\' mean costs fell by 669 AED. Does that alone establish the programme caused the fall? Explain the missing comparison.',
  'The cost model ratio is 1.86 under assumed duration and costs. Write the evidence request needed before treating that as sufficient for approval.')

finding_titles <- c('Pilot result','City comparisons','Value for money','Evidence still needed')
finding_text <- c(
  sprintf('The pilot lottery estimate is %s AED annual saving per business after 12 months. The 95%% interval is %s to %s. It spans the 1,000 AED rule; the result describes one district.',fmt(-case$rct),fmt(sort(-case$rct_ci)[1]),fmt(sort(-case$rct_ci)[2])),
  sprintf('City extra change: %s AED, interval %s to %s, below the rule. Earlier parallel change cannot be checked with one before measure. The local score estimate and matching have their own limitations. City methods share records, not independent studies.',fmt(-case$did),fmt(sort(-did_ci)[1]),fmt(sort(-did_ci)[2])),
  sprintf('The provisional model ratio is %.2f using the city extra-change saving. One-off cost %s AED, savings in years 2 to 6 and 5%% discounting are fictional assumptions. A ratio above 1 is a model result, not proof of nationwide value.',ratio(),fmt(model$cost)),
  'No real fieldwork records, earlier trends or score-manipulation evidence are supplied. Request the evidence relevant to your proposed action, including delivery reach, omitted costs and saving duration. Complete generated rows do not resolve these questions.')
example_brief <- c(
  sprintf('Finding: In one pilot district, the lottery estimate is %s AED annual saving per business; the 95%% interval is %s to %s. It spans the authority\'s 1,000 AED rule.',fmt(-case$rct),fmt(sort(-case$rct_ci)[1]),fmt(sort(-case$rct_ci)[2])),
  'Recommendation: Do not give unconditional approval for nationwide expansion on this evidence. Consider a limited next stage with explicit review conditions.',
  'Risk: Results concern different populations. The cost model depends on unverified duration and costs.',
  'Next evidence: Request evidence of delivery in the proposed areas, full programme costs and how long savings last. Use this to revisit the proposed scale and budget.')
ai_verdict <- 'The complete data prove reliable measurement. Four independent studies agree, and the matched saving exceeds the rule. National expansion is therefore well supported.'
ai_brief <- sprintf('GreenWaste saves %s AED per business per year. The pilot settles the 1,000 AED rule, so expand nationally. The %.2f ratio proves good value and no further cost evidence is required.',fmt(-case$rct),ratio())
brief_parts <- c('Finding and source','Recommendation and condition','Important risk or limit','Next evidence and its purpose')
