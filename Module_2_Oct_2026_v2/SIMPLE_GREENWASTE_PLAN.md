> Day 3 approved and rebuilt 6 October 2026. Days 1 to 3 are complete: shortened decks, two-sided worksheets, trainer keys and shared computed figures. [Day 3 review](review_2026_10_06/day3_review.qmd); [Day 4 tables](review_2026_10_06/day4_plan.qmd) are the next daily approval. Two 60-minute sessions remain; the former final slot is excluded. Earlier status and build proposals below are historical where superseded.

> Day 2 approved and rebuilt 6 October 2026. The eight score-58 records are corrected; the current table below uses that CSV and robust RDD intervals. Earlier completion notes are historical. Next tables: `review_2026_10_06/day3_plan.qmd`.

# Simple GreenWaste: what is being done and what is next

## Scope update from Lucas (6 October 2026)

The rebuild now covers **eleven course-owned sessions**. Drop the former Day 4
Session 3 design workshop from the delivery plan; its slot will be an evaluation
simulation prepared by someone else. Keep the existing files for reference.
The original row for Oct15 S3 below is superseded.

Lucas also asked for shorter sessions, less information and technical prose,
appealing activity materials, better interactive visuals and a course-owned
replacement for Menti. The review and proposed daily teaching plan are in
`review_2026_10_06/week_review.qmd`, with a rendered HTML review and a local
activity preview in the same folder. Lucas approved the 60/60/75-minute
schedule for Days 1-3, 60/60 for Day 4, and the Day 1 slide tables on 6 October.
The shorter Day 1 decks and screen/paper materials are now built and checked.
Day 2 slide tables are in `review_2026_10_06/day2_plan.qmd`, pending daily review.
The case CSV remains unchanged; its score-rounding correction is still pending.

Status 2026-10-06 (updated the same day). Owner: Lucas, agreed with Fiona. Work happens on the branch
`simple-greenwaste`; `main` and the live site stay as they are until the branch
is reviewed and merged.

## Why

The current GreenWaste file (`evaluation_data_GreenWaste.csv`) has three
overlapping layers: neighbourhoods offered by lottery, an eligibility score with
a cut-off at 58, and enrolment. Every session has to explain *drawn*, *eligible*,
*enrolled* and *round* before it can teach its method, and the room loses the
thread. Participants have also never seen any GreenWaste numbers (Module 1 used
the case only for a Theory of Change exercise; see the 2026-10-05 reminder in
`CLAUDE.md`), so there are no Module 1 figures to stay consistent with.

## Scope (decided 2026-10-06)

