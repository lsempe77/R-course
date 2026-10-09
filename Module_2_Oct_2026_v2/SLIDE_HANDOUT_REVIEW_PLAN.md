# Module 2 slide and handout revision plan

**Discussion draft for Lucas, Fiona and colleagues — 7 October 2026. This is a proposal, not approval to implement it.**

Restore explanatory depth while keeping a manageable number of slides. By the end of the week, officials should be able to identify an evaluation's comparison and assumptions, interpret its tables and figures, and judge whether its recommendations follow from the evidence. Plain language should support that technical understanding.

Only this Markdown plan is being revised. Teaching materials, data and the live site remain unchanged by this planning work. Session decisions and comments below are deliberately open for review. The plan is now shared on `main` alongside Fiona's notes.

## Update (9 October 2026)

- **Previews (`*_review.qmd`)**: language pass from `PREVIEW_CHANGE_NOTES.md` sections 1 to 7 is applied in source for the 7 existing previews (Day 1 S1 to S3, Day 2 S1 and S3, Day 3 S1 and S2). Not yet re-rendered on a full toolchain and not published: `docs/preview/` still shows the earlier versions.
- **Still to do, in order**: (1) Fiona and Lucas review the edited sources; (2) re-render on a machine with Quarto, fonts and the webR extension, check slide fit (1280x720) and A4 worksheet fit, and run the webR code boxes; (3) copy to `docs/preview/`, then promote to the live routes with `review_2026_10_06/publish_live.py` once approved; (4) build the missing previews: **Day 2 S2 (regression discontinuity)**, Day 3 S3 and Day 4 S1 to S3, applying the same language rules; (5) section 8 content additions (see `PREVIEW_CHANGE_NOTES.md`); (6) open questions in section 9 (negative costs for Lucas, time budgets, snippet style).
- **Where to look**: `HANDOFF.md` (latest entry at the top), `PREVIEW_CHANGE_NOTES.md` (rules, approved wording, section 8 additions), `PRINT_SHEETS_TRAINER.md` (print and cutting instructions for trainers).



Original slide/handout baseline: `80d9262`. Subsequent check on 7 October found two new Fiona commits on `origin/main`: `ae2bef8` (source edits and review notes) and `f3db11d` (proposed Day 1 outline). These have not been merged into the working `simple-greenwaste` branch. Fiona explicitly records her new deck edits as not yet rendered or published. The row IDs below still identify the original baseline; the reconciliation section records additions and changes rather than silently renumbering them.

Fiona's review is [REVIEW_NOTES.md on main](https://github.com/lsempe77/R-course/blob/f3db11df7e7209e86c64e3869b1059ea9b2077e8/Module_2_Oct_2026_v2/REVIEW_NOTES.md). Her working notes distinguish implemented source edits, items recorded as decided, and the proposed Day 1 restructure, which is explicitly not agreed. This plan preserves those distinctions. Her source edits are present in the current `main` checkout; this planning work has not modified or rendered them.

Reviewed: eleven current QMD decks, published participant DOCX sheets, relevant trainer packs, supplementary references, the four A1 poster uses, HANDOFF.md, SIMPLE_GREENWASTE_PLAN.md and CLAUDE.md. Original headings at `217858a` identify useful restoration candidates. This is a teaching/content review, not a fresh visual render audit.

Baseline IDs refer to the original content sequence, excluding the generated title screen: `D1S1-01` is its first content slide. All eleven title screens and 122 baseline content screens are mapped. Day 1 now uses P IDs for the proposed delivery order, with origin/action columns mapping existing material and additions. H1–H11 identify participant handouts in session order; Day 1 tables explicitly show replacement sections and questions rather than preserving the earlier worksheet order.

## Decisions to settle together

| Decision | Recommendation for discussion | Agreed decision |
|---|---|---|
| Daily schedule | Lucas confirmed 09:00–15:00, with one 15-minute and one 30-minute break: 315 minutes of teaching/activity time per day. | Confirmed |
| Simulation start | Lucas confirmed the Day 4 simulation starts at 13:00. Within the confirmed day ending at 15:00, this leaves 120 minutes for the simulation and 195 minutes before it after the two breaks. | Confirmed start; end follows daily schedule |
| Session allocation | For Days 1–3, propose 90/90/120 minutes plus 15 minutes of daily consolidation. For Day 4, propose two 90-minute sessions plus 15 minutes of feedback/handover before the simulation. Break placement remains a proposal. | Pending |
| Technical level | Explain comparisons, coefficients, p-values, confidence intervals and causal assumptions through worked examples. Keep full estimator syntax and advanced inference as trainer extensions unless necessary to read the supplied report. | Pending |
| Day 1 order and outcome | Proposed sequence now consistently follows Fiona's outline: S1 read a cost result, S2 descriptive cost data and weak comparisons, S3 pilot lottery. Keep annual cost AED throughout, including the four claim cards. Landfill remains available for later chart/denominator teaching. | Draft aligned; teaching approval pending |
| Slide count | With the explicit additions below, provisionally aim for about 14–18 substantive screens for explanation-heavy sessions, fewer for workshops, excluding title/break screens. Agree a final sequence before exact timings. Do not add slides simply to fill a longer slot. | Pending |
| AI tasks | Restore a two-stage AI Snapshot: participants mark a realistic supplied response, then run the better prompt themselves and compare it with the source. 15 minutes per Snapshot in every session that already has an AI exercise (ten sessions); D4S1 keeps its independent reading check and gets no separate Snapshot. Participants are expected to have Microsoft Copilot, so no account setup is needed: write the better prompts for Copilot. A prepared second response is the paper fallback. General good practice goes on a one-page AI good-practice card (see "AI good-practice card"). | Agreed by Fiona, 7 Oct; Lucas to confirm |
| Reading assessment | Retain independent Day 4 reading, feedback and targeted retries. Consider a short unfamiliar extract to check transfer beyond recognition of GreenWaste numbers. This is a teaching check, not validated certification. | Pending |
| Print length | Allow an activity sheet plus an identified source/reference when needed. Do not shrink diagrams, tables or handwriting spaces to enforce two pages. Keep keys and setup separate from participant materials. | Pending |

### Schedule and implications for depth

The confirmed day contains 360 elapsed minutes minus 45 minutes of breaks: **315 minutes for teaching and activities**. The previous shortened 60/60/75-minute plan uses only 195 minutes on Days 1–3, leaving 120 minutes unallocated. It should no longer govern the proposed revision. The additional time should restore explanations, worked examples and practice, rather than add more methods.

Proposed timetable for Days 1–3; break placement is for discussion:

| Time | Allocation | Minutes |
|---|---|---|
| 09:00–10:30 | Session 1 | 90 |
| 10:30–10:45 | Short break | 15 |
| 10:45–12:15 | Session 2 | 90 |
| 12:15–12:45 | Longer break | 30 |
| 12:45–14:45 | Session 3 | 120 |
| 14:45–15:00 | Daily wrap-up and feedback (no separate materials; also a buffer if sessions run over) | 15 |

An indicative 90-minute concept session could use 10 minutes for context/retrieval, 30 for explanation and worked examples, 25 for guided practice, 15 for source reading and 10 for feedback. A 120-minute applied session could use 10/30/40/25/15 minutes respectively. These are planning envelopes, not final slide timings. The separate 15-minute daily close checks learning across sessions; it is not another lecture. Fiona (7 October): it needs no separate materials and doubles as a buffer if earlier sessions run over.

Day 4's simulation starts at 13:00. Assuming it occupies the remainder of the confirmed day, the allocation is 120 minutes. Before it, 240 elapsed minutes minus the two breaks leaves **195 minutes** for our teaching, feedback and handover.

Proposed Day 4 timetable; placement of the two breaks remains for discussion:

| Time | Allocation | Minutes |
|---|---|---|
| 09:00–10:30 | Session 1: independent report reading and review | 90 |
| 10:30–10:45 | Short break | 15 |
| 10:45–12:15 | Session 2: recommendation, peer review and retry | 90 |
| 12:15–12:30 | Feedback, consolidation and simulation handover | 15 |
| 12:30–13:00 | Longer break | 30 |
| 13:00–15:00 | Other provider's evaluation simulation | 120 |

Our Day 4 teaching ends before the simulation; there is no separate 14:45 daily close in this allocation. Coordinate the handover and any closing reflection with the simulation provider.

Implications for the slide and handout proposals: keep the same core concepts and restoration priorities; allow time to explain their diagrams, work calculations and discuss errors. The revised guide of 14–18 substantive screens for explanation-heavy sessions is not a quota. Restore source pages, useful figures and response space where needed, without adding compulsory worksheet tasks merely to fill time. Existing break screens inside longer decks must be reconciled with the two scheduled breaks; do not assume an additional formal break without accounting for its time.

## Principles for every revision

1. Introduce GreenWaste before any vocabulary or results. Explain equipment subsidy, installation help and staff training; pilot lottery versus city score rule; recorded outcomes; timing; and the decision. Use the same map throughout.
2. Give each retained technical concept an explanation, a worked example and independent interpretation. Keep useful labelled diagrams visible while discussing them. An interaction should expose a relationship or test a reason, rather than merely reveal text.
3. Recover original teaching devices selectively. Adapt traffic-camera, school-zone and neighbourhood examples to the current business-level GreenWaste design. Do not restore obsolete figures, neighbourhood assignment, Menti or the removed Day 4 workshop.
4. Distinguish case reference, session study extract, draft analyst note, Day 4 review report and corrected findings. Give paragraph/table identifiers. A paragraph on a worksheet is not a full report.
5. Announce outcome switches: landfill tonnes versus annual waste cost AED. State population, period, units and comparison on substantive tables and figures. Separate descriptive changes from causal estimates.
6. Preserve Fiona's four claim cards, RDD cards A–H and number line, seven matching profiles with withheld cost slips, five economic scenarios and prediction wall, and two-sheet credibility grid. Do not restore the AI walls she reverted in D1S3 and D2S1.
7. Keep readable commented R boxes as optional trainer demonstrations, with printed outputs. Explain how a result was produced even when learners do not run code.
8. Use authored AI examples that mix accurate facts, plausible qualifications and consequential overclaims. Exercise copies have no answer highlighting; debriefs cite the source. Following Fiona's recorded decision, participants first mark the supplied response, then run the better prompt and compare against the source. Participants are expected to use Microsoft Copilot (no account setup needed); a prepared second response is the paper fallback. Do not require a separate second-chat checking exercise in every session.
9. Keep one consistent fictional-case notice per deck/document. Remove facilitator instructions from learner-facing prose. Layout should organise meaningful explanation, rather than replace it with large numbers and short slogans.

## Proposed teaching sequence

The Day 1 tables below now directly specify the cost-focused sequence, as-you-go worksheets and two-stage AI exercises. The reconciliation section records why the plan changed; it is not an alternative sequence. Days 2–4 retain their original baseline row mapping plus the proposed insertions.

| Session | Progression | Main source |
|---|---|---|
| D1S1 | Case/ToC; five terms through annual cost results; worksheet questions as concepts are taught; pair correction; realistic AI markup and better-prompt comparison. | Case card + H1 cost records/table |
| D1S2 | City cost records/counts/distributions; before/after versus with/without; four cost claims; chart AI markup and better-prompt comparison. | H2 cost data/figures + four cost cards |
| D1S3 | Brief city-comparison recap; pilot lottery/draw; baseline check; post-period means/regression; uncertainty/reach; recommendation and ministerial AI task. | H3 pilot study extract |
| D2S1 | Four means; DiD diagram/arithmetic; output; parallel trends; data limits; source interpretation. | H4 DiD extract |
| D2S2 | Score rule/scatterplot; raw group gaps; fitted local jump; window/credibility checks; reach. | H5 cutoff extract + cards |
| D2S3 | Pair profiles before costs; differences; full-study matching/reuse; balance/overlap; unmeasured factors. | H6 matching extract + cards |
| D3S1 | Benefit input; cash-flow timeline; ratio/discounting; scenarios; conditional spending recommendation. | H7 model note + cards |
| D3S2 | Chart source; axes/distributions; denominators; uncertainty; defend a caption. | H8 figures and small data tables |
| D3S3 | Decision note; questions; analyst role-play; assess answers; revise sign-off. | H9 note + evidence bank |
| D4S1 | Independent report reading; claim ratings; section work; source-based debrief; feedback. | Review report + H10 |
| D4S2 | Corrected findings; worked brief; draft; peer check; revision/defence; reading retry. | Corrected findings + H11 |

