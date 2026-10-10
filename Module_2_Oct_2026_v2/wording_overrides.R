# Wording overrides for the sessions that have no preview version (Day 2 S2, Day 3 S3, Day 4 S1 and S2).
# Source this after the case file. The shared case files are not changed, so other sessions keep their text.
rule_full <- 'our rule of at least a 1,000 AED reduction in annual waste management cost per business per year'
if (exists('method_rows')) {
  method_rows$Method <- c('Pilot lottery: treatment group compared with control group',
    'City: difference between the two changes (DiD)',
    'City: jump at the score cut-off of 58 (RDD)',
    'City: participant businesses compared with matched comparison businesses')
  names(method_rows) <- c('Method', 'Estimated saving (AED)', '95% interval for saving (AED)')
}
if (exists('qa_note')) qa_note <- sprintf('GreenWaste should expand nationally. The pilot estimated a saving of %s AED per business, above our rule of at least a 1,000 AED reduction. All methods confirm the programme works, so the evidence is sufficient for approval.', fmt(-case$rct))
if (exists('ai_verdict')) ai_verdict <- 'The complete data prove reliable measurement. Four independent studies agree, and the matched saving exceeds our rule of at least a 1,000 AED reduction. National expansion is therefore well supported.'
if (exists('ai_brief')) ai_brief <- sprintf('GreenWaste saves %s AED per business per year. The pilot settles our rule of at least a 1,000 AED reduction, so expand nationally. The benefit-cost ratio of %.2f proves good value and no further cost evidence is required.', fmt(-case$rct), ratio())
