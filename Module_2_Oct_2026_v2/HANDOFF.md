# Handoff: moving Module 2 to the simple GreenWaste case

## Separate Day 3 Session 1 comparison prototype, 7 October 2026

Lucas requested continuation with the separate-review approach. `Oct14_session1_review.qmd` supplies 16 content screens and a 90-minute facilitator script. The original `Oct14_session1_live.qmd`, current handouts, production builder and live teaching route remain unchanged. `Oct14_session1_current_compare.html` freshly renders the original; `day3_session1_compare.html` aligns fourteen related topics.

The sequence distinguishes the provisional city DiD benefit from assumed economic inputs, restores the year 0-6 cash-flow timeline, works one-year versus year-two discounting, then reads present-value benefits, ratio and NPV. It explicitly identifies the mixed-actor cost boundary rather than claiming a complete authority-budget or social appraisal. The five existing scenarios and eight-group allocation 1,2,3,4,5,1,2,3 are preserved. Ranking the single-input settings is conditional on those specified changes, not a universal sensitivity claim.

Canonical model: unrounded saving 812.445811 AED; equipment delivery cost 1,800 AED at year 0; no year-1 benefit; five equal saving years 2-6; 5% rate. Present-value benefits 3,349.966843 AED, ratio 1.861093 and NPV 1,549.966843 AED per participant. Scenario ratios 1.07/1.40/1.67/1.17/0.80; only combined decay-and-extra-cost Card 5 is below 1. A 40% rate gives 0.66, while three extra years of delay at 5% gives 1.61. Those checks do not establish realistic settings or applicable discount-rate guidance.

`Oct14_session1_review_worksheet.qmd` has six printable pages: H7-A numbered model note, cash-flow/output reference, input/calculation/boundary worksheet, scenario/judgement worksheet, 15-minute two-stage Copilot Snapshot and prepared paper alternative. The AI tasks adapt the older scenario-breaking/ranking prompts while correcting the obsolete claim that the cost is measured. `Oct14_session1_review_cards.qmd` has five scenario pages, a two-lane board and a separate Table S result key on page 7. Hold that key until predictions are recorded; the worksheet reference pages do not reveal scenario ratios before the activity. After reveal, Table S supplements the model source for the AI prompt. Keys and transitions otherwise remain in slide notes.

Validation: 17 title/content screens, expanded scenario results and executed trainer R fit 1280x720 with no heading/logo collisions or browser page errors. Trainer Run gives ratio 1.86 and NPV 1549.97 AED. Fourteen paired-topic controls and the 375px comparison layout pass. All six worksheet pages fit A4 at 14mm margins (largest 995px of 1,017px). Card pages fit A4 at 16mm margins. Numeric assertions verify cash-flow totals, scenario thresholds, allocation and 90-minute timing. Selected slides, source pages, live output and the withheld key were visually inspected. Browser checks explicitly verify that the scenario result table occurs only on cards page 7.

Render the three new QMDs in the module directory, and the unchanged original with `--output Oct14_session1_current_compare.html`. Five independent HTMLs are copied to `docs/preview/`, with matching file hashes, valid comparison links and the correct browser CSV. On 8 October Lucas requested committing and pushing this bundle to `main`, where the existing Cloudflare build deploys the preview paths. Published teaching routes are not replaced. This review candidate does not mark production-plan revisions complete.

## Separate Day 2 Session 3 comparison prototype, 7 October 2026

Lucas confirmed the separate-review approach for matching. `Oct13_session3_review.qmd` supplies 17 content screens and a 120-minute facilitator script. The original `Oct13_session3.qmd`, existing materials, production builders and live teaching routes remain unchanged. The current source is freshly rendered as `Oct13_session3_current_compare.html`; `day2_session3_compare.html` aligns thirteen related topics across both versions.

