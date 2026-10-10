source('day3_case.R', encoding='UTF-8')

d8_table <- function(df, title=NULL) paste0(
  if (!is.null(title)) paste0('<p class="table-title"><strong>', title, '</strong></p>') else '',
  as.character(knitr::kable(df, format='html',
  row.names=FALSE, escape=TRUE, table.attr='class="reading-table"')))
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
      '<text x="290" y="291" text-anchor="middle" font-size="19">Mean annual waste management cost (AED)</text>') else ''),
    if(labels)paste('Mean annual waste management cost of city participant businesses before GreenWaste and 12 months after: 1,432 and 763 AED. The vertical axis starts at',start,'AED. This is a description, not an estimate of the effect of GreenWaste.') else
      'Incomplete draft chart: the values, units, group of businesses and axis labels are hidden until the labels are revealed.',
    550,310)
}
d8_pair <- function(labels=TRUE) paste0(
  '<div class="review-grid chart-pair"><div><h3>Chart A: the vertical axis starts at zero</h3>',d8_bar(0,labels),
  '</div><div><h3>Chart B: the vertical axis starts at 700 AED</h3>',d8_bar(700,labels),'</div></div>')
d8_cost_table <- function(title=NULL) d8_table(data.frame(
  Group='Same 4,794 city participant businesses',
  'Before GreenWaste (AED)'=fmt(ba_mean[1]), '12 months after GreenWaste (AED)'=fmt(ba_mean[2]),
  'Fall in mean cost (AED)'=fmt(ba_mean[1]-ba_mean[2]),
  check.names=FALSE), title)
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
    '<text x="110" y="28" font-size="25">All 4,794 city participant businesses, before GreenWaste</text>',
    '<text x="28" y="155" text-anchor="middle" font-size="22" transform="rotate(-90 28 155)">Number of businesses</text>',
    axis,'<line x1="110" x2="990" y1="230" y2="230" stroke="#545860"/>',bars,
    sprintf('<line x1="%.1f" x2="%.1f" y1="75" y2="230" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="58" text-anchor="start" font-size="23" fill="#B8272C">Mean %s</text>',
      mean_x,mean_x,mean_x+8,fmt(mean(tp$cost_before))),
    sprintf('<line x1="%.1f" x2="%.1f" y1="90" y2="230" stroke="#063360" stroke-width="3" stroke-dasharray="6 5"/><text x="%.1f" y="58" text-anchor="end" font-size="23" fill="#063360">Median %s</text>',
      median_x,median_x,median_x-8,fmt(d8_quantiles[2])),
    paste(vapply(seq(0,4500,900),function(v)sprintf('<text x="%.1f" y="262" text-anchor="middle" font-size="22">%s</text>',x(v),fmt(v)),''),collapse=''),
    '<text x="550" y="302" text-anchor="middle" font-size="24">Annual waste management cost before GreenWaste (AED per business, in 300 AED ranges)</text>'),
    'Histogram of annual waste management cost before GreenWaste for all 4,794 city participant businesses. The mean is 1,432 AED and the median is 1,376 AED. This is variation between businesses. It is not an estimated effect and not a confidence interval.')
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
    '<text x="90" y="28" font-size="25">Ten records selected for teaching. They do not represent the city.</text>',
    '<line x1="90" x2="1010" y1="200" y2="200" stroke="#545860"/>',dots,
    sprintf('<line x1="%.1f" x2="%.1f" y1="70" y2="205" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="57" text-anchor="start" font-size="24">Mean %s</text>',
      x(mean(values)),x(mean(values)),x(mean(values))+6,fmt(mean(values),1)),
    sprintf('<line x1="%.1f" x2="%.1f" y1="90" y2="205" stroke="#063360" stroke-dasharray="6 5" stroke-width="3"/><text x="%.1f" y="57" text-anchor="end" font-size="24">Median %s</text>',
      x(median(values)),x(median(values)),x(median(values))-6,fmt(median(values),1)),
    paste(vapply(seq(0,50,10),function(v)sprintf('<text x="%.1f" y="237" text-anchor="middle" font-size="23">%s</text>',x(v),v),''),collapse=''),
    '<text x="550" y="293" text-anchor="middle" font-size="24">Landfill waste before GreenWaste (tonnes per business per year)</text>'),
    'Landfill waste before GreenWaste in ten selected records: 3, 4, 5, 5, 6, 7, 7, 8, 9 and 46 tonnes per business per year. The mean is 10 and the median is 6.5. The largest value raises the mean.')
}
d8_toy <- data.frame(Business=c('Business with a small starting amount','Business with a large starting amount'),
  Before=c(10,90),After=c(2,54))
d8_toy$Fall <- 100*(1-d8_toy$After/d8_toy$Before)
d8_toy_table <- function(answer=FALSE) {
  df <- data.frame(Business=d8_toy$Business,
    'Before (tonnes)'=d8_toy$Before,'After (tonnes)'=d8_toy$After,
    'Fall (%)'=if(answer)fmt(d8_toy$Fall) else c('_____','_____'),
    check.names=FALSE)
  d8_table(df)
}
d8_land_table <- function(title=NULL) d8_table(data.frame(
  Summary=c('Fall in total participant tonnes','Mean of the percentage falls of the participant businesses'),
  Value=paste0(fmt(c(percent_total,percent_average),1),'%'),
  'How businesses are weighted'=c('Businesses with larger starting amounts count for more','Each of the 4,794 businesses counts equally'),
  check.names=FALSE), title)