## Slide-by-slide proposals

**Update for the full teaching day:** additional explanatory screens are proposed explicitly in the next section. The older row-level instructions to combine a screen are provisional, not requirements to fit a 60-minute session. Preserve a separate worked-example screen where combining would make the explanation rushed or crowded. Keep combinations that remove repeated headlines, instructions or exit questions. The timing table budgets the full proposed slots without introducing more methods. Minutes columns are for planning and speaker notes only: no timings appear on slides (existing rule, no `.mins` badges).

Title screens: keep the question-led main titles for review, use explicit content/technical subtitles, and add one short interpretation objective. Reconsider titles after the teaching sequence is agreed. Day 1 S2's subtitle should explicitly name descriptive statistics and recorded comparisons. No facilitator setup or duration on the title.

### D1S1 What do the numbers actually say?

Source: `Oct12_session1_live.qmd`. Existing notes total 60 minutes; proposed allocation: **90 minutes**, with 17 content screens. Handout: H1. Session decision: **Pending**. Comments: ____________________

The P IDs below give the proposed delivery order. Origin IDs preserve traceability to every baseline screen and Fiona's additions. Worksheet questions are answered as concepts are taught; P14 is correction and Q6, not a repeat of the whole worksheet. Title screen has no separate time allocation.

| Proposed slide | Origin/action | Explanation, visual and learner work | Paper task | Minutes |
|---|---|---|---|---:|
| D1S1-T Title | Retain | Five terms for reading an annual cost result; one interpretation objective. | H1 source identified | — |
| D1S1-P01 The GreenWaste case study | Preserve Fiona F1 | Case map, intervention components, pilot/city settings and measured outcomes. Introduce annual cost AED as Day 1's main outcome; distribute the picture card. | Case card | 4 |
| D1S1-P02 Where does GreenWaste fit? | Preserve Fiona F2 | ToC bridge from delivery outputs to measured outcomes. Explain that distributing equipment does not establish caused savings. | Case reference | 4 |
| D1S1-P03 A cost result lands on your desk | D1S1-01, orient | Show the named city before/after source and self-check the five terms. Explain people/period/units before asking learners to read it. | H1-A source | 2 |
| D1S1-P04 Mean: who looks like the average? | D1S1-02, adapt to costs | Ten selected actual annual COST records; learners calculate first, then reveal mean and dot plot. Recompute values from CSV; do not relabel the old tonne values as AED. | Q1 | 5 |
| D1S1-P05 One large business changes the average | ADD1, restore | Remove the largest selected cost record; compare mean and median and predict movement. Selected records are not a representative city sample. | Q1 follow-up | 4 |
| D1S1-P06 Treatment effect: what did GreenWaste cause? | D1S1-03, expand | Observed-versus-missing-no-programme outcome diagram and concrete business example. Separate causal effect from recorded change; revisit after coefficient reading. | Proposed Q2 | 5 |
| D1S1-P07 Coefficient: which row is the change? | D1S1-04, expand | Annotated intercept/after rows, intervals, p-values and source/model note. Explain reference period and 1,432 + (-669) ≈ 763. Intercept interpretation is model-specific. | Proposed Q3 | 6 |
| D1S1-P08 What does the minus sign mean? | Preserve Fiona's revision of D1S1-05 | Outcome-dependent sign interpretation; worked subtraction, then optional commented R Run. Explain arithmetic/regression agreement without requiring participant code. | Proposed Q3 follow-up | 4 |
| D1S1-P09 Confidence interval: how sure are we? | D1S1-06, expand | Estimate/interval line; uncertainty around the mean change versus business-level spread. Brief hypothetical repeated-sample coverage explanation. | Q4 | 5 |
| D1S1-P10 Same estimate. Different uncertainty. | ADD2, restore | Three hypothetical intervals on one labelled scale; compare precision and implications for the same threshold. No extra model-fitting lecture. | Q4 follow-up | 5 |
| D1S1-P11 P-value: what does small tell us? | D1S1-07, expand | Explain result under no-mean-change null and assumptions with a valid hypothetical illustration. Not probability the programme works; not proof of cause. | Q5 | 5 |
| D1S1-P12 Statistically clear. Large enough to matter? | ADD3, restore | Coherent precise-small versus imprecise-larger examples. A non-significant result does not prove no change; significance is not policy importance. | Q5 follow-up | 4 |
| D1S1-P13 A lower cost. Enough saving? | D1S1-08, retain | Convert -669 change to positive saving with reversed interval endpoints; compare against fictional 1,000 AED rule. Do not label change as impact. | Q6 interpretation | 4 |
| D1S1-P14 Pair check: what does the table support? | D1S1-09, revise | Compare completed Q1–Q5, correct misunderstandings and finish Q6. Trainer listens for each term's meaning; no second full worksheet round. | Pair check + Q6 | 10 |
| D1S1-P15 A plausible AI reading of the table | D1S1-10, replace | Realistic multi-paragraph response to a busy official's prompt: correct figures/qualifications mixed with causal and decision overclaims. Mark source support before debrief. | H1 AI response/source | 8 |
| D1S1-P16 Ask for a reading you can verify | AI2, add | Run better prompt with decision, source and limits; ask for clarifying questions. Compare to marked response and source. Prepared second response is paper fallback. | H1 better prompt/comparison | 7 |
| D1S1-P17 What would you tell the director? | D1S1-11, retain | Independent interpretation, causal limit and evidence request. Bridge: S2 inspects the cost data and comparisons behind -669. | Individual close | 8 |
| Total content time | | | | **90** |

### D1S2 Good news. Enough to act?

Source: `Oct12_session2.qmd`. Current duration: 60 minutes; proposed allocation: **90 minutes**, with 15 content screens. Handout: H2. Session decision: **Pending**. Comments: ____________________

Replace the landfill headline sequence with cost data and descriptive comparisons. Keep Fiona's brief case reminder within P01, four-card triage and A1 board. Do not repeat S1's ten-record mean lesson or formally teach DiD before Day 2.

| Proposed slide | Origin/action | Explanation, visual and learner work | Paper task | Minutes |
|---|---|---|---|---:|
| D1S2-T Title | Revise subtitle | Descriptive statistics, annual costs and the comparison behind a claim. | H2 source identified | — |
| D1S2-P01 We read -669. Was it the programme's effect? | D1S2-01, D1S2-02 and D1S2-03, replace/combine | City cost result callback and one-minute case reminder. Learners give provisional reason; no landfill headline or isolated percentage. | Opening judgement | 4 |
| D1S2-P02 One row. One business. Two measurements. | D1S2-04 + ADD1 | Selected real city rows, IDs, participation and before/after cost columns. Describe one business in words; one record contains two measurements. | Q1 data orientation | 5 |
| D1S2-P03 Who is included in these averages? | ADD2 | Participation counts 4,794/5,206 and score-rule reminder. Identify which businesses each average describes. | Source/sample caption | 3 |
| D1S2-P04 What do costs look like before the programme? | D1S2-07, replace | Full-city or explicitly labelled group histogram with mean/median/spread. Extend S1; do not re-teach its ten selected records. | Q2 distribution | 6 |
| D1S2-P05 Participants: what changed after GreenWaste? | D1S2-06, split | Before/after 1,432→763; work approximately -669 using proper unrounded source for final value. Interpret a descriptive change, not an effect. | Q3 before/after | 6 |
| D1S2-P06 Did every business's cost fall? | ADD3 | Distribution of individual changes with zero marked. A mean fall does not mean a fall for every participant. | Q3 variation | 5 |
| D1S2-P07 What else could have changed costs? | D1S2-04 question, retain within new context | Before/after timeline plus hypothetical price/service change. Learners state needed evidence; brainstormed shocks are not established case facts. | Q3 comparison limit | 5 |
| D1S2-P08 Other city businesses: what changed? | D1S2-05, replace | 2,258→2,401 and approximately +143 change, common axes. It raises a counterfactual question; does not alone prove participant untreated trend. | Q4 other-group change | 6 |
| D1S2-P09 Lower than without. Already lower before. | D1S2-06, split | After-only 763 versus 2,401 gives approximately -1,638. Reveal baseline levels and concrete selection concern; do not call the whole gap caused saving. | Q4 with/without | 7 |
| D1S2-P10 Two numbers. Two weak comparisons. | ADD4 | Compare -669 and -1,638 with groups/periods labelled. Ask what each misses and why a fair comparison is needed. No claim that these alone establish true bias direction. | Comparison summary | 5 |
| D1S2-P11 Four cost claims. Which would you act on? | D1S2-08, adapt cards | Four cost cards preserve Fiona's activity and Act/Ask first/Do not act grid. Sources identify before/after change and paired descriptive changes. Do not smuggle in an unexplained DiD effect. | Q5 four cards/A1 | 12 |
| D1S2-P12 Which evidence supports your choice? | D1S2-09, retain | Debrief two disagreements using words/numbers. Explain what would justify action; several evidence requests can be defensible. | Q5 reasons | 5 |
| D1S2-P13 Would you accept this AI chart reading? | D1S2-10, replace | Realistic cost-chart reading with correct changes and subtle causal/generalisation leap. Mark supported claims and missing comparison before feedback. | H2 AI response/source | 8 |
| D1S2-P14 Ask for a comparison-aware explanation | AI2, add | Run better prompt with source, decision and data limits; compare response against chart and marked draft. Paper fallback supplied. | H2 better prompt/comparison | 7 |
| D1S2-P15 What comparison would you ask for next? | D1S2-11, revise | Independent descriptive conclusion and useful evaluator question; compare opening reason. Bridge to pilot lottery, not another landfill lesson. | Individual close | 6 |
| Total content time | | | | **90** |

### D1S3 Did the programme make the difference?

Source: `Oct12_session3_live.qmd`. Current duration: 75 minutes; proposed allocation: **120 minutes**, with 16 content screens. Handout: H3. Session decision: **Pending**. Comments: ____________________

Move the full weak-city-comparison explanation to S2; S3 uses only a brief recap before the pilot. Original D1S3-02, D1S3-03 and D1S3-04 content is covered by D1S2-P07/P09/P10 rather than taught twice. Original D1S3-08 break screen becomes a change-of-activity cue, not a third scheduled break. No outcome switch: costs remain in AED.

