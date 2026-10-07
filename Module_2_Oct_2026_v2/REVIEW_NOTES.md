# Module 2 review notes (Fiona), October 2026

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
