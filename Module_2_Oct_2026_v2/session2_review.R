# Native figures and source material for the separate Session 2 review.
source('day1_case.R', encoding = 'UTF-8')
others <- city[!took, ]
s2_means <- rbind(Participants = colMeans(tp[c('cost_before','cost_after')]),
                  Others = colMeans(others[c('cost_before','cost_after')]))
s2_rows <- city[match(c('B00401','B00402','B00403','B00404'),city$business), ]
s2_escape <- function(x) gsub('<','&lt;',gsub('&','&amp;',x,fixed=TRUE),fixed=TRUE)
s2_paragraphs <- function(x) paste0('<p>',paste(strsplit(x,'\n\n',fixed=TRUE)[[1]],collapse='</p><p>'),'</p>')
s2_table <- function(rows=FALSE) {
  df <- if(rows) data.frame(Business=s2_rows$business,'Efficiency score'=fmt(s2_rows$score,1),
    Participation=ifelse(s2_rows$took_part==1,'Took part','Did not take part'),
    'Before (AED)'=fmt(s2_rows$cost_before),'After (AED)'=fmt(s2_rows$cost_after),check.names=FALSE) else
    data.frame(Group=c('Participant businesses (took part)','Comparison businesses (did not take part)'),Businesses=c('4,794','5,206'),
      'Before (AED)'=fmt(s2_means[,1]),'After (AED)'=fmt(s2_means[,2]),
      'Change (AED)'=fmt(s2_means[,2]-s2_means[,1]),check.names=FALSE)
  ttl <- if(rows) 'H2-A1: Four selected businesses: efficiency score, whether the business took part, and annual waste management cost before and 12 months after (AED)' else
    'H2-A2: Mean annual waste management cost before and 12 months after GreenWaste, for participant businesses and comparison businesses (AED)'
  paste0('<p class="table-title"><strong>',ttl,'</strong></p><table class="reading-table"><thead><tr>',paste0('<th>',names(df),'</th>',collapse=''),
    '</tr></thead><tbody>',paste(vapply(seq_len(nrow(df)),function(i)
      paste0('<tr>',paste0('<td>',df[i,],'</td>',collapse=''),'</tr>'),''),collapse=''),'</tbody></table>')
}
s2_svg <- function(body,label,w=1100,h=330) paste0('<svg class="review-svg" viewBox="0 0 ',w,' ',h,
  '" role="img" aria-label="',label,'">',body,'</svg>')