| Proposed slide | Origin/action | Explanation, visual and learner work | Paper task | Minutes |
|---|---|---|---|---:|
| D1S3-T Title | Retain | Pilot lottery, uncertainty and limits of wider recommendations. | H3 source identified | — |
| D1S3-P01 Two city comparisons. Why a lottery? | D1S3-01, shorten | Brief recap of -669 and -1,638 with their weaknesses. Do not redo S2 calculations or baseline lesson. | H2 summary referenced | 4 |
| D1S3-P02 The pilot district: 400 businesses, 200 places | D1S3-05, split | Show eligible pilot population and individual-business allocation; 200 join/200 wait. Distinguish random assignment from selecting a representative sample. | H3-A design | 5 |
| D1S3-P03 What the lottery buys us | D1S3-05, split | Concrete selection example and random-assignment diagram. Explain comparability under trial assumptions, not guaranteed identical businesses. | Q1 comparison/fairness | 7 |
| D1S3-P04 Draw the lottery, then draw again | D1S3-06, expand | Physical draw of ten from 20 numbered manager-age slips; compare drawn/not-drawn means, repeat, then optional commented R repeats. Physical activity is internet fallback. | Q1 draw reflection | 12 |
| D1S3-P05 Small lotteries can look different | D1S3-06, split | Sample-size visual/repeated-draw display, with illustrative and actual pilot sample sizes distinguished. Predict imbalance before reveal. Avoid randomisation-proof significance tests. | Q1 sample-size note | 6 |
| D1S3-P06 Were groups similar before GreenWaste? | ADD1 | Pilot baseline means 1,390/1,411 and distributions. Explain chance imbalance and why the assignment process matters more than one balance p-value. | H3 baseline panel | 6 |
| D1S3-P07 The result is a difference of two averages | D1S3-07 + ADD2, split | Post-period means 769/1,783 yield approximately -1,014. Work units, comparison and sign before the output. Use precise data for final estimate. | Q2 mean difference | 8 |
| D1S3-P08 The regression reports that same comparison | D1S3-07 + ADD2, split | Treatment row, reference group, uncertainty and source. Explain why the assignment design supports the pilot effect interpretation, unlike S1 before/after. | Q2 output annotation | 6 |
| D1S3-P09 Does the interval clear our rule? | D1S3-09, retain | Positive saving interval 862–1,167 against 1,000. Point exceeds minimum, interval spans it. | Q3 uncertainty/rule | 8 |
| D1S3-P10 Who does this pilot describe? | Part of D1S3-10, separate | One district, score ≤58 and trial delivery conditions. Explain evidence needed for broader use; a lottery does not guarantee nationwide relevance. | Q4 reach | 6 |
| D1S3-P11 Three numbers. Three comparisons. | Restore day's summary | City before/after -669, city with/without -1,638, pilot -1,014 with interval, each labelled by people/period. Pilot is not automatic ground truth for city's different population. | H3 comparison reference | 6 |
| D1S3-P12 Would you extend it now? | D1S3-10, retain | Individual choice before group discussion; explain design strength plus uncertainty/reach limit and proportionate condition. | Q5 provisional action | 8 |
| D1S3-P13 Your recommendation in three sentences | D1S3-11, retain | Draft finding, action/condition and important limit/request; pair source-check without a predetermined policy answer. | Q5 note | 13 |
| D1S3-P14 A plausible AI paragraph for the minister | D1S3-12, replace | Accurate result/qualification mixed with subtle threshold/nationwide-value assurance. Mark against H3-A before debrief. | H3 AI response/source | 8 |
| D1S3-P15 Ask for a recommendation the trial supports | AI2, add | Run better prompt and compare to source and marked draft; provide prepared paper response. | H3 better prompt/comparison | 7 |
| D1S3-P16 Which evidence could change your decision? | D1S3-13, retain | Independent request and final source-based recommendation. Bridge to city DiD tomorrow; daily cross-session consolidation is separate. | Individual close | 10 |
| Total content time | | | | **120** |

### D2S1 What would have happened anyway?

Source: `Oct13_session1.qmd`. Current duration: 60 minutes. Handout: H4. Session decision: **Pending**. Comments: ____________________

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D2S1-T Title | Retain | Explicit DiD objective: interpret an extra change and its assumption. |
| 01 Yesterday's saving. Today's question. | Orient | Select CITY on the case map and distinguish the pilot result. Recap the two weak comparisons in one visual. |
| 02 Both groups changed. What was extra? | Expand | Restore two-line DiD diagram with observed means and dashed assumed untreated path. Label the dashed path as hypothetical, not recorded data; mark programme start. |
| 03 Four numbers. What is the extra change? | Keep | Preserve Fiona's arithmetic. Work one change together, then groups finish. Accept one-AED rounding differences; final estimate comes from unrounded values. |
| 04 What does the extra change tell us? | Expand | Pair arithmetic with an annotated interaction/DiD regression row. Explain extra change and causal conditions. Keep one commented trainer calculation; fitting syntax is optional. |
| 05 What must we assume about the groups? | Expand | Use the dashed path to explain parallel trends. Groups can start at different levels. Work a concrete reason untreated changes could differ. |
| 06 Which trend would make you hesitate? | Keep | Retain hypothetical pre-trend diagrams with identical scales. Learners explain the concerning feature; reassuring past trends do not prove the future assumption. |
| 07 Can one 'before' show a trend? | Combine with 06 debrief | Display the actual one-before/one-after timeline. Distinguish available data from hypothetical histories. Ask for earlier measures and information on other changes. |
| 08 Does the report go beyond its evidence? | Expand source | Provide a realistic methods/results extract and table with paragraph/row identifiers. Locate comparison, coefficient, interval and assumption before judging the conclusion. |
| 09 The AI says cause. Does the comparison? | Restore richer example | Adapt older DiD paragraph with correct estimate/interval, an unwarranted parallel-trends assurance and a conclusion ignoring the minimum. Include a plausible caveat. |
| 10 What would you ask for next? | Keep | Require a plain-language interpretation and a specific request. Locate DiD on the city-method map. |

### D2S2 What changes at the cutoff?

Source: `Oct13_session2_live.qmd`. Current duration: 60 minutes. Handout: H5. Session decision: **Pending**. Comments: ____________________

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D2S2-T Title | Retain | Explicit local-jump and credibility-check objective. |
| 01 Same city. Either side of the rule. | Expand | Restore score-versus-cost scatterplot with cutoff 58 and distinct participation groups. Explain running variable, threshold and local comparison in that order. |
| 02 What do you expect at score 58? | Keep | Predict before fitted lines appear. Explain score direction and eligibility at or below 58. Record reasons as well as votes. |
| 03 Twelve nearby businesses. What do they show? | Keep | Preserve eight A–H cards and arithmetic. Work one subtraction; small raw samples may give different gaps. |
| 04 Why did our groups get different jumps? | Keep | Preserve A1 line. Separate raw group gaps and fitted estimate in two lanes. Explain slope/sample differences; regression is not just averaging the cards. |
| 05 Is the jump large enough to matter? | Expand | Restore fitted local lines and annotated below-cutoff coefficient, window, units and robust interval. Use -721 and HC2 interval -943 to -498; distinguish local jump from overall level gap. |
| 06 Change the window. Change the answer? | Visualise | Shade narrow/wide windows on the same scatterplot and reveal estimates. Explain locality/information tradeoff; stable results do not prove validity. |
| 07 Waste costs jump. Manager age does too. | Expand | Restore pre-programme manager-age plot. Explain the credibility concern without claiming it proves a particular bias. Include adjusted estimate as an optional small panel. |
| 08 Does this cutoff make a fair comparison? | Expand | Add score-manipulation/density explanation with a labelled hypothetical diagram or an evidence request. No observed test is supplied. Cover rule, locality, other jumps, score setting and reach. |
| 09 Local evidence. A citywide recommendation? | Restore richer example | Adapt older RDD AI paragraph with correct local result and plausible technical wording, then ignored balance concern or generalisation beyond cutoff. Learners cite plot/table evidence. |
| 10 Which check is missing? | Keep | Interpret the coefficient and identify the check most likely to change judgement. Distinguish evidence near a rule from a whole-city effect. |

### D2S3 How similar is similar enough?

Source: `Oct13_session3.qmd`. Current duration: 75 minutes. Handout: H6. Session decision: **Pending**. Comments: ____________________

Proposed order: 01–04; expanded 06; 05; break; 08–10; 11+13; 12 if time permits. Put the matching process before the unexplained full-study result.

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D2S3-T Title | Retain | Explicit matched-comparison and remaining-bias objective. |
| 01 Who would you choose as the comparison? | Orient | Explain which city differences matching tries to repair; introduce recorded pre-programme characteristics. |
| 02 What can you tell before seeing costs? | Keep | Preserve profile fronts without costs. Draw a participant/comparison link and explain close characteristics do not make businesses identical. |
| 03 Find the twins | Keep; qualify | Preserve seven profiles and optional walking. Record choices before revealing costs. Explain closest recorded comparison rather than promising identical twins. |
| 04 Now open the costs. Still convinced? | Keep | Reveal separate slips after pairing. Work first pair difference then group mean. Distinguish this invented small exercise from the full-city study. |
| 05 Near the rule. Enough certainty? | Expand; move after 06 | Annotate result, interval, replacement and sample counts. Draw control reuse: 4,794 participants do not mean 4,794 distinct controls. |
| 06 Four characteristics. Still different? | Expand; move before 05 | Restore four-step matching diagram and before/after balance display for age/staff/area/filtration. Teach overlap and adequate similarity; distance fitting remains optional. |
| 07 Take a break | Keep | Retain a short break before limitations; timetable pending. |
| 08 Drop one characteristic. A new answer? | Visualise | Show full-feature versus age-omitted estimates side by side. Explain changed comparisons, rather than only revealing another number. |
| 09 What if motivation is missing? | Expand | Use a concrete hypothetical motivation example or small causal-path diagram. It is not a recorded case variable. Measured balance does not rule it out. |
| 10 What does 'everyone matched' prove? | Expand source | Replace full report with full-city study extract. Supply methods/results with identifiers, balance evidence and reuse. Nearest match is not necessarily an acceptable match. |
| 11 Act now, add conditions or ask first? | Keep | Require interpretation, a supporting strength, a concern and a proportionate action; no single mandatory policy answer. |
| 12 The AI promises no bias. Where is the proof? | Restore richer example | Adapt older matching review with accurate estimate/features, plausible qualifications and an unsupported selection-bias or threshold assurance. |
| 13 Close the sheet. What would you ask? | Combine with 11 close | Write a matching-specific request and use a compact lottery/DiD/cutoff/matching comparison map. |

### D3S1 Worth the money?

Source: `Oct14_session1_live.qmd`. Current duration: 60 minutes. Handout: H7. Session decision: **Pending**. Comments: ____________________

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D3S1-T Title | Retain | Explicit benefit-cost interpretation and assumptions objective. |
| 01 A saving is only half the question. | Orient | Explain transition from impact evidence to spending. Identify provisional DiD benefit input and its causal limit; methods are not interchangeable benefit estimates. |
| 02 Benefits beat costs. Should we approve? | Keep | Collect provisional reasons for the headline ratio, then reveal its inputs promptly. |
| 03 What is inside the headline ratio? | Expand | Restore cash-flow timeline: cost now, no year-1 benefit, five saving years in years 2–6. Distinguish estimated inputs from fictional assumptions. |
| 04 Benefits of 3,350. Against which costs? | Expand | Work ratio 3,350/1,800 ≈ 1.86 and net present value 3,350-1,800 ≈ 1,550 AED. Restore a readable model output, not a full coding lesson. |
| 05 Worth less if the saving arrives later? | Expand | Restore two-date diagram and 812/1.05 ≈ 774 worked example. Explain year-2 discounting in the full model. Optional rate control must serve this explanation. |
| 06 Whose costs are missing? | Keep; clarify | Show authority/business/other cost boundaries and specify perspective. Check already-included items before adding costs. Distinguish financial saving from wider social benefit. |
| 07 One changed assumption. Your prediction? | Keep | Preserve five cards and eight allocations 1,2,3,4,5,1,2,3. State exact changed inputs; predictions above the A1 line. |
| 08 Where does your scenario land? | Keep | Place results below the line; explain why scenario 5 crosses 1 and what makes a scenario plausible. Use the canonical model for all outputs. |
| 09 Which assumption changes the verdict? | Keep | Require a consequential input, concrete evidence and an explanation of possible decision change. |
| 10 The ratio is above 1. Case closed? | Restore richer example | Adapt older value-for-money task with correct ratio/discounting and plausible caveats, then unsupported duration/cost assurances. Learners test the source model. |
| 11 Which missing fact matters most? | Combine with 09 close | End with interpretation under assumptions, conditional action and its evidence request. |

### D3S2 Same numbers. Different story.

Source: `Oct14_session2.qmd`. Current duration: 60 minutes. Handout: H8. Session decision: **Pending**. Comments: ____________________

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D3S2-T Title | Retain | Explicit chart/denominator/caption objective. |
| 01 Which chart would you show the director? | Keep | Briefly withhold labels for diagnosis, then reveal them on the same screen. Ask which impression affects a decision. |
| 02 Same values. A different impression. | Combine with 01 | Keep native axis toggle and identical values. Explain distortion without implying all nonzero axes are unacceptable. |
| 03 Where does the axis start? | Keep | Annotate units, sample, period and comparison. Add small underlying data table to verify the bars. |
| 04 Does anyone look like the average? | Expand | Restore distributions with common scales and mean/median/spread. Distinguish selected-record illustration from full-city analysis. |
| 05 49.5% or 58.6%? Both can be right. | Expand | Work a two-business denominator example, then show actual city summaries. Explain weights and questions; neither summary is inherently dishonest. |
| 06 Does this interval settle the decision? | Keep | Retain pilot interval and saving-rule plot. Distinguish estimate uncertainty from individual variation in 04. |
| 07 Write the caption the chart deserves. | Keep | Require population, outcome, period, comparison and causal limit, using the actual chart source. |
| 08 The AI sees cause. Can you? | Restore richer example | Adapt older chart comparison with accurate readings mixed with causal leap, denominator omission or every-business claim. Verify each sentence. |
| 09 Defend your chart. Defend its limit. | Keep | Give pairs a decision/audience and ask them to justify representation and limits. |
| 10 Before trusting a chart, check what? | Keep | Collect annotated figure or caption as evidence of learning, then a short memory check. |

