source('day3_case.R', encoding='UTF-8')

d8_table <- function(df) as.character(knitr::kable(df, format='html',
  row.names=FALSE, escape=TRUE, table.attr='class="reading-table"'))
d8_svg <- function(body, label, width=1100, height=320) paste0(
  '<svg class="review-svg" viewBox="0 0 ', width, ' ', height,
  '" role="img" aria-label="', label, '">', body, '</svg>')
d8_bar <- function(start=0, labels=TRUE) {
  y <- function(v) 225-(v-start)/(1600-start)*165
  ticks <- if(!labels)'' else paste(vapply(
    if(start==0)c(0,400,800,1200,1600) else c(700,1000,1300,1600),
    function(v) sprintf('<line x1="95" x2="495" y1="%.1f" y2="%.1f" stroke="#D5DEE8"/><text x="83" y="%.1f" text-anchor="end" font-size="20">%s</text>',
      y(v),y(v),y(v)+6,fmt(v)), ''), collapse='')
  bars <- paste(vapply(1:2, function(i) sprintf(
    '<rect x="%s" y="%.1f" width="95" height="%.1f" fill="#215a9e"/><text x="%s" y="%.1f" text-anchor="middle" font-size="23">%s</text>',
    c(155,355)[i],y(ba_mean[i]),225-y(ba_mean[i]),c(202,402)[i],
    y(ba_mean[i])-10,if(labels)fmt(ba_mean[i]) else ''), ''), collapse='')
  d8_svg(paste0(ticks,bars,
    if(labels)paste0('<text x="202" y="258" text-anchor="middle" font-size="21">Before</text><text x="402" y="258" text-anchor="middle" font-size="21">12 months after</text>',
      '<text x="290" y="291" text-anchor="middle" font-size="19">Participants: mean annual cost (AED)</text>') else ''),
    if(labels)paste('City participant mean annual costs before and after: 1,432 and 763 AED. Axis starts at',start,'AED. Descriptive comparison, not a causal estimate.') else
      'Deliberately incomplete draft chart: values, units, group and axis labels are withheld until the reveal.',
    550,310)
}
d8_pair <- function(labels=TRUE) paste0(
  '<div class="review-grid chart-pair"><div><h3>A: zero baseline</h3>',d8_bar(0,labels),
  '</div><div><h3>B: baseline 700 AED</h3>',d8_bar(700,labels),'</div></div>')
d8_cost_table <- function() d8_table(data.frame(
  Population='Same 4,794 city participants',
  'Before AED'=fmt(ba_mean[1]), 'After AED'=fmt(ba_mean[2]),
  'Recorded fall AED'=fmt(ba_mean[1]-ba_mean[2]),
  check.names=FALSE))
d8_quantiles <- quantile(tp$cost_before,c(.25,.5,.75))
d8_distribution <- function() {
  h <- hist(tp$cost_before,breaks=seq(0,4500,300),plot=FALSE)
  x <- function(v) 110+v/4500*880
  y <- function(n) 230-n/max(h$counts)*155
  counts <- pretty(c(0,max(h$counts)),n=3)
  counts <- counts[counts<=max(h$counts)]
  axis <- paste(vapply(counts,function(n)sprintf(
    '<line x1="110" x2="990" y1="%.1f" y2="%.1f" stroke="#D5DEE8"/><text x="95" y="%.1f" text-anchor="end" font-size="21">%s</text>',
    y(n),y(n),y(n)+7,fmt(n)),''),collapse='')
  bars <- paste(vapply(seq_along(h$counts),function(i)sprintf(
    '<rect x="%.1f" y="%.1f" width="55" height="%.1f" fill="#7da1c4"/>',
    x(h$breaks[i]),y(h$counts[i]),230-y(h$counts[i])),''),collapse='')
  mean_x <- x(mean(tp$cost_before)); median_x <- x(d8_quantiles[2])
  d8_svg(paste0(
    '<text x="110" y="28" font-size="25">Actual city participants (N = 4,794), before GreenWaste</text>',
    '<text x="28" y="155" text-anchor="middle" font-size="22" transform="rotate(-90 28 155)">Businesses</text>',
    axis,'<line x1="110" x2="990" y1="230" y2="230" stroke="#545860"/>',bars,
    sprintf('<line x1="%.1f" x2="%.1f" y1="75" y2="230" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="58" text-anchor="start" font-size="23" fill="#B8272C">Mean %s</text>',
      mean_x,mean_x,mean_x+8,fmt(mean(tp$cost_before))),
    sprintf('<line x1="%.1f" x2="%.1f" y1="90" y2="230" stroke="#063360" stroke-width="3" stroke-dasharray="6 5"/><text x="%.1f" y="58" text-anchor="end" font-size="23" fill="#063360">Median %s</text>',
      median_x,median_x,median_x-8,fmt(d8_quantiles[2])),
    paste(vapply(seq(0,4500,900),function(v)sprintf('<text x="%.1f" y="262" text-anchor="middle" font-size="22">%s</text>',x(v),fmt(v)),''),collapse=''),
    '<text x="550" y="302" text-anchor="middle" font-size="24">Annual waste cost, AED per business; 300 AED bins</text>'),
    'Actual distribution of before-costs for all 4,794 city participants. Mean 1,432 and median 1,376 AED; not an effect or confidence interval.')
}
d8_selected <- function() {
  values <- ten$landfill_before
  x <- function(v) 90+v/50*920
  dots <- paste(vapply(seq_along(values),function(i) {
    stack <- sum(values[seq_len(i)]==values[i])-1
    sprintf('<circle cx="%.1f" cy="%s" r="11" fill="#215a9e"/>',
      x(values[i]),170-stack*27)
  },''),collapse='')
  d8_svg(paste0(
    '<text x="90" y="28" font-size="25">Ten selected actual records, not a representative city sample</text>',
    '<line x1="90" x2="1010" y1="200" y2="200" stroke="#545860"/>',dots,
    sprintf('<line x1="%.1f" x2="%.1f" y1="70" y2="205" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="57" text-anchor="start" font-size="24">Mean %s</text>',
      x(mean(values)),x(mean(values)),x(mean(values))+6,fmt(mean(values),1)),
    sprintf('<line x1="%.1f" x2="%.1f" y1="90" y2="205" stroke="#063360" stroke-dasharray="6 5" stroke-width="3"/><text x="%.1f" y="57" text-anchor="end" font-size="24">Median %s</text>',
      x(median(values)),x(median(values)),x(median(values))-6,fmt(median(values),1)),
    paste(vapply(seq(0,50,10),function(v)sprintf('<text x="%.1f" y="237" text-anchor="middle" font-size="23">%s</text>',x(v),v),''),collapse=''),
    '<text x="550" y="293" text-anchor="middle" font-size="24">Landfill before GreenWaste, tonnes per business per year</text>'),
    'Ten selected actual before-landfill records: 3, 4, 5, 5, 6, 7, 7, 8, 9 and 46 tonnes. Mean 10 and median 6.5; the largest record raises the mean.')
}
d8_toy <- data.frame(Business=c('Small starting amount','Large starting amount'),
  Before=c(10,90),After=c(2,54))
