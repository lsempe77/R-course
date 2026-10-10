# Source-linked pilot figures for the separate Day 1 Session 3 review.
source('day1_case.R', encoding='UTF-8')
s3_join <- pilot[pilot$took_part==1, ]
s3_wait <- pilot[pilot$took_part==0, ]
s3_means <- rbind(Join=colMeans(s3_join[c('cost_before','cost_after')]),
                  Wait=colMeans(s3_wait[c('cost_before','cost_after')]))
s3_ages <- pilot$manager_age[1:20]
s3_escape <- function(x) gsub('<','&lt;',gsub('&','&amp;',x,fixed=TRUE),fixed=TRUE)
s3_paragraphs <- function(x) paste0('<p>',gsub('\n\n','</p><p>',s3_escape(x),fixed=TRUE),'</p>')
s3_svg <- function(body,label,h=310) paste0('<svg class="review-svg" viewBox="0 0 1100 ',h,
  '" role="img" aria-label="',label,'">',body,'</svg>')
s3_flow <- function() s3_svg(paste0(
  '<rect x="290" y="10" width="520" height="75" rx="8" fill="#e3ebf5"/><text x="550" y="42" text-anchor="middle" font-size="28" fill="#063360">400 eligible pilot businesses</text><text x="550" y="70" text-anchor="middle" font-size="24">One district; scores 58 or below</text>',
  '<path d="M550 85V120H260V150M550 120H840V150" fill="none" stroke="#545860" stroke-width="3"/><rect x="395" y="90" width="310" height="28" fill="white"/><text x="550" y="113" text-anchor="middle" font-size="22" fill="#063360">Lottery for 200 places</text>',
  '<rect x="40" y="155" width="440" height="125" rx="8" fill="#215a9e"/><text x="260" y="200" text-anchor="middle" font-size="30" fill="white">200 in the treatment group</text><text x="260" y="242" text-anchor="middle" font-size="25" fill="white">Receive GreenWaste</text>',
  '<rect x="620" y="155" width="440" height="125" rx="8" fill="#D5DEE8"/><text x="840" y="200" text-anchor="middle" font-size="30">200 in the control group</text><text x="840" y="242" text-anchor="middle" font-size="25">No GreenWaste during the study</text>'),
  '400 eligible businesses in one pilot district; a lottery assigns exactly 200 to the treatment group and 200 to the control group.')