### D3S3 The analyst is in the room

Source: `Oct14_session3_live.qmd`. Current duration: 75 minutes. Handout: H9. Session decision: **Pending**. Comments: ____________________

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D3S3-T Title | Retain | Explicit question/evidence/sign-off objective. |
| 01 Would you sign this note? | Expand source | Restore a realistic one-page draft decision note with recommendation, table and some plausible qualifications. Distinguish it from Day 4's report. Independent opening decision. |
| 02 Follow each claim back to its evidence. | Expand | Map four results to populations/comparisons/assumptions. Explain shared city records and different estimands; agreement in sign is not independent replication. |
| 03 Only three questions. Which ones? | Keep | Groups choose three specific evidence requests from five question families; avoid yes/no assurances. |
| 04 Will 'is it reliable?' get a useful answer? | Model | Restore one weak-to-specific question and follow-up. Show what evidence a satisfactory answer would contain. |
| 05 Choose before the analyst arrives. | Combine with 03 | Ranking, spokesperson and follow-up become one task screen. Protect preparation time. |
| 06 Take a break | Keep | Trainer uses break to prepare fixed evidence responses. |
| 07 The analyst is here. What will you ask? | Keep | Reveal evidence in response to questions where practical. Answers have source IDs; trainer does not invent missing checks. |
| 08 Pilot estimate: 1,014. Enough to act? | Keep as evidence reveal | Show in response to threshold question, or debrief if unasked. Optional commented R demonstration; printed plot available. |
| 09 An answer, a partial answer or no answer? | Keep | Rate actual answer with source and follow-up; disclosure of uncertainty can be useful evidence. |
| 10 What still stands between you and approval? | Combine with 11 | Identify the one unresolved issue most consequential to sign-off. |
| 11 Now would you sign? | Keep | Repeat individual decision and compare reasons. An unchanged decision can reflect improved reasoning. |
| 12 The AI says four studies agree. Do they? | Restore richer example | Adapt older review paragraph with correctly read results/limitations plus overstated independence, threshold certainty or complete-data assurance. |
| 13 Ask for evidence you would actually use. | Combine with 11 close | Write one actionable request and purpose; offer evaluator-question reference for workplace use. |

### D4S1 Would you trust this report?

Source: `Oct15_session1.qmd`. Current duration: 60 minutes. Handout: H10. Session decision: **Pending**. Comments: ____________________

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D4S1-T Title | Retain | Explicit independent report-reading objective. |
| 01 Your own judgement first. No discussion. | Fix orientation | Introduce separate four-page report and worksheet. Direct learners to Sections 1, 2 and 5, not only Pages 1 and 3: pilot comparison is explained in Section 2. State that the report contains claims to scrutinise without identifying the errors. |
| 02 Your first verdict, with a reason. | Keep | Collect independent judgement and cited passage; source remains open. |
| 03 Supported, concern or unsupported? | Model | Work one neutral claim rating. Explain concern versus unsupported and rating a claim versus a whole section. Use words with colours. |
| 04 What survives checking the summary? | Keep | Check summary against design/results; find a strength and a consequential concern. |
| 05 Your section. One strength, one concern. | Keep | Preserve eight allocations 3,4,5,6,7,3,5,7 and passage references. Permit Section 6 to receive supported; do not require every section to be wrong. |
| 06 Put the passage beside the judgement. | Keep | Preserve two A1 sheets. Note format: claim/paragraph, rating, reason. Distinguish worksheet Sheet 1 from wall Sheet 1 in instructions. |
| 07 Why do our ratings differ? | Keep | Compare precise passages; different claims in one section can warrant different ratings. |
| 08 Trace the headline to the finding. | Expand | Restore table beside headline/limitations. Annotate chosen largest estimate, intervals crossing rule and preferred city analysis. Explain selective reporting through source tracing. |
| 09 A confident AI verdict. A supported one? | Restore richer example | Use a plausible complete-report review that acknowledges strengths and some limits but misses a consequential overclaim. Check completeness as well as correctness. |
| 10 Your final verdict: what changed? | Keep | Repeat independent source-based judgement. Assess reading separately from agreement with a particular recommendation. |
| 11 One question you still need answered. | Combine with 10 close | Collect specific request, return feedback and identify targeted retries for S2. |

### D4S2 What should the director do next?

Source: `Oct15_session2_live.qmd`; non-live alias mirrors it. Current duration: 60 minutes. Handout: H11. Session decision: **Pending**. Comments: ____________________

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D4S2-T Title | Retain | Explicit evidence-to-recommendation objective. |
| 01 The corrected findings are on your desk. | Clarify | Name the NEW drafting source, distinct from the flawed review report. Provide source index linking findings to comparisons. |
| 02 What does the director need to decide? | Expand | Specify hypothetical scale, eligibility and budget choice and unknowns. Learners need a concrete decision to advise on. |
| 03 What makes this brief useful? | Expand | Restore worked short brief with four elements annotated and a contrasting weak sentence. Explain how action follows from evidence; keep model answer off independent draft sheet. |
| 04 150 words. What should happen next? | Keep | Confirm word limit; allow source references outside it. Protect drafting time and require connected prose using the corrected findings. |
| 05 Would you sign your partner's brief? | Keep | Use rubric: comparison/population, result/interval, proportional action, important limit, specific evidence request. |
| 06 Which sentence needs changing? | Keep | Require substantive revision and explanation of how it changes the advice, not only wording polish. |
| 07 Which claim did the AI add? | Restore richer example | Adapt older coherent AI brief to GreenWaste with correct numbers, a defensible sentence and an unsupported national/cost assurance. Compare with learner draft. |
| 08 Defend the action and its conditions. | Keep | Permit different defensible actions. Challenge each with evidence and an answer that could change its conditions. |
| 09 Ask for the next piece of evidence. | Keep | Complete targeted retries and independent request. Hand over to other provider's simulation; do not restore our former Session 3. |

## Additional slides and session time budgets

These additions answer the question of what is missing between a definition, a result and the learner's task. They are proposed screens, not extra topics. An ADD ID is a stable discussion reference; its final slide number comes after sequence agreement. Where the desired content already exists on one enlarged baseline slide, split it into two focused screens rather than showing the explanation twice.

### Opening slides already added by Fiona

| ID | Position and title | Treatment in this plan | Proposed time |
|---|---|---|---|
| D1S1-F1 | Before original 01: The GreenWaste case study | Preserve her source addition, use the case map and distribute the case card. Explain intervention, settings, outcomes and period. No duplicate new introduction. | 4 minutes |
| D1S1-F2 | After F1: Where does GreenWaste fit? | Preserve her theory-of-change bridge. Highlight the measured outcomes and distinguish delivery outputs from caused outcomes. Simplify the six-column visual if necessary after render review. | 4 minutes |

These eight minutes form D1S1's opening allocation below, not extra time on top of it. The original entry check can become the transition into the first explanation.

### Proposed explanatory insertions

| New ID | Position in agreed sequence | Proposed title and purpose | Visual, learner work and matching paper | Time within session budget |
|---|---|---|---|---|
| D1S1-ADD1 | D1S1-P05 | One large business changes the average | Dot plot before/after removing the largest selected actual annual cost; compare recomputed mean and median. Learners predict before reveal. H1 adds one comparison field; no relabelled tonne values. | 4 minutes |
| D1S1-ADD2 | After interval explanation, original 06, before decision-rule reading | Same estimate. Three different levels of uncertainty. | Three hypothetical intervals around the same estimate with a common decision threshold. Learners explain what changes and what does not. H1 gets the figure and interpretation question. This replaces extra repeated-sample slides if both cannot be taught clearly. | 5 minutes |
| D1S1-ADD3 | After p-value explanation, original 07 | Statistically clear. Large enough to matter? | Compare a precise small change with a less precise larger change; show estimate, interval and relevant threshold. Hypothetical examples must be coherent, with p-values computed if displayed. H1 supplies both rows. | 4 minutes |
| D1S2-ADD1 | After brief city/cost reminder, before descriptive summaries | One row. One business. Two measurements. | Selected real rows with highlighted ID, participation and before/after columns. Learner describes one business in words. H2 includes those rows, not the entire dataset. Split from the source-orientation content planned for original 04. | 5 minutes |
| D1S2-ADD2 | After ADD1, before cost histogram | Who is included in these averages? | Count chart: 4,794 city participants and 5,206 other businesses. Explain the score rule and denominator of each mean. H2 adds source/sample caption; no additional worksheet exercise required. | 3 minutes |
| D1S2-ADD3 | After participant before/after means | Did every business's cost fall? | Distribution of business-level changes with zero marked; distinguish a mean fall from a fall for everyone. H2 adds one supported statement and one limit. This is different from the baseline-cost distribution. | 5 minutes |
| D1S2-ADD4 | After worked before/after and with/without comparisons | Two numbers. Two different comparisons. | -669 and -1,638 on matched mini-timelines, showing groups and starting costs. Learners identify what each misses. H2 includes comparison summary. Original 06 provides the worked steps; this screen consolidates them and bridges to the pilot. | 5 minutes |
| D1S3-ADD1 | After lottery demonstration, before post-period result | Were the pilot groups similar at the start? | Baseline cost distribution/means for randomly assigned groups, including 1,390 versus 1,411. Explain chance imbalance; do not use a non-significant balance test as proof of successful randomisation. H3 includes source and question. | 5 minutes |
| D1S3-ADD2 | After pilot result and before threshold decision | Two group means become one coefficient | Work 769 minus 1,783 ≈ -1,014, then highlight the corresponding regression row. Show reference group, outcome and period. Split original 07 so arithmetic is understood before output is interpreted. H3 supplies both displays. | 6 minutes |
| D2S1-ADD1 | Between four-number task and result interpretation, originals 03–04 | Where is the extra change in this table? | Annotated teaching regression output with participant, after and interaction rows. The interaction is the DiD row; other rows have different meanings. Link to manual arithmetic without a syntax lesson. H4 includes clean output for annotation. | 6 minutes |
| D2S2-ADD1 | Before local result interpretation, original 05 | A gap between averages is not the fitted jump | Same score/cost scatterplot, raw card means and fitted lines meeting the cutoff. Explain slope adjustment and why the A–H activity need not reproduce -721. H5 supplies the plot. | 6 minutes |
| D2S2-ADD2 | Before checklist, original 08 | Could businesses influence which side they landed on? | Clearly hypothetical score-density picture plus explanation of what a real manipulation check could show. No claim that GreenWaste has passed a test. H5 adds score-setting evidence request. | 4 minutes |
| D2S3-ADD1 | Before full matching result, original 05 | One comparison business can be used many times | Link diagram showing replacement, repeated controls and distinction between participants and unique controls. Use canonical full-study counts alongside a small illustrative diagram. H6 adds reuse interpretation. | 5 minutes |
| D2S3-ADD2 | After matching process/balance explanation, original 06 | Closest available does not always mean close enough | Paired hypothetical overlap examples, clearly separated from actual balance output. Explain weak support/poor matches without claiming a caliper was applied here. H6 includes a question about acceptable match quality. | 5 minutes |
| D3S1-ADD1 | After input table, original 03, before ratio result | When do the costs and savings happen? | Cash-flow timeline: cost now, no year-1 saving, savings in years 2–6. Learners distinguish assumption from estimate. Split timeline from the input list. H7 includes both. | 5 minutes |
| D3S1-ADD2 | After basic discount explanation, original 05 | From future savings to today's total | Work one discounted annual amount and show the sum over the stated saving years; connect present-value benefits, costs, ratio and NPV. No second coding exercise. H7 contains the worked reference. | 6 minutes |
| D3S2-ADD1 | Before actual 49.5%/58.6% comparison, original 05 | Two businesses. Two ways to calculate a percentage. | Small hypothetical two-business table worked step by step, showing total-weighted fall versus equally weighted business percentages. H8 provides blanks before the city summary. | 6 minutes |
| D3S3-ADD1 | Between note/source comparison and question selection, originals 02–03 | Which result answers which decision? | Matrix of pilot/city/local populations, comparison and key assumption. Learners select a result relevant to the proposed action before questioning it. Use as a source reference during role-play; H9 supplies the matrix. | 5 minutes |
| D4S1 | No additional technical lecture screen proposed | Protect independent report reading | Expand source orientation and table debrief on existing screens. Use the longer slot for reading, section discussion and feedback; do not coach the independent answers immediately before assessment. | See budget below |
| D4S2-ADD1 | After source orientation, before worked brief, originals 01–03 | Which finding supports this sentence? | Trace a worked brief sentence to numbered corrected finding, comparison and interval; contrast with a sentence the source cannot support. H11 includes source index; worked answer remains on teaching/reference material, not the independent draft sheet. | 5 minutes |

