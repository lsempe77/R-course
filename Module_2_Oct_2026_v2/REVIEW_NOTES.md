# Module 2 review notes (Fiona), October 2026

> **From 7 October, `SLIDE_HANDOUT_REVIEW_PLAN.md` (Lucas) is the master plan.** These notes are Fiona's earlier review and are kept for reference; record new decisions and disagreements in the plan.

Running list of changes Fiona has flagged while reviewing each session and its
worksheets. Open items are not implemented yet; implemented items are removed
once they are rendered and published. When implementing, change the sources
(`review_2026_10_06/build_day*_decks.py` + `reader_titles.json` for decks,
`make_*.R` / `day*_case.R` for paper), rebuild, render, verify, then publish via
`review_2026_10_06/publish_live.py`. Never hand-edit generated `.docx` or `docs/` HTML.

---

## Implemented in source, NOT yet rendered or published (7 Oct 2026)

Quarto/R were not available in the session that made these edits. To finish:
render `Oct12_session1_live.qmd` and `Oct12_session2.qmd`, rebuild Day 1 paper
(`Rscript make_session_materials.R --day1`), walk both decks (`?print-pdf` and
normal view), copy to preview/live with `publish_live.py`, commit and push.
Pre-change copies: `backups/s1_intro_2026_10_07/`, `backups/poster_rename_2026_10_07/`.

- Day 1 S1 now opens with **The GreenWaste case study** (case map; hand out picture card)
  and **Where does GreenWaste fit?** (simplified Module 1 theory of change,
  long-term outcome "lower waste management costs" highlighted as measured this
  week; check question: do outputs show the programme worked?). Day 1 S2's case
  slide is now a 1-minute reminder, **Remember GreenWaste?** (S2 has 2 spare minutes).
- Day 1 S1 mean slide: answer hidden behind "Show the answer"; slide sends the
  room to Sheet 1 Q1 first.
- Day 1 S1 minus-sign slide retitled **What does the minus sign mean?**: room
  decides whether -669 is good or bad news (outcome is a cost), then answer
  reveal, then the optional trainer Run.
- S1 timings rebalanced to keep 60 minutes (intro 3+3, entry 2, mean 6, effect 5,
  sign 3, p-value 5). Trainer-pack delivery text updated in `make_day1_materials.R`.
- Poster renamed `Oct12_session1_board_A1.pdf` -> `Oct12_session2_board_A1.pdf`
  everywhere (it is the Session 2 claim-triage board).
- Still to update with these: `verify_day*.py` slide-count asserts (S1 now 14
  sections), `Module2_exercise_plan_v3.docx` S1 timing rows and when the picture
  card is handed out (now S1; `make_case_brief.R` comment still says Oct12 S3).

---

## Cross-cutting (apply to every session)

1. **OPEN · Speaker notes must be a facilitator script, not a build log.**
   Current notes read like design decisions ("Individual entry check, no AI",
   "No shuffle simulation or hypothesis-testing lecture"). Rewrite step by step:
   what to say, what to ask, the answer to listen for, the transition. Flag
   every activity, e.g. **"WORKSHEET - Q1: 3 min individually"**.
   *Do this after the worksheet-timing question (item 6) is resolved.*
   The new S1 intro, mean and minus-sign notes are a first example of the style.
2. **OPEN · No trainer instructions in participant handouts.** Known case:
   `GreenWaste_case_brief.docx` ("Use the picture card when first introducing
   the case. This cost reference is optional once cost reading has begun." -
   source `refresh_case_brief.R` ~line 22). Audit every participant handout.
3. **OPEN (do not implement yet) · Explain before practising; more visuals.**
   Rebuilt decks are simpler (good) but jump into concepts/activities with little
   explanation and fewer visuals than before. Pre-rebuild versions (commit
   `2993d01`, e.g. `git show 2993d01:Module_2_Oct_2026_v2/Oct12_session1_live.qmd`)
   had: "What the mean hides", p-value "shuffle the labels", "Significant is not
   the same as big", a 100-studies confidence-interval chart, and "Which one would
   you act on?" (same estimate, three intervals). Consider restoring the best.
4. **OPEN · Don't show answers before participants attempt them.** Check every
   deck for slides that ask for work and show the answer at the same time.
5. **OPEN · Exercise plan header** says "Running brief for PwC". Confirm intended.