d8_toy$Fall <- 100*(1-d8_toy$After/d8_toy$Before)
d8_toy_table <- function(answer=FALSE) {
  df <- data.frame(Business=d8_toy$Business,
    'Before tonnes'=d8_toy$Before,'After tonnes'=d8_toy$After,
    'Business fall'=if(answer)paste0(fmt(d8_toy$Fall),'%') else c('_____','_____'),
    check.names=FALSE)
  d8_table(df)
}
d8_land_table <- function() d8_table(data.frame(
  Summary=c('Fall in total participant tonnes','Mean of participant percentage falls'),
  Value=paste0(fmt(c(percent_total,percent_average),1),'%'),
  Weight=c('Starting tonnes: larger starts carry more weight','Each of the 4,794 businesses equally'),
  check.names=FALSE))
d8_pilot <- function(show=TRUE) {
  value <- -case$rct; ci <- sort(-case$rct_ci)
  x <- function(v) 100+v/1400*900
  d8_svg(paste0(
    '<text x="100" y="28" font-size="25">Separate pilot: 400 lottery-assigned businesses, after 12 months</text>',
    '<line x1="100" x2="1000" y1="170" y2="170" stroke="#545860"/>',
    sprintf('<line x1="%.1f" x2="%.1f" y1="60" y2="170" stroke="#B8272C" stroke-width="3" stroke-dasharray="7 5"/><text x="%.1f" y="53" text-anchor="middle" font-size="24">Rule 1,000</text>',x(1000),x(1000),x(1000)),
    if(show)sprintf('<line x1="%.1f" x2="%.1f" y1="105" y2="105" stroke="#215a9e" stroke-width="8"/><text x="%.1f" y="92" text-anchor="end" font-size="24">%s</text><text x="%.1f" y="92" font-size="24">%s</text>',
      x(ci[1]),x(ci[2]),x(ci[1])-8,fmt(ci[1]),x(ci[2])+8,fmt(ci[2])) else '',
    sprintf('<circle cx="%.1f" cy="105" r="9" fill="#063360"/><text x="%.1f" y="146" text-anchor="middle" font-size="24">Estimate %s</text>',x(value),x(value),fmt(value)),
    paste(vapply(seq(0,1400,200),function(v)sprintf('<text x="%.1f" y="204" text-anchor="middle" font-size="22">%s</text>',x(v),fmt(v)),''),collapse=''),
    '<text x="550" y="253" text-anchor="middle" font-size="24">Estimated annual waste-cost reduction per business, AED</text>'),
    if(show)'Pilot estimated annual reduction 1,014 AED; 95 percent confidence interval 862 to 1,167 crosses the 1,000 AED saving rule.' else
      'Pilot point estimate 1,014 AED on an annual cost-reduction scale; interval is deliberately withheld until the reveal.',1100,275)
}
d8_ai <- paste0(
  'Both charts show the same underlying participant means accurately: annual waste cost was about ',
  fmt(ba_mean[1]),' AED before and ',fmt(ba_mean[2]),
  ' AED after, a recorded fall of ',fmt(ba_mean[1]-ba_mean[2]),' AED.\n\n',
  'The truncated-axis chart is often preferable for a policy audience because it makes the difference visible. A zero baseline is not a requirement in professional visualisation, and the labels allow readers to recover the exact values.\n\n',
  'On balance, B communicates the finding more effectively beside "GreenWaste substantially reduced every participant\'s costs." The large visual drop makes the programme effect clear; anyone needing the absolute values can consult the labels.')
d8_prompt <- paste(
  'These two cost bar charts will sit beside the claim "GreenWaste substantially reduced every participant\'s costs" for a non-technical director.',
  'Using only H8-A below, ask me questions before recommending a chart.',
  'Check whether the descriptive before/after means support that sentence, whether "every" and "programme effect" are justified, and how the zero versus 700 AED bar baseline changes perceived size.',
  'Distinguish a chart being numerically accurate from being appropriate for this claim and audience. Do not ban all nonzero axes or confuse distribution spread with confidence intervals.',
  'Suggest a corrected caption naming population, outcome, units, period, comparison and causal limit. Cite source IDs. Source: [paste H8-A pages 1-2; attach or show the two Figure C charts on page 1 if available].')