The seven invented profiles and separately withheld cost slips preserve Fiona's A2/B1/C3 pairing, unused comparison 4 and -1,000 AED toy mean. `Oct13_session3_review_cards.qmd` prints profiles and costs on separate pages. The full study is explicitly different: four standardised pre-programme features, nearest neighbour with replacement, no caliper or participant exclusions. Reuse, measured balance, actual marginal age overlap, hypothetical poor support, age omission and unrecorded motivation are explained separately.

Computed four-feature result: -1,029 AED, business-clustered robust interval -1,200 to -859, 4,794 participants and 585 unique controls; maximum reuse 440. The residual age and before-cost gaps are 2.97 years and 161 AED. Omitting age gives -1,341 AED, interval -1,420 to -1,263, 623 unique controls, age gap 17.12 years and before-cost gap 540 AED. The interval treats matches as given, does not fully account for match selection and does not include all bias. The four-feature reduction interval crosses the fictional 1,000 AED saving rule.

`Oct13_session3_review_worksheet.qmd` has six printable pages: H6-A numbered study extract with Table R, actual balance Table B and visual references, pairing/result worksheet, credibility/judgement worksheet, two-stage 15-minute Copilot Snapshot and prepared paper alternative. Exact page/task references appear in slides. The within-session break is replaced by a physical change of activity; the daily wrap-up/buffer remains separate. `day2_session3_review.R` supplies data and visuals; scoped CSS reuses the earlier review styles.

Validation: all 18 title/content screens fit 1280x720; arithmetic reveal and all thirteen comparison controls work. Trainer Run returned -1029. No browser page errors; comparison layout fits 375px. Six worksheet panels fit A4 at 14mm margins (largest 879px of 1,017px); both cards panels fit A4 at 16mm margins (largest 855px of 1,002px). Selected slide, executed R, source-page and card screenshots were visually inspected. R assertions verify counts, reuse, rule crossing, card arithmetic and 120-minute timing. The integrated browser timed out; standalone installed Playwright completed these checks instead.

Render the three new QMDs in the module directory and the unchanged original with `--output Oct13_session3_current_compare.html`. The five independent HTMLs are copied to `docs/preview/`. On 8 October Lucas requested committing and pushing this bundle to `main`, where the existing Cloudflare build deploys the preview paths. Published teaching routes are not replaced. This candidate does not mark production-plan revisions complete.

## Separate Day 2 Session 1 comparison prototype, 7 October 2026

Lucas asked to continue with Session 4 (Day 2 Session 1) using the separate-review approach. `Oct13_session1_review.qmd` contains 14 content screens and 90 minutes in facilitator notes. The original `Oct13_session1.qmd`, existing handout, builders and teaching route remain unchanged. Current source is freshly rendered as `Oct13_session1_current_compare.html`. Review comparison: https://3ie.academy/preview/day2_session1_compare.html.

The sequence links city context, observed changes, Fiona's four-number arithmetic, one commented trainer R calculation, the four-row regression table, assumed untreated path, competing changes, hypothetical earlier histories, actual data limits, the saving rule, source reading and the two-stage AI Snapshot. Native controls reveal arithmetic and feedback, highlight regression columns and toggle the dashed assumed path. It is a local classroom demonstration, not a shared room poll.

All figures are recalculated from the corrected city CSV. Participant mean costs are 1,432/763 AED, other businesses 2,258/2,401; changes are -669/+143 and the extra change is -812. Business-clustered robust regression interval is -833 to -792, or reduction 792-833. Under parallel trends the assumed untreated participant after-cost is 1,575. The dashed path is not observed data. A/B histories are explicitly hypothetical and share axes. The actual file has only one before and one after wave and cannot show earlier trends. Precision does not establish causal validity; estimate and interval are below the fictional 1,000 AED annual-saving minimum. The separate pilot is not the city's true counterfactual.

`Oct13_session1_review_worksheet.qmd` supplies six printable pages: named H4-A four-paragraph city study extract with full regression, visual reference, Q1 arithmetic/blank chart and Q2 regression interpretation, Q3 assumptions/evidence and Q4 rule plus independent reading, realistic AI response/better prompt, and prepared paper alternative. Slide references identify exact physical pages. Participants complete the worksheet as concepts are taught. The Copilot Snapshot totals 15 minutes and reuses the shared AI good-practice card. Facilitation keys and transitions remain in slide notes.

