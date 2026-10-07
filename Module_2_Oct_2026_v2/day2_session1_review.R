# Corrected city data and native visuals for the separate DiD review.
source('day1_case.R', encoding='UTF-8')
d4_long <- data.frame(business=rep(city$business,2),after=rep(0:1,each=nrow(city)),
  took_part=rep(city$took_part,2),cost=c(city$cost_before,city$cost_after))
d4_fit <- estimatr::lm_robust(cost~after*took_part,data=d4_long,
  clusters=business,se_type='stata')
d4_ci <- unname(confint(d4_fit)['after:took_part',])
d4_means <- rbind(Participants=colMeans(city[took,c('cost_before','cost_after')]),
  Others=colMeans(city[!took,c('cost_before','cost_after')]))
d4_changes <- d4_means[,2]-d4_means[,1]
d4_counterfactual <- d4_means[1,1]+d4_changes[2]
d4_escape <- function(x) gsub('<','&lt;',gsub('&','&amp;',x,fixed=TRUE),fixed=TRUE)
d4_paragraphs <- function(x)paste0('<p>',gsub('\n\n','</p><p>',d4_escape(x),fixed=TRUE),'</p>')
d4_svg <- function(body,label,w=1100,h=330)paste0('<svg class="review-svg" viewBox="0 0 ',w,' ',h,
  '" role="img" aria-label="',label,'">',body,'</svg>')
