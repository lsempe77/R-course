# Abu Dhabi Impact Evaluation Training — Module 2

## Project Overview

The goal of this project is to develop material for the second module of an impact evaluation training we are delivering in Abu Dhabi from Oct 12-15. Focus on the Module_2_Oct_2026 folder which contains the outline for each day and session and within which we will be developing materials. Reference the other folders mentioned in the section below (outside of Module_2_Oct_2026) only for some previous material that we can reuse - but brainstorm with me some ways to adapt to the outline for the particular module we are working on. We will develop quarto files for each session, which should be labelled [monthday_session#] - e.g., Oct12_session1. Some sessions will use evaluation_data_GreenWaste data in this folder, while others or parts of sessions (especially case studies) require me to upload data that we do not yet have in the folder. Compared to the previous training sessions we had, which were more focused on training students to use R, these modules and materials need to focus more on interpreting the results and include AI in every aspect. They should not include code or running code directly within the sessions and instead focus on interpretation, as well as AI best practices for us in evaluation (as and when useful to mention).

In close consultation with me, develop sessions based on the outline. We will develop one at a time based on whichever I ask you to work on. Wait for my input on your ideas before developing or editing any files in this folder.

Output format: quarto files and powerpoint versions of the quarto files.

A few ideas I had on critical questions they should learn to ask AI throughout the sessions/for each method (not necessarily in this format or way but whatever way will help the AI not make mistakes or help us catch its mistakes):
    - Ask about data needed for DID
    - Ask about assumptions and limitations
    - Ask AI to help you review graphs/charts
    - How to interpret the results

In general, we should try to include some real examples of AI making mistakes when responding so they are tangibly shown the risks, and remind them to ask the AI to ask them questions before responding, and to remind them to review (or have a second chat/AI to review) the output for potential misunderstanding or mistakes.

---

## Audience and the Code Question

**Audience:** consumers and commissioners of evaluation — people who receive evaluation reports and must decide what to do about them. They are not analysts. They will not write R, and they will not read R.

**The resolution of an apparent conflict in the outline.** The outline says the trainer "runs the analysis in R and projects the output." CLAUDE.md says sessions should not include code. Both hold, as follows:

- The trainer *may* run R live as a demonstration of where numbers come from.
- **No slide ever displays syntax.** Every chunk is `echo=FALSE`. Slides show tables, figures and plain-language labels only.
- Participants are never asked to write, run, or debug anything.

**The test for any slide:** would a director-general who has never opened R get value from this slide? If not, cut it or rewrite it.

**What this means when adapting the legacy decks.** The `sessions_in_Abu_Dhabi` material was built to teach R to analysts. Expect to cut roughly half of any legacy deck: implementation chunks, "Implementing X in R", package names, estimator variants (TWFE, staggered adoption, Callaway & Sant'Anna, polynomial specifications), and robustness machinery that a commissioner would never run. Expand instead the few slides that teach *reading*: what each number means, which number answers the decision question, what has to be true for it to be believed, and what to ask the evaluator.

---

## Session Map

Filenames follow `[Monthday]_session[#].qmd`. "Legacy source" is the file in `sessions_in_Abu_Dhabi` to adapt from — several sessions have no legacy source and are built from scratch.

| Day | # | Filename | Topic (outline title) | Legacy source | Length |
|---|---|---|---|---|---|
| Oct 12 | 1 | `Oct12_session1.qmd` | Compared to What? — Know the Language First | — | 1.5h |
| Oct 12 | 2 | `Oct12_session2.qmd` | What Do the Numbers Say? — Abu Dhabi Police | `session_5_updated.qmd` (partly) | 1.5h |
| Oct 12 | 3 | `Oct12_session3.qmd` | Spot the Problem — Naive Comparisons and RCT Reading | `session_6_updated.qmd` | 2h |
| Oct 13 | 1 | `Oct13_session1.qmd` | Reading DiD Results — Abu Dhabi DOH | **`session_9_updated.qmd`** | 1.5h |
| Oct 13 | 2 | `Oct13_session2.qmd` | Reading RDD Results — Abu Dhabi DCD | **`session_8_updated.qmd`** | 1.5h |
| Oct 13 | 3 | `Oct13_session3.qmd` | Reading Matching Results — Two Case Studies | `session_10_updated.qmd`, `session_10_updated_CEM.qmd` | 2h |
| Oct 14 | 1 | `Oct14_session1.qmd` | Was It Worth It? — Cost Analysis | — | 1.5h |
| Oct 14 | 2 | `Oct14_session2.qmd` | What Can You Read? What Might Be Wrong? — Data Visualisation | — | 1.5h |
| Oct 14 | 3 | `Oct14_session3.qmd` | "Interrogate the Analyst" — QA Clinic | — | 2h |
| Oct 15 | 1 | `Oct15_session1.qmd` | Is This Evidence Credible? — QA Deep Dive | — | 1.5h |
| Oct 15 | 2 | `Oct15_session2.qmd` | From Findings to Policy — Evidence Translation | — | 1.5h |
| Oct 15 | 3 | `Oct15_session3.qmd` | Plan Your Own Evaluation — Building on Module 1 | — | 2h |

**Note the easy mistake:** `session_8` is RDD and `session_9` is DiD. Day 2 runs DiD *first*, so the session numbers are crossed relative to the legacy files.

---

## Build Conventions

- **Formats:** `revealjs` (primary, for delivery) and `pptx` (secondary, lossy — see the pptx section below). Both declared in the YAML header of every session file.
- **Theme:** `[clean.scss, module2.scss]` — `clean.scss` is the base (Grant McDermott's quarto-revealjs-clean); `module2.scss` is ours and carries the type scale, callout components and palette. Both must live in `Module_2_Oct_2026/`.
- **Slide size:** `width: 1280`, `height: 720` in the revealjs block.
- **Data path:** relative — `./evaluation_data_GreenWaste.csv`. Keep all session files and data in the same folder so paths stay simple.
- **All chunks `echo=FALSE`.** Set it once in the YAML (`knitr: opts_chunk: echo: false`) rather than per chunk, so a stray chunk cannot leak code onto a slide.
- **Author field:** 3ie (the legacy decks are authored "Dr. Lucas Sempé" — do not carry that over without asking).
- **Slide budget:** roughly 22-28 slides for a 1.5h session, 30-36 for a 2h session. These sessions are discussion-heavy; slide count is low relative to a lecture.
- **Speaker notes carry the timing.** Every section break has a `::: {.notes}` block giving elapsed minutes and the facilitation instruction. The trainer should be able to run the session from the notes alone.
- **Versioning:** `_v1`, `_v2` suffixes. Never overwrite a session file that has been reviewed.

### Known formatting traps (found the hard way — do not repeat)

| Trap | Symptom | Fix |
|---|---|---|
| **pptx slide level** | 40 slides collapse to 19; body text becomes slide titles; images land on the wrong slide | `slide-level: 2` in the `pptx:` block. Mandatory. |
| **Nested fenced divs** | A two-column slide renders as one broken column; content escapes its column | Outer fences need MORE colons than inner: `:::::: {.columns}` > `::::: {.column}` > `::: {.panel}` |
| **`display: inline-block` on `h2`** | The next block floats up alongside the heading | `display: block; width: fit-content;` |
| **Unicode minus in ggplot labels** | Renders as literal `<U+2212>` | Use ASCII `-` inside any `annotate()` / `label =` string. Unicode is fine in markdown text. |
| **Ad-hoc `{.smaller}`** | "Text of different sizes" across the deck | Use the type scale and the callout components; do not hand-tune sizes per slide. |

### The pptx export is lossy — design around it

Quarto's pptx comes from pandoc, not from the revealjs theme. It ignores SCSS entirely, so **none** of our styling reaches it: no callout boxes, no hero numbers, no colour, no type scale. Worse, pandoc allows only **one content block per slide** — a figure followed by a paragraph is silently split across two slides, with the paragraph's first line promoted to a title.

Practical consequences:

- **revealjs (HTML) is the deliverable.** It is what gets presented.
- **For a portable/shareable copy, export the rendered revealjs to PDF** (open the deck with `?print-pdf` and print to PDF). This is pixel-faithful; pptx is not.
- **Only produce pptx when someone genuinely needs editable slides.** If so, expect a plain deck and keep those slides to one content block each.
- A branded `reference-doc:` template would improve pptx fonts/colours, but cannot fix the one-block-per-slide splitting.

---

## Design System

### Palette (validated — CVD-safe, chroma floor, contrast vs surface)

| Role | Hex | Use |
|---|---|---|
| Accent / series 1 | `#00789E` | The programme / offered / treated group |
| Series 2 | `#B45309` | Comparison / not-offered group |
| Alert | `#9A2515` | Decision rules, annotations, flagged AI errors. **Never a data series.** |
| Ink | `#131516` | Primary text |
| Muted | `#5C6467` | Axis labels, secondary text |
| Rule / panel | `#DCE1E3` / `#F4F6F7` | Borders, panel backgrounds |

The `#00789E` / `#B45309` pair passes CVD separation, the normal-vision floor, the chroma floor and contrast. Do not substitute a grey for the comparison group — teal-vs-grey fails colourblind separation.

### Chart conventions

- One shared `theme_m2()` defined in each deck's setup chunk — never per-chart theming.
- `fig.width` ~8–10, `fig.height` ~3.4–4.2, `dpi: 200`, `dev: "png"`.
- Legend at the bottom, no legend title, minor gridlines off.
- Direct-label the values that matter; never label every point.

### Callout components (defined in `module2.scss`)

| Class | Use |
|---|---|
| `.panel` | Neutral framing — context, the decision at stake |
| `.ask` | A question put to the room; a facilitation prompt |
| `.warn` | A caution, a limitation, a "hold that thought" |
| `.ai-output` | Verbatim AI response for participants to mark up; wrap planted errors in `[...]{.flag}` |
| `.hero` / `.stat-row` | The single number a slide exists to deliver; a three-across figure row |
| `.facts` | Case-study "at a glance" key/value grid |
| `.mins` | Timing badge on a section divider, e.g. `# 2 · The result [15 min]{.mins}` |

Use these instead of bold paragraphs. They are what keep the decks visually consistent across twelve sessions.

---

## Recurring Session Architecture

Every method session follows the same beats. This makes the week feel like one course rather than twelve talks, makes each new session faster to draft, and means participants know where they are at any moment.

**Never open on a result.** Every session earns its numbers first: what the programme was, who it reached, what decision hangs on the answer. A statistic shown before the reader knows the case is an abstraction. This is beat 0 and it is not optional.

0. **The case** — the programme, the people, the decision at stake, and the bar the evidence has to clear. One slide of narrative plus a `.facts` "at a glance" panel. Where the data allows, a second slide showing *who is in the evaluation*.
1. **The trap** — a result that looks convincing and is not. Participants commit to an answer before the reveal.
2. **The idea in plain terms** — one paragraph, no equations, and wherever possible an arithmetic exercise participants do by hand.
3. **Reading the output** — the real skill. Walk the actual table an evaluator would hand them, including the numbers that are commonly *mistaken* for the impact.
4. **The one question** — the single assumption the method rests on, what it looks like when it fails, and what to ask when it cannot be tested.
5. **AI Snapshot** — see the template below.
6. **The Abu Dhabi case** — the same reading skills applied to real local findings.
7. **Three questions to ask the evaluator** — a standing closing slide, method-specific, that participants can take back to their desk.

---

## AI Snapshot Template

Every session contains one. The structure is fixed; the content changes by method.

1. **Pre-baked failure (demo, ~5 min).** A realistic flawed AI response is written into the deck. Groups mark it up and find the errors. This guarantees the mistake actually appears and protects the session timing.
2. **Reveal (~3 min).** Name each planted error and why a model makes it.
3. **Bad prompt vs good prompt (~7 min).** Groups run *both* prompts on the same output and compare answers. The bad prompt is the one people actually type ("explain these results"). The good prompt states the decision rule, supplies the context the model lacks, and asks the model to *ask questions before answering*.
4. **Debrief (~5 min).** What did AI soften, overstate, or invent? What did the good prompt recover?

**Two habits to reinforce in every session:** ask the AI to ask *you* questions before it answers; and have a second chat (or a second model) review the first one's output.

### AI Failure Library

Failures observed and planted, to be reused and escalated across the week. Add to this list as sessions are built.

**`AI_failure_exs/` holds real captured examples.** When Fiona runs an AI task herself and the model gets something wrong, the screenshot goes in that folder. Real screenshots beat written-out examples — they carry the model's actual tone and formatting, which is exactly what makes the failure persuasive. Before drafting a session's AI Snapshot, check this folder for a captured example that fits; use it in preference to an invented one, and record it in the table below.

| Failure | What it looks like | Sessions |
|---|---|---|
| **Fabricated robustness check** | Asserts "the parallel trends assumption holds" / "the balance tests confirm" when the data cannot support the claim and no such test was run | Oct13 S1 |
| **Significant ≠ meets the decision rule** | Reads stars, recommends scaling, ignores the stated decision threshold | Oct13 S1, all of Day 2 |
| **Sign and direction muddle** | A fall in costs described as "savings increased by X", changing what the result appears to say | Oct13 S1 |
| **Wrong coefficient named as the impact** | Reports the baseline gap or the time trend as the treatment effect | Oct13 S1 |
| **Invented precision** | Supplies a p-value, CI or sample size that is not in the table it was given | Day 2 generally |
| **Silent generalisation** | States a local estimate as if it applied to everyone | Oct13 S2 (RDD) |
| **Unmeasured-confounder blindness** | Treats matching on observables as if it removed all selection | Oct13 S3 |

---

## Consistency Across Day 2

Day 2 is one story told four ways: the same programme, four methods, two different recommendations. Hold these fixed across the three sessions so they compound.

- **Decision rule (used all week):** the programme must reduce waste expenditures by **at least 1,000 AED** to justify national scale-up.
- **GreenWaste estimates:** DiD **−816 AED** · RDD **−905 AED** · Randomised **−1,014 AED** · IV **−1,033 AED** (ToT).
- **The punchline:** DiD and RDD say *do not scale*; the RCT says *scale*. Same programme, same data, different answers — because each method answers a slightly different question about a slightly different group of businesses.
- Each Day 2 session closes by adding its estimate to a running comparison slide, so the contrast is built up rather than asserted at the end.

---

## Data Inventory

### Available now

**`evaluation_data_GreenWaste.csv`** — 19,826 rows, 22 columns. Fictional GreenWaste Program.

- **Structure:** 4,959 businesses × 2 rounds (`round` = 0 before, 1 after). 100 neighbourhoods. Panel, balanced.
- **Assignment:** `treatment_neighborhood` (neighbourhood offered the programme), `eligible` (efficiency index ≤ 58), `enrolled` (actually offered/enrolled).
- **Important:** within treatment neighbourhoods, `enrolled` is *identical* to `eligible` — perfect compliance, sharp assignment. The DiD comparison group is therefore the businesses that scored *above* the cut-off, which are systematically different by construction. This is a genuine, teachable threat to parallel trends and it explains why DiD understates the RCT.
- **Only two rounds.** Pre-trends cannot be tested with this data. Do not write slides that imply otherwise.
- **Outcome:** `waste_management_costs` (AED).
- **Covariates:** manager/deputy age and education, female manager, foreign owned, staff size, advanced filtration, water treatment system, business area, recycling centre distance, recycling compliance.
- **Key means (treatment neighbourhoods):** offered 1,449 → 784 (−665); not offered 2,079 → 2,230 (+151); DiD = **−816**; baseline gap = −630.

A variant `evaluation_data_GreenWaste_IV.csv` exists in `sessions_in_Abu_Dhabi` for the IV material.

### Still needed from Fiona

| Data | Needed for | Status |
|---|---|---|
| Abu Dhabi Police evaluation data (descriptive + RCT) | Oct12 S2, Oct12 S3 | Not in folder |
| Abu Dhabi DOH health evaluation findings | **Oct13 S1** | Not in folder |
| Abu Dhabi DCD Social Protection RDD findings | Oct13 S2 | Not in folder |
| Abu Dhabi DCD matching case (imperfect matches) | Oct13 S3 | Not in folder |
| Fictitious evaluation report (with planted flaws) | Oct14 S2, Oct15 S1 | To be written |
| Evaluation Design Update template (from Module 1) | Oct15 S3 | Not in folder |

**Placeholder convention.** Where case data has not arrived, build the section with clearly marked dummy figures and a fixed slide structure, so the real findings drop in later without redesigning the session. Mark every placeholder with `<!-- PLACEHOLDER -->` and a visible `[PLACEHOLDER]` label on the slide itself, so nothing fake is ever presented by accident.

---

## Working Rhythm — every session goes through this loop

A session is not done when it renders. Each one goes through these stages, and
the next session is not started until the current one has been through at least
stage 3.

1. **Draft** — Claude builds the `.qmd` against the outline and the session architecture.
2. **Render and self-check** — Claude renders revealjs + pptx, screenshots every slide, and checks for overflow, broken layouts, wrong numbers and stray code before handing over. Never hand over a deck that has not been looked at slide by slide.
3. **Fiona reviews and runs it** — read it through, test each section, and actually run the AI tasks as a participant would.
4. **Capture failures** — Fiona saves screenshots of any real AI mistakes into `AI_failure_exs/` and notes them in the AI Failure Library.
5. **Iterate** — Claude revises into a `_v2` (never in place), folding in the review notes and any newly captured AI failures.

**Standing tasks, repeated for every session:**

- [ ] After creating each session: review and iterate on it (stages 2–5 above) before moving to the next
- [ ] Fiona: run each session's AI tasks yourself and add real failure screenshots to `AI_failure_exs/`, then flag them for inclusion

---

## Checklist / Next Steps

- [x] Set up folder and draft Claude md
- [x] Help me improve the Claude md and fill in any missing details
- [x] Copy `clean.scss` into `Module_2_Oct_2026/`
- [x] Establish the design system (`module2.scss`, validated palette, callouts)
- [ ] **Oct13 S1 — DiD** — rebuilt with the design system, a case-study opening and a Word facilitator guide. Awaiting Fiona's review and the DOH data. *(Stale `Oct13_session1.pptx` from the first draft is still in the folder and no longer matches the deck — delete it when convenient.)*
- [ ] Oct13 S2 — RDD
- [ ] Oct13 S3 — Matching
- [ ] Oct12 S1 — Language / Compared to What?
- [ ] Oct12 S2 — Abu Dhabi Police descriptives
- [ ] Oct12 S3 — Naive comparisons and RCT
- [ ] Oct14 S1 — Cost analysis
- [ ] Oct14 S2 — Data visualisation
- [ ] Oct14 S3 — QA clinic
- [ ] Oct15 S1 — QA deep dive
- [ ] Oct15 S2 — Evidence translation
- [ ] Oct15 S3 — Plan your own evaluation
- [ ] Cross-session pass: check the running Day 2 comparison slide is consistent
- [ ] Upload outstanding case data (see Data Inventory)

---

## Folders

- **`C:\Users\FionaKastel\OneDrive - International Initiative for Impact Evaluation\Documents\GitHub\R-course\sessions_in_Abu_Dhabi`** — contains previous training material teaching various methods in R. The _updated quarto files in this folder are good reference material for some of the descriptions as well as output we will want to present.

---

## Dos and Don'ts

### Do
- **Create versioned outputs** - Use `_v1` or `_v2` suffixes instead of overwriting existing files/scripts, unless given express permission to do so
- **Focus on relevant files only** - When returning to this project, review only the files needed for the next checklist step. Start with this CLAUDE.md and the main scripts. Do not view or modify files outside the current working folder unless I explicitly ask or give permission.

### Don't
- **Don't delete files** without express permission
- **Don't overwrite outputs** - Always create new versions instead
- **Don't edit files/scripts in place** - Save a new versioned copy first (e.g., `script_v3.py`), then make changes there
- **Don't make API calls** without user awareness of the cost implications (API calls should not be needed in this project)
- **Don't view or modify files outside of the current working folder** without express permission

---

## Behavioral Guidelines for Coding
Behavioral guidelines to reduce common LLM coding mistakes.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Executing on a Task

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