Render review and worksheet in the module directory. `day2_session1_review.R` supplies calculations and native SVGs; scoped CSS and interaction include supplement the existing review styles. `review_2026_10_06/build_day2_session1_review.py` assembles only this review's worksheet and comparison hub. Publish four independent HTMLs under `docs/preview/`; this candidate does not mark production-plan revisions complete.

Validation: all 15 title/content screens and expanded states fit 1280x720 without heading/logo collisions or browser errors. Regression column controls, arithmetic/feedback reveals, assumed-path toggle and every paired-topic comparison pass; phone comparison layout fits. Trainer Run executed and returned -812, with no editor clipping or output overflow. Independently checked CSV counts (4,794/5,206), changes and assumed 1,575. All six worksheet panels fit A4 at 14mm margins (largest 795px of 1,016px available). Final figures, table, trainer box, source extract, writing space and AI pages visually inspected. Four preview copies match tested renders byte-for-byte, local links and browser CSV match, and every file is below 25 MiB.

## Separate Session 3 comparison prototype, 7 October 2026

Lucas asked to continue Day 1 with Session 3 using separate review QMDs and both renders. `Oct12_session3_review.qmd` implements D1S3-P01-P16: 16 content screens and 120 minutes in facilitator notes. `Oct12_session3_live.qmd`, existing handouts and the live teaching route remain unchanged. Current source is freshly rendered as `Oct12_session3_current_compare.html`. Review comparison: https://3ie.academy/preview/session3_compare.html.

The city comparisons are a brief recap. The pilot has 400 eligible businesses (all scores 58 or below), individually assigned exactly 200 to join and 200 to wait. Native figures cover allocation, chance age imbalance, actual baseline distributions, after-group means, regression columns and the saving interval against the rule. Baseline means are 1,390/1,411 AED; after means 769/1,783; the fitted effect is -1,014 with interval -1,167 to -862, or saving 1,014 with interval 862-1,167. The pilot is not labelled ground truth for the city. Random assignment is distinguished from representative sampling; full costs and national effects are not supplied.

Physical activity uses twenty cuttable numbered manager-age slips (`Oct12_session3_review_slips.qmd`) from the first twenty actual pilot records. Draw ten, compare join/wait means, replace all and redraw. Optional webR uses the same age pool, with a new fixed seed per Run. It demonstrates pre-programme age balance, not an effect or the actual trial allocation. First two trainer draws should give Join/Wait 35.2/35.6 and 36.8/34.0. The larger-sample visual uses the full pilot age pool: 200 practice allocations per size, N=20 random subsets versus N=400; every redraw is labelled illustrative.

`Oct12_session3_review_worksheet.qmd` supplies six printable pages: named H3-A design/baseline, findings/interval/three-comparison reference, Q1-Q2, Q3-Q5 and independent recommendation, realistic ministerial AI markup/better prompt, and prepared paper alternative. Exact source paragraphs and physical page locations are repeated in slides. AI Snapshot totals 15 minutes, uses Microsoft Copilot and the shared good-practice card. The obsolete internal break is replaced by a physical change of activity within the fixed timetable. Daily wrap-up/buffer remains separate.

Render the three new QMDs in the module directory. Values and native SVGs come from `session3_review.R`; scoped styles supplement `session1_review.css`. Publish independent renders only under `docs/preview/`; no production builder changes. This remains a content-review candidate, not replacement of the original session.

Validation: all 17 title/content screens, reveals and larger-sample variants fit 1280x720; no heading/logo collisions or browser errors. Native table highlights and decisions work. Trainer Run executed twice and returned the expected different Join/Wait age means; editor has no horizontal clipping and output fits. Topic comparison controls and phone layout pass. All six worksheets fit A4 at 14mm margins (largest panel 860px of 1,016px available), and the 20 cuttable age slips fit one page. Final slide montages, executed R, source pages, writing space, AI tasks and slips visually inspected. Source labels are consistent. Five preview copies match the tested renders byte-for-byte and are below 25 MiB; links and browser CSV checked.