d4_lines <- function(assumption=FALSE,blank=FALSE) {
  x <- c(260,795);y <- function(v)255-v/3000*180
  axis <- paste(vapply(seq(0,3000,1000),function(v)sprintf('<line x1="150" x2="1020" y1="%.1f" y2="%.1f" stroke="#D5DEE8"/><text x="130" y="%.1f" text-anchor="end" font-size="25">%s</text>',y(v),y(v),y(v)+7,fmt(v)),''),collapse='')
  lines <- if(blank)'' else paste(vapply(1:2,function(i){
    a<-d4_means[i,];col<-c('#215a9e','#545860')[i]
    paste0(sprintf('<line x1="260" x2="795" y1="%.1f" y2="%.1f" stroke="%s" stroke-width="5"/>',y(a[1]),y(a[2]),col),
      paste(vapply(1:2,function(j)sprintf('<circle cx="%s" cy="%.1f" r="7" fill="%s"/><text x="%s" y="%.1f" text-anchor="middle" font-size="29" fill="%s">%s</text>',x[j],y(a[j]),col,x[j],y(a[j])+if(i==1&&j==2)32 else -14,col,fmt(a[j])),''),collapse=''))
  },''),collapse='')
  assumed <- if(!assumption||blank)'' else sprintf('<line x1="260" x2="795" y1="%.1f" y2="%.1f" stroke="#215a9e" stroke-width="4" stroke-dasharray="10 7"/><circle cx="795" cy="%.1f" r="7" fill="white" stroke="#215a9e" stroke-width="3"/><text x="795" y="%.1f" text-anchor="middle" font-size="27" fill="#215a9e">%s assumed</text><line x1="850" x2="850" y1="%.1f" y2="%.1f" stroke="#B8272C" stroke-width="4"/><text x="870" y="%.1f" font-size="27" fill="#B8272C">%s AED</text>',
    y(d4_means[1,1]),y(d4_counterfactual),y(d4_counterfactual),y(d4_counterfactual)-14,
    fmt(d4_counterfactual),y(d4_counterfactual),y(d4_means[1,2]),(y(d4_counterfactual)+y(d4_means[1,2]))/2+8,fmt(abs(case$did)))
  d4_svg(paste0('<text x="150" y="28" fill="#215a9e" font-size="26">Participants (4,794)</text><text x="620" y="28" fill="#545860" font-size="26">Other businesses (5,206)</text>',axis,
    '<line x1="500" x2="500" y1="60" y2="255" stroke="#7da1c4" stroke-dasharray="5 5"/><text x="500" y="54" text-anchor="middle" font-size="22">Programme starts</text>',lines,assumed,
    '<text x="260" y="294" text-anchor="middle" font-size="26">Before</text><text x="795" y="294" text-anchor="middle" font-size="26">12 months after</text><text x="580" y="327" text-anchor="middle" font-size="25">Mean annual waste cost per business (AED)</text>'),
    if(blank)'Blank city comparison axes: label the four group means, changes and assumed untreated path.' else
    if(assumption)'Actual city means plus an assumed untreated participant after-cost of 1,575 AED under parallel trends; gap to observed 763 is 812 AED.' else
    'Actual city mean annual costs: participants 1,432 to 763 AED; other businesses 2,258 to 2,401 AED. Two waves only.')
}
d4_regression <- function() {
  rows <- c('(Intercept)','after','took_part','after:took_part');ci<-confint(d4_fit)
  labels<-c('Other group, before','Other group\'s change','Participant gap, before','Extra change: after x participant')
  df<-data.frame(Row=labels,'Coefficient AED'=fmt(coef(d4_fit)[rows]),
    '95% interval AED'=vapply(rows,function(r)paste(fmt(ci[r,1]),'to',fmt(ci[r,2])),''),
    'p-value'=vapply(d4_fit$p.value[match(rows,names(coef(d4_fit)))],function(p)if(p<.001)'&lt; 0.001' else fmt(p,3),''),check.names=FALSE)
  paste0('<table class="reading-table"><thead><tr>',paste0('<th>',names(df),'</th>',collapse=''),
    '</tr></thead><tbody>',paste(vapply(1:4,function(i)paste0('<tr>',paste0('<td>',df[i,],'</td>',collapse=''),'</tr>'),''),collapse=''),
    '</tbody></table><p class="caption">10,000 city businesses, two measurements each. Model: cost ~ after * took_part; business-clustered robust intervals (Stata correction). Reference: other businesses before the programme. The interaction is the extra change.</p>')
}
d4_interval <- function() {
  estimate<-abs(case$did);ci<-sort(-d4_ci);x<-function(v)120+v/1200*890
  ticks<-paste(vapply(seq(0,1200,200),function(v)sprintf('<text x="%.1f" y="181" text-anchor="middle" font-size="26">%s</text>',x(v),fmt(v)),''),collapse='')
  d4_svg(paste0('<line x1="120" x2="1010" y1="150" y2="150" stroke="#545860"/>',ticks,
    sprintf('<line x1="%.1f" x2="%.1f" y1="45" y2="150" stroke="#B8272C" stroke-width="3" stroke-dasharray="7 5"/><text x="%.1f" y="28" text-anchor="middle" font-size="26" fill="#B8272C">Rule 1,000</text>',x(1000),x(1000),x(1000)),
    sprintf('<line x1="%.1f" x2="%.1f" y1="85" y2="85" stroke="#215a9e" stroke-width="8"/><circle cx="%.1f" cy="85" r="9" fill="#063360"/><text x="%.1f" y="65" text-anchor="end" font-size="27">%s</text><text x="%.1f" y="65" font-size="27">%s</text><text x="%.1f" y="125" text-anchor="middle" font-size="27" font-weight="bold">Estimate %s</text>',x(ci[1]),x(ci[2]),x(estimate),x(ci[1])-9,fmt(ci[1]),x(ci[2])+9,fmt(ci[2]),x(estimate),fmt(estimate)),
    '<text x="565" y="229" text-anchor="middle" font-size="25">Extra annual cost reduction per participant (AED)</text>'),
    'DiD estimate on a positive reduction scale: 812 AED, 95 percent interval 792 to 833; all below the fictional 1,000 AED rule.',1100,240)
}
d4_trend <- function(type=1) {
  # Both pictures are hypothetical histories on identical axes.
  a<-if(type==1)c(1250,1350,1450) else c(1750,1550,1350);b<-c(2150,2250,2350)
  xx<-c(80,260,440);y<-function(v)205-v/3000*130
  lines<-paste(vapply(1:2,function(i){v<-list(a,b)[[i]];col<-c('#215a9e','#545860')[i]
    sprintf('<polyline points="%s" fill="none" stroke="%s" stroke-width="4"/>',paste(paste(xx,y(v),sep=','),collapse=' '),col)},''),collapse='')
  ticks<-paste(vapply(seq(0,3000,1000),function(v)sprintf('<text x="62" y="%.1f" text-anchor="end" font-size="20">%s</text>',y(v)+6,fmt(v)),''),collapse='')
  d4_svg(paste0('<text x="80" y="22" fill="#215a9e" font-size="21">Participants</text><text x="280" y="22" fill="#545860" font-size="21">Other group</text>',ticks,lines,
    '<line x1="80" x2="475" y1="205" y2="205" stroke="#545860"/><text x="80" y="238" text-anchor="middle" font-size="20">Earlier 2</text><text x="260" y="238" text-anchor="middle" font-size="20">Earlier 1</text><text x="440" y="238" text-anchor="middle" font-size="20">Before</text><text x="275" y="273" text-anchor="middle" font-size="21">Mean annual costs (AED); all pre-programme</text>'),
    if(type==1)'Hypothetical A: groups start at different levels and increase by the same amounts before the programme.' else 'Hypothetical B: participants were already falling while the other group was rising before the programme.',550,285)
}
d4_timeline <- function() d4_svg(paste0('<line x1="200" x2="900" y1="110" y2="110" stroke="#7da1c4" stroke-width="4"/>',
  '<circle cx="200" cy="110" r="12" fill="#063360"/><circle cx="900" cy="110" r="12" fill="#063360"/>',
  '<text x="200" y="70" text-anchor="middle" font-size="28">One before measure</text><text x="900" y="70" text-anchor="middle" font-size="28">One after measure</text>',
  '<text x="550" y="168" text-anchor="middle" font-size="27">No earlier sequence to compare</text><text x="550" y="216" text-anchor="middle" font-size="25">The hypothetical A/B histories are not in this file.</text>'),
  'Actual GreenWaste city data have one before measure and one after measure; earlier trends cannot be checked.',1100,250)
