# Module 2 — Exercise Plan

**Running brief for our exercises partner · Abu Dhabi Impact Evaluation Training · October 2026**

This document lists every in-session exercise across Module 2, so the partner can build the materials for each one. It grows as we develop each session. For each exercise it gives what it is, roughly when in the session it appears, its type, the materials needed, and a description of what the partner should build.

Where an exercise is not fully built into the slides, the slide carries a placeholder (a short Menti quiz or the exercise instructions) and the build details live here. The slides carry the in-room instructions; this doc is the build brief.

## What changed in this revision (21 Sep 2026)

Reviewed the current `.qmd` for all twelve sessions and refreshed every table to match the latest slides. Two changes run across the whole module:

- **The decks now have the Menti plumbing wired in, but the polls still need building.** Each deck defines one join code (`MENTI_CODE`) and, where results are shown, an embed ID (`MENTI_EMBED`), and renders a QR code on the poll slide plus a live results view on the reveal slide. Slides that hold a poll are marked `[MENTI PLACEHOLDER]` because the polls do not exist yet. So the partner still builds the Menti polls: **set up one Menti presentation for the week**, create each poll with the exact question and options listed below, and hand Fiona the join code and the presentation embed ID to drop into the decks. Low-tech hands are the fallback everywhere.
- **Three sessions that were placeholders are now drafted:** Oct 12 S2 (illustrative traffic-camera case), Oct 14 S1 (cost-benefit), and Oct 14 S2 (data visualisation). Their exercises are filled in below.

Still awaiting real case data: Oct 12 S2/S3 (was Police), Oct 13 S1 (DOH), Oct 13 S2 and S3 (DCD). Those cases run on illustrative or placeholder figures for now; the exercise structure is final so materials can be built when the data lands.

---

## Oct 12, Session 1 — Compared to What? (Know the Language First)

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Opening decision poll — Al Falah "fund a second year?" | ~0:08 · Section 1, "Many times we make decisions based on numbers" (result shown on "Did it work?") | Live Menti poll (embedded), QR on slide | The Menti presentation with this poll; QR + live results are already in the deck | Single MC: "Traffic fatalities fell 30% in one year. Would you fund a second year?" Options: Fund it / Do not fund / Not on this alone. The deck shows the live results on the "Did it work?" slide, then reveals that a second, hidden world produced the same headline. Partner: create this poll in Menti and give Fiona the join code and embed ID. | Menti poll to build (deck embeds it) |
| Word 2 — the 2×2 by hand | ~0:35 · Section 3, "Word 2 · Treatment effect" | Individual/pair hands-on arithmetic | Optional printed 2×2 card (before/after × two groups) | Participants read a treatment effect off a 2×2: each group's change over time, then the difference of the changes. The deck shows the grid; a small printed card mirroring it (Change column and bottom row blank) helps them do the two subtractions by hand. Optional. | Optional handout |
| AI Prompt Cards — one prompt per group | ~0:52 · Section 4, "AI prompt cards" | Small-group hands-on + AI | A deck of 4 prompt cards; one device with AI access per group | Four cards, each a ready-to-paste prompt: (1) "Explain what a 95% confidence interval means…" (planted error: says there is a 95% probability the true value is in *this* interval), (2) "Explain what a p-value means", (3) "School pass rates rose 5 percentage points after our programme. Is that a good result?" (no comparison, no bar), (4) "The coefficient on class size is −0.32. What should I do about it?" (recommendation with no interval). Groups paste, mark what the AI overstates, compare with the debrief slide. Partner: design the 4 cards (prompt on the front, space to note errors); text is final on the slide. | Cards to design |
| Terms Bingo — closing exercise | ~1:15–1:30 · Section 5, "Terms bingo" | Hands-on group card/handout | One bingo card per participant or pair (terms randomised per card); the 8 excerpt slips | A bingo grid of this session's terms (mean, comparison group, treatment effect, coefficient, p-value, confidence interval, statistically significant, sample size, baseline). The 8 real-evaluation excerpt slips are now finalised in the deck (Section 5) and are read aloud to "call" terms in context; excerpts 3 and 8 are the ones the room must judge with the three questions. Partner: build the bingo cards and print the 8 excerpt slips. A small prize for first bingo is optional. | Handout + slips to build |

