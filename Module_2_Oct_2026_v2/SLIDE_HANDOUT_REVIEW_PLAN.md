# Module 2 slide and handout revision plan

**Discussion draft for Lucas, Fiona and colleagues — 7 October 2026. This is a proposal, not approval to implement it.**

Restore explanatory depth while keeping a manageable number of slides. By the end of the week, officials should be able to identify an evaluation's comparison and assumptions, interpret its tables and figures, and judge whether its recommendations follow from the evidence. Plain language should support that technical understanding.

Only this Markdown plan is being created. Teaching materials, data and the live site remain unchanged. Session decisions and comments below are deliberately open for review.

## Basis of the review

Original slide/handout baseline: `80d9262`. Subsequent check on 7 October found two new Fiona commits on `origin/main`: `ae2bef8` (source edits and review notes) and `f3db11d` (proposed Day 1 outline). These have not been merged into the working `simple-greenwaste` branch. Fiona explicitly records her new deck edits as not yet rendered or published. The row IDs below still identify the original baseline; the reconciliation section records additions and changes rather than silently renumbering them.

Fiona's review is [REVIEW_NOTES.md on main](https://github.com/lsempe77/R-course/blob/f3db11df7e7209e86c64e3869b1059ea9b2077e8/Module_2_Oct_2026_v2/REVIEW_NOTES.md). Her working notes distinguish implemented source edits, items recorded as decided, and the proposed Day 1 restructure, which is explicitly not agreed. This plan preserves those distinctions. No source edits have been merged or rendered as part of this review.

Reviewed: eleven current QMD decks, published participant DOCX sheets, relevant trainer packs, supplementary references, the four A1 poster uses, HANDOFF.md, SIMPLE_GREENWASTE_PLAN.md and CLAUDE.md. Original headings at `217858a` identify useful restoration candidates. This is a teaching/content review, not a fresh visual render audit.

Slide IDs refer to the **current sequence**, excluding the generated title screen: `D1S1-01` is the first content slide. All eleven title screens and 122 content screens have a proposal below. “Combine” retains a slide's teaching purpose within another screen. H1–H11 identify participant handouts in session order. Their section names below refer to the current documents, not hypothetical worksheets.

## Decisions to settle together

| Decision | Recommendation for discussion | Agreed decision |
|---|---|---|
| Daily schedule | Lucas confirmed 09:00–15:00, with one 15-minute and one 30-minute break: 315 minutes of teaching/activity time per day. | Confirmed |
| Simulation start | Lucas confirmed the Day 4 simulation starts at 13:00. Within the confirmed day ending at 15:00, this leaves 120 minutes for the simulation and 195 minutes before it after the two breaks. | Confirmed start; end follows daily schedule |
| Session allocation | For Days 1–3, propose 90/90/120 minutes plus 15 minutes of daily consolidation. For Day 4, propose two 90-minute sessions plus 15 minutes of feedback/handover before the simulation. Break placement remains a proposal. | Pending |
| Technical level | Explain comparisons, coefficients, p-values, confidence intervals and causal assumptions through worked examples. Keep full estimator syntax and advanced inference as trainer extensions unless necessary to read the supplied report. | Pending |
| Day 1 order and outcome | Keep the requested terms-first order. Fiona's new outline proposes S1 read a result, S2 descriptive cost data and weak comparisons, S3 pilot lottery. Prefer costs in AED as the main thread throughout Day 1; decide whether to convert landfill claim cards or explicitly identify them as the second outcome. | Pending |
| Slide count | Provisionally aim for about 12–16 substantive screens per concept session, fewer for workshops, excluding title/break screens. Agree a final sequence before exact timings. Do not add slides simply to fill a longer slot. | Pending |
| AI tasks | Fiona records a decision to restore a shortened AI Snapshot in each session: mark a realistic response, then run the better prompt and compare. Reflect that sequence in the draft, with device/account requirements and a prepared paper fallback. Confirm its timing within each session. | Recorded as decided in Fiona's notes; timings to agree |
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
| 14:45–15:00 | Individual reading check, feedback and daily consolidation | 15 |

