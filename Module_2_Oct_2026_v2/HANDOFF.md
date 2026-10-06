# Handoff: moving Module 2 to the simple GreenWaste case

## Day 3 approved and built on 6 October 2026

Lucas approved the Day 3 slide tables. Three active decks now have 11, 10 and 13 content screens, 60/60/75 minutes. One trainer calculation per session, no participant coding. Keep predictions before reveals and the clinic's five-minute break.

- `day3_case.R` shares all screen and paper values. The provisional benefit input is minus corrected city DiD, 812 AED. Causal limitations carry forward. The model assumes 1,800 AED one-off cost, no benefit in year 1, five saving years in years 2 to 6 and a 5% rate: benefits at today's value 3,350 AED, ratio 1.86. Cost, timing and duration are fictional assumptions.
- Fiona's five scenario cards and eight allocations 1,2,3,4,5,1,2,3 remain. Ratios 1.07/1.40/1.67/1.17/0.80; only the combined decay and hidden-cost scenario is below 1. A1 headline regenerated; prediction and result lanes retained.
- Chart session uses native axis toggle with identical values, ten-business landfill distribution, different percentage weights, pilot interval and caption repair. Total participant tonnes fall 49.5%; mean business percentage fall 58.6%. These descriptive changes do not establish cause. School-zone, pie-chart and repeated discount tasks are retired.
- Analyst clinic has five questions and a trainer-only fixed answer bank. It discloses missing earlier trends, fieldwork/attrition documents and score-manipulation evidence. Complete generated rows do not establish real data quality. The live pilot saving interval is 862 to 1,167 AED; endpoint names removed after negation so the output does not mislabel quantiles. Old neighbourhood lab is outside the main teaching route.
- `Rscript make_session_materials.R --day3` writes three two-sided participant sheets, trainer packs 9/3/5 pages, a one-page QA reference and the ratio A1 board. Print pages 3-7 plus 3-5 again for eight scenario groups. The optional QA desk reference uses the same five questions as the clinic. Historical `qa_checklist.R` remains for reference.
- Exercise brief now covers Days 1 to 3, 11 landscape pages. Day 4 rows are explicitly historical. Backups: `backups/day3_2026_10_06_approved/`. Live teaching pages unchanged.
- All three decks walked sequentially with actual trainer outputs and feedback open. Browser errors [] and no overflow; final heading/logo and enlarged SVG label checks passed. Native keyboard controls, both axis states and room poll regression passed. All print pages and A1 board rendered and inspected.

Review: https://3ie.academy/preview/day3_review.html
Next tables: https://3ie.academy/preview/day4_plan.html
The Day 4 proposal has two 60-minute sessions: independent report reading and the two-sheet credibility wall, then a brief based on corrected evidence. Build both only after Lucas approves the concrete tables. Former Day 4 S3 remains excluded for another provider's simulation.

Published checkpoint: Day 3 source and packs pushed in `2019e52` on `simple-greenwaste`; unlinked main previews pushed in `7120980`. Eighteen copied files were hash-verified; 18 Day 3 hub links and both Day 4 plan links resolve locally. The unauthenticated site check returned HTTP 403 this time, so online page content was not inspected.

Use the retained `.preview_day2_publish` main worktree for unlinked previews. The site password gate applies. Source and preview checkpoints below pre-date this Day 3 update. Venue phone reachability still needs rehearsal.


## Day 2 approved and built on 6 October 2026

Lucas approved Day 2, including the score-rule correction and refresh of affected Day 1 figures. The active three Day 2 decks now have 10, 10 and 13 content screens, 60/60/75 minutes. One trainer demonstration per session; no participant coding. Plain-language report reading, individual questions and evidence reveals replace the long model labs. No Menti or restored AI wall boards.

