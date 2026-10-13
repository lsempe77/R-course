source('day3_session2_review.R', encoding='UTF-8')

# Day 3 Session 3 revisits the RCT-linked model from Session 1.
model$saving <- -case$rct
model$lag <- 0

d9_threshold_plot <- function() {
  lo <- sort(-case$rct_ci)[1]
  hi <- sort(-case$rct_ci)[2]
  x <- function(v) 120 + (v-750)/500*900
  sprintf(paste0(
    '<svg class="d9-threshold" viewBox="0 0 1120 250" role="img" ',
    'aria-label="Pilot annual saving estimate %s AED, 95 percent interval %s to %s AED; ',
    'the interval crosses the 1,000 AED rule.">',
    '<line x1="120" y1="155" x2="1020" y2="155" stroke="#aec2d6" stroke-width="4"/>',
    '<line data-d3-rule-line x1="%.1f" y1="55" x2="%.1f" y2="180" stroke="#b8272c" stroke-width="3" stroke-dasharray="8 6"/>',
    '<text data-d3-rule-label x="%.1f" y="40" text-anchor="middle" fill="#b8272c" font-size="27" font-weight="700">Rule: 1,000</text>',
    '<line x1="%.1f" y1="105" x2="%.1f" y2="105" stroke="#215a9e" stroke-width="8"/>',
    '<circle cx="%.1f" cy="105" r="13" fill="#063360"/>',
    '<text x="%.1f" y="87" text-anchor="middle" font-size="26" font-weight="700">%s</text>',
    '<text x="%.1f" y="205" text-anchor="middle" font-size="24">%s</text>',
    '<text x="%.1f" y="205" text-anchor="middle" font-size="24">%s</text>',
    '<text x="560" y="245" text-anchor="middle" font-size="23">Annual saving at 12 months, AED per pilot business | 95%% interval</text></svg>'),
    fmt(-case$rct), fmt(lo), fmt(hi),
    x(1000),x(1000),x(1000),
    x(lo),x(hi),x(-case$rct),x(-case$rct),fmt(-case$rct),
    x(lo),fmt(lo),x(hi),fmt(hi))
}

d9_four_intervals <- function() {
  estimate <- -c(case$rct, case$did, rdd[1], match_A$est)
  limits <- rbind(sort(-case$rct_ci), sort(-did_ci),
                  sort(-rdd_ci), sort(-match_A$ci))
  label <- c('Pilot RCT', 'City: DiD', 'City: cut-off', 'City: matching')
  y <- c(80, 145, 210, 275)
  x <- function(v) 365 + v / 1300 * 590
  rows <- paste(vapply(seq_along(y), function(i) sprintf(
    paste0('<text x="30" y="%s" font-size="25" fill="#063360">%s</text>',
           '<line x1="%.1f" x2="%.1f" y1="%s" y2="%s" stroke="%s" stroke-width="7"/>',
           '<circle cx="%.1f" cy="%s" r="11" fill="%s"/>',
           '<text x="975" y="%s" font-size="24" font-weight="700">%s</text>'),
    y[i]+8, label[i], x(limits[i,1]), x(limits[i,2]), y[i], y[i],
    if(i==1)'#215a9e' else '#64839e',x(estimate[i]),y[i],
    if(i==1)'#063360' else '#64839e',y[i]+8,fmt(estimate[i])), ''),collapse='')
  ticks <- paste(vapply(c(0,500,1000,1300), function(v)
    sprintf('<text x="%.1f" y="345" text-anchor="middle" font-size="21">%s</text>',
            x(v),fmt(v)),''),collapse='')
  sprintf(paste0(
    '<svg class="d9-forest" viewBox="0 0 1120 390" role="img" ',
    'aria-label="Four annual saving estimates with 95 percent intervals. Pilot: 1,014, 862 to 1,167. ',
    'City DiD: 812, 792 to 833. City cut-off: 721, 498 to 943. City matching: 1,029, 859 to 1,200.">',
    '<rect x="15" y="112" width="1080" height="195" fill="#f3f7fb"/>',
    '<line x1="365" x2="955" y1="317" y2="317" stroke="#b5c8da" stroke-width="3"/>',
    '<line x1="%.1f" x2="%.1f" y1="32" y2="317" stroke="#b8272c" stroke-width="3" stroke-dasharray="8 6"/>',
    '<text x="%.1f" y="26" text-anchor="middle" font-size="22" fill="#b8272c">1,000 AED rule</text>',
    '%s%s<text x="660" y="382" text-anchor="middle" font-size="21">Annual saving at 12 months (AED) | 95%% interval</text></svg>'),
    x(1000),x(1000),x(1000),rows,ticks)
}

