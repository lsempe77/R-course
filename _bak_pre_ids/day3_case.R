# Shared Day 3 outputs, fictional assumptions and clinic answers.
source('day2_case.R',encoding='UTF-8')
model <- list(saving=-case$did,cost=1800,lag=1,rate=.05,years=5)
pv_factor <- function(rate=model$rate,years=model$years,decay=0) {
  k<-seq_len(years);sum((1-decay)^(k-1)/(1+rate)^(k+model$lag))
}
ratio <- function(rate=model$rate,years=model$years,decay=0,extra=0,saving=model$saving) saving*pv_factor(rate,years,decay)/(model$cost+extra)
scenarios <- data.frame(card=1:5,name=c('Old habits','Hidden costs','A higher discount rate','A shorter life','Old habits and hidden costs'),
  story=c('Saving shrinks by 30% each year after its first year.','Add 600 AED per business for administration and business time.','Use an 8% discount rate instead of 5%.','Saving lasts three years instead of five.','Saving shrinks 30% each year and costs rise by 600 AED.'),
  value=c(ratio(decay=.3),ratio(extra=600),ratio(rate=.08),ratio(years=3),ratio(decay=.3,extra=600)))
allocation <- c(1:5,1:3)
assumptions <- data.frame(Input=c('Annual saving','One-off cost','When savings start','How long savings last','Discount rate'),
  Value=c(paste(fmt(model$saving),'AED'),paste(fmt(model$cost),'AED'),'Year 2',paste(model$years,'years'),paste0(100*model$rate,'%')),
  Status=c('Provisional DiD estimate','Fictional cost assumption','Assumed','Assumed','Assumed'),check.names=FALSE)
percent_total <- 100*(1-sum(tp$landfill_after)/sum(tp$landfill_before))
percent_average <- mean(100*(1-tp$landfill_after/tp$landfill_before))
read_questions <- c('Who was compared, and how were they chosen?','What assumption supports a claim of cause?','Where do the data come from, and who is missing?','What are the estimate, interval and decision rule?','Does the recommendation go beyond the evidence?')
qa_note <- sprintf('GreenWaste should expand nationally. The pilot estimated a saving of %s AED per business, above our %s AED rule. All methods confirm the programme works, so the evidence is sufficient for approval.',fmt(-case$rct),fmt(decision_rule))
method_rows <- data.frame(Method=c('Pilot lottery','City extra change','Jump near score 58','City matched comparison'),
  'Estimated saving AED'=fmt(-c(case$rct,case$did,rdd[1],match_A$est)),
  '95% interval for saving AED'=c(paste(fmt(sort(-case$rct_ci)),collapse=' to '),paste(fmt(sort(-did_ci)),collapse=' to '),paste(fmt(sort(-rdd_ci)),collapse=' to '),paste(fmt(sort(-match_A$ci)),collapse=' to ')),check.names=FALSE)
answer_bank <- data.frame(Question=c('Which estimate is the headline?','Do all methods confirm the same effect?','Is the minimum saving settled?','Can earlier city trends be checked?','What else jumps at 58?','Are all matched businesses comparable?','Who is missing and how were outcomes measured?','Does the ratio prove value for money?'),
  Answer=c(sprintf('The note selected the pilot point estimate, %s AED saving. It comes from 400 lottery-assigned businesses in one district after 12 months.',fmt(-case$rct)),
    'No. Methods use different comparisons and populations; city methods reuse the same records and are not independent confirmations. Each has assumptions and limitations.',
    sprintf('The pilot interval is %s to %s AED saving and crosses the %s AED rule. The point estimate clears it; the interval does not settle it.',fmt(sort(-case$rct_ci)[1]),fmt(sort(-case$rct_ci)[2]),fmt(decision_rule)),
    'No. The file has one before measure. Several earlier measures and evidence about other changes are needed.',
    sprintf('Pre-programme manager age jumps by about %s years. The extract has no evidence about whether businesses manipulated scores.',fmt(abs(case$age_jump),1)),
    sprintf('All participants get a nearest neighbour without a distance limit. %s different controls are reused, one %s times; manager ages remain %s years apart. Request closeness and support checks.',fmt(match_A$used),fmt(match_A$max_reuse),fmt(match_A$age_gap,1)),
    'The synthetic file has one complete row per generated business. That does not establish real recruitment, follow-up, measurement reliability or representativeness. No fieldwork or attrition documentation is supplied.',
    sprintf('The provisional model gives %.2f under fictional cost and duration assumptions. It uses the city DiD saving, whose causal assumption remains uncertain. Request costs, duration evidence and sensitivity.',ratio())),stringsAsFactors=FALSE)
html_table <- function(df,compact=FALSE) paste0(as.character(knitr::kable(df,format='html',row.names=FALSE,table.attr=if(compact)'class="reading-table compact-table"' else 'class="reading-table"')),fiction)
bar_svg <- function(start=0,labels=TRUE) {
  vals<-ba_mean; ymax<-1600; y<-function(v)250-(v-start)/(ymax-start)*180
  bars<-paste(vapply(1:2,function(i)sprintf('<rect x="%s" y="%.1f" width="155" height="%.1f" fill="#215a9e"/><text x="%s" y="%.1f" text-anchor="middle" font-size="32">%s</text>',c(220,590)[i],y(vals[i]),250-y(vals[i]),c(297,667)[i],y(vals[i])-10,if(labels)fmt(vals[i]) else ''),''),collapse='')
  axis<-if(labels)paste(vapply(seq(start,ymax,length.out=4),function(v)sprintf('<text x="160" y="%.1f" text-anchor="end" font-size="31">%s</text><line x1="180" x2="870" y1="%.1f" y2="%.1f" stroke="#d5dee8"/>',y(v),fmt(v),y(v),y(v)),''),collapse='') else ''
  sprintf('<svg class="reading-chart" viewBox="0 0 1000 350" role="img" aria-label="Two bars of recorded participant costs. Axis starts at %s AED.">%s%s<text x="297" y="290" text-anchor="middle" font-size="32">Before</text><text x="667" y="290" text-anchor="middle" font-size="32">After</text><text x="500" y="335" text-anchor="middle" font-size="26">%s</text></svg>',start,axis,bars,if(labels)paste('City participants | annual cost (AED) | axis starts at',start) else 'Draft chart with missing labels')
}
distribution_svg <- function() {
  # The ten actual landfill records used on Day 1, shown as dots instead of a mean.
  v<-ten$landfill_before;x<-function(a)90+a/50*830
  dots<-paste(vapply(seq_along(v),function(i)sprintf('<circle cx="%.1f" cy="%s" r="12" fill="#215a9e"/>',x(v[i]),if(i%in%c(4,7))110 else 145),''),collapse='')
  sprintf('<svg class="reading-chart" viewBox="0 0 1000 280" role="img" aria-label="Landfill before GreenWaste for ten businesses: %s tonnes. Mean %s."><line x1="90" x2="920" y1="180" y2="180" stroke="#545860"/>%s<line x1="%.1f" x2="%.1f" y1="65" y2="185" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="45" text-anchor="middle" font-size="24">Mean %s</text>%s<text x="500" y="260" text-anchor="middle" font-size="24">Landfill before GreenWaste, tonnes per business per year</text></svg>',paste(v,collapse=', '),fmt(mean(v),1),dots,x(mean(v)),x(mean(v)),x(mean(v)),fmt(mean(v),1),paste(vapply(seq(0,50,10),function(a)sprintf('<text x="%.1f" y="215" text-anchor="middle" font-size="22">%s</text>',x(a),a),''),collapse=''))
}
