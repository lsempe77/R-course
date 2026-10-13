# Separate RDD review: actual city records, preserved activity seeds, native SVGs.
source('day1_case.R', encoding='UTF-8')
d5_near <- subset(city,abs(score-58)<=2)
d5_wide <- subset(city,abs(score-58)<=5)
d5_model <- function(width=2,outcome='cost_after') {
  d<-subset(city,abs(score-58)<=width);d$below<-as.integer(d$score<=58);d$distance<-d$score-58
  lm(reformulate('below * distance',outcome),data=d)
}
d5_card <- function(seed) {
  set.seed(seed)
  b<-city[sample(which(city$score>57 & city$score<=58),6),]
  a<-city[sample(which(city$score>58 & city$score<=59),6),]
  list(rows=data.frame('Score at or below 58'=fmt(b$score,1),'Cost AED'=fmt(round(b$cost_after,-1)),
    'Score above 58'=fmt(a$score,1),'Cost AED '=fmt(round(a$cost_after,-1)),check.names=FALSE),
    below=mean(round(b$cost_after,-1)),above=mean(round(a$cost_after,-1)))
}
d5_cards<-lapply(c(A=4,B=11,C=37,D=22,E=9,F=21,G=33,H=5),d5_card)
d5_jumps<-sapply(d5_cards,function(x)x$below-x$above)
d5_escape<-function(x)gsub('<','&lt;',gsub('&','&amp;',x,fixed=TRUE),fixed=TRUE)
d5_paragraphs<-function(x)paste0('<p>',gsub('\n\n','</p><p>',d5_escape(x),fixed=TRUE),'</p>')
d5_svg<-function(body,label,h=360)paste0('<svg class="review-svg" viewBox="0 0 1100 ',h,'" role="img" aria-label="',label,'">',body,'</svg>')
d5_plot<-function(width=2,fit=FALSE,age=FALSE,jump=TRUE,steps=FALSE) {
  d<-d5_wide;v<-if(age)d$manager_age else d$cost_after
  ymax<-if(age)80 else ceiling(max(v)/1000)*1000
  y<-function(z)280-z/ymax*200;x<-function(z)130+(z-53)/10*850
  axis<-paste(vapply(if(age)seq(0,80,20) else seq(0,ymax,2000),function(z)sprintf('<line x1="130" x2="980" y1="%.1f" y2="%.1f" stroke="#D5DEE8"/><text x="112" y="%.1f" font-size="24" text-anchor="end">%s</text>',y(z),y(z),y(z)+7,fmt(z)),''),collapse='')
  ticks<-paste(vapply(seq(53,63,1),function(z)sprintf('<text x="%.1f" y="313" text-anchor="middle" font-size="24">%s</text>',x(z),z),''),collapse='')
  inside<-abs(d$score-58)<=width;col<-ifelse(!inside,'#bac7d6',ifelse(d$score<=58,'#215a9e','#545860'))
  points<-paste(sprintf('<circle cx="%.1f" cy="%.1f" r="2.8" fill="%s" opacity="%s"/>',x(d$score),y(v),col,ifelse(inside,'.45','.18')),collapse='')
  lines<-''
  if(fit) {
    f<-d5_model(width,if(age)'manager_age' else 'cost_after');co<-coef(f)
    left<-function(z)co[1]+co['below']+(co['distance']+co['below:distance'])*(z-58)
    right<-function(z)co[1]+co['distance']*(z-58)
    left_line<-sprintf('<line x1="%.1f" x2="%.1f" y1="%.1f" y2="%.1f" stroke="#215a9e" stroke-width="5"/>',x(58-width),x(58),y(left(58-width)),y(left(58)))
    right_line<-sprintf('<line x1="%.1f" x2="%.1f" y1="%.1f" y2="%.1f" stroke="#545860" stroke-width="5"/>',x(58),x(58+width),y(right(58)),y(right(58+width)))
    if(steps) {
      left_line<-paste0('<g class="fragment" data-fragment-index="0">',left_line,'</g>')
      right_line<-paste0('<g class="fragment" data-fragment-index="1">',right_line,'</g>')
    }
    gap<-if(!jump)'' else sprintf('<line x1="%.1f" x2="%.1f" y1="%.1f" y2="%.1f" stroke="#B8272C" stroke-width="5"/><text x="%.1f" y="%.1f" font-size="24" fill="#B8272C">Jump %s %s</text>',x(58)+10,x(58)+10,y(left(58)),y(right(58)),x(58)+28,(y(left(58))+y(right(58)))/2-8,fmt(co['below'],if(age)1 else 0),if(age)'years' else 'AED')
    lines<-paste0(left_line,right_line,gap)
  }
  d5_svg(paste0(sprintf('<rect x="%.1f" y="60" width="%.1f" height="220" fill="#e3ebf5"/>',x(58-width),x(58+width)-x(58-width)),
    '<text x="130" y="26" font-size="25" fill="#215a9e">At/below 58: participant businesses</text><text x="620" y="26" font-size="25" fill="#545860">Above 58: comparison businesses</text>',axis,points,
    sprintf('<line x1="%.1f" x2="%.1f" y1="48" y2="280" stroke="#B8272C" stroke-dasharray="6 5"/><text x="%.1f" y="53" text-anchor="middle" font-size="22">Cut-off 58</text>',x(58),x(58),x(58)),lines,ticks,
    sprintf('<text x="560" y="353" font-size="25" text-anchor="middle">Efficiency score (higher means more efficient); %s</text>',if(age)'pre-programme manager age (years)' else 'waste cost after GreenWaste (AED)')),
    paste(if(age)'Pre-programme manager age' else 'Annual waste management cost 12 months after GreenWaste','against score; data shown from 53 to 63; shaded window plus/minus',width,'points; fitted lines',fit))
}
d5_table<-function() {
  a<-case$rdd2
  paste0('<table class="reading-table"><thead><tr><th>Result row</th><th>Coefficient AED</th><th>95% interval AED</th><th>Businesses</th></tr></thead><tbody><tr><td>At/below cut-off: local jump</td><td>',fmt(a[1]),'</td><td>',fmt(a[2]),' to ',fmt(a[3]),'</td><td>',fmt(a[4]),'</td></tr></tbody></table><p class="caption">Cost 12 months after GreenWaste ~ below * distance; distance = score - 58. Separate linear slopes; window 56-60; HC2 robust interval. Reference: fitted cost above the cut-off at 58. The coefficient compares the fitted limits at the cut-off.</p>')
}
d5_windows<-function() {
  paste0('<table class="reading-table"><thead><tr><th>Window</th><th>Businesses</th><th>Jump AED</th><th>95% interval AED</th></tr></thead><tbody>',paste(vapply(1:2,function(i){a<-list(case$rdd2,case$rdd5)[[i]];paste0('<tr><td>Within ',c(2,5)[i],' points</td><td>',fmt(a[4]),'</td><td>',fmt(a[1]),'</td><td>',fmt(a[2]),' to ',fmt(a[3]),'</td></tr>')},''),collapse=''),'</tbody></table>')
}
d5_interval<-function() {
  x<-function(v)130+v/1200*850;a<-sort(-case$rdd2[2:3]);est<--case$rdd2[1]
  d5_svg(paste0('<line x1="130" x2="980" y1="145" y2="145" stroke="#545860"/>',paste(vapply(seq(0,1200,200),function(v)sprintf('<text x="%.1f" y="181" text-anchor="middle" font-size="25">%s</text>',x(v),fmt(v)),''),collapse=''),
    sprintf('<line x1="%.1f" x2="%.1f" y1="38" y2="145" stroke="#B8272C" stroke-dasharray="6 5"/><text x="%.1f" y="26" font-size="26" text-anchor="middle" fill="#B8272C">Rule 1,000</text><line x1="%.1f" x2="%.1f" y1="80" y2="80" stroke="#215a9e" stroke-width="7"/><circle cx="%.1f" cy="80" r="8" fill="#063360"/><text x="%.1f" y="62" text-anchor="end" font-size="26">%s</text><text x="%.1f" y="62" font-size="26">%s</text><text x="%.1f" y="123" text-anchor="middle" font-size="27">Estimate %s</text>',x(1000),x(1000),x(1000),x(a[1]),x(a[2]),x(est),x(a[1])-10,fmt(a[1]),x(a[2])+10,fmt(a[2]),x(est),fmt(est)),
    '<text x="560" y="229" text-anchor="middle" font-size="25">Local annual cost reduction at the cut-off (AED)</text>'),
    'Local reduction estimate 721 AED, robust interval 498 to 943, below the 1000 rule; model uncertainty does not resolve design concerns.',240)
}
d5_sorting<-function() {
  vals<-c(18,20,22,40,9,21,20,18);xs<-seq(200,830,length.out=8)
  bars<-paste(sprintf('<rect x="%.1f" y="%.1f" width="65" height="%.1f" fill="%s"/>',xs,230-vals*3,vals*3,c(rep('#215a9e',4),rep('#545860',4))),collapse='')
  d5_svg(paste0('<text x="550" y="28" text-anchor="middle" font-size="27">Hypothetical bunching near a score rule</text>',bars,
    '<line x1="545" x2="545" y1="50" y2="230" stroke="#B8272C" stroke-dasharray="6 5"/><text x="545" y="267" text-anchor="middle" font-size="25">Cut-off 58</text><text x="250" y="267" text-anchor="middle" font-size="24">Lower scores</text><text x="830" y="267" text-anchor="middle" font-size="24">Higher scores</text><text x="550" y="309" text-anchor="middle" font-size="24">Illustrative counts, not GreenWaste data or a diagnostic test</text>'),
    'Hypothetical score-count pattern with bunching just below the score cut-off; for illustration only, no GreenWaste manipulation test is supplied.',320)
}
d5_board<-function(raw=FALSE) {
  ticks<-paste(vapply(seq(-2000,1000,500),function(v)sprintf('<line x1="%.1f" x2="%.1f" y1="80" y2="90" stroke="#545860"/><text x="%.1f" y="120" font-size="23" text-anchor="middle">%s</text>',100+(v+2000)/3000*900,100+(v+2000)/3000*900,100+(v+2000)/3000*900,fmt(v)),''),collapse='')
  markers<-if(!raw)'' else paste(vapply(seq_along(d5_jumps),function(i)sprintf('<circle cx="%.1f" cy="85" r="5" fill="#215a9e"/><text x="%.1f" y="%s" text-anchor="middle" font-size="23">%s</text>',100+(d5_jumps[i]+2000)/3000*900,100+(d5_jumps[i]+2000)/3000*900,c(47,71,147,171)[(i-1)%%4+1],names(d5_jumps)[i]),''),collapse='')
  paste0('<svg id="rdd-board" viewBox="0 0 1100 380" role="img" aria-label="Two-lane number line: raw card gaps above, fitted regression jump below"><text x="100" y="25" font-size="26">Raw gaps: six businesses per side</text><line x1="100" x2="1000" y1="85" y2="85" stroke="#545860"/>',ticks,'<g id="raw-markers"',if(raw)' hidden' else '','>',markers,'</g><text x="100" y="197" font-size="26">Fitted local jump: 545 businesses, separate slopes</text><line x1="100" x2="1000" y1="260" y2="260" stroke="#545860"/><g id="fit-marker" hidden>',
    sprintf('<line x1="%.1f" x2="%.1f" y1="260" y2="260" stroke="#215a9e" stroke-width="7"/><circle cx="%.1f" cy="260" r="9" fill="#063360"/><text x="%.1f" y="310" text-anchor="middle" font-size="27">%s; interval %s to %s AED</text>',100+(case$rdd2[2]+2000)/3000*900,100+(case$rdd2[3]+2000)/3000*900,100+(case$rdd2[1]+2000)/3000*900,100+(case$rdd2[1]+2000)/3000*900,fmt(case$rdd2[1]),fmt(case$rdd2[2]),fmt(case$rdd2[3])),
    '</g><text x="550" y="365" font-size="25" text-anchor="middle">At/below minus above (AED); negative means lower costs</text></svg>')
}
d5_ai<-paste0('The score threshold provides a regression discontinuity comparison. The fitted annual cost immediately below the cut-off is 721 AED lower than immediately above it, with a robust 95% interval of 498 to 943 AED lower. A wider five-point window also gives lower fitted costs, which is a useful sensitivity comparison.\n\n',
  'Businesses on either side of the threshold are effectively interchangeable because their scores are close. The manager-age difference is a background characteristic and does not affect this conclusion; adjusting for it would remove any remaining selection bias. The stable direction across windows confirms that the threshold isolates the programme effect.\n\n',
  'Implementation costs and practical capacity should still be checked. However, because most participants have scores below 58, this result describes the typical participant and supports citywide expansion. The interval is precise enough to show that the 1,000 AED saving requirement is met.')
