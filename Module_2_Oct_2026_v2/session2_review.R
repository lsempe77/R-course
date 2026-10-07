# Native figures and source material for the separate Session 2 review.
source('day1_case.R', encoding = 'UTF-8')
others <- city[!took, ]
s2_means <- rbind(Participants = colMeans(tp[c('cost_before','cost_after')]),
                  Others = colMeans(others[c('cost_before','cost_after')]))
s2_rows <- city[match(c('B00401','B00402','B00403','B00404'),city$business), ]
s2_escape <- function(x) gsub('<','&lt;',gsub('&','&amp;',x,fixed=TRUE),fixed=TRUE)
s2_paragraphs <- function(x) paste0('<p>',paste(strsplit(x,'\n\n',fixed=TRUE)[[1]],collapse='</p><p>'),'</p>')
s2_table <- function(rows=FALSE) {
  df <- if(rows) data.frame(Business=s2_rows$business,Score=fmt(s2_rows$score,1),
    Participation=ifelse(s2_rows$took_part==1,'Took part','Did not take part'),
    'Before AED'=fmt(s2_rows$cost_before),'After AED'=fmt(s2_rows$cost_after),check.names=FALSE) else
    data.frame(Group=c('Took part','Did not take part'),Businesses=c('4,794','5,206'),
      'Before AED'=fmt(s2_means[,1]),'After AED'=fmt(s2_means[,2]),
      'Change AED'=fmt(s2_means[,2]-s2_means[,1]),check.names=FALSE)
  paste0('<table class="reading-table"><thead><tr>',paste0('<th>',names(df),'</th>',collapse=''),
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
  s2_svg(paste0('<text x="85" y="23" font-size="20">Number of businesses</text>',bars,marks,ya,axis,
    '<line x1="85" x2="1045" y1="255" y2="255" stroke="#545860"/>',
    '<text x="565" y="322" text-anchor="middle" font-size="23">',if(change)'After minus before: annual cost change (AED)' else 'Annual waste cost before GreenWaste (AED)','</text>'),
    if(change)'Cost changes for all 4,794 city participants; values on both sides of zero.' else 'Baseline annual costs for all 10,000 city businesses; 250 AED bins.')
}
s2_counts <- function() {
  s2_svg(paste0('<text x="75" y="55" font-size="25">All city businesses: 10,000</text>',
    '<rect x="75" y="90" width="455.43" height="95" fill="#215a9e"/><rect x="530.43" y="90" width="494.57" height="95" fill="#D5DEE8"/>',
    '<text x="300" y="145" text-anchor="middle" fill="white" font-size="29">4,794 took part</text><text x="780" y="145" text-anchor="middle" font-size="29">5,206 did not</text>',
    '<text x="300" y="230" text-anchor="middle" font-size="25">Score 58 or below</text><text x="780" y="230" text-anchor="middle" font-size="25">Score above 58</text>',
    '<text x="550" y="290" text-anchor="middle" font-size="23">Participation followed a score rule, not a city lottery.</text>'),
    'City sample: 4,794 participants with score 58 or below; 5,206 nonparticipants above 58.')
}
s2_lines <- function(group='both',baseline=TRUE) {
  x <- c(330,875); y <- function(v) 265-v/3000*215
  axis <- paste(vapply(seq(0,3000,1000),function(v)sprintf('<line x1="180" x2="990" y1="%.1f" y2="%.1f" stroke="#D5DEE8"/><text x="165" y="%.1f" text-anchor="end" font-size="21">%s</text>',y(v),y(v),y(v)+7,fmt(v)),''),collapse='')
  lines <- paste(vapply(seq_len(2),function(i) {
    if(group=='participants'&&i==2||group=='others'&&i==1)return('')
    a <- s2_means[i,]; col <- c('#215a9e','#545860')[i]
    label <- c('Took part','Did not take part')[i]
    path <- if(baseline)sprintf('<line x1="330" x2="875" y1="%.1f" y2="%.1f" stroke="%s" stroke-width="5"/>',y(a[1]),y(a[2]),col) else ''
    dots <- paste(vapply(if(baseline)1:2 else 2,function(j)sprintf('<circle cx="%.1f" cy="%.1f" r="8" fill="%s"/><text x="%.1f" y="%.1f" text-anchor="middle" font-size="25" fill="%s">%s</text>',x[j],y(a[j]),col,x[j],y(a[j])-17,col,fmt(a[j])),''),collapse='')
    paste0(path,dots,sprintf('<text x="190" y="%s" font-size="23" fill="%s">%s</text>',if(i==1)29 else 55,col,label))
  },''),collapse='')
  description <- if(!baseline) 'After only: participants 763; others 2,401.' else
    if(group=='participants') 'Participants 1,432 before to 763 after.' else
    if(group=='others') 'Nonparticipants 2,258 before to 2,401 after.' else
    'Participants 1,432 to 763; nonparticipants 2,258 to 2,401.'
  s2_svg(paste0(axis,lines,'<text x="330" y="302" text-anchor="middle" font-size="24">Before</text><text x="875" y="302" text-anchor="middle" font-size="24">12 months after</text><text x="180" y="325" font-size="20">Mean annual waste cost per business (AED); common scale starts at zero.</text>'),
    paste('City mean annual costs in AED.',description))
}
s2_cards <- c(
  sprintf('Annual waste costs among GreenWaste participants fell by %s AED per business in a year.',fmt(-case$before_after)),
  sprintf('The effect of GreenWaste is a %s AED reduction in annual cost per business, with a 95%% confidence interval of %s to %s AED saved.',fmt(-case$before_after),fmt(-ba_ci[2]),fmt(-ba_ci[1])),
  'The fall in participants\' costs is statistically significant (p < 0.001), so every business in the country should join GreenWaste.',
  sprintf('Mean annual costs fell by %s AED among participants and rose by %s AED among other city businesses.',fmt(-case$before_after),fmt(mean(others$change))))
s2_card_sources <- c('H2-A, group means: same participants before and after.',
  'City before/after model: same 4,794 participants measured twice; no nonparticipant comparison in this model.',
  'City before/after model: null is zero mean change among participants.',
  'H2-A, group means: separate before/after changes in the two city groups. No interval for their difference is supplied on this card.')
s2_ai <- paste0('The chart shows a strong improvement: participants\' average annual waste cost fell from 1,432 to 763 AED, while costs for nonparticipants rose from 2,258 to 2,401 AED. The participant reduction of 669 AED is therefore unlikely to be just a city-wide fall in waste costs.\n\n',
  'After a year, participating businesses paid 1,638 AED less than nonparticipants. This is the saving attributable to GreenWaste, because the other city businesses show what would have happened without it. It exceeds the authority\'s 1,000 AED annual saving rule.\n\n',
  'The two groups began at different cost levels, so caution is appropriate. However, the chart\'s diverging lines confirm that the programme worked across participating businesses. A wider rollout should deliver similar savings, with monitoring to check delivery quality.')
s2_prompt <- paste0('Help a policy adviser read H2-A for a decision on expanding GreenWaste. The outcome is mean annual waste cost per business in AED, before and 12 months after. The city has 4,794 participants (score 58 or below) and 5,206 nonparticipants (score above 58). Participation was not random. The groups started at different cost levels. Our fictional rule is at least 1,000 AED annual saving caused by the programme.\n\n',
  'Ask essential clarifying questions first. Then give three short points: the recorded changes and after-only gap; what these comparisons cannot establish; and a specific evidence request before a recommendation. Cite H2-A. Do not assume nonparticipants are a valid counterfactual, a mean describes every business, or these results apply nationwide.')
s2_fallback <- paste0('Before advising on expansion, I would ask how participation scores were determined, whether other changes affected the groups differently, and what evidence supports using nonparticipants to estimate participants\' costs without GreenWaste.\n\n',
  'H2-A records a 669 AED mean fall among participants and a 143 AED mean rise among other city businesses. The after-only mean gap is 1,638 AED, but participants already had lower mean costs before the programme (1,432 versus 2,258 AED). Neither the participant before/after change nor the after-only gap alone is a credible causal saving.\n\n',
  'The group means do not show that every business improved or that national expansion would produce the same result. I would request evidence for a fair comparison before judging a caused saving against the 1,000 AED rule. The chart is useful descriptive evidence, not by itself an expansion decision.')
stopifnot(nrow(tp)==4794,nrow(others)==5206,round(case$before_after)==-669,
          round(case$with_without)==-1638,sum(tp$change>0)==485)