The insertion catalogue contains **19 proposed explanatory screens**, plus Fiona's two existing opening additions. Some split content already assigned to an expanded slide; they are not 19 new concepts. The Day 1 P tables incorporate these and further splits explicitly, and take precedence for Day 1 order/timing. Final proposed Day 1 counts are 17/15/16 content screens; title screens have no additional time.

### A second screen for each restored AI Snapshot

For each session with an AI exercise (all except D4S1, see budget note), use the existing AI/repair screen as the first stage: a realistic supplied response, its naive prompt context and exact source. Then insert **D1S1-AI2, D1S2-AI2, D1S3-AI2, D2S1-AI2, D2S2-AI2, D2S3-AI2, D3S1-AI2, D3S2-AI2, D3S3-AI2 and D4S2-AI2** immediately afterwards. These are ten proposed additional screens, not ten additional exercises.

Each AI2 screen is titled for that session's task, for example Ask for a table reading you can verify or Ask for a recommendation tied to the evidence. It supplies the better prompt with context, decision, relevant data and limitations; asks AI to request missing information before concluding; and tells learners what to compare with their marked-up response. Keep instructions brief. Handouts H1–H11 carry the realistic response, exact source location and improved prompt/comparison space. Trainer packs carry keys and a prepared second response for the paper fallback.

Allocate **15 minutes total per Snapshot**, not 15 minutes per screen: 5 for markup, 3 for pair/source-check debrief, 4 for the improved prompt and response, and 3 for comparing what improved or remains unsupported. Account setup occurs before teaching; if a response is delayed or unavailable, use the prepared response within the same time. Correctness is checked against the source, not whether two AI outputs agree. General good practice (second-chat review, leading prompts and the rest) goes on the AI good-practice card below, rather than another best-practices slide in every deck.

### AI good-practice card

Agreed by Fiona, 7 October. The shared reference is a one-page printed card, handed out on Day 1 with the first AI Snapshot (D1S1-P15/P16) and kept for the week. Each later stage-2 AI slide carries a one-line reminder that points to it. Proposed content:

> **The fluency of AI output makes rigorous oversight more important. There are fewer obvious signals when something is wrong.**
>
> - **Prompt engineering:** Provide clear context and structure in your query (e.g., role, background, task, output format) and iterate on your instructions to the model.
> - **Agentic review:** Ask an agent without the same context to review your instructions and/or output (e.g., start a new chat, give the agent multiple roles/personas).
> - **Human review:** Critically review the output for accuracy and logical consistency (e.g., does the design make sense, is the response complete, is the flow logical, are there errors you have made or seen others make with this kind of task in the past).
> - **Peer review:** Ask a peer to read your AI-generated code/writing to spot obvious inaccuracies, inconsistencies, etc.
>
> *Reminder: You are ultimately responsible for the quality of the output you create and share, regardless of whether it was AI-generated.*

Optional second block, if it fits on the page (otherwise the back of the card): **prompting tips**, adapted from 3ie's internal "Reminder: Prompting Tips" slide for this audience.

> **Prompting tips: Persona, Task, Context, Format**
>
> *Example:* "**[Persona]** I am a policy adviser deciding whether to expand a business waste programme. **[Task]** I need to understand what this evaluation result supports. **[Context]** I have pasted the results table; our decision rule is a saving of at least 1,000 AED per business per year, and the study compares the same businesses before and after. **[Format]** Ask me questions before you answer. Then give me three short points: what the result shows, what it does not show, and one question to put to the evaluator."
>
> *Other suggestions:*
> - Ask the AI to take the persona of a sceptical evaluation reviewer.
> - Ask for a specific format, such as a table listing each claim beside the evidence that supports it.
> - Give it the decision rule and the limits of the data, so it cannot quietly assume them away.
> - Watch for prompts that push it towards a conclusion (e.g. "write two sentences recommending scale-up").

### Session budgets with the additions included

The following are proposed allocations for review, based on 90/90/120 minutes on Days 1–3 and 90/90 on Day 4. They are not approved slide-by-slide timings. Time estimates in the insertion table sit **inside** these blocks. Existing as-you-go worksheet questions form part of explanation/practice, not a second compulsory full worksheet round.

| Session | Opening/context | Explanation and worked examples | Guided worksheet/activity | Independent source reading or drafting | AI Snapshot | Feedback/close | Total |
|---|---:|---:|---:|---:|---:|---:|---:|
| D1S1 | 8 | 30 | 17 | 10 | 15 | 10 | 90 |
| D1S2 | 5 | 25 | 25 | 10 | 15 | 10 | 90 |
| D1S3 | 5 | 35 | 30 | 20 | 15 | 15 | 120 |
| D2S1 | 5 | 25 | 25 | 10 | 15 | 10 | 90 |
| D2S2 | 5 | 25 | 25 | 10 | 15 | 10 | 90 |
| D2S3 | 5 | 30 | 35 | 20 | 15 | 15 | 120 |
| D3S1 | 5 | 25 | 25 | 10 | 15 | 10 | 90 |
| D3S2 | 5 | 20 | 25 | 15 | 15 | 10 | 90 |
| D3S3 | 5 | 15 | 45 | 20 | 15 | 20 | 120 |
| D4S1 | 5 | 10 | 20 | 35 | 0 | 20 | 90 |
| D4S2 | 5 | 15 | 20 | 25 | 15 | 10 | 90 |

D4S1 (Fiona, 7 October): no AI Snapshot on top of the independent reading check; its 15 minutes go to independent reading and feedback. The current short AI item (D4S1-09) can stay as a brief discussion or be dropped.

The two fixed daily breaks remain outside these session budgets. Current internal break screens in S3 decks should become a brief transition/change of activity unless the timetable is explicitly adjusted to accommodate another break. Day 4's 15-minute feedback/handover is separate from the session budgets and ends before the 12:30–13:00 proposed longer break.

Reconsider the earlier combine proposals as follows: keep sign interpretation visible during coefficient work; keep source-checking AI work separate from ordinary worksheet correction; keep a dedicated decision/debrief screen after substantial group work where needed. Continue combining duplicate headline/vote screens, repeated spokesperson instructions and multiple nearly identical exit questions. A realistic AI response and its better-prompt stage should not be squeezed into one crowded slide.

Provisional final screen range: roughly 14–18 substantive screens for explanation-heavy sessions; fewer for clinics/report workshops. A workshop screen may remain visible for 15–25 minutes. These ranges supersede the earlier 12–16 guide where the additions warrant it; the team should judge explanation and practice time, not slides per minute.

## Handout-by-handout proposals

Paths below refer to the current published participant copies in `docs/handouts/`. Current source generators are `make_day1_materials.R` through `make_day4_materials.R`, called by `make_session_materials.R`; shared print styles come from `reader_material_helpers.R`. Implement agreed changes in those generators, not only in saved Word files.

Each packet should have an identifiable source, an activity and space to respond. Put substantial source reading on a separate reference page where that improves usability. Keep activity numbering and paragraph/table references identical on slides and paper. Suggested extra panels below are additions for review, not a blanket requirement to make every handout longer.

### H1 Day 1 Session 1

File: `Oct12_session1_handouts.docx`. Proposed purpose: Read an annual cost result using five terms. Decision: **Pending**. Comments: ____________________

Use a cost-source reference, as-you-go response sheet and realistic AI task. Proposed question numbering follows teaching order: Q1 mean, Q2 treatment effect, Q3 coefficient, Q4 interval, Q5 p-value and Q6 interpretation. This swaps the current coefficient/treatment-effect question numbers; synchronize all slides, notes, worksheet and key when implementing. Fiona's as-you-go method is preserved.

| Proposed section/item | Replacement and learner work | Proposed slide connection |
|---|---|---|
| Opening source instructions | Identify case card and H1-A city before/after cost table, with physical page location. Explain annual cost AED and 12-month follow-up; no teacher setup prose. | D1S1-P01–P03 |
| Q1 Mean and what it hides | Replace ten landfill values with ten selected real annual cost records, a dot plot and calculation space. Compare mean/median before and after removing largest cost. Recompute answers; the old total 100/mean 10/median 6.5 do not apply to cost records. | P04+P05 |
| Q2 Treatment effect | Observed-versus-missing-no-programme diagram and question about causal comparison. Answer as taught, then revisit after reading coefficient. | P06 |
| H1-A annual cost regression reference | Readable annotated output with intercept/after indicator, interval, p-value, N and source/model note. Explain reference category and units; clean copy available for annotation. | P03+P07–P13 |
| Q3 Coefficient/sign | Mark change row, interpret units/sign, reconstruct after mean and explain why arithmetic reproduces the simple coefficient. | P07+P08 |
| Q4 Confidence interval | Plot change interval; distinguish estimate uncertainty from individual costs. Three hypothetical intervals add comparison task; avoid presenting task answers in the reference. | P09+P10 |
| Q5 P-value | Null-model question plus precise-small/imprecise-larger rows; explain significance versus practical relevance and absence-of-evidence limit. | P11+P12 |
| Q6 Interpretation and pair correction | Learners use completed Q1–Q5 to repair interpretation, compare rule, name causal limit and correct answers with partner. Do not repeat every question independently at the end. | P13+P14 |
| AI Snapshot A: supplied reading | Multi-paragraph realistic response, naive prompt context and exact H1-A source location. Underline supported claims and cross out unsupported claims before debrief. | P15 |
| AI Snapshot B: better prompt/comparison | Printed improved prompt with decision, source, limits and request for clarifying questions; room for source-based comparison of response. Trainer provides paper fallback. | P16 |
| My independent interpretation/request | Cost change, interval, comparison and one causal limit/request. Source table stays available; term explanations closed. | P17 |

### H2 Day 1 Session 2

File: `Oct12_session2_handouts.docx`. Proposed purpose: Read city cost data and question two descriptive comparisons. Decision: **Pending**. Comments: ____________________

Replace the landfill headline and repeated ten-tonne mean task. Supply a named cost-data/figure reference H2-A, response sheet and AI task; retain four-card group work and optional A1 board. All charts/cards here use annual cost AED. Sources are supplied extracts/figures, not a complete report.

| Proposed section/item | Replacement and learner work | Proposed slide connection |
|---|---|---|
| Opening judgement | Replace approximately 50% landfill headline with city -669 cost callback. Ask whether this is an effect and record reason for later comparison. | D1S2-P01 |
| Q1 Meet the data | Selected actual city rows with identifier, participation and before/after COST columns; column key and source. Describe one business in words. Count caption identifies 4,794 participants/5,206 others. | P02+P03 |
| Q2 Describe baseline costs | Histogram with mean/median and labelled population; explain spread and what one average hides. Use full-city/group data, not a second copy of H1's selected ten records. | P04 |
| Q3 Participants before/after | Labelled 1,432→763 chart, after-minus-before fields, individual-change distribution and a hypothetical common-shock question. Interpret descriptive change and reject every-business inference. | P05–P07 |
| Q4 Other businesses and with/without | 2,258→2,401 chart and +143 change; after-only 763 versus 2,401; starting levels and named group/period. Learners calculate and explain limitations without a formal DiD lesson. | P08+P09 |
| Two-comparison summary | -669 and -1,638 with populations/periods and missing-counterfactual question. Do not claim observed group changes alone prove true bias directions. | P10 |
| Q5 Four cost claims | Four response fields with decision, source support, missing question and reason. Cost versions of cards preserve Fiona's distinct claim types; several justified questions are acceptable. | P11+P12 |
| AI Snapshot A: cost-chart reading | Realistic multi-paragraph response and naive prompt; mark support against named H2-A charts/tables before feedback. Core planned activity, not optional unless team explicitly changes allocation. | P13 |
| AI Snapshot B: better prompt/comparison | Supply context, decision and comparison limits; request clarifying questions, run and compare with source. Prepared response is offline alternative. | P14 |
| Independent conclusion/request | State supported descriptive conclusion, missing causal comparison and specific evaluator question. Compare opening reason. | P15 |

