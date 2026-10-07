# Values and native SVG figures for the separate Session 1 review prototype.
# The approved live sources and generators are not modified by this file.
source('day1_case.R', encoding = 'UTF-8')
review_ids <- c('B06703','B08019','B07004','B01415','B02039',
                'B00533','B04597','B04071','B01361','B09368')
review_ten <- city[match(review_ids, city$business), ]
review_costs <- review_ten$cost_before
stopifnot(!anyNA(review_costs), all(review_ten$took_part == 1))
review_mean <- mean(review_costs)
review_median <- median(review_costs)
review_without <- review_costs[-which.max(review_costs)]
review_ai <- paste0(
  'The city data show a substantial improvement in participants\' annual waste costs: ',
  'the average fell from 1,432 AED before GreenWaste to 763 AED twelve months later. ',
  'The reported change is -669 AED, with a 95% confidence interval of -684 to -654 AED ',
  'and p < 0.001. This is strong statistical evidence against a zero mean change.\n\n',
  'Because the same businesses were measured twice, their starting differences are ',
  'accounted for, so the programme can be credited with this reduction. The narrow ',
  'interval suggests the finding is robust, and most individual businesses can ',
  'expect savings in this range.\n\n',
  'The recorded saving is below the authority\'s 1,000 AED minimum, but the very ',
  'small p-value makes a compelling case for expansion. A phased rollout with ',
  'monitoring would be prudent to confirm the result in other locations.'
)
review_prompt <- paste0(
  'Help me read the supplied GreenWaste city before/after table for a director. ',
  'The outcome is annual waste cost in AED per business, measured before and ',
  '12 months after. The same 4,794 participants were measured twice; no ',
  'non-participant comparison is supplied here. The fictional decision rule is ',
  'at least 1,000 AED annual saving per business.\n\n',
  'Ask me any essential clarifying questions before recommending action. ',
  'Separate recorded change, statistical uncertainty, causal attribution and ',
  'policy importance. Explain the coefficient, confidence interval and p-value ',
  'in plain language. Cite the table for factual claims; do not invent missing ',
  'evidence or assume the interval describes individual businesses.'
)
review_fallback <- paste0(
  'Before advising expansion, I need to know what happened to a credible ',
  'comparison group and whether the 1,000 AED rule is intended as the sole ',
  'decision criterion.\n\n',
  'The table reports a mean cost change of -669 AED among these city participants ',
  'over 12 months, with a 95% interval of -684 to -654 AED. This is a statistically ',
  'clear recorded fall under the model, but before/after alone does not isolate ',
  'what GreenWaste caused. The interval concerns the estimated mean change, ',
  'not the spread of individual savings, and it does not cover every source of bias.\n\n',
  'The p-value is evidence against the tested zero-change model under its ',
  'assumptions; it does not establish cause or practical importance. The recorded ',
  'saving and its interval fall below 1,000 AED. That does not establish that ',
  'GreenWaste\'s causal effect is below the rule. Request comparison evidence ',
  'before attributing the fall, and cost/delivery evidence before recommending expansion.'
)
review_escape <- function(x) {
  x <- gsub('&', '&amp;', x, fixed=TRUE)
  x <- gsub('<', '&lt;', x, fixed=TRUE)
  gsub('>', '&gt;', x, fixed=TRUE)
}
review_paragraphs <- function(x) paste0('<p>',gsub('\n\n','</p><p>',review_escape(x),fixed=TRUE),'</p>')
review_svg <- function(body, height=260, label='Teaching figure') paste0(
  '<svg class="review-svg" viewBox="0 0 1100 ',height,'" role="img" aria-label="',
  review_escape(label),'" xmlns="http://www.w3.org/2000/svg">',body,'</svg>')
review_text <- function(x,y,t,size=22,colour='#111418',anchor='start',weight=400)
  sprintf('<text x="%s" y="%s" font-size="%s" fill="%s" text-anchor="%s" font-weight="%s">%s</text>',x,y,size,colour,anchor,weight,review_escape(t))
review_line <- function(x1,y1,x2,y2,colour='#D5DEE8',width=2,dash='')
  sprintf('<line x1="%s" y1="%s" x2="%s" y2="%s" stroke="%s" stroke-width="%s"%s/>',x1,y1,x2,y2,colour,width,if(nzchar(dash))paste0(' stroke-dasharray="',dash,'"')else'')
