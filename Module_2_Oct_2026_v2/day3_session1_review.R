source('day3_case.R', encoding='UTF-8')

d7_benefits <- model$saving * pv_factor()
d7_npv <- d7_benefits - model$cost
d7_flows <- data.frame(Year=0:6,
  'Cost AED'=c(model$cost, rep(0, 6)),
  'Saving AED'=c(0, 0, rep(model$saving, 5)),
  'Present saving AED'=c(0, 0, model$saving/(1+model$rate)^(2:6)),
  check.names=FALSE)
d7_table <- function(df, title=NULL) paste0(
  if (!is.null(title)) paste0('<p class="table-title"><strong>', title, '</strong></p>') else '',
  as.character(knitr::kable(df, format='html',
  row.names=FALSE, escape=TRUE, table.attr='class="reading-table"')))
d7_scenarios <- data.frame(card=1:5,
  name=c('Savings fade', 'Hidden costs', 'A higher discount rate', 'A shorter life', 'Savings fade and hidden costs'),
  story=c('Each year\'s saving after the first year of saving is 30% lower than the year before. The first saving, in year 2, stays at the base amount.',
    'We add 600 AED per business for administration and business time, at year 0, in addition to the 1,800 AED already included. Check that the costs are not already counted.',
    'We use a discount rate of 8% instead of 5%, over the same five years of savings.',
    'Savings last three years instead of five. Savings are made only in years 2, 3 and 4.',
    'This card changes two inputs. Each year\'s saving after the first is 30% lower than the year before, and we add 600 AED at year 0.'),
  short=c('Savings are 30% lower each year after the first year of saving',
    'Add 600 AED of costs at year 0',
    'Discount rate of 8% instead of 5%',
    'Savings last three years (years 2 to 4)',
    'Savings fade by 30% a year and add 600 AED at year 0'),
  value=scenarios$value, stringsAsFactors=FALSE)
d7_inputs <- function(title=NULL) d7_table(data.frame(
  Input=c('Annual saving per participant business', 'One-off cost per participant business',
    'Year when savings start', 'Number of years that savings last', 'Discount rate'),
  Value=c(paste(fmt(model$saving), 'AED'), paste(fmt(model$cost), 'AED'), 'Year 2',
    paste(model$years, 'years'), paste0(100*model$rate, '% a year')),
  Source=c('Estimate from the city study (provisional)', 'Assumption in this fictional case',
    'Assumption', 'Assumption', 'Assumption'), check.names=FALSE), title)
d7_output <- function(title=NULL) d7_table(data.frame(
  Measure=c('Benefits at value today', 'Cost at value today',
    'Benefit-cost ratio', 'Net present value'),
  Value=c(paste(fmt(d7_benefits), 'AED'), paste(fmt(model$cost), 'AED'),
    fmt(ratio(), 2), paste(fmt(d7_npv), 'AED')),
  'What it is'=c('The savings in years 2 to 6, converted to year 0',
    'The one-off equipment delivery cost at year 0',
    'Benefits divided by costs', 'Benefits minus costs'),
  check.names=FALSE), title)
d7_cash_table <- function(title=NULL) {
  df <- d7_flows
  names(df) <- c('Year', 'Cost (AED)', 'Saving (AED)', 'Saving at value today (AED)')
  df[-1] <- lapply(df[-1], fmt)
  d7_table(df, title)
}
d7_svg <- function(body, label, height=250) paste0(
  '<svg class="review-svg" viewBox="0 0 1100 ', height,
  '" role="img" aria-label="', label, '">', body, '</svg>')