An indicative 90-minute concept session could use 10 minutes for context/retrieval, 30 for explanation and worked examples, 25 for guided practice, 15 for source reading and 10 for feedback. A 120-minute applied session could use 10/30/40/25/15 minutes respectively. These are planning envelopes, not final slide timings. The separate 15-minute daily close checks learning across sessions; it is not another lecture.

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

Implications for the slide and handout proposals: keep the same core concepts and restoration priorities; allow time to explain their diagrams, work calculations and discuss errors. The provisional 12–16 substantive screens is still a useful guide, not a quota. Restore source pages, useful figures and response space where needed, without adding compulsory worksheet tasks merely to fill time. Existing break screens inside longer decks must be reconciled with the two scheduled breaks; do not assume an additional formal break without accounting for its time.

## Principles for every revision

1. Introduce GreenWaste before any vocabulary or results. Explain equipment subsidy, installation help and staff training; pilot lottery versus city score rule; recorded outcomes; timing; and the decision. Use the same map throughout.
2. Give each retained technical concept an explanation, a worked example and independent interpretation. Keep useful labelled diagrams visible while discussing them. An interaction should expose a relationship or test a reason, rather than merely reveal text.
3. Recover original teaching devices selectively. Adapt traffic-camera, school-zone and neighbourhood examples to the current business-level GreenWaste design. Do not restore obsolete figures, neighbourhood assignment, Menti or the removed Day 4 workshop.
4. Distinguish case reference, session study extract, draft analyst note, Day 4 review report and corrected findings. Give paragraph/table identifiers. A paragraph on a worksheet is not a full report.
5. Announce outcome switches: landfill tonnes versus annual waste cost AED. State population, period, units and comparison on substantive tables and figures. Separate descriptive changes from causal estimates.
6. Preserve Fiona's four claim cards, RDD cards A–H and number line, seven matching profiles with withheld cost slips, five economic scenarios and prediction wall, and two-sheet credibility grid. Do not restore the AI walls she reverted in D1S3 and D2S1.
7. Keep readable commented R boxes as optional trainer demonstrations, with printed outputs. Explain how a result was produced even when learners do not run code.
8. Use authored AI examples that mix accurate facts, plausible qualifications and consequential overclaims. Exercise copies have no answer highlighting; debriefs cite the source. Following Fiona's recorded decision, participants first mark the supplied response, then run the better prompt and compare against the source. Specify device/account arrangements; a prepared second response is the paper fallback. Do not require a separate second-chat checking exercise in every session.
9. Keep one consistent fictional-case notice per deck/document. Remove facilitator instructions from learner-facing prose. Layout should organise meaningful explanation, rather than replace it with large numbers and short slogans.

## Proposed teaching sequence

The table and slide/handout rows below are the original review mapping. Fiona's newer cost-focused Day 1 alternative is the preferred sequence for discussion in the reconciliation section below. If agreed, D1S2 landfill data/figures become cost data/figures and D1S3's repeated weak-comparison teaching becomes a brief recap. Do not implement both versions in parallel.

| Session | Progression | Main source |
|---|---|---|
| D1S1 | Case; records and mean/spread; worked change; coefficient; effect versus change; interval; p-value; independent reading. | Case card + H1 table |
| D1S2 | City landfill data; descriptive summaries/distribution; before/after versus with/without; four claims; chart review. | H2 data/figures + cards |
| D1S3 | Weak cost comparisons; pilot lottery; difference of means/regression; uncertainty/reach; recommendation. | H3 pilot study extract |
| D2S1 | Four means; DiD diagram/arithmetic; output; parallel trends; data limits; source interpretation. | H4 DiD extract |
| D2S2 | Score rule/scatterplot; raw group gaps; fitted local jump; window/credibility checks; reach. | H5 cutoff extract + cards |
| D2S3 | Pair profiles before costs; differences; full-study matching/reuse; balance/overlap; unmeasured factors. | H6 matching extract + cards |
| D3S1 | Benefit input; cash-flow timeline; ratio/discounting; scenarios; conditional spending recommendation. | H7 model note + cards |
| D3S2 | Chart source; axes/distributions; denominators; uncertainty; defend a caption. | H8 figures and small data tables |
| D3S3 | Decision note; questions; analyst role-play; assess answers; revise sign-off. | H9 note + evidence bank |
| D4S1 | Independent report reading; claim ratings; section work; source-based debrief; feedback. | Review report + H10 |
| D4S2 | Corrected findings; worked brief; draft; peer check; revision/defence; reading retry. | Corrected findings + H11 |