d8_pilot <- function(show=TRUE) {
  value <- -case$rct; ci <- sort(-case$rct_ci)
  x <- function(v) 100+v/1400*900
  d8_svg(paste0(
    '<text x="100" y="28" font-size="25">Separate pilot: 400 businesses assigned by lottery, 12 months after GreenWaste</text>',
    '<line x1="100" x2="1000" y1="170" y2="170" stroke="#545860"/>',
    sprintf('<line x1="%.1f" x2="%.1f" y1="60" y2="170" stroke="#B8272C" stroke-width="3" stroke-dasharray="7 5"/><text x="%.1f" y="53" text-anchor="middle" font-size="24">Our rule: 1,000 AED</text>',x(1000),x(1000),x(1000)),
    if(show)sprintf('<line x1="%.1f" x2="%.1f" y1="105" y2="105" stroke="#215a9e" stroke-width="8"/><text x="%.1f" y="92" text-anchor="end" font-size="24">%s</text><text x="%.1f" y="92" font-size="24">%s</text>',
      x(ci[1]),x(ci[2]),x(ci[1])-8,fmt(ci[1]),x(ci[2])+8,fmt(ci[2])) else '',
    sprintf('<circle cx="%.1f" cy="105" r="9" fill="#063360"/><text x="%.1f" y="146" text-anchor="middle" font-size="24">Estimate %s</text>',x(value),x(value),fmt(value)),
    paste(vapply(seq(0,1400,200),function(v)sprintf('<text x="%.1f" y="204" text-anchor="middle" font-size="22">%s</text>',x(v),fmt(v)),''),collapse=''),
    '<text x="550" y="253" text-anchor="middle" font-size="24">Estimated reduction in annual waste management cost per business (AED)</text>'),
    if(show)'Estimated reduction in the pilot: 1,014 AED a year. The 95% interval of 862 to 1,167 AED includes values below our rule of at least a 1,000 AED reduction.' else
      'Pilot estimate of 1,014 AED on a scale of annual reductions in cost. The interval is hidden until it is revealed.',1100,275)
}
d8_ai <- paste0(
  'Both charts show the same underlying participant means accurately: annual waste management cost was about ',
  fmt(ba_mean[1]),' AED before and ',fmt(ba_mean[2]),
  ' AED after, a recorded fall of ',fmt(ba_mean[1]-ba_mean[2]),' AED.\n\n',
  'The chart whose axis does not start at zero is often preferable for a policy audience because it makes the difference visible. A zero baseline is not a requirement in professional visualisation, and the labels allow readers to recover the exact values.\n\n',
  'On balance, B communicates the finding more effectively beside "GreenWaste substantially reduced every participant\'s costs." The large visual drop makes the programme effect clear; anyone needing the absolute values can consult the labels.')
d8_prompt <- paste(
  'These two bar charts of annual waste management cost will sit beside the claim "GreenWaste substantially reduced every participant\'s costs" in a report for a director who is not a technical expert.',
  'Using only H8-A below, ask me questions before you recommend a chart.',
  'Check whether the before and after means support that sentence, whether the words "every" and "programme effect" are justified, and how a zero baseline compared with a baseline of 700 AED changes how large the difference looks.',
  'Separate whether a chart is numerically accurate from whether it suits this claim and audience. Do not say that every axis that does not start at zero is wrong. Do not confuse the spread of a distribution with a confidence interval.',
  'Suggest a corrected caption that names the group of businesses, the outcome, the units, the period, the comparison and the limit on causal claims. Cite the source for each point.',
  'Source: [paste H8-A pages 1 and 2; attach or show the two charts of Figure C from page 1 if you can].')