review_dots <- function(remove=FALSE, markers=TRUE) {
  vals <- if(remove) review_without else review_costs
  x <- function(v) 60+v/4500*980
  dots <- paste(vapply(seq_along(vals),function(i){
    yy <- 110-(i%%2)*25
    sprintf('<circle cx="%.1f" cy="%s" r="9" fill="#215a9e"/>',x(vals[i]),yy)
  },''),collapse='')
  axis <- paste(vapply(seq(0,4000,1000),function(v)paste0(review_line(x(v),160,x(v),170,'#545860'),review_text(x(v),195,fmt(v),21,anchor='middle')),''),collapse='')
  marks <- if(markers) paste0(review_line(x(mean(vals)),55,x(mean(vals)),160,'#B8272C',3),
    review_text(x(mean(vals))+9,42,paste('Mean',fmt(mean(vals),1)),23,'#B8272C'),
    review_line(x(median(vals)),120,x(median(vals)),160,'#063360',3,'5 4'),
    review_text(x(median(vals))-8,143,paste('Median',fmt(median(vals))),21,'#063360','end')) else ''
  review_svg(paste0(review_line(60,160,1040,160,'#545860'),axis,dots,marks,
    review_text(550,239,'Selected businesses: annual waste cost before GreenWaste (AED)',22,anchor='middle')),260,
    'Selected business costs; mean and median markers when revealed. Same cost scale before and after removing the largest record.')
}
review_intervals <- function(values, low, high, labels, xmax=2000, rule=NULL, zero=TRUE, xmin=NULL) {
  if(is.null(xmin)) xmin <- min(0,low)
  x <- function(v) 260+(v-xmin)/(xmax-xmin)*770
  h <- 80+length(values)*80
  marks <- paste(vapply(seq(xmin,xmax,length.out=5),function(v)paste0(review_line(x(v),h-45,x(v),h-39,'#545860'),review_text(x(v),h-14,fmt(v),20,anchor='middle')),''),collapse='')
  body <- paste0(review_line(260,h-45,1030,h-45,'#545860'),marks)
  if(zero && xmin<0)body <- paste0(body,review_line(x(0),20,x(0),h-45,'#7da1c4',2,'5 4'))
  if(!is.null(rule))body <- paste0(body,review_line(x(rule),20,x(rule),h-45,'#B8272C',3,'7 5'),review_text(x(rule),18,paste('Rule',fmt(rule)),19,'#B8272C','middle'))
  for(i in seq_along(values)) {
    y <- 50+(i-1)*80
    body <- paste0(body,review_text(20,y+7,labels[i],22),review_line(x(low[i]),y,x(high[i]),y,'#215a9e',7),
      sprintf('<circle cx="%.1f" cy="%s" r="8" fill="#063360"/>',x(values[i]),y),
      review_text(20,y+30,paste(fmt(low[i]),'to',fmt(high[i])),19))
  }
  review_svg(body,h,'Estimates and 95 percent intervals on a common labelled scale.')
}
review_coverage <- function() {
  set.seed(812); centres <- rnorm(20,1000,70);lo<-centres-1.96*70;hi<-centres+1.96*70
  x<-function(v)120+(v-650)/700*850
  body<-paste0(review_line(x(1000),30,x(1000),335,'#063360',2,'5 4'),review_text(x(1000)+9,20,'Fixed true mean in this simulation',21))
  for(i in seq_along(centres))body<-paste0(body,review_line(x(lo[i]),30+i*14,x(hi[i]),30+i*14,if(lo[i]<=1000&&hi[i]>=1000)'#215a9e'else'#B8272C',4))
  body<-paste0(body,review_text(120,350,paste(sum(lo<=1000&hi>=1000),'of these 20 intervals cover the true mean.'),22),
    review_text(120,379,'The procedure targets 95% coverage over many repeated samples, under assumptions.',20))
  review_svg(body,400,'Hypothetical repeated-sample confidence intervals; some miss the fixed true mean.')
}
review_null <- function() {
  x<-function(z)130+(z+4)/8*840;y<-function(z)205-dnorm(z)/dnorm(0)*150
  zs<-seq(-4,4,length.out=160)
  path<-paste(sprintf('%.1f,%.1f',x(zs),y(zs)),collapse=' ')
  body<-paste0('<polyline points="',path,'" fill="none" stroke="#215a9e" stroke-width="4"/>',review_line(130,205,970,205,'#545860'),
    review_line(x(-2.5),60,x(-2.5),205,'#B8272C',3,'6 4'),review_line(x(2.5),60,x(2.5),205,'#B8272C',3,'6 4'),
    review_text(x(0),236,'0: no mean change',22,anchor='middle'),review_text(130,280,'Hypothetical null model: p includes both tails at least as extreme as the observed change.',20),
    review_text(130,312,sprintf('Here |z| = 2.5 gives p = %.3f. This is not the GreenWaste result.',2*pnorm(-2.5)),20))
  review_svg(body,340,'Hypothetical sampling distribution under zero mean change, with two-sided extreme values marked.')
}
review_table <- function() paste0(regression_table(),
  '<p class="caption">H1-A &#183; 4,794 city participants, two measurements each. Model: cost = intercept + coefficient &times; after (0 before; 1 after). Uncertainty clustered by business.</p>')