- `day2_case.R` supplies screen and paper values, using the corrected CSV. Exactly eight city rows at score 58 changed in participation, cost_after and landfill_after; pilot and other city rows are unchanged. City participation is now 4,794. Before/after -669; with/without -1,638; DiD -812 (95% interval -833 to -792); pilot -1,014 unchanged.
- Canonical RDD now uses `estimatr::lm_robust` with HC2, the intended original teaching interval. Two-point estimate -721 (95% interval -943 to -498); five-point -784; age-adjusted two-point -632. The eight corrected records are at the cut-off, so the local change is material. Do not use the former -656 or ordinary interval.
- Four-feature matching -1,029 (reported interval -1,200 to -859); without age -1,341. Every participant gets a nearest neighbour, with replacement, no caliper. 585 different controls, maximum reuse 440; manager-age gap remains 3.0 years. Do not claim perfect balance, no bias, or discarded participants. Interval clusters by original business and treats selected matches as given.
- Fiona's eight seeded RDD cards A-H and A1 number line are retained. Seven matching profiles retain original identifiers, age and size; separate cost slips are withheld until pairs are recorded. Optional walking retained. Toy unused business 4 is a comparison profile, not an excluded full-study participant.
- `make_day2_materials.R` and `--day2` write three two-sided participant sheets and trainer packs of 3/12/12 pages. `reader_material_helpers.R` shares print styling with Day 1. The full generator skips old Day 2 blocks; retained code is historical. The existing static RDD A1 line needs no numerical refresh.
- Day 1 data-derived decks and all six print files are refreshed. `Module2_exercise_plan_v3.docx` now covers Days 1 and 2; Days 3 and 4 rows are historical. Backups: `backups/day2_2026_10_06_approved/`.
- Review hub source: `review_2026_10_06/day2_review.qmd`. Next daily tables: `day3_plan.qmd`; build Day 3 after Lucas approves those tables. Scope remains eleven sessions; former Day 4 S3 is the other provider's simulation.

The optional `GreenWaste_case_brief.docx` was also refreshed: its older saved copy still described 6,000 city records. It now uses 10,000 city records and computed means, two A4 pages at 12 point. Rebuild with `Rscript make_case_brief.R --brief-only` (calls `refresh_case_brief.R`). Give it out after costs enter; the picture card remains the opening reference.

Validation: all six decks walked sequentially, live outputs checked, fragments and evidence opened. No browser errors or overflow after the DiD screen correction. Final native keyboard/reveal checks passed. Every Day 2 print page and refreshed Day 1 page was inspected through Word rendering; the brief is 14 pages. Room poll two-browser and phone-width regression passed. Main preview files were hash-verified and review hub relative links checked.

Review: https://3ie.academy/preview/day2_review.html
Next tables: https://3ie.academy/preview/day3_plan.html
The site password gate applies. The main preview worktree `.preview_day2_publish` is retained for reuse; avoid deleting the earlier ignored `.preview_publish` residue whose cleanup was rejected by automatic approval review. Live teaching pages are unchanged.

The previous Day 1 checkpoint and conversion notes below are historical where they refer to an unchanged CSV or a pending correction.

## Latest direction from Lucas (6 October 2026)

- Review and revise the whole programme for officials with little evaluation
  knowledge, prioritising proficient reading of evaluation reports. Shorten the
  sessions themselves, reduce technical explanation, improve the activity sheets
  and visuals, and replace Menti with a course-owned interaction.
- **Exclude our former Oct15 Session 3 from the rebuild.** Someone else will
  prepare an evaluation simulation for that slot. Retain its files as historical
  material; the remaining scope is eleven course-owned sessions.
- The other-branch check is complete: Fiona's activity changes (`786ee9c`) and
  A1 boards (`217858a`) are already merged into `simple-greenwaste`. Preserve
  claim triage, the RDD number line, matching cards, the ratio wall and the
  credibility grid. The exercise-plan document still needs reconciliation.