## Separate Session 2 comparison prototype, 7 October 2026

Lucas asked to continue the separate-review approach with Day 1 Session 2. `Oct12_session2_review.qmd` implements the master plan's D1S2-P01-P15 sequence: 15 content screens and a 90-minute facilitator script. `Oct12_session2.qmd`, the existing DOCX/cards/A1 board and live Session 2 route are unchanged. The current source is freshly rendered as `Oct12_session2_current_compare.html`.

The prototype uses annual waste cost AED throughout: actual city records and sample counts, baseline histogram, individual-change histogram, same-group before/after, other-group change and after-only gap. It distinguishes -669 recorded participant change from -1,638 after-only gap, and never treats the other group as an automatically valid counterfactual or teaches an unexplained DiD result. All source values and figures are computed by `session2_review.R` from the corrected CSV. Participant costs rose in 485 records, were unchanged in one, and fell in 4,308. Full-city baseline mean is 1,862 AED, median 1,801; 250 AED histogram bins.

Separate review materials: `Oct12_session2_review_worksheet.qmd` (six printable pages, including named sources and the prepared AI alternative), `Oct12_session2_review_cards.qmd` (four cost claim cards and a printable/local interactive triage board). Existing A1 activity remains available; the native board is local to an open browser page, not a shared room poll. The two-stage Copilot Snapshot totals 15 minutes and reuses the Session 1 AI good-practice card. Facilitator keys and transitions are in slide notes.

`session2_compare.html` maps related topics across both rendered decks and links worksheet, cards/board, AI card and QMD. Review URL: https://3ie.academy/preview/session2_compare.html. Render each of the three new QMDs in the module directory; render the unchanged source with `quarto render Oct12_session2.qmd --output Oct12_session2_current_compare.html`. Scoped `session2_review.css` supplements the existing separate-review type scale. Publish only the independent HTMLs under `docs/preview/`. Production builders and live teaching routes are not changed; this remains a review candidate.

Validation: all 16 title/content screens and revealed states fit 1280x720 with no heading/logo collision or browser errors. Topic controls target both versions, and the comparison hub fits a 375px phone. All six worksheet pages fit A4 with 14mm margins (largest final panel 968px of 1,016px available); four cards and board fit A4 with 16mm margins. Board placements move correctly between cells. Data checks independently confirm counts, changes, after-only gap and 485 rising participant records. Final slide montages, code box, worksheet pages and board inspected. Five preview artifacts are hash-identical to the reviewed local renders, with valid local links and all below 25 MiB.

## Separate Session 1 comparison prototype, 7 October 2026

Lucas requested implementation of the first session in a separate QMD, with both versions rendered for comparison. `Oct12_session1_review.qmd` is the proposed 17-content-slide/90-minute version; `Oct12_session1_live.qmd` is unchanged. A fresh comparison render of the current source includes Fiona's two opening additions, rather than the older published deck. The live Session 1 route and its existing print files are not replaced.

`session1_compare.html` links both renders and switches them to corresponding topics. Review preview: `docs/preview/session1_compare.html`. The proposed source is `Oct12_session1_review.qmd`, with `session1_review.R`, scoped `session1_review.css` and `_session1_review_interactions.html`. Render in the module directory with `quarto render Oct12_session1_review.qmd`; render current source separately with `quarto render Oct12_session1_live.qmd --output Oct12_session1_current_compare.html`.

The companion `Oct12_session1_review_worksheet.qmd` renders four printable HTML pages: source and Q1-Q3, uncertainty/Q4-Q6 and independent interpretation, realistic AI task with better prompt, and a prepared paper comparison response. This is a separate review worksheet, not a replacement of the existing DOCX. Q2 treatment effect/Q3 coefficient follow delivery order. Cost-example IDs are real selected city participants; total 13,906 AED, mean 1,390.6, median 1,150; excluding 4,306 gives mean 1,066.7 and median 1,100. This teaching selection is not representative.