### H3 Day 1 Session 3

File: `Oct12_session3_handouts.docx`. Proposed purpose: Interpret the pilot lottery and write a proportionate recommendation. Decision: **Pending**. Comments: ____________________

Use named pilot study extract H3-A and response/AI tasks. Refer back to H2's city comparison summary for the brief recap; do not add a second full weak-comparison worksheet. All substantive Day 1 outcomes remain annual cost AED.

| Proposed section/item | Replacement and learner work | Proposed slide connection |
|---|---|---|
| H3-A programme/design source | Numbered paragraphs, eligible pilot population, exact 200/200 individual assignment, annual cost and follow-up. Distinguish pilot district from rest of city. | D1S3-P02+P03 |
| Q1 Comparison and draw reflection | Who is assigned to join/wait, why chance helps, physical draw/repeated-draw comparison and small-sample chance imbalance. Note demo N=20 separately from actual N=400. | P03–P05 |
| Baseline source panel | Pilot baseline means 1,390/1,411 with distributions; source-labelled. Ask what reassurance and limitation this supplies; no proof from a non-significant test. | P06 |
| Q2 Means and regression row | Post-period means 769/1,783 beside full pilot output. Work difference then annotate treatment coefficient and reference group. Explain why design supports pilot effect reading. | P07+P08 |
| Q3 Interval and rule | Positive-saving number line, 862–1,167 and 1,000 rule; state what is settled and remains uncertain. | P09 |
| Q4 Reach | One district, score ≤58 and trial delivery conditions; request evidence for proposed wider setting. | P10 |
| Three-comparison reference | Compact city-before/after, city-with/without and pilot table with people/periods. Supports comparison, not a new calculation round or assertion of identical target populations. | P11 |
| Q5 Provisional recommendation | Individual action/reason followed by three/four-sentence note and pair source check. Finding, action/condition, important limit and request. | P12+P13 |
| AI Snapshot A: ministerial paragraph | Realistic multi-paragraph response with accurate trial result/qualification and consequential overclaims; naive prompt and exact H3-A source location. Mark before feedback. | P14 |
| AI Snapshot B: better prompt/comparison | Improved trial-aware prompt, clarifying questions and response-source comparison; prepared paper response available. | P15 |
| Independent final request | Revisit recommendation and specify evidence that could change it. Preserve an individual response even after pair work. | P16 |

### H4 Day 2 Session 1

File: `Oct13_session1_handouts.docx`. Current heading: Read the extra change. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| Opening context | Identify city comparison and distinguish the pilot. Supply small programme timeline. | D2S1-01 |
| 1 Complete the four numbers | Keep the arithmetic table and add blank two-line DiD diagram. Learners mark both changes and extra change. State rounded inputs may differ slightly from fitted estimate. | 02+03 |
| 2 Read the result row | Expand to annotated teaching regression output with the interaction row, units, interval and sample/model note. Explicitly link extra-change arithmetic to coefficient. | 04 |
| 3 Question the assumption | Add contrasting hypothetical histories. Ask why different levels can be acceptable and different untreated trends problematic. | 05+06 |
| Report extract | Rename City DiD study extract, with source ID H4-A and numbered paragraphs. Include design, result, assumption and honest one-pre-period limit. It is a supplied extract, not a separately distributed report. | 07+08 |
| Annotation prompt after extract | Refer to specific paragraph/table IDs; distinguish finding, assumption and evidence still absent. | 08 |
| AI Snapshot (stages 1 and 2) | Two-stage AI Snapshot (15 min), restoring the old realistic response with fewer steps. Stage 1: mark up the old realistic answer to "explain this regression table to a decision-maker" (correct estimate, plus unsupported claims that parallel trends is satisfied and the 1,000 AED rule is met), updated to current figures. Stage 2: run the better prompt in Copilot (two waves only, no pre-trend test possible, the 1,000 AED rule, ask me questions first) and compare. No second-chat or "if time" prompt. | 09 |
| Your question from memory | Require one interpretation sentence and one specific evidence request/purpose. | 10 |

### H5 Day 2 Session 2

File: `Oct13_session2_handouts.docx`. Current heading: Read the jump at a score rule. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| The comparison | Add rule diagram and score/cost scatterplot with cutoff and local window. Explain running variable, score direction and exact participation rule. | D2S2-01+02 |
| 1 Record your group card | Preserve mean/subtraction fields and card letter. Label group calculation as a small raw mean gap; all A–H cards remain separate participant activity materials. | 03+04 |
| 2 Read the reported jump | Add fitted plot and fuller result output with local population, 545 businesses, coefficient and HC2 interval. Distinguish fitted cutoff jump from raw card mean differences. | 05 |
| Report extract | Rename Cutoff study extract, with paragraph IDs. Include window results, manager-age jump and absent score-manipulation evidence. No fabricated diagnostic result. | 06+07 |
| Check table | Add explicit score-setting/manipulation row. Distinguish rule compliance from validity of local comparison. Include evidence reference and concern/unknown reason. | 08 |
| New visual-check reference | Supply narrow/wide-window picture and manager-age plot, with hypothetical density illustration labelled separately if used. Adjusted estimate remains optional. | 06–08 |
| AI Snapshot (stages 1 and 2) | Two-stage AI Snapshot (15 min), restoring the old realistic response with fewer steps. Stage 1: mark up the old realistic answer to "explain, without jargon, who this result applies to" (overgeneralises beyond the cutoff), updated to current figures. Stage 2: run the better prompt (cutoff 58, two-point window, most participants score well below 58, manager-age difference, ask me questions first) and compare. | 09 |
| Your next question | Include an interpretation of who the estimate describes before the evidence request. | 10 |

### H6 Day 2 Session 3

File: `Oct13_session3_handouts.docx`. Current heading: Read a matched comparison. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| Opening instruction | Replace inspect the full report with read the full-city study extract supplied on the reference page. Distinguish toy profiles from actual city data. | D2S3-01 |
| 1 Record your pairs before opening costs | Preserve A/B/C pairing, chosen comparison and unused profile. Add reason for each pair, then separate cost-difference fields. Costs remain withheld until choices are recorded. | 02–04 |
| 2 Read the full study result | Explain four-feature matching, replacement and 585 unique controls. Add a reuse diagram rather than leaving sample counts unexplained. | 05 |
| New process/balance panel | Four-step diagram; before/after balance and overlap illustration using computed city values. Label any hypothetical comparison separately. | 06 |
| Report extract | Rename City matching study extract, with paragraph IDs. Explain nearest-neighbour rule, no caliper, residual age gap and reuse. Retain maximum reuse as a reference concern where useful, not a new memorisation target. | 08–10 |
| New sensitivity panel | Side-by-side full-feature and age-omitted result; ask why the comparison changed. Link unrecorded motivation separately as a hypothetical limitation. | 08+09 |
| Your provisional judgement | Retain action/reason/evidence task; require a strength and consequential concern. | 11 |
| AI Snapshot (stages 1 and 2) | Two-stage AI Snapshot (15 min), restoring the old realistic response with fewer steps. Stage 1: adapt the old "what should a commissioner flag?" response to the full four-characteristic result versus the result without manager age (the old two-evaluator comparison), with correct matching facts and subtle bias/threshold assurances. Stage 2: run the better prompt (what was left off the list, were costs similar before, how far apart are unmatched characteristics, decision rule, ask me questions first) and compare. | 12 |
| A question from memory | Integrate into judgement; optional method comparison reference supports transfer. | 13 |

### H7 Day 3 Session 1

File: `Oct14_session1_handouts.docx`. Current heading: Judge a value for money claim. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| 1 Open the inputs behind the headline | Make a named economic model note, not a string of results. Add source of provisional benefit input, cash-flow timeline, perspective and input status. | D3S1-01–03 |
| Input table | Keep assumptions explicit; add units and timing. Separate measured/estimated quantities from fictional cost, duration and discount assumptions. | 03 |
| New worked calculation | Show ratio and net present value with space to explain each. One short discount example connects future amount to today's value. | 04+05 |
| 2 What would you ask about the inputs | Ask for one specific input, required evidence and possible decision consequence. | 03+05 |
| 3 What costs might be missing | Add actor/perspective diagram and included/unknown column to prevent double counting. | 06 |
| Your group scenario | Preserve card number, changed input, prediction/result and plausibility question. Add source for the changed assumption; sufficient handwriting space. | 07–09 |
| AI Snapshot (stages 1 and 2) | Two-stage AI Snapshot (15 min), restoring the old realistic response with fewer steps. Stage 1: mark up the response to the old version-1 prompt ("generate a scenario where the ratio falls below 1, and say whether it is realistic"). Stage 2: run the old version-2 prompt (which inputs are measured and which assumed; which single assumption moves the ratio most; ask me questions first) and compare. Current model figures (1.86). | 10 |
| Your question from memory | Combine with conditional recommendation under stated assumptions. | 11 |

### H8 Day 3 Session 2

File: `Oct14_session2_handouts.docx`. Current heading: Read a chart before trusting its story. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| Source caption and printed cost chart | Provide paired axis versions and small underlying data table. Every figure has population, outcome, period and comparison. Printed versions reproduce the interactive states. | D3S2-01–03 |
| 1 Mark the chart | Preserve axis/unit/source annotation; add legend/scale checks where relevant. | 03 |
| 2 What can it support | Ask for supported descriptive claim and a specific causal limit. Avoid a generic cannot prove anything response. | 03 |
| New distribution figure | Add full-city or clearly labelled illustrative distribution, mean/median and a variability question. | 04 |
| Two summaries of participant landfill waste | Keep actual percentages; add worked two-business example and explicit denominator/weight calculation. | 05 |
| New pilot interval figure | Add a compact reference if the interval discussion stays core; label it a different outcome/design from landfill. | 06 |
| Repair the cost chart caption | Retain population/outcome/period/comparison/limit task with generous writing space. | 07 |
| AI Snapshot (stages 1 and 2) | Two-stage AI Snapshot (15 min), restoring the old realistic response with fewer steps. Stage 1: mark up the old realistic answer to "which of these two charts better represents the difference?" (defends the truncated axis), redrawn from current data. Stage 2: run the better prompt that ties the chart to the claim it will sit beside, for a non-technical reader, and compare. | 08 |
| Your check from memory | Keep concise; the annotated figure and final caption are the main evidence of learning. | 09+10 |

### H9 Day 3 Session 3

File: `Oct14_session3_handouts.docx`. Current heading: Question the analyst. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| The note offered for sign off | Expand three assertions into realistic one-page draft note with paragraphs, result table and some qualifications. Label note H9-A; it is not Day 4's review report. | D3S3-01 |
| Four-method result table | Add population/comparison and evidence IDs; keep intervals on positive-saving scale. Explicitly identify shared city data. | 02 |
| My opening decision/reason | Preserve independent response; source citation required. | 01 |
| Choose three questions and request evidence | Preserve five families, but provide space for all three selected specific questions and a follow-up, rather than only top question. | 03–05 |
| Answer log | Keep question/answer/evidence/rating. Enlarge space and add follow-up/action. A separate sheet may be justified for three substantial exchanges. | 07–09 |
| The unresolved issue that matters most | Connect issue to a possible action rather than an undirected concern list. | 10 |
| My final decision and reason | Retain individual decision and compare source-based reasons. | 11 |
| AI Snapshot (stages 1 and 2) | Two-stage AI Snapshot (15 min), restoring the old realistic response with fewer steps. Stage 1: mark up the response to the old Prompt A ("list the critical questions…" for a four-method evaluation). Stage 2: run the old Prompt B (decision, threshold, which single assumption each design rests on, what evidence would change the advice, ask me questions first) and compare. Current figures; keep within 15 min alongside the clinic. | 12 |
| My independent request to the evaluator | Require document/result, purpose and how advice might change. | 13 |

### H10 Day 4 Session 1