6b. **OPEN · The 6 Oct rebuild cut every deck by about half.** Before → after
    content slides (R/webR chunks): D1S1 23→13 (19→7), D1S2 22→11 (19→3),
    D1S3 27→13, D2S1 29→10, D2S2 25→10, D2S3 31→13, D3S1 21→11, D3S2 28→10,
    D3S3 30→13, D4S1 26→11, D4S2 28→9. Methods and case are unchanged on Day 2
    (DiD, RDD, matching on GreenWaste), but the R implementation sections,
    regression-table reading, assumption checks (pre-trends plot; RDD placebo,
    manipulation and covariate checks; matching balance and evaluator A vs B) and
    the AI Snapshot sections were removed or reduced to one slide. Sessions
    went from 90/90/120 to 60/60/75 minutes. Confirm the real room timetable:
    if slots are still 1.5h/1.5h/2h, much of the cut material can come back.
    Pre-rebuild sources: `git show 2993d01:Module_2_Oct_2026_v2/<deck>.qmd`.
    Day 1 mapping: new S1 = old S1 "five words" (without charts) + old S2's
    regression-table reading; new S2 = old S1's opening ("compared to what?")
    + Fiona's claim triage; new S3 = old S3, condensed. Old S2's descriptive
    data work was dropped.

6c. **OPEN · Handouts were cut the same way.** Participant handouts went from
    about 900-3,300 words to 210-400 words each (two A4 pages). Removed from every
    session: the AI Snapshot pages (a realistic prompt, a sample AI response to
    mark up, then a better prompt to run and compare) and the take-away cards.
    The AI work is now one short "repair an illustrative AI draft" box, with no
    prompt-writing or running AI. Also removed: Day 1 S1 "remove the largest
    business" (mean vs median) and "which report would you act on?" (three
    intervals); Day 1 S2 "Annotate this output" (moved into S1's table); RDD
    scorecard; matching "which evaluator would you trust?"; Day 3 S1 AI prompt
    versions 1 and 2; Day 3 S3 strong/weak sort. Group cards (RDD A-H, matching
    profiles, scenario cards, claim cards) moved to the trainer packs for
    cutting; the activities themselves were kept. New sheets add a "question
    from memory" close. Old versions: `git show 2993d01:docs/handouts/<s>_handouts.docx`.

## Introducing GreenWaste

6. **OPEN · One consistent description of GreenWaste.** Case brief: "subsidy for
   waste equipment, technical help with installation and staff training"; case
   map: "helps businesses cut their waste costs"; new S1 notes (from the Module 1
   ToC): technology, technical assistance and training. Align everywhere.
7. **NOTE · Module 1 ToC slide typo.** Long-term outcomes read "Volume of solid
   waste disposed increase" (presumably *decrease*). The simplified Module 2
   version says "less waste to landfill". Original saved as
   `assets/module1_greenwaste_toc.png`.

## Day 1 · Session 1 - "What do the numbers actually say?"

8. **DECIDED (7 Oct) · Worksheet "as you go" (option A).** Each concept slide
   ends with its worksheet question (Q1 mean, Q2 coefficient, Q3 treatment
   effect, Q4 interval, Q5 p-value). Slide 10 ("Your turn") becomes a shorter
   pair check and debrief plus Q6; its goal is to compare and correct answers.
   Implement together with the speaker-notes rewrite (item 1). Revisit if the
   older, more technical explanation slides come back (item 3).

## Day 1 · Session 2 - "Good news. Enough to act?" (`Oct12_session2.qmd`)

Background: the outline's Session 2 is "What Do the Numbers Say?": the trainer
runs descriptive analysis live, participants use the Session 1 vocabulary to read
it, annotate a printed output, and do an AI snapshot. Fiona's pre-rebuild deck
(commit `2993d01`) did this with the data: one row = one business, who took part,
histogram with mean vs median, before/after charts, did every business's cost
fall, how big (difference of averages = regression), how sure (CI, p-value),
interval against the 1,000 AED rule, AI snapshot reading a chart, "compared to
what?", annotate an output, take-away cards. On 6 Oct the vocabulary and
regression parts moved to the new Session 1 and Session 2 became "Question a
claim" (old Session 1 opening + the four claim cards). The descriptive data
work, charts and AI snapshot were dropped.

9. **OPEN · Session 2 is too vague and too simple, and has no visuals.** Decide
   whether Session 2 should return to descriptive statistics with the data
   (as the outline asks) and which pre-rebuild slides to restore.
10. **OPEN · Opening slide has no context.** "That headline lands on your desk"
    shows a one-line claim and asks participants to "use the five terms" without
    saying how. If it is a deliberate baseline (the notes say to keep sheets for
    an end-of-week comparison), say so, and give a prompt per term (Compared
    with what? How big against 1,000 AED? How sure? Who does the average hide?).
11. **OPEN · "Who else saw waste fall?" is unclear.** Name the groups and state
    the finding: city businesses that took part went from 6.6 to 3.3 tonnes
    (-49.5%); city businesses that did not take part also fell, from 11.2 to
    10.6 tonnes (-5.3%), and started much higher. Retitle (e.g. "Did
    businesses outside GreenWaste also cut waste?") and make the notes say this.
12. **OPEN · Repeats Session 1.** "Who is hidden by the average?" re-teaches the
    same ten-business mean from Session 1. Notes still say "the full
    uncertainty lesson comes next session", which is stale since the swap.

## Source documents and AI exercises (cross-cutting) - DECIDED 7 Oct

13. **TO DO · Restore the AI Snapshot exercise in every session (slides and
    handouts), in a shorter form.** Use the pre-rebuild exercises as the base
    (`git show 2993d01:docs/handouts/<s>_handouts.docx` and the old decks) and
    keep their realistic content: the prompt a busy official would type and a
    realistic, multi-paragraph AI response whose errors are subtle (e.g. "the
    interval excludes zero, which confirms the finding is robust"; "parallel
    trends has been satisfied"), not the current one-line obvious errors.
    New sequence:
    1. Participants **mark up the realistic AI response first** (underline what
       the source supports, cross out what it does not). They do not run the
       naive prompt themselves.
    2. Then give them **the better prompt** (context, decision rule, data
       limits, "ask me questions before you answer"). **This is when they run AI
       themselves** and compare with the marked-up response.
    Drop from the exercise: pasting the answer into a new chat to check it, and
    the "if you have time" leading prompt. Instead, show these on the slides as
    **general AI best practices** (not exercises): ask the AI to ask you
    questions first; check an answer in a second chat or with a second AI;
    watch for prompts that push the AI towards a conclusion (e.g. "write two
    sentences recommending scale-up"). Replaces the current "Repair an
    illustrative AI draft" box. Facilitator notes say who needs a device/AI
    account and the paper fallback.
14. **TO DO · Name every source document clearly, everywhere.** Each first
    mention on a slide, in the notes and on the handout states what the document
    is and where it is (e.g. "the short report extract on page 2 of your
    worksheet", "the sign-off note on this slide", "the one-page Corrected
    GreenWaste findings handout"). Known cases: Day 2 S1-S3 "the report"/"the
    extract"; Day 3 S3 "this note"; Day 4 S2 "the corrected findings are on
    your desk". Then sweep all decks and handouts for other vague references
    ("the source", "the reference", "the sheet", "the table", "the card",
    "the board", "the result", "your sheet") and make each specific.
15. **TO DO · Fix two Day 4 errors.** D4 S2 notes: "yesterday's flawed report"
    is wrong, the report is read in D4 S1 the same morning. Participant
    findings sheet (`Oct15_session2_findings.docx`): remove "corrects the review
    report's planted overclaims" (trainer language, see item 2).
16. **TO DO · Check the Day 4 report stayed realistic.** It went from 1,179 to
    901 words (now 7 numbered sections: executive summary, programme, design,
    data, results, limitations, recommendations). Compare old and new section
    by section and make sure it still reads like a real evaluation report
    (methods described properly, a results table, realistic limitations and
    recommendations, the strengths and weaknesses the exercise depends on).
    Restore detail where it was thinned. Also check the D4 S2 findings sheet
    (701 -> 232 words) is detailed enough to write a brief from.

## PROPOSED Day 1 restructure (DRAFT 7 Oct, for Fiona to review; not agreed)

Rationale: comparisons are currently split awkwardly (S2 does "compared with
what?" on landfill, S3 repeats it on costs) and the data is never shown. Give each
session one job: S1 read a result; S2 what the data show and why the obvious
comparisons mislead; S3 how a lottery gives a fair comparison. Keep the whole day
on **costs in AED** (landfill only on the triage cards, or convert the cards).
The day's story is three numbers for one programme:

| Comparison | Saving per business |
|---|---|
| Before vs after (participants) | 669 AED (likely too small: non-participants' costs rose 143 AED) |
| With vs without (after only) | 1,638 AED (too big: non-participants started far higher, 2,258 vs 1,432) |
| Pilot lottery | 1,014 AED (interval 862 to 1,167; spans the 1,000 AED rule) |

Assumes 90/90/120-minute slots (being confirmed). Cuts for 60/60/75 are noted.

Open question: keep terms first (as below) or a data-first order (case, data
and descriptives, comparisons, regression as a way to report a difference,
uncertainty), which would partly merge and swap S1 and S2. Lucas asked for
terms first.

### Session 1: Reading a result (mostly current deck)
1. The GreenWaste case study: case map; hand out the picture card
2. Where GreenWaste fits: Module 1 theory of change; costs highlighted
3. A results table lands on your desk: self-check on the five terms
4. Mean: ten businesses, worksheet Q1, reveal; what the mean hides (restore
   "remove the largest business" visual)
5. Treatment effect: what the programme caused vs what would have happened
   without it (simple actual vs without-programme picture)
6. Coefficient: which row is the start, which is the change (Q2)
7. What the minus sign means
8. Confidence interval with a restored visual (100-studies chart or three
   intervals around the same estimate) (Q4)
9. P-value: small is not the same as important (restore "significant is not
   the same as big") (Q5)
10. Against the 1,000 AED rule (interval chart)
11. Pair check and debrief (option A)
12. AI exercise: mark up a realistic AI reading of the table, then run the
    better prompt
13. Close: what would you tell the director? Teaser: was -669 the effect?
If 60 min: drop the p-value visual; keep one interval visual.
Board/activities: none; worksheet done as you go.

### Session 2: What do the data show? Compared with what? (rebuilt)
1. Callback: this morning we read -669. Was it GreenWaste's effect? Predict.
2. Meet the data: a few real rows on screen; one row = one business; column
   meanings. Worksheet: describe one business in words.
3. Who took part: city score 58 or below joined (4,794 vs 5,206); bar chart
4. Describing costs: histogram before the programme; mean vs median; spread.
   Worksheet question.
5. Before and after for participants: 1,432 -> 763 chart; did every business's
   cost fall? (distribution of changes)
6. What else changed that year? Brainstorm; introduces the counterfactual
7. Non-participants: 2,258 -> 2,401, costs rose. What does that say about -669?
8. With vs without: 763 vs 2,401 = -1,638; reveal starting levels; two-group
   before/after chart
9. Two numbers, two biases (-669, -1,638). Which would you trust? Neither, so
   we need a fair comparison (to S3)
10. Claim triage with Fiona's four cards (compared with what / how big / how
    sure; act / ask first / do not act)
11. AI exercise: mark up a realistic AI reading of the before/after chart,
    then run the better prompt (adapt old S2 AI Snapshot)
12. Close: one question for the evaluator
If 60 min: drop the histogram detail (4); shorten triage to two cards.
Replaces the current S2 almost entirely (landfill headline and "who else saw
waste fall" go).
Board/activities: the optional A1 claim-triage board
(`Oct12_session2_board_A1.pdf`) and the four claim cards move to step 10 as
the main group activity: groups write card numbers in their marker colour on
the grid; debrief two disagreements. Worksheet grid is the fallback. Three of
the four cards are about landfill: convert to costs or add one sentence that
landfill is the second outcome. Optional flipchart "three numbers" line: mark
the 1,000 AED rule, add -669 and -1,638 here; S3 adds -1,014 with its interval.

### Session 3: Did the programme make the difference? The pilot lottery
1. Recap: -669 vs -1,638 and why each is unfair
2. The pilot district: 400 businesses; a lottery chose 200 (picture card)
3. What a lottery buys you: physical draw with the twenty numbered manager-age
   slips (volunteer draws ten; room compares average age of drawn vs not drawn;
   draw again), then the live R draw repeats it many times (restore "draw the
   lottery again"). The physical draw is the no-internet fallback.
4. Four businesses or four hundred? Slider: small lotteries can be unbalanced
   (restore)
5. Did the real draw work? Starting costs 1,390 vs 1,411
6. The effect is a difference of two averages: 769 vs 1,783 = -1,014
7. The regression gives the same number: callback to S1; here the coefficient
   is a treatment effect because the design supports it
8. Break
9. How sure: interval 862 to 1,167 against 1,000 AED; it spans the rule
10. Optional: what if the trial had been smaller? (wider interval)
11. Who does this apply to? One district, scores 58 or below
12. Three numbers side by side: -669, -1,638, -1,014 (day's summary visual;
    add -1,014 to the flipchart line)
13. Your recommendation in three sentences (worksheet)
14. AI exercise: a paragraph for the minister; mark up, then better prompt
15. Close: one question that could change your decision
If 75 min: drop the slider (4) and smaller-trial slide (10).

Unaffected by this restructure: RDD number line (D2 S2), value-for-money wall
(D3 S1), report credibility grid (D4 S1). Check their fit when reviewing those days.