s2_hist <- function(change=FALSE,markers=FALSE) {
  values <- if(change) tp$cost_after-tp$cost_before else city$cost_before
  breaks <- if(change) seq(floor(min(values)/250)*250,ceiling(max(values)/250)*250,250) else seq(0,6000,250)
  hh <- hist(values,breaks=breaks,plot=FALSE,right=FALSE)
  limits <- range(breaks); x <- function(v) 85+(v-limits[1])/diff(limits)*960
  top <- ceiling(max(hh$counts)/100)*100; y <- function(v) 255-v/top*185
  bars <- paste(vapply(seq_along(hh$counts),function(i)sprintf(
    '<rect x="%.1f" y="%.1f" width="%.1f" height="%.1f" fill="#7da1c4" stroke="white"/>',
    x(hh$breaks[i]),y(hh$counts[i]),x(hh$breaks[i+1])-x(hh$breaks[i]),255-y(hh$counts[i])),''),collapse='')
  ticks <- if(change) seq(ceiling(limits[1]/1000)*1000,floor(limits[2]/1000)*1000,1000) else seq(0,6000,1000)
  axis <- paste(vapply(ticks,function(v)sprintf('<text x="%.1f" y="283" text-anchor="middle" font-size="21">%s</text>',x(v),fmt(v)),''),collapse='')
  ya <- paste(vapply(c(0,top/2,top),function(v)sprintf('<text x="72" y="%.1f" text-anchor="end" font-size="20">%s</text>',y(v)+6,fmt(v)),''),collapse='')
  marks <- if(change) sprintf('<line x1="%.1f" x2="%.1f" y1="60" y2="255" stroke="#B8272C" stroke-width="3"/><text x="%.1f" y="45" text-anchor="middle" font-size="23" fill="#B8272C">No change</text>',x(0),x(0),x(0)) else if(markers)
    sprintf('<line x1="%.1f" x2="%.1f" y1="65" y2="255" stroke="#063360" stroke-width="3"/><line x1="%.1f" x2="%.1f" y1="65" y2="255" stroke="#B8272C" stroke-width="3" stroke-dasharray="7 5"/><text x="200" y="43" font-size="23" fill="#063360">Mean %s</text><text x="610" y="43" font-size="23" fill="#B8272C">Median %s</text>',x(mean(values)),x(mean(values)),x(median(values)),x(median(values)),fmt(mean(values)),fmt(median(values))) else ''
  ttl <- if(change) 'Histogram of the change in annual waste management cost for the 4,794 participant businesses (AED)' else
    'Histogram of annual waste management cost before GreenWaste for all 10,000 city businesses (AED, in bands of 250 AED)'
  paste0('<p class="table-title"><strong>',ttl,'</strong></p>', s2_svg(paste0('<text x="85" y="23" font-size="20">Number of businesses</text>',bars,marks,ya,axis,
    '<line x1="85" x2="1045" y1="255" y2="255" stroke="#545860"/>',
    '<text x="565" y="322" text-anchor="middle" font-size="23">',if(change)'Change in annual waste management cost: after minus before (AED)' else 'Annual waste management cost before GreenWaste (AED)','</text>'),
    if(change)'Changes in annual waste management cost for all 4,794 city participant businesses; values on both sides of zero.' else 'Annual waste management cost before GreenWaste for all 10,000 city businesses; 250 AED bands.'))
}
s2_counts <- function() {
  s2_svg(paste0('<text x="75" y="55" font-size="25">All city businesses: 10,000</text>',
    '<rect x="75" y="90" width="455.43" height="95" fill="#215a9e"/><rect x="530.43" y="90" width="494.57" height="95" fill="#D5DEE8"/>',
    '<text x="300" y="145" text-anchor="middle" fill="white" font-size="27">4,794 participant businesses</text><text x="780" y="145" text-anchor="middle" font-size="27">5,206 comparison businesses</text>',
    '<text x="300" y="230" text-anchor="middle" font-size="25">Score 58 or below</text><text x="780" y="230" text-anchor="middle" font-size="25">Score above 58</text>',
    '<text x="550" y="290" text-anchor="middle" font-size="23">Participation followed a score rule, not a city lottery.</text>'),
    'City businesses: 4,794 participant businesses with score 58 or below; 5,206 comparison businesses with score above 58.')
}
s2_lines <- function(group='both',baseline=TRUE) {
  x <- c(330,875); y <- function(v) 265-v/3000*215
  axis <- paste(vapply(seq(0,3000,1000),function(v)sprintf('<line x1="180" x2="990" y1="%.1f" y2="%.1f" stroke="#D5DEE8"/><text x="165" y="%.1f" text-anchor="end" font-size="21">%s</text>',y(v),y(v),y(v)+7,fmt(v)),''),collapse='')
  lines <- paste(vapply(seq_len(2),function(i) {
    if(group=='participants'&&i==2||group=='others'&&i==1)return('')
    a <- s2_means[i,]; col <- c('#215a9e','#545860')[i]
    label <- c('Participant businesses','Comparison businesses')[i]
    path <- if(baseline)sprintf('<line x1="330" x2="875" y1="%.1f" y2="%.1f" stroke="%s" stroke-width="5"/>',y(a[1]),y(a[2]),col) else ''
    dots <- paste(vapply(if(baseline)1:2 else 2,function(j)sprintf('<circle cx="%.1f" cy="%.1f" r="8" fill="%s"/><text x="%.1f" y="%.1f" text-anchor="middle" font-size="25" fill="%s">%s</text>',x[j],y(a[j]),col,x[j],y(a[j])-17,col,fmt(a[j])),''),collapse='')
    paste0(path,dots,sprintf('<text x="190" y="%s" font-size="23" fill="%s">%s</text>',if(i==1)29 else 55,col,label))
  },''),collapse='')
  description <- if(!baseline) 'After the programme only: participant businesses 763; comparison businesses 2,401.' else
    if(group=='participants') 'Participant businesses 1,432 before to 763 after.' else
    if(group=='others') 'Comparison businesses 2,258 before to 2,401 after.' else
    'Participant businesses 1,432 to 763; comparison businesses 2,258 to 2,401.'
  s2_svg(paste0(axis,lines,'<text x="330" y="302" text-anchor="middle" font-size="24">Before</text><text x="875" y="302" text-anchor="middle" font-size="24">12 months after</text><text x="180" y="325" font-size="20">Mean annual waste management cost per business (AED). The scale starts at zero.</text>'),
    paste('City mean annual costs in AED.',description))
}
s2_cards <- c(
  sprintf('Annual waste costs among GreenWaste participants fell by %s AED per business in a year.',fmt(-case$before_after)),
  sprintf('The effect of GreenWaste is a %s AED reduction in annual cost per business, with a 95%% confidence interval of %s to %s AED saved.',fmt(-case$before_after),fmt(-ba_ci[2]),fmt(-ba_ci[1])),
  'The fall in participants\' costs is statistically significant (p < 0.001), so every business in the country should join GreenWaste.',
  sprintf('Mean annual costs fell by %s AED among participant businesses and rose by %s AED among comparison businesses.',fmt(-case$before_after),fmt(mean(others$change))))