## Slide-by-slide proposals

Title screens: keep the question-led main titles for review, use explicit content/technical subtitles, and add one short interpretation objective. Reconsider titles after the teaching sequence is agreed. Day 1 S2's subtitle should explicitly name descriptive statistics and recorded comparisons. No facilitator setup or duration on the title.

### D1S1 What do the numbers actually say?

Source: `Oct12_session1_live.qmd`. Current duration: 60 minutes. Handout: H1. Session decision: **Pending**. Comments: ____________________

Proposed order of current material: 01 with new case/data orientation; 02; 04+05; 03; 06; 07; 08; 09+10; 11. Additional screens are justified only where a worked diagram cannot fit legibly.

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D1S1-T Title | Retain | Explicit subtitle and objective: interpret a simple regression table using five terms. |
| 01 An impressive result lands on your desk | Expand | Replace the one-line description with a formal case introduction before the vocabulary check. Show programme components, pilot/city settings, outcomes and timing using the existing case map. Add a separate context screen if needed. Link H1 to the case card. |
| 02 Mean: who looks like the average? | Expand | Keep ten records and calculation. Restore a dot plot with mean marker and the 46-tonne business. Calculate before revealing 100/10. Compare median 6.5 tonnes for this selected set; explain that these are selected records, not a representative city sample. |
| 03 Treatment effect: what did GreenWaste cause? | Expand; move after 04+05 | Draw the observed outcome and the missing no-programme outcome for a concrete business. Explain the counterfactual and why the change just calculated is not automatically a causal effect. |
| 04 Coefficient: which row is the change? | Expand | Restore a complete teaching output with labelled intercept, after indicator, coefficients, intervals and p-values. Explain rows/columns, reference category and 1,432 + (-669) ≈ 763. An intercept is the baseline mean in this simple model, not in every regression. |
| 05 A minus sign. Good news or bad? | Combine with 04 | Show the worked subtraction beside the optional commented R calculation. Learners predict sign and explain units before Run. Explain why this arithmetic and the simple regression give the same change. |
| 06 Confidence interval: how sure are we? | Expand | Plot estimate/interval on a labelled line. Contrast estimate uncertainty with individual outcome variation. Restore a short hypothetical repeated-sample coverage illustration; avoid a 95% probability claim about this fixed interval. |
| 07 P-value: does small mean important? | Expand | Adapt the old null/shuffle teaching device to a valid hypothetical no-mean-change illustration. Do not shuffle programme labels and imply random assignment in this before/after analysis. Include significant-but-small and imprecise non-significant examples. |
| 08 A lower cost. Enough of a saving? | Keep; clarify | Explicitly convert negative cost change to positive saving, reversing interval endpoints. Separate statistical evidence, causal credibility and the fictional 1,000 AED minimum. |
| 09 Your turn: what does the table say? | Keep | Protect independent annotation then paired checking. Use the same labelled output as the worked example. Require population, outcome, comparison and uncertainty in the interpretation. |
| 10 A correct number. A wrong conclusion. | Replace; combine debrief with 09 | Use a plausible 80–120 word paragraph with accurate descriptive figures, a cautious phrase and two consequential overclaims. Learners explain repairs before flags appear. Adapt older AI task structure, not old figures. |
| 11 What would you tell the director? | Keep | Ask for an interpretation and its limit, not only another question. Give feedback on the five meanings. Bridge to inspecting the data behind a headline in S2. |

### D1S2 Good news. Enough to act?

Source: `Oct12_session2.qmd`. Current duration: 60 minutes. Handout: H2. Session decision: **Pending**. Comments: ____________________