**Every Module 2 deck uses this one case**: no traffic cameras (Oct12 S1, S2, Oct13 S3's second case),
no school-zone data (Oct14 S2), no Tariff Shield (Oct15 S2), no old GreenWaste file. The work runs in
daily batches: all of a day's decks are drafted together, Lucas reviews one table and the previews
per day.

## The new case, in one sentence

GreenWaste helps businesses cut their waste costs. In the **pilot district** a
lottery chose which businesses joined; in **the rest of the city** every business
with an efficiency score of 58 or below joined.

## The data (done)

`evaluation_data_GreenWaste_simple.csv`, written by `make_greenwaste_simple.R`.
Invented, one row per business, twelve columns, no other file needed:

| Column | Meaning |
|---|---|
| `business` | identifier |
| `setting` | `pilot` (400 businesses, all scoring 58 or below, lottery) or `city` (10,000 businesses, every score, rule at 58) |
| `score` | efficiency score, 0 to 100, higher is more efficient |
| `took_part` | 1 if the business took part |
| `cost_before`, `cost_after` | waste-management costs in AED, before and 12 months after |
| `landfill_before`, `landfill_after` | waste sent to landfill, tonnes per year (a second outcome, used in Day 1 Session 1 to practise the vocabulary without giving away the cost results) |
| `manager_age`, `staff`, `area`, `filtration` | what else we know about each business |

Which part each method uses:

| Method | Uses | Compares |
|---|---|---|
| Randomised comparison | pilot | lottery winners with the rest, after |
| Before and after | city | businesses that took part, before with after |
| With and without | city | took part with did not, after |
| Difference-in-differences | city | the change for those who took part with the change for the rest |
| Regression discontinuity | city | businesses just either side of 58 |
| Matching | city | each business that took part with one like it on age, staff, area, filtration |

What is built in, so each method has something real to find:

- The effect is larger for less efficient businesses: about -1,020 AED on average
  for those who took part, about -650 at the cut-off.
- Costs were rising anyway, faster for less efficient businesses: before-and-after
  understates; DiD falls about 200 AED short (parallel trends fails).
- Businesses that took part were cheaper to begin with: with-and-without overstates.
- Manager age drives costs and differs a lot between the groups: matching on all
  four characteristics works; **leaving manager age out breaks it**.
- Managers are about 5 years younger just below 58: **the RDD balance check
  fails**, and adjusting for manager age moves the RDD estimate.
- A few large businesses give costs and landfill a long right tail (mean above
  median), and changes vary: about one business in ten that took part ends with
  higher costs.
- Landfill: smaller businesses send less (a head start), everyone's landfill fell a
  little, and taking part cut it by about 3 tonnes a year.

Current headline numbers (computed by `greenwaste_case.R`; decks and handouts must
quote the objects in that file, never type the numbers):

| Estimate | Value |
|---|---|
| Before and after | -669 |
| With and without | -1,638 (took part started 825 AED cheaper) |
| Randomised (pilot) | -1,014, 95% CI -1,167 to -862 (spans the 1,000 rule) |
| Difference-in-differences | -812 |
| RDD, +/-2 points | -721 (robust HC2 CI -943 to -498); -632 adjusted for manager age |
| RDD, +/-5 points | -784 |
| Matching, all four | -1,029; without manager age -1,341 |
| Manager age just below 58 | 5.3 years younger |

## Done so far

| Item | File | Where to see it |
|---|---|---|
| Data generator and data | `make_greenwaste_simple.R`, `evaluation_data_GreenWaste_simple.csv` | repo |
| Every headline number, computed once | `greenwaste_case.R` | repo |
| Case introduction: one city map, pilot district inside it, shops with their scores | `greenwaste_case_intro.qmd` | sempe.dev/R-course/greenwaste_case_intro.html (unlinked preview) |
| Detailed case brief (draft) | `make_case_brief.R` -> `GreenWaste_case_brief.docx` | docs/handouts (unlinked) |

Converted on the branch (see `HANDOFF.md` for the full state): Day 1 (Oct12 S1, S2, S3,
approved) and Day 2 (Oct13 S1, S2, S3, waiting for review), with their packs. The city
map is shared as `_case_map.qmd`. Days 3 and 4 are next.

## Words to use, words to retire

| Use | Retire |
|---|---|
| pilot district; the rest of the city | neighbourhood; treatment neighbourhood; drawn |
| took part | enrolled; eligible; offered |
| efficiency score | efficiency index |
| cost before; cost after | round 0 / round 1 |
| "two numbers someone might report" | "Module 1 said ..." (participants never saw GreenWaste numbers) |

## What is next, on the branch

1. **Case introduction in every GreenWaste deck.** The city-map slide opens the
   GreenWaste part of Oct12 S3, Oct13 S1, Oct13 S2, Oct13 S3, Oct14 S1, Oct14 S2,
   Oct14 S3 and Oct15 S1. In Oct12 S3 it replaces "Where we left GreenWaste".
2. **Two case handouts.** A picture-only brief (the city map and two lines),
   handed out with the introduction; the detailed reference sheet (decision rule,
   the four groups, the columns) handed out later in Oct12 S3, once the numbers
   start. Both go on the landing page.
3. **Convert each session** to the new data, vocabulary and numbers:

   | Session | Owner | Main changes |
   |---|---|---|
   | Oct12 S3, naive comparisons and RCT | Lucas | done: recap of Session 2's -670, with-and-without (-1,638), the lottery and the RCT on the pilot; no clustering slide |
   | Oct13 S1, DiD | Fiona | done: four numbers from the city; parallel-trends failure is now visible in the data (the pilot's untreated businesses show the true trend) |
   | Oct13 S2, RDD | Lucas | done: cut-off at 58 in the city; Check 3 fails on manager age; remove "Module 1" facts box |
   | Oct13 S3, matching | Fiona | done (camera case replaced by two evaluators, A and B): match on age, staff, area, filtration; Check 1 = leave out manager age |
   | Oct14 S1, cost-benefit | Lucas | saving from the new DiD (-818); ratio barely moves |
   | Oct14 S2, charts | Fiona | GreenWaste charts redrawn from the new data |
   | Oct14 S3, QA clinic | Lucas | the analyst's reruns and "who is missing" slide |
   | Oct15 S1, report | Fiona | report rewritten for the pilot-and-city design and its planted flaws re-checked (or a different case, per the 2026-10-05 note) |
   | Oct12 S1, language | Lucas | done: traffic cameras replaced: the city-map introduction (first meeting with the case) and the five words practised on landfill |
   | Oct12 S2, reading an output | Fiona | done: traffic cameras replaced: the decision rule, meet the data, and the before-and-after number on costs (-670, short of the rule); compared to what? |
   | Oct15 S2, writing a brief | Lucas | Tariff Shield replaced: the brief is written from GreenWaste's own findings |
   | Oct15 S3, own designs | Fiona | one line (the GreenWaste ratio it quotes) |

4. **Print packs.** Point `make_session_materials.R` at the new file for the eight
   sessions above; regenerate packs, keys and participant copies.
5. **The lab** (`gw_lab.R`): true effect from -900 to about -1,020 so the invented
   world and the case agree; slider wording unchanged.
6. **Consistency check.** A script that fails if any deck, note, pack or handout
   still contains a retired word or an old number (-665, -1,447, -1,446, -816, -791,
   -905, -1,119, "Module 1 said").
7. **Verify.** Render all twelve decks, walk every slide with live cells run,
   check every pack in Word, then refresh the PDF and PowerPoint exports and the zip.
8. **Merge.** Fiona pauses edits to the eight affected decks while the branch is
   reviewed; then merge to `main` and publish.

## Open decisions

- Oct15 S1: keep a GreenWaste report rewritten for the new design, or use a fresh
  case as suggested on 2026-10-05.
- Timing: delivery starts 2026-10-12. If the branch is not reviewed by
  2026-10-09, deliver with `main` as it is and merge after the training.