s3_baseline <- function() {
  breaks <- seq(0,ceiling(max(pilot$cost_before)/250)*250,250)
  hh <- lapply(list(s3_join$cost_before,s3_wait$cost_before),function(v)hist(v,breaks=breaks,plot=FALSE,right=FALSE))
  x <- function(v) 125+v/max(breaks)*930
  y <- function(v) 240-v/50*145
  bars <- paste(vapply(1:2,function(g)paste(vapply(seq_along(hh[[g]]$counts),function(i)sprintf(
    '<rect x="%.1f" y="%.1f" width="%.1f" height="%.1f" fill="%s"/>',
    x(breaks[i])+(g-1)*(x(250)-x(0))/2,y(hh[[g]]$counts[i]),(x(250)-x(0))/2-1,
    240-y(hh[[g]]$counts[i]),c('#215a9e','#7f8995')[g]),''),collapse=''),''),collapse='')
  ticks <- paste(vapply(seq(0,max(breaks),500),function(v)sprintf('<text x="%.1f" y="271" text-anchor="middle" font-size="24">%s</text>',x(v),fmt(v)),''),collapse='')
  ys <- paste(vapply(c(0,25,50),function(v)sprintf('<text x="110" y="%.1f" text-anchor="end" font-size="22">%s</text>',y(v)+6,fmt(v)),''),collapse='')
  s3_svg(paste0('<text x="125" y="25" font-size="22">Number of businesses in each 250 AED band</text>',
    '<text x="125" y="58" font-size="25" fill="#215a9e">Treatment group: mean ',fmt(s3_means[1,1]),' AED</text><text x="600" y="58" font-size="25" fill="#545860">Control group: mean ',fmt(s3_means[2,1]),' AED</text>',
    bars,ticks,ys,'<line x1="125" x2="1055" y1="240" y2="240" stroke="#545860"/><text x="590" y="309" text-anchor="middle" font-size="25">Annual waste management cost before GreenWaste (AED per business)</text>'),
    'Pilot baseline annual waste management cost: treatment group (200 businesses), mean 1,390 AED; control group (200 businesses), mean 1,411 AED. Similar but not identical.')
}
set.seed(713)
s3_draws <- lapply(c(20,400),function(n) replicate(200,{
  v <- sample(pilot$manager_age,n,replace=FALSE)
  mean(v[seq_len(n/2)])-mean(v[(n/2+1):n])
}))
s3_sizes <- function(both=FALSE) {
  x <- function(v) 130+(v+15)/30*900
  dots <- paste(vapply(if(both)1:2 else 1,function(g) {
    yy <- c(95,215)[g]
    paste0(sprintf('<text x="130" y="%.1f" font-size="26">%s businesses: %s in the treatment group, %s in the control group</text>',yy-35,
      c(20,400)[g],c(10,200)[g],c(10,200)[g]),
      paste(vapply(seq_along(s3_draws[[g]]),function(i)sprintf('<circle cx="%.1f" cy="%.1f" r="4" fill="%s" opacity="0.6"/>',x(s3_draws[[g]][i]),yy+((i%%7)-3)*5,c('#215a9e','#545860')[g]),''),collapse=''))
  },''),collapse='')
  ticks <- paste(vapply(seq(-15,15,5),function(v)sprintf('<text x="%.1f" y="282" text-anchor="middle" font-size="25">%s</text>',x(v),v),''),collapse='')
  s3_svg(paste0('<line x1="580" x2="580" y1="45" y2="250" stroke="#B8272C" stroke-dasharray="6 5"/><text x="580" y="27" text-anchor="middle" font-size="23">Same mean age</text>',dots,
    '<line x1="130" x2="1030" y1="253" y2="253" stroke="#545860"/>',ticks,
    '<text x="580" y="318" text-anchor="middle" font-size="24">Treatment group minus control group: difference in mean manager age (years)</text>'),
    'Illustration: 200 practice lotteries per size using pilot manager ages. Smaller lotteries have more variable age differences.',330)
}
s3_after <- function() {
  x <- c(320,805); y <- function(v) 250-v/2500*185
  axis <- paste(vapply(seq(0,2500,500),function(v)sprintf('<line x1="145" x2="1015" y1="%.1f" y2="%.1f" stroke="#D5DEE8"/><text x="130" y="%.1f" text-anchor="end" font-size="24">%s</text>',y(v),y(v),y(v)+7,fmt(v)),''),collapse='')
  bars <- paste(vapply(1:2,function(i)sprintf('<rect x="%.1f" y="%.1f" width="180" height="%.1f" fill="%s"/><text x="%.1f" y="%.1f" text-anchor="middle" font-size="30">%s</text><text x="%.1f" y="281" text-anchor="middle" font-size="26">%s</text>',x[i]-90,y(s3_means[i,2]),250-y(s3_means[i,2]),c('#215a9e','#7f8995')[i],x[i],y(s3_means[i,2])-15,fmt(s3_means[i,2]),x[i],c('Treatment group','Control group')[i]),''),collapse='')
  s3_svg(paste0('<text x="145" y="27" font-size="25">Mean annual waste management cost, 12 months after GreenWaste (AED)</text>',axis,bars,
    '<text x="580" y="317" text-anchor="middle" font-size="24">200 businesses in each group, assigned by lottery</text>'),
    'Pilot means 12 months after GreenWaste: treatment group 769 AED; control group 1,783 AED. The axis begins at zero.',330)
}
s3_regression <- function() {
  fit <- case_env$rct_fit; ci <- confint(fit); ss <- summary(fit)$coefficients
  df <- data.frame('Result row'=c('Control group: mean cost after 12 months','Treatment group minus control group'),
    'Coefficient (AED)'=fmt(coef(fit)),
    '95% interval (AED)'=vapply(1:2,function(i)paste(fmt(ci[i,1]),'to',fmt(ci[i,2])),''),
    'p-value'=vapply(ss[,4],function(p)if(p<.001)'&lt; 0.001' else fmt(p,3),''),check.names=FALSE)
  paste0('<p class="table-title"><strong>Annual waste management cost 12 months after GreenWaste: treatment group (200 businesses) compared with control group (200 businesses) (AED)</strong></p><table class="reading-table"><thead><tr>',paste0('<th>',names(df),'</th>',collapse=''),
    '</tr></thead><tbody>',paste(vapply(1:2,function(i)paste0('<tr>',paste0('<td>',df[i,],'</td>',collapse=''),'</tr>'),''),collapse=''),
    '</tbody></table><p class="caption">The pilot has 400 businesses, 200 in each group, with annual waste management cost measured 12 months after GreenWaste. The model compares the two group means (ordinary least squares). The control group is the reference, so the first row is the control group\'s mean cost. The second row is the difference between the treatment group and the control group. It is not the treatment group\'s own mean. A negative difference in cost means a reduction in cost, which is a saving.</p>')
}
s3_comparisons <- function() paste0('<p class="table-title"><strong>Three comparisons from three groups of businesses: difference in annual waste management cost (AED)</strong></p><table class="reading-table"><thead><tr><th>Businesses</th><th>Comparison</th><th>Difference (AED)</th></tr></thead><tbody>',
  '<tr><td>City participant businesses</td><td>The same businesses, after minus before</td><td>-669</td></tr>',
  '<tr><td>City participant businesses and comparison businesses</td><td>Participant minus comparison businesses, after the programme</td><td>-1,638</td></tr>',
  '<tr><td>Eligible pilot businesses</td><td>Treatment group minus control group, after 12 months</td><td>-1,014<br>95% interval: -1,167 to -862</td></tr></tbody></table>')