Proposed order: 01+03 with brief context from 02; 04 data orientation; 07 descriptive distribution; 05+06 worked comparisons; 08; 09; 10; 11. This makes the descriptive purpose visible.

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D1S2-T Title | Clarify subtitle | Name descriptive statistics, recorded outcomes and claim checking. |
| 01 That headline lands on your desk | Keep; orient | Identify city participants, landfill tonnes and before/after period. Take a provisional vote with a reason. Do not present the headline as an effect. |
| 02 What did GreenWaste actually do? | Move; combine | Move the substantive introduction to S1. Here retain a small city-setting reminder and explicitly announce the switch to landfill tonnes. |
| 03 Would you extend it? | Combine with 01 | Reveal the fully labelled headline chart. Explain approximately 50% as rounding of 49.5%; show the underlying quantities rather than an isolated percentage. |
| 04 What does the headline leave out? | Expand | Restore selected rows with identifier, participation and before/after landfill columns. Explain one row per business with two measures. Add the before/after timeline; selected rows illustrate structure, not the whole sample. |
| 05 Who else saw waste fall? | Expand | Restore paired participant/comparison charts with common axes and labelled means. Calculate both changes without calling the extra change causal; DiD assumptions come on Day 2. |
| 06 Better than before. Better than without? | Expand | Show actual before/after and with/without landfill comparisons side by side. Work one calculation for each; name people, period and limitation. Keep counterfactual explanation attached to the diagrams. |
| 07 Who is hidden by the average? | Extend S1 | Use a full-city distribution or labelled size-group summary, with mean/median and variation. Avoid repeating the same ten numbers as if they represented the city. |
| 08 Four claims. Which would you act on? | Keep | Preserve Fiona's four cards and optional A1 board. Add short sources and units. Card 2's causal wording remains open to challenge; landfill does not establish the cost decision rule. |
| 09 Which evidence supports your choice? | Keep | Debrief disagreement using exact claims and available evidence. Explain what would justify action; avoid teaching that ask-first is always the answer. |
| 10 Would you accept the AI explanation? | Replace | Restore a realistic chart-reading paragraph with correct figures/comparison and a plausible causal or nationwide leap. Mark supported/qualified/unsupported claims, then improve the prompt and verify the answer. |
| 11 Which answer do you need before acting? | Keep | Repeat the opening decision and compare reasons. Require one supported descriptive conclusion and one missing causal comparison. Bridge to the pilot lottery. |

### D1S3 Did the programme make the difference?

Source: `Oct12_session3_live.qmd`. Current duration: 75 minutes. Handout: H3. Session decision: **Pending**. Comments: ____________________

| Current slide | Action | Specific revision and learner work |
|---|---|---|
| D1S3-T Title | Retain | Explicit lottery/causal-comparison objective. |
| 01 Two savings. Two weak comparisons. | Expand | Restore two cost mini-tables/timelines for before/after and with/without. Work the comparisons with learners. Explicitly switch from landfill tonnes to annual cost AED. |
| 02 Which comparison is fair? | Expand | Explain selection bias with a concrete baseline difference and the existing group diagram. Use the current pilot/city design, not the old neighbourhood assignment. |
| 03 How different were they at the start? | Keep; explain | Keep the baseline gap chart with common axes. Explain why the later level gap cannot all be credited to treatment; starting-level differences are not fatal to every method. |
| 04 Could something else explain the fall? | Combine with 01 debrief | Attach one hypothetical common price/service change to the before/after timeline. Label it hypothetical, rather than evidence of an observed real shock. |
| 05 What does the lottery protect us from? | Expand | Restore the lottery diagram: 400 eligible pilot businesses, 200 assigned to join and 200 to wait. Explain random assignment, sample selection and the assumptions supporting the post-period comparison. |
| 06 A lottery. Perfectly balanced groups? | Keep; explain | Keep one trainer rerandomisation of 20 illustrative businesses and display distributions as well as means. Explain chance imbalance and distinguish this demo from the 400-business pilot. |
| 07 What did the pilot actually find? | Expand | Restore the worked difference of post-period means followed by the regression row. Annotate treatment indicator, reference group, sign and interval; explain both estimate the pilot comparison. |
| 08 Break | Keep | Retain a break; confirm length with timetable. Leave comparison diagram and source accessible. |
| 09 Does the interval clear our saving rule? | Keep | Use a consistent positive-saving scale. Explain what remains uncertain when the interval crosses 1,000. |
| 10 Would you extend it now? | Keep | Vote after reading. Ask for a design strength and a precision/transfer limit; accept supported conditional actions. |
| 11 Your recommendation in three sentences | Keep; scaffold | Give one worked interpretation sentence, then learners write their own recommendation, limitation and request. Preserve individual thinking before pairs. |
| 12 The AI wants to expand. What is missing? | Restore richer example | Adapt the older ministerial paragraph: correct pilot estimate/uncertainty, plausible qualification, then threshold or national-value overclaims. Debrief sentence by sentence without pre-highlighted answers. |
| 13 Which question could change your decision? | Combine with 11 close | Make the request the last sentence of the recommendation. Finish with a map: pilot lottery today; city comparisons tomorrow. |

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

