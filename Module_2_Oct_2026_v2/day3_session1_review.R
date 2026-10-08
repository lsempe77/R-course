source('day3_case.R', encoding='UTF-8')

d7_benefits <- model$saving * pv_factor()
d7_npv <- d7_benefits - model$cost
d7_flows <- data.frame(Year=0:6,
  'Cost AED'=c(model$cost, rep(0, 6)),
  'Saving AED'=c(0, 0, rep(model$saving, 5)),
  'Present saving AED'=c(0, 0, model$saving/(1+model$rate)^(2:6)),
  check.names=FALSE)
d7_table <- function(df) as.character(knitr::kable(df, format='html',
  row.names=FALSE, escape=TRUE, table.attr='class="reading-table"'))
d7_inputs <- function() d7_table(assumptions)
d7_output <- function() d7_table(data.frame(
  Quantity=c('Present-value benefits', 'Present-value included cost',
    'Benefit-cost ratio', 'Net present value'),
  Value=c(paste(fmt(d7_benefits), 'AED'), paste(fmt(model$cost), 'AED'),
    fmt(ratio(), 2), paste(fmt(d7_npv), 'AED')),
  Meaning=c('Modelled savings in years 2-6', 'One-off equipment delivery at year 0',
    'Benefits divided by included costs', 'Benefits minus included costs'),
  check.names=FALSE))
d7_cash_table <- function() {
  df <- d7_flows
  df[-1] <- lapply(df[-1], fmt)
  d7_table(df)
}
d7_svg <- function(body, label, height=250) paste0(
  '<svg class="review-svg" viewBox="0 0 1100 ', height,
  '" role="img" aria-label="', label, '">', body, '</svg>')
d7_timeline <- function() {
  x <- seq(90, 1010, length.out=7)
  dots <- paste(vapply(0:6, function(i) sprintf(
    '<circle cx="%.1f" cy="110" r="8" fill="#063360"/><text x="%.1f" y="150" text-anchor="middle" font-size="24">Year %s</text><text x="%.1f" y="75" text-anchor="middle" font-size="23" fill="%s">%s</text>',
    x[i+1], x[i+1], i, x[i+1], if(i==0)'#B8272C' else '#215a9e',
    if(i==0)paste('-', fmt(model$cost)) else if(i==1)'No saving' else paste('+', fmt(model$saving))), ''), collapse='')
  d7_svg(paste0('<line x1="90" x2="1010" y1="110" y2="110" stroke="#7da1c4" stroke-width="4"/>',
    dots, '<text x="550" y="210" text-anchor="middle" font-size="26">Assumed cash flows: AED per business, before discounting</text>'),
    'Assumed cash-flow timeline: cost 1,800 AED now, no saving in year 1, saving about 812 AED each year in years 2 through 6.')
}
d7_discount <- function() d7_svg(sprintf(
  '<g fill="#063360" font-size="30"><text x="100" y="65">One year later: %s AED</text><text x="630" y="65">Today: %s AED</text></g><path d="M450 110L620 110" stroke="#7da1c4" stroke-width="5"/><text x="550" y="165" text-anchor="middle" font-size="30">%s / 1.05 = %s</text><text x="550" y="215" text-anchor="middle" font-size="24">Illustration only: the model starts savings in year 2, not year 1.</text>',
  fmt(model$saving), fmt(model$saving/1.05), fmt(model$saving), fmt(model$saving/1.05)),
  'At a five percent rate, 812 AED one year from now has present value about 774 AED.')
d7_scenario_table <- function() d7_table(data.frame(
  Card=scenarios$card, Change=scenarios$name,
  Ratio=fmt(scenarios$value, 2), 'Below 1?'=ifelse(scenarios$value<1, 'Yes', 'No'),
  check.names=FALSE))
d7_board <- function(results=FALSE) {
  x <- function(v) 120+v/2*860
  ticks <- paste(vapply(seq(0,2,.25), function(v) sprintf(
    '<line x1="%.1f" x2="%.1f" y1="120" y2="132" stroke="#545860"/><text x="%.1f" y="160" text-anchor="middle" font-size="23">%s</text>',
    x(v), x(v), x(v), fmt(v,2)), ''), collapse='')
  marks <- if(!results)'' else paste(vapply(seq_len(nrow(scenarios)), function(i) {
    yy <- c(225,225,225,275,225)[i]
    sprintf('<line x1="%.1f" x2="%.1f" y1="175" y2="%s" stroke="#7da1c4"/><circle cx="%.1f" cy="%s" r="18" fill="#215a9e"/><text x="%.1f" y="%s" text-anchor="middle" fill="white" font-size="22">%s</text>',
      x(scenarios$value[i]), x(scenarios$value[i]), yy,
      x(scenarios$value[i]), yy, x(scenarios$value[i]), yy+7, i)
  }, ''), collapse='')
  d7_svg(paste0(
    '<rect x="120" y="175" width="430" height="115" fill="#F8E9EA"/><rect x="550" y="175" width="430" height="115" fill="#EAF2EC"/>',
    '<text x="120" y="25" font-size="25">Prediction lane: sticky notes before the reveal</text>',
    '<line x1="120" x2="980" y1="125" y2="125" stroke="#545860" stroke-width="3"/>', ticks,
    sprintf('<line x1="%.1f" x2="%.1f" y1="45" y2="290" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="65" text-anchor="middle" font-size="24">Break-even 1</text>', x(1),x(1),x(1)),
    sprintf('<line x1="%.1f" x2="%.1f" y1="45" y2="290" stroke="#063360" stroke-dasharray="7 5"/><text x="%.1f" y="95" text-anchor="middle" font-size="24">Headline %s</text>',
      x(ratio()),x(ratio()),x(ratio()),fmt(ratio(),2)),
    marks, '<text x="120" y="325" font-size="25">Result lane: card numbers after the reveal</text>'),
    if(results)'Scenario results on a benefit-cost ratio line: cards 1 to 5 are 1.07, 1.40, 1.67, 1.17 and 0.80; only card 5 is below 1.' else
      'Blank prediction and result lanes on a benefit-cost ratio line from zero to two, with break-even one and headline 1.86.', 350)
}
d7_ai <- paste0(
  'The base model gives a benefit-cost ratio of ', fmt(ratio(),2),
  ': discounted savings exceed the 1,800 AED cost. This is a useful starting point, although programme costs should still be checked.\n\n',
  'One scenario is to raise the discount rate to 40%. With all other inputs unchanged, the ratio is about ',
  fmt(ratio(rate=.4),2),
  ', below break-even. Such a rate is realistic and commonly used in government infrastructure appraisal, so this shows the programme should not be funded.\n\n',
  'Alternatively, delaying benefits by a few more years also makes the ratio fall below 1. Both scenarios are plausible. The five-year saving stream in the source is established, so changing the discount rate is the main issue to investigate.')
d7_prompt <- paste(
  'I am reviewing the fictional GreenWaste cost-benefit model H7-A below.',
  'Identify which inputs are estimated, modelled or assumed; do not call the 1,800 AED cost measured or the DiD saving a proven causal benefit.',
  'Compare the specified single-input scenarios on Cards 1-4. Quantify each change from the base ratio and rank them within those stated changes; do not rank assumptions without defining their ranges. Card 5 combines two inputs, so keep it separate.',
  'Ask me questions before recommending which assumption to investigate, including what evidence makes the changes plausible and what discount-rate guidance applies.',
  'Keep timing, perspective and the distinction between ratio and net present value explicit. Cite H7-A paragraph/table IDs. Here is the source: [paste worksheet pages 1-2 and Table S from cards page 7, distributed after predictions].')
