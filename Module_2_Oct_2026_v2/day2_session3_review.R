source('day2_case.R', encoding='UTF-8')

d6_vars <- case_env$MATCH_VARS
d6_X <- scale(city[, d6_vars, drop=FALSE])
d6_ids <- which(took)
d6_controls <- which(!took)
d6_Xc <- t(d6_X[d6_controls, , drop=FALSE])
d6_twins <- d6_controls[vapply(d6_ids, function(i)
  which.min(colSums((d6_Xc - d6_X[i, ])^2)), 1L)]
stopifnot(length(unique(d6_twins)) == match_A$used,
  abs(mean(city$cost_after[d6_ids] - city$cost_after[d6_twins]) - match_A$est) < 1e-6)

d6_table <- function(df) as.character(knitr::kable(df, format='html',
  row.names=FALSE, escape=TRUE, table.attr='class="reading-table"'))
d6_results <- function() d6_table(data.frame(
  Comparison=c('Four recorded features', 'Manager age omitted'),
  'Difference AED'=fmt(c(match_A$est, match_B$est)),
  '95% interval AED'=c(paste(fmt(match_A$ci), collapse=' to '),
    paste(fmt(match_B$ci), collapse=' to ')),
  'Unique controls'=fmt(c(match_A$used, match_B$used)), check.names=FALSE))
d6_balance <- function() {
  columns <- c(d6_vars, 'cost_before')
  participant <- colMeans(city[d6_ids, columns])
  before <- colMeans(city[d6_controls, columns])
  after <- colMeans(city[d6_twins, columns])
  d6_table(data.frame(
    Feature=c('Manager age (years)', 'Staff (people)', 'Area (100 m2)',
      'Filtration (share)', 'Before-cost (AED; not matched on)'),
    Participants=fmt(participant, 2),
    'All controls'=fmt(before, 2), 'Matched controls'=fmt(after, 2),
    'Gap / city SD'=fmt((participant-after)/vapply(city[, columns], sd, 0), 2),
    check.names=FALSE))
}
d6_support <- function() {
  x <- function(v) 120 + (v-15)/70*840
  group <- function(values, y, colour) {
    breaks <- seq(15, 85, 5)
    counts <- hist(values, breaks=breaks, plot=FALSE)$counts/length(values)
    paste(vapply(seq_along(counts), function(i) sprintf(
      '<rect x="%.1f" y="%.1f" width="56" height="%.1f" fill="%s" opacity=".8"/>',
      x(breaks[i]), y-counts[i]*210, counts[i]*210, colour), ''), collapse='')
  }
  paste0('<svg class="review-svg" viewBox="0 0 1100 250" role="img" aria-label="Actual pre-programme manager-age distributions for participants and all available controls; overlap in age alone does not establish joint support.">',
    '<text x="120" y="28" font-size="24" fill="#215a9e">Participants</text>',
    '<text x="620" y="28" font-size="24" fill="#545860">All available controls</text>',
    group(city$manager_age[d6_ids], 115, '#215a9e'),
    group(city$manager_age[d6_controls], 205, '#545860'),
    paste(vapply(seq(20,80,10), function(v) sprintf(
      '<text x="%.1f" y="239" font-size="22" text-anchor="middle">%s</text>',
      x(v), v), ''), collapse=''),
    '<text x="1030" y="239" font-size="21">Age</text></svg>')
}
d6_reuse <- function() paste0(
  '<svg class="review-svg" viewBox="0 0 1100 220" role="img" aria-label="Illustrative reuse: three participants can share one control. Actual study: 4,794 participants, 585 unique controls, maximum reuse 440.">',
  '<g stroke="#7da1c4" stroke-width="4"><path d="M300 50L690 110M300 110L690 110M300 170L690 110"/></g>',
  '<g fill="#063360" font-size="28"><text x="100" y="58">Participant A</text><text x="100" y="118">Participant B</text><text x="100" y="178">Participant C</text><text x="710" y="118">One control</text></g>',
  '<text x="550" y="215" text-anchor="middle" font-size="24">Illustration only; not the seven-card activity</text></svg>')
d6_interval <- function() {
  ci <- sort(-match_A$ci)
  x <- function(v) 120+v/1600*850
  paste0('<svg class="review-svg" viewBox="0 0 1100 230" role="img" aria-label="Matched reduction 1,029 AED; interval 859 to 1,200 crosses the 1,000 AED rule.">',
    '<line x1="120" x2="970" y1="150" y2="150" stroke="#545860"/>',
    sprintf('<line x1="%.1f" x2="%.1f" y1="45" y2="150" stroke="#B8272C" stroke-width="3" stroke-dasharray="7 5"/><text x="%.1f" y="30" text-anchor="middle" font-size="26">Rule 1,000</text>', x(1000), x(1000), x(1000)),
    sprintf('<line x1="%.1f" x2="%.1f" y1="85" y2="85" stroke="#215a9e" stroke-width="8"/><circle cx="%.1f" cy="85" r="9" fill="#063360"/><text x="%.1f" y="65" text-anchor="end" font-size="26">%s</text><text x="%.1f" y="65" font-size="26">%s</text><text x="%.1f" y="125" text-anchor="middle" font-size="26">Estimate %s</text>',
      x(ci[1]), x(ci[2]), x(-match_A$est), x(ci[1])-10, fmt(ci[1]),
      x(ci[2])+10, fmt(ci[2]), x(-match_A$est), fmt(-match_A$est)),
    paste(vapply(seq(0,1600,400), function(v) sprintf(
      '<text x="%.1f" y="182" text-anchor="middle" font-size="24">%s</text>',
      x(v), fmt(v)), ''), collapse=''),
    '<text x="550" y="222" text-anchor="middle" font-size="25">Matched annual cost reduction per participant (AED)</text></svg>')
}
d6_ai <- paste0(
  'The four-feature evaluator compared participants with businesses similar in manager age, staff, premises area and filtration before GreenWaste. Every participant received a match, and controls could be reused. Annual after-cost was about ',
  fmt(-match_A$est), ' AED lower, with a 95% reduction interval of ',
  paste(fmt(sort(-match_A$ci)), collapse=' to '), ' AED.\n\n',
  'The evaluator who omitted manager age found a larger reduction of ',
  fmt(-match_B$est), ' AED. A commissioner should prefer the fuller model: the extra feature removes selection bias, and finding a match for everyone shows that the comparisons are sufficiently close.\n\n',
  'Both analyses point towards lower costs. The four-feature estimate exceeds the 1,000 AED minimum, so the minimum is securely achieved. Verify programme costs before deciding whether to expand.')
d6_prompt <- paste(
  'I commission a GreenWaste evaluation. Using only H6-A below, compare four-feature matching with the analysis omitting manager age.',
  'State the outcome, comparison, estimate and interval. Flag what was left off the matching list, whether costs were similar before, and how close the matches are.',
  'Distinguish control reuse, measured balance and unrecorded influences. Test the 1,000 AED annual-saving rule against the interval, not just the estimate.',
  'Ask me questions about missing information before recommending action. Do not invent diagnostics or treat matching as a lottery.',
  'Cite paragraph/table IDs for each factual claim. Here is H6-A: [paste worksheet page 1 and the balance table on page 2].')
