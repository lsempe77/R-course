# One source for Day 2 screen, paper and trainer demonstrations.
source('day1_case.R', encoding='UTF-8')
long <- data.frame(business=rep(city$business,2), after=rep(0:1,each=nrow(city)),
                   took_part=rep(city$took_part,2),cost=c(city$cost_before,city$cost_after))
did_fit <- estimatr::lm_robust(cost ~ after*took_part, data=long, clusters=business, se_type='stata')
did_ci <- unname(confint(did_fit)['after:took_part',])
means <- c(join_before=mean(city$cost_before[took]),join_after=mean(city$cost_after[took]),
           other_before=mean(city$cost_before[!took]),other_after=mean(city$cost_after[!took]))
changes <- c(join=means[2]-means[1],other=means[4]-means[3]); names(changes) <- c('join','other')
stopifnot(abs(coef(did_fit)['after:took_part']-case$did)<1e-6)
rdd <- case$rdd2; rdd_ci <- unname(rdd[2:3])
near <- subset(city,abs(score-58)<=2)
age_near <- c(mean(near$manager_age[near$took_part==1]),mean(near$manager_age[near$took_part==0]))
jump_card <- function(seed) {
  set.seed(seed)
  b <- city[sample(which(city$score>57 & city$score<=58),6),]
  a <- city[sample(which(city$score>58 & city$score<=59),6),]
  list(rows=data.frame('Score at or below 58'=fmt(b$score,1),'Cost AED'=fmt(round(b$cost_after,-1)),
       'Score above 58'=fmt(a$score,1),'Cost AED '=fmt(round(a$cost_after,-1)),check.names=FALSE),
       below=mean(round(b$cost_after,-1)),above=mean(round(a$cost_after,-1)))
}
cards <- lapply(c(A=4,B=11,C=37,D=22,E=9,F=21,G=33,H=5),jump_card)
jumps <- sapply(cards,function(x)x$below-x$above)
matching_detail <- function(vars) {
  X <- scale(city[,vars,drop=FALSE]); ids <- which(took); co <- which(!took); Xc <- t(X[co,,drop=FALSE])
  tw <- co[vapply(ids,function(i)which.min(colSums((Xc-X[i,])^2)),1L)]
  m <- rbind(city[ids,],city[tw,])
  f <- estimatr::lm_robust(cost_after~took_part,data=m,clusters=business,se_type='stata')
  list(est=unname(coef(f)['took_part']),ci=unname(confint(f)['took_part',]),used=length(unique(tw)),
       max_reuse=max(table(tw)),age_gap=abs(mean(city$manager_age[ids])-mean(city$manager_age[tw])),
       base_gap=abs(mean(city$cost_before[ids])-mean(city$cost_before[tw])),
       balance=sapply(vars,function(v)(mean(city[[v]][ids])-mean(city[[v]][tw]))/sd(city[[v]])))
}
match_A <- matching_detail(case_env$MATCH_VARS)
match_B <- matching_detail(setdiff(case_env$MATCH_VARS,'manager_age'))
stopifnot(abs(match_A$est-case$matching)<1e-6,abs(match_B$est-case$matching_no_age)<1e-6)
profiles <- data.frame(id=c('A','B','C','1','2','3','4'),
  group=c(rep('Took part',3),rep('Did not take part',4)),age=c(45,38,52,39,46,51,29),
  size=c('small','large','small','large','small','small','large'),cost=c(900,1400,700,2300,1900,1800,2600))
report_row <- function(method) {
  if(method=='did') {estimate<-case$did;ci<-did_ci;label<-'Extra change in participants'}
  if(method=='rdd') {estimate<-rdd[1];ci<-rdd_ci;label<-'Jump at score 58'}
  if(method=='match') {estimate<-match_A$est;ci<-match_A$ci;label<-'Matched cost difference'}
  data.frame('Result row'=label,'Estimate AED'=fmt(estimate),
    '95% interval AED'=paste(fmt(ci[1]),'to',fmt(ci[2])),check.names=FALSE,row.names=NULL)
}
trend_svg <- function(type=1) {
  # Explicitly hypothetical pictures, not additional GreenWaste observations.
  blue<-c(180,160,140,120); red<-if(type==2)c(270,225,180,135) else c(270,250,230,210)
  x<-c(160,380,600,820)
  line<-function(y,col)sprintf('<polyline points="%s" fill="none" stroke="%s" stroke-width="7"/>',paste(paste(x,y,sep=','),collapse=' '),col)
  sprintf('<svg class="trend-visual" viewBox="0 0 1100 310" role="img" aria-label="Hypothetical trends, time runs from left to right"><text x="40" y="30" font-size="23">Annual cost</text>%s%s<text x="835" y="%s" font-size="23" fill="#215a9e">Participants</text><text x="835" y="%s" font-size="23" fill="#B8272C">Comparison</text><text x="160" y="305" font-size="23">Earlier</text><text x="700" y="305" font-size="23">Before joining</text></svg>',line(blue,'#215a9e'),line(red,'#B8272C'),tail(blue,1),tail(red,1))
}