d9_sensitivity_plot <- function() {
  value <- c(ratio(),ratio(years=3),ratio(decay=.3),
             ratio(decay=.3,extra=800))
  label <- c('Base: five years, 1,800 AED cost',
             'Saving lasts three years',
             'Saving fades 30% each year',
             'Fade plus 800 AED extra cost')
  y <- c(70,135,200,265)
  x <- function(v) 520 + v/2.6*505
  rows <- paste(vapply(seq_along(y),function(i)sprintf(
    paste0('<text x="25" y="%s" font-size="23">%s</text>',
           '<line x1="520" x2="1025" y1="%s" y2="%s" stroke="#d4e0eb" stroke-width="2"/>',
           '<circle cx="%.1f" cy="%s" r="11" fill="%s"/>',
           '<text x="%.1f" y="%s" font-size="24" font-weight="700">%s</text>'),
    y[i]+8,label[i],y[i],y[i],x(value[i]),y[i],
    if(i==4)'#b8272c' else '#215a9e',x(value[i])+17,y[i]+8,fmt(value[i],2)),''),collapse='')
  sprintf(paste0(
    '<svg class="d9-sensitivity" viewBox="0 0 1120 340" role="img" ',
    'aria-label="Partial benefit-cost ratio: base model 2.44, three saving years 1.53, ',
    '30 percent annual fading 1.40, fading plus 800 AED extra cost 0.97.">',
    '<line x1="%.1f" x2="%.1f" y1="35" y2="295" stroke="#b8272c" stroke-width="3" stroke-dasharray="7 5"/>',
    '<text x="%.1f" y="25" text-anchor="middle" font-size="21" fill="#b8272c">Ratio 1</text>',
    '%s<text x="770" y="330" text-anchor="middle" font-size="22">Benefit-cost ratio under stated assumptions</text></svg>'),
    x(1),x(1),x(1),rows)
}

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
  sprintf('N3. The RCT-linked model gives a benefit-cost ratio of %.2f, using the pilot effect and stated delivery-cost, duration and rate assumptions. This establishes value for money nationally. We should monitor costs during expansion, but no further evidence is needed before approval.',ratio()))
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
    sprintf('The RCT-linked partial model gives a ratio of %.2f. Its annual benefit is the pilot saving estimate of %s AED at 12 months. It assumes 1,800 AED delivery cost at year 0, equal annual savings in years 1-5 and a 5%% rate. Delivery costs and later savings are not RCT measurements; this is not a complete national public-budget or social appraisal.',ratio(),fmt(model$saving))),
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
d9_screen_desk <- function() {
  topics <- c('Pilot and reach','Shared city file','Saving rule','Earlier trends',
              'Score cut-off','Matching','Data quality','Costs and duration')
  supplied <- c(
    'The pilot randomly assigned 400 businesses in one district. Annual waste cost was measured after 12 months.',
    'Three city methods use the same 10,000-business teaching file. They are different comparisons, not independent studies.',
    'Pilot saving: 1,014 AED per business per year. The 95% interval is 862 to 1,167 AED, crossing the 1,000 AED rule.',
    'The city file has one measure before and one after. It cannot show whether the groups followed similar earlier trends.',
    'The city cut-off is score 58. Manager age also changes near that score, raising a comparability question.',
    'Matching reuses some comparison businesses and sets no maximum match distance.',
    'The generated teaching file has complete rows; it does not document real recruitment, follow-up or measurement quality.',
    'The partial model gives a ratio of 2.44 using the pilot effect, 1,800 AED assumed cost, five saving years and a 5% rate.')
  missing <- c(
    'How national businesses and delivery differ from this district.',
    'A genuinely separate replication or one effect estimate for the national target group.',
    'Evidence that a national programme would meet the minimum saving.',
    'Several earlier cost measurements and a record of other changes affecting the groups.',
    'A score-setting audit and checks that businesses on either side are otherwise comparable.',
    'Match-distance, overlap and residual-balance checks; unmeasured differences remain possible.',
    'Fieldwork, attrition and validation records from a real evaluation.',
    'Audited full costs and follow-up showing whether savings persist.')
  buttons <- paste(vapply(seq_along(topics), function(i) paste0(
    '<button type="button" data-d3-evidence="E',i,'" aria-pressed="false">E',i,' ',topics[i],'</button>'),''),collapse='')
  panels <- paste(vapply(seq_along(topics), function(i) paste0(
    '<article class="d3-evidence-panel" data-d3-panel="E',i,'" hidden><h3>E',i,' ',topics[i],'</h3>',
    '<p><strong>What we have:</strong> ',supplied[i],'</p>',
    '<p><strong>What is missing:</strong> ',missing[i],'</p></article>'),''),collapse='')
  paste0('<div class="d3-evidence-desk"><div class="d3-evidence-buttons">',buttons,
         '</div><div class="d3-evidence-panel d3-evidence-prompt" data-d3-panel="prompt">',
         'Ask a question first. The presenter then opens one relevant evidence card.',
         '</div>',panels,'</div>')
}
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
