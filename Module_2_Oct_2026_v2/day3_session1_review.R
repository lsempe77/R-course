source('day3_case.R', encoding='UTF-8')

# This session appraises the pilot RCT; other sessions keep their city model.
model$saving <- -case$rct
model$lag <- 0
scenarios$value <- c(ratio(decay=.3),ratio(extra=600),ratio(rate=.08),
  ratio(years=3),ratio(decay=.3,extra=800))

d7_benefits <- model$saving * pv_factor()
d7_npv <- d7_benefits - model$cost
d7_flows <- data.frame(Year=0:5,
  'Cost AED'=c(model$cost, rep(0, 5)),
  'Saving AED'=c(0, rep(model$saving, 5)),
  'Present saving AED'=c(0, model$saving/(1+model$rate)^(1:5)),
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
    'Savings last three years instead of five. Savings are made only in years 1, 2 and 3.',
    'This card changes two inputs. Each year\'s saving after the first is 30% lower than the year before, and we add 800 AED at year 0.'),
  short=c('Savings are 30% lower each year after the first year of saving',
    'Add 600 AED of costs at year 0',
    'Discount rate of 8% instead of 5%',
    'Savings last three years (years 1 to 3)',
    'Savings fade by 30% a year and add 800 AED at year 0'),
  value=scenarios$value, stringsAsFactors=FALSE)
d7_inputs <- function(title=NULL) d7_table(data.frame(
  Input=c('Annual saving per participant business', 'One-off cost per participant business',
    'Year when savings start', 'Number of years that savings last', 'Discount rate'),
  Value=c(paste(fmt(model$saving), 'AED'), paste(fmt(model$cost), 'AED'), 'Year 1',
    paste(model$years, 'years'), paste0(100*model$rate, '% a year')),
  Source=c('Pilot RCT estimate at 12 months', 'Assumption in this fictional case',
    'Assumption', 'Assumption', 'Assumption'), check.names=FALSE), title)
