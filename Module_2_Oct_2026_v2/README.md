# GreenWaste Module 2: current teaching materials

Training: 12-15 October 2026, Abu Dhabi. These are fictional training records and scenarios, not findings about a real programme.

## Published status

The full teaching rollout was committed and pushed to `main` as [`89c2577`](https://github.com/lsempe77/R-course/commit/89c25776e12aac9928d080bf7785f7ec5fe0336b). Cloudflare Workers (`module2`) and all GitHub build/deploy checks succeeded on 12 October 2026 at 00:55:54 UAE time (11 October, 20:55:54 UTC). Local browser, webR and print checks passed. Authenticated public-page contents were not independently inspected because the site is password-protected.

Start with the [online teaching guide](https://3ie.academy/teaching_materials), or its [repository copy](../docs/teaching_materials.html). It identifies the selected decks, matching materials and distribution instructions. The [course hub](https://3ie.academy) links the teaching routes and downloads.

## Selected sources and teaching routes

Counts include the title screen and refer to actual Reveal screens.

| Session | Edit this source | Teaching route | Screens |
|---|---|---|---:|
| Day 1 S1 | [Oct12_session1_hybrid.qmd](Oct12_session1_hybrid.qmd) | [Oct12_session1_live](https://3ie.academy/Oct12_session1_live) | 19 |
| Day 1 S2 | [Oct12_session2_review.qmd](Oct12_session2_review.qmd) | [Oct12_session2](https://3ie.academy/Oct12_session2) | 22 |
| Day 1 S3 | [Oct12_session3_hybrid.qmd](Oct12_session3_hybrid.qmd) | [Oct12_session3_live](https://3ie.academy/Oct12_session3_live) | 20 |
| Day 2 S1 | [Oct13_session1_review.qmd](Oct13_session1_review.qmd) | [Oct13_session1](https://3ie.academy/Oct13_session1) | 15 |
| Day 2 S2 | [Oct13_session2_review.qmd](Oct13_session2_review.qmd) | [Oct13_session2_live](https://3ie.academy/Oct13_session2_live) | 18 |
| Day 2 S3 | [Oct13_session3_review.qmd](Oct13_session3_review.qmd) | [Oct13_session3](https://3ie.academy/Oct13_session3) | 22 |
| Day 3 S1 | [Oct14_session1_review.qmd](Oct14_session1_review.qmd) | [Oct14_session1](https://3ie.academy/Oct14_session1) | 19 |
| Day 3 S2 | [Oct14_session2_review.qmd](Oct14_session2_review.qmd) | [Oct14_session2](https://3ie.academy/Oct14_session2) | 20 |
| Day 3 S3 | [Oct14_session3_review.qmd](Oct14_session3_review.qmd) | [Oct14_session3](https://3ie.academy/Oct14_session3) | 15 |
| Day 4 S1 | [Oct15_session1_review.qmd](Oct15_session1_review.qmd) | [Oct15_session1](https://3ie.academy/Oct15_session1) | 13 |
| Day 4 S2 | [Oct15_session2_review.qmd](Oct15_session2_review.qmd) | [Oct15_session2](https://3ie.academy/Oct15_session2) | 14 |

- Day 1 S1/S3 deliberately retain Fiona's hybrids and original printed two-page worksheets. Do not replace them with the separate review candidates.
- Day 1 S2 retains Fiona's latest cleaning-picture/words-flip activity and revised seven-page Word worksheet. Its hybrid/flex alternatives are not selected.
- Days 2-4 use the corresponding review worksheets and supplementary sources. The Day 4 simulation is supplied separately; it is not a twelfth course-owned deck.
- Alternate Day 3 S1/S3 and Day 4 S2 `_live` routes match their canonical outputs. Old Day 1 S1/S3 and Day 2 S2 plain routes forward to the selected live routes.

## Printing and delivery

Use [PRINT_SHEETS_TRAINER.md](PRINT_SHEETS_TRAINER.md) and the [teaching guide](../docs/teaching_materials.html) for exact page counts and delayed handouts. Use embedded speaker notes (`S` in Reveal) for current timings, rather than historical schedule proposals.

The [Days 1-2 deck ZIP](../docs/downloads/GreenWaste_decks_days1_2.zip) contains six selected browser decks; the [Days 3-4 ZIP](../docs/downloads/GreenWaste_decks_days3_4.zip) contains five. Unzip both into the same folder. The [print ZIP](../docs/downloads/GreenWaste_week_materials.zip) contains current worksheets, separately labelled sources, private keys and posters. Keep trainer keys private.

Participants interpret outputs; they do not need to write or debug R. Trainer Run Code boxes use webR and need internet. Open decks early and rehearse on the venue network. Printed result tables provide the fallback. [ROOM_POLL_README.md](ROOM_POLL_README.md) explains shared room voting; native slide/card choices are local to one browser.

## Editing and publishing safely

1. Refresh `main` and integrate collaborators' changes before editing. Select the source from the table above, not from its URL name.
2. Render changed QMDs in this folder with Quarto and R. For example, `quarto render Oct13_session1_review.qmd`. Render in place; do not use `--output-dir` on the OneDrive path.
3. Copy the rendered HTML to the matching canonical filename under [docs](../docs/). Refresh the corresponding review copy under [docs/preview](../docs/preview/) where applicable. If a shared helper, stylesheet or [_case_map.qmd](_case_map.qmd) changes, rerender every selected deck affected by that change.
4. Render matching worksheet/supplementary QMDs, publish participant HTML under [docs/handouts](../docs/handouts/) and private keys under [docs/trainer](../docs/trainer/). Preserve Day 1 printed-worksheet choices. Update hub, guide, comparisons and all affected ZIP entries together.
5. Check actual screen counts, 1280x720 content bounds and heading/logo clearance, opened controls, actual Run Code output and editor width. Check exact A4 PDF pagination, material links and ZIP entry bytes against canonical outputs. Do not infer slide count from the number of QMD headings alone.
6. Stage only intended files, commit and push. Confirm remote SHA and successful Cloudflare/GitHub deployment checks before reporting deployment. A password-gated HTTP response is not proof of authenticated deck contents.

**Do not run the historical [publish_live.py](review_2026_10_06/publish_live.py), [switch_session.py](review_2026_10_06/switch_session.py) reverts or blanket legacy print generators to publish the revised week.** They can restore obsolete decks, hub links or Word packs. The final rollout's validation/package scripts were session artifacts, not a checked-in publisher.

## Documentation and history

- [HANDOFF.md](HANDOFF.md): implementation, validation and deployment record.
- [SLIDE_HANDOUT_REVIEW_PLAN.md](SLIDE_HANDOUT_REVIEW_PLAN.md): current rollout status followed by historical review decisions.
- [SESSION_BUILD_GUIDE.md](SESSION_BUILD_GUIDE.md): rendering/layout techniques; older case-building examples are historical.
- [CLAUDE.md](CLAUDE.md): project conventions; current source selection is the table above.
- [PREVIEW_CHANGE_NOTES.md](PREVIEW_CHANGE_NOTES.md) and [REVIEW_NOTES.md](REVIEW_NOTES.md): language/review history, not a list of unbuilt current sessions.
- [SIMPLE_GREENWASTE_PLAN.md](SIMPLE_GREENWASTE_PLAN.md): earlier rebuild history, not the current schedule or publisher.
- [S2_WORKSHEET_SWAP.md](S2_WORKSHEET_SWAP.md): contingency guidance only; coordinate worksheet/deck changes with Fiona.

Old decks and source-comparison outputs are preserved in the [historical archive](../docs/preview/archive/index.html). Former preview bookmarks carry explicit warnings. Do not teach from archived versions or select a deck merely because its filename includes `live` or `review`.