s3_interval_svg <- function(...) {
  x <- interval_svg(...)
  x <- gsub('Rule 1,000', 'Our rule: 1,000 AED reduction', x, fixed = TRUE)
  gsub('Annual saving per business (AED)', 'Annual reduction in cost per business (AED)', x, fixed = TRUE)
}
s3_ai <- paste0('The GreenWaste pilot provides credible evidence of lower waste costs. Four hundred eligible businesses were allocated by lottery, and after twelve months the treatment group averaged 769 AED compared with 1,783 AED in the control group. The estimated annual saving is 1,014 AED per business, with a 95% confidence interval of 862 to 1,167 AED and p < 0.001.\n\n',
  'This randomised design is stronger than a simple before-and-after comparison. The saving exceeds the authority\'s 1,000 AED rule, and the statistically significant result confirms that the required saving has been achieved. Because the lottery removes selection bias, the same gain can be expected across city businesses.\n\n',
  'The study covers one district, so expansion should be phased and monitored. Even with that caveat, the trial demonstrates that a national rollout will offer good value for money. The minister can therefore approve expansion while collecting implementation feedback.')
s3_prompt <- paste0('Help write advice for a minister considering wider GreenWaste delivery. Use only H3-A: 400 eligible businesses in one pilot district, with scores of 58 or below, individually assigned, 200 to the treatment group and 200 to the control group. Annual waste management cost was measured 12 months after GreenWaste. Assignment equals participation, and all 400 businesses have cost records after 12 months. The estimated reduction is 1,014 AED per business, with a 95% interval of 862 to 1,167 AED. Our rule is a reduction in annual waste management cost of at least 1,000 AED per business per year. Full programme costs and results elsewhere are not supplied.\n\n',
  'Ask any essential clarifying questions first. Then draft three sentences: the finding and the comparison; a recommendation, or a condition that fits the size of the decision; and the most important limit, with a specific request for evidence. Separate evidence of some reduction from certainty that the reduction is at least 1,000 AED. Do not treat random assignment as a representative sample, and do not assert nationwide value for money. Cite H3-A.')
s3_fallback <- paste0('Before making a recommendation, I would ask which businesses and delivery conditions the proposed expansion would cover, what programme costs it would incur, and how the authority wants to handle uncertainty around our rule of at least a 1,000 AED reduction.\n\n',
  'H3-A reports a randomised comparison among eligible businesses in one pilot district: annual waste management cost after twelve months was about 1,014 AED lower in the treatment group than in the control group, with a 95% interval for the reduction of 862 to 1,167 AED. A limited next stage with evaluation is a defensible option, subject to the authority\'s costs and risk tolerance, because the interval includes reductions below our rule of at least 1,000 AED. Before broader approval, request evidence on delivery costs and on how the intended businesses differ from this pilot. The pilot alone does not show national effects or value for money.')
stopifnot(nrow(s3_join)==200,nrow(s3_wait)==200,all(pilot$score<=58),
          round(case$rct)==-1014,all(round(sort(-case$rct_ci))==c(862,1167)),
          max(abs(unlist(s3_draws)))<15)
