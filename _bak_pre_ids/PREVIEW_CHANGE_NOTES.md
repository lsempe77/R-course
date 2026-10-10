# Preview versions: further changes and language review

Draft for Fiona, 9 October 2026. **Status (9 October, later): sections 1 to 7 have been applied to the source files of all seven existing previews (Day 1 S1 to S3, Day 2 S1 and S3, Day 3 S1 and S2), including worksheets, cards, slips and R helper files. Section 8 additions are not started. The published copies in `docs/preview/` have not been re-rendered yet. See `HANDOFF.md` and `PRINT_SHEETS_TRAINER.md`.** This file lists what was to change, with the approved wording.

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

Replacements:

| Current | Proposed |
|---|---|
| "A cost result lands on your desk" (D1S1 slide) | "An impressive result lands on your desk." |
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
| "extra change", "extra reduction", "extra recorded reduction" for the difference-in-differences estimate | D2S1 title, slides, worksheet H4-A, Day 3 S1 | **Decided (Fiona, 9 Oct):** use "the difference between the two changes". Also state the method name where the estimate is first calculated: "This is the difference-in-differences (DiD) estimate." Currently the full name appears in the D2S1 subtitle and in H4-A section 2 only. Add it to the slide where the four-number arithmetic is done (D2S1 slide 3), the regression slide (slide 5), and each later mention in Day 2 and Day 3 until it is routine. |
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

### 3A. Term decisions made on 9 October (these replace the matching proposals in the table above)

| # | Term | Decision |
|---|---|---|
| 1 | Name for the comparison group | Use the technical terms. **Treatment and control** in the pilot lottery ("treatment group", "control group"; do not use "join group" or "waiting group"). In the city sessions: **"participant businesses"** (the treatment businesses) and **"comparison businesses that did not receive GreenWaste"** (the control businesses). Do not use "nonparticipants", "others", "other group" or "other businesses". In matching: "comparison businesses" (and "control" where the method is named). Gloss each term on first use in each session, e.g. "comparison businesses (also called controls) did not receive GreenWaste". |
| 2 | Name for the 1,000 AED test | Say the full rule wherever it is applied, especially when it has not been stated for a while: "our rule of at least a 1,000 AED reduction in annual waste management cost per business per year". Never "the rule" on its own. "Threshold" and "target" are acceptable only next to the figure ("the 1,000 AED threshold"), and "a reduction in costs of at least 1,000 AED" is preferred to "saving" in the test itself. Titles and questions: "Does it meet our rule of at least a 1,000 AED reduction?" |
| 3 | Names for the two Session 2 comparisons | Agreed: "before and after" and "with and without", each glossed on first use; drop "after-only gap". Because of decision 1, the gloss reads "participant businesses compared with comparison businesses, after the programme". |
| 4 | "Authored exercise material" and variants | Agreed: "This response was written for the exercise. It is not a real AI answer." |
| 5 | "Null model" | Agreed: "What does the p-value assume about the change?" |
| 6 | "Denominator" | Say it with the plain wording in brackets: "denominator (the total that each percentage is based on)". |
| 7 | Clustered robust intervals (Stata correction) | Agreed: notes only; on the page, "The intervals allow for each business being measured twice." |
| 8 | Regression row labels | Agreed, with the group names from decision 1. Day 1 S1: "Mean cost before GreenWaste (intercept)"; "Change after GreenWaste: after minus before". Day 1 S3: "Control group: mean cost after 12 months"; "Treatment group minus control group". Day 2 S1: "Comparison businesses, before GreenWaste (intercept)"; "Change in comparison businesses (after)"; "Participant businesses minus comparison businesses, before GreenWaste (took part)"; "Difference between the two changes (after × took part)". |
| 9 | Scenario card titles | Agreed: "Savings shrink each year", "Added administration costs", "Savings last three years", "A discount rate of 8%". |
| 10 | Document IDs | Keep the IDs, and give each a short description tied to the method, stated on first mention on every slide, worksheet page and card (see below). |
| 11 | Jargon in instructions | Agreed (replace "proportionate", "consequential", "attribution"; drop "unrounded"; keep taught terms). |
| 12 | Cut-off spelling | Agreed: "cut-off". |
| 13 | Fall, change, effect, saving | Agreed. |

Document and table titles (proposed, for Fiona to confirm).

**"Extract" is replaced by "summary".** What the previews call a "study extract" is a short written summary of one study (four numbered paragraphs on who and when, what was compared, what a causal reading needs, and what the data can establish) with its results table. Use "study summary" everywhere ("study extract" also appears in the Day 1 S3, Day 2 S1 and Day 2 S3 worksheets and slides). First mention on each slide, worksheet page and card: the ID plus the plain description.

**Every table and figure gets a full descriptive title** that says what is measured, for which businesses (with the number), in what units, and when. No short names such as "Table F, the cash flows". The ID stays as a label for cross-reference only.

| ID | Document (first mention) | Table or figure titles |
|---|---|---|
| H1-A | "H1-A, the before-and-after table for city participant businesses" | "Annual waste management cost of the same 4,794 participant businesses: mean before GreenWaste and change 12 months after (AED)" |
| H2-A | "H2-A, the city data tables and charts" | H2-A1: "Four selected businesses: efficiency score, whether the business took part, and annual waste management cost before and 12 months after (AED)". H2-A2: "Mean annual waste management cost before and 12 months after GreenWaste, for participant businesses and comparison businesses (AED)". H2-A3: "Histogram of the change in annual waste management cost for the 4,794 participant businesses (AED)". Baseline chart: "Histogram of annual waste management cost before GreenWaste for all 10,000 city businesses (AED)". |
| H3-A | "H3-A, the pilot lottery study summary" | "Annual waste management cost 12 months after GreenWaste: treatment group (200 businesses) compared with control group (200 businesses) (AED)" |
| H4-A | "H4-A, the difference-in-differences study summary" | "Difference-in-differences regression: annual waste management cost of 10,000 city businesses, before and 12 months after GreenWaste, for participant businesses and comparison businesses (AED)". Charts: "Observed mean costs and the assumed path for participant businesses without GreenWaste"; "Two hypothetical earlier cost histories, A and B". |
| H5-A (when built) | "H5-A, the regression discontinuity study summary" | To be written with the preview. |
| H6-A | "H6-A, the matching study summary" | Table R: "Difference in annual waste management cost 12 months after GreenWaste between participant businesses and their matched comparison businesses, with and without manager age used for matching (AED)". Table B: "Average characteristics of participant businesses, all other businesses and matched comparison businesses before GreenWaste". |
| H7-A | "H7-A, the cost-benefit model note" | Table I: "Inputs to the cost-benefit model: annual saving, delivery cost, year savings start, number of years and discount rate". Table P: "Which costs and benefits the model includes, for the authority and for businesses". Table F: "Delivery cost and annual saving per participant business in each year, with each saving converted to its value today (AED)". Table O: "Results per participant business: present value of savings, included cost, benefit-cost ratio and net present value (AED)". Table S: "Benefit-cost ratio for each of the five scenario cards". |
| H8-A | "H8-A, the bar charts and distributions" | Figure C: "Two bar charts of the same data: mean annual waste management cost of the 4,794 participant businesses before GreenWaste and 12 months after, one with the vertical axis starting at zero and one starting at 700 AED". Table C: "The values behind Figure C (AED)". Figure D: "Histogram of annual waste management cost before GreenWaste for the 4,794 participant businesses (AED)". Figure E: "Dot plot of landfill waste before GreenWaste for ten selected businesses (tonnes per business per year)". Figure P: "Estimated reduction in annual waste management cost in the pilot, with its 95% interval, compared with our rule of at least a 1,000 AED reduction". |

Exact numbers and wording to be checked against each table when the titles are applied.

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
- "This supplied extract is the source, not a separately distributed report" / "there is no separate report to find" (D1S3, D2S1, D2S3, D3S1, D3S2). Delete these sentences. Participants only need: "Use this study summary as your source for today's questions." (Fiona, 9 Oct: lines that only describe how the material was produced do not belong on participant pages.)

**Instructions addressed to the trainer on pages participants hold**
- D2S3 cards: "Trainer: cut along dashed borders. Distribute page 1 only; retain page 2 until pairs are recorded."
- D3S1 cards: "For eight groups print Cards 1, 2 and 3 twice: allocation 1, 2, 3, 4, 5, 1, 2, 3. Retain page 7 until predictions are recorded."
- D3S1 worksheet: "Table S (cards page 7) is held by the trainer until predictions are recorded."
- "After the trainer distributes cost slips" (D2S3 Q1), "Table S ... distributed after predictions".
- Slide titles: "The trainer computes the paired difference" (D2S3), "The trainer runs the model arithmetic" (D3S1), "The trainer checks the two denominators" (D3S2). Reword as "We [do the task] in R" (Fiona, 9 Oct), e.g. "We calculate the paired difference in R."
- Slide text boxes: "How the trainer obtains the two means" (D1S2 p05), "The trainer compares mean cost changes" (D2S1 p04). Relabel as "We calculate the two means in R" / "We compare the mean changes in R", with the code box labelled "R code". The R code boxes stay visible (section 6, item 4).
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

Updated 9 Oct with the decisions in section 3A. Rule used: every title is a complete sentence or question. Titles about R code use the same form: "We [do the task] in R." (Fiona, 9 Oct), and the code box on the slide is labelled "R code", not "trainer". "Term: question" titles on the five Day 1 S1 terms are kept because each already contains a full question. "The trainer ..." titles become "R ..." or an instruction. Titles marked "keep" are already full sentences or questions. "Pending" means Fiona has not yet reviewed the row.

**Day 1 Session 1** (status: pending)