- Lucas approved the shortened timetable and Day 1 slide tables on 6 October.
  Days 1-3 are 60/60/75 minutes; Day 4 is 60/60. The Day 1 rebuild is complete:
  11, 11 and 13 content screens, with two-sided participant sheets, trainer keys
  and the existing four-claim cards and optional A1 triage board.
- Day 1 sources: `Oct12_session1_live.qmd`, `Oct12_session2.qmd`,
  `Oct12_session3_live.qmd`. S1 now uses ordinary revealjs and native browser
  interactions; S2 and S3 keep one trainer-run webR demonstration each. The
  active filenames and DGE branding are retained. No participant coding.
- `day1_case.R` supplies computed figures to screen and paper. Build Day 1 packs
  with `Rscript make_session_materials.R --day1`; the scoped path changes no
  other session's outputs. `make_day1_materials.R` writes participant sheets
  directly, keeping cards and keys out of participant copies. The full build
  skips the old Day 1 sections and former Oct15 S3; their code is retained.
- `room_poll.py` and `room_poll.html` replace Day 1 Menti: anonymous browser
  votes, Before/After phases, QR, hidden totals until close and private reasons.
  See `ROOM_POLL_README.md`. HTTP and two-browser checks passed, including
  320/375-pixel phones. Classroom Wi-Fi reachability still needs a venue test.
  Native choices in the deck record one page's choice, not aggregate votes.
- The three decks have been rendered and walked sequentially. Slide fit,
  revealed feedback, keyboard choices and both trainer outputs were checked.
  All participant sheets are two A4 pages; trainer packs are 4/3/3 pages.
  Word's native renderer was used after the packaged renderer reported missing
  LibreOffice. All print pages were inspected. Local QA is in the review folder.
- Backups are in `backups/day1_2026_10_06_approved/`, ignored by Git. The shared
  CSV is unchanged; the score-rounding correction below remains pending.
- `Module2_exercise_plan_v3.docx` now describes the Day 1 rebuild and shorter
  scope. The former Oct15 S3 section is removed. Later-day descriptions are
  explicitly historical pending their daily rebuild, including old Menti rows.
- The whole-week review is `review_2026_10_06/week_review.qmd`. The next concrete
  Day 2 slide tables are in `review_2026_10_06/day2_plan.qmd`, pending review.
  Day 1 previews are refreshed under the existing unlinked `docs/preview/`
  workflow; live teaching pages and the landing page are unchanged.

Published checkpoint: Day 1 source and packs were pushed in `8a7973d` on
`simple-greenwaste`. Unlinked preview files were pushed in `d3fdbfd` on `main`.
Review hub: https://3ie.academy/preview/day1_review.html
Next tables: https://3ie.academy/preview/day2_plan.html
The normal site password gate returns 401 to unauthenticated checks; the local
preview files and all fifteen links in the review hub were verified before push.
The source CSV, other days' outputs and live teaching-page URLs are unchanged.

The state and conversion notes below describe the earlier plan. The latest
scope direction above supersedes references to rebuilding Oct15 Session 3.

State on 2026-10-06, end of session. Read this first, then `SIMPLE_GREENWASTE_PLAN.md`
(the plan Lucas approved) and the memory files. Delivery starts **2026-10-12**; if the
branch is not reviewed by **2026-10-09**, deliver with `main` and merge after.

## Where things stand

| Day | Decks | Status |
|---|---|---|
| Day 1 (Oct12) | `Oct12_session1_live.qmd`, `Oct12_session2.qmd`, `Oct12_session3_live.qmd` | converted, approved by Lucas |
| Day 2 (Oct13) | `Oct13_session1.qmd`, `Oct13_session2_live.qmd`, `Oct13_session3.qmd` | converted, **waiting for Lucas's review** |
| Day 3 (Oct14) | `Oct14_session1*`, `Oct14_session2*`, `Oct14_session3_live.qmd` | not started; next once Lucas says "build day 3" |
| Day 4 (Oct15) | `Oct15_session1*`, `Oct15_session2*`, `Oct15_session3*` | not started |