d5_prompt<-paste0('Explain H5-A without jargon to a policy adviser considering expansion. Businesses with a score at or below 58 took part; the local linear model uses scores 56-60 and 545 businesses, with separate slopes. The jump is -721 AED in annual waste cost 12 months after GreenWaste, HC2 interval -943 to -498; as a reduction this is 721, interval 498-943. Most city participants are outside this local window. Pre-programme manager age jumps by about -5.3 years in the five-point window. No score-setting/manipulation diagnostic is supplied. The fictional annual-saving minimum is 1,000 AED.\n\n',
  'Ask essential clarifying questions first. Explain who the local comparison describes, what the coefficient and interval show, and what evidence is needed for a causal reading. Distinguish rule compliance from comparison validity. Request specific missing evidence; do not dismiss the age check, promise that adjustment fixes it, generalise citywide or claim that the saving minimum is met. Cite H5-A.')
d5_fallback<-paste0('Before recommending expansion, I would ask how scores were assigned and recorded, whether businesses could influence them, and why manager age differs at the same threshold. I would also ask for other pre-programme checks and reasons for the chosen local window.\n\n',
  'H5-A compares fitted annual waste management costs 12 months after GreenWaste, immediately either side of score 58, using 545 businesses in scores 56-60 and separate slopes. It reports 721 AED lower cost on the participating side, with a model-based robust interval of 498 to 943 AED lower. A programme-effect reading requires a credible local comparison without other important jumps or sorting at the cut-off. The age discontinuity is a concern, not proof of a particular bias; controlling for age alone does not establish validity.\n\n',
  'A similar wider-window result is useful but does not settle these concerns. This is evidence near the cut-off, not an estimated average effect for all city participants. Both the estimate and interval are below the fictional 1,000 AED minimum, conditional on the model. I would investigate the design concern before relying on a causal interpretation, and request evidence for businesses further from the cut-off before extrapolating.')
stopifnot(round(case$rdd2[1])==-721,all(round(case$rdd2[2:3])==c(-943,-498)),case$rdd2[4]==545,
  case$rdd5[4]==1260,all(city$took_part==as.integer(city$score<=58)))