*Dropped since the last revision: the "BrightStart prediction" poll, the "what's missing" word cloud, and the significance true/false quiz. The session now opens on the Al Falah case and teaches significance through the Word 4 slides rather than a quiz.*

---

## Oct 12, Session 2 — What Do the Numbers Say? (Illustrative Traffic-Camera Case)

*Now drafted. Runs on a fictional automated-speed-camera dataset (the case names no real body); every figure carries an illustrative-data disclaimer.*

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Commitment poll — "Would you fund the extension?" | ~0:20 · Section 2, "Would you fund the extension?" | Live Menti poll (embedded), QR on slide | The Menti poll; QR is in the deck | Single MC on the headline (−22% before-and-after): "Would you commit the money?" Options: Yes / No / Not on this alone. Same poll shape as Session 1: the room commits before seeing the comparison group. Partner: create the poll in Menti. | Menti poll to build |
| AI Snapshot — mark up "three sentences for a decision-maker" | ~0:38 · Section 4, "AI Snapshot" | Small-group hands-on + AI (mark-up demo) | Printed copy of the flawed AI answer, one per group; a device with AI access per group; a printed copy of the results table | Groups paste the results table with the prompt "Explain this result to a decision-maker in three sentences. They have a rule: avoid 2.0 collisions per segment per round to be funded", then mark up the response. Three planted problems: the 22% is real but not the impact (the true estimate is 1.13), "likely to be even larger" is invented, and the flagged closing sentence recommends national funding the table does not support. Partner: print the flawed answer with room to annotate, plus a facilitator key naming the three errors, and the results table. Swap in Fiona's real capture when available. This session's AI Snapshot is the shorter demo-plus-debrief form, not the full bad-prompt/good-prompt group exercise. | Handout to build (real capture to be swapped in) |

---

## Oct 12, Session 3 — Spot the Problem (Naive Comparisons and RCT Reading)

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| "Which would you trust?" poll | ~0:26 · Section 2, "Which would you trust?" | Live Menti poll (embedded), QR on slide | The Menti poll; QR is in the deck | Single MC: "Both comparisons say GreenWaste worked. Which would you trust more?" Options: Before-and-after / With-and-without / Neither on its own. Show live results before the reveal; collect a few verbal "why" answers. Partner: create the poll in Menti. | Menti poll to build |
| "On your desk" pair discussion | ~0:16 · Section 1 | Think-pair-share (no tech) | None (optional flipchart) | None. | In slides |
| Randomisation true/false quiz | ~0:36 · Section 3, "True or false?" | Live Menti quiz (embedded) | The Menti quiz, 3 statements | Three true/false statements on what randomisation does and does not do (text on the slide). Reveal one at a time. Item 1 ("only balances measured things") is the key misconception. Partner: build as a Menti quiz (or run as hands). | Menti quiz to build |
| AI Snapshot — main group exercise | ~0:38–0:56 · Section 5 | Group work (pairs / tables) | Printed flawed AI answer (one per pair); two prompt cards (short Prompt A, full Prompt B), one set per group; a working AI tool per table, tested beforehand | Three parts: (1) mark up the flawed AI answer and find the four planted errors; (2) run the short prompt vs the full prompt on the same before-and-after scenario and compare; (3) paste the second answer into a fresh chat and ask it to review for errors. Partner: produce the printed flawed-answer handout plus a facilitator key, the two prompt cards, and a short debrief worksheet. The deck's flawed answer is an invented placeholder for now; swap in Fiona's real capture when available. | Handouts to build (deck refers to them) |
| Abu Dhabi RCT — group reading | ~0:58–1:03 · Section 6 | Group work + report-back | Case handout (balance table + estimate + case facts) — pending real findings | Groups read the randomised result in three steps (balance / which number is the impact / does it clear the 1,000 AED rule), then a report-back with a confidence verdict and "one question for the evaluator". Placeholder currently in the slides; structure mirrors the GreenWaste reading. | PLACEHOLDER — awaiting case data |
| Closing "three questions" take-away card | ~1:04 · Section 7, closing slide | Handout (take-away) | Printed pocket card, one per participant | A small take-away card with the three questions: compared to what? how do you know the groups started out alike? does it clear our decision rule, not just zero? Optional. | Handout (optional) |