## Handout-by-handout proposals

Paths below refer to the current published participant copies in `docs/handouts/`. Current source generators are `make_day1_materials.R` through `make_day4_materials.R`, called by `make_session_materials.R`; shared print styles come from `reader_material_helpers.R`. Implement agreed changes in those generators, not only in saved Word files.

Each packet should have an identifiable source, an activity and space to respond. Put substantial source reading on a separate reference page where that improves usability. Keep activity numbering and paragraph/table references identical on slides and paper. Suggested extra panels below are additions for review, not a blanket requirement to make every handout longer.

### H1 Day 1 Session 1

File: `Oct12_session1_handouts.docx`. Current heading: Read a regression table. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| Opening instructions | Name the case reference and table source. Add a compact explanation of participants, annual cost, two periods and what one record means. Use the case card for the fuller introduction. | D1S1-01 |
| 1 Mean | Retain ten records and arithmetic; add matching dot plot, blank mean marker and median comparison. Label selected teaching records. Give enough space to explain what the mean hides. | 02 |
| Annual waste cost regression | Restore an authentic-looking but readable teaching output, including row labels, estimate, interval, p-value and N/source/model note. Explain after=0/1 and reference category. Do not present an unexplained machine screenshot or imply causal identification. | 04+05 |
| 2 Coefficient | Ask learners to mark the relevant row, interpret sign/units and reconstruct the after mean. Explain baseline intercept interpretation applies to this model. | 04+05 |
| 3 Treatment effect | Add observed-versus-missing-outcome diagram. Ask what comparison would be needed before relabelling change as effect. | 03 |
| 4 Confidence interval | Add estimate/interval number line and contrast with individual outcomes. Ask what the interval describes; put the repeated-sample explanation in a reference margin/page, not the answer key on the task. | 06 |
| 5 P value | Add short null-model source and two cases: precise small change and imprecise non-significant estimate. Ask what each allows a reader to conclude. Avoid equating p-value with probability of no effect. | 07 |
| 6 Read and repair | Replace single obvious sentence with richer source paragraph. Identify it as an illustrative analyst/AI draft based on Table H1-A. No pre-highlighted mistakes. | 08–10 |
| My independent reading and next question | Require interpretation, comparison/causal limit and next evidence. Keep table open and explanations closed for retrieval. | 09–11 |

### H2 Day 1 Session 2

File: `Oct12_session2_handouts.docx`. Current heading: Question a claim. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| Opening heading/instructions | Make descriptive-statistics purpose explicit. Say the source is city landfill data, not a complete evaluation report. | D1S2-01 |
| 1 Read alone first | Retain approximate 50% headline, label its rounding from 49.5%, period and population. Add a fully labelled figure and provisional reason; do not imply a causal result. | 01+03 |
| New data orientation panel | Include a few selected records with identifier, participation, before/after tonnes and a brief column key. Explain the full data contain more businesses than this illustration. | 04 |
| 2 What could an average hide | Replace repetition of H1 with full-city distribution or size-group summary. Include mean/median and a distribution question. Keep the ten-record example only as an optional recap. | 07 |
| New comparison panel | Supply participant/non-participant before/after means and one worked example. Learners calculate before/after and with/without, then name limitations. Label rounded descriptive values. | 05+06 |
| Triage four claims, Cards 1–4 response fields | Keep all four responses. Include card IDs, exact source references, units and sufficiently large spaces for reasons. Do not force one missing-question label when several are defensible. | 08+09 |
| New AI/source-check task | Current participant sheet lacks the on-slide AI task. Add the richer paragraph only if it is a core exercise, or supply it as a separate optional activity card; slides and print must state which. | 10 |
| My next question from memory | Add final decision and one supported descriptive statement; compare with the opening reason. | 11 |

### H3 Day 1 Session 3