- Work branch: `simple-greenwaste` (last commit `bf6a960`, pushed). `main` is untouched
  apart from previews.
- Previews: copied by hand to `docs/preview/` **on main** (last commit `2d39536`), served
  at `https://3ie.academy/preview/<file>` behind the site password. Day 1 and Day 2 decks,
  packs, the case card, the brief, the CSV and `gw_lab.R` are there. The previews are not
  linked from the landing page.
- Lucas works in daily batches: for each day, propose one plan table (slide by slide),
  wait for approval, build, publish previews, report the links.

## Score-rule correction resolved

Approved and completed with Day 2. Use the latest checkpoint above for current figures.

## The case and its numbers

- Data: `evaluation_data_GreenWaste_simple.csv` (from `make_greenwaste_simple.R`, seed
  2026). 10,400 rows: a pilot district of 400 (scores 20–58, half chosen by lottery)
  and 10,000 city businesses (`took_part` = score of 58 or below). Columns: business,
  setting, score, took_part, cost_before, cost_after, landfill_before, landfill_after,
  manager_age, staff, area, filtration.
- `greenwaste_case.R` computes every headline number once. Decks source it **into
  their own environment**, because decks use `RULE` as a colour:
  `case_env <- new.env(); case_env$gw <- read.csv("./evaluation_data_GreenWaste_simple.csv"); sys.source("greenwaste_case.R", envir = case_env)`.
  The pack script does the same with `s1_env` … `s6_env`.
- Headline numbers (city unless stated): before and after −670; with and without −1,639
  (gap before −825); lottery in the pilot (RCT) −1,014 (CI −1,167 to −862); DiD −813;
  the pilot's waiting businesses rose 372 against 144 for the city's non-participants
  (DiD with them as comparison −1,042); RDD ±2 −656 (CI −881 to −430), −554 adjusted for
  manager age, ±5 −755; manager age jumps about −5 years at 58; matching on manager age,
  staff, area, filtration −1,031; without manager age −1,342. 4,786 took part.
- Never type a number in a deck or pack: compute it with inline R or `sprintf()`.

## Conventions used in the conversion

- City map: `_case_map.qmd`, included with `{{< include _case_map.qmd >}}` as the first
  content slide of Day 2+ decks ("The GreenWaste case", with a one-minute note). Day 1
  decks have the map inline. Keep the same picture as `GreenWaste_case_card.docx`.
- Live decks: hidden autorun `{webr}` setup cell under the first section heading;
  `webr: resources:` (Lucas's decks) or top-level `resources:` (Fiona's) must list
  `evaluation_data_GreenWaste_simple.csv` and `gw_lab.R`.
- Raw HTML with numbers: inline `` `r ` `` does **not** work inside a ```` ```{=html} ````
  block. Use an R chunk with `results='asis'` and `cat(sprintf(...))` (or `html_out()`).
- Matching uses nearest neighbour on standardised characteristics (as in
  `greenwaste_case.R`), not a propensity score: propensity matching fails on this data.
- Vocabulary: "took part / did not take part", "efficiency score", "the rest of the
  city", "the pilot district", "the lottery". Retire: enrolled, neighbourhood,
  round 0/1, efficiency index, offered, Module 1, traffic cameras, school zones,
  Tariff Shield, and old numbers (−665, −816, −791, −1,447, −905, −1,119).
- Writing style: `memory/slide-writing-style.md` (Fiona's list: no "not X but Y", no
  em dashes, no inflated words, no forced triads, no author notes). Every `.ask` box
  is a question; predictions come before every Run.

## How to build a day

1. Read each deck in full; propose the plan table to Lucas; wait for approval.
2. Edit the deck (Python string replacement with `assert count == 1` worked well;
   back up the original to the scratchpad first). Fiona's decks may be edited on the
   branch because Lucas approved the conversion.
3. Convert that session's section of `make_session_materials.R` (sections are headed
   `# Oct14 S1 · …` etc.; use a new `sN_env`). Note: `estimatr` loads at about line 758,
   so code above that must call `estimatr::lm_robust`.