---

## Oct 13, Session 1 — Reading DiD Results (Abu Dhabi DOH)

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Opening poll — "Did the programme work?" | ~0:20 · Section 1, "Did the programme work?" | Live Menti poll (embedded), QR on slide | The Menti poll; QR is in the deck | Single MC asked before the comparison group is revealed, and revisited after: "Based on this evidence, did the programme work?" Options: Yes / No / Not on this alone. Partner: create the poll in Menti so the room sees the count shift. Hands are the fallback. | Menti poll to build |
| Fill-in-the-blanks: the four numbers | ~0:38 · Section 2, "Your turn: four numbers, two minutes" | Individual hands-on | Printed "four-numbers card", one per participant | Participants do two subtractions by hand (each group's change over time, then the difference of the changes) to get the DiD estimate. Partner: design a clean one-page card mirroring the slide's 2×2, with the Change column and bottom row blank. | Handout to build |
| "Which row is the impact?" vote | ~0:52 · Section 3, "Which row is the impact?" | Quick vote / optional Menti | None, or a Menti poll | After the regression output appears, the room votes on which coefficient is the programme's effect (the interaction is the answer). Partner: optional Menti MC (Intercept / round / enrolled / round:enrolled). | In slides (verbal); Menti optional |
| Parallel-trends "which would you trust?" vote | ~1:00 · Section 4/5 | Vote (per panel) | None, or a Menti poll | Small charts (parallel / already diverging / already converging). Vote on each whether the DiD can be trusted. Note: GreenWaste has only one pre-period, so this teaches the idea; the deck substitutes a baseline-balance table for a pre-trend test it cannot run. Partner: optional Menti (quick yes/no items). | In slides; Menti optional |
| AI Snapshot — main group exercise | ~1:06–1:25 · Section 6 | Group work (pairs / tables) | Printed flawed AI answer (one per pair); two prompt cards (Prompt A short, Prompt B full); the regression table on the handout; a working AI tool per table | Three parts: (1) mark up the flawed AI answer and find the four planted errors; (2) run the short vs the full prompt on the same table and compare; (3) paste the second answer into a fresh chat and ask it to review. The planted errors escalate this session: a fabricated "parallel trends holds" claim, significant-≠-meets-the-rule, a sign/direction muddle, and the wrong coefficient named as the impact. Partner: produce the printed AI-answer handout plus a facilitator key, the two prompt cards, and a short debrief worksheet. Confirm an AI tool at each table. | Handouts to build (deck refers to them) |
| Abu Dhabi DOH case — group exercise | ~1:26–1:40 · Section 7 | Group work + verdict round | DOH case handout (table + case facts) — pending real DOH findings | Groups read the DOH DiD table using the four reading steps, then a verdict round: act / act with caveats / send back. Placeholder in the slides; structure mirrors the GreenWaste reading. | PLACEHOLDER — awaiting DOH data |

---

## Oct 13, Session 2 — Reading RDD Results (Abu Dhabi DCD)

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Trap poll — "Which side is which?" / the whole-market gap | ~0:08 · Section 1, "Which side is which?" | Live Menti poll (embedded), QR on slide | The Menti poll; QR is in the deck | A question put to the room before the reveal about the offered-vs-not-offered gap: does the gap show the programme worked, and how big is the effect? The room commits, then sees the two sides differ across the whole index. Partner: build the poll (Yes, it caused it / No / Can't tell). Hands are the fallback. | Menti poll to build |
| By-hand jump — narrow-band averages | ~0:11 · Section 2, "Your turn: the jump by hand" | Individual / pairs hands-on (printed card) | Printed "narrow-band" card, one per participant or pair | Participants estimate the RDD jump by hand: average the costs of businesses just below the cut-off (scores 55–58, offered) and just above it (59–62, not offered), then subtract. Partner: design a one-page card (Just below / Just above / Difference) with about 10–12 example businesses per side (efficiency score and waste cost) so the class lands near the real figure. Fiona to supply the example rows from the data. | Handout to build (needs example rows from Fiona) |
| Which row is the effect? — coefficient vote | ~0:22 · Section 3, "Running the regression" | Live vote (hands or Menti) | None, or an optional Menti poll listing the four rows | After the regression table appears, the room votes on which of the four rows (Intercept, c0 slope, enrolled, c0:enrolled) is the programme's effect, before the reveal. Partner: optional Menti with the four rows. | In slides (hands); Menti optional |
| AI Snapshot — mark up the flawed response | ~0:38 · Section 5, "Feeding the RDD table to AI" | Small-group hands-on (printed handout) | Printed copy of the AI response, one per group, with room to annotate | Groups read a sample AI answer to "Explain these results" and mark anything wrong. Four planted issues (a local result stated as national, the slope read as the effect, the decision rule ignored, an invented p-value) but do not print the number; let groups find what they can. A real captured example will replace the invented one once Fiona tests the prompt. | Handout to build (real capture to be swapped in) |
| AI Snapshot — bad prompt vs good prompt + fresh-chat review | ~0:44 · Section 5, "The same table, a better prompt" and "Your turn" | Small-group hands-on + AI (device per group) | Two printed prompt cards; a printed copy of the RDD results table; a device with AI access per group | Groups run both prompts on the same table (the short "Explain these results" and the full commissioner prompt, which states the 1,000 AED rule, notes the estimate is local, and asks the model to ask questions first), then paste the second answer into a fresh chat to review for errors and overstatement. Partner: design the two prompt cards (text on the slides) and a printed RDD results table. | Cards + table handout to build |
| Verdict round — the DCD case | ~1:22 · Section 6, "Read it, then decide" (placeholder) | Live vote (hands) | None (optional flipchart) | After reading the Abu Dhabi DCD RDD result, the room votes: act on it, act with caveats, or send it back. No build yet; awaiting the real DCD Social Protection findings. The exercise structure (read the table, then a three-way verdict) is final. | Awaiting DCD data; structure final |

---

## Oct 13, Session 3 — Reading Matching Results (Two Case Studies)

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Opening poll — "Would that be fair?" / the naive gap | ~0:08 · Section 1, "Would that be fair?" | Live Menti poll (embedded), QR on slide | The Menti poll; QR is in the deck | A question before the reveal about the enrolled-vs-not gap and whether building a comparison group yourself is fair: "Enrolled businesses spend far less than those that did not. Did the programme cause that whole gap?" Record the guess, revisit after the selection point. Partner: optional single-MC Menti (Yes / No / Can't tell). Hands are the fallback. | Menti poll to build |
| "Find the twins" — matching by hand | ~0:18 · Section 2, "Your turn: find the twins" | Individual hands-on | Printed "twins card", one per participant | Participants match each of 3 enrolled businesses to the most similar not-enrolled candidate (on characteristics, not cost), then read off the cost gap between the pairs. Partner: design a clean one-page card (3 enrolled rows, 3 candidates) with space to draw pairings and note the gap. The point they should feel: matching discards candidates with no good twin. | Handout to build |
| AI Snapshot — main group exercise | ~1:00–1:14 · Section 6 | Group work (pairs / tables) | Printed flawed AI answer (one per pair); two prompt cards (Prompt A short, Prompt B full); the matching table on the handout; a working AI tool per table | Three parts: (1) mark up the flawed AI answer and find the four planted errors (balance treated as proof of no bias; a fabricated robustness-to-unobservables check; the 1,000 AED rule ignored; an invented p-value); (2) run the short vs the full prompt on the same table and compare; (3) paste the second answer into a fresh chat and ask it to review. Partner: produce the printed flawed-answer handout plus a facilitator key, the two prompt cards, and a short debrief worksheet. Swap in Fiona's real capture when available. | Handouts to build (deck refers to them) |
| Two case studies — "which do you believe?" | ~1:20–1:30 · Section 7, "Which one do you believe?" | Group work + verdict round | Case 1 (GreenWaste) summary; Case 2 (imperfect-match case) handout — pending real DCD findings | Groups compare a clean matching study (Case 1) with a messy one where many treated units had no good match (Case 2): which gives more confidence and why, what they would ask Case 2's evaluator that Case 1 does not raise, then a verdict round (act / act with caveats / send back). Partner: build two one-page case summaries (overlap picture, share of treated units matched, the estimate and its uncertainty) for side-by-side reading, plus verdict cards. Build Case 2 once the data arrives. | PLACEHOLDER — awaiting DCD data |
| Closing "three questions" take-away card | ~1:32 · Section 8, closing slide | Handout (take-away) | Printed pocket card, one per participant | A take-away card with the three questions to ask any evaluator presenting matching: what did you match on and what could you not measure? how many treated units had a good match, and who got dropped? does it clear our bar, and does the answer hold if you change what you matched on? Optional. | Handout (optional) |

---

## Oct 14, Session 1 — Was It Worth It? (Cost Analysis)

*Now drafted. Runs on the GreenWaste cost-benefit model, carried forward from Day 2.*

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Approval poll — "Would you approve it?" | ~0:12 · Section 1, "Would you approve it?" | Live Menti poll (embedded), QR on slide | The Menti poll; QR is in the deck | Single MC on the headline benefit-cost ratio: "On a ratio of 1.87, what would you do?" Options: Approve / Reject / I need to know something else first. If most pick the third, ask two people what they need and write it up to compare with the three questions at the end. Partner: create the poll in Menti. | Menti poll to build |
| AI Snapshot — "find the scenario that breaks it" | ~0:55 · Section 4, "AI Snapshot" | Group work + AI | The cost-benefit table on a handout; two prompt cards (basic vs better); a device with AI access per group | Groups paste the cost-benefit table with a prompt and ask the model to find the scenario that breaks the ratio, mark up the flawed `.ai-output` answer, then run a better prompt (names the discount rate, the horizon and the decision it feeds) and compare. Debrief theme: the AI gets the arithmetic and the right lever but supplies no numbers. Partner: print the cost-benefit table, and the two prompt cards (text on the slides). | Handout + cards to build |
| Abu Dhabi cost-benefit case — apply the three questions | ~1:20 · Section 5, "The cost-benefit case" (placeholder) | Group work + report-back | Case handout — pending the real case | Groups run the three-question framework (are the benefits plausible? are all the costs included? what would flip it?) on the real cost-benefit case, then present. `[PLACEHOLDER]` in the slides; build once the case arrives. | PLACEHOLDER — awaiting case data |

---

## Oct 14, Session 2 — What Can You Read? What Might Be Wrong? (Data Visualisation)

*Now drafted. Discussion-heavy; no live Menti poll in this session. Built on figures drawn from the three datasets the week has already used.*

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| "Which figure would you put in a briefing?" | ~0:12 · Section 1, "The same gap, drawn to fill the frame" | Think-pair-share (no tech) | None (optional flipchart) | The same GreenWaste gap is shown twice, once on a zero axis and once truncated to fill the frame. In groups, two minutes: which figure would you put in a briefing, and why? Sets up the "read the axis first" rule. No build. | In slides |
| Pie chart — "what is it not telling you?" | ~0:44 · Section 6, "What is this pie not telling you?" | Think-pair-share (no tech) | None (optional flipchart / worksheet) | A real severity-mix pie from the dataset. In groups, three minutes: write what the pie cannot show (no denominator, no change over time, no comparison). Optional: a half-page worksheet with the pie and space to write. | In slides (optional worksheet) |
| AI Snapshot — "the chart that cannot be wrong" | ~1:05 · Section 7, "AI Snapshot" | Group work + AI | The two GreenWaste baseline figures (zero-axis and truncated) on a handout; two prompt cards; a device with AI access per group | Groups give the model both baseline figures with the prompt "Which chart better shows the difference between the two groups, and why?" and mark up the `.ai-output`. The planted failure: the AI makes true statements about the charts but never asks the question that matters (which is honest for the reader). Then a better prompt that names the reader and the sentence the chart must support. Partner: print the two figures and the two prompt cards. | Handout + cards to build |
| Closing — start compiling QA-clinic questions | ~1:25 · Section 8, closing slide | Individual prompt (no tech) | None | The session closes by asking participants to start writing the questions they will bring to tomorrow's QA clinic (Oct 14 S3). No build; flagged so the clinic's opening can reference it. | In slides |

---

## Oct 14, Session 3 — "Interrogate the Analyst" (QA Clinic)

*Materials built and ready to print: `Oct14_session3_qa_checklist.qmd` renders to docx with all twenty questions in four areas, and the same source drives the deck.*

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Sign-off vote (opening and close) | ~0:05 opening · Section 0, "Would you sign off?"; repeated at the close | Live Menti poll (embedded), QR on slide | The Menti poll (one, reused for both votes) | "Would you sign off on this evaluation for national scale-up?" Three options (e.g. Sign off / Sign off with conditions / Send back). Run before the clinic and again at the end so the two votes can be compared. Partner: create the poll in Menti. Hands are the fallback. | Menti poll to build |
| Sort strong from weak questions | ~0:35 · Section 2, "Your turn: sort these" | Hands-on group card (no tech) | Printed set of 8 candidate questions, one per group | Eight candidate questions the room marks S (strong) or W (weak); the reveal explains why. Partner: print the 8 questions as slips or a single card; the text is final on the slide, and the facilitator key is the "which of those survived" slide. | Handout to build |
| The clinic — interrogate the analyst | ~0:50–1:35 · Section 3 | Group work (role-play) | The printed QA checklist (built: `Oct14_session3_qa_checklist`), one per group | Groups of four interrogate the trainer, who plays the evaluator, one checklist area at a time (methodology, assumptions, data quality, results/reporting); any group may follow up once. Groups get five minutes to agree their three sharpest questions first. Partner: just print the QA checklist (already built). | Checklist built — print only |
| AI question list, then compare | ~1:35 · Section 3, near the close | Group work + AI | A device with AI access per group | Each group asks an AI to generate a question list for interrogating the analyst, then compares it with the questions the room itself produced. No printed build; confirm an AI tool per group. | In slides |

---

## Oct 15, Session 1 — Is This Evidence Credible? (QA Deep Dive)

*Materials built and ready to print: `Oct15_session1_report.qmd` renders to docx as the fictitious report the room rates, and `Oct15_session1_rating_sheet.qmd` renders to docx as the rating sheet. Both are generated from `qa_rating.R`, which also drives the deck's reveal slides.*

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Sign-off vote (before reading and at the close) | ~0:05 opening · Section 0, "Before you open it"; repeated at the close | Live Menti poll (embedded), QR on slide | The Menti poll (one, reused for both votes) | The same sign-off question as the clinic, three options, run before reading the report and again at the end so the two votes can be compared. Partner: create the poll in Menti. | Menti poll to build |
| Rate the executive summary alone | ~0:20 · Section 1, "Read the summary and rate it" | Individual hands-on (five minutes) | The report and the rating sheet (both built) | Five minutes, working individually before any group discussion: read the executive summary and rate it on the rating sheet. Partner: print the report and the rating sheet (already built). | Handouts built — print only |
| Rate the remaining five sections, then defend | ~0:40–1:15 · Section 3, section by section | Group work (colour + reason) | The rating sheet (built) | Rate the remaining five sections (design, data, results, limitations, conclusions) on the rating sheet, one colour plus the reason that decided it; groups then defend their colours. Amber is framed as the most useful rating. Partner: rating sheet already built. | Handout built — print only |
| AI credibility verdict, then compare | ~1:20 · Section 4 | Group work + AI | A device with AI access per group | Each group asks an AI for a credibility verdict on the report, then compares it with the group's own rating. No printed build; confirm an AI tool per group. | In slides |

---

## Oct 15, Session 2 — From Findings to Policy (Evidence Translation)

*Materials built and ready to print: `Oct15_session2_findings.qmd` (the six-finding pack) and `Oct15_session2_brief_template.qmd` (the one-page brief template), both rendered to docx and generated from `qa_translation.R`, which also drives the deck.*

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Commitment vote (before the findings and before writing) | ~0:05 · Section 0, "The number the decision turns on"; repeated before writing | Live Menti poll (embedded), QR on slide | The Menti poll (one, reused for both votes) | Whether to recommend rollout, three options, voted before the findings are read and again before writing the brief. Partner: create the poll in Menti. | Menti poll to build |
| Read the six findings, mark what each can bear | ~0:15 · Section 1 | Individual/pairs hands-on | The findings pack (built) | Read the six Tariff Shield findings and mark each for what it can and cannot bear (which is sound, which is a null, which carries the cost overrun). Partner: findings pack already built. | Handout built — print only |
| Write the brief | ~0:40 · Section 2, "Four elements, one page" | Pair hands-on (writing) | The brief template (built), one per pair | In pairs, write the brief: four elements (headline sentence, recommendation, risk, and the number the decision turns on) on the printed template, one side of A4. Partner: template already built. | Handout built — print only |
| Swap and critique | ~1:05 · Section 3, "Swap" | Group work (peer critique) | The completed briefs; the six checks on the closing slides | Pairs swap briefs and critique against the six checks. Partner: no build; the checks are on the slides. | In slides |
| AI Snapshot — draft the brief, then edit as a team | woven into Section 2 | Group work + AI | A device with AI access per group | Have the AI draft the brief, then edit it as a team. Planted failures: it never mentions the 900 AED threshold, calls a non-significant estimate a benefit, and omits the cost overrun. Partner: no printed build; confirm an AI tool per group. | In slides |

---

## Oct 15, Session 3 — Plan Your Own Evaluation (Building on Module 1)

*Team working time followed by a pitch. No AI Snapshot in this session. Material built and ready to print: `Oct15_session3_design_template.qmd` renders to docx as the Evaluation Design Update template (generated from `qa_design_update.R`); it recaps Module 1's eight conditions so teams can complete it without the Module 1 document to hand.*

| Exercise | When (approx.) | Type | Materials needed | What the partner builds / needs to know | Status |
|---|---|---|---|---|---|
| Opening readiness check | ~0:03 · Section 0, "How far along is your design?" | Quick poll / show of hands | Optional Menti | "How far along is your design?" Not started / rough outline / drafted / ready to pitch. Partner: optional Menti; a show of hands is fine. | In slides; Menti optional |
| Part 1 — current design against the eight conditions | ~0:10–0:30 · Section 1, "Working time" | Team working time | The design template (built), one per team | Twenty minutes: write the current design against Module 1's eight conditions in Part 1 of the template. Partner: template already built. | Handout built — print only |
| Part 2 — the four additions | ~0:35–1:05 · Section 2, "Working time" | Team working time | The design template (built) | Thirty minutes: complete the four additions (results-presentation plan, cost-benefit framework, visualisation sketch, evidence-translation plan) in Part 2. Partner: template already built. | Handout built — print only |
| Team pitch + room feedback | ~1:10–1:55 · Section 3 | Group presentation + structured feedback | Timer; optional printed pitch structure and feedback order | Five-minute pitch per team using the timed five-part structure on the slides (limit first), then three minutes of room feedback in a fixed order, written down and aimed at the design not the team. Partner: optional printed pitch-structure and feedback-order cards; both are on the slides. | In slides (cards optional) |