# ---- Two graphs from evaluation reports (added in the preview) ---------------------
# Scatter plot: cost before against cost after for a random sample of city businesses,
# with a fitted line for each group and a 45-degree "no change" line.
d8_scatter <- function() {
  old <- if (exists('.Random.seed', envir = globalenv())) get('.Random.seed', envir = globalenv()) else NULL
  set.seed(2026); s <- city[sample(nrow(city), 400), ]
  if (!is.null(old)) assign('.Random.seed', old, envir = globalenv())
  lo <- floor(min(s$cost_before, s$cost_after, 0) / 500) * 500
  hi <- ceiling(max(s$cost_before, s$cost_after) / 500) * 500
  x <- function(v) 120 + (v - lo) / (hi - lo) * 300
  y <- function(v) 330 - (v - lo) / (hi - lo) * 300
  col <- function(g) if (g == 1) '#215a9e' else '#8a8f98'
  pts <- paste(sprintf('<circle cx="%.1f" cy="%.1f" r="4" fill="%s" opacity="0.55"/>',
    x(s$cost_before), y(s$cost_after), vapply(s$took_part, col, '')), collapse = '')
  fit_line <- function(g) {
    d <- city[city$took_part == g, ]; f <- coef(lm(cost_after ~ cost_before, data = d))
    r <- range(d$cost_before)
    sprintf('<line x1="%.1f" y1="%.1f" x2="%.1f" y2="%.1f" stroke="%s" stroke-width="4"/>',
      x(r[1]), y(f[1] + f[2] * r[1]), x(r[2]), y(f[1] + f[2] * r[2]), col(g))
  }
  ticks <- seq(ceiling(lo / 2000) * 2000, hi, 2000)
  axis <- paste0(
    paste(sprintf('<text x="%.1f" y="356" text-anchor="middle" font-size="18">%s</text>', x(ticks), fmt(ticks)), collapse = ''),
    paste(sprintf('<text x="112" y="%.1f" text-anchor="end" font-size="18">%s</text>', y(ticks) + 6, fmt(ticks)), collapse = ''))
  d8_svg(paste0(
    '<defs><clipPath id="d8-plot"><rect x="120" y="30" width="300" height="300"/></clipPath></defs><rect x="120" y="30" width="300" height="300" fill="#fff" stroke="#D5DEE8"/><g clip-path="url(#d8-plot)">', pts,
    sprintf('<line x1="%.1f" y1="%.1f" x2="%.1f" y2="%.1f" stroke="#B8272C" stroke-width="2.5" stroke-dasharray="7 5"/>', x(lo), y(lo), x(hi), y(hi)),
    fit_line(0), fit_line(1), '</g>', axis,
    '<text x="270" y="390" text-anchor="middle" font-size="20">Annual waste management cost before GreenWaste (AED)</text>',
    '<text transform="translate(30,180) rotate(-90)" text-anchor="middle" font-size="20">Cost 12 months later (AED)</text>',
    '<g font-size="21"><circle cx="500" cy="90" r="7" fill="#215a9e"/><text x="518" y="97">Participant business</text>',
    '<line x1="492" x2="508" y1="135" y2="135" stroke="#215a9e" stroke-width="4"/><text x="518" y="142">Fitted line, participants</text>',
    '<circle cx="500" cy="190" r="7" fill="#8a8f98"/><text x="518" y="197">Comparison business</text>',
    '<line x1="492" x2="508" y1="235" y2="235" stroke="#8a8f98" stroke-width="4"/><text x="518" y="242">Fitted line, comparison</text>',
    '<line x1="486" x2="510" y1="280" y2="280" stroke="#B8272C" stroke-width="2.5" stroke-dasharray="7 5"/><text x="518" y="287">No change (45 degrees)</text></g>'),
    'Scatter plot of annual waste management cost before GreenWaste (horizontal axis) and 12 months later (vertical axis) for a random sample of 400 city businesses. Each point is one business. Points below the dashed no-change line had a lower cost later. The fitted line for participant businesses lies below the fitted line for comparison businesses.',
    1100, 410)
}

# Forest plot: the estimated reduction and 95% interval from each method, with our rule.
d8_forest <- function() {
  est <- -c(case$rct, case$did, rdd[1], match_A$est)
  ci <- rbind(sort(-case$rct_ci), sort(-did_ci), sort(-rdd_ci), sort(-match_A$ci))
  nm <- c('Pilot lottery', 'City: difference between the two changes (DiD)', 'Jump near score 58', 'City matched comparison')
  x <- function(v) 330 + v / 1500 * 560
  rows <- paste(vapply(1:4, function(i) {
    yy <- 70 + (i - 1) * 62
    sprintf('<text x="20" y="%d" font-size="22">%s</text><line x1="%.1f" x2="%.1f" y1="%d" y2="%d" stroke="#215a9e" stroke-width="6"/><circle cx="%.1f" cy="%d" r="9" fill="#063360"/><text x="%d" y="%d" font-size="19" fill="#545860">%s</text>',
      yy + 6, nm[i], x(ci[i, 1]), x(ci[i, 2]), yy, yy, x(est[i]), yy, 930, yy + 6,
      paste0(fmt(est[i]), ' (', fmt(ci[i, 1]), ' to ', fmt(ci[i, 2]), ')'))
  }, ''), collapse = '')
  d8_svg(paste0(rows,
    sprintf('<line x1="%.1f" x2="%.1f" y1="40" y2="290" stroke="#B8272C" stroke-width="3" stroke-dasharray="7 5"/><text x="%.1f" y="30" text-anchor="middle" font-size="21">Our rule: 1,000 AED</text>', x(1000), x(1000), x(1000)),
    '<line x1="330" x2="890" y1="290" y2="290" stroke="#545860"/>',
    paste(vapply(seq(0, 1500, 500), function(v) sprintf('<text x="%.1f" y="318" text-anchor="middle" font-size="20">%s</text>', x(v), fmt(v)), ''), collapse = ''),
    '<text x="610" y="352" text-anchor="middle" font-size="21">Estimated reduction in annual waste management cost per business (AED)</text>'),
    'Forest plot of the estimated reduction in annual waste management cost from four methods, each with a 95% interval, and a dashed line at our rule of 1,000 AED.',
    1100, 370)
}