s2_card_sources <- c('H2-A2, the mean cost of the same participant businesses before and after.',
  'The city before-and-after model: the same 4,794 participant businesses, measured twice. The model has no comparison businesses.',
  'The city before-and-after model, which tests whether the mean change among participant businesses is zero.',
  'H2-A2, the mean change in each of the two groups. This card gives no interval for the difference between the groups.')
s2_ai <- paste0('The chart shows a strong improvement: participant businesses\' average annual waste cost fell from 1,432 to 763 AED, while costs for comparison businesses rose from 2,258 to 2,401 AED. The participant reduction of 669 AED is therefore unlikely to be just a city-wide fall in waste costs.\n\n',
  'After a year, participant businesses paid 1,638 AED less than comparison businesses. This is the saving attributable to GreenWaste, because the comparison businesses show what would have happened without it. It exceeds the authority\'s 1,000 AED annual saving rule.\n\n',
  'The two groups began at different cost levels, so caution is appropriate. However, the chart\'s diverging lines confirm that the programme worked across participant businesses. A wider rollout should deliver similar savings, with monitoring to check delivery quality.')
s2_prompt <- paste0('Help a policy adviser read H2-A2 for a decision on expanding GreenWaste. The outcome is mean annual waste management cost per business in AED, measured before GreenWaste and 12 months after. The city has 4,794 participant businesses (score 58 or below) and 5,206 comparison businesses that did not receive GreenWaste (score above 58). They were selected by the score rule, not by a lottery. The groups started at different cost levels. Our rule is a reduction of at least 1,000 AED in annual waste management cost per business per year, caused by the programme.\n\n',
  'Ask any essential clarifying questions first. Then give three short points: the before-and-after change and the difference between the two groups after the programme; what these comparisons cannot show; and one specific piece of evidence to request before making a recommendation. Cite H2-A2. Do not assume that the comparison businesses show what would have happened to participant businesses without GreenWaste. Do not assume that a mean describes every business. Do not assume that these results apply nationwide.')
s2_fallback <- paste0('Before I advise on expansion, I would ask how the efficiency scores were determined, whether other changes affected the two groups differently, and what evidence supports using the comparison businesses to estimate participant businesses\' costs without GreenWaste.\n\n',
  'H2-A2 records a 669 AED mean fall among participant businesses and a 143 AED mean rise among comparison businesses. After the programme, the participant businesses\' mean cost is 1,638 AED lower than the comparison businesses\' mean cost. But the participant businesses already had lower mean costs before the programme (1,432 AED, compared with 2,258 AED). Neither the before-and-after change nor the difference between the groups after the programme is, on its own, a credible estimate of a saving caused by GreenWaste.\n\n',
  'The group means do not show that every business improved or that national expansion would produce the same result. Before I judge whether GreenWaste meets our rule of at least a 1,000 AED reduction in annual waste management cost per business per year, I would request evidence for a fair comparison. The chart is useful descriptive evidence, but it is not enough by itself for a decision on expansion.')
stopifnot(nrow(tp)==4794,nrow(others)==5206,round(case$before_after)==-669,
          round(case$with_without)==-1638,sum(tp$change>0)==485)