File: `Oct12_session3_handouts.docx`. Current heading: Judge a fair comparison. Decision: **Pending**. Comments: ____________________

| Current section or item | Proposed revision | Slide connection |
|---|---|---|
| Opening and The pilot trial | Expand into a short study extract with design diagram, exact 200/200 allocation, outcome/period and numbered paragraphs. State eligibility and distinguish pilot from city. | D1S3-05 |
| New weak-comparisons panel | Add before/after and with/without cost tables or figures so the opening discussion has a paper source. This can sit on a separate reference rather than crowd the response sheet. | 01–04 |
| 1 Name the comparison | Ask who was assigned to join versus wait and why assignment helps. Use a small blank comparison diagram for annotation. | 05+06 |
| Pilot result table | Add post-period group means beside the regression row, showing their difference. Keep coefficient/interval sign conventions explicit. | 07 |
| 2 Read the estimate and interval | Include saving-scale figure and decision-rule line. Ask what is settled and uncertain. | 09 |
| 3 How far does this result reach | Name the proposed citywide/nationwide use and ask what supports transfer from one district. Do not accept location alone as a complete answer. | 10 |
| Write a decision note | Retain three/four-sentence task with finding, provisional action, limitation and request. Give a sentence starter, not a full model answer. | 11 |
| Check an illustrative AI draft | Replace three short assertions with a realistic paragraph containing supported and unsupported material. Cite the pilot source paragraphs/table. | 12 |
| Your question from memory | Integrate into final recommendation, while preserving an individual response. | 13 |

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
| Repair an illustrative AI draft | Replace caricature with 80–120 words adapted from older DiD exercise. Mix correct figures, a plausible caveat and unverified causal/policy assurances. | 09 |
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
| Repair an illustrative AI recommendation | Use richer local-to-national example with supported facts and ignored credibility/reach limits. | 09 |
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
| Repair an illustrative AI assurance | Restore realistic paragraph with correct matching facts and subtle claims about selection bias/threshold. Do not pre-mark errors. | 12 |
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
| Repair an illustrative AI recommendation | Use richer model-based recommendation with supported calculation and a consequential unverified duration/cost claim. Include one reasonable qualification. | 10 |
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
| Repair an illustrative AI caption | Restore a realistic chart interpretation with accurate observations, omitted denominator and causal/generalisation overclaim. | 08 |
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
| Check an illustrative AI review | Restore full plausible paragraph checking evidence bank, independence and uncertainty. | 12 |
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
| Repair an illustrative AI verdict | Replace simplistic assertions with plausible report review that gets some strengths/limits right but misses one consequential overclaim. | 09 |
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
| Repair an illustrative AI draft | Restore coherent realistic director brief with accurate numbers, reasonable content and consequential overclaim. Compare to learner draft. | 07 |
| My independent request and purpose | Keep final independent evidence request. | 09 |
| Retry instruction | Refer to a separately handed-out numbered retry slip; feedback explains the missed ability. Record revised reading result separately. | 09 |

## Supplementary references, cards, posters and trainer packs

These are part of the plan because activity materials cannot be reviewed solely through the participant worksheet. Items below are covered individually; their existing identifiers should remain stable during the discussion.

