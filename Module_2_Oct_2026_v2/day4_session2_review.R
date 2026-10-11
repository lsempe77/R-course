source('day4_session1_review.R', encoding='UTF-8')

d11_decision <- paste(
  'D11. Hypothetical decision: should the director authorise national rollout to businesses scoring at or below 58,',
  'and commit a proposed 1,800 AED delivery allowance per business?',
  'A limited next phase or deferral is also possible; specify the scale and condition you recommend.',
  'The allowance is a planning proposal, not a measured cost. The national eligible count, total budget,',
  'full delivery costs and acceptable risk of falling below 1,000 AED annual saving are not supplied.')
d11_findings <- list(
  list(title='F1 | Pilot comparison, uncertainty and reach',paragraphs=c(
    'F1.1. In a separate pilot district, 400 businesses with scores at or below 58 entered a lottery: 200 were assigned to join and 200 to wait. The analysis compares recorded annual waste costs in AED per business at 12 months. Lottery assignment reduces systematic starting selection; credible outcome follow-up still matters. This result describes one district, not national delivery.',
    sprintf('F1.2. Estimated annual saving is %s AED per business, with a 95%% interval of %s to %s AED. The interval lies above zero but spans the authority\'s %s AED minimum-saving rule. The point estimate exceeds that rule; the interval does not settle it. Do not describe uncertainty about the minimum as no evidence of a reduction.',fmt(-case$rct),fmt(sort(-case$rct_ci)[1]),fmt(sort(-case$rct_ci)[2]),fmt(decision_rule)))),
  list(title='F2 | City comparisons and causal requirements',paragraphs=c(
    sprintf('F2.1. The city has 10,000 businesses: %s participants and %s others. Participation is at or below score 58. Extra change subtracts nonparticipant change from participant change: estimated saving %s AED, interval %s to %s, below the 1,000 rule. Attribution requires parallel changes without support; one before measure cannot show earlier trends. Participants\' descriptive mean fall of %s AED is a different comparison and does not by itself establish cause.',fmt(sum(took)),fmt(sum(!took)),fmt(-case$did),fmt(sort(-did_ci)[1]),fmt(sort(-did_ci)[2]),fmt(-case$before_after)),
    sprintf('F2.2. The fitted score-58 jump uses %s businesses within two score points and is local. Continuity without support and absence of relevant sorting/other jumps matter. A separate five-point diagnostic shows managers about %s years younger below the rule. Matching uses four recorded features; %s controls are reused, one %s times, with a %s-year mean age gap remaining. Comparability and unmeasured selection remain concerns. The city methods share records; they are not independent replications.',fmt(nrow(near)),fmt(abs(case$age_jump),1),fmt(match_A$used),fmt(match_A$max_reuse),fmt(match_A$age_gap,1)))),
  list(title='F3 | Conditional economic model',paragraphs=c(
    sprintf('F3.1. The limited model provisionally uses the city extra-change saving of %s AED. It assumes %s AED one-off cost at year 0, no benefit in year 1, five equal saving years in years 2-6 and a 5%% discount rate. The benefit-cost ratio is %.2f. Costs, timing and persistence are fictional assumptions, not measured programme facts. The benefit still needs a credible causal interpretation.',fmt(model$saving),fmt(model$cost),ratio()),
    sprintf('F3.2. A ratio above 1 compares modelled benefits with included costs; it is not the 1,000 AED annual-saving test. The boundary mixes actors and is not a complete government-budget or social appraisal. Under the previously tested combination of 30%% annual benefit decay and 600 AED additional year-0 costs, the ratio is %.2f. Request full cost amounts, timing, perspective and persistence evidence before relying on a national spending conclusion.',ratio(decay=.3,extra=600)))),
  list(title='F4 | Missing evidence and decision-changing requests',paragraphs=c(
    'F4.1. Complete generated records in this synthetic training file do not establish real recruitment, measurement reliability or follow-up. No fieldwork/attrition records, earlier city series, score-manipulation audit or complete matching-support assessment are supplied. Do not invent those checks or treat missing evidence as proof that the programme failed.',
    'F4.2. National expansion needs a comparison of the intended population and delivery conditions with the studied setting. Its eligible business count and full budget are not given. Choose the evidence most relevant to your action: target-population/delivery comparison, full costs/persistence, earlier trends/concurrent changes, fieldwork/follow-up, or cutoff/matching credibility. Explain what a favourable or unfavourable answer would change.'))
)
d11_index <- data.frame(
  Anchor=c('F1.1-F1.2','F2.1-F2.2 / T11','F3.1-F3.2','F4.1-F4.2'),
  'Read it for'=c('Pilot comparison, interval and district reach',
    'City comparisons, requirements and shared data',
    'Model inputs, cost boundary and sensitivity',
    'Missing evidence and decision consequence'),check.names=FALSE)