The prototype retains the case/ToC introduction, adds actual cost mean/median and outlier interaction, counterfactual explanation, annotated regression columns, worked optional R, interval/coverage and precision visuals, coherent hypothetical p-value examples, pair correction and two-stage realistic AI exercise. Notes are facilitator scripts with worksheet IDs, expected answers, transitions and timings totaling 90 minutes. Do not run the production builders to generate this prototype: it is intentionally independent for comparison. It awaits content review before replacing any teaching route.

Fiona's latest plan update (`044af55`) is incorporated: the two-stage Snapshot uses Microsoft Copilot, totals 15 minutes, and points to a separate one-page `AI_good_practice_review.qmd` card for use throughout the week. The comparison hub links its printable HTML. The prototype does not mark production revisions as complete. Browser verification covers all 18 screens, expanded feedback, visual toggles, table-column controls, topic matching and phone layout; trainer R returns -669. The four worksheet pages fit A4 at the intended margins. Publication is limited to independent files under `docs/preview/`; comparison URL: https://3ie.academy/preview/session1_compare.html.

## Reader-facing headings rewritten, 6 October 2026

The landing day themes, eleven session titles and card descriptions, deck subtitles and 122 content-slide headings now pose concrete questions or decisions. Examples: What do the numbers actually say?; Good news. Enough to act?; How similar is similar enough?; What should the director do next? Named technical terms remain in subtitles, explanations and the five-term opening lesson. Day themes: Good news needs good questions; Compared with what?; Would you approve it?; Make the call. Show the evidence.

`review_2026_10_06/reader_titles.json` is the shared catalog. `reader_titles.py` applies it to deck metadata and headings; all four builders and the hub generator use it. Twelve deck sources, including the Day 4 alias, reproduced exactly in an isolated build. Compared with backups/reader_titles_2026_10_06/, teaching bodies, calculations and speaker notes are unchanged. Printed worksheet headings remain direct activity instructions; session numbers link them to the renamed decks. The current daily and whole-week reviews use the new session names. Landing durations remain removed and facilitator preparation stays in the collapsed trainer area.

`verify_reader_titles.py` checked all 133 title/content screens across eleven decks, with fragments and feedback open and all eight visible trainer calculations executed. Browser errors empty; no slide overflow or heading/logo collisions. Title pages and dense screens visually inspected. The pilot heading explicitly calls 1,014 AED an estimate. Hub checks passed all 49 links, keyboard filters and four phone/desktop widths. Updated preview, live-root bytes and deck archives are hash-verified, below 25 MiB.

## Client-facing landing copy, 6 October 2026

Facilitator preparation belongs in the collapsed trainer section. The Before teaching paragraph, presenter-note shortcut and trainer calculation setup instructions now sit there. The main-page slide guide contains only navigation and evidence controls. The hub generator preserves this placement. Pre-change copies: backups/landing_trainer_copy_2026_10_06/.

## Landing page durations removed, 6 October 2026

Lucas requested no timings in the landing page session boxes or day summaries. The live hub now shows session numbers and counts without durations, including every day-filter state. Actual teaching timings remain in the course sources and trainer materials. The hub generator preserves this change on future builds. Pre-change hub and generator copies: backups/landing_no_times_2026_10_06/. Existing link, keyboard and responsive-layout checks cover the revised page.

## Trainer R boxes improved, 6 October 2026

All eight visible trainer calculations now include short plain-language comments explaining their comparison, units and output. Shared styles use 22px code, clear comments, a framed editor and a "Trainer calculation - R" header. The duplicate echoed source underneath is hidden; results remain visible. The lottery demonstration now uses the full slide width. Participant coding and session durations are unchanged.