File: `Oct15_session1_handouts.docx`. Current heading: Read the report independently. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| Opening source instructions | Name separately supplied GreenWaste review report and direct learners to Sections 1, 2 and 5. Section IDs take precedence over page numbers, which can change with layout. | D4S1-01 |
| Question 1 Outcome/units/period/population | Keep; point to pilot result row and programme description. Assess identification, not recognition of a memorised number. | 01 |
| Question 2 Comparison/fairness | Keep; include Section 2 in assigned reading so learners have the required source. Ask why lottery helps, not merely who was compared. | 01 |
| Question 3 Estimate/interval/rule | Keep interpretation requirement; allow correct positive-saving or negative-cost language with consistent endpoints. | 01 |
| Question 4 Concern/source citation | Keep; accept a consequential cited concern, not only the trainer's preferred error. | 01 |
| Question 5 Recommendation/request | Keep; score proportionality and evidence use separately from choice of action. | 01 |
| My opening judgement | Preserve independent source-based reason. | 02 |
| Rate the report using its evidence | Clarify claim-level rating within each section. Include paragraph IDs, words with colours, reason and evidence that would change judgement. | 03–07 |
| Our strongest supported passage | Preserve to counter blanket fault finding. A correct limitations disclosure can be a strength. | 04+05 |
| The concern that matters most | Require consequence for the decision and evidence that could resolve it. | 07+08 |
| AI item | No AI Snapshot in this session (Fiona, 7 October): the independent reading check takes priority. Keep the short AI verdict as an optional brief discussion, or drop it. | 09 |
| My final judgement and independent request | Keep. Return targeted reading feedback and separate retry instructions. | 10+11 |

### H11 Day 4 Session 2

File: `Oct15_session2_handouts.docx`. Current heading: Write a defensible recommendation. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| Opening instructions | Name corrected findings document and state it replaces the review report as drafting evidence. Add exact hypothetical decision. Confirm 150-word limit and treatment of source citations. | D4S2-01+02 |
| Finding and source | Require comparison/population and interval where material, with finding/paragraph reference. | 03+04 |
| Recommendation and condition | State action, scale and condition; different proportionate actions are acceptable. | 04 |
| Important risk or limit | Tie risk to recommendation; avoid boilerplate more research is needed. | 04 |
| Next evidence and its purpose | Request specific document/result and explain its effect on the decision. | 04 |
| Your partner checks the source | Add visible compact rubric: source, comparison, result/interval, reach, action, risk and request. | 05 |
| Specific suggested repair and finding number | Keep source reference; require substantive repair. | 05 |
| My revised sentence and its effect | Keep explanation of how advice changes. Provide space for final connected brief, on reverse/separate paper if needed. | 06+08 |
| AI Snapshot (stages 1 and 2) | Two-stage AI Snapshot (15 min), restoring the old realistic response with fewer steps. Stage 1: mark up the old AI-written one-page brief (headline, implications, recommendation, risk), rewritten for GreenWaste from the corrected findings: find what it gets wrong and what it leaves out. Stage 2: run a better prompt (decision, corrected findings, 150 words, interval against the rule, ask me questions first) and compare with your own draft. | 07 |
| My independent request and purpose | Keep final independent evidence request. | 09 |
| Retry instruction | Refer to a separately handed-out numbered retry slip; feedback explains the missed ability. Record revised reading result separately. | 09 |

## Supplementary references, cards, posters and trainer packs

These are part of the plan because activity materials cannot be reviewed solely through the participant worksheet. Items below are covered individually; their existing identifiers should remain stable during the discussion.

| Material | Proposed revision or retention | Review decision |
|---|---|---|
| AI good-practice card (new) | One page, printed for every participant, handed out with the first AI Snapshot on Day 1. Content agreed in "AI good-practice card" above. | Agreed by Fiona |
| `GreenWaste_case_card.docx` | Make this the opening reference in D1S1. Retain pilot/city picture, add programme components and outcome/timing key. Use businesses consistently rather than switching between shops and businesses. Avoid an overcrowded map. | Pending |
| `GreenWaste_case_brief.docx` | Retain as technical case reference. First page: intervention/design/outcomes; second: data/means. Remove the participant-facing instruction to use the picture card. Give stable paragraph/table IDs. Avoid repeating the fictional notice. | Pending |
| `Oct14_session3_qa_checklist.docx` | Keep optional workplace reference; add a worked specific evidence request under each question family and space for follow-up. Do not distribute a duplicate worksheet without explaining purpose. | Pending |
| `Oct15_session1_report.docx` | Retain four-page review task; make overclaims more plausible, mixed with genuine strengths and useful disclosures. Restore realistic report prose and annotated design/table references without highlighting faults. Keep all correct figures; assess errors in attribution, uncertainty, selection and reach. Number paragraphs and sections. | Pending |
| `Oct15_session1_rating_sheet.docx` | Currently duplicates H10. Choose one participant route or label this explicitly as the alternative standalone worksheet; keep content synchronised. | Pending |
| `Oct15_session2_findings.docx` | Keep corrected authoritative drafting source. Expand short findings into enough design/context to support independent writing. Add precise numbered anchors, result table and input/assumption distinction. Explicitly distinguish it from the flawed report. | Pending |
| `Oct15_session2_brief_template.docx` | Keep only as an optional standalone version of H11's drafting side. Explain alternative use; no duplicate compulsory task. | Pending |
| H2 claim card 1 | Cost version: city participants' annual costs fell 669 AED over 12 months. Identify source and population, with no causal label or comparison group. Learners explain the missing counterfactual. | Proposed conversion; approval pending |
| H2 claim card 2 | Cost version: label the -669 before/after change as an effect, alongside interval -684 to -654 and exact source. Deliberate causal wording is for critique, not endorsement. Precision does not validate attribution. | Proposed conversion; approval pending |
| H2 claim card 3 | Cost version: correct small p-value for reported city change, then nationwide recommendation. Use a plausible short paragraph; learners separate significance, minimum saving and reach. | Proposed conversion; approval pending |
| H2 claim card 4 | Cost version: participants' costs fell 669 AED while other city businesses' costs rose 143 AED, without uncertainty/assumption evidence. Learners identify what is still needed; do not call the extra change a proven DiD effect. | Proposed conversion; approval pending |
| `Oct12_session2_board_A1.pdf` on Fiona's main branch | Fiona has renamed the former `Oct12_session1_board_A1.pdf` throughout her source changes. Preserve the corrected Session 2 name when integrating; do not repeat the rename. Retain optional triage grid with word labels and room for numbers/reasons. | Rename in main; integration pending |
| RDD cards A, B, C, D, E, F, G, H | Retain all eight distinct seeded cards, six businesses each side. Improve score/units/subtraction guidance and writing space. Each card remains a participant activity, with no key visible. Recheck each answer against source values. | Pending |
| `Oct13_session2_board_A1.pdf` | Retain -2,000 to +500 line and two lanes. Label raw card gaps versus fitted local estimate/interval; label the -1,000 cost-change rule and its equivalent positive saving. | Pending |
| Matching profiles A, B, C, 1, 2, 3, 4 | Retain original identifiers, ages and sizes. Clear fronts/cut lines; no costs on front. Explain that unused comparison 4 is a toy profile, not an excluded full-study participant. | Pending |
| Matching cost slips for all seven profiles | Keep separate and reveal only after recorded pair choices. Match IDs exactly and provide participant-minus-comparison formula. Recheck all toy differences and key. | Pending |
| Economic scenario 1 Old habits | Retain benefit-decay change and exact input wording. Ask for reason/prediction before result. Canonical ratio 1.07. | Pending |
| Economic scenario 2 Hidden costs | Retain added-cost change; clarify it is not already included. Canonical ratio 1.40. | Pending |
| Economic scenario 3 Higher discount rate | Retain 8% alternative and connect it to the timing explanation. Canonical ratio 1.67. | Pending |
| Economic scenario 4 Shorter life | Retain three saving years and explicit timeline. Canonical ratio 1.17. | Pending |
| Economic scenario 5 Old habits and hidden costs | Retain combined changes; identify both precisely. Canonical ratio 0.80. | Pending |
| `Oct14_session1_board_A1.pdf` | Retain prediction and result lanes, break-even 1 and corrected 1.86 headline. Include scenario IDs; debrief why only scenario 5 falls below 1 under these settings. | Pending |
| `Oct15_session1_board_A1.pdf`, sheet 1 | Retain executive-summary grid; word labels and paragraph IDs on notes. Distinguish wall sheet from worksheet side. | Pending |
| Same PDF, sheet 2 | Retain Sections 3–7 grid and supported/concern/unsupported rows. Rate a named claim; Section 6 can be supported. Do not require one colour for an entire section. | Pending |
| `Module2_exercise_plan_v3.docx` | Reconcile after decisions: eleven owned sessions, confirmed timetable, new slide/source IDs, copy counts, group allocations, distribution order, room kit and simulation handover. Historical twelve-session instructions must not govern delivery. | Pending |

### Trainer packs — one proposal for each session

Current copies: `docs/trainer/Oct12_session1_materials.docx` through `Oct15_session2_materials.docx`, excluding the removed Session 3. Retain separate keys; distinguish participant cut-outs from trainer-only answers inside each pack.

| Pack | Required revision |
|---|---|
| D1S1 | Preserve Fiona's introduction/ToC scripts; recompute selected cost example and key; follow proposed Q1–Q6 delivery order with Q2 effect/Q3 coefficient. Add worked table/CI/null explanations, misconception feedback, pair correction and both AI stages/fallback. Explain model-specific intercept. |
| D1S2 | Replace landfill teaching/key with cost data, distribution, before/after and with/without; compute converted four-card sources and preserve A1 method. Remove stale next-session uncertainty note. Add realistic cost-chart AI markup, better prompt and source checks. |
| D1S3 | Move extended city comparison explanation to S2 and leave short recap. Add physical age-slip draw, pilot baseline/post means/regression, source IDs, richer ministerial AI stages and transfer limits. Distinguish demo N=20 from pilot N=400; no extra unbudgeted break. |
| D2S1 | Explain DiD diagram, interaction coefficient, rounding and parallel-trends counterfactual. State that one pre-period cannot show prior trends. Update richer AI key. |
| D2S2 | Retain keys for every A–H card and board setup. Add scatterplot explanation, local slopes, robust interval, window/balance/manipulation discussion and adjusted-result extension. |
| D2S3 | Keep profile/cost distribution order and toy key. Add process/balance/overlap/reuse explanations, sensitivity interpretation and acceptable source-based judgements. |
| D3S1 | Add cash-flow/discounting worked example and perspective guidance; preserve five-card answers and allocations. Include ratio versus NPV interpretation and provisional causal-benefit caveat. |
| D3S2 | Add axis/distribution/denominator workings, corrected caption examples and explanation of when different summaries are appropriate. |
| D3S3 | Expand fixed analyst answer bank with evidence IDs, satisfactory follow-ups and honest unavailable evidence. Add realistic note/AI review keys; do not improvise reassuring diagnostics. |
| D4S1 | Fix assigned reading, keep item-level rubric and alternative defensible responses, synchronise report paragraph IDs, section allocations, wall guidance and targeted retries. |
| D4S2 | Add worked brief/weak-sentence explanation, peer-review rubric and source-linked alternative recommendations. Synchronise corrected findings, richer AI brief and retry feedback. |

All packs should receive final timings after session allocations are agreed within the confirmed 09:00–15:00 day. Add optional technical extensions explicitly, so trainers can explain a question without accidentally making every extension part of the session. Following Fiona's item 1, rewrite speaker notes as a facilitator script: what to say, what to ask, answer to listen for and transition. Label every worksheet task by question, grouping and minutes; keep build history in the handoff instead.

## Reconciliation with Fiona's new review notes

This section was added after locating her two 7 October commits on main. It records proposals and source work; it does not merge branches or approve the draft restructure. Her reference for pre-rebuild material is `2993d01`, a later and more relevant restoration reference than `217858a` where the simple case had already been adapted.