d11_findings_html <- function(i) paste0('<section class="finding-section" id="F',i,
  '"><h3>',d11_findings[[i]]$title,'</h3>',
  paste(vapply(seq_along(d11_findings[[i]]$paragraphs),function(j)paste0(
    '<p id="F',i,'.',j,'">',d11_findings[[i]]$paragraphs[j],'</p>'),''),collapse=''),
  '</section>')
d11_model <- c(
  sprintf('In one pilot district, the lottery comparison estimated %s AED annual waste-cost saving per business at 12 months; its 95%% interval, %s to %s AED, spans the 1,000 AED rule.',fmt(-case$rct),fmt(sort(-case$rct_ci)[1]),fmt(sort(-case$rct_ci)[2])),
  'Do not commit to national rollout and its proposed allowance yet. Consider a limited next phase with a decision checkpoint before wider spending.',
  'The pilot does not establish national reach, and the favourable economic ratio depends on unverified inputs.',
  'Request a comparison of intended delivery conditions and businesses with the pilot, plus full cost and persistence evidence. Use these to reconsider scale and budget; specify acceptable minimum-saving risk before the checkpoint.')
d11_model_sources <- c('Finding: F1.1-F1.2','Action: D11 / F4.2',
  'Limit: F1.1 / F3.1-F3.2','Request and purpose: F3.2 / F4.2')
d11_words <- function(text) length(strsplit(trimws(paste(text,collapse=' ')),'\\s+')[[1]])
d11_model_html <- function() paste0('<div class="worked-brief">',
  paste(vapply(seq_along(d11_model),function(i)paste0('<p><strong>',
    brief_parts[i],'.</strong> ',d11_model[i],'</p>'),''),collapse=''),'</div>')
d11_prompt_a <- paste(
  'Using corrected GreenWaste findings F1-F4 and D11, write a 150-word director brief recommending national rollout',
  'with the current eligibility rule and proposed allowance. Include the headline, implications, recommendation and risk.')
d11_ai <- c(
  sprintf('The pilot lottery estimates %s AED annual waste-cost saving per business at 12 months, with a 95%% interval of %s to %s AED. This is evidence of a reduction in the pilot district.',fmt(-case$rct),fmt(sort(-case$rct_ci)[1]),fmt(sort(-case$rct_ci)[2])),
  'The point estimate exceeds the 1,000 AED rule, so national expansion meets the authority\'s standard. The interval includes lower savings, making continued monitoring sensible rather than requiring a delay.',
  sprintf('Authorise rollout to all businesses scoring at or below 58 and commit the proposed 1,800 AED allowance. The %.2f benefit-cost ratio establishes that this spending is good value.',ratio()),
  'The principal risk is inconsistent implementation. Address it through routine monitoring and periodic reporting; the evaluation already gives sufficient assurance for approval.')
d11_prompt <- paste(
  'I advise on D11: national rollout for scores at or below 58 and a proposed 1,800 AED allowance.',
  'Use only corrected findings F1-F4 and T11 below.',
  'Ask at most two questions about decision priorities and acceptable minimum-saving risk before drafting.',
  'After my answers, write connected prose of at most 150 words: finding, proportionate action/condition, important limit, and specific evidence request with decision purpose.',
  'Keep the comparison, population, units, period and interval against the 1,000 AED rule accurate; distinguish model assumptions from facts.',
  'Put source references outside the word limit. Do not invent missing checks or guarantee national value.',
  'Compare one substantive change with my own draft. [Paste D11, F1-F4/T11 and brief prose only; omit names and scores.]')
d11_fallback <- c(
  'Before drafting: which decision consideration is binding, and what risk of falling below 1,000 AED is acceptable?',
  paste(d11_model,collapse=' '),
  'Sources: F1.1-F1.2; D11/F4.2; F3.1-F3.2. Compared with the supplied draft, national assurance becomes a bounded next-step recommendation; the proposed allowance is not treated as validated spending.')
d11_peer <- c('Source for important claims',
  'Comparison and population','Result, units, period and interval against the rule',
  'Action, scale and accountable condition','Important limit linked to the action',
  'Specific evidence request and decision purpose')
d11_retry_html <- function(i) paste0('<article class="retry-card" id="retry-',i,
  '"><h3>Retry ',i,' | ',d10_retry$Ability[i],'</h3>',
  '<p>Name/identifier: __________________</p><p>',d10_retry$Task[i],
  '</p><div class="writing log-space"></div>',
  '<p>Opening item score: ___ / 2 &nbsp; Retry item score: ___ / 2</p></article>')