| Slide | Current | Proposed |
|---|---|---|
| Subtitle | Read a cost result using five terms | Read an evaluation result using five terms |
| 1 | The GreenWaste case study | keep (Fiona) |
| 2 | Where does GreenWaste fit? | keep |
| 3 | A cost result lands on your desk | An impressive result lands on your desk. (Fiona's edit) |
| 4 | Mean: who looks like the average? | keep (term: question) |
| 5 | One large business changes the average | keep |
| 6 | Treatment effect: what did GreenWaste cause? | keep |
| 7 | Coefficient: which row is the change? | keep |
| 8 | What does the minus sign mean? | keep |
| 9 | Confidence interval: how sure are we? | keep |
| 10 | Same estimate. Different uncertainty. | Three estimates are identical. Is the uncertainty the same? |
| 11 | P-value: what does small tell us? | What does a small p-value tell us? |
| 12 | Statistically clear. Large enough to matter? | A result can be statistically significant, but is it large enough to matter? (Fiona's wording; "significant" replaces "clear". Confirm the slide body and notes also say "statistically significant".) |
| 13 | A lower cost. Enough saving? | Costs fell by 669 AED. Is that at least a 1,000 AED reduction? |
| 14 | Pair check: what does the table support? | keep |
| 15 | A plausible AI reading of the table | An AI explains the table. Which parts does the table support? |
| 16 | Ask for a reading you can verify | Ask the AI for an explanation you can check. |
| 17 | What would you tell the director? | keep |

**Day 1 Session 2** (status: pending)

| Slide | Current | Proposed |
|---|---|---|
| Title | Good news. Enough to act? | We receive good news. Is it enough to act on? |
| Subtitle | ...the comparison behind a cost claim | ...the comparison behind a claim about GreenWaste |
| 1 | We read -669. Was it the programme's effect? | We read that the mean annual waste cost fell by 669 AED. Was that fall the programme's effect? |
| 2 | One row. One business. Two measurements. | Each row shows one business, measured twice. |
| 3 | Who is included in these averages? | keep |
| 4 | What do costs look like before the programme? | What do waste costs look like before the programme? |
| 5 | Participants: what changed after GreenWaste? | Participant businesses: what changed after GreenWaste? |
| 6 | Did every business's cost fall? | Did the cost fall for every business? |
| 7 | What else could have changed costs? | keep |
| 8 | Other city businesses: what changed? | Comparison businesses: what happened to their costs? |
| 9 | Lower than without. Already lower before. | Participant businesses ended with lower costs. Were their costs already lower than the comparison businesses' costs before? |
| 10 | Two numbers. Two weak comparisons. | Each number compares something different. Why is neither enough on its own? |
| 11 | Four cost claims. Which would you act on? | Here are four statements about GreenWaste. Which would you act on? |
| 12 | Which evidence supports your choice? | keep |
| 13 | Would you accept this AI chart reading? | Would you accept this AI explanation of the chart? |
| 14 | Ask for a comparison-aware explanation | Ask the AI to name the comparison it is using. |
| 15 | What comparison would you ask for next? | keep |

**Day 1 Session 3** (status: pending)

| Slide | Current | Proposed |
|---|---|---|
| 1 | Two city comparisons. Why a lottery? | We have two city comparisons. Why would a lottery be better? |
| 2 | The pilot district: 400 businesses, 200 places | The pilot had 400 eligible businesses but only 200 places in the programme. ("Places" means programme places: 200 of the 400 businesses receive GreenWaste, the treatment group, and 200 do not, the control group. A lottery decides which.) |
| 3 | What the lottery buys us | What does a lottery give us? |
| 4 | Draw the lottery, then draw again | Draw the lottery, then draw it again. |
| 5 | Small lotteries can look different | keep |
| 6 | Were groups similar before GreenWaste? | Were the treatment and control groups similar before GreenWaste? |
| 7 | The result is a difference of two averages | The result is the difference between two averages. |
| 8 | The regression reports that same comparison | The regression table reports the same comparison. |
| 9 | Does the interval clear our rule? | Is the whole interval at or above our rule of a 1,000 AED reduction? |
| 10 | Who does this pilot describe? | keep |
| 11 | Three numbers. Three comparisons. | Each of the three numbers compares different groups. |
| 12 | Would you extend it now? | Would you extend GreenWaste now? |
| 13 | Your recommendation in three sentences | Write your recommendation in three sentences. |
| 14 | A plausible AI paragraph for the minister | An AI writes a paragraph for the minister. Which claims does the pilot support? |
| 15 | Ask for a recommendation the trial supports | Ask the AI for a recommendation the pilot supports. |
| 16 | Which evidence could change your decision? | keep |

**Day 2 Session 1** (status: pending)

| Slide | Current | Proposed |
|---|---|---|
| Subtitle | Difference-in-differences, the extra change and its assumption | Difference-in-differences: the difference between the two changes, and its assumption |
| 1 | Yesterday's saving. Today's question. | Yesterday we found a saving from a lottery. Today we use another method and ask what else changed. (Fiona. Slide notes: "Today we use another method, with a different group of businesses that were not chosen at random, and ask what else changed.") |
| 2 | Both groups changed. What was extra? | Costs changed in both groups. How much more did participant businesses' costs fall? |
| 3 | Four numbers. What is the extra change? | Use four numbers to find the difference in differences. (Fiona. Then define it in the body: the difference between the two changes.) |
| 4 | The same calculation, using all the records | We repeat the same calculation in R using all the records. |
| 5 | Where is the extra change in this table? | Which row of the table shows the difference between the two changes? |
| 6 | The dashed line is an assumption | keep |
| 7 | Same city. Different changes without GreenWaste? | Could the two groups have changed differently even without GreenWaste? |
| 8 | Which earlier history would make you hesitate? | keep |
| 9 | Can one before measure show a trend? | Can one measurement before the programme show a trend? |
| 10 | A precise result. Enough to meet the rule? | The estimate is precise. Does it meet our rule of at least a 1,000 AED reduction? |
| 11 | What does the source support? | What does the study summary support? |
| 12 | The AI says cause. Does the comparison? | The AI says GreenWaste caused the change. Does the comparison support that? |
| 13 | Ask for an explanation you can verify | Ask the AI for an explanation you can check. |
| 14 | What would you ask for next? | keep |

**Day 2 Session 3** (status: pending)

| Slide | Current | Proposed |
|---|---|---|
| 1 | Which comparison would you trust? | keep |
| 2 | Similar on what we can see | How can we find businesses that look similar? |
| 3 | Find the closest recorded comparisons | Find the closest comparison business for each participant business. |
| 4 | Open the costs, not a new pairing | Reveal each business's cost, and keep your pairs unchanged. |
| 5 | From seven cards to the full city | How does matching work for the full city? |
| 6 | One comparison business can be reused | keep |
| 7 | What changed in measured balance? | Did matching make the groups more alike on what we measured? |
| 8 | Closest available may still be too far | The closest available business may still be too different. |
| 9 | Read the full-city difference | Read the difference for the full city. |
| 10 | The trainer computes the paired difference | We calculate the paired difference in R. |
| 11 | Leave age out. Change the comparison. | What happens when manager age is left out of the matching? |
| 12 | What if motivation is not recorded? | keep |
| 13 | Read the source before trusting the summary | Read the study summary before trusting the headline. |
| 14 | Above the rule. Certain enough? | The estimate is above 1,000 AED. Is the whole interval? |
| 15 | AI Snapshot: what should a commissioner flag? | keep |
| 16 | Ask Copilot for a reading you can verify | Ask Copilot for an explanation you can check. |
| 17 | Close the source. Make a defensible request. | Close the study summary. Make a request you can defend. |

**Day 3 Session 1** (status: pending)

| Slide | Current | Proposed |
|---|---|---|
| 1 | A saving is only half the question | keep |
| 2 | A ratio of 1.86. Approve? | The benefit-cost ratio is 1.86. Should we approve GreenWaste? |
| 3 | What went into the number? | keep |
| 4 | When do the costs and savings happen? | When do the programme costs and the savings happen? |
| 5 | A later saving is worth less today | keep |
| 6 | From five future savings to today's total | How do five future savings become one total in today's value? |
| 7 | Ratio and net present value answer different questions | keep (spell out "net present value (NPV)" in the body) |
| 8 | The trainer runs the model arithmetic | We run the model arithmetic in R. |
| 9 | Whose costs and benefits are counted? | keep |
| 10 | Change an assumption. Predict before the reveal. | Change one assumption. Predict the ratio before the results are shown. |
| 11 | Where do the five scenarios land? | What ratio does each of the five scenarios give? |
| 12 | Which change matters, over which range? | Which assumption matters most, and over what range? |
| 13 | Read the model note, not just the headline | Read the model note, not just the headline ratio. |
| 14 | AI Snapshot: find a scenario that breaks it | AI Snapshot: can the AI find a scenario that pushes the ratio below 1? |
| 15 | Ask Copilot to identify and quantify assumptions | keep |
| 16 | Close the source. Make a conditional recommendation. | Close the model note. Make a recommendation with a condition. |

**Day 3 Session 2** (status: pending)

| Slide | Current | Proposed |
|---|---|---|
| 1 | Which picture would you show the director? | Which chart would you show the director? |
| 2 | Change the axis, not the values | Changing the axis changes the picture but not the values. |
| 3 | Read the source under the bars | Check the table of values behind the bars. |
| 4 | A supported description is not a causal verdict | A description the data support is not proof that GreenWaste caused the fall. |
| 5 | How much does the mean hide? | keep |
| 6 | One large record can pull the mean | keep |
| 7 | Two businesses. Two percentage questions. | Two businesses give two different percentage answers. |
| 8 | Why 44% and 60% both answer real questions | Why are 44% and 60% both correct answers? |
| 9 | Same city participants. Two valid summaries. | The same participant businesses give two valid summaries. |
| 10 | The trainer checks the two denominators | We check in R which total each percentage uses. |
| 11 | Write the caption the chart deserves | Write a caption that fits what the chart shows. |
| 12 | Spread between businesses is not this interval | Variation between businesses is different from this confidence interval. |
| 13 | AI Snapshot: which chart is fairer? | keep |
| 14 | Ask Copilot about the claim and its audience | keep |
| 15 | Defend the chart. Defend its limit. | Defend your chart choice and state its limit. |
| 16 | Before trusting a chart, check what? | What should you check before trusting a chart? |

Also: in every title where "source" means the study summary, name it ("the study summary", "the model note"), per `REVIEW_NOTES.md` item 14.

### B. Worksheet questions and instructions

Reviewed session by session with Fiona, using the decisions in section 3A. Each session below is marked pending or approved. The older example table further down is superseded session by session as each one is approved.

**B1. Day 1 Session 1 worksheet** (status: pending Fiona's review)

| Item | Proposed text |
|---|---|
| Title and banner | Title: "GreenWaste: reading an evaluation result". Remove "Separate Session 1 review worksheet. The current published handout is unchanged." and "All pages below belong to the separate review version." |
| Page 1 heading | "Page 1: The before-and-after table" |
| Page 1 intro | "GreenWaste subsidises waste equipment and provides installation help and staff training. In the pilot district, a lottery chose which businesses took part. In the rest of the city, businesses with an efficiency score of 58 or below took part. In this session we read results about each business's annual waste management cost, in AED. GreenWaste is a fictional training case." |
| H1-A heading and text | "H1-A: The before-and-after table for city participant businesses. The same 4,794 participant businesses were measured before GreenWaste and 12 months after. This table does not include any comparison businesses that did not receive GreenWaste. Our rule is a reduction in annual waste management cost of at least 1,000 AED per business per year. Meeting this rule does not by itself show that GreenWaste is good value for money." |
| H1-A table title | "Annual waste management cost of the same 4,794 participant businesses: mean before GreenWaste and change 12 months after (AED)". Rows: "Mean cost before GreenWaste (intercept)" and "Change after GreenWaste: after minus before". Columns: "Coefficient (AED)", "95% interval (AED)", "p-value". |
| H1-A caption and model note | "The table shows annual waste management cost in AED for the same participant businesses before and 12 months after GreenWaste. This comparison alone does not show the effect of the programme. Each of the 4,794 businesses is measured twice. The model is: cost = intercept + coefficient x after, where after is 0 before GreenWaste and 1 twelve months after. The intervals allow for each business being measured twice." |
| Q1 intro | "These ten businesses were selected from the GreenWaste data. The dot plot shows their annual waste management cost before GreenWaste, in AED. They are not representative of all city businesses." |
| Q1 tasks | "(a) Calculate the mean annual waste management cost of the ten businesses. (b) Calculate the mean and the median again after removing the business with the largest cost (4,306 AED). (c) Which changes more, the mean or the median, and why?" |
| Q2 | "The costs of the participant businesses fell after GreenWaste. (a) Does this tell us what would have happened to these businesses without GreenWaste? (b) Explain what information is missing. This missing information is called the counterfactual." |
| Q3 | "Use H1-A. (a) Mark the row that shows the change in cost. (b) Write its value, its units, what it compares, and whether it is positive or negative. (c) Use both rows of the table to work out the mean annual waste management cost 12 months after GreenWaste." |
| Page 2 intro | "Page 2: Uncertainty and your own interpretation. Keep page 1 open, because you need H1-A. Answer each question when we reach that idea in the session." |
| Q4 | "(a) Draw a box around the 95% interval in the change row of H1-A. (b) What does this interval describe? (c) Does it show how much each individual business saved? Explain. Now compare three invented estimates of the annual reduction in cost. Each estimate is 1,100 AED. Their 95% intervals are A: 1,080 to 1,120 AED, B: 900 to 1,300 AED, and C: 400 to 1,800 AED. (d) Which interval is entirely above our rule of a reduction of at least 1,000 AED? (e) What is still uncertain for B and C?" |
| Q5 | "(a) Find the p-value in the change row of H1-A. (b) What does the p-value assume about the change? (c) Does the p-value show that GreenWaste caused the fall, or the probability that the programme works? Explain. Now compare two invented results. Result A is a reduction of 50 AED (interval 30 to 70 AED, p < 0.001). Result B is a reduction of 1,100 AED (interval -100 to 2,300 AED, p = 0.072). (d) Which result is statistically significant? (e) Which result could be large enough to matter for our rule? (f) Does Result B prove that there is no reduction? Explain." |
| Q6 | "(a) Compare your answers to Q1 to Q5 with a partner. Correct one explanation if it needs it. (b) Explain what the estimate and the interval in H1-A show, and compare them with our rule of a reduction of at least 1,000 AED per business per year. (c) Explain why this table cannot show that GreenWaste caused the change." |
| Your own reading | "Close the AI responses and your notes on the terms, and keep H1-A open. Write three sentences. (1) What the table shows, with the units and the period. (2) What the table cannot show. (3) One piece of evidence you would ask for, and why." |
| Page 3 Part A | "Part A: Mark the response. Naive prompt (a prompt with no context, as a busy person might type it): 'Explain H1-A and advise whether to expand GreenWaste.' This response was written for the exercise. It is not a real AI answer. Underline the claims that H1-A supports. Cross out the claims that H1-A does not support." |
| Page 3 Part B | "Part B: Run the improved prompt, then compare. Copy the prompt and the H1-A table into Microsoft Copilot, and keep your AI good-practice card beside you. If you are not using Copilot, read the prepared response on page 4 after you finish Part A. (a) Which question that the AI asked helped you most? (b) What improved compared with the response in Part A? (c) Which claim still needs checking against H1-A?" |
| Improved prompt text | Unchanged, apart from the agreed terms ("participant businesses", "comparison businesses", and the full 1,000 AED rule wording). |
| Page 4 | "Page 4: Prepared response. Use this response if you are not using Copilot. Read it after you have marked the response on page 3. It is an example of a better answer. An AI tool may answer differently. (a) Which sentences does H1-A support? (b) What additional evidence would answer the clarifying questions at the start of the response?" |
| Source records | "Records used in Q1. These ten participant businesses were selected from the GreenWaste data for teaching. They are not representative of all participant businesses. Values are annual waste management cost before GreenWaste, in AED." Remove "Values come from cost_before". |

**B1 status:** approved by Fiona, 9 Oct.

**B2. Day 1 Session 2 worksheet and decision cards** (status: pending Fiona's review)

| Item | Proposed text |
|---|---|
| Title and banner | "GreenWaste: comparing groups". Remove "Separate Session 2 review worksheet." |
| Page 1 intro | "GreenWaste offers equipment subsidies, installation help and staff training. All costs are annual waste management cost, in AED per business, measured before GreenWaste and 12 months after. GreenWaste is a fictional training case." Heading: "H2-A: The city data tables and charts". |
| H2-A1 | Title: "Four selected businesses: efficiency score, whether the business took part, and annual waste management cost before and 12 months after (AED)". Note: "These four businesses were selected from the GreenWaste data for reading practice. They are not representative of all city businesses. Businesses with a score of 58 or below took part in GreenWaste, and businesses with a score above 58 did not. The pilot lottery uses a different set of businesses." |
| H2-A2 | Title: "Mean annual waste management cost before and 12 months after GreenWaste, for participant businesses and comparison businesses (AED)". Group labels: "Participant businesses (took part)" and "Comparison businesses (did not take part)". Note: "Each mean uses all the businesses in that group. Figures are rounded. A lottery did not decide which businesses took part, and the two groups had different costs before GreenWaste." |
| Two comparisons (under H2-A2) | "Before and after: for the same participant businesses, the mean cost after minus the mean cost before is -669 AED. With and without: after the programme, the participant businesses' mean cost minus the comparison businesses' mean cost is -1,638 AED. Neither comparison alone shows how much of the fall GreenWaste caused. Our rule is a reduction in annual waste management cost of at least 1,000 AED per business per year, caused by the programme." |
| Source key | "Source: GreenWaste city data (10,000 businesses). Decision cards 2 and 3 use a before-and-after regression for the same 4,794 participant businesses, measured twice. It shows a change of -669 AED, with a 95% interval of -684 to -654 AED and p < 0.001. The interval describes the mean change. It does not describe individual businesses, and it does not show the effect of the programme." Remove "corrected", the file name and "zero-mean-change null". |
| Page 2 opening judgement | "The mean annual waste management cost of participant businesses fell by 669 AED. Does this tell us the effect of the programme? Write one reason. We will come back to it at the end of the session." |
| Q1 | "Use H2-A1 on page 1. (a) Write one sentence about business B00402. Say whether it took part, what its cost was before and after, and over what period. (b) Which group of businesses does the participant average describe, and how many businesses are in it?" |
| Baseline histogram | Title: "Histogram of annual waste management cost before GreenWaste for all 10,000 city businesses (AED, in bands of 250 AED). The mean and median are marked." Remove "after the slide discussion". |
| Q2 | "(a) Write one description of the histogram that the data support. (b) Write one thing that the mean alone cannot tell you." |
| Page 3 histogram | Title: "Histogram of the change in annual waste management cost for the 4,794 participant businesses (AED). Each business's change is its cost after minus its cost before. The histogram shows the changes that were recorded. It is not a confidence interval, and it does not show the effect of GreenWaste on each business." |
| Q3 | "(a) Use H2-A2 on page 1. Calculate the change in mean cost for participant businesses, and write what it shows, with units and period. (b) Use the histogram. Did the cost fall for every business? (c) Suppose waste-service prices changed during the year. This is a hypothetical example, not a fact about the case. What evidence would help separate a price change from the effect of GreenWaste?" |
| Q4 | "(a) Calculate the change in mean cost for comparison businesses. (b) Calculate the difference between the mean cost of participant businesses and of comparison businesses after the programme. (c) Explain why we cannot give GreenWaste the credit for the whole difference." |
| Two-comparison summary table | Rows: "Before and after: -669 AED. Compares the same participant businesses, cost after minus cost before. Missing: their cost after a year without GreenWaste is not known." and "With and without: -1,638 AED. Compares participant businesses with comparison businesses, after a year. Missing: we do not know whether these two groups are a fair comparison." Below: "Before GreenWaste, the mean cost was 1,432 AED for participant businesses and 2,258 AED for comparison businesses. Different recorded changes do not by themselves prove that GreenWaste caused a change, or show which way any bias goes." |
| Page 4, Q5 | "Q5: Four decision cards. Use the cards and H2-A. For each card: (a) choose Act, Ask first or Do not act; (b) write what the source supports; (c) write one question you would ask and why the answer matters; (d) say which action you mean." |
| Closing box | "Close the AI responses and turn over the decision cards, and keep H2-A2 open. (a) Write one conclusion that the data support. (b) Write one specific piece of evidence you would request to help decide whether to expand GreenWaste. (c) Compare this with the reason you wrote on page 2. What changed?" |
| Page 5 Part A | "Part A: Mark the response. Naive prompt (a prompt with no context, as a busy person might type it): 'Explain H2-A2 and advise whether to expand GreenWaste.' This response was written for the exercise. It is not a real AI answer. Underline the passages that H2-A2 supports. Cross out the claims that H2-A2 does not support." The planted response is updated to the agreed terms (Fiona, 9 Oct): "The chart shows a strong improvement: participant businesses' average annual waste cost fell from 1,432 to 763 AED, while costs for comparison businesses rose from 2,258 to 2,401 AED. The participant reduction of 669 AED is therefore unlikely to be just a city-wide fall in waste costs. After a year, participant businesses paid 1,638 AED less than comparison businesses. This is the saving attributable to GreenWaste, because the comparison businesses show what would have happened without it. It exceeds the authority's 1,000 AED annual saving rule. The two groups began at different cost levels, so caution is appropriate. However, the chart's diverging lines confirm that the programme worked across participant businesses. A wider rollout should deliver similar savings, with monitoring to check delivery quality." The planted errors are unchanged. |
| Page 5 Part B | "Part B: Run the improved prompt, then compare. Copy the prompt below and H2-A2 into Microsoft Copilot, and keep your AI good-practice card beside you. If you are not using Copilot, read the prepared response on page 6 after you finish Part A. (a) What improved compared with Part A? (b) Which claims are still unsupported? (c) Which table or figure should you check each claim against?" |
| Page 6 | "Prepared response. Use this response if you are not using Copilot. Read it after you have marked the response on page 5. It is an example of a better answer. An AI tool may answer differently. Check it against H2-A2, as you would check a live AI answer. (a) Does it separate what was observed, what a fair comparison would need, and what decision to make? (b) Which clarifying question in the response is most helpful? (c) What evidence is still needed before advising on expansion?" |
| Decision cards: title and intro | Title: "Four statements about GreenWaste: decide what is missing". Intro: "Read each statement about GreenWaste and decide whether to act on it." Remove "Separate review cards and a local interactive triage board." Move "Print blank copies for group use" and "Choices remain in this browser page. For group or room use ... use printed cards or the existing A1 board" to the trainer print sheet. |
| Card wording | Question on each card: "What would you do with this statement?" "Source supplied:" becomes "Source:". Card 1 keeps its wording: "Annual waste costs among GreenWaste participants fell by 669 AED per business in a year." (Fiona). Card 3 source: "The city before-and-after model, which tests whether the mean change among participant businesses is zero." Card 4 source: "H2-A2, the mean change in each of the two groups. This card gives no interval for the difference between the groups." Cards 2 and 3 statements stay as written. Keep the labels Act / Ask first / Do not act and Compared to what? How big? How sure? |
| Card instructions | "Place each card under Act, Ask first or Do not act. Explain your reason, using words and card numbers. More than one missing question can be a good answer. Say which action you mean: acting on a descriptive finding does not have to mean expanding the programme." Footer: "GreenWaste is a fictional training case. These statements are exercise material for you to check. Do not accept them as conclusions." |

**B2 status:** approved by Fiona, 9 Oct (planted AI response updated to the agreed terms; decision card 1 keeps "GreenWaste participants").

**B3. Day 1 Session 3 worksheet and age slips** (status: approved 9 Oct). Terms: "trial" becomes "pilot"; "join/wait" becomes "treatment/control".

| Item | Proposed text |
|---|---|
| Title and banner | Title: "GreenWaste pilot: evidence and recommendation". Remove "Separate Session 3 review worksheet." |
| Page 1 heading and intro | "H3-A: The pilot lottery study summary (design and starting costs). GreenWaste is a fictional training case. Use this study summary as your source for today's questions." |
| §1 Who and what? | "GreenWaste offers equipment subsidies, installation help and staff training. The pilot covered 400 eligible businesses in one district. All of them had efficiency scores of 58 or below. The outcome is annual waste management cost in AED per business, measured before GreenWaste and 12 months after." |
| §2 How were places given out? | "The programme had 200 places for the 400 eligible businesses. A lottery assigned individual businesses: 200 to the treatment group, which received GreenWaste, and 200 to the control group, which did not receive GreenWaste during the study. Random assignment within this pilot is not the same as choosing a sample that represents the whole country." |
| §3 What must be true for the comparison to be reliable? | "In this fictional pilot, every business took part according to its assignment, and all 400 businesses have cost records 12 months later. A causal reading of the result depends on three conditions: the lottery was carried out as described, costs were measured in the same way in both groups, and the programme did not affect the control group's costs. A real report should document these conditions." |
| §4 Before the programme | "These are the two groups as assigned, 200 businesses each. Before GreenWaste, the mean annual waste management cost was 1,390 AED in the treatment group and 1,411 AED in the control group. The distributions were similar but not identical. Similar starting costs support the comparison. They do not prove that the lottery was carried out correctly or that the groups are balanced on everything." |
| Source line | "Source: GreenWaste pilot data (400 businesses). The age-slip lottery in Q1 is a practice activity. It is not the allocation used in this pilot." Remove "corrected", the file name, the R script name and "the shared pilot model". |
| Page 2 §5 | "Twelve months after GreenWaste, the treatment group's mean annual waste management cost was 769 AED and the control group's was 1,783 AED. The treatment group minus the control group is -1,014 AED. If the three conditions in §3 hold, this is an estimate of the effect of GreenWaste on the eligible pilot businesses." |
| Results table | Title: "Annual waste management cost 12 months after GreenWaste: treatment group (200 businesses) compared with control group (200 businesses) (AED)". Rows: "Control group: mean cost after 12 months" and "Treatment group minus control group". Columns: "Coefficient (AED)", "95% interval (AED)", "p-value". |
| Table note | "The pilot has 400 businesses, 200 in each group, with annual waste management cost measured 12 months after GreenWaste. The model compares the two group means (ordinary least squares). The control group is the reference, so the first row is the control group's mean cost. The second row is the difference between the treatment group and the control group. It is not the treatment group's own mean. A negative difference in cost means a reduction in cost, which is a saving." |
| Rule box | Heading: "The same result as a reduction in cost". Text: "Our rule is a reduction in annual waste management cost of at least 1,000 AED per business per year. The estimated reduction is 1,014 AED. The 95% interval is 862 to 1,167 AED, so it includes values below 1,000 AED. The interval shows uncertainty about the mean effect if the model's assumptions hold. It does not show the savings of individual businesses." |
| Three comparisons table | Heading: "Three comparisons from three groups of businesses". Rows: "City participant businesses: the same businesses, after minus before: -669"; "City participant and comparison businesses: participant minus comparison businesses, after the programme: -1,638"; "Eligible pilot businesses: treatment group minus control group, after 12 months: -1,014 (95% interval: -1,167 to -862)". Note: "The pilot result does not automatically apply to the city, because the city's businesses are different. One district does not show effects for the whole country. This study summary does not give the full programme costs, so these results alone cannot settle whether GreenWaste is good value for money." |
| Page 3, Q1 | "Read §1 to §3 of H3-A on page 1. Why does the control group give a more reliable comparison than businesses that chose whether to join?" |
| Practice lottery | "Practice lottery: 20 age slips and 10 places. Draw ten slips for the treatment group. The other ten slips are the control group. Calculate the mean manager age of each group. Put all the slips back and draw again. The slips show manager ages before the programme, not effects on cost. The pilot itself has 400 businesses, not 20." Table headings: "Treatment mean age", "Control mean age", "Treatment minus control". Questions: "(a) What changed between the two draws? (b) Would larger groups usually have mean ages closer to each other? (c) Use the starting costs in §4 on page 1. What reassurance do they give, and what do they not prove?" |
| Q2 | "Use §5 and the table on page 2. (a) Calculate the treatment group's mean cost minus the control group's mean cost, 12 months after GreenWaste. (b) Explain what the sign, the units, the comparison and the group of businesses tell you. (c) Circle the row of the table that shows the comparison. (d) Explain what the control group row shows. (e) Use both rows to work out the treatment group's mean cost." |
| Page 4, Q3 | "Use the interval on page 2. (a) What in the table suggests that GreenWaste reduces costs? (b) What is still uncertain about whether the reduction is at least 1,000 AED?" |
| Q4 | "Use §1 to §3 and the final paragraph on page 2. (a) Which businesses does the pilot describe? (b) What evidence would you request before expanding GreenWaste to other businesses? (c) Say why that evidence matters." |
| Q5 | "(a) Choose Extend, Do not extend or Ask first. (b) Write one strength of the pilot design. (c) Write one limit that matters for the decision. (d) Write one condition that fits the size of the decision. (e) Say which businesses your action covers." |
| Three-sentence recommendation | "Write your recommendation in three sentences. (1) What the pilot found and which table shows it. (2) What you recommend, or the condition you set. (3) The most important limit and the evidence you would request. Then swap with a partner and check each other's sentences. Does each sentence name the comparison and the businesses? Does it give units and period? Does it compare the interval with our rule of at least a 1,000 AED reduction? Does it say how far the result reaches? Does it name a specific evidence request? Mark one claim that needs more support." |
| Final box | "Your final recommendation and evidence request. Keep H3-A open, and close the AI responses and your partner's comments. Revise your recommendation on your own. What answer to your evidence request could change your advice, and how?" |
| Page 5 Part A | "Part A: Mark the response. Naive prompt (a prompt with no context, as a busy person might type it): 'Our GreenWaste pilot saved 1,014 AED per business (p < 0.001). Write a short paragraph for the minister recommending expansion.' This response was written for the exercise. It is not a real AI answer. Underline the claims that H3-A supports. Cross out the claims that H3-A does not support. Check H3-A on pages 1 and 2." Planted response: only change "the programme group averaged 769 AED compared with 1,783 AED in the waiting group" to "the treatment group averaged 769 AED compared with 1,783 AED in the control group". Errors unchanged. |
| Page 5 Part B | "Part B: Run the improved prompt, then compare. Copy the prompt and H3-A into Microsoft Copilot, and keep your AI good-practice card beside you. If you are not using Copilot, read the prepared response on page 6 after you finish Part A. (a) What improved compared with your own note? (b) Which claim still needs checking against H3-A?" Improved prompt: "individually assigned 200 to join and 200 to wait" becomes "individually assigned, 200 to the treatment group and 200 to the control group"; "Our fictional minimum is 1,000 AED annual saving" becomes "Our rule is a reduction in annual waste management cost of at least 1,000 AED per business per year"; "Distinguish evidence of some saving from certainty about the minimum" becomes "Separate evidence of some reduction from certainty that the reduction is at least 1,000 AED". |
| Page 6 | "Prepared response. Use this response if you are not using Copilot. Read it after you have marked the response on page 5. It is an example of a better answer. An AI tool may answer differently." In the response, "the group assigned to join than in the waiting group" becomes "the treatment group than in the control group". Questions: "(a) Which clarifying question in the response helps most? (b) Does the advice separate some reduction in cost, our 1,000 AED rule, wider reach and full programme costs? (c) Which claim would you check or strengthen before sharing this advice?" |
| Age slips | "A practice lottery: 20 manager-age slips. There are 20 businesses and 10 places. Cut out the slips along the dashed lines (one set per group). Draw ten slips for the treatment group. The other ten slips are the control group. Calculate each group's mean manager age. Put all the slips back before you draw again." Footer: "The slips use manager ages from 20 businesses in the GreenWaste pilot data. A draw compares ages before the programme, not effects on cost. It is not the lottery used in the pilot, which involved 400 businesses and 200 places. Record both draws on worksheet page 3. GreenWaste is a fictional training case. Ages are in years." Remove "Source: corrected pilot data." |

**B4. Day 2 Session 1 worksheet** (status: approved 9 Oct; figure caption note about the programme-start marker cut). Terms: "participant businesses" and "comparison businesses that did not receive GreenWaste"; "difference between the two changes (difference-in-differences, DiD)"; "study summary".

| Item | Proposed text |
|---|---|
| Title and banner | Title: "GreenWaste city: what was the difference between the two changes?" Remove "Separate Day 2 Session 1 review worksheet." |
| Page 1 heading and intro | "H4-A: The city difference-in-differences (DiD) study summary. GreenWaste is a fictional training case. Use this study summary as your source for today's questions." |
| §1 Who, what and when? | "GreenWaste provides equipment subsidies, installation help and staff training. The city study follows 10,000 businesses: 4,794 participant businesses and 5,206 comparison businesses that did not receive GreenWaste. Eligibility followed an efficiency-score rule, not a lottery. Annual waste management cost per business, in AED, was recorded once before GreenWaste and once 12 months after. These are city records. They are not the separate pilot of 400 businesses." |
| §2 What was compared? | "The participant businesses' mean cost went from 1,432 to 763 AED, a change of -669 AED. The comparison businesses' mean cost went from 2,258 to 2,401 AED, a change of +143 AED. The difference-in-differences (DiD) estimate is the participants' change minus the comparison businesses' change, which is about -812 AED. The calculations use unrounded records. This is the difference between the two changes. It is not the participant businesses' own change, and it is not the gap between the two groups after the programme." |
| Table title | "Annual waste management cost in the city study: change in participant businesses compared with change in comparison businesses (AED)". |
| Table rows | "Comparison businesses, before GreenWaste (intercept)"; "Change in comparison businesses (after)"; "Participant businesses minus comparison businesses, before GreenWaste (took part)"; "Difference between the two changes (after × took part)". Columns: "Coefficient (AED)", "95% interval (AED)", "p-value". |
| Table note | "The table uses 10,000 city businesses with two cost measurements each (before and 12 months after). The model is cost ~ after × took part. The 95% intervals allow for the two measurements on each business (clustered robust standard errors, Stata correction). The reference row is the comparison businesses before the programme. The last row is the difference between the two changes." |
| §3 What is needed for a causal reading? | "The parallel trends assumption means that, without GreenWaste, the two groups would have had the same mean change in cost over this period. They do not need to start at the same cost. Under this assumption, the participant businesses' mean cost after 12 months without GreenWaste would be about 1,575 AED, not the 763 AED we observe. A causal reading also needs comparable measurement, stable group membership and no important effect of the programme on the comparison businesses. A competing change that affected the groups differently could undermine the reading." |
| §4 What can this study summary show? | "One measurement before GreenWaste cannot show earlier trends. The histories A and B on page 2 are hypothetical. They are not additional observations. The 95% interval for the difference between the two changes is a reduction of 792 to 833 AED, if the model's assumptions hold. A precise interval does not verify parallel trends. Both the estimate and the interval are smaller than our rule of at least a 1,000 AED reduction in annual waste management cost per business per year. This table alone does not show effects for the whole country or whether GreenWaste is good value for money, because the full programme costs are not given." |
| Source line | "Source: GreenWaste city data (10,000 businesses, measured before and 12 months after). The regression uses the same businesses at both times and allows for the repeated measurements on each business. The paragraphs and table above are the material to inspect." Remove "corrected", the CSV name and the R script name. |
| Page 2 headings and captions | "H4-A: Figures for reference". "Observed means and an assumed path for participant businesses without GreenWaste". Caption: "Solid lines join the observed means. The dashed line shows the path the participant businesses would have followed under the parallel trends assumption." "Two hypothetical earlier histories, A and B". Caption: "Both histories use the same scales and both end before the programme. Groups can start at different levels and still change by similar amounts. Neither history comes from the GreenWaste data." "The difference between the two changes compared with our rule". Caption: "The interval shows uncertainty about the mean difference between the two changes, if the model's assumptions hold. It does not show the savings of each business, and it does not allow for every possible source of bias." |
| Page 3 heading | "Q1 and Q2: work on these as we teach each idea". |
| Q1 | Title: "Q1 | Four numbers, two changes, one difference between the changes". "Use §2 on page 1. (a) Calculate the change (after minus before) for each group in the table. (b) Subtract the comparison businesses' change from the participant businesses' change. (c) Label the four observed means on the figure and connect each group's two points. After we explain the dashed line, add the assumed participant outcome and label it 'assumed'." Table groups: "Participant businesses", "Comparison businesses"; columns "Before (AED)", "After (AED)", "Change (AED)"; last line "Participant change minus comparison change (AED):". |
| Q2 | Title: "Q2 | Find the difference between the two changes in the regression table". "(a) Circle its row in the table on page 1. (b) Explain in your own words what its sign, its units, the comparison and the group of businesses tell you. (c) What does each of the other three rows show? (d) Why is the last row not the participant businesses' own change of -669 AED?" |
| Page 4 heading | "Q3 and Q4: how credible is the result, and what should we advise?" |
| Q3 | Title: "Q3 | What would have happened without GreenWaste?" "Use §3 and §4 on page 1 and the figures on page 2. (a) Explain the parallel trends assumption for GreenWaste in your own words. The groups do not need to start at the same cost. (b) Which hypothetical history, A or B, makes you hesitate? Describe what looks different. (c) What does the more reassuring history still not prove? (d) Could the GreenWaste data show earlier trends? (e) Request one specific piece of evidence about earlier costs or about a competing change, and say why it matters." |
| Q4 | Title: "Q4 | Some reduction, or a large enough reduction?" "Use the interval on page 2. (a) How do the estimate and the interval compare with our rule of at least a 1,000 AED reduction in annual waste management cost per business per year? (b) What does a narrow interval still leave unresolved?" |
| Box: source check | Heading: "Check the source, then give your own reading". "In H4-A, circle the last row of the table and its interval, underline the assumption and mark the limit of the data. Compare your marks with a partner." |
| Final task | "Keep H4-A open, and close the AI responses and your partner's comments. Write one interpretation that H4-A supports and one specific evidence request. How could the answer change your advice?" |
| Page 5 heading | "AI exercise: check the numbers and the claims" |
| Page 5 Part A | "Naive prompt (a prompt with no context, as a busy person might type it): 'Explain the regression table to a policy adviser considering GreenWaste expansion. Say what they should check.' This response was written for the exercise. It is not a real AI answer. It mixes accurate readings with questionable conclusions. Do not run this prompt yourself." Planted response: keep the preview text, with "participants'" → "participant businesses'" and "other businesses'" → "comparison businesses'", "authority's" → "city authority's". Instruction: "Underline the claims that H4-A supports. Cross out the claims that H4-A does not support. Check H4-A on page 1, not whether the writing sounds confident." |
| Page 5 Part B | Heading: "Part B: Run the improved prompt, then compare". Improved prompt: "Explain H4-A to a policy adviser considering GreenWaste expansion. The outcome is annual waste management cost in AED per business. There are 4,794 participant businesses and 5,206 comparison businesses that did not receive GreenWaste. They were selected by the score rule, not by a lottery. The difference-in-differences estimate is a reduction of 812 AED, with a 95% interval of 792 to 833 AED. The data have one measurement before GreenWaste and one 12 months after, so they cannot show earlier trends. Parallel trends is an assumption, not a reported check. Our rule is a reduction of at least 1,000 AED per business per year. Ask any essential clarifying questions first. Then give three short points: what the comparison and the last row of the table show; what must be credible for a causal reading; and whether the estimate and interval meet the rule. Cite H4-A and request specific missing evidence. Do not invent a test for earlier trends. Do not treat a narrow interval as proof that the result is robust or applies nationwide." Instructions: "Copy this prompt and H4-A into Microsoft Copilot, and keep your AI good-practice card beside you. If you are not using Copilot, read the prepared response on page 6 after you finish Part A. (a) Which claim improved? (b) What still needs checking against H4-A?" |
| Page 6 | Heading: "Prepared response". "Use this response if you are not using Copilot. Read it after you have marked the response on page 5. It was written for the exercise in reply to the improved prompt. It is not additional evidence from the study. An AI tool may answer differently." In the response: "the other-group change of +143 AED" → "the comparison businesses' change of +143 AED"; "per participant" → "per participant business"; "Both the estimate and interval are below the fictional 1,000 AED minimum" → "Both the estimate and the interval are below our rule of at least a 1,000 AED reduction"; "the minimum" → "the rule" and "claiming that the minimum is met" → "claiming that the rule is met". Questions: "(a) Match its numbers to H4-A §2 and the table. (b) Match its conditions and requests for evidence to §3 and §4. (c) Does it separate the comparison, the credibility of the causal reading and the decision rule? (d) Compare it with page 5. Which unsupported claim has been removed? (e) Could any remaining wording be clearer? Now return to page 4 and write your own interpretation and evidence request with the AI responses closed." |

**B5. Day 2 Session 3 worksheet and profile cards / reveal slips** (status: approved 9 Oct). Terms: "participant businesses"; "comparison businesses that did not receive GreenWaste" (not "nonparticipants" or "controls"); "matched comparison businesses"; "reveal slips"; "study summary".

| Item | Proposed text |
|---|---|
| Title and banner | Title: "GreenWaste city: read a matched comparison". Remove "Separate Day 2 Session 3 review worksheet. Use pages 3-4 as concepts are taught." Page 3 and 4 headings carry the timing instead: "Work on these pages as we teach each idea." |
| Page 1 heading and intro | "H6-A: The city matching study summary. GreenWaste is a fictional training case. Use this study summary as your source for today's questions." (The sentence "not a separately distributed report" is deleted.) |
| §1 Who, what and when? | "GreenWaste provides equipment subsidies, installation help and staff training. The city study records 10,000 businesses: 4,794 participant businesses and 5,206 comparison businesses that did not receive GreenWaste. Taking part followed an efficiency-score rule, not random assignment. Annual waste management cost per business, in AED, was measured before GreenWaste and 12 months after. This study is not the pilot lottery, and it is not the analysis of businesses near the score cut-off." |
| §2 How were comparison businesses selected? | "For each participant business, the evaluator selected the one comparison business that was most similar before GreenWaste on four recorded features: manager age, number of staff, premises area and filtration. Each feature was scaled by its standard deviation across all city businesses. The distance between two businesses is the sum of the squared differences on these scaled features. The same comparison business could be selected more than once (matching with replacement). All 4,794 participant businesses were matched to 585 different comparison businesses, and one comparison business was used up to 440 times. There was no maximum acceptable distance (caliper), and no participant business was excluded. Annual waste management cost before GreenWaste was not used for matching." |
| Table R title | "Table R: Annual waste management cost 12 months after GreenWaste: participant businesses minus matched comparison businesses (AED)". Columns: "Comparison", "Difference (AED)", "95% interval (AED)", "Different comparison businesses used". Rows: "Matched on four recorded features" and "Matched without manager age". |
| After Table R | "Table R shows the participant businesses' mean annual cost after GreenWaste minus the matched comparison businesses' mean annual cost. With four recorded features the difference is -1,029 AED, which is a reduction of 1,029 AED. The 95% interval for the reduction is 859 to 1,200 AED. Leaving out manager age changes which comparison businesses are selected. This does not show which estimate is closer to the true effect." |
| §3 What is needed for a causal reading? | "After we account for the recorded features, two things must hold. First, there is no important remaining difference that affects both taking part and costs. Second, there are enough comparison businesses that are similar to the participant businesses. Costs must also be measured in the same way, and the programme must not have a large effect on comparison businesses. An unrecorded influence, such as owner motivation, could break the first condition. Motivation is not a variable in the GreenWaste data, and we do not know that it explains the result." |
| §4 What can and cannot be concluded? | "Table B on page 2 shows how similar the groups are on the recorded features. After matching on four features, the participants' mean manager age is 2.97 years lower than the matched comparison businesses', and their mean cost before GreenWaste is 161 AED lower. Without manager age, these gaps are 17.12 years and 540 AED. Finding a match for every participant does not show that the matches are close enough. This study summary does not give the distribution of distances, a check that the groups overlap on all features together, or an analysis of how strong an unrecorded influence would need to be to change the result." |
| §4 second paragraph | "The 95% interval allows for the reuse of comparison businesses. It treats the selected matches as given, so it does not fully allow for how the matches were chosen or for bias from unrecorded influences. The 95% interval for the reduction (859 to 1,200 AED) includes values below 1,000 AED. So the estimate alone does not show that our rule of at least a 1,000 AED reduction in annual waste management cost per business per year is met. The full programme costs and the effects for the whole country are not given." |
| Source line | "Source: GreenWaste city data (10,000 businesses, measured before and 12 months after). All values use unrounded records. Tables R and B and paragraphs §1 to §4 are the material to inspect." Remove "corrected", the CSV name and both script names. |
| Page 2 heading | "H6-A: How similar the matched groups are, and what the figures show" |
| Table B title and columns | "Table B: Average characteristics before GreenWaste: participant businesses, all comparison businesses and matched comparison businesses". Columns: "Feature", "Participant businesses", "All comparison businesses", "Matched comparison businesses", "Gap in city standard deviations". Rows: "Manager age (years)", "Staff (people)", "Premises area (100 m²)", "Filtration (share of businesses)", "Annual cost before GreenWaste (AED; not used for matching)". Delete "Actual" from the title. |
| Table B note | "The matched comparison means count a business each time it is used. The gap is the participant mean minus the matched comparison mean, divided by the standard deviation across all city businesses. It is not a standard error and it is not a threshold for judging whether a match is good. Filtration is the share of businesses with a filter. Annual cost before GreenWaste was not used for matching." |
| Figure title and caption | "Figure 1: Manager age in participant businesses and in all comparison businesses". Caption: "The bars show the share of businesses in each age group, so the two groups can be compared even though they have different numbers. Overlap in age alone does not show that the groups are similar on all four features together." |
| Reuse box | Heading: "Reuse of comparison businesses and our rule". "4,794 pairs does not mean 4,794 different comparison businesses. The four-feature comparison has 9,588 matched rows but only 5,379 different businesses, so some comparison businesses contribute many times. The interval shows uncertainty about the mean matched difference, if the model's assumptions hold. It does not show the savings of individual businesses, and it does not allow for all sources of bias." |
| Page 3, Q1 | "Q1 | Match three participant businesses to comparison businesses. The seven businesses in this activity are invented. They are not from the city study. Use the profile cards. (a) Match A, B and C to comparison businesses using manager age and size. Use each comparison business at most once. (b) Write why you chose each pair. (c) Write which comparison business is not used. (d) Write one thing you do not know that could matter. Keep the reveal slips closed until you have recorded your choices." |
| Q1 after reveal | "Your trainer will now give you the reveal slips. Each shows a business's annual waste management cost after GreenWaste. Keep your pairs. For each pair, calculate the participant's cost minus the comparison business's cost." Table columns: "Pair", "Participant cost (AED)", "Comparison cost (AED)", "Difference (AED)". Then: "Calculate the mean of the three differences. Does this show that GreenWaste caused the difference? Explain why or why not." |
| Q2 | Title: "Q2 | Read the result for the city study (H6-A §2 and Table R)". "(a) Explain the sign, the comparison, the period and the units of the four-feature result. (b) Which four features were used to select the comparison businesses? Was annual cost before GreenWaste one of them? (c) Why can 4,794 participant businesses be matched to only 585 different comparison businesses? (d) What does this reuse mean for how we interpret the sample and the interval?" |
| Page 4 heading | "Q3 to Q6: judge the comparison" |
| Q3 | "Q3 | How similar are the matched groups? (Table B on page 2) (a) Write one measure on which the matched groups are more similar than all comparison businesses. (b) Write one difference that remains. (c) Which extra check would help you judge whether the matches are close enough?" |
| Q4 | "Q4 | What changes when manager age is left out, and what is not recorded? (Table R and §3 and §4) (a) Why could leaving out manager age change the estimate? (b) Why does making the recorded features similar not show that unrecorded influences are absent?" |
| Q5 | "Q5 | Read the source yourself, then check our rule. (a) Write the main finding and the paragraph or table that shows it. (b) Write the key assumption for a causal reading and the paragraph that states it. (c) A match was found for every participant. What does that show, and what does it not show? (d) Does the interval, and not only the estimate, show that our rule of at least a 1,000 AED reduction is met? Keep the uncertainty in the estimate separate from the question of whether a causal reading is credible." |
| Q6 | "Q6 | Close the source and give your first judgement. (a) Write one sentence interpreting the result, one strength of the comparison and one concern that matters for the decision. (b) Choose Act, Act with conditions or Ask first, and give your reason. (c) Request one piece of evidence about the matching and say how the answer could change your decision." |
| Comparison reminder | "Four methods compare in four ways. A lottery compares groups assigned by chance. Difference-in-differences compares changes over time. Regression discontinuity compares businesses either side of a cut-off. Matching compares businesses chosen because they look similar. Do not average the results of these different comparisons." |
| Page 5 heading | "AI exercise: compare, then verify" Remove "(15 minutes)". Stage headings: "Stage 1: Mark the response" and "Stage 2: Run the improved prompt in Microsoft Copilot" (timings removed; the trainer gives them aloud). |
| Stage 1 | "Naive prompt (a prompt with no context, as a busy person might type it): 'Compare these two matching evaluations and advise the commissioner.' Source: H6-A and Table B. This response was written for the exercise. It is not a real AI answer." Planted response: keep the preview text with "nonparticipants/controls" → "comparison businesses" and "the 1,000 AED minimum" → "our rule of at least a 1,000 AED reduction". Instruction: "Keep the claims that H6-A supports. Cross out the claims it does not support. Write one passage from the source that changes the advice." |
| Stage 2 improved prompt | "I commission a GreenWaste evaluation. Using only H6-A below, compare four-feature matching with the analysis that leaves out manager age. State the outcome, the comparison, the estimate and the interval. Tell me what was left off the matching list, whether costs were similar before GreenWaste, and how close the matches are. Separate the reuse of comparison businesses, the measured similarity and the unrecorded influences. Test our rule of at least a 1,000 AED reduction against the interval, not only the estimate. Ask me questions about missing information before you recommend action. Do not invent diagnostics, and do not treat matching as a lottery. Cite the paragraph or table for each fact. Here is H6-A: [paste page 1 of this worksheet and Table B from page 2]." Instructions: "Use only the information in H6-A, and keep your AI good-practice card beside you. If you are not using Copilot, read the prepared response on page 6 after you finish Stage 1. (a) Record one correction you verified. (b) Record one useful question Copilot asked about missing evidence." |
| Page 6 | Heading: "Prepared response". "Use this response if you are not using Copilot. Read it after you have marked the response on page 5. It was written for the exercise. It is not a real AI answer. An AI tool may answer differently." Heading inside: "A comparison grounded in the source". Terms in the text: "nearest control" → "most similar comparison business"; "4,794 participants used only 585 unique controls" → "4,794 participant businesses were matched to only 585 different comparison businesses"; "the annual-saving minimum" → "our rule of at least a 1,000 AED reduction". "Questions before recommending action" lists the four questions as in the preview, with "controls" → "comparison businesses". Closing task: "Verify the alternative yourself. (a) Check one factual claim against a named paragraph or table. (b) Write one question that could change the decision, and why." |
| Cards: title and instructions | Title: "Matching activity: business profile cards and reveal slips". Remove "Trainer: cut along dashed borders. Distribute page 1 only; retain page 2 until pairs are recorded." (move to the trainer print sheet). Page 1 heading: "Page 1 | Seven invented business profile cards". Text: "Match businesses A, B and C to comparison businesses 1 to 4 using manager age and size. Use each comparison business at most once. Record your choices before you receive the reveal slips. In the city study, one comparison business can be used more than once. In this activity each can be used only once." Cards: "Business A. Took part in GreenWaste. Manager age: 45. Size: small" and so on; comparison cards "Did not take part in GreenWaste". |
| Cards: reveal slips | Page 2 heading: "Reveal slips: keep these until you have recorded your pairs". Intro: "These are invented values for the exercise. Keep your original pairs. For each pair, calculate the participant's cost minus the comparison business's cost. Then calculate the mean of the three differences." Each slip: "Business A. Annual waste management cost after GreenWaste: 900 AED. Invented value for this activity." (replaces "Annual after-cost" and "Invented activity value"). |

**B6. Day 3 Session 1 worksheet and scenario cards** (status: approved 9 Oct, with Card 1 renamed "Savings fade" and Card 5 "Savings fade and hidden costs"). Terms: "scenario cards"; "scenario results table" (not "Table S held by the trainer"); "benefit-cost ratio"; "value today (year 0)"; full table titles; the full 1,000 AED rule; "study summary" becomes "model summary" here because the page describes a model.

| Item | Proposed text |
|---|---|
| Title and banner | Title: "GreenWaste: read the economic model". Remove "Separate Day 3 Session 1 review worksheet. Use pages 3-4 while concepts are taught." |
| Page 1 heading and intro | "H7-A: The economic model summary. GreenWaste is a fictional training case. Use this model summary as your source for today's questions." (The sentence "there is no separate economic report" is deleted.) |
| §1 Where does the benefit input come from? | "The city difference-in-differences study compares the change in annual waste management cost in 4,794 participant businesses with the change in 5,206 comparison businesses that did not receive GreenWaste. The difference between the two changes is a reduction of 812 AED per participant business, measured 12 months after GreenWaste. To call this a causal saving, we need the parallel trends assumption and the other conditions for the comparison. The estimate is provisional and is not a guarantee. The other methods compare different groups of businesses in different ways." |
| Table I title and rows | "Table I: Inputs to the model and where each comes from". Columns: "Input", "Value", "Source". Rows: "Annual saving per participant business: 812 AED, estimate from the city study (provisional)"; "One-off cost per participant business: 1,800 AED, assumption in this fictional case"; "Year when savings start: year 2, assumption"; "Number of years that savings last: 5, assumption"; "Discount rate: 5% a year, assumption". |
| §2 How are future amounts combined? | "The model assumes that equipment delivery costs 1,800 AED per participant business now (year 0), that there is no saving in year 1, and that the same annual saving is made in each of years 2 to 6. Future savings are discounted at an assumed rate of 5% a year, so that every amount is shown at its value in year 0 (its value today). The city data do not show five years of savings. They show only the first 12 months. For year t, the value today of the saving is the annual saving divided by 1.05 raised to the power t. Table F and Table O are on page 2. The calculations use unrounded inputs." |
| §3 Whose perspective, and which costs and benefits? | "This model mixes two points of view. It compares a cost to the authority (equipment delivery) with savings to businesses. It is not a full appraisal of the authority's budget, and it is not a full social cost-benefit analysis." |
| Table P title and columns | "Table P: Costs and benefits in the model: who bears each one and whether the model includes it". Columns: "Who and what", "Included in the model?", "Evidence we would need". Rows: "Authority: equipment delivery | Yes, as an assumed cost at year 0 | Amounts and coverage from the programme's records"; "Authority: staff and administration | Not known | What is already included, the amount and the timing"; "Business time and maintenance; wider effects | Not known | The point of view, the resource costs and any transfers between actors". |
| After Table P | "Check that a cost is not already counted before you add it. Financial savings are not automatically net benefits to society. Charges, transfers and wider effects need separate treatment." |
| §4 Sensitivity and the limits of the headline result | "The scenarios change the model's inputs. They do not change any observed fact about the programme. The settings for each scenario are on page 2. The scenario results table is given out after your group records its prediction. The results for Cards 1 to 4 depend on the ranges we tested, because each of those cards changes one input. Card 5 changes two inputs together. We have no evidence about how realistic these settings are." |
| §4 second paragraph | "An extra check shows that a discount rate of 40% would give a ratio of 0.66, with all other inputs unchanged. Delaying the savings by three more years (years 5 to 9) at 5% gives a ratio of 1.61, which is still above 1. These checks do not show which discount rate the government would use, or how long a delay is realistic. A ratio above 1, or a positive net present value, depends on the model and does not prove value for money. Our rule of at least a 1,000 AED reduction in annual waste management cost is a different test and is not a benefit-cost ratio threshold." |
| Source line | "Source: GreenWaste city data and the economic model. The model inputs, the cost boundary and the scenarios are fictional. Paragraphs §1 to §4 and Tables I, P, F and O, and the scenario results table, are the material to inspect." Remove "corrected city CSV" and both script names. |
| Page 2 heading | "H7-A: Cash flows, results and scenario settings" becomes "H7-A: Costs and savings by year, base case results and scenario settings". |
| Table F title | "Table F: Delivery cost and annual saving per participant business in each year, with each saving converted to its value today (AED)". Columns: "Year", "Cost (AED)", "Saving (AED)", "Saving at value today (AED)". |
| After Table F | "One-year example: 812 divided by 1.05 is about 774 AED. The first saving in the model is in year 2: 812 divided by 1.05² is about 737 AED. Add the values today for years 2 to 6. The rounded figures in the table may not add up exactly to the unrounded total." |
| Table O title and rows | "Table O: Base case results per participant business: total benefits, cost, benefit-cost ratio and net present value (AED)". Rows: "Benefits at value today: 3,350 AED. The savings in years 2 to 6, converted to year 0"; "Cost at value today: 1,800 AED. The one-off equipment delivery cost at year 0"; "Benefit-cost ratio: 1.86. Benefits divided by costs"; "Net present value: 1,550 AED. Benefits minus costs". |
| After Table O | "The benefit-cost ratio is benefits divided by costs. It has no units. The net present value is benefits minus costs, in AED per participant business. Neither number shows that GreenWaste caused the savings, that the savings will last, or that all costs are included." |
| Scenario settings box | Heading: "Scenario settings: write your prediction before you see the results". "Card 1: Savings fade. After the first year of saving, each year's saving is 30% lower than the year before. Card 2: Hidden costs. We add 600 AED of costs at year 0 that are not already counted. Card 3: A higher discount rate. The rate is 8%. Card 4: A shorter life. Savings last three years (years 2 to 4). Card 5: Savings fade and hidden costs. This card changes the inputs of Cards 1 and 2 together. On every card, all other inputs stay at the base values. Keep this page closed while your group makes its prediction." Then: "The scenario results table is given out after your group has recorded its prediction and its reason in Q4." **Decided (Fiona, 9 Oct):** Card 1 "Old habits" is renamed "Savings fade". Card 5 is "Savings fade and hidden costs". Cards 3 and 4 keep their names. |
| Page 3 heading | "Q1 to Q3: inputs, timing and whose point of view". |
| Q1 | "Q1 | What goes into the model? (§1 and §2, Table I) (a) Name one input that comes from the city study and one that is an assumption, and write where each appears. (b) In which year does the cost occur? (c) In which year do savings start, and in which year do they end? (d) How many years of savings are there? (e) Is there a saving in year 1? (f) What evidence would you need before you trust the future savings?" |
| Q2 | "Q2 | Value today, ratio and net present value (Tables F and O) (a) Calculate the year 2 saving at its value today: 812 divided by ____ is about ____ AED. (b) Why can we not simply multiply the annual saving by five? (c) Write the benefits at value today (AED) and the cost at value today (AED). (d) Show how the ratio is calculated. (e) Show how the net present value is calculated. (f) Explain what each of these two numbers means, under the model's assumptions." |
| Q3 | "Q3 | Whose point of view? (§3, Table P) (a) Whose decision is this? (b) Which costs and benefits belong to that point of view? (c) Name one cost that may be missing. (d) What might already be counted in the model? (e) What amount and timing would you request, without counting the cost twice?" |
| Page 4 heading | "Q4 to Q6: scenarios and your recommendation". |
| Q4 | "Q4 | Predict before you see the results. (a) Write your card number and the input it changes. (b) Which inputs stay the same? (c) Predict the benefit-cost ratio. Will it be above or below 1? Give your reason. After your group has recorded its prediction, you will receive the scenario results table. (d) Write the ratio in the table. What explains the difference from your prediction? (e) What evidence would show whether this change is realistic? (f) Among Cards 1 to 4, which card lowers the ratio most? Why does this not give a ranking of the assumptions in general?" |
| Q5 | "Q5 | Read the model yourself (H7-A, pages 1 and 2). (a) Write one input that comes from the city study and one assumption, and where each appears. (b) What does the ratio support, under these assumptions? (c) What does it not show?" |
| Q6 | "Q6 | Close the source and give a conditional recommendation. (a) Explain what a benefit-cost ratio of 1.86 means. (b) State your provisional action and one condition. (c) Request one specific missing fact, and explain how its answer could change your decision." |
| Page 5 heading | "AI exercise: check the scenario". Remove "(15 minutes)", "(8 minutes)" and "(7 minutes)". Stage headings: "Stage 1: Mark the response" and "Stage 2: Run the improved prompt in Microsoft Copilot". |
| Stage 1 | "Naive prompt (a prompt with no context, as a busy person might type it): 'Generate one plausible scenario where this programme's benefit-cost ratio falls below 1. Tell me whether it is realistic.' Source: H7-A. This response was written for the exercise. It is not a real AI answer." Planted response kept as in the preview. Instruction: "Keep the claims that H7-A supports. Cross out the arithmetic, timing or realism claims that it does not support. Write one source reference that changes the advice." |
| Stage 2 improved prompt | "I am reviewing the fictional GreenWaste cost-benefit model H7-A below. Identify which inputs are estimated from data, modelled or assumed. Do not call the 1,800 AED cost measured, and do not call the difference-in-differences saving a proven causal benefit. Compare the four scenarios that each change one input (Cards 1 to 4). Say how far each one moves the ratio from the base ratio, and rank them only within these stated changes. Do not rank assumptions in general without defining their ranges. Card 5 changes two inputs together, so keep it separate. Before you recommend which assumption to investigate, ask me questions, including what evidence would make each change realistic and which discount-rate guidance applies. Keep the timing, the point of view, and the difference between the ratio and the net present value explicit. Cite the paragraph or table in H7-A. Here is the source: [paste worksheet pages 1 and 2 and the scenario results table, which you receive after your group has recorded its prediction]." Instructions: "Use only the information in H7-A, and keep your AI good-practice card beside you. If you are not using Copilot, read the prepared response on page 6 after you finish Stage 1. (a) Write one number you verified. (b) Write one useful question that the response asked about missing evidence." |
| Page 6 | Heading: "Prepared response". "Use this response if you are not using Copilot. Read it after you have marked the response on page 5. It was written for the exercise. It is not a real AI answer. An AI tool may answer differently." Section headings kept: "Separate inputs from conclusions", "Quantify the stated changes", "Questions before recommending an input to investigate". In the text, "estimated city extra change" → "estimate from the city study"; "Tables F/O" → "Tables F and O"; "Table S" → "the scenario results table"; "the ratio and NPV" → "the ratio and the net present value". Closing: "Verify this response yourself. (a) Check one number against a named table. (b) Write one request for evidence that could change the spending decision, and say why." |
| Cards: title and instructions | Title: "GreenWaste: cost-benefit scenario cards". Remove "Print scenario cards, board and separate result key. One card per group. For eight groups print Cards 1, 2 and 3 twice… Retain page 7 until predictions are recorded; pages 1-6 contain no scenario results." (move to the trainer print sheet). |
| Each scenario card | Replace the repeated "Everything else stays fixed: base annual saving 812 AED, year-0 equipment delivery cost 1,800 AED, no saving in year 1, five saving years 2-6 and 5% rate, except the input(s) this card changes." with "All other inputs stay at the base values, which are on the board page." Then: "Change: [the card's change]". "Base ratio: 1.86. Write your prediction of the new ratio before you see the results. Prediction and reason: ____ What evidence would show whether this change is realistic? ____" Footer: "This is a fictional scenario. It does not show how the programme actually performed. Post your card number and prediction above the line. After the results are given out, post your card number and the result below the line." |
| Card names and text | Card 1: "Savings fade. Each year's saving after the first year of saving is 30% lower than the year before. The first saving, in year 2, stays at the base amount." Card 2: "Hidden costs. We add 600 AED per business for administration and business time, at year 0, in addition to the 1,800 AED already included. Check that the costs are not already counted." Card 3: "A higher discount rate. We use a discount rate of 8% instead of 5%, over the same five years of savings." Card 4: "A shorter life. Savings last three years instead of five. Savings are made only in years 2, 3 and 4." Card 5: "Savings fade and hidden costs. This card changes two inputs. Each year's saving after the first is 30% lower than the year before, and we add 600 AED at year 0." |
| Page 6, board | Heading: "Page 6 | Two-lane board for the benefit-cost ratio". "Post your predictions above the line before the results. After the results are given out, post the card numbers and the results below the line." Base case: "The base case is a benefit-cost ratio of 1.86, using the base inputs: annual saving 812 AED, equipment delivery cost 1,800 AED at year 0, no saving in year 1, savings in years 2 to 6, and a discount rate of 5%." "A ratio of 1 is the break-even point: the benefits at value today equal the costs." "A result below 1 is conditional on the scenario. It does not show that the programme failed." Remove "The board is a paper/browser reference, not a shared room poll. Use the existing A1 board…" and "These five cards preserve the current scenario inputs and eight-group allocation." |
| Page 7, scenario results table | Heading: "Scenario results table". Remove "Table S: trainer holds until reveal" and "Distribute only after groups have recorded their predictions." Title: "Benefit-cost ratio in each scenario, compared with the base ratio of 1.86". Columns: "Card", "Change", "Benefit-cost ratio", "Below 1?". Text after: "Only Card 5 is below 1. It combines fading savings and hidden costs. Among Cards 1 to 4, which each change one input, Card 1 lowers the ratio most. This compares only these settings. It is not a ranking of the assumptions in general, and it does not show that the settings are realistic. Write the results in Q4 on worksheet page 4. Keep your predictions visible above the line while you compare them with the results below it." |

**B7. Day 3 Session 2 worksheet** (status: approved 9 Oct). There are no cards or slips for this session. Terms: "participant businesses", "comparison businesses that did not receive GreenWaste", "treatment group"/"control group" (pilot only), the full 1,000 AED rule, full figure and table titles, "source summary" in place of "supplied source".

| Item | Proposed text |
|---|---|
| Title and banner | Title: "GreenWaste: read the chart and its claim". Remove "Separate Day 3 Session 2 review worksheet. Work on pages 3-4 as concepts are taught. Page 7 holds numerical references: open after the two-business task. Page 6 is the AI fallback: hold until Stage 1 is finished." The instructions to open page 6 and page 7 are given at the point where they are needed (Q4, Stage 2). |
| Page 1 heading and intro | "H8-A §1: Reading the cost bars. GreenWaste is a fictional training case. Use H8-A as your source for today's questions." (The sentence "there is no separate report to find" is deleted.) |
| Figure C title | "Figure C: Mean annual waste management cost of the same participant businesses, drawn twice. Chart A starts at zero. Chart B starts at 700 AED." |
| Table C title and headings | "Table C: The values behind Figure C: mean annual waste management cost of the same 4,794 city participant businesses (AED)". Columns: "Group", "Before GreenWaste (AED)", "12 months after GreenWaste (AED)", "Fall in mean cost (AED)". Row: "Same 4,794 city participant businesses: 1,432; 763; 669". |
| Source caption | "These are the mean annual waste management costs, in AED per business, of the same 4,794 city participant businesses before GreenWaste and 12 months after. The bars compare two times for participants. They do not compare participants with comparison businesses that did not receive GreenWaste. The values are rounded. The mean fall is about 669 AED." Remove "Corrected city CSV." |
| What is supported, and what is not? | "The bars describe the participants' mean cost before and after GreenWaste. They do not show that GreenWaste caused the fall. They do not show that every participant's cost fell, or that the mean describes every business. The bars do not show individual changes, a credible comparison for a causal reading, or the uncertainty of an estimated effect." |
| Why does the baseline matter? | "The length of a bar shows an amount. A baseline at zero keeps the lengths in proportion to the amounts. Chart B starts at 700 AED, so its bar lengths show the amounts above 700 AED, not the full costs. The labels give the values, but they may not change a reader's first impression. A baseline that does not start at zero can be appropriate for other types of chart, or when it is clearly explained. It is not automatically misleading." |
| Audience paragraph | "The sentence and the audience also matter. A large drop in the height of the bars does not show an effect of the programme. A better caption cannot create evidence that is missing." |
| Source line | "Sources: Figure C and Table C in H8-A §1. Both charts have the same upper bound, 1,600 AED. Only the lower bound differs." Remove "Calculations: day3_case.R and day3_session2_review.R". |
| Page 2 heading | "H8-A §2: Distributions show variation between businesses, not uncertainty." |
| Figure D title and caption | "Figure D: Annual waste management cost before GreenWaste of all 4,794 city participant businesses (AED)". Caption: "The histogram includes all 4,794 city participant businesses. Each bar counts the businesses whose cost falls within a 300 AED range. The mean is 1,432 AED and the median is 1,376 AED. The middle 50% of businesses have costs from 1,096 to 1,694 AED. The range is 153 to 4,306 AED. These numbers describe how much costs varied between businesses before GreenWaste. They are not an estimated effect and not a confidence interval." |
| Outcome-change notice | Add above Figure E: "The outcome changes on this page. Figure E shows landfill waste in tonnes per business per year, not annual waste management cost in AED." |
| Figure E title and caption | "Figure E: Landfill waste before GreenWaste in ten selected records (tonnes per business per year)". Caption: "The ten values are 3, 4, 5, 5, 6, 7, 7, 8, 9 and 46 tonnes per business per year. The mean is 10.0 tonnes, the median is 6.5 tonnes and the range is 3 to 46 tonnes. Nine of the ten values are below the mean. Repeated values are shown as separate stacked dots. We selected these ten records for teaching. They do not represent the city. One large value can raise the mean, but that alone is not a reason to delete it." |
| Spread box | Heading: "Two different meanings of spread". "A distribution shows how much businesses differ from each other. The interval for the pilot on page 7 shows how uncertain we are about an estimated mean effect. The middle 50% in Figure D and the range of the ten records in Figure E are not that interval." |
| Page 2 source line | "Sources: H8-A §2, Figures D and E. Figure D uses the before-GreenWaste cost of every participant business. Figure E uses ten records chosen earlier in the course. Page 7 changes the group of businesses and the outcome again, for the pilot." |
| Page 3 heading | "Q1 to Q3: mark the chart and interpret it" |
| Q1 | "Q1 | Mark Figure C on page 1. (a) Circle the units and mark where each axis starts. (b) Underline the group of businesses, the time period and the comparison in the caption. (c) Use Table C to check the bars. (d) What changes when the baseline changes? (e) What stays the same?" |
| Q2 | "Q2 | What do the cost bars support? (a) Write one descriptive statement that the bars support, and the source you took it from. (b) Write one specific limit, and the evidence you would need to address it." |
| Q3 | "Q3 | Read Figures D and E on page 2. (a) What does the histogram of all participants add to the mean? (b) Explain the middle 50% without calling it a confidence interval. (c) Why does the mean of the ten selected landfill records differ from their median? (d) Why must we not call the ten records a result for the city? (e) What changes between Figure D and Figure E: the outcome, the units, the group of businesses, or more than one of these?" |
| Page 4 heading | "Q4 to Q7: percentages, the caption and your judgement" |
| Q4 | "Q4 | Two invented businesses. Calculate first, then open page 7. (a) Complete the table: the fall in tonnes for each business as a percentage of its starting amount. (b) Calculate the total tonnes before and after, and the fall in the total as a percentage. (c) Calculate the mean of the two business percentage falls. (d) Why are the two percentages different? (e) After you see the summary for the city on page 7, explain what 49.5% and 58.6% each measure. Which total is each percentage based on?" Table row labels: "Business with a small starting amount", "Business with a large starting amount". |
| Q5 | "Q5 | Repair the caption for the director. Draft caption: 'GreenWaste substantially reduced every participant's costs.' Use Figure C. Write a caption that names the group of businesses, the outcome, the units, the time, the comparison, the source and the limit on causal claims. Choose a baseline that suits your sentence, and say why." |
| Q6 | "Q6 | Read the pilot interval (page 7, Figure P). (a) What uncertainty does the interval show? (b) Does it show that our rule of at least a 1,000 AED reduction in annual waste management cost per business per year is met?" |
| Q7 | "Q7 | Close the source and give your first chart check. (a) Name one check you will do before trusting a chart, and the mistake it prevents. (b) Write one statement that today's evidence supports and one limit." |
| Page 5 heading | "AI exercise: chart, claim and audience". Remove "(15 minutes)", "(8 minutes)" and "(7 minutes)". Stage headings: "Stage 1: Mark the response" and "Stage 2: Run the improved prompt in Microsoft Copilot". |
| Stage 1 | "Naive prompt (a prompt with no context, as a busy person might type it): 'Which of these two charts better represents the difference, and why?' The AI was given Figure C and the draft claim. This response was written for the exercise. It is not a real AI answer." Planted response kept as in the preview. Instruction: "Keep the readings that H8-A supports. Cross out the advice and conclusions that it does not support. Check whether each sentence answers the question about the claim and the audience." |
| Stage 2 improved prompt | "These two bar charts of annual waste management cost will sit beside the claim 'GreenWaste substantially reduced every participant's costs' in a report for a director who is not a technical expert. Using only H8-A below, ask me questions before you recommend a chart. Check whether the before and after means support that sentence, whether the words 'every' and 'programme effect' are justified, and how a zero baseline compared with a baseline of 700 AED changes how large the difference looks. Separate whether a chart is numerically accurate from whether it suits this claim and audience. Do not say that every axis that does not start at zero is wrong. Do not confuse the spread of a distribution with a confidence interval. Suggest a corrected caption that names the group of businesses, the outcome, the units, the period, the comparison and the limit on causal claims. Cite the source for each point. Source: [paste H8-A pages 1 and 2; attach or show the two charts of Figure C from page 1 if you can]." Instructions: "Use only the information in H8-A, and keep your AI good-practice card beside you. If you are not using Copilot, read the prepared response on page 6 after you finish Stage 1. (a) Record one correction you verified. (b) Record one useful question the response asked about missing evidence." |
| Page 6 | Heading: "Prepared response". "Use this response if you are not using Copilot. Read it after you have marked the response on page 5. It was written for the exercise. It is not a real AI answer. An AI tool may answer differently." Headings: "Questions before choosing the display", "Check the numbers and what the chart claims", "Correct the sentence, not just the chart". In the text, "H8-A §1, corrected city records" → "H8-A §1"; "causal/every-participant claim" → "claim about causes or about every participant"; "the same 4,794 city participants" → "the same 4,794 city participant businesses". Closing: "Verify this response yourself. (a) Check one factual reading against its source. (b) Write one reason the chart choice fits the corrected claim, and one request for evidence." |
| Page 7 heading and intro | "H8-A §§3 and 4: numbers for reference". Replace "Open after completing the two-business calculation in Q4. These references are not the prepared AI response on page 6." with "Open this page after you have completed the two-business calculation in Q4." |
| §3 | Heading: "§3 | Percentage falls: an invented example and the summary for the city". Table columns: "Business", "Before (tonnes)", "After (tonnes)", "Fall (%)". Text: "In the invented example, total tonnes fall from 100 to 56, which is a fall of 44%. The mean of the two business percentage falls is (80% + 40%) / 2 = 60%. Weighting each business by its starting tonnes gives 0.1 × 80% + 0.9 × 40% = 44%. Every starting amount in this example is above zero, so each percentage can be calculated." |
| §3 city summary table | Title: "Landfill waste of the same 4,794 city participant businesses, before GreenWaste and 12 months after: two ways to summarise the fall". Columns: "Summary", "Value", "How businesses are weighted". Rows: "Fall in total participant tonnes: 49.5%: businesses with larger starting amounts count for more"; "Mean of the percentage falls of the participant businesses: 58.6%: each of the 4,794 businesses counts equally". Text: "The total before GreenWaste was 31,766.4 tonnes and the total after was 16,038.0 tonnes. Every business had a landfill amount above zero before GreenWaste. Neither summary alone shows that GreenWaste caused the fall, or that every business fell. One summary gives more weight to businesses with larger starting amounts. The other gives every business the same weight." Delete "Actual". |
| §4 | Heading: "§4 | Figure P: the separate pilot and annual waste management cost". Text: "This is the separate pilot of 400 businesses. A lottery assigned 200 businesses to the treatment group and 200 to the control group. The comparison is of annual waste management cost 12 months after GreenWaste. The estimated mean reduction is 1,014 AED, with a 95% interval of 862 to 1,167 AED. The interval includes values below our rule of at least a 1,000 AED reduction. The interval shows uncertainty about the estimated mean effect. It does not show the distribution of individual savings, and it does not allow for every source of bias." Figure P title: "Figure P: Estimated mean reduction in annual waste management cost in the pilot, with its 95% interval, compared with our rule (AED)". |
| Page 7 source line | "Sources: H8-A §3 (the two-business example and the city summaries) and §4, Figure P (the pilot). Do not attach the landfill percentages or the pilot interval to the cost bars on page 1." Remove the script names. |

Older rewrite examples (superseded as each session is approved; keep for reference):


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

**C proposals (status: pending Fiona's review).**

| Where | Current | Proposed |
|---|---|---|
| D1S1 slide 9, figure caption | Cost change in AED. Zoomed axis: 720 to 620; zero is outside this view. | The vertical axis shows the change in cost in AED. It is zoomed in to run from -720 to -620 AED, so zero is not shown. (Check the axis signs against the figure before the edit.) |
| D1S1 slide 9, figure title | Estimate / repeated-sample illustration | Illustration: the estimate, and how it would vary across repeated samples |
| D1S1 slide 10 | Hypothetical estimates of annual saving, AED. All three point estimates are 1,100; these are not additional GreenWaste results. | These are three hypothetical estimates of annual saving, in AED. All three estimates are 1,100 AED, but their uncertainty differs. They are not additional GreenWaste results. |
| D1S1 slide 12 | A: p < 0.001. B: p ≈ 0.072. These are hypothetical normal-model examples, not GreenWaste results. | Example A has a p-value below 0.001. Example B has a p-value of about 0.072. Both are hypothetical examples. They are not GreenWaste results. |
| D1S2 slide 8 | 5,206 businesses above the participation score cutoff. Same period and cost units. | These 5,206 comparison businesses that did not receive GreenWaste had scores above the cut-off for taking part. The period and the cost units are the same as for the participant businesses. |
| D1S3 slide 3 | The first example is hypothetical. Random assignment avoids systematic selection, across possible lotteries. | The first example is hypothetical. Over many possible lotteries, random assignment does not favour one kind of business. |
| D1S3 slide 5 | Illustration: 200 practice lotteries per size, using pilot manager-age records. These are not programme effects. | This illustration shows 200 practice lotteries for each group size, using manager ages from the pilot data. The results are not programme effects. |
| D1S3 slide 6 | The actual pilot groups: 200 join and 200 wait. Similar distributions, not identical businesses. | These are the pilot groups as assigned: a treatment group of 200 businesses and a control group of 200 businesses. Their starting costs have similar distributions, but the businesses are not identical. |
| D1S3 slide 7 | Join minus wait: 769 − 1,783 ≈ −1,014 AED. Lower annual waste costs in the join group, 12 months after, among eligible pilot businesses. | Treatment group minus control group: 769 − 1,783 = −1,014 AED. Twelve months after GreenWaste, the treatment group's mean annual waste management cost was lower than the control group's, among the eligible pilot businesses. |
| D2S1 slide 8 | Hypothetical histories, identical scales. These are not extra GreenWaste observations. | These are two hypothetical histories on identical scales. They are not additional observations from the GreenWaste data. |
| D2S1 slide 10 / figure caption | Extra reduction compared with the rule | The difference between the two changes compared with our rule of at least a 1,000 AED reduction |
| D3S2 page 1 | Long compound sentences under "What is supported, and what is not?" and "Why does the baseline matter?" | Already split into short sentences in B7. |

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

### 8A. Process for the language pass (agreed; language pass done in source for the 7 existing previews on 9 Oct, not yet re-rendered or published)

1. Work one session at a time in this order: Day 1 S1, S2, S3; Day 2 S1, S3; Day 3 S1, S2. Apply the same rules to Day 2 S2, Day 3 S3 and Day 4 when their previews are built.
2. For each session, edit the review `.qmd` files (slides, worksheet, cards or slips) and the R helper files that produce text.
3. Before anything is rendered, give Fiona a before-and-after list for that session: location, current text, new text, reason. Fiona approves or revises.
4. Then re-render, recheck all figures against the R scripts, recheck that every slide fits 1280x720 and every worksheet page fits A4, and look at the rendered pages.
5. Add a short entry to `HANDOFF.md` and tick the items in this file.
6. Content additions (sections 8B to 8H) are proposed separately from the language pass, so the before-and-after lists stay readable.

### 8B. R code snippets on slides (DONE in source, 9 Oct: D1S2 data exploration; D1S3, D2S1 and D2S3 regression-table code; base R plus estimatr, as in the existing snippets; code boxes not yet run in the live webR toolchain)

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

### 8C. The "review and interpret the regression table" activity (DONE in source, 9 Oct, without duplicating existing questions: Q2 in the D1S3 and D2S1 worksheets already circles the row and reads the other rows, so only "box the 95% interval" and "read the p-value" were added there; D2S3 Q2 already reads Table R and gets nothing new; no separate page 7 was added)

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

### 8D. AI examples: keep the preview versions (DONE: planted responses and prompts kept, language rules applied)

**Decided (Fiona, 9 Oct):** keep the AI responses and the improved prompts exactly as they are in the previews. Do not shorten them or switch back to the earlier (pre-6 October) versions. The earlier responses were shorter (about 40 to 75 words) but had almost every sentence wrong, so there was little to mark as supported; the previews have a mix of supported claims and overclaims (Day 2 Session 1: 3 supported sentences, 1 neutral, 3 with errors).

The AI best-practice sheet is already settled (`REVIEW_NOTES.md` item 13) and is not repeated here.

Only the language rules and the agreed terms apply to the AI pages (section 1; Fiona, 9 Oct: the planted responses use the agreed group names, e.g. "comparison businesses" in place of "nonparticipants", with the planted errors unchanged): full sentences, "Improved prompt" in place of "Better prompt" (keep "Naive prompt"), and one standard sentence in place of the "authored exercise material" wording (section 3).

### 8E. Day 1 Session 2: more code, data exploration and cleaning (DONE in source, 9 Oct: four new slides and worksheet page 7. FOR LUCAS: negative annual waste costs after the programme (734 city rows) are left as they are and not addressed anywhere in the slides or worksheets; the cleaning examples are invented. If we later decide to address them, see the comment in session2_review.R)

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

### 8F. End of Day 1 Session 2: state both comparisons and hand over to Session 3 (DONE in source, 9 Oct: the final slide now states both comparisons)

Current state: slide 10 names both comparisons (before and after, -669 AED; with and without, -1,638 AED) with "what each misses". Five slides then follow (cards, AI, final reading), so the two comparisons are not what participants see last. The closing slide asks only "Could the pilot's lottery give a fairer comparison?" Day 1 S3 slide 1 then restates both comparisons.

Proposal: the final slide of Session 2 states both in full sentences, with the same labels used on Session 3 slide 1: "Before and after: for the same participants, the mean annual waste cost fell by 669 AED. With and without: after the programme, participants' mean cost was 1,638 AED lower than other businesses' mean cost. Neither tells us what would have happened without GreenWaste. Tomorrow's first question is: can a lottery give a fairer comparison?" Use "with and without" and "before and after" everywhere; drop "after-only gap" and "with/without" (section 3).

### 8G. Show the GreenWaste map before every methods section (DONE in source, 9 Oct: a "Who and what are we comparing?" slide opens D1S2, D1S3, D2S1, D2S3, D3S1 and D3S2; _case_map.qmd takes an optional map_highlight variable; no worksheet header maps added)

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

### 8H. Day 3 Session 2: add a scatter plot or another typical impact-evaluation graph (DONE in source, 9 Oct: both options 1 and 2, as two slides before the AI snapshot, d3s2-p12b scatter and d3s2-p12c forest plot of four methods; the questions are on the slides, no new worksheet questions)

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