| Fiona's item/status | Relationship to this plan | Specific follow-up for review |
|---|---|---|
| Implemented in source: two opening S1 slides | Addresses our D1S1-01 gap. These slides are The GreenWaste case study and Where does GreenWaste fit? They precede the original content, so original row IDs remain stable. | Preserve case map and Module 1 theory-of-change bridge. Check the outcome highlight, readability and consistent programme description. Do not create a duplicate introduction. |
| Source edit: hide mean answer | Matches explanation/attempt/reveal approach. | Preserve delayed answer and worksheet Q1 instruction; apply the same check across all decks. |
| Source edit: minus-sign explanation | Improves D1S1-05 and adds paper/internet fallback. | Preserve outcome-dependent interpretation when combining with coefficient explanation. |
| Source edit: S2 brief case reminder | Incorporated into D1S2-P01. | Preserve reminder and use the cost outcome, without a second full introduction. |
| Source edit: triage-poster rename | Resolves legacy filename confusion. | Integrate all renamed references and archive contents without restoring the old name. |
| Source timings still total 60 minutes | Superseded as a planning constraint by confirmed daily schedule. | Reallocate explanation/practice to proposed 90-minute slot after sequence agreement; do not preserve 60 minutes solely because source notes currently say it. |
| Item 1: facilitator scripts | Missing from our original row-level notes. | Add task IDs, grouping, timing, expected answers and transitions to every session; remove build-log wording. |
| Items 2 and 15: participant-facing copy | Supports our source-clarity audit; identifies two additional concrete errors. | Remove trainer sentence from case brief and planted-overclaims wording from corrected findings. Fix yesterday's flawed report in D4S2 notes: the report is read the same morning. |
| Items 3, 6b and 6c: restore explanations, figures and sources | Strong agreement with plan. | Use `2993d01` to inspect original source sections and realistic handout content; restore useful detail, not obsolete models or a mandatory old word count. |
| Item 4: answers visible before attempts | Requires an explicit review criterion. | Audit slide/handout answer visibility, including mean, arithmetic, plots and AI flags. Reveal only after an attempt; keys stay separate. |
| Item 5: exercise-plan header Running brief for PwC | Intended audience unresolved. | Confirm who uses the brief; update heading after agreement, without assuming client delivery. |
| Items 6 and 7: programme consistency and ToC typo | Supports case orientation. | Agree one intervention description. Keep simplified less waste to landfill wording; do not reuse the original increase typo from the saved Module 1 image. |
| Item 8: worksheet as you go, recorded DECIDED | Incorporated directly in H1 and D1S1-P04–P14. | Each concept ends with its question; later practice is pair correction/Q6. Proposed numbering follows delivery order, with Q2 treatment effect/Q3 coefficient. Synchronize all source references. |
| Items 9–12: S2 role, missing descriptives and duplication | Incorporated directly in D1S2 and H2. | Annual cost records, counts, histogram, individual changes and weak comparisons replace the landfill sequence. No repeated ten-business mean in S2. |
| Item 13: AI Snapshot sequence, recorded DECIDED | More participatory than our original authored-only proposal. | Every core AI task gets naive prompt context, realistic multi-paragraph supplied response, source markup, better prompt run/comparison and paper fallback. Keep second-chat checking/leading-prompt cautions as general guidance, not repeated compulsory exercises. |
| Item 14: exact source names, recorded TO DO | Matches our source IDs, but wording must include physical location. | First mention names document and location, e.g. short DiD study extract on worksheet page 2. IDs alone are insufficient. |
| Item 16: realistic report and adequate corrected findings | Strong agreement with H10/H11 proposal. | Compare both old/current documents section by section; restore methods/context needed for independent reading/writing. Do not announce planted errors to participants. |
| Proposed Day 1 restructure, explicitly DRAFT | Now the sole proposed Day 1 sequence in the slide/handout tables above; teaching approval remains pending. | Terms first; costs throughout; restore context, explanations and AI tasks. No alternative landfill S2 sequence remains in the plan. |

### Reconciliation outcome

The primary Day 1 tables now implement Fiona's suggestions as a concrete review proposal: 17/15/16 content screens, timed to 90/90/120 minutes, with cost-based H1/H2/H3, as-you-go questions and two-stage AI tasks. This section records provenance rather than offering another sequence. Actual deck/Word changes await review approval; recompute selected cost statistics and converted cards before building. Do not relabel the old ten-tonne example as costs.

Fiona's draft suggests -669 before/after is too small and -1,638 with/without too large. The designed case allows discussion of these directions, but the rise among non-participants and starting-level gap alone do not prove the true causal bias direction in an arbitrary evaluation. Explain the assumptions and use the pilot as its own population-specific estimate; do not call it ground truth for the whole city's effect.

## What to recover from the older decks

Use `2993d01` (the last version before the 6 October rebuild, already on the simple GreenWaste case) as the main reference for restoring slides and handout tasks, and `217858a` for older devices. Restore the types of slides, not a wholesale replacement. **The dataset changed (corrected 6 October): recompute every restored figure, table and number from the current `evaluation_data_GreenWaste_simple.csv`; never copy numbers from old slides** (e.g. DiD -812, not -816; RDD -721 with the HC2 interval, not -656).

| Destination | Older slide or task to consult | Adaptation boundary |
|---|---|---|
| D1S1 mean/coefficient | Word 1 — What the mean hides; Word 3 — The other rows of a table | Use business outcomes; choose a compact output and explain reference categories. |
| D1S1 p-value/interval | Word 4 — p-value: shuffle the labels; Word 4 — The warning cuts both ways; Word 5 — Confidence interval | Hypothetical statistically valid null/coverage illustration; no false random-assignment claim in before/after case. |
| D1S2 data/descriptive reading | One row, one road segment, one year; Who is in the data?; Did every road fall?; Annotate this output | City business cost records, distributions and explicit sources; no traffic case return. |
| D1S3 comparison/lottery | Two biases, opposite directions; What the lottery buys you; The effect is a difference of two averages; The regression gives the same number | Current individual business lottery, not old neighbourhood-cluster design. |
| D2S1 | Visualising the DiD; Reading the table; Everything rests on one assumption | Current extra change and actual data limits; do not restore misleading prior-trend testing. |
| D2S2 | The picture the method is built on; Seeing the jump; Check 2: did anyone bend the rule?; Check 3: are the two sides alike? | Correct score-58 data, HC2 interval and local reach; manipulation evidence is absent. |
| D2S3 | Implementing matching: four steps; Did matching work? Balance; What matching can and cannot see | Current features, reuse and residual balance; do not restore second traffic case or obsolete matching recipe. |
| D3S1 | What went into that number; A saving next year is worth less than one today; The calculator | Current cash-flow model, 1.86 ratio, provisional 812 benefit input. |
| D3S2 | The same comparison, as distributions; Try it: one change, two averages | Current business data and denominators; do not restore unrelated pie/school-zone exercises. |
| D3S3 | The answers that cost the analyst something; Who is each estimate about?; Who is missing from the data? | Evidence-backed fixed answer bank and realistic note, not multiple new labs. |
| D4S1 | The table you should look at twice; The strengths are real; What AI got, and what it could not get | Current report, useful strengths, subtle overclaims and paragraph references. |
| D4S2 | Four elements, one page; Test your headline; Run the checks on a draft | GreenWaste decision and corrected findings, not Tariff Shield. |
| All AI tasks | Each session's original AI Snapshot/prompt, debrief and better-prompt sequence | Keep realistic task structure; update data and scope; no repeated external-chat requirement. |

## Figures and distinctions that must stay consistent

The revision should change explanation, not silently change the approved training data. Use current shared case scripts and recompute source outputs when building approved changes.

| Quantity | Current reference |
|---|---|
| Pilot | 400 businesses; 200 assigned to join, 200 to wait; all score at or below 58. |
| City | 10,000 businesses; 4,794 participants and 5,206 others. |
| City participant before/after cost change | -669 AED, interval -684 to -654; starting mean 1,432, after mean approximately 763. Descriptive comparison. |
| City DiD extra change | -812 AED; interval -833 to -792. Causal reading requires parallel untreated change; only one pre-period supplied. |
| Pilot comparison | -1,014 AED; interval -1,167 to -862. Positive saving presentation: 1,014, interval 862 to 1,167. |
| Cutoff comparison, two-point window | -721 AED; HC2 interval -943 to -498; 545 businesses. Five-point estimate -784; age-adjusted two-point estimate approximately -632. |
| Age cutoff diagnostic | About 5.3 years younger just below cutoff in five-point window; a credibility concern. |
| Matching | -1,029 AED; interval -1,200 to -859. 4,794 participants matched with replacement to 585 distinct controls; maximum reuse 440; mean age gap remains 3.0 years. |
| Matching without age | -1,341 AED. |
| Economic model | Provisional benefit 812 AED; cost 1,800 now; five saving years in years 2–6; discount 5%; benefits at today's value approximately 3,350; ratio 1.86. These model assumptions are fictional. |
| Economic scenarios | Ratios 1.07, 1.40, 1.67, 1.17, 0.80 for cards 1–5 respectively. |
| Landfill summaries | Total tonnes fall 49.5%; mean of business percentage falls 58.6%. Different weights/questions; neither establishes cause. |
| Historical ten selected landfill records | 3,4,5,5,6,7,7,8,9,46; total 100; mean 10; median 6.5. Not a representative sample. Retained here as baseline reference only; proposed Day 1 uses newly selected cost records with recomputed statistics. |

Confidence intervals describe statistical uncertainty under the model and assumptions, not all possible bias. A small p-value does not establish cause or policy importance. A non-significant result does not prove no effect. A point estimate above the minimum does not settle the minimum when its interval crosses it. Shared analyses of city records are not independent studies. Complete synthetic rows do not establish real-world measurement quality. The 1,000 AED rule is a fictional teaching decision rule, not a complete economic approval criterion.

## Review and implementation after agreement

1. Lucas, Fiona and colleagues settle session allocations within the confirmed daily schedule, technical depth and Day 1 roles, then mark each session's proposals accepted, revised or deferred. Capture disagreements beside the relevant stable slide/handout ID.
2. Before implementing any session, fetch again and compare colleagues' direct edits. Preserve them or discuss substantive conflicts; this plan's baseline is not permission to overwrite later work.
3. Agree a concrete final sequence for that session, including source/reference pages and core versus optional AI/technical tasks. Set timings to protect explanation, independent reading and feedback.
4. Update shared title catalog, deck builders, material generators and source references together. Revise CLAUDE.md and the top-level plan/handoff so historical twelve-session/timing/print instructions cannot be mistaken for current instructions.
5. Recompute tables/figures and check slide-paper-key consistency. Render all changed print pages and inspect readability, response space, cut lines and poster labels. Walk all revised slides with reveals open; check charts, output, keyboard interaction and R fallback.
6. Rehearse one unfamiliar colleague through the instructions: can they identify the programme, comparison and source without oral rescue? Check that richer explanations resolve confusion rather than add vocabulary without examples.
7. Review concrete preview decks and print outputs with the team. Publish only after the revised materials receive approval; this document itself authorises no deployment.

### Discussion record

| Reviewer/date | Slide or handout ID | Accept / revise / defer | Reason or proposed alternative |
|---|---|---|---|
| Fiona, 7 Oct | Day 1 (D1S1-D1S3, H1-H3) | Accept | Cost-focused sequence, recomputed cost mean example, "two weak comparisons" wording and change-of-activity instead of the D1S3 break. |
| Fiona, 7 Oct | AI tasks, all sessions | Accept with changes | Copilot (no setup); 15 minutes per Snapshot; none added to D4S1; AI good-practice card instead of per-deck best-practice slides. |
| Fiona, 7 Oct | Day 2 (D2S1-D2S3, H4-H6) | Accept | Restoration list accepted. Open question: how much trainer-run R stays in each Day 2 session. |
| Fiona, 7 Oct | Days 2-4 consistency | Revise | Bring Days 2-4 to Day 1's level (sequence and minutes; headers still say 60 minutes). Reconcile D2S3-07 and D3S3-06 break slides with the fixed breaks. Update H4-H11 AI rows to the two-stage Snapshot. The 15-minute daily wrap-up needs no materials and doubles as a buffer. Day 2-4 handout AI rows now updated to the two-stage Snapshot (old realistic responses, fewer steps). |
| | | | |
| | | | |
| | | | |

Outstanding decisions: approval of the single cost-focused Day 1 sequence and converted claim cards; session allocations/break placement within the confirmed day and 13:00 Day 4 simulation start; print/reference length; AI device arrangements; optional unfamiliar transfer extract; simulation handover. The Day 1 slide timings and paper mappings are concrete proposals for that review, not permission to implement.