d4_ai <- paste0('The regression reports a difference-in-differences estimate: participants\' annual costs fell by 669 AED while other businesses\' costs rose by 143 AED. The extra reduction is 812 AED per participant, with a 95% interval of 792 to 833 AED and p < 0.001. Comparing changes is stronger than simply comparing cost levels after the programme.\n\n',
  'The different starting costs are accounted for, and parallel trends is satisfied because both groups were followed over the same period. The small p-value and interval excluding zero confirm that the finding is robust and GreenWaste caused the extra saving.\n\n',
  'Implementation should still be monitored, particularly in new districts. The result clears the authority\'s 1,000 AED minimum, so expansion is justified; the precise estimate gives confidence that a wider rollout will meet this target.')
d4_prompt <- paste0('Explain H4-A to a policy adviser considering GreenWaste expansion. The outcome is annual waste cost in AED per business. There are 4,794 city participants and 5,206 other businesses, selected by the score rule rather than lottery. The DiD extra reduction is 812 AED, with a 95% interval of 792 to 833 AED. The file has one before wave and one 12-month follow-up: it cannot show earlier trends. Parallel trends is an assumption, not a reported check. The fictional minimum is 1,000 AED annual saving.\n\n',
  'Ask essential clarifying questions first. Then give three short points: what the comparison and interaction coefficient show; what must be credible for a causal reading; and whether the estimate and interval meet the rule. Cite H4-A and request specific missing evidence. Do not invent a pre-trend test or treat precision as proof of robustness or national reach.')
d4_fallback <- paste0('Before advising on expansion, I would ask for earlier cost measurements in both groups and information on other changes that might have affected them differently. I would also ask whether the same businesses and comparable cost measurements were retained.\n\n',
  'H4-A reports an extra mean cost reduction of about 812 AED per participant: the participant change of -669 AED minus the other-group change of +143 AED. The model\'s 95% reduction interval is 792 to 833 AED. A programme-effect reading requires credible parallel trends and the other stated design conditions; one pre-period cannot show whether earlier trends were similar.\n\n',
  'Both the estimate and interval are below the fictional 1,000 AED minimum, conditional on the model. Precision does not resolve the causal assumption. I would request earlier measures and evidence on competing changes before relying on the causal interpretation; this table alone does not justify claiming that the minimum is met or that the result transfers nationwide.')
stopifnot(abs(coef(d4_fit)['after:took_part']-case$did)<1e-6,
  round(case$did)==-812,all(round(sort(-d4_ci))==c(792,833)),round(d4_counterfactual)==1575)