| Material | Proposed revision or retention | Review decision |
|---|---|---|
| `GreenWaste_case_card.docx` | Make this the opening reference in D1S1. Retain pilot/city picture, add programme components and outcome/timing key. Use businesses consistently rather than switching between shops and businesses. Avoid an overcrowded map. | Pending |
| `GreenWaste_case_brief.docx` | Retain as technical case reference. First page: intervention/design/outcomes; second: data/means. Remove the participant-facing instruction to use the picture card. Give stable paragraph/table IDs. Avoid repeating the fictional notice. | Pending |
| `Oct14_session3_qa_checklist.docx` | Keep optional workplace reference; add a worked specific evidence request under each question family and space for follow-up. Do not distribute a duplicate worksheet without explaining purpose. | Pending |
| `Oct15_session1_report.docx` | Retain four-page review task; make overclaims more plausible, mixed with genuine strengths and useful disclosures. Restore realistic report prose and annotated design/table references without highlighting faults. Keep all correct figures; assess errors in attribution, uncertainty, selection and reach. Number paragraphs and sections. | Pending |
| `Oct15_session1_rating_sheet.docx` | Currently duplicates H10. Choose one participant route or label this explicitly as the alternative standalone worksheet; keep content synchronised. | Pending |
| `Oct15_session2_findings.docx` | Keep corrected authoritative drafting source. Expand short findings into enough design/context to support independent writing. Add precise numbered anchors, result table and input/assumption distinction. Explicitly distinguish it from the flawed report. | Pending |
| `Oct15_session2_brief_template.docx` | Keep only as an optional standalone version of H11's drafting side. Explain alternative use; no duplicate compulsory task. | Pending |
| H2 claim card 1 | Retain rounded descriptive percentage; add population, period and source. Learners identify missing comparison. | Pending |
| H2 claim card 2 | Retain estimate/interval and deliberate causal wording for critique. Add source/comparison so ambiguity is inspectable; do not silently endorse effect. | Pending |
| H2 claim card 3 | Retain significance-to-national-action leap, but embed in a realistic short recommendation rather than only an obvious wrong sentence. | Pending |
| H2 claim card 4 | Retain changes in both groups; state units/period. Learners identify uncertainty and comparison credibility needs. | Pending |
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
| D1S1 | Add case introduction, worked table explanation, CI/null-model teaching guidance, acceptable interpretations of all five terms, likely misconceptions and feedback. Explain the intercept's model-specific meaning. |
| D1S2 | Update descriptive-statistics purpose, data/figure calculations, four-card key and optional board reference. Remove note that the full uncertainty lesson comes next session: vocabulary is now taught in S1. |
| D1S3 | Add lottery/difference-of-means explanations, updated source IDs, richer AI key and transfer limits. Keep the 20-business demo distinct from actual 400-business pilot. |
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
| Source edit: S2 brief case reminder | Matches moving formal introduction into S1. | Preserve reminder; revise its outcome if the cost-focused S2 proposal is adopted. |
| Source edit: triage-poster rename | Resolves legacy filename confusion. | Integrate all renamed references and archive contents without restoring the old name. |
| Source timings still total 60 minutes | Superseded as a planning constraint by confirmed daily schedule. | Reallocate explanation/practice to proposed 90-minute slot after sequence agreement; do not preserve 60 minutes solely because source notes currently say it. |
| Item 1: facilitator scripts | Missing from our original row-level notes. | Add task IDs, grouping, timing, expected answers and transitions to every session; remove build-log wording. |
| Items 2 and 15: participant-facing copy | Supports our source-clarity audit; identifies two additional concrete errors. | Remove trainer sentence from case brief and planted-overclaims wording from corrected findings. Fix yesterday's flawed report in D4S2 notes: the report is read the same morning. |
| Items 3, 6b and 6c: restore explanations, figures and sources | Strong agreement with plan. | Use `2993d01` to inspect original source sections and realistic handout content; restore useful detail, not obsolete models or a mandatory old word count. |
| Item 4: answers visible before attempts | Requires an explicit review criterion. | Audit slide/handout answer visibility, including mean, arithmetic, plots and AI flags. Reveal only after an attempt; keys stay separate. |
| Item 5: exercise-plan header Running brief for PwC | Intended audience unresolved. | Confirm who uses the brief; update heading after agreement, without assuming client delivery. |
| Items 6 and 7: programme consistency and ToC typo | Supports case orientation. | Agree one intervention description. Keep simplified less waste to landfill wording; do not reuse the original increase typo from the saved Module 1 image. |
| Item 8: worksheet as you go, recorded DECIDED | Changes the original plan's standalone end-of-session worksheet approach. | Each S1 concept ends with its corresponding question; the later practice screen becomes pair check, correction and Q6. Keep a short independent final interpretation. Recheck numbering after sequence changes. |
| Items 9–12: S2 role, missing descriptives and duplication | Strong agreement, but Fiona offers a more coherent outcome choice. | Prefer cost data throughout Day 1: records, participant counts, histogram, individual changes and weak comparisons. Drop repeated ten-business mean in S2. |
| Item 13: AI Snapshot sequence, recorded DECIDED | More participatory than our original authored-only proposal. | Every core AI task gets naive prompt context, realistic multi-paragraph supplied response, source markup, better prompt run/comparison and paper fallback. Keep second-chat checking/leading-prompt cautions as general guidance, not repeated compulsory exercises. |
| Item 14: exact source names, recorded TO DO | Matches our source IDs, but wording must include physical location. | First mention names document and location, e.g. short DiD study extract on worksheet page 2. IDs alone are insufficient. |
| Item 16: realistic report and adequate corrected findings | Strong agreement with H10/H11 proposal. | Compare both old/current documents section by section; restore methods/context needed for independent reading/writing. Do not announce planted errors to participants. |
| Proposed Day 1 restructure, explicitly DRAFT | Preferred alternative to our original landfill-focused S2, subject to team agreement. | Review the integrated Day 1 sequence below; preserve terms-first request. No deck edits until agreed. |

