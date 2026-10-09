# Preview versions: further changes and language review

Draft for Fiona, 9 October 2026. Nothing in the decks, worksheets or cards has been edited. This file lists what to change, with proposed wording to confirm first.

Assumption: the `*_review` preview versions (Day 1 to Day 3 Session 2) become the base for the final materials, even though they are not yet published. The Day 2 Session 2 preview (regression discontinuity) and Day 3 Session 3 / Day 4 previews do not exist yet, so everything below must also be applied when those are built.

Scope of this review: the rendered previews in `docs/preview/` for Day 1 S1-S3, Day 2 S1 and S3, Day 3 S1 and S2, with their worksheets, claim cards, profile/cost slips, scenario cards and age slips. Slide text and printed pages were read; speaker notes were not checked line by line.

Related files: `REVIEW_NOTES.md` (Fiona's earlier notes), `SLIDE_HANDOUT_REVIEW_PLAN.md`, `HANDOFF.md`, and the writing rules in `CLAUDE.md` (no em dashes, the "AI pet peeves" list).

---

## 1. Language rules to apply everywhere

1. **Full sentences.** Every title, question, instruction and caption is a complete sentence or a complete question. No bare labels such as "We read -669" (-669 what?) or "Lower than without. Already lower before." Short labels are acceptable only inside tables and diagrams.
2. **Worksheets and handouts first.** A participant who is only half listening must be able to read a page and know what is being discussed and what they are asked to do. Each question should say what to look at, what to do, and in what words to answer.
3. **One task per sentence.** Many questions currently string together four or five fragments ("State its number, units, comparison and sign. Reconstruct the after mean."). Split into numbered parts (a), (b), (c), each a full sentence.
4. **Name the quantity.** Say "the mean annual waste management cost fell by 669 AED", not "-669" or "the change".
5. **Participant-facing text contains no trainer or production language.** See section 4.
6. **One name per idea.** See section 3 (terms) and section 2 (the "cost" problem).
7. **Plain words before jargon.** Spell out DiD, RDD, NPV and "null model" on first use, or replace them. Avoid "proportionate", "consequential", "credible" in task instructions without a short explanation.
8. **Keep the existing writing rules.** No em dashes; run the pet-peeve pass again on the previews. The previews contain many "X, not Y" and "does not establish" constructions. Keep the ones that prevent a real misreading; cut the rest.
9. **Check against the Language issues document** (Fiona, Oct 2026). Status of her examples is in section 5.

---

## 2. The word "cost" is doing too many jobs

"Cost" currently means three different things:

- the **outcome** (each business's annual waste management cost, in AED);
- the **programme's delivery cost** (1,800 AED per participant in Day 3 S1);
- **cost-benefit analysis** (Day 3 S1).

It also appears as a label for things that are not costs: "cost results", "cost cards", "cost claims", "cost slips", "cost bars", "cost reading worksheet", "cost comparisons". In Day 3 these labels sit next to a real cost analysis, which makes them harder to read. In the matching session "after-cost" and "before-cost" appear about 30 times.

Proposal:

| Keep or introduce | Use for |
|---|---|
| **outcome** | Define once on Day 1 (and add to the glossary): "The outcome we measure is each business's annual waste management cost, in AED." After that, refer to "the outcome" in prompts and instructions. |
| **annual waste management cost** | The full name in every table heading, caption and source line. Shorter "waste cost" is fine in running sentences once defined. |
| **programme cost** or **delivery cost** | Only for the money the authority spends (Day 3 S1). Never use bare "cost" there for the outcome. |
| **saving** | The positive version of a fall in the outcome. Say so once. |

Replacements to confirm:

| Current | Proposed |
|---|---|
| "A cost result lands on your desk" (D1S1 slide) | "A GreenWaste result lands on your desk." |
| "GreenWaste cost reading worksheet" | "GreenWaste: reading an evaluation result" |
| "GreenWaste: cost comparisons worksheet" | "GreenWaste: comparing groups" |
| "Four cost claims. Which would you act on?"; cards "Four cost claims: decide what is missing" | "Here are four statements about GreenWaste. Which would you act on?"; cards "Four statements about GreenWaste: decide what is missing" |
| "the four separate cost cards" (D1S2) | "decision cards": each card shows one statement about GreenWaste and asks "Act, ask first or do not act?" Explain this the first time the cards appear. (Fiona found "claim cards" unclear.) |
| "What do the cost bars support?"; "Repair the cost-chart caption" | "What do the bar charts show?"; "Rewrite the caption of the bar chart". (Fiona: "the bar charts" is fine in general; name the specific chart, e.g. "Chart A" or "Figure C", when only one is meant.) |
| "cost slips", "Cost slips: trainer holds until reveal" (D2S3 matching) | "reveal slips". First mention explains it: "A reveal slip shows what one business's annual waste management cost was 12 months after GreenWaste. You receive the slips after you have chosen your pairs." (Fiona found "outcome slips" unclear; pick another name if "reveal slips" is also unclear.) |
| "after-cost", "before-cost" | "waste cost 12 months after GreenWaste", "waste cost before GreenWaste" |
| "ten-record cost example" | "the ten selected records of annual waste management cost" |
| Landfill versus cost (D3S2 Figure E, Q4, section 3) | Always write "landfill waste, in tonnes per business per year" and say when the outcome changes (see item B below). |

---

## 3. Terms to settle (confirm each)

| Issue | Where | Proposal |
|---|---|---|
| "extra change", "extra reduction", "extra recorded reduction" for the difference-in-differences estimate | D2S1 title, slides, worksheet H4-A, Day 3 S1 | **Decided (Fiona, 9 Oct):** use "the difference between the two changes". Also state the method name where the estimate is first calculated: "This is called the difference-in-differences (DiD) estimate." Currently the full name appears in the D2S1 subtitle and in H4-A section 2 only. Add it to the slide where the four-number arithmetic is done (D2S1 slide 3), the regression slide (slide 5), and each later mention in Day 2 and Day 3 until it is routine. |
| "real", "actual" records, "actual pilot groups", "actual landfill records" | D1S1, D1S2, D1S3, D2S3, D3S2 | **Decided (Fiona, 9 Oct):** the case is fictional, so replace with "records from the GreenWaste data" or "selected records". |
| "Naive prompt" / "Better prompt" | All AI Snapshots | **Decided (Fiona, 9 Oct):** keep "Naive prompt" (it tells participants more than "First prompt"). Change "Better prompt" to "Improved prompt" for consistency. Explain "naive" in a few words on first use, e.g. "a prompt with no context, as a busy person might type it". |
| "authored exercise material", "illustrative prepared response, not a live Copilot transcript", "authored practice response" | All AI Snapshots | One sentence everywhere: "This response was written for the exercise. It is not a real AI answer." |
| "after-only gap", "with/without" | D1S2, D1S3, D2S1 | "the difference between the two groups after the programme". |
| "null model", "zero-mean-change model" | D1S1 slide 11, Q5 | "Which assumption about the effect does the p-value start from?" or "What does the p-value assume about the change?" |
| "denominator" | D3S2 | "the total that each percentage is based on". |
| "business-clustered robust intervals (Stata correction)" | D2S1 p05 and H4-A | Move to a footnote or the notes. Participants do not need it to read the table. |
| Row labels in regression tables ("After minus before", "Participant gap, before", "Extra change: after x participant") | D1S1, D2S1 | See section 5. Each row gets a plain-language label with the model term in brackets. |
| "Old habits", "Hidden costs", "A shorter life", "A higher discount rate" (scenario card titles) | D3S1 cards | Say what changes: "Savings shrink each year", "Added administration costs", "Savings last three years", "A discount rate of 8%". |
| Document IDs (H1-A, H8-A, Table R) | all | Keep (useful for cross-reference), but always add a short description on first mention, e.g. "H4-A, the city study extract". |

---

## 4. Trainer and production wording that must not reach participants

Remove from slides and printed pages; keep only in speaker notes, a trainer print sheet, or HANDOFF.md.

**Process or change-log wording**
- Author line on every title slide: "3ie · Review version".
- Worksheet banners: "Separate Session 1 review worksheet", "Separate Day 2 Session 3 review worksheet", "The current published handout is unchanged", "All pages below belong to the separate review version."
- Source lines naming the corrected file or script: "corrected evaluation_data_GreenWaste_simple.csv" (D1S2, D1S3 slips, D2S1, D2S3, D3S1, D3S2), "Corrected city CSV", "H8-A §1, corrected city records" (this one sits inside the sentence participants are asked to repair), "day2_case.R", "day2_session1_review.R", "session3_review.R", "day3_session2_review.R", and "Values come from cost_before" (D1S1 page 4). Replace with "Source: GreenWaste city data" or the table ID.
- "These five cards preserve the current scenario inputs and eight-group allocation" (D3S1 cards).
- "Scenario results are revealed in the review deck" (D3S1 cards).
- "The board is a paper/browser reference, not a shared room poll. Use the existing A1 board for the full-room activity." and "Choices remain in this browser page. For group or room use ... use printed cards or the existing A1 board." (D1S2 cards, D3S1 cards).
- "This supplied extract is the source, not a separately distributed report" / "there is no separate report to find" (D1S3, D2S1, D2S3, D3S1, D3S2). Reword for participants: "Use this extract as your source for today's questions."

**Instructions addressed to the trainer on pages participants hold**
- D2S3 cards: "Trainer: cut along dashed borders. Distribute page 1 only; retain page 2 until pairs are recorded."
- D3S1 cards: "For eight groups print Cards 1, 2 and 3 twice: allocation 1, 2, 3, 4, 5, 1, 2, 3. Retain page 7 until predictions are recorded."
- D3S1 worksheet: "Table S (cards page 7) is held by the trainer until predictions are recorded."
- "After the trainer distributes cost slips" (D2S3 Q1), "Table S ... distributed after predictions".
- Slide titles: "The trainer computes the paired difference" (D2S3), "The trainer checks the two denominators" (D3S2). Reword as an activity: "Check the paired difference in R."
- Slide text boxes: "How the trainer obtains the two means" (D1S2 p05), "The trainer compares mean cost changes" (D2S1 p04). Decide whether the R code boxes stay visible (see section 7); if so, label them "R code" without the trainer framing.
- Fix: put print and distribution instructions on a separate trainer print sheet (one per card or slip set), not on the participant pages.

**Defensive caveats that read as notes to colleagues**
- "Figures are rounded for display; changes and gaps use unrounded means." Keep once per document, shortened: "Figures are rounded."
- "It is a possible improved response, not a guarantee of how an AI tool will answer." Shorten to one sentence, same for all AI pages.

---

## 5. Specific wording issues, by file (proposed rewrites for Fiona to confirm)

Status of the examples in Fiona's Language issues document:

| Fiona's example | Status in the previews |
|---|---|
| "Would a fall after GreenWaste, on its own, establish its effect?" | Not found in this form. D1S1 Q2 now reads "Does the before/after comparison supply what would have happened without GreenWaste?", which is still awkward. Rewrite below. |
| "After minus before" row in the table | Still present (D1S1 slide 7 and H1-A). Rewrite below. |
| "Annual waste cost in AED" | Still present in headings, captions and prompts. Use "Annual waste management cost in AED". |
| "Find the change row p-value" (Oct 12 Worksheet 1) | Still present as "Find the change p-value" in Q5. Rewrite below. |
| "Is it landfill waste volume or cost?" (Oct 12 deck 2) | The headline slide is gone. The same confusion returns in D3S2 (Figure E, Q4, section 3). |
| "That headline lands on your desk" / "Landfill waste from businesses ... fell 50%" | Replaced by "A cost result lands on your desk" (cost, not landfill). Rename per section 2. |
| "shops" versus "business" | Still present in the GreenWaste case map (`_case_map.qmd`, used in the Day 1 decks and the picture card): the map legend says "shops joined", "shops scoring 58 or below" and "the number under each shop", and the description says "shops". Change to "businesses" and keep "business" throughout. |
| DiD slide "Both groups changed. What was extra?" | Still present as the D2S1 slide 2 title. Rewrite below. |
| "Can one 'before' show a trend?" | Still present (D2S1 slide 9). Rewrite below. |
| Partial sentences, e.g. Session 2 title and "We read -669" | Both still present. Rewrite below. |

### A. Slide and card titles (full sentences)

| Where | Current | Proposed |
|---|---|---|
| D1S2 title | Good news. Enough to act? | We receive good news. Is it enough to act on? |
| D1S2 slide 1 | We read -669. Was it the programme's effect? | We read that the mean annual waste cost fell by 669 AED. Was that fall the programme's effect? |
| D1S2 slide 2 | One row. One business. Two measurements. | Each row shows one business, measured twice. |
| D1S2 slide 9 | Lower than without. Already lower before. | Participants ended with lower costs. Were their costs already lower before? |
| D1S2 slide 10 | Two numbers. Two weak comparisons. | Each number compares something different. Why is neither enough on its own? |
| D1S2 slide 11 | Four cost claims. Which would you act on? | Here are four claims about GreenWaste. Which would you act on? |
| D1S2 slide 14 | Ask for a comparison-aware explanation | Ask the AI to say which comparison it is using. |
| D1S1 slide 12 | Statistically clear. Large enough to matter? | A result can be statistically clear. Is it large enough to matter? |
| D1S1 slide 13 | A lower cost. Enough saving? | The cost fell. Is the saving enough? |
| D1S1 slide 15 | A plausible AI reading of the table | Here is an AI explanation of the table. Do you agree with it? |
| D1S1 slide 16 | Ask for a reading you can verify | Ask the AI for an explanation you can check. |
| D1S3 slide 1 | Two city comparisons. Why a lottery? | We have two city comparisons. Why would a lottery be better? |
| D1S3 slide 2 | The pilot district: 400 businesses, 200 places | The pilot district had 400 businesses and 200 places. |
| D1S3 slide 3 | What the lottery buys us | What does a lottery give us? |
| D1S3 slide 9 | Does the interval clear our rule? | Is the whole interval above our 1,000 AED rule? |
| D1S3 slide 11 | Three numbers. Three comparisons. | Each of the three numbers compares different groups. |
| D1S3 slide 12 | Would you extend it now? | Would you extend GreenWaste now? |
| D2S1 slide 1 | Yesterday's saving. Today's question. | Yesterday we found a saving. Today we ask what else changed. |
| D2S1 slide 2 | Both groups changed. What was extra? | Costs changed in both groups. How much more did participants' costs fall? |
| D2S1 slide 3 | Four numbers. What is the extra change? | Use four numbers to find the difference between the two changes. |
| D2S1 slide 7 | Same city. Different changes without GreenWaste? | Could the two groups have changed differently even without GreenWaste? |
| D2S1 slide 9 | Can one before measure show a trend? | Can one measurement before the programme show a trend? |
| D2S1 slide 10 | A precise result. Enough to meet the rule? | The estimate is precise. Does it meet the 1,000 AED rule? |
| D2S1 slide 12 | The AI says cause. Does the comparison? | The AI says GreenWaste caused the change. Does the comparison support that? |
| D2S3 | Similar on what we can see; Open the costs, not a new pairing; Closest available may still be too far; Above the rule. Certain enough? | Full-sentence versions needed: "How can we find businesses that look similar?"; "Reveal the outcomes without changing your pairs."; "Is the closest available business close enough?"; "The estimate is above the rule. Are we certain enough?" |
| D2S3 | The trainer computes the paired difference | Calculate the paired difference in R. |
| D3S1 | A ratio of 1.86. Approve? | The benefit-cost ratio is 1.86. Should we approve? |
| D3S1 | Ratio and net present value answer different questions | Fine, but spell out "net present value (NPV)" on first use. |
| D3S2 | A supported description is not a causal verdict | A description the data support is not proof that GreenWaste caused the fall. |
| D3S2 | Why 44% and 60% both answer real questions | Why are 44% and 60% both correct answers? |
| D3S2 | The trainer checks the two denominators | Check which total each percentage uses. |
| D3S2 | Spread between businesses is not this interval | Variation between businesses is different from this confidence interval. |
| D3S2 | Before trusting a chart, check what? | What should you check before trusting a chart? |

### B. Worksheet questions and instructions (examples; same pattern applies to every Q)

| Where | Current | Proposed |
|---|---|---|
| D1S1 H1-A page 1, header | Today we read annual waste cost in AED. | In this session we read results about the annual waste management cost of each business, in AED. |
| D1S1 Q1 | Calculate mean. Compare mean and median before/after removing the largest value. Which moves more, and why? | (a) Calculate the mean waste cost of the ten businesses. (b) Calculate the mean and the median again after removing the largest value. (c) Which of the two changes more, and why? |
| D1S1 Q2 | Does the before/after comparison supply what would have happened without GreenWaste? Explain the missing outcome. | The costs fell after GreenWaste. Does that tell us what would have happened to these businesses without GreenWaste? Explain what information is missing. |
| D1S1 Q3 | Mark the change row in H1-A. State its number, units, comparison and sign. Reconstruct the after mean. | (a) Mark the row that shows the change. (b) Write its value, its units, what it compares, and whether it is positive or negative. (c) Use the table to work out the mean cost after GreenWaste. |
| D1S1 Q4 follow-up | Which stays above 1,000? What remains uncertain in B/C? | Which of the three intervals stays above 1,000 AED? What is still uncertain in B and C? |
| D1S1 Q5 | Find the change p-value. What null model is tested? Does the p-value establish causality or the probability that the programme works? | (a) Find the p-value in the change row of the table. (b) What does the p-value assume about the change? (c) Does the p-value show that GreenWaste caused the fall, or the probability that the programme works? |
| D1S1 closing box | Close AI responses and term explanations; keep H1-A open. Write the result, what it cannot establish, and a specific evidence request with its purpose. | Close the AI responses and your notes on the terms, and keep H1-A open. Write three sentences: what the table shows, what it cannot show, and one piece of evidence you would ask for and why. |
| D1S1 table | Result row "After minus before" | "Change after GreenWaste (after minus before)" |
| D1S1 table caption | Annual waste cost in AED. The same city participants before and 12 months after. | The table shows the annual waste management cost, in AED, of the same city participants before GreenWaste and 12 months after. |
| D1S2 Opening judgement | Participants' mean annual cost fell by 669 AED. Does this tell us the programme's effect? Give a reason to revisit later. | The mean annual waste cost of participants fell by 669 AED. Does this tell us the effect of the programme? Write one reason. We will return to it at the end of the session. |
| D1S2 Q1 | Describe B00402: participation, before/after annual costs and period. Which population does the participant average describe? How many businesses? | (a) Write one sentence about business B00402. Say whether it took part, what its costs were before and after, and over what period. (b) Which group of businesses does the participant average describe, and how many are in it? |
| D1S2 two comparisons | Before/after: same participants, after minus before = -669 AED. With/without, after only: ... = -1,638 AED. | Before and after: for the same participants, the mean cost after minus the mean cost before is -669 AED. Participants and non-participants after the programme: the participants' mean cost minus the other businesses' mean cost is -1,638 AED. |
| D1S2 summary table | "Their outcome after a year without GreenWaste" | Replace the fragment with a sentence: "We do not know what the participants' costs would have been after a year without GreenWaste." |
| D1S2 Q5 | For each: choose Act / Ask first / Do not act, give source support and a missing question with its purpose. Say what action you mean. | For each claim: (a) choose Act, Ask first or Do not act. (b) Write what the source supports. (c) Write one question you would ask and why the answer matters. (d) Say which action you mean. |
| D1S2 cards, card 3 | Source supplied: City before/after model: null is zero mean change among participants. | Source: the city before and after model, which tests whether the mean change among participants is zero. |
| D1S3 Q1 | Use H3-A §1-3 on page 1. Why is the waiting group a more credible comparison than businesses that chose whether to join? | Read paragraphs 1 to 3 of H3-A on page 1. Why does the waiting group give a more reliable comparison than businesses that chose whether to join? |
| D1S3 Q5 | Give a trial-design strength, a consequential limit and a proportionate condition. State the scope of the action. | Write one strength of the trial design, one limit that matters for the decision, and one condition that fits the size of the decision. Say which businesses your action covers. |
| D1S3 recommendation box | Finding and source; action or condition; important limit and specific request. Peer source check: comparison and population; units/period; ... Mark one claim to strengthen. | Write three sentences: (1) what the pilot found, and the table you took it from; (2) what you recommend; (3) the most important limit and the evidence you would request. Then swap with a partner. Can your partner find the source for each claim? Mark one claim that needs more support. |
| D2S1 H4-A | Extra change: after x participant | Additional change: after × participant (the difference between the two changes) |
| D2S1 H4-A | Participant gap, before | Participants minus other businesses, before GreenWaste |
| D2S1 H4-A | Other group, before; Other group's change | Other businesses, before GreenWaste; Change in other businesses |
| D2S1 Q1 | Calculate after minus before in each row. ... Participant change minus other-group change: ____ | Calculate the change (after minus before) for each group. Then subtract the other businesses' change from the participants' change. |
| D2S1 Q3 | State parallel trends in this case without saying the groups must start at the same level. ... Explain the feature. | (a) Explain the parallel trends assumption for GreenWaste in your own words. The groups do not need to start at the same cost. (b) Which hypothetical history, A or B, makes you hesitate? Describe what looks different. (c) What does the more reassuring history still not prove? (d) Could the GreenWaste file show earlier trends? |
| D2S3 H6-A §4 | The business-clustered robust interval accounts for reused controls treating selected matches as given. | The interval allows for the reuse of control businesses. It treats the selected matches as given. (Sentence is garbled in the current version.) |
| D2S3 Q6 | One interpretation, one strength and one consequential concern: Act, act with conditions or ask first: your reason, then one matching-specific evidence request ... | (a) Write one sentence interpreting the result, one strength of the comparison and one concern that matters for the decision. (b) Choose Act, Act with conditions or Ask first, and give your reason. (c) Request one piece of evidence about the matching and say how the answer could change your decision. |
| D2S3 reminder | lottery = assigned groups; DiD = extra change; RDD = fitted cutoff jump; matching = selected recorded similarities. | Four methods compare in four ways. A lottery compares groups assigned by chance. Difference-in-differences compares changes over time. Regression discontinuity compares businesses either side of a cut-off. Matching compares businesses chosen because they look similar. |
| D3S1 §4 | An additional check gives ratio 0.66 at 40%, holding all else fixed. | An extra check shows that a discount rate of 40% would give a ratio of 0.66, with all other inputs unchanged. |
| D3S1 cards | Everything else stays fixed: base annual saving 812 AED ... except the input(s) this card changes. (repeated on each card) | State the base case once on the board page. On each card: "Change: ... All other inputs stay at the base values." |
| D3S2 Q4 | After the actual city summary is shown, explain what 49.5% and 58.6% measure and which denominator each uses. | After you see the city summary, explain what 49.5% and 58.6% each measure. Which total is each percentage based on? |
| D3S2 §3 | Every starting denominator here is positive. | Every business started with a positive number of tonnes, so each percentage can be calculated. |
| D3S2 Q7 | Name a check and the error it prevents. Give one supported statement and one limit from today's evidence. | (a) Name one check you will do before trusting a chart, and the mistake it prevents. (b) Write one statement that today's evidence supports and one limit. |

### C. Captions, notes and table text that are fragments

Rewrite as sentences, or label them clearly as table notes:
- D1S1 slide 9: "Cost change in AED. Zoomed axis: 720 to 620; zero is outside this view." and "Estimate / repeated-sample illustration".
- D1S1 slide 10: "Hypothetical estimates of annual saving, AED." and D1S1 slide 12: "A: p < 0.001. B: p ≈ 0.072."
- D1S2 slide 8: "5,206 businesses above the participation score cutoff." becomes "These 5,206 businesses had scores above the cut-off for taking part."
- D1S3 slide 3: "Random assignment avoids systematic selection, across possible lotteries." (unfinished thought) becomes "Over many possible lotteries, random assignment does not favour one kind of business."
- D1S3 slide 5: "Illustration: 200 practice lotteries per size" and slide 7: "Lower annual waste costs in the join group, 12 months after, among eligible pilot businesses."
- D2S1 captions "Hypothetical histories, identical scales" and "Extra reduction compared with the rule".
- D3S2 page 1 "What is supported, and what is not?" and "Why does the baseline matter?" are good questions, but the answers beneath use long compound sentences. Split.

---

## 6. Other changes for the preview versions

1. **Outcome changes without warning (Day 3 S2).** Figure E and Q4 switch from AED costs to landfill tonnes. Add a one-line "The outcome changes on this page: landfill waste, in tonnes per business per year" at the top of those sections, and use the same unit label every time.
2. **Fictional case versus "real" data.** See section 3. Also check that "actual" is not used to mean "the true effect".
3. **Remove "Review version" labels and comparison hubs from anything published for participants.** The comparison pages (`day2_session1_compare.html` etc.) stay in the team preview area only.
4. **R code on slides.** **Decided (Fiona, 9 Oct):** some code snippets stay visible, not all code. Keep the snippets already in the previews (D1S1 slide 8, D1S2 slide 5, D2S1 slide 4, D2S3 slide 10, D3S1 slide 8, D3S2 slide 10) and add the ones listed in section 8B. Label them "R code", not "trainer", and keep comments in plain English.
5. **Print instructions out of participant pages.** Move cutting, copying and distribution instructions to one trainer print sheet per activity.
6. **Repeated disclaimers.** "GreenWaste is a fictional training case" appears on each worksheet page group; once per document is enough.
7. **Question density.** Several questions (D1S1 Q3 to Q5, D2S3 Q6, D3S1 Q4) ask five or six things in one box. Number the parts and leave a writing line for each.
8. **Table headings.** "Coefficient AED", "95% interval AED" become "Coefficient (AED)" and "95% interval (AED)", with the first-use explanation of "coefficient" in a short line beneath the first table.
9. **Pet-peeve pass.** Run the writing-rules pass on all previews, including the AI response texts and prompts.
10. **Check numbers after rewording.** After any edit, recheck the figures the R scripts produce (669, 1,638, 812, 1,014, 1,029, 1.86 and the scenario ratios) against the printed pages.
11. **Housekeeping.** About 30 tracked files show as modified since the last commit with equal insertions and deletions. This looks like a line-ending change. Confirm before the next commit so the real edits are visible in the diff.
12. **Missing previews.** Day 2 S2 (regression discontinuity), Day 3 S3 and Day 4 have no review versions yet. Apply sections 1 to 4 when they are built.

---

## 7. Decisions made on 9 October

- "The bar charts" is fine as a general phrase; name the chart ("Chart A", "Figure C") when only one is meant.
- Use "the difference between the two changes" for the difference-in-differences estimate, and state "difference-in-differences (DiD)" where it is first calculated (section 3).
- Replace "real" and "actual" with "records from the GreenWaste data" or "selected records" (section 3).
- Some R snippets stay visible on slides (section 8B).
- Do the language pass session by session with a before-and-after list for approval (section 8A). Do not start until Fiona says so.
- "Claim cards" become **"decision cards"** (confirmed). "Outcome slips" are still to settle: "reveal slips" is proposed (section 2), with the context explained on first use.

---

## 8. Additions to discuss and add to the previews

### 8A. Process for the language pass (agreed, not started)

1. Work one session at a time in this order: Day 1 S1, S2, S3; Day 2 S1, S3; Day 3 S1, S2. Apply the same rules to Day 2 S2, Day 3 S3 and Day 4 when their previews are built.
2. For each session, edit the review `.qmd` files (slides, worksheet, cards or slips) and the R helper files that produce text.
3. Before anything is rendered, give Fiona a before-and-after list for that session: location, current text, new text, reason. Fiona approves or revises.
4. Then re-render, recheck all figures against the R scripts, recheck that every slide fits 1280x720 and every worksheet page fits A4, and look at the rendered pages.
5. Add a short entry to `HANDOFF.md` and tick the items in this file.
6. Content additions (sections 8B to 8H) are proposed separately from the language pass, so the before-and-after lists stay readable.

### 8B. R code snippets on slides

Visible code already in the previews: D1S1 slide 8 (the minus-sign calculation), D1S2 slide 5 (`colMeans`), D2S1 slide 4 (change calculation), D2S3 slide 10 (paired difference), D3S1 slide 8 (model arithmetic), D3S2 slide 10 (denominators). Keep them, relabelled "R code" (section 6, item 4).

Add (Fiona, 9 Oct):
- **D1S3 and all Day 2 sessions: a short snippet that creates the regression table, followed by a slide that explains the table.** The model code already exists in the case scripts and can be shortened for a slide:
  - Pilot lottery (D1S3): `lm(cost_after ~ took_part, data = pilot)` (`greenwaste_case.R`).
  - Difference-in-differences (D2S1): reshape to one row per business per period, then `estimatr::lm_robust(cost ~ after * took_part, data = long, clusters = business, se_type = "stata")` (`day2_case.R`).
  - Regression discontinuity (D2S2, when built): `lm_robust(cost_after ~ below * dist, data = near)` (`greenwaste_case.R`).
  - Matching (D2S3): `lm_robust(cost_after ~ took_part, data = matched, clusters = business, se_type = "stata")` (`day2_case.R`). Table R is currently a two-row comparison; show the same call and the line of output it produces.
  - Optional for D1S1: the before-and-after model on the participants (two rows).
- Each snippet is at most 6 to 8 lines, with plain-English comments. Show the code and its output side by side, and draw lines from each code part to the table row it produces (formula to rows, `clusters` to the interval).
- Participants do not need to run the code. Each snippet has a paper equivalent on the worksheet.
- Explain the table on the next slide: what each column means, which row is the comparison, the reference group, the number of observations and the model note (`SLIDE_HANDOUT_REVIEW_PLAN.md` already proposes annotated tables for D1S1-P07, D2S1 slide 04 and D2S2 slide 05).

### 8C. The "review and interpret the regression table" activity

What happened: before the 6 October rebuild there were two full table tasks. Day 1 Session 2 ("Annotate this output") used a two-row before-and-after table: circle the change, box the interval, underline the baseline mean and say why it is not the effect, and write a question for the evaluator. Day 2 Session 1 ("Which row is the impact?") used the four-row table: circle the effect row, say what the "After" and "Took part" rows measure, check the smallest end of the interval against 1,000 AED, and say what cannot be checked with one before measure. The rebuild cut every deck and handout by roughly half (`REVIEW_NOTES.md` items 6b and 6c), moved "Annotate this output" into Day 1 S1's table reading, and removed the stand-alone tasks.

The previews restore only parts of it:

| Session | Table in the preview | Worksheet task today |
|---|---|---|
| Day 1 S1 | Two-row before-and-after table (H1-A) | Q3 mark the change row, Q4 interval, Q5 p-value, spread over three questions |
| Day 1 S2 | None (descriptive session) | None |
| Day 1 S3 | Two-row pilot table (H3-A) | Q2 combines calculation and reading in one question |
| Day 2 S1 | Four-row DiD table (H4-A) | Q2 find the row and explain; the interval check sits in Q4 |
| Day 2 S2 | No preview yet | None |
| Day 2 S3 | Table R is a matching comparison, not a regression table | Q2 reads Table R |

Proposal: a boxed task called "Read the regression table" on the worksheet for Day 1 S3 and every Day 2 session (Day 1 S1 already has the pieces; make it the same box). Use the same six steps each time, written as full sentences, with a clean copy of the table to annotate: (a) circle the row that answers the question; (b) write its value, its units and what it compares; (c) say what each of the other rows describes; (d) box the interval and say what it describes; (e) read the p-value and say what it does and does not show; (f) say what the table cannot tell you. The same box makes the independent reading task at the end of each session easier to mark.

### 8D. AI examples: keep the preview versions

**Decided (Fiona, 9 Oct):** keep the AI responses and the improved prompts exactly as they are in the previews. Do not shorten them or switch back to the earlier (pre-6 October) versions. The earlier responses were shorter (about 40 to 75 words) but had almost every sentence wrong, so there was little to mark as supported; the previews have a mix of supported claims and overclaims (Day 2 Session 1: 3 supported sentences, 1 neutral, 3 with errors).

The AI best-practice sheet is already settled (`REVIEW_NOTES.md` item 13) and is not repeated here.

Only the language rules apply to the AI pages (section 1): full sentences, "Improved prompt" in place of "Better prompt" (keep "Naive prompt"), and one standard sentence in place of the "authored exercise material" wording (section 3).

### 8E. Day 1 Session 2: more code, data exploration and cleaning

Add code that shows how the numbers are produced:
- **What is in the file?** `glimpse(data)` or `str(data)` and `table(data$setting)`: 10,400 rows and 12 columns, of which 10,000 are city businesses and 400 are in the separate pilot.
- **Who is included in these averages?** (the current slide 3) shows `table(city$took_part)` giving 4,794 and 5,206, then the mean of `cost_before` and `cost_after` for each group. This is data exploration, as Fiona suggested, and the code makes the denominators visible.
- **Baseline distribution:** `summary(city$cost_before)` for mean and median, and the histogram call.
- **Change per business:** `change <- cost_after - cost_before`, `mean(change)` and `sum(change > 0)` (485 participants whose cost rose).

Add data-cleaning content (Fiona, 9 Oct):

**A. One slide of hypothetical cleaning examples (required, whatever is decided about the negative values).** Title as a full sentence, for example "Real datasets need cleaning before anyone calculates a mean." Show a small image of a messy table next to the cleaned one, labelled "invented example, not in the GreenWaste file", with the effect on the answer for each: duplicate business IDs (rows and mean change); missing values coded as 999 or -99 that get averaged as real numbers; one cost recorded in thousands of AED instead of AED; inconsistent labels ("Yes", "yes", "Y") that split a group in two; a merge on the wrong key that repeats rows; a before-and-after file stacked without a business ID. Pick three or four, with the effect on the mean worked out so the numbers are correct. The message: check what is in the data before calculating anything, because a wrong structure gives a wrong answer with no error message.

**B. The filtering example, from the real file (include on the "Who is included in these averages?" slide).** The point: make sure the data are the subset and sample you want, with nothing extra. The file holds 10,400 rows: 10,000 city businesses and 400 businesses in the separate pilot (`setting` column). The course code already filters before any calculation (`city <- subset(gw, setting == "city")` and `pilot <- subset(gw, setting == "pilot")`, in `greenwaste_case.R`), so every printed number in the course uses the correct subset. The filter is a step done in the background today; this slide would show it.

Is including the pilot "technically fine"? No, for three reasons. (1) The pilot is a different population: all 400 businesses scored below 58, and a lottery decided who joined. (2) The 200 pilot businesses who waited have scores that qualify them but did not receive GreenWaste, so they would sit in the city's "did not take part" group, even though they are not comparable with city non-participants, who all scored above 58. (3) Group sizes and answers change. Computed from the file (recheck in R before use):

| Quantity | City rows only (correct) | All 10,400 rows (wrong) |
|---|---|---|
| Participants | 4,794 | 4,994 |
| Other businesses | 5,206 | 5,406 |
| Participants' mean change | -669 AED | -667 AED |
| Other businesses' mean change | +143 AED | +152 AED |
| Difference between the two changes | -812 AED | -819 AED |

The differences are small here, which is a useful point in itself: the error is easy to miss, and it would not have been spotted from a sensible-looking result. The group sizes show it.

**C. Negative costs (optional, depends on Lucas).** 734 of the 10,000 city businesses (733 of them participants) have a negative annual waste cost 12 months after, with a minimum of -1,565 AED. Cost cannot be negative unless it is net of income such as recycling revenue. The choice changes the answer: keeping them gives a mean fall of 669 AED (4,794 participants); dropping them gives 551 AED (4,061 participants); setting them to zero gives 616 AED. **QUESTION FOR LUCAS: are these negative values intended** (and if so how does the case brief explain them) or are they a data-generation problem? If intended, add a sentence to the case brief and table definitions; if not, fix the data and recheck every figure in the course. This is an additional slide only if the answer changes the data or the case brief. Until Lucas answers, do not build it into a slide.

Time: these additions cost minutes. Check the Day 1 S2 budget in `SLIDE_HANDOUT_REVIEW_PLAN.md` and decide what to shorten.

### 8F. End of Day 1 Session 2: state both comparisons and hand over to Session 3

Current state: slide 10 names both comparisons (before and after, -669 AED; with and without, -1,638 AED) with "what each misses". Five slides then follow (cards, AI, final reading), so the two comparisons are not what participants see last. The closing slide asks only "Could the pilot's lottery give a fairer comparison?" Day 1 S3 slide 1 then restates both comparisons.

Proposal: the final slide of Session 2 states both in full sentences, with the same labels used on Session 3 slide 1: "Before and after: for the same participants, the mean annual waste cost fell by 669 AED. With and without: after the programme, participants' mean cost was 1,638 AED lower than other businesses' mean cost. Neither tells us what would have happened without GreenWaste. Tomorrow's first question is: can a lottery give a fairer comparison?" Use "with and without" and "before and after" everywhere; drop "after-only gap" and "with/without" (section 3).

### 8G. Show the GreenWaste map before every methods section

The case map (`_case_map.qmd`) appears only in the Day 1 S1 preview. Proposal: a standard "Who and what are we comparing?" slide built from the same map, shown at the start of every methods session, with a highlight option:

| Session | Map highlight and text |
|---|---|
| Day 1 S2 | No highlight. "Let's consider all the businesses in the city." 10,000 businesses; the unit is one business; the outcome is annual waste management cost in AED; measured before and 12 months after. |
| Day 1 S3 | Pilot district highlighted: 400 businesses, 200 places by lottery. |
| Day 2 S1 | City: participants (4,794) and other businesses (5,206). |
| Day 2 S2 | Businesses just below and just above the score of 58. |
| Day 2 S3 | Participants and their matched comparison businesses. |
| Day 3 S1 | Participants, with the per-business benefit and the delivery cost. |
| Day 3 S2 | Which group each chart describes. |

Each slide states the unit, the group and its number, the outcome and its units, and the period, so participants know the population before details start. A small version of the same map can sit in the worksheet header. Fix the "shops" wording in the map at the same time (section 5).

### 8H. Day 3 Session 2: add a scatter plot or another typical impact-evaluation graph

Add at least one graph of the kind seen in evaluation papers, with a question about reading it. Options:
1. **Scatter plot with a fitted line:** annual waste cost before (x axis) against after (y axis) for a random sample of city businesses, participants and others in different colours, with a fitted line for each group and a 45-degree "no change" line. Questions: What does each point represent? What does the line show? Does the line show cause? (Use a random sample or transparent points; 10,000 points would hide the pattern.)
2. **Coefficient (forest) plot:** the estimates and intervals from the five methods on one axis, with the 1,000 AED rule marked. It repeats a graph type almost every evaluation report contains, and it ties the course together.
3. **Score against cost with a cut-off line** (regression discontinuity style), if not already used in Day 2 S2.
Recommend options 1 and 2. Add one worksheet question for each ("What does each point show? What would change if the line were steeper?").

---

## 9. Open questions for Fiona

1. "Decision cards" is confirmed. Are "reveal slips" (D2S3: the slips that show each business's annual waste cost after 12 months, handed out once pairs are chosen) clear once explained on first use? If not, which word would you use?
2. **For Lucas:** are the negative annual waste costs after the programme intended? This affects the cleaning example and possibly the whole case. If we do not pursue it, use hypothetical cleaning examples (section 8E, part A, which goes in regardless).
3. Time budgets: Day 1 S2 gains code and cleaning examples; D1S3 and Day 2 gain table snippets and explanation slides; Day 3 S2 gains a graph. What should be shortened?
4. Keep base R plus `estimatr` for all snippets (as in the existing scripts), or switch to the tidyverse for readability?
5. Day 3 S2 graph: scatter plot, forest plot, or both?
6. AI examples: (Answered: keep the preview versions unchanged apart from the language rules.)
7. When may the session-by-session language pass start, and should the content additions (section 8) go in the same pass or after it?