`review_2026_10_06/trainer_code.py` annotates visible cells in all four deck builders, preserving hidden setup code. All twelve generated QMDs, including the Day 4 alias, reproduced exactly in an isolated build; the final Day 1 layout was rechecked. `verify_trainer_boxes.py` ran all eight calculations and checked comments, header, font, duplicate echo, slide overflow and editor clipping. All passed: editor overflow zero, browser errors empty; results -669 / -812 / -721 / -1029 / 1.86 / 49.5 and pilot interval 862 to 1167 unchanged. Every calculation screenshot inspected. Hub verification: 49 local links, 53 byte-checked copies, phone and desktop layouts passed. Current downloads regenerated. Pre-change sources retained in backups/trainer_code_2026_10_06/.

The preceding Day 1 order and notice changes were published at 09d6559; Cloudflare and GitHub Pages deployment checks succeeded. This update continues the same authorised live publication route.

## Day 1 order and case notice corrected, 6 October 2026

Lucas requested the first two Day 1 sessions exchange places and explicitly teach the five core terms before regression-table reading. Session 1 is now **Read a regression table**: mean, treatment effect, coefficient, confidence interval and p-value; a two-row actual regression distinguishes the starting mean (1,432 AED) from the observed change (-669 AED). The fifth term recovered from the original lesson is treatment effect. A coefficient is not automatically a programme effect. Preserve ten minutes for independent reading, paired checking and feedback. Session 2 is **Question a claim**, applying the vocabulary to Fiona's four claim cards. Both remain 60 minutes; Day 1 S3 stays 75. Session 1/2 each have 11 content screens, two participant pages and four trainer pages. The classroom brief and hub match the order. The optional triage poster retains its legacy Oct12_session1 filename but is used in Session 2.

Generic fictional-case stamps are removed from slide content, plots and tables. Shared title-slide notice reads "GreenWaste is a fictional training case." exactly once per deck, 19px Noto Sans, regular grey; paper notices use Arial 9 grey. The four-page deliberately flawed report states its status on its first page. Keep substantive fictional-assumption and teaching-record labels where needed for interpretation.

Both revised decks were walked with feedback open: no browser errors or overflow, trainer Run reproduced -669, keyboard choices/reveals passed. All eleven title notices have identical computed styles and fit. Updated print pages and all nine classroom-brief pages rendered in Word and visually inspected. Three download archives regenerated with byte checks; all remain under 25 MiB. Existing backups in backups/case_notice_2026_10_06/ retain pre-change sources and materials. The latest source replaces the earlier Day 1 lesson; historical notes below are superseded.

## Live publication authorised, 6 October 2026

Live checkpoint `0a0a03d` pushed to main and simple-greenwaste. Cloudflare `Workers Builds: module2` completed successfully; GitHub Pages build and deploy also succeeded. The revised hub is https://3ie.academy/ with all eleven live decks and their materials. Main-worktree checks confirmed all 49 hub links and byte identity for the eleven decks plus corrected CSV. Remote unauthenticated requests returned 403 and no authenticated browser was available, so online page content was not inspected. This deployment record is saved on the source branch after publication.

Lucas requested a revised internal landing page and explicitly instructed us to push the whole rebuilt week live. This supersedes earlier preview-only restrictions. `docs/index.html` is now a working course hub with day filters, eleven session cards, worksheets, three downloads and a collapsible trainer area. The existing password gate is unchanged; no public-facing launch or access changes are requested.

`review_2026_10_06/publish_live.py` promotes checked preview bytes into the live deck URLs, `docs/handouts/`, `docs/trainer/`, `docs/posters/` and `docs/downloads/`. It also copies the corrected CSV next to the live decks, retains old aliases as redirects and replaces Oct15 S3 with an other-provider simulation notice. The old landing page linked stale PDF/PPTX snapshots; those links are omitted from the current hub. Old snapshot files remain historical and should not be advertised until refreshed.

Versioned pre-publication copies: `backups/live_2026_10_06/`. Fifty-three promotion copies hash-verified. Landing checks: 49 links served HTTP 200 locally, eleven cards, keyboard filters, day-hash reload and trainer disclosure, 1280/768/375/320 widths with no horizontal overflow or browser errors. All static assets below 25 MiB. Earlier deck/print walks remain applicable because the promoted bytes match their checked previews. Trainer calculation smoke check runs from the live root with the corrected CSV.