### Preferred Day 1 sequence for discussion after Fiona's review

**S1 — read a result, 90 minutes proposed:** preserve her new introduction and theory-of-change bridge; then terms through one cost result. Mean/spread example should ideally use annual cost data to keep the main thread consistent. If retaining the existing ten-tonne illustration, label that temporary outcome switch explicitly. Each concept includes a worksheet attempt; pair checking and a short independent interpretation consolidate the lesson. Restore an interval visual and p-value explanation; use realistic AI Snapshot plus better-prompt comparison.

**S2 — what the data show and why obvious comparisons mislead, 90 minutes proposed:** show real selected rows and describe one business; participant counts; cost histogram/mean/median; participant before/after means and distribution of changes; other city businesses' cost rise; with/without comparison and starting levels. End with two weak comparisons, four-card triage and chart AI Snapshot. This replaces the original landfill headline sequence rather than adding a second complete sequence. Keep all four cards; agree whether they switch to cost or remain an explicitly introduced second outcome.

**S3 — how the pilot lottery provides a fair comparison, 120 minutes proposed:** short recap of the two weak city comparisons, then pilot design, physical manager-age draw and optional repeated-draw/small-sample visual. Show pilot baseline comparison, post-period difference of means, regression row, interval, reach and the three-results summary. Retain recommendation and ministerial AI task. A physical draw is the offline alternative; no additional permanent method is introduced. Existing internal break slide must fit within the confirmed break allocation or be treated as a brief activity transition with time accounted for.

H1 follows the as-you-go questions and pair correction; H2 gets the cost-data/distribution/comparison source plus triage and realistic AI task; H3 gets pilot design/baseline/post-period table and uncertainty/recommendation task. Recompute cost-based mean/median and any converted claim cards before drafting. Do not substitute invented cost values for the existing ten-tonne records.

Fiona's draft suggests -669 before/after is too small and -1,638 with/without too large. The designed case allows discussion of these directions, but the rise among non-participants and starting-level gap alone do not prove the true causal bias direction in an arbitrary evaluation. Explain the assumptions and use the pilot as its own population-specific estimate; do not call it ground truth for the whole city's effect.

## What to recover from the older decks

Use `217858a` as a reference for teaching devices, not a wholesale replacement. The titles below identify exact old content to inspect when an item is approved. Rewrite figures, samples and case design against current sources.

| Destination | Older slide or task to consult | Adaptation boundary |
|---|---|---|
| D1S1 mean/coefficient | Word 1 — What the mean hides; Word 3 — The other rows of a table | Use business outcomes; choose a compact output and explain reference categories. |
| D1S1 p-value/interval | Word 4 — p-value: shuffle the labels; Word 4 — The warning cuts both ways; Word 5 — Confidence interval | Hypothetical statistically valid null/coverage illustration; no false random-assignment claim in before/after case. |
| D1S2 data/descriptive reading | One row, one road segment, one year; Who is in the data?; Did every road fall?; Annotate this output | Business records, landfill outcome and explicit source; no traffic case return. |
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
| Ten selected landfill records | 3,4,5,5,6,7,7,8,9,46; total 100; mean 10; median 6.5. Not a representative sample. |

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
| | | | |
| | | | |
| | | | |

Outstanding decisions: session allocations and break placement within the confirmed 09:00–15:00 day and 13:00 Day 4 simulation start; exact final slide sequences/counts; cost-focused Day 1 and claim-card outcome; print/reference length; AI task timings/device arrangements; optional unfamiliar transfer extract; simulation handover. No implementation decisions are implied by an empty review field.