d7_output <- function(title=NULL) d7_table(data.frame(
  Measure=c('Benefits at value today', 'Cost at value today',
    'Benefit-cost ratio', 'Net present value'),
  Value=c(paste(fmt(d7_benefits), 'AED'), paste(fmt(model$cost), 'AED'),
    fmt(ratio(), 2), paste(fmt(d7_npv), 'AED')),
  'What it is'=c('The modelled savings in years 1 to 5, converted to year 0',
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
d7_rct_means_chart <- function() {
  vals <- c(mean(pilot$cost_after[pilot$took_part==0]),
            mean(pilot$cost_after[pilot$took_part==1]))
  x <- function(v) 335 + v/max(vals)*595
  rows <- paste(vapply(1:2, function(i) sprintf(
    '<text x="25" y="%s" font-size="27">%s</text><rect x="335" y="%s" width="%.1f" height="42" fill="%s"/><text x="%.1f" y="%s" font-size="27" font-weight="700">%s</text>',
    c(103,185)[i],c('No GreenWaste','GreenWaste')[i],c(70,152)[i],
    x(vals[i])-335,c('#7d8b99','#215a9e')[i],x(vals[i])+15,c(102,184)[i],fmt(vals[i])),''),collapse='')
  d7_svg(paste0(rows,
    '<text x="335" y="255" font-size="24">Mean annual waste cost at 12 months (AED per pilot business)</text>',
    sprintf('<text x="335" y="297" font-size="26" fill="#063360">Difference: %s AED lower with GreenWaste</text>',fmt(vals[1]-vals[2]))),
    paste('Pilot RCT means at 12 months: no GreenWaste',fmt(vals[1]),'AED; GreenWaste',fmt(vals[2]),
          'AED. The difference is',fmt(vals[1]-vals[2]),'AED per business per year.'),320)
}
d7_qaly_chart <- function() d7_svg(paste0(
  '<line x1="140" x2="975" y1="235" y2="235" stroke="#545860" stroke-width="3"/>',
  '<line x1="140" x2="140" y1="32" y2="235" stroke="#545860" stroke-width="3"/>',
  '<rect x="140" y="94" width="700" height="141" fill="#dcebf8"/>',
  '<line x1="140" x2="840" y1="94" y2="94" stroke="#215a9e" stroke-width="5"/>',
  '<line x1="840" x2="840" y1="94" y2="235" stroke="#215a9e" stroke-width="3"/>',
  '<text x="85" y="105" font-size="25" text-anchor="end">0.7</text>',
  '<text x="85" y="242" font-size="25" text-anchor="end">0</text>',
  '<text x="840" y="270" font-size="25" text-anchor="middle">4 years</text>',
  '<text x="505" y="177" font-size="30" text-anchor="middle" fill="#063360">0.7 x 4 = 2.8 QALYs</text>',
  '<text x="140" y="305" font-size="23">Illustrative health example only: quality-of-life weight x time</text>'),
  'Illustrative health example, not GreenWaste data: four years at a quality-of-life weight of 0.7 give 2.8 QALYs.',320)
d7_timeline <- function() {
  x <- seq(90, 1010, length.out=6)
  dots <- paste(vapply(0:5, function(i) sprintf(
    '<circle cx="%.1f" cy="110" r="8" fill="#063360"/><text x="%.1f" y="150" text-anchor="middle" font-size="24">Year %s</text><text x="%.1f" y="75" text-anchor="middle" font-size="23" fill="%s">%s</text>',
    x[i+1], x[i+1], i, x[i+1], if(i==0)'#B8272C' else '#215a9e',
    if(i==0)paste('Cost', fmt(model$cost)) else paste('Saving', fmt(model$saving))), ''), collapse='')
  d7_svg(paste0('<line x1="90" x2="1010" y1="110" y2="110" stroke="#7da1c4" stroke-width="4"/>',
    dots, '<text x="550" y="210" text-anchor="middle" font-size="26">Assumed costs and savings by year: AED per participant business, before conversion to value today</text>'),
    paste('Model timeline for one pilot business: assumed cost of 1,800 AED now, then',fmt(model$saving),'AED annual saving in years 1 to 5. Persistence after the 12-month RCT is assumed.'))
}
d7_discount <- function() {
  v <- model$saving/(1+model$rate)^(1:5)
  x <- function(i) 185+(i-1)*175
  y <- function(z) 238-z/1100*195
  pts <- paste(vapply(1:5,function(i)sprintf('%.1f,%.1f',x(i),y(v[i])),''),collapse=' ')
  marks <- paste(vapply(1:5,function(i)sprintf(
    '<circle cx="%.1f" cy="%.1f" r="10" fill="#215a9e"/><text x="%.1f" y="274" text-anchor="middle" font-size="24">Year %s</text><text x="%.1f" y="%.1f" text-anchor="middle" font-size="23" font-weight="700">%s</text>',
    x(i),y(v[i]),x(i),i,x(i),y(v[i])-17,fmt(v[i])),''),collapse='')
  d7_svg(paste0('<line x1="185" x2="885" y1="238" y2="238" stroke="#545860" stroke-width="3"/>',
    '<polyline points="',pts,'" fill="none" stroke="#215a9e" stroke-width="5"/>',marks,
    '<text x="185" y="315" font-size="23">Value today (AED) of the same assumed annual saving in each year</text>'),
    paste('At an assumed five percent discount rate, a saving of',fmt(model$saving),
          'AED has present value',paste(fmt(v),collapse=', '),'AED in years one to five.'),330)
}
d7_value_chart <- function() {
  x <- function(v) 390+v/5000*500
  vals <- c(d7_benefits,model$cost,d7_npv)
  labels <- c('Modelled benefits','Assumed delivery cost','Modelled net benefit')
  ys <- c(55,125,195)
  bars <- paste(vapply(seq_along(vals),function(i)sprintf(
    '<text x="105" y="%.1f" font-size="25">%s</text><rect x="390" y="%.1f" width="%.1f" height="30" fill="%s"/><text x="%.1f" y="%.1f" font-size="27" font-weight="700">%s</text>',
    ys[i]-9,labels[i],ys[i],x(vals[i])-390,if(i==2)'#B8272C' else '#215a9e',x(vals[i])+18,ys[i]+25,fmt(vals[i])),''),collapse='')
  d7_svg(paste0(bars,'<text x="390" y="275" font-size="22">Present value in AED per pilot business</text>'),
    paste('Modelled benefit',fmt(d7_benefits),'AED; assumed delivery cost',fmt(model$cost),'AED; modelled net benefit',fmt(d7_npv),'AED.'),300)
}
d7_sensitivity_chart <- function() {
  labels <- c('Base model','Savings fade 30% yearly','Add 600 AED to cost',
    'Discount rate 8%','Savings for three years','Fade plus 800 AED cost')
  vals <- c(ratio(),d7_scenarios$value)
  x <- function(v) 420+(v-.8)/1.8*600
  ys <- 35+seq_along(vals)*45
  rows <- paste(vapply(seq_along(vals),function(i)sprintf(
    '<text x="25" y="%.1f" font-size="23">%s</text><line x1="420" x2="1020" y1="%.1f" y2="%.1f" stroke="#d5dee8"/><circle cx="%.1f" cy="%.1f" r="9" fill="%s"/><text x="%.1f" y="%.1f" font-size="24" font-weight="700">%s</text>',
    ys[i]+8,labels[i],ys[i],ys[i],x(vals[i]),ys[i],if(i==length(vals))'#B8272C' else '#215a9e',x(vals[i])+14,ys[i]+8,fmt(vals[i],2)),''),collapse='')
  d7_svg(paste0(rows,sprintf('<line x1="%.1f" x2="%.1f" y1="55" y2="325" stroke="#B8272C" stroke-width="2" stroke-dasharray="7 5"/><text x="%.1f" y="40" text-anchor="middle" font-size="21">Ratio 1</text>',x(1),x(1),x(1))),
    'Illustrative benefit-cost ratios: base 2.44; fading savings 1.40; 600 AED extra cost 1.83; eight percent discount 2.25; three saving years 1.53; fading savings plus 800 AED extra cost 0.97.',340)
}
d7_break_even_chart <- function() {
  x<-function(v)90+v/1400*920
  lo<-min(-case$rct_ci); hi<-max(-case$rct_ci); point<-model$saving
  threshold<-model$cost/pv_factor()
  d7_svg(sprintf('<line x1="90" x2="1010" y1="160" y2="160" stroke="#545860" stroke-width="3"/><line x1="%.1f" x2="%.1f" y1="60" y2="180" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="42" text-anchor="middle" font-size="23">Model break-even %s</text><line x1="%.1f" x2="%.1f" y1="90" y2="180" stroke="#7d3c98" stroke-width="3"/><text x="%.1f" y="75" text-anchor="middle" font-size="23">Policy rule 1,000</text><line x1="%.1f" x2="%.1f" y1="115" y2="115" stroke="#215a9e" stroke-width="9"/><circle cx="%.1f" cy="115" r="11" fill="#063360"/><text x="%.1f" y="205" text-anchor="middle" font-size="23">%s</text><text x="%.1f" y="205" text-anchor="middle" font-size="23">%s</text><text x="%.1f" y="245" text-anchor="middle" font-size="25">RCT estimate %s</text>',
    x(threshold),x(threshold),x(threshold),fmt(threshold),x(1000),x(1000),x(1000),x(lo),x(hi),x(point),x(lo),fmt(lo),x(hi),fmt(hi),x(point),fmt(point)),
    paste('Pilot RCT annual saving estimate',fmt(point),'AED, 95 percent interval',fmt(lo),'to',fmt(hi),'AED; model break-even',fmt(threshold),'AED under assumed cost and duration; separate policy rule 1000 AED.'),270)
}
d7_scenario_table <- function(title=NULL) d7_table(data.frame(
  Card=d7_scenarios$card, Change=paste0(d7_scenarios$name, ': ', d7_scenarios$short),
  'Benefit-cost ratio'=fmt(d7_scenarios$value, 2), 'Below 1?'=ifelse(d7_scenarios$value<1, 'Yes', 'No'),
  check.names=FALSE), title)
d7_board <- function(results=FALSE) {
  x <- function(v) 120+v/2.6*860
  ticks <- paste(vapply(seq(0,2.5,.5), function(v) sprintf(
    '<line x1="%.1f" x2="%.1f" y1="120" y2="132" stroke="#545860"/><text x="%.1f" y="160" text-anchor="middle" font-size="23">%s</text>',
    x(v), x(v), x(v), fmt(v,2)), ''), collapse='')
  marks <- if(!results)'' else paste(vapply(seq_len(nrow(scenarios)), function(i) {
    yy <- c(225,225,225,275,225)[i]
    sprintf('<line x1="%.1f" x2="%.1f" y1="175" y2="%s" stroke="#7da1c4"/><circle cx="%.1f" cy="%s" r="18" fill="#215a9e"/><text x="%.1f" y="%s" text-anchor="middle" fill="white" font-size="22">%s</text>',
      x(scenarios$value[i]), x(scenarios$value[i]), yy,
      x(scenarios$value[i]), yy, x(scenarios$value[i]), yy+7, i)
  }, ''), collapse='')
  d7_svg(paste0(
    sprintf('<rect x="120" y="175" width="%.1f" height="115" fill="#F8E9EA"/><rect x="%.1f" y="175" width="%.1f" height="115" fill="#EAF2EC"/>',x(1)-120,x(1),980-x(1)),
    '<text x="120" y="25" font-size="25">Post your predictions here, before the results are given out</text>',
    '<line x1="120" x2="980" y1="125" y2="125" stroke="#545860" stroke-width="3"/>', ticks,
    sprintf('<line x1="%.1f" x2="%.1f" y1="45" y2="290" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="65" text-anchor="middle" font-size="24">Ratio of 1</text>', x(1),x(1),x(1)),
    sprintf('<line x1="%.1f" x2="%.1f" y1="45" y2="290" stroke="#063360" stroke-dasharray="7 5"/><text x="%.1f" y="95" text-anchor="middle" font-size="24">Base case %s</text>',
      x(ratio()),x(ratio()),x(ratio()),fmt(ratio(),2)),
    marks, '<text x="120" y="325" font-size="25">Post the card numbers and results here, after the results are given out</text>'),
    if(results)'Scenario results on a line of benefit-cost ratios: Cards 1 to 5 give 1.40, 1.83, 2.25, 1.53 and 0.97. Only Card 5 is below 1.' else
      'Blank prediction and result lanes on a line of benefit-cost ratios from zero to 2.6. A ratio of 1 and the base case of 2.44 are marked.', 350)
}
stopifnot(round(model$saving)==1014, round(ratio(),2)==2.44,
          round(d7_benefits)==4392, round(d7_npv)==2592)