Source and preview histories are reconciled before the live push. Retain previews as build-review history; the live root is now the current delivery route. Do not remove the password gate or retry the previously rejected worktree cleanup.


## Current checkpoint: all eleven sessions built, 6 October 2026

Lucas approved Day 4. All four daily rebuilds are complete. The historical notes below are superseded where they describe pending approval, twelve sessions, old figures or retired teaching tasks.

- Day 4: two 60-minute sessions, 11 and 9 content screens, no participant coding or new model lab. Former Oct15 S3 remains excluded for the other provider's simulation; retain its historical files.
- `day4_case.R` supplies the intentionally flawed fictional report, section keys, corrected writing evidence and authored AI drafts. Session 1 begins with eight minutes of independent reading before discussion or AI. Five abilities score 0 to 2: outcome/scope, fair comparison, estimate/interval/rule, cited concern, and action with evaluator question. Suggested readiness target 8/10 with no false causal claim from before/after or significance. This is a teaching check, not validated certification. Give a targeted retry in Session 2 and record revised scores separately.
- Session 1 retains Fiona's two-sheet A1 credibility grid, now labelled Supported / Concern / Unsupported alongside colours. Section 6 provides genuinely useful disclosure; do not reward unsupported fault finding. Participant sheet 2 pages, trainer pack 7, report 4. Rating reference duplicates the participant sheet.
- Session 2 uses the corrected one-page findings, not the planted report's assurances. Protect twelve minutes for a first draft and eight for peer review. At most 150 words: finding/source, recommendation/condition, important risk/limit, next evidence/purpose. Accept another defensible conditional action. Participant sheet 2 pages, trainer pack 3; optional one-page template duplicates Sheet 1.
- `Rscript make_session_materials.R --day4` rebuilds this day only. The default now calls all four current builders and writes eleven trainer packs plus eleven participant sheets. Legacy implementation is retained inside `if (FALSE)` and cannot overwrite current packs. Full build passed in an isolated copy. Styled reference DOCX files come from the scoped builder; reference QMDs mirror the content but should not overwrite the checked print layouts.
- Exercise brief: all eleven sessions, 9 landscape pages. Day 4 backup: `backups/day4_2026_10_06_approved/`. All final print pages and both A1 sheets rendered and inspected. Deck walks, open feedback, keyboard choices/reveals and room-tool regression passed. Browser errors [], no slide overflow or logo collisions. Review hubs checked at desktop and phone widths.
- Three whole-week downloads together include 11 decks, 11 participant sheets, 11 trainer packs, references, four poster files/five A1 sheets, classroom brief and room tool. File bytes and local links checked. Browser R still needs internet; rehearse trainer decks early and use printed output as fallback. Classroom phone access requires venue rehearsal.

Current reviews: https://3ie.academy/preview/week_ready.html and https://3ie.academy/preview/day4_review.html
Published checkpoints: source build `63ff9cc` plus size-limit adjustment `a92f8e8` on simple-greenwaste; main previews `57df051`. Both pushes succeeded. Download sizes are 762,846 / 17,193,159 / 13,686,934 bytes, each below the static asset cap. Final hub relative links: Day 4 18, whole week 43. Unauthenticated checks returned HTTP 403 for both review URLs; local copies were verified, online content was not inspected.
Source remains `simple-greenwaste`; only unlinked `docs/preview/` assets are updated on main. Live teaching pages remain unchanged. No further daily build approval is pending. Production replacement requires a separate final review and instruction.

Use `.preview_day2_publish` for main previews. Retain ignored worktree residue; do not retry the previously rejected cleanup. The site password gate applies; unauthenticated remote content verification is unavailable.


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

The complete download was split into print materials and deck archives for Days 1-2 and Days 3-4 to respect Cloudflare's 25 MiB static asset limit. Each archive is size-checked before publication.