d7_timeline <- function() {
  x <- seq(90, 1010, length.out=7)
  dots <- paste(vapply(0:6, function(i) sprintf(
    '<circle cx="%.1f" cy="110" r="8" fill="#063360"/><text x="%.1f" y="150" text-anchor="middle" font-size="24">Year %s</text><text x="%.1f" y="75" text-anchor="middle" font-size="23" fill="%s">%s</text>',
    x[i+1], x[i+1], i, x[i+1], if(i==0)'#B8272C' else '#215a9e',
    if(i==0)paste('Cost', fmt(model$cost)) else if(i==1)'No saving' else paste('Saving', fmt(model$saving))), ''), collapse='')
  d7_svg(paste0('<line x1="90" x2="1010" y1="110" y2="110" stroke="#7da1c4" stroke-width="4"/>',
    dots, '<text x="550" y="210" text-anchor="middle" font-size="26">Assumed costs and savings by year: AED per participant business, before conversion to value today</text>'),
    'Assumed timeline for each participant business: cost of 1,800 AED now (year 0), no saving in year 1, and a saving of about 812 AED in each of years 2 to 6.')
}
d7_discount <- function() d7_svg(sprintf(
  '<g fill="#063360" font-size="30"><text x="100" y="65">In one year: %s AED</text><text x="630" y="65">Value today: %s AED</text></g><path d="M450 110L620 110" stroke="#7da1c4" stroke-width="5"/><text x="550" y="165" text-anchor="middle" font-size="30">%s / 1.05 = %s</text><text x="550" y="215" text-anchor="middle" font-size="24">This is an illustration. In the model, savings start in year 2, not year 1.</text>',
  fmt(model$saving), fmt(model$saving/1.05), fmt(model$saving), fmt(model$saving/1.05)),
  'At a 5% rate, 812 AED received one year from now is worth about 774 AED today.')
d7_scenario_table <- function(title=NULL) d7_table(data.frame(
  Card=d7_scenarios$card, Change=paste0(d7_scenarios$name, ': ', d7_scenarios$short),
  'Benefit-cost ratio'=fmt(d7_scenarios$value, 2), 'Below 1?'=ifelse(d7_scenarios$value<1, 'Yes', 'No'),
  check.names=FALSE), title)
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
    '<text x="120" y="25" font-size="25">Post your predictions here, before the results are given out</text>',
    '<line x1="120" x2="980" y1="125" y2="125" stroke="#545860" stroke-width="3"/>', ticks,
    sprintf('<line x1="%.1f" x2="%.1f" y1="45" y2="290" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="65" text-anchor="middle" font-size="24">Ratio of 1</text>', x(1),x(1),x(1)),
    sprintf('<line x1="%.1f" x2="%.1f" y1="45" y2="290" stroke="#063360" stroke-dasharray="7 5"/><text x="%.1f" y="95" text-anchor="middle" font-size="24">Base case %s</text>',
      x(ratio()),x(ratio()),x(ratio()),fmt(ratio(),2)),
    marks, '<text x="120" y="325" font-size="25">Post the card numbers and results here, after the results are given out</text>'),
    if(results)'Scenario results on a line of benefit-cost ratios: Cards 1 to 5 give 1.07, 1.40, 1.67, 1.17 and 0.80. Only Card 5 is below 1.' else
      'Blank prediction and result lanes on a line of benefit-cost ratios from zero to two. A ratio of 1 is marked, and the base case of 1.86 is marked.', 350)
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
  'Identify which inputs are estimated from data, modelled or assumed. Do not call the 1,800 AED cost measured, and do not call the difference-in-differences saving a proven causal benefit.',
  'Compare the four scenarios that each change one input (Cards 1 to 4). Say how far each one moves the ratio from the base ratio, and rank them only within these stated changes. Do not rank assumptions in general without defining their ranges. Card 5 changes two inputs together, so keep it separate.',
  'Before you recommend which assumption to investigate, ask me questions, including what evidence would make each change realistic and which discount-rate guidance applies.',
  'Keep the timing, the point of view, and the difference between the ratio and the net present value explicit. Cite the paragraph or table in H7-A.',
  'Here is the source: [paste worksheet pages 1 and 2 and the scenario results table, which you receive after your group has recorded its prediction].')
