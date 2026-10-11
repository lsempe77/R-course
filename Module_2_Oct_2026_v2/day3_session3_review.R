source('day3_session2_review.R', encoding='UTF-8')

d9_ids <- paste0('E', 1:8)
d9_results <- data.frame(
  Source=c('E1 / E3','E2 / E4','E2 / E5','E2 / E6'),
  method_rows, check.names=FALSE)
d9_table <- function(df) as.character(knitr::kable(df, format='html',
  row.names=FALSE, table.attr='class="reading-table"'))
d9_results_table <- function() d9_table(d9_results)
d9_map <- data.frame(
  Source=c('E1','E2 / E4','E2 / E5','E2 / E6'),
  Comparison=c(
    'Pilot: 400 businesses in one district; lottery assigned 200 to support and 200 to comparison. Costs at 12 months.',
    'City: participant businesses\' change (before to after) minus comparison businesses\' change in the same 10,000-business file.',
    sprintf('City: fitted cost jump at score 58, using %s businesses within two score points on either side.',fmt(nrow(near))),
    'City: 4,794 participant businesses paired to comparison businesses on four standardised pre-programme features; controls may be reused.'),
  'Causal requirement to scrutinise'=c(
    'Valid lottery and comparable outcome follow-up; no other systematic differences created by assignment.',
    'Without support, the groups would have had parallel cost trends; no differential concurrent changes.',
    'Without support, expected outcomes would vary smoothly at 58; no sorting or other discontinuous cause.',
    'Conditional on the matched features, no remaining outcome-relevant selection; adequate comparable controls.'),
  check.names=FALSE)
d9_note <- c(
  sprintf('N1. Recommendation to the director: approve phased national expansion of GreenWaste. The programme subsidises business waste-management technology. In the pilot district, the lottery comparison estimated an annual saving of %s AED per business after 12 months, exceeding our %s AED minimum-saving rule. This is the clearest basis for proceeding.',fmt(-case$rct),fmt(decision_rule)),
  'N2. The city analyses also estimate lower costs for participants, using the difference between the two changes, the score cut-off and matched comparisons. Their figures differ, but the common direction across four methods provides independent confirmation that the programme works. Table T9 reports the estimates and their uncertainty.',
  sprintf('N3. We recognise that the pilot is from one district and the cut-off result is local. The city model gives a benefit-cost ratio of %.2f under stated cost and duration assumptions. National delivery should monitor costs and implementation, but the pilot point estimate clears our rule of at least a 1,000 AED reduction, so no further evidence is needed before approving the expansion.',ratio()))
d9_note_html <- function() paste(sprintf('<p>%s</p>',d9_note),collapse='')
d9_bank <- data.frame(
  ID=d9_ids,
  Question=answer_bank$Question,
  Supplied=c(
    sprintf('The note selected the pilot point estimate: %s AED annual saving. The separate pilot has 400 businesses in one district, lottery assigned 200/200, with costs at 12 months. The comparison is lottery groups, not the city before/after mean.',fmt(-case$rct)),
    sprintf('The city file has %s businesses. DiD compares changes; RDD fits a local jump using %s businesses within score 58 +/- 2; matching compares 4,794 participant businesses with selected comparison businesses. These city analyses reuse records and estimate different comparisons. They are not independent replications.',fmt(nrow(city)),fmt(nrow(near))),
    sprintf('On a positive annual-saving scale, the pilot estimate is %s AED and its 95%% interval is %s to %s AED. Pilot and matching intervals span the %s AED rule; the DiD and RDD intervals lie below it. All four intervals lie above zero. Uncertainty about the minimum saving and evidence of a reduction are different questions.',fmt(-case$rct),fmt(sort(-case$rct_ci)[1]),fmt(sort(-case$rct_ci)[2]),fmt(decision_rule)),
    'The city file contains one before observation and one observation at 12 months per business. It cannot show earlier trends. The DiD causal interpretation requires the participant and comparison changes to stand in for what would have happened without support.',
    sprintf('Businesses with a score at or below 58 took part. The local result uses a two-point window and an HC2 robust interval. A separate five-point diagnostic shows pre-programme managers about %s years younger below the cut-off. This is a concrete comparability concern, not proof of which alternative cause explains the cost jump.',fmt(abs(case$age_jump),1)),
    sprintf('Matching uses manager age, staff, area (in 100 square metres) and filtration before support. Every participant gets a nearest neighbour, without a distance limit. %s distinct controls are used; one is reused %s times. Residual gaps in mean manager age and in waste cost before GreenWaste are %s years and %s AED. The reported business-clustered interval treats the chosen matches as given.',fmt(match_A$used),fmt(match_A$max_reuse),fmt(match_A$age_gap,1),fmt(match_A$base_gap)),
    'These are complete generated records in a synthetic training file. No real recruitment, fieldwork, attrition, measurement-validation or representativeness documents are supplied. Completeness of this file does not demonstrate those qualities in an actual evaluation.',
    sprintf('The limited model gives a ratio of %.2f. Its annual benefit is the provisional city DiD saving of %s AED. It assumes 1,800 AED cost at year 0, no saving in year 1, five equal saving years in years 2-6 and a 5%% rate. This is a mixed-actor model, not a complete public-budget or social appraisal.',ratio(),fmt(model$saving))),
  Unavailable=c(
    'No national representativeness or implementation-transfer evidence is supplied.',
    'No common national effect or genuinely independent city replication is supplied.',
    'No analysis resolves national threshold certainty. An interval alone cannot decide an acceptable risk level.',
    'No earlier cost series or documented review of concurrent changes is supplied.',
    'No score-manipulation audit or evidence resolving the age jump is supplied.',
    'No full closeness/support assessment or evidence ruling out unmeasured selection is supplied.',
    'Real data-quality assurance cannot be inferred from the supplied file.',
    'No measured full cost inventory or evidence establishing five-year persistence is supplied.'),
  Follow_up=c(
    'Send the lottery and follow-up protocol, plus evidence about the businesses and delivery conditions expected nationally.',
    'Identify the target population and preferred analysis, its rationale and any genuine independent evidence.',
    'Show the estimate and interval alongside our rule of at least a 1,000 AED reduction; state the risk tolerance and evidence needed for a phased decision.',
    'Send several earlier cost measures and an account of other changes affecting the two groups.',
    'Send the score-setting audit, cut-off balance checks and sensitivity to reasonable windows/specifications.',
    'Send distance/overlap distributions, residual balance and sensitivity to features and unmeasured selection.',
    'Send recruitment, follow-up by group, reasons for missing outcomes and measurement-validation records.',
    'Send amounts, timing and perspective for all relevant costs, persistence evidence and sensitivity results.'),
  Purpose=c(
    'Assess the credibility of the pilot comparison and whether expansion changes the population or delivery conditions.',
    'Stop counting methods as votes; align the comparison and assumptions with the decision.',
    'Separate an estimated reduction from a settled minimum-saving claim.',
    'Judge how plausible the counterfactual trend is; earlier trends cannot prove it.',
    'Assess continuity around the cut-off; a clean audit would not by itself establish every assumption.',
    'Assess comparability and remaining selection; measured balance alone cannot rule out unmeasured bias.',
    'Judge what the observed outcome comparison represents and whether measurement/follow-up could distort it.',
    'Judge a spending recommendation without turning assumed inputs into measured facts.'),
  stringsAsFactors=FALSE)
