"""Author the approved Day 1 teaching route. Calculations stay in day1_case.R."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

def header(title, session, live=False):
    return f'''---
title: "{title}"
subtitle: "Module 2 · Day 1 · Session {session}"
author: "3ie"
always_allow_html: true
format:
  {'live-revealjs' if live else 'revealjs'}:
    theme: [theme_dge.scss, theme_live.scss, theme_reader.scss]
    logo: assets/dge_logo_horizontal.svg
    slide-number: true
    width: 1280
    height: 720
    slide-level: 2
    embed-resources: true
    include-after-body: _reader_interactions.html
{'''webr:
  render-df: kable
  resources:
    - evaluation_data_GreenWaste_simple.csv
''' if live else ''}knitr:
  opts_chunk:
    echo: false
    warning: false
    message: false
---

{ '{{< include ./_extensions/r-wasm/live/_knitr.qmd >}}' if live else '' }

```{{r setup, include=FALSE}}
source('day1_case.R')
```

'''

s1 = r'''
## A report has reached your desk {.reader-slide}

::: {.lead}
“Landfill waste from businesses in GreenWaste fell `r fmt(landfill_fall)`% in a year.”
:::

::: {.ask}
Would this sentence justify extending the programme?
:::

Write your decision and one question on **Sheet 1**. Work alone first.

Fictional GreenWaste case · invented figures

::: {.notes}
7 minutes. This is the entry task, not a lecture. Do not define terms or correct answers yet. Collect a few decisions and questions. Keep the sheets so participants can compare their own reading at the end of the week. No AI for this task.
:::

## Meet GreenWaste {.reader-slide}

{{< include _case_map.qmd >}}

Fictional case · today we read **waste sent to landfill**, in tonnes per business per year.

::: {.notes}
3 minutes. Use the existing case picture/card. GreenWaste advises businesses and helps them improve waste handling. One pilot used a lottery; the rest of the city used a score rule. Do not teach either method yet or reveal cost findings. The map shows an illustrative arrangement, not actual counts. The existing data contain eight rounded score-58 exceptions; do not claim that every displayed score follows the rule without exception.
:::

## Would you extend it? {.reader-slide}

::: {.big-number}
`r fmt(landfill_fall)`% lower
:::

Landfill among businesses that took part, one year later.

```{=html}
<div data-choices>
  <button data-choice aria-pressed="false">Extend</button>
  <button data-choice aria-pressed="false">Do not extend</button>
  <button data-choice aria-pressed="false">Ask first</button>
  <p role="status" class="feedback"></p>
</div>
```

Fictional GreenWaste case · invented figures

::: {.notes}
3 minutes. Individual choice, then a reason. Buttons record only the choice in this open page. For shared phone voting use room_poll.py and its facilitator page; the room poll is separate from this local interaction. Keep results hidden until voting closes. Paper fallback: three labelled cards or a show of hands. Revisit the same question after opening the comparison.
:::

## What is missing? {.reader-slide}

::: {.lead}
“Landfill fell after GreenWaste.”
:::

::: {.ask}
What would you need to know before saying GreenWaste caused the fall?
:::

Write one question. Compare it with a partner’s.

::: {.notes}
4 minutes. Invite concrete questions, not a list of technical terms. Prompt only if needed: what else changed, what happened elsewhere, how businesses were selected? Keep the next slide hidden until participants have committed.
:::

## Open the comparison {.reader-slide}

```{r landfill-comparison, results='asis'}
html_out(sprintf('<div class="evidence-pair"><div class="evidence"><h3>Took part</h3><p class="big-number">%s &rarr; %s</p><p>Before &rarr; one year later</p></div><div class="evidence"><h3>Did not take part</h3><button data-open="other-landfill" data-closed="Open their result" data-opened="Hide their result" aria-controls="other-landfill" aria-expanded="false">Open their result</button><div id="other-landfill" hidden><p class="big-number">%s &rarr; %s</p><p>Before &rarr; one year later</p></div></div></div><p class="caption">Landfill, tonnes per business per year</p>%s', fmt(landfill['before'],1), fmt(landfill['after'],1), fmt(landfill['other_before'],1), fmt(landfill['other_after'],1), fiction))
```

::: {.ask}
What can the first fall tell us on its own?
:::

::: {.notes}
5 minutes. Ask participants to predict the other group’s direction before opening it. The other group also improved. This weakens a causal reading of before/after; it does not prove that these groups are a valid causal comparison. They started at different levels. Ask the same extension question again using the room poll’s After phase or cards. Invite a changed reason, not a winning answer.
:::

## Compared to what? {.reader-slide}

::: {.lead}
“Waste was lower **than it had been before**.”
:::

The **counterfactual** is what would have happened without GreenWaste.

::: {.ask}
Does this sentence tell us what would have happened without it?
:::

::: {.fragment}
Ask how the evaluator estimated that missing outcome.
:::

::: {.notes}
5 minutes. Point to the comparison words. Explain counterfactual once in plain language. We cannot observe the same business, at the same time, both with and without the programme. A comparison can help estimate the missing outcome if its assumptions are credible. Avoid launching a methods survey. Have pairs add comparison words to one claim.
:::

## What does an average hide? {.reader-slide}

Landfill before GreenWaste, tonnes per year, for ten businesses:

```{r ten-businesses, results='asis'}
html_out(paste0('<div class="ten-businesses">', paste(sprintf('<span>%s</span>', fmt(ten$landfill_before)), collapse=''), '</div>', fiction))
```

::: {.ask}
Would one number describe these businesses well?
:::

::: {.fragment}
The **mean** is the total divided by ten: `r fmt(mean(ten$landfill_before),1)` tonnes. Nine businesses are below it.
:::

::: {.notes}
5 minutes. Participants point to the large business before revealing the mean. No long arithmetic exercise. A mean can answer a useful total-related question, but it does not describe every business. Ask which extra information they would want about the spread. Do not introduce quartiles or a second lesson on medians.
:::

## Try four claims {.reader-slide}

Read the four claim cards. For each, choose:

**Act · Ask first · Do not act**

Then name what is missing:

**Compared to what? · How big? · How sure?**

::: {.ask}
What question would move your decision forward?
:::

::: {.notes}
12 minutes. Preserve Fiona’s four cards and triage activity. Give one card set per group and use Sheet 2. Optional A1 board: one group-coloured marker per group; write card numbers into its question/decision grid. No extra AI wall board. Card 2’s causal wording is intentionally open to challenge. Technical terms on cards can be glossed briefly; the full uncertainty lesson comes next session. Protect time for groups to write their reasons.
:::

## Defend one choice {.reader-slide}

Choose a card that two groups placed differently.

::: {.ask}
Which words or numbers support your choice?
:::

Explain one missing piece of evidence that could change it.

::: {.notes}
6 minutes. Discuss two disagreements, not a tour through every group. Expected primary placements: card 1 compared to what/ask first; card 2 how big/ask first (it concerns landfill, not the cost rule; also ask about the causal comparison); card 3 do not act on the nationwide recommendation; card 4 how sure/ask first. More than one missing question can be justified. Do not treat grid placement as a single-answer test.
:::

## Check the AI sentence {.reader-slide data-correct="The second sentence claims a cause the headline has not established. Ask what happened without GreenWaste."}

An illustrative AI draft. Select the unsupported sentence.

```{=html}
<div class="claim-list">
<button data-claim="supported" aria-pressed="false">Landfill fell among businesses that took part.</button>
<button data-claim="unsupported" aria-pressed="false">GreenWaste caused the entire fall.</button>
</div>
<button data-check>Check against the evidence</button>
<p data-feedback class="feedback" role="status"></p>
```

::: {.ask}
What should the AI ask before writing that conclusion?
:::

::: {.notes}
6 minutes. This is an authored example of a possible AI error, not a transcript of a verified tool response. Participants must point to source evidence. Optional live AI: provide only the headline and ask it to list the missing information before offering a conclusion. Review its questions yourselves. No AI account is required to complete the activity.
:::

## Your next question {.reader-slide}

Close the cards and turn over the sheet.

::: {.ask}
What would you ask the evaluator before acting on a claim of improvement?
:::

Write one question and explain why the answer matters.

::: {.notes}
4 minutes. Individual retrieval, no list or AI. Look for a concrete comparison/counterfactual question, a decision-relevant size question or a useful uncertainty question, with a reason. Collect two answers. Session total 60 minutes. Do not add a summary lecture.
:::
'''

s2 = r'''
## One question from memory {.reader-slide}

```{webr}
#| context: setup
#| autorun: true
#| echo: false
#| include: false
gw <- read.csv('evaluation_data_GreenWaste_simple.csv')
tp <- subset(gw, setting == 'city' & took_part == 1)
```

::: {.ask}
What would you ask before turning a fall into a claim of impact?
:::

Tell a partner. Keep the cards closed.

::: {.notes}
3 minutes. Retrieve the previous session’s question. Do not reteach the whole session. Hidden webR setup belongs beneath this heading to avoid a blank slide. Open the deck early for webR; its trainer demo is optional, with the same static result on paper.
:::

## What decision is required? {.reader-slide}

::: {.big-number}
`r fmt(decision_rule)` AED
:::

The course’s decision rule: an annual saving of at least this amount **per business**, measured **12 months later**.

::: {.ask}
What units and time period must the result use?
:::

Fictional GreenWaste case · invented decision rule

::: {.notes}
3 minutes. Distinguish a minimum saving from a value-for-money judgement. Programme costs, reach and implementation matter later. This rule alone is not a complete scale-up decision. It is not a real government policy.
:::

## Read this extract {.reader-slide}

```{r extract, results='asis'}
html_out(reading_table())
```

::: {.ask}
Which number answers “how much did costs change”?
:::

Read **Sheet 1** alone before discussing it.

::: {.notes}
5 minutes. Wait for reading. Ask participants to circle a number and underline the comparison words. Do not explain every column immediately. The extract is a before/after regression with business-clustered standard errors. The statistical method is in the trainer key, not a participant prerequisite.
:::

## Circle the change {.reader-slide}

```{r cost-pair, results='asis'}
html_out(sprintf('<div class="evidence-pair"><div class="evidence"><h3>Before</h3><p class="big-number">%s</p></div><div class="evidence"><h3>12 months later</h3><p class="big-number">%s</p></div></div><p class="caption">Annual waste cost, AED per city business that took part</p>%s',fmt(ba_mean['before']),fmt(ba_mean['after']),fiction))
```

::: {.ask}
What does the negative sign on `r fmt(case$before_after)` mean here?
:::

::: {.fragment}
Costs were `r fmt(abs(case$before_after))` AED lower. This is a change over time.
:::

::: {.notes}
5 minutes. The difference uses unrounded values, so subtracting displayed rounded means may differ by one AED. Distinguish lower costs from a harmful outcome. Ask for the time period and group in the spoken answer. Do not call the change the programme’s causal effect.
:::

## Find its row {.reader-slide}

**Coefficient**: the number beside a named result row.

::: {.ask}
Will this calculation give a rise or a fall?
:::

:::: {.columns}
::: {.column width="48%"}
```{webr}
#| echo: true
change <- tp$cost_after - tp$cost_before
data.frame(Result = 'After minus before',
           AED = round(mean(change)))
```
:::
::: {.column width="52%"}
```{r highlighted, results='asis'}
html_out(sprintf('<div class="evidence"><h3>After GreenWaste</h3><p class="big-number">%s</p><p>Coefficient, AED</p></div>%s',fmt(case$before_after),fiction))
```
:::
::::

::: {.notes}
5 minutes. Predict, then trainer Run. Participants read the output, not the code. The arithmetic produces the same coefficient as the before/after regression shown in the extract. The row’s name is essential: a different coefficient answers a different question. Use the printed coefficient if webR is unavailable. Never ask participants to fix code.
:::

## What does the interval add? {.reader-slide}

::: {.lead}
95% confidence interval: `r fmt(ba_ci[1])` to `r fmt(ba_ci[2])` AED
:::

A range compatible with the data and statistical model. It shows uncertainty around the estimate.

::: {.ask}
Does a narrow interval fix a poor comparison?
:::

::: {.fragment}
It does not account for every source of bias.
:::

Fictional GreenWaste case · invented figures

::: {.notes}
6 minutes. Box the interval on the worksheet. It is not a range of individual business savings or a 95% chance statement about this fixed interval. If needed: repeating the procedure under its assumptions yields intervals covering the true model quantity about 95% of the time. Do not teach repeated-sampling machinery. Precision cannot tell us what else changed over time.
:::

## Compare it with the rule {.reader-slide}

```{r before-rule, results='asis'}
html_out(interval_svg())
```

::: {.ask}
Does this reported change reach the rule?
:::

::: {.fragment}
The interval is below the rule. The comparison still does not establish what GreenWaste caused.
:::

::: {.notes}
6 minutes. Orient to the saving scale, which is positive here: it is the magnitude of the negative cost change in the table. Participants trace the estimate, interval and rule with a finger. Even a precise before/after change cannot settle a causal decision. Avoid concluding that the programme does not work.
:::

## Significant enough to act? {.reader-slide}

The **p-value** for this change is **less than 0.001**.

“Statistically significant” asks how unusual the result would be under a no-change model and its assumptions.

::: {.ask}
Does that tell us GreenWaste caused enough saving to extend it?
:::

::: {.fragment}
A small p-value establishes neither cause nor a large enough saving. A non-significant result does not prove no effect.
:::

Fictional GreenWaste case · invented figures

::: {.notes}
5 minutes. Recognise the term when reading reports. The p-value concerns the null tested by the analysis; here the before/after change, not a causal effect. It is not the probability that the programme works or that the result is due to chance. Do not introduce a hypothesis-testing lecture.
:::

## Finish the mark up {.reader-slide}

On **Sheet 1**:

Circle the estimate. Box its interval. Underline the comparison.

Write the units and period, then a decision sentence.

::: {.ask}
Which part of the scale-up decision does this extract leave unanswered?
:::

::: {.notes}
10 minutes. Five minutes alone, three in pairs, two for feedback. Every reader locates the result before discussing. Use the answer space on Sheet 1. The causal comparison is missing. Invite a threshold reading plus the limitation; do not accept “significant therefore extend”.
:::

## Repair an AI summary {.reader-slide data-correct="The second sentence is unsupported. The extract measures a change over time; it does not isolate what GreenWaste caused."}

Select every unsupported claim in this illustrative AI draft.

```{r ai-summary, results='asis'}
html_out(sprintf('<div class="claim-list"><button data-claim="supported" aria-pressed="false">City participants&#39; annual costs fell by %s AED.</button><button data-claim="unsupported" aria-pressed="false">GreenWaste caused that saving, so scale-up is justified.</button></div><button data-check>Check against the extract</button><p data-feedback class="feedback" role="status"></p>%s',fmt(abs(case$before_after)),fiction))
```

::: {.ask}
How would you rewrite the second sentence using only this source?
:::

::: {.notes}
7 minutes. Use Sheet 2. Example rewrite: the observed fall is below the rule, but the extract cannot isolate the programme’s effect. Ask an AI to identify the comparison, quote the supporting result row and ask for missing information before recommending. Check its answer against the source yourselves. A second AI review is assistance, not verification. The draft is an authored example.
:::

## Write the decision sentence {.reader-slide}

::: {.ask}
What can you say confidently, and what would you ask next?
:::

Write a result with its units, one limit, and your next question. Use the extract.

::: {.notes}
5 minutes. Individual close. Accept plain wording: participants’ annual costs fell about the estimated amount after 12 months; the change is below the 1,000 AED rule; we need a credible estimate of what happened without the programme. Do not turn this into a definitive rejection of GreenWaste. Total 60 minutes.
:::
'''

s3 = r'''
## Two estimates one programme {.reader-slide}

```{webr}
#| context: setup
#| autorun: true
#| echo: false
#| include: false
gw <- read.csv('evaluation_data_GreenWaste_simple.csv')
pilot <- subset(gw, setting == 'pilot')
ages <- pilot$manager_age[1:20]
draw <- 0
group_ages <- function(groups) {
  out <- aggregate(ages, list(Group = groups), function(x) round(mean(x), 1))
  names(out)[2] <- 'Manager age'
  out
}
```

```{r two-estimates, results='asis'}
html_out(sprintf('<div class="evidence-pair"><div class="evidence"><h3>Same businesses over time</h3><p class="big-number">%s</p><p>AED lower after 12 months</p></div><div class="evidence"><h3>Two groups afterwards</h3><p class="big-number">%s</p><p>AED lower among participants</p></div></div>%s',fmt(abs(case$before_after)),fmt(abs(case$with_without)),fiction))
```

::: {.ask}
Which comparison could support an extension decision?
:::

::: {.notes}
4 minutes. Recall the 1,000 AED rule. The first is before/after city participants; the second compares city participants with non-participants after. Both are observational summaries. Do not endorse the larger number because it passes the threshold. Hidden webR setup belongs under this first heading. Open early; there is one optional trainer demo.
:::

## Which comparison is fair? {.reader-slide}

::: {.lead}
“Participants had lower costs than businesses that did not take part.”
:::

```{=html}
<div data-choices>
<button data-choice aria-pressed="false">A fair comparison</button>
<button data-choice aria-pressed="false">I need their starting costs</button>
<p role="status" class="feedback"></p>
</div>
```

::: {.ask}
Why might the two groups already have different costs?
:::

::: {.notes}
4 minutes. Commit before opening baseline. Invite a reason related to size, management or the score rule. Use the same local choice controls or room poll with a custom question and two choices. No national inference yet.
:::

## See where they started {.reader-slide}

```{r starting-gap, results='asis'}
html_out(sprintf('<button data-open="starting-costs" data-closed="Open starting costs" data-opened="Hide starting costs" aria-controls="starting-costs" aria-expanded="false">Open starting costs</button><div id="starting-costs" hidden><div class="evidence-pair"><div class="evidence"><h3>Took part</h3><p class="big-number">%s</p></div><div class="evidence"><h3>Did not take part</h3><p class="big-number">%s</p></div></div><p class="caption">Annual waste cost before GreenWaste, AED per business</p></div>%s',fmt(mean(city$cost_before[took])),fmt(mean(city$cost_before[!took])),fiction))
```

::: {.ask}
Can the entire later gap be credited to GreenWaste?
:::

::: {.notes}
5 minutes. Predict who started cheaper, then open. Participants already had lower costs. The later gap includes a starting difference. This is a warning about selection; no need to add a regression slide. Invite someone to state both the evidence and its implication.
:::

## What else changed? {.reader-slide}

::: {.lead}
Costs can change while a programme is running.
:::

::: {.ask}
What might have changed costs without GreenWaste?
:::

Compare your idea with a partner’s. Say what evidence would help check it.

::: {.notes}
4 minutes. Possible ideas: waste charges, supply prices, business activity, another waste policy. These are hypotheses, not facts about the invented data. Before/after confounds programme effects with other changes. Day 2 will examine how a comparison of changes helps, with assumptions. Do not teach DiD now.
:::

## How the lottery helps {.reader-slide}

```{=html}
<div class="evidence-pair">
<div class="evidence"><h3>Chosen by lottery</h3><p>Joined GreenWaste</p></div>
<div class="evidence"><h3>Waiting group</h3><p>Did not join during the study</p></div>
</div>
```

::: {.ask}
Why does chance help make these groups comparable?
:::

Fictional pilot district · `r fmt(nrow(pilot))` businesses · roughly half in each group

::: {.notes}
5 minutes. The pilot picture is already on the case card. Random assignment, an RCT, prevents systematic selection into the two groups on average across possible lotteries. It need not make any one draw perfectly balanced. In this invented pilot, assignment equals participation; real reports require checking follow-up, take-up and effects on the waiting group. Keep the estimand explanation in notes.
:::

## Draw once draw again {.reader-slide}

::: {.ask}
Will a small lottery make the groups exactly alike?
:::

:::: {.columns}
::: {.column width="50%"}
```{webr}
#| echo: true
draw <- draw + 1
set.seed(draw)
group <- sample(rep(c('Join', 'Wait'), each = 10))
group_ages(group)
```
:::
::: {.column width="50%"}
Twenty businesses. Ten places.

The output compares **manager age before the programme**.

Fictional case · demonstration only
:::
::::

::: {.notes}
7 minutes. Predict first; trainer Run, then Run once more. The input is the first 20 pilot businesses’ actual pre-programme manager ages. This redraw is a demonstration of chance balance, not a reanalysis of the trial or an effect estimate. Rename output x orally as average manager age. Each run uses a new fixed seed. Paper fallback: draw ten of twenty numbered slips from the age list in the trainer pack and compare means. Avoid adding a sample-size slider or a sampling theory lecture.
:::

## Read the trial result {.reader-slide}

```{r trial-table, results='asis'}
html_out(reading_table('trial', TRUE))
```

::: {.ask}
Which comparison does this coefficient describe?
:::

::: {.notes}
6 minutes. Read Sheet 1. The result is the after-period difference between randomly assigned pilot groups. Assignment equals participation in this fictional pilot. Show that the comparison is different from both city estimates. Ask learners to state a saving in AED per business per year, observed 12 months later. The interval is from the canonical ordinary least-squares pilot model in greenwaste_case.R, matching the printed table.
:::

## Break {.reader-slide}

Pause here. Leave the result sheet on the table.

::: {.notes}
5 minutes. Protect the break. Do not use it to add further slides or a lab.
:::

## Open the uncertainty {.reader-slide}

```{r trial-interval, results='asis'}
html_out(interval_svg('trial', TRUE))
html_out('<button data-open="interval-trial" data-closed="Open the 95% interval" data-opened="Hide the interval" aria-controls="interval-trial" aria-expanded="false">Open the 95% interval</button>')
```

::: {.ask}
Does the trial settle whether saving reaches the rule?
:::

::: {.notes}
6 minutes. Point estimate first, interval second. The interval spans the 1,000 AED threshold: uncertainty remains about meeting it. On the saving scale, both ends are positive; uncertainty about a threshold is different from uncertainty about any saving. The interval relies on statistical assumptions and does not capture all design failures. The pilot result may not generalise to the whole city.
:::

## Would you extend it now? {.reader-slide}

```{=html}
<div data-choices>
<button data-choice aria-pressed="false">Extend</button>
<button data-choice aria-pressed="false">Do not extend</button>
<button data-choice aria-pressed="false">Ask first</button>
<p role="status" class="feedback"></p>
</div>
```

::: {.ask}
What evidence supports your decision, and what still limits it?
:::

Use the trial’s comparison, interval and decision rule.

::: {.notes}
6 minutes. A provisional judgement may differ with costs, risks and the next evidence opportunity. Require a reason; do not award “ask first” automatically. The interval spans the rule; the pilot covers one district. If using room polling, capture After and compare with Before; invite which evidence changed a mind, without identifying voters.
:::

## Write a decision note {.reader-slide}

Use **Sheet 2** with a partner.

State the trial result and comparison. Explain the limit on your recommendation.

::: {.ask}
What would a director need to know before approving scale-up?
:::

Keep your note to three or four sentences. Point to the evidence for each claim.

::: {.notes}
10 minutes. Six to write, two to exchange notes, two for feedback. The note should contain the randomised pilot comparison, annual saving, uncertainty about the threshold and limits on reach/implementation. Do not require every possible caveat or formula. Programme costs are not supplied, so value for money is not settled.
:::

## Check an AI note {.reader-slide data-correct="The pilot estimate is supported. The threshold is still uncertain, and nationwide value for money is not established."}

Select every unsupported conclusion in this illustrative AI draft.

```{r ai-trial, results='asis'}
html_out(sprintf('<div class="claim-list"><button data-claim="supported" aria-pressed="false">The pilot trial estimated an annual saving of %s AED per business.</button><button data-claim="unsupported" aria-pressed="false">The trial proves the minimum saving is met.</button><button data-claim="unsupported" aria-pressed="false">Nationwide rollout is good value for money.</button></div><button data-check>Check against the result sheet</button><p data-feedback class="feedback" role="status"></p>%s',fmt(abs(case$rct)),fiction))
```

::: {.notes}
8 minutes. Find two unsupported conclusions, then rewrite them using the source. Ask AI, if used, to quote the evidence behind each conclusion and list unanswered questions. Participants check the quotations, units and comparisons themselves. This authored draft is not a real saved chat. Avoid presenting agreement between two AIs as proof.
:::

## Your question for the evaluator {.reader-slide}

Close the result sheet.

::: {.ask}
What is your most useful question before this pilot becomes a citywide programme?
:::

Write your question and say how its answer could change your recommendation.

::: {.notes}
5 minutes. Individual retrieval, no AI. Accept specific questions about whether the trial was implemented fairly, who was followed up, how the pilot differs from the city, cost, uncertainty about the rule, or the next feasible evidence. Require the reason, not the term. Total 75 minutes. No full lab or additional simulation.
:::
'''

for name, text in [('Oct12_session1_live.qmd', header('Compared to what',1)+s1),
                   ('Oct12_session2.qmd', header('Read the result',2,True)+s2),
                   ('Oct12_session3_live.qmd', header('Choose a fair comparison',3,True)+s3)]:
    (ROOT/name).write_text(text.strip()+'\n', encoding='utf-8')
    print(name, 'content screens:', sum(line.startswith('## ') for line in text.splitlines()))
