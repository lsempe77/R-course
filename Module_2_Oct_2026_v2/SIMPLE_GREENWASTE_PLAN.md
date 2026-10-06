# Simple GreenWaste: what is being done and what is next

Status 2026-10-06. Owner: Lucas, agreed with Fiona. Work happens on the branch
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

## The new case, in one sentence

GreenWaste helps businesses cut their waste costs. In the **pilot district** a
lottery chose which businesses joined; in **the rest of the city** every business
with an efficiency score of 58 or below joined.

## The data (done)

`evaluation_data_GreenWaste_simple.csv`, written by `make_greenwaste_simple.R`.
Invented, one row per business, ten columns, no other file needed:

| Column | Meaning |
|---|---|
| `business` | identifier |
| `setting` | `pilot` (400 businesses, all scoring 58 or below, lottery) or `city` (6,000 businesses, every score, rule at 58) |
| `score` | efficiency score, 0 to 100, higher is more efficient |
| `took_part` | 1 if the business took part |
| `cost_before`, `cost_after` | waste-management costs in AED, before and 12 months after |
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

Current headline numbers (computed by `greenwaste_case.R`; decks and handouts must
quote the objects in that file, never type the numbers):

| Estimate | Value |
|---|---|
| Before and after | -670 |
| With and without | -1,503 (took part started 685 AED cheaper) |
| Randomised (pilot) | -1,014, 95% CI -1,086 to -941 (spans the 1,000 rule) |
| Difference-in-differences | -818 |
| RDD, +/-2 points | -820 (CI -949 to -691); -675 adjusted for manager age |
| RDD, +/-5 points | -784 |
| Matching, all four | -1,058; without manager age -1,361 |
| Manager age just below 58 | 5.1 years younger |

## Done so far

| Item | File | Where to see it |
|---|---|---|
| Data generator and data | `make_greenwaste_simple.R`, `evaluation_data_GreenWaste_simple.csv` | repo |
| Every headline number, computed once | `greenwaste_case.R` | repo |
| Case introduction: one city map, pilot district inside it, shops with their scores | `greenwaste_case_intro.qmd` | sempe.dev/R-course/greenwaste_case_intro.html (unlinked preview) |
| Detailed case brief (draft) | `make_case_brief.R` -> `GreenWaste_case_brief.docx` | docs/handouts (unlinked) |

None of the twelve session decks uses the new data yet.

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
   | Oct12 S3, naive comparisons and RCT | Lucas | biggest rework: new opening, "two numbers someone might report", RCT on the pilot, drop the neighbourhood-clustering slide, lottery sliders on the pilot |
   | Oct13 S1, DiD | Fiona | four numbers from the city; parallel-trends failure is now visible in the data (the pilot's untreated businesses show the true trend) |
   | Oct13 S2, RDD | Lucas | cut-off at 58 in the city; Check 3 fails on manager age; remove "Module 1" facts box |
   | Oct13 S3, matching | Fiona | match on age, staff, area, filtration; Check 1 = leave out manager age |
   | Oct14 S1, cost-benefit | Lucas | saving from the new DiD (-818); ratio barely moves |
   | Oct14 S2, charts | Fiona | GreenWaste charts redrawn from the new data |
   | Oct14 S3, QA clinic | Lucas | the analyst's reruns and "who is missing" slide |
   | Oct15 S1, report | Fiona | report rewritten for the pilot-and-city design and its planted flaws re-checked (or a different case, per the 2026-10-05 note) |
   | Oct12 S1, Oct12 S2, Oct15 S2, Oct15 S3 | | no change (other cases or participants' own designs) |

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