4. Render: `quarto render <deck>.qmd` from `Module_2_Oct_2026_v2`.
5. Walk: serve the folder (`python -m http.server 8766` in `Module_2_Oct_2026_v2`),
   then `node export_tools/walk_check.js http://localhost:8766/<deck>.html <outdir>`
   (needs Node with Playwright; 40 s initial wait, 16 s per run cell; screenshots go
   to `<outdir>`). Check `over=` is 2 or less and live outputs are not empty. Walk
   decks **one at a time**: parallel walks starve the data download. `over` on a
   slide with a plotly animation is a false alarm (parked off-axis point).
6. Packs: `"/c/Program Files/R/R-4.4.1/bin/Rscript.exe" make_session_materials.R`
   (Rscript is not on PATH; takes about 10 minutes; do not edit the script while it
   runs). It rewrites all twelve packs, four A1 boards and `docs/handouts/`. Then
   restore every pack, board and handout of sessions **not** converted that day with
   `git checkout HEAD -- <files>`: table widths differ between machines, and Fiona's
   committed files must stay as they are.
7. Commit on `simple-greenwaste` with the trailer
   `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`; push.
8. Preview: copy the rendered HTML (HTML is git-ignored in the module folder), packs
   and boards to a temp folder, `git checkout main`, copy into `docs/preview/`, commit,
   push, `git checkout simple-greenwaste`. Run `git fetch` first and check whether
   Fiona has pushed to main.

## Day 3 and Day 4 plan (from the approved plan; propose details to Lucas)

- **Oct14 S1, cost-benefit (Lucas):** saving from the new DiD (−813 instead of −818);
  the ratio wall poster headline (about 1.87) will move slightly; regenerate its A1 board.
- **Oct14 S2, charts (Fiona):** school-zone data removed; GreenWaste charts redrawn
  from the new data.
- **Oct14 S3, QA clinic (Lucas):** the analyst's reruns and the "who is missing" slide.
- **Oct15 S1, report (Fiona):** report rewritten for the pilot-and-city design, planted
  flaws re-checked (open decision: or a fresh case). Has an A1 board.
- **Oct15 S2, writing a brief (Lucas):** Tariff Shield replaced by a GreenWaste brief.
- **Oct15 S3, own designs (Fiona):** one line (the ratio it quotes).

## After Day 4

- `gw_lab.R`: true effect −900 → about −1,020; update the lab notes in every deck
  (Oct13 S1/S2/S3 notes still say −900).
- Consistency-check script: fail on any retired word or old number in decks, notes,
  packs and handouts.
- Known overflow in Fiona's Oct13 S1 (existed before): "AI Snapshot" (16 px) and "The
  same question, a better prompt" (25 px).
- Refresh PDF/PPTX exports (`export_tools/README.md`) and the materials zip.
- Merge `simple-greenwaste` into `main`, publish, remove `docs/preview/`.

## Site and access (parked unless Lucas raises them)

- 3ie.academy: Cloudflare Worker `module2` serving `docs/` with a password gate
  (`functions/_middleware.js`, `src/worker.js`, `wrangler.jsonc`). The password is a
  Cloudflare secret; never ask for it or put it in the repo.
- Parked: in-slide polls to replace Menti (needs a Firebase config), sempe.dev redirect,
  making the repo private and turning off GitHub Pages (tell Fiona first).

## Rules that bind every session

- Organisation rules: no deleting or overwriting outputs without permission; save a
  versioned copy before substantial in-place edits unless approved; no paid API calls
  without telling Lucas the cost; nothing outside this folder without permission.
- If a delete is denied, give Lucas the command instead of working around it.
- Avoid running parallel subagents: the org spend limit has cut one off before.