d9_evidence_html <- function(i) paste0(
  '<article class="evidence-card" id="',d9_bank$ID[i],'">',
  '<h3>',d9_bank$ID[i],': ',d9_bank$Question[i],'</h3>',
  '<p><strong>Supplied evidence.</strong> ',d9_bank$Supplied[i],'</p>',
  '<p><strong>Not supplied.</strong> ',d9_bank$Unavailable[i],'</p>',
  '<p><strong>A useful follow-up.</strong> ',d9_bank$Follow_up[i],'</p>',
  '<p><strong>Decision purpose.</strong> ',d9_bank$Purpose[i],'</p></article>')
d9_ai_prompt_a <- paste(
  'An evaluation of subsidised waste-management technology used a pilot lottery,',
  'city difference-in-differences, a score cut-off and matching. It reports annual savings in Table T9.',
  'List the critical questions a commissioner should ask before acting on these results.')
d9_ai <- paste0(
  'A commissioner should first check how the comparison groups were chosen, whether outcomes were measured consistently and whether the recommendation fits the population studied. Table T9 reports annual savings of ',
  paste(d9_results[['Estimated saving AED']],collapse=', '),
  ' AED. All intervals exclude zero; the pilot and matched intervals include the 1,000 AED minimum-saving rule. The point estimates alone do not settle that minimum.\n\n',
  'The pilot lottery offers a stronger basis for deciding whether GreenWaste caused the change than a simple before/after comparison. Earlier trends should be requested for the city difference-in-differences analysis, and comparability near the cut-off and after matching should be checked. The national recommendation also needs evidence on delivery costs and how long savings last.\n\n',
  'However, four independent studies now agree on a reduction, which gives strong assurance that national expansion will achieve the intended saving. The large, complete city file establishes data reliability and leaves little reason to delay approval. Ask the evaluator to confirm that the results are robust, then proceed with national rollout.')
d9_prompt <- paste(
  'I advise on national GreenWaste expansion with a 1,000 AED annual-saving rule.',
  'Use only H9-A (N1-N3, Table T9), H9-B and evidence E1-E8 supplied below.',
  'Ask me questions about the decision, population and acceptable uncertainty before giving advice.',
  'For each design, identify its main causal assumption, evidence that would challenge it and what is not supplied; do not claim one assumption is sufficient.',
  'Separate positive estimates, uncertainty about the minimum saving, national reach and modelled value for money.',
  'Recommend a provisional action and one evidence request that could change it. Cite source IDs.',
  'Do not invent diagnostics or treat shared city records as independent studies. [Paste the named sources.]')
d9_fallback <- paste(
  'Before advising, I need to know the intended expansion population and acceptable risk of falling below 1,000 AED.',
  'T9 / E3 supports reductions on the supplied comparisons, but pilot and matching intervals span that rule.',
  'E2 says city methods share records and compare different populations. E4-E6 identify causal requirements and missing checks;',
  'earlier trends would inform, not prove, the DiD counterfactual. E7 does not establish real-world data quality.',
  'E8 gives a conditional model, not verified national value for money.',
  'One defensible provisional response is a limited next phase with an evaluation and cost-monitoring plan, rather than signing the note as written.',
  'Request a target-population and delivery comparison with the pilot (E1); it could change how far the pilot result can guide expansion.',
  'If whether GreenWaste caused the change, or the full costs, are the main concern instead, prioritise a different specific request and explain why.')
