# Abu Dhabi Impact Evaluation Training — Module 2

## Project Overview

The goal of this project is to develop material for the second module of an impact evaluation training we are delivering in Abu Dhabi from Oct 12-15. Focus on the Module_2_Oct_2026 folder which contains the outline for each day and session and within which we will be developing materials. Reference the other folders mentioned in the section below (outside of Module_2_Oct_2026) only for some previous material that we can reuse - but brainstorm with me some ways to adapt to the outline for the particular module we are working on. We will develop quarto files for each session, which should be labelled [monthday_session#] - e.g., Oct12_session1. Some sessions will use evaluation_data_GreenWaste data in this folder, while others or parts of sessions (especially case studies) require me to upload data that we do not yet have in the folder. Compared to the previous training sessions we had, which were more focused on teaching students to use R, these modules and materials focus more on interpreting the results and include AI in every aspect. They still show the technical detail and the code behind the analysis, and the trainer produces output live to give a feel for what happens behind the scenes, but participants never have to write or run any code themselves. Alongside interpretation, weave in AI best practices for evaluation (as and when useful to mention).

In close consultation with me, develop sessions based on the outline. We will develop one at a time based on whichever I ask you to work on. Wait for my input on your ideas before developing or editing any files in this folder.

Output format: quarto (.qmd) files only. For each session Claude's deliverable is a correct, well-structured .qmd, **plus its rendered HTML** (see Rendering and Publishing below). Claude renders and publishes; Fiona reviews the live deck. Claude does not produce a separate facilitator guide. Speaker notes in `::: {.notes}` blocks are fine to include.

A few ideas I had on critical questions they should learn to ask AI throughout the sessions/for each method (not necessarily in this format or way but whatever way will help the AI not make mistakes or help us catch its mistakes):
    - Ask about data needed for DID
    - Ask about assumptions and limitations
    - Ask AI to help you review graphs/charts
    - How to interpret the results

In general, we should try to include some real examples of AI making mistakes when responding so they are tangibly shown the risks, and remind them to ask the AI to ask them questions before responding, and to remind them to review (or have a second chat/AI to review) the output for potential misunderstanding or mistakes.

---

## Audience and the Code Question

**Audience:** consumers and commissioners of evaluation — people who receive evaluation reports and must decide what to do about them. They are not analysts. They will not write R, and they will not read R.

**What the outline asks for.** The trainer "runs the analysis in R and projects the output." We embrace this: the sessions **show** the technical detail and the code that produces the tables and graphs, and the trainer produces that output live, so participants get a feel for what happens behind the scenes. What we do **not** do is make participants write, run, or debug anything themselves.

- **Show code on the slides that teach the mechanics** (computing the estimator, running the regression, visualising the result, testing an assumption): set `echo: true` on those chunks so the code is visible, and let the chunk produce its table or figure. Keep those code chunks short and readable, and use a two-column layout (code beside the output) so a code slide still fits within 1280x720.
- **Keep the rest of the deck clean.** Framing, hero numbers, questions, the AI snapshot and closing slides carry no code (leave the YAML default `echo: false` and opt in per chunk).
- **Running code live is optional for now.** Showing the code on the slide is enough. A real "press play" (via the `quarto-live` / webr extension, which runs R in the browser) is a possible future add-on, not required; running chunks from RStudio is not a clean presentation view.
- Participants are never asked to write, run, or debug anything.

**The test for any slide:** would a director-general who has never opened R get value from this slide? Seeing the code run and being walked through what it does counts as value; being expected to write or fix it does not.

**What this means when adapting the legacy decks.** The `sessions_in_Abu_Dhabi` material was built to teach R to analysts, and it is the source to pull the mechanics back from: the implementing-with-regression, interpreting-coefficients, visualising-DiD and testing-pre-trends slides all come from there. Reuse that code (adapted to the session's data and the module palette), but still cut the analyst-only material a commissioner would never need: estimator variants (TWFE, staggered adoption, Callaway & Sant'Anna), heavy robustness machinery, and "here is every package" slides. Keep expanding the slides that teach *reading*: what each number means, which number answers the decision question, what has to be true for it to be believed, and what to ask the evaluator.

---

## Session Map

Filenames follow `[Monthday]_session[#].qmd`. **Lucas's six sessions (1, 3, 5, 7, 9, 11) now live in `[Monthday]_session[#]_live.qmd`**: those are the sources that publish, and the plain `.qmd` of the same session is retired (kept for reference, not published; its old URL forwards to the live deck). "Legacy source" is the file in `sessions_in_Abu_Dhabi` to adapt from — several sessions have no legacy source and are built from scratch.

| Day | # | Filename | Topic (outline title) | Legacy source | Length |
|---|---|---|---|---|---|
| Oct 12 | 1 | **`Oct12_session1_live.qmd`** | Compared to What? — Know the Language First | — | 1.5h |
| Oct 12 | 2 | `Oct12_session2.qmd` | What Do the Numbers Say? — Abu Dhabi Police | `session_5_updated.qmd` (partly) | 1.5h |
| Oct 12 | 3 | **`Oct12_session3_live.qmd`** | Spot the Problem — Naive Comparisons and RCT Reading | `session_6_updated.qmd` | 2h |
| Oct 13 | 1 | `Oct13_session1.qmd` | Reading DiD Results (GreenWaste only; DOH case dropped) | **`session_9_updated.qmd`** | 1.5h |
| Oct 13 | 2 | **`Oct13_session2_live.qmd`** | Reading RDD Results (GreenWaste only; DCD case dropped) | **`session_8_updated.qmd`** | 1.5h |
| Oct 13 | 3 | `Oct13_session3.qmd` | Reading Matching Results — Two Case Studies | `session_10_updated.qmd`, `session_10_updated_CEM.qmd` | 2h |
| Oct 14 | 1 | **`Oct14_session1_live.qmd`** | Was It Worth It? — Cost Analysis | — | 1.5h |
| Oct 14 | 2 | `Oct14_session2.qmd` | What Can You Read? What Might Be Wrong? — Data Visualisation | — | 1.5h |
| Oct 14 | 3 | **`Oct14_session3_live.qmd`** | "Interrogate the Analyst" — QA Clinic | — | 2h |
| Oct 15 | 1 | `Oct15_session1.qmd` | Is This Evidence Credible? — QA Deep Dive | — | 1.5h |
| Oct 15 | 2 | **`Oct15_session2_live.qmd`** | From Findings to Policy — Evidence Translation | — | 1.5h |
| Oct 15 | 3 | `Oct15_session3.qmd` | Plan Your Own Evaluation — Building on Module 1 | — | 2h |

**Note the easy mistake:** `session_8` is RDD and `session_9` is DiD. Day 2 runs DiD *first*, so the session numbers are crossed relative to the legacy files.

---

## Build Conventions

- **Formats:** `revealjs` (primary, for delivery) and `pptx` (secondary, lossy — see the pptx section below). Both declared in the YAML header of every session file.
- **Theme: DGE, in every deck (since 2026-09-25).** All twelve published decks load `theme_dge.scss`: the ten decks that run live R (`live-revealjs`: Lucas's six `_live.qmd` files plus Fiona's Oct12 S2, Oct13 S1, Oct13 S3 and Oct14 S2) load `[theme_dge.scss, theme_live.scss]`; Fiona's two plain `revealjs` decks (Oct15 S1, Oct15 S3) load `[theme_dge.scss]`. Oct14 S2 became a live deck on 2026-09-25: three "Try it" slides (axis start, pooled vs averaged percentage, discount rate) run base-R cells from a hidden `autorun` setup cell on its first slide, reading the GreenWaste and SchoolZone CSVs. Every deck also sets `logo: assets/dge_logo_horizontal.svg` and puts `{background-gradient="linear-gradient(240deg, #7da1c4 0%, #7da1c4 22%, #215a9e 58%, #063360 100%)"}` on each `#` section heading. `theme_dge.scss` is the editorial theme re-dressed in the DGE brand (DGE Brand Identity Guideline 2025): same layout rules and callout components (`.panel`, `.ask`, `.warn`, `.excerpt`, `.ai-output`, `.dense`), so edit it for any theme or callout change. Confirm the YAML `theme:` line before editing anything. `theme_editorial.scss` is retired (only the retired plain `.qmd` copies of Lucas's sessions still load it); `clean.scss` and `module2.scss` are older still. Editing any of those changes nothing on screen.
- **Tables.** In a `live-revealjs` deck do not load `kableExtra` (see below). Fiona's four live decks define a `tbl()` helper in the setup chunk: plain `knitr::kable(format = "html")` wrapped in a raw HTML block, with `font_size`, `hl` (rows to shade), `hl_bg` (`HL_BLUE` or `HL_RED`), `hl_bold`, `widths` (CSS width per column, Oct14 S2 only) and `note` (a line under the table) standing in for `kable_styling()`, `row_spec()` and `footnote()`. Use it for any new styled table in a live deck. The plain `revealjs` decks may still use kableExtra.
- **Live decks (Lucas's sessions).** `format: live-revealjs` (quarto-live, in `_extensions/r-wasm/live`), theme `[theme_dge.scss, theme_live.scss]` (the DGE brand: Tech/Reliable/Light Blue, Noto Kufi Arabic, logo top-right via `logo:`, gradient dividers via `{background-gradient=...}` on each `#` heading). Live cells are `{webr}` chunks: a hidden `autorun` setup cell on the first content slide defines data and helpers; teaching cells do **not** autorun (the room predicts, then the trainer presses Run); only slider/button/switch cells autorun. `webr: render-df: kable` prints data frames as tables. The CSV a deck reads must sit next to the page in `docs/`. The setup cell warms up `estimatr`; even so, open a live deck a couple of minutes early, because R and its packages take about a minute to load. Avoid `kableExtra` in live decks (its JavaScript needs jQuery and throws "$ is not defined"). Keep base R in live cells: it loads faster than dplyr/ggplot2.
- **One example per session** (Lucas's rule, 2026-09-24). Every slide, exercise and "your turn" uses the session's single case; a second case (such as an Abu Dhabi placeholder) is dropped rather than added. The Abu Dhabi DOH and DCD placeholder sections were removed from Oct13 S1 and Oct13 S3 on 2026-09-25, matching Oct13 S2. Oct13 S3 keeps its two cases (GreenWaste and traffic cameras) because the outline's session is built on comparing two matching studies; the camera case stands in for the DCD study.
- **Writing rules.** Fiona's "AI pet peeves" list applies to all slide text and notes: no staged run-ups, "not X but Y", dramatic closers, inflated words, forced triads, stacked qualifiers, em dashes or chat residue.
- **Slide size:** `width: 1280`, `height: 720` in the revealjs block.
- **`embed-resources: true` — mandatory.** Without it, Quarto writes the deck as a small `.html` plus a `<name>_files/` folder holding every chart image *and* the entire reveal.js engine and compiled theme. Move or send the `.html` alone and it opens as an unstyled wall of text with no images. With it, everything is inlined into one portable file (~4.5 MB) that works on any machine with a browser and nothing else. Always deliver the embedded version.
- **Data path:** relative — `./evaluation_data_GreenWaste.csv`. Keep all session files and data in the same folder so paths stay simple.
- **Default `echo: false`; opt in to `echo: true` on the mechanics slides.** Keep the YAML default `echo: false` so framing and result slides never leak code, and set `echo: true` per chunk on the analysis slides meant to show the code (see the Code Question above). On a code-plus-output slide keep the code short and put it in a two-column layout beside the figure or table so the slide fits 1280x720.
- **Author field:** 3ie (the legacy decks are authored "Dr. Lucas Sempé" — do not carry that over without asking).
- **Slide budget:** roughly 22-28 slides for a 1.5h session, 30-36 for a 2h session. These sessions are discussion-heavy; slide count is low relative to a lecture. **Exception: Oct15 S3** (Plan Your Own Evaluation) is mostly group work continuing from Module 1, so it should have *fewer* slides than the budget, not more: framing, the template, working-time slides and the pitch structure.
- **Speaker notes are fine; no separate facilitator guide.** `::: {.notes}` blocks may be used for presenter notes (they appear in revealjs presenter view, press S on the day). What Claude does not produce is a separate facilitator-guide document; facilitation prompts also live on the slides themselves as `.ask` / `.warn` callouts, and section-level timing goes in the section divider's speaker notes (e.g. "Section timing: about 15 minutes."). Do NOT put `.mins` timing badges on slides: Fiona removed them from the visible decks.
- **Versioning:** edit session files in place; git history is the record of changes. The one exception is the `_live.qmd` rebuild of Lucas's sessions (2026-09-25), made as new files under the organisation's rule to save a new copy before a substantial rewrite. Those are now the sources; do not create further copies.
- **No em dashes.** Fiona's style preference for the training materials: do not use em dashes (—) in slides or in any prose meant for participants. Use a colon where the dash introduces an explanation, definition, or list; otherwise rephrase with a comma or split into two sentences. En dashes in numeric or time ranges (e.g. 0:00–0:03) are fine.

### Known formatting traps (found the hard way — do not repeat)

| Trap | Symptom | Fix |
|---|---|---|
| **pptx slide level** | 40 slides collapse to 19; body text becomes slide titles; images land on the wrong slide | `slide-level: 2` in the `pptx:` block. Mandatory. |
| **Nested fenced divs** | A two-column slide renders as one broken column; content escapes its column | Outer fences need MORE colons than inner: `:::::: {.columns}` > `::::: {.column}` > `::: {.panel}` |
| **`display: inline-block` on `h2`** | The next block floats up alongside the heading | `display: block; width: fit-content;` |
| **Unicode minus in ggplot labels** | Renders as literal `<U+2212>` | Use ASCII `-` inside any `annotate()` / `label =` string. Unicode is fine in markdown text. |
| **Ad-hoc `{.smaller}`** | "Text of different sizes" across the deck | Use the type scale and the callout components; do not hand-tune sizes per slide. For a genuinely list-heavy slide (e.g. terms bingo, a multi-card debrief) add `{.dense}` to the slide: it steps the callouts down one defined notch, defined once in `theme_dge.scss`. |
| **Noto Kufi is wider** | Slides that fitted in the editorial theme overflow after the DGE switch (Oct14 S2 had three) | Kufi's Latin is wide. After a theme change, check every slide at 1280x720 with all fragments shown; shrink a full-width chart to `height = 230` and cut text before adding `.dense`. |
| **Non-fragment callout after a fragment** | A later callout appears before the fragment above it, so the slide reads out of order | If one callout on a slide is a `.fragment`, make every callout below it a fragment too (or move it to the notes). |

### R packages

Run `setup_packages.R` once in RStudio (`source("setup_packages.R")`) before rendering anything. It installs what's missing and then **loads** each package, which is the part that matters: a package can be "installed" yet broken because one of its own dependencies is absent — that is the `gtable`/`ggplot2` failure, and a simple installed-or-not check does not catch it.

### Delivery check — verify the file actually landed

`device_commit_files` can report success while writing **stale content**. It appears to cache by staged path: committing from a staged path that was used earlier in the session re-sends the older content, even with `force: true`. Seen twice — a 4.5 MB deck silently staying at its previous 68 KB, and a CLAUDE.md update losing its two newest sections.

- **After every commit, list the folder and check the byte size matches the source.** Size is the cheap check; for text, stage the file back and `diff` it.
- **The fix is a fresh staged path.** Copy the file to a new name under the outputs folder and commit *that* to the destination. Re-committing the same staged path, force or not, does not reliably update.

### Rendering and Publishing

**One copy of each deck, in `docs/`.** GitHub Pages serves `docs/` on `main` (legacy source; it cannot be set to the repo root while `docs/` is used). The deck is **not** also kept beside the `.qmd` — that duplicate was removed on 2026-09-22. Render, then move the file into `docs/`:

```powershell
$env:PATH = "C:\Program Files\R\R-4.4.1\bin;C:\Users\LucasSempe\AppData\Local\Programs\Quarto\bin;" + $env:PATH
Push-Location Module_2_Oct_2026_v2
quarto render Oct12_session1.qmd
Move-Item Oct12_session1.html ..\docs\ -Force
Pop-Location
```

- **Render only the decks whose content changed.** Each is 3.4–7 MB, so a full re-render is ~50 MB of git churn for no benefit; an untouched deck renders byte-identical.
- **Do not use `--output-dir ../docs`.** It does write to `docs/`, but on this OneDrive path it reliably exits 1 with `unable to open database file ... deno-kv-file` (SQLITE_CANTOPEN), which makes a real render failure indistinguishable from a spurious one. Render in place and move.
- **The exit code is the only trustworthy signal.** `Select-String` and grep-style tools truncate these decks' 3.5 M-character minified lines and report 0 matches regardless; use `[IO.File]::ReadAllText($p).Contains($s)` instead.
- **Confirm the live page, do not assume the push worked.** Pages builds take ~30–60 s:

```powershell
$r = Invoke-WebRequest https://sempe.dev/R-course/Oct12_session1.html -UseBasicParsing
$r.StatusCode; $r.Content.Contains("a phrase only the new content has")
```

- **Add every new deck to `docs/index.html`.** The landing page is hand-maintained and does not discover files; a deck that is published but unlinked is invisible. Lucas's six sessions link to `docs/<deck>_live.html`; `docs/<deck>.html` for those six is a small page that forwards to the live deck, so old links keep working.
- **Checking a live deck.** Serve it (`quarto preview`, or any local web server); a live cell does not run from a double-clicked file. After a render, check every slide still fits 1280x720 with all fragments shown, and open each Run-button slide on a fresh page to prove it runs on its own (the setup cell defines everything a later slide needs).

### Presenting — no R needed on the day

The rendered `.html` **is** the presentation. R and Quarto are only needed to *build* it.

- **To present:** double-click the `.html`. It opens in any browser, on any machine, online or offline. Arrow keys move between slides.
- **Speaker notes:** press **S** for presenter view — notes, timer, and next-slide preview on your laptop while the projector shows the slides.
- **Overview of all slides:** press **Esc** or **O**.
- **To send it to someone:** send the single `.html` file. Nothing else. (This only works because of `embed-resources: true` above.)
- **For a PDF:** append `?print-pdf` to the URL in Chrome, then Print → Save as PDF.

### The pptx export is lossy — design around it

Quarto's pptx comes from pandoc, not from the revealjs theme. It ignores SCSS entirely, so **none** of our styling reaches it: no callout boxes, no hero numbers, no colour, no type scale. Worse, pandoc allows only **one content block per slide** — a figure followed by a paragraph is silently split across two slides, with the paragraph's first line promoted to a title.

Practical consequences:

- **revealjs (HTML) is the deliverable.** It is what gets presented.
- **For a portable/shareable copy, export the rendered revealjs to PDF** (open the deck with `?print-pdf` and print to PDF). This is pixel-faithful; pptx is not.
- **Only produce pptx when someone genuinely needs editable slides.** If so, expect a plain deck and keep those slides to one content block each.
- A branded `reference-doc:` template would improve pptx fonts/colours, but cannot fix the one-block-per-slide splitting.

---

## Design System

### Palette (single source: `theme_dge.scss`)

| Role | Hex | Use |
|---|---|---|
| Accent / series 1 (Tech Blue) | `#215a9e` | The programme / offered / treated group |
| Series 2 (Light Blue) | `#7da1c4` | Comparison / not-offered group |
| Alert | `#B8272C` | Decision rules, annotations, flagged AI errors. **Never a data series.** Not a brand colour. |
| Headings (Reliable Blue) | `#063360` | Headings, section gradients |
| Ink | `#111418` | Primary text |
| Muted (Grey) | `#545860` | Axis labels, secondary text |
| Rule | `#D5DEE8` | Borders |
| Row tints | `#E4EBF3` / `#F8E9EA` | Shaded table rows (`HL_BLUE` / `HL_RED`) |

Chart font: `CHART_FONT <- "Noto Kufi Arabic, Segoe UI, Arial, sans-serif"`. Each deck's
setup chunk mirrors the palette as `ACCENT`, `ACCENT2`, `ALERT`, `INK`, `MUTED` and `RULE`, and
the live decks repeat it in their webR setup cell. Keep all three in step, or a chart and the
slide around it will disagree.

Tech Blue and Light Blue are well apart in lightness, which is what separates the programme and
comparison groups for colour-blind viewers and in greyscale, so **do not substitute a grey for
the comparison group.** The one non-brand exception is the Oct15 S1 traffic light: Green
`#2E7D4F` and Amber `#A9561F` are fixed hexes, because a traffic light needs them.

### Chart conventions

- **Charts are plotly, sized by `pl_m2()`.** `pl_m2()` and `ax()` are shared across the decks
  and must stay identical. (Oct13 S1 and S3 also define a `theme_m2()` for their few ggplot
  figures.)
- **`dpi: 96`, never 200.** knitr sizes an htmlwidget container as `fig.width × dpi`, so at 200
  a `fig.width` of 11.5 rendered 2,300 px wide and pushed slide content off the bottom. At 96,
  inches map 1:1 onto CSS pixels.
- Full-width charts: `pl_m2(width = PL_W, height = 290)` with `fig.width = 11.5, fig.height = 3`.
  Half-width: `pl_m2(width = PL_WC, height = 250)` with `fig.width = 5.4, fig.height = 2.6`.
- `pl_m2()` gives every chart an explicit pixel width, a transparent background, no mode bar
  and a bottom legend with no title. Direct-label the values that matter; never label every point.

### Callout components (defined in `theme_dge.scss`)

| Class | Use |
|---|---|
| `.panel` | Neutral framing — context, the decision at stake |
| `.ask` | A question put to the room; a facilitation prompt |
| `.warn` | A caution, a limitation, a "hold that thought" |
| `.ai-output` | Verbatim AI response for participants to mark up; wrap planted errors in `[...]{.flag}` |
| `.hero` / `.stat-row` | The single number a slide exists to deliver; a three-across figure row |
| `.facts` | Case-study "at a glance" key/value grid |
| `.mins` | Not used. Timing lives in speaker notes, not on slides. |

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
6. **Three questions to ask the evaluator** — a standing closing slide, method-specific, that participants can take back to their desk.

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

The `evaluation_data_GreenWaste_IV.csv` variant is **gone**: no `*_IV.csv` exists anywhere in the repo. This matches the 2026-09-21 decision to drop instrumental variables from the sessions that never taught it.

### Still needed from Fiona

| Data | Needed for | Status |
|---|---|---|
| Abu Dhabi Police evaluation data (descriptive + RCT) | Oct12 S2, Oct12 S3 | Not in folder |
| Abu Dhabi DOH health evaluation findings | Oct13 S1 | Dropped 2026-09-25 (one example per session) |
| Abu Dhabi DCD Social Protection RDD findings | Oct13 S2 | Dropped (one example per session) |
| Abu Dhabi DCD matching case (imperfect matches) | Oct13 S3 | Dropped 2026-09-25; the traffic-camera case stands in |
| Fictitious evaluation report (with planted flaws) | Oct15 S1 | Written: `Oct15_session1_report.qmd`, rendered to `Oct15_session1_report.docx` |
| Evaluation Design Update template (from Module 1) | Oct15 S3 | Built into `Oct15_session3_materials.docx`; recaps Module 1's eight conditions from `qa_design_update.R` |

**Placeholder convention.** Where case data has not arrived, build the section with clearly marked dummy figures and a fixed slide structure, so the real findings drop in later without redesigning the session. Mark every placeholder with `<!-- PLACEHOLDER -->` and a visible `[PLACEHOLDER]` label on the slide itself, so nothing fake is ever presented by accident.

---

## Exercises and partner materials

A partner helps us build the exercises and their materials (printed handouts and cards, Menti quizzes, worksheets). To brief them, we keep one running Word document, **`Module2_exercise_plan.docx`** in this folder, that lists every exercise across all sessions: the exercise, roughly when in the session it appears, its type (vote, hands-on, group work, handout, Menti quiz), the materials needed, and a description of what the partner should build.

**Current version: `Module2_exercise_plan_v2.docx`** (25 Sep): every section now points to its session's print pack; the Abu Dhabi DOH and DCD rows are gone. Print materials for all twelve sessions come from `make_session_materials.R` (one `<deck>_materials.docx` pack per session); edit the script, not the Word files.

**Print packs.** Run `source("make_session_materials.R")` in RStudio after any change to a session's exercises. It writes the twelve `<deck>_materials.docx` packs (the trainer copy: print lines and a facilitator key) and the participant copies in `docs/handouts/<deck>_handouts.docx` (no key, no print lines), then copies the other handouts there. Every pack follows the same page order: exercise sheets, the AI Snapshot page, a take-away card, the facilitator key. Prompts, AI responses and closing questions are copied word for word from the deck, so change both together. Every AI page carries both habits (ask the AI to ask questions first; check its answer in a fresh chat). Numbers are computed from the CSVs, never typed. Oct12 S2 and Oct14 S2 print charts on their AI pages (ggplot2). Oct15 S1 and S3 read `qa_rating.R` and `qa_design_update.R`, which also feed their decks. `Oct15_session1_rating_sheet.qmd` and `Oct15_session3_design_template.qmd` are retired: their content lives in the packs. Link each participant copy under its deck in `docs/index.html`.

**Standing task for every session:** when a session is drafted or revised, add or update its exercises in `Module2_exercise_plan.docx`. Where an exercise is not fully built into the slides, leave a clear placeholder on the slide (a short Menti quiz, or the exercise instructions) and describe in the doc what the partner needs to create for it. The slides carry the in-room instructions; the doc is the build brief for the partner.

---

## Working Rhythm — every session goes through this loop

A session is not done when it renders. Each one goes through these stages, and
the next session is not started until the current one has been through at least
stage 3.

1. **Draft** — Claude builds the `.qmd` against the outline and the session architecture.
2. **Claude renders and publishes** — Claude renders the HTML, moves it into `docs/`, commits and pushes, and confirms the live page updated (see Rendering and Publishing below). Slides still have to be built light: a 1280×720 slide holds roughly one panel plus one short callout, or two side-by-side callouts. When a slide would be denser than that, split it across two slides rather than crowd one.
3. **Fiona reviews the live deck** — read it through slide by slide for overflow, layout, numbers and timing, test each section, and actually run the AI tasks as a participant would.
4. **Capture failures** — Fiona saves screenshots of any real AI mistakes into `AI_failure_exs/` and notes them in the AI Failure Library.
5. **Iterate** — Claude revises the session file in place (git tracks the history), re-renders and re-publishes, folding in the review notes and any newly captured AI failures.

**Standing tasks, repeated for every session:**

- [ ] After each session: render it, publish it, and give Fiona the live URL to review (stages 2–5 above) before moving to the next
- [ ] Fiona: run each session's AI tasks yourself and add real failure screenshots to `AI_failure_exs/`, then flag them for inclusion
- [ ] For each session: add or update its exercises in `Module2_exercise_plan.docx` (the partner's build brief), and leave a placeholder on any slide whose exercise is not built in

---

## Session Ownership

Every session has one named owner, and the other person is its second pair of eyes. The
owner is accountable for that session's content and delivery; the other reviews the live
deck (stage 3 of the Working Rhythm) and is the reviewer of record, so no session goes
unreviewed.

| Day | Session | Owner | Second pair of eyes |
|---|---|---|---|
| Oct 12 | S1 · Compared to What? | Lucas | Fiona |
| Oct 12 | S2 · What Do the Numbers Say? | Fiona | Lucas |
| Oct 12 | S3 · Spot the Problem | Lucas | Fiona |
| Oct 13 | S1 · Reading DiD Results | Fiona | Lucas |
| Oct 13 | S2 · Reading RDD Results | Lucas | Fiona |
| Oct 13 | S3 · Reading Matching Results | Fiona | Lucas |
| Oct 14 | S1 · Was It Worth It? | Lucas | Fiona |
| Oct 14 | S2 · What Can You Read? | Fiona | Lucas |
| Oct 14 | S3 · Interrogate the Analyst | Lucas | Fiona |
| Oct 15 | S1 · Is This Evidence Credible? | Fiona | Lucas |
| Oct 15 | S2 · From Findings to Policy | Lucas | Fiona |
| Oct 15 | S3 · Plan Your Own Evaluation | Fiona | Lucas |

**Lucas reviews Fiona's six.** Note that an owner is not the same as a builder: the decks
were built by Claude, and git history rather than this table records who wrote what.

---

## Checklist / Next Steps

**All twelve decks are built and published.** Nothing is outstanding on the slides
themselves; what remains is delivery readiness.

### Delivery readiness

- [ ] **Session length.** Oct12 S3 (live) is 29 slides and Oct14 S3 (live) 29, just under the
      30–36 budget for a 2h session; Oct13 S3 is 31 after the DCD section was removed.
      Oct15 S3 is 17 (trimmed 2026-09-25) and should stay low: it is group work.
- [ ] **A better report for the QA review (Oct15 S1).** The fictitious report
      (`Oct15_session1_report.qmd`) reuses GreenWaste, which the room has seen all week, so the
      planted flaws are easy to spot from memory. Consider a fresh example: a different
      programme and dataset, with its flaws planted in the same four QA areas.
- [ ] **Polls.** `MENTI_CODE` is still the placeholder in every deck. For the live decks the
      plan is a poll built into the slide (Firebase, QR code plus live bars); it needs a
      Firebase project and its web config.
- [ ] **Keep `Module2_exercise_plan.docx` current.** It is the partner's build brief for
      every exercise, card and handout.
- [ ] Fiona: run each session's AI tasks, capture real failures into `AI_failure_exs/`,
      and flag them for inclusion in the AI Failure Library.
- [ ] **Re-render and publish after 2026-09-25 edits.** Oct12 S2, Oct13 S1, Oct13 S3, Oct14 S2,
      Oct15 S1 and Oct15 S3 all changed (DGE theme, kableExtra removal, Abu Dhabi sections
      removed, Oct14 S2 layout fixes and live cells, pet-peeve pass, Oct15 S3 trim). Oct14 S2
      is now a live deck: serve it (not a double-clicked file) to test the three Try it
      slides, and check `docs/` has `evaluation_data_SchoolZoneRCT.csv` beside it.
- [ ] **Two hard-coded deck figures disagree with the data.** Oct14 S2's "Rule 5" slide and
      its "Try it" notes say 4,082 and 3,366 (gap 716); the data gives 4,080 and 3,365
      (gap 715). Oct13 S1 "Where this sits" and Oct13 S3 "The week so far" still describe
      Day 1 S2 as "-1.13 against a 2.0 rule"; the Oct12 S2 deck now reports -2.53, which
      clears the rule (and Oct13 S1's "none of them has cleared its bar" follows from it).
- [ ] **Report text: eligibility direction.** `Oct15_session1_report.qmd` section 2 says
      businesses "at or above 58" were eligible; in GreenWaste the eligible ones score 58 or
      below. Not one of the planted flaws: fix it, or add it to the key as a planted one.

### Done

- [x] Set up the folder and this file
- [x] Establish the design system and the single editorial theme
- [x] Build all twelve decks
- [x] Publish them, with one copy of each in `docs/`
- [x] Resolve the theme fork, the author field, and the false Abu Dhabi Police attribution
- [x] Rebuild Lucas's six sessions as live (webR) decks in the DGE theme, publish them and
      link them from the landing page (2026-09-25)
- [x] Settle the stale working copies of Oct12 S1–S3 and theme_editorial.scss (they were
      identical to commit b30ce08; kept in a git stash) and the `.dense` question with them
- [x] Move Fiona's six decks to the DGE theme, logo and gradient dividers; replace kableExtra
      with `tbl()` in her three live decks (2026-09-25)
- [x] Day 2 numbers: Oct13 S3's "week so far" slide now quotes the live RDD figure (-791),
      not the retired -249 (2026-09-25)
- [x] Remove the Abu Dhabi DOH / DCD placeholder sections from Oct13 S1 and S3 (2026-09-25)
- [x] Oct14 S2: fixed the three overflowing slides and the out-of-order fragment, binned the
      baseline table, fixed the NaN% "average of percentages" (now the 384 computable
      segments) (2026-09-25)
- [x] Pet-peeve pass on Oct14 S2, Oct15 S1 and Oct15 S3; "compliers" (IV language) removed
      from `qa_rating.R` (2026-09-25)
- [x] Oct14 S2 round two (2026-09-25): bar labels no longer clipped (`cliponaxis = FALSE`),
      distributions slide fits, a "Six pairs, two questions" slide sets the outline's two
      group questions, the percentage/absolute pair is two charts instead of two tables, the
      pie has a fair partner ("The same collisions, as counts"), and three live cells
- [x] Oct15 S3 trimmed from 19 to 17: "What today is not" folded into the opener, "Peer
      feedback on the day" folded into "Feedback from the room" (2026-09-25)
- [x] Print packs for Fiona's six sessions, built in `make_session_materials.R` in the same
      format as Lucas's, with participant copies linked on the landing page; Oct15 S1's
      rating sheet and Oct15 S3's template moved into their packs; the report re-rendered
      (the old .docx still carried the IV version); em dashes removed from `qa_rating.R`,
      `qa_design_update.R` and the exercise plan (2026-09-25)

---

## Folders

- **`C:\Users\FionaKastel\OneDrive - International Initiative for Impact Evaluation\Documents\GitHub\R-course\sessions_in_Abu_Dhabi`** — contains previous training material teaching various methods in R. The _updated quarto files in this folder are good reference material for some of the descriptions as well as output we will want to present.

---

## Dos and Don'ts

### Do
- **Edit in place** - Change existing session files directly; git history is the record of changes. Do not create `_v1`/`_v2` copies.
- **Render and publish after every content change** - The `.qmd` and the live site are otherwise out of step, which is exactly how `docs/` came to serve Sep 19–21 HTML behind Sep 22 sources. Render, move into `docs/`, commit, push, verify.
- **Keep one copy of each deck** - Only `docs/<deck>.html` is tracked. Do not re-create a copy beside the `.qmd`.
- **Focus on relevant files only** - When returning to this project, review only the files needed for the next checklist step. Start with this CLAUDE.md and the main scripts. Do not view or modify files outside the current working folder unless I explicitly ask or give permission.

### Don't
- **Don't delete files** without express permission
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
