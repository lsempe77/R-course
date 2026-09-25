# Module 2 · Session Build Guide

Reference for building the remaining Module 2 decks (Day 1 Session 3 onward) so
they match the Session 1 deck we built. Everything here was verified against a
rendering deck, not assumed. Where a fact was checked, the check is named.

**The reference deck:** `Module_2_Oct_2026_v2/Oct12_session1.qmd`
**Second reference:** `Module_2_Oct_2026_v2/Oct12_session2.qmd` (the Police case)
**Companion file:** `CLAUDE.md` in the same folder holds the project overview,
palette and session map. This guide adds the accumulated, hard-won detail.

---

## 0 · Read `Module2_outline.xlsx` first

**This is the source of truth for what each session must cover.** It is laid out
as a grid: rows are time slots, columns are days.

```
         Day 1 (Oct 12)          Day 2 (Oct 13)      Day 3          Day 4
9:00     Session 1               Reading DiD         Cost analysis  QA deep dive
11:00    Session 2  <- Police    Reading RDD         Data viz       Evidence trans.
13:30    Session 3               Reading Matching    QA clinic      Plan your eval
```

Reading it shows things `CLAUDE.md` does not, for example that the **Police case
opens Day 1 at 11:00** as the first real Abu Dhabi case, that Session 2 is
*descriptive* reading (not a new method), and that participants **annotate a
printed output** - identify the treatment effect, circle the interval, flag what
is unclear.

```powershell
# rows are the slots, columns the days; each cell holds that session's brief
Rscript -e "library(readxl); d <- read_excel('Module2_outline.xlsx', col_names=FALSE); print(as.data.frame(d))"
```

Also in the folder: `Module2_exercise_plan.docx` and
`Module2_task_checklist.docx`. Check them for a session before drafting, in case
they already specify the exercise.

## 0b · There is no Abu Dhabi case data in this workspace

**Searched the whole workspace. No Police, DOH or DCD dataset exists.** What is
present is two copies of the GreenWaste data, and they are not interchangeable:

| File | Rows | Units named | `waste_management_costs` |
|---|---|---|---|
| `evaluation_data.csv` (ships in the Module 1 decks: `session_4/`, `sessions_in_Abu_Dhabi/`) | 19,827 | zone / facility | `15.19` |
| `evaluation_data_GreenWaste.csv` (in this folder) | 19,826 | neighborhood / business | `1518.55` |

Same records, but the cost column differs by **exactly 100×**. Never mix them.

### NEVER attribute invented numbers to a real organisation

**This mistake was made, and it is the worst one in this folder's history.**
Sessions 2 and 3 were first built with a "Abu Dhabi Police" case: the deck title
said "The Abu Dhabi Police Data", the slide said "Abu Dhabi Police: cameras on
the fastest roads", and entirely fabricated findings were presented as results.
The deck was published to `sempe.dev`. That attributes invented numbers to a
named real organisation, in public.

The fix, applied to both decks:

- The case now names **no real body**. It is "a roads authority", and the data
  files are `evaluation_data_TrafficCameras.csv` and
  `evaluation_data_SchoolZoneRCT.csv`.
- Titles and headings assert nothing about provenance: "Reading an Evaluation
  Output", "Illustrative Case Data", "5 · The randomised case".
- A visible disclaimer sits on **every slide carrying a number**:
  *"Illustrative case, with invented figures. This is not a real programme and
  the numbers are generated for this training."*

`CLAUDE.md` line 241 already required this and was not followed:

> **Placeholder convention.** … Mark every placeholder with `<!-- PLACEHOLDER -->`
> and a visible `[PLACEHOLDER]` label on the slide itself, **so nothing fake is
> ever presented by accident.**

**Checklist item before publishing any deck with generated data:**

1. Does any title, subtitle or heading assert the data is real, or name a
   real organisation? Grep for the organisation's name.
2. Does every slide showing a number carry a visible disclaimer?
3. Is the honesty marker *on the slide*, not only in the speaker notes or an R
   comment? Participants never see those.

Verify with a grep over the rendered `.html`, not the `.qmd` — only the HTML
shows what the room will actually see.

For Session 2 the outline needs a Police case, so one was invented:
`make_police_data.R` generates `evaluation_data_Police.csv` (1,200 road segments
× 2 rounds). Read the header comment of that script before changing it - it
records why each column exists.

**Design the columns for every session that will use the data, not just the next
one.** This dataset is shaped so one file serves four sessions:

| Session | What it uses |
|---|---|
| Session 2 | base table, counts, rates, exposure |
| Oct13 S1 DiD | sector rollout in two phases × before/after rounds |
| Oct13 S2 RDD | `baseline_speed_85th` with a cut-off at 70 km/h, **sharp** within phase 1 |
| Oct13 S3 matching | covariates that predict both selection and the outcome |

`check_police_data.R` tests all four uses plus plausibility, and prints the
result. Run it after any change to the generator. A `FAIL` there is real - but
check the test itself before "fixing" the data (see section 7).

Every deck using invented numbers must say so on the slide. Both built decks do.

---

## 1 · The theme fork (RESOLVED — every deck uses editorial)

**Settled 2026-09-21. All twelve decks load `[theme_editorial.scss]`.**

`clean.scss` and `module2.scss` are dead files: nothing loads them and editing
them changes nothing on screen. Any theme or callout change goes in
`theme_editorial.scss`. This section is kept as the record of why, so that a
future session does not re-open it.

When this guide was first written, the five decks then in the folder did **not**
share a theme:

| Deck | Theme declared then | Theme now |
|---|---|---|
| `Oct12_session1` | `[theme_editorial.scss]` | editorial |
| `Oct12_session3` | `[clean.scss, module2.scss]` | editorial |
| `Oct13_session1` | `[clean.scss, module2.scss]` | editorial |
| `Oct13_session2` | `[clean.scss, module2.scss]` | editorial |
| `Oct13_session3` | `[clean.scss, module2.scss]` | editorial |

The two schemes are genuinely different, not two names for one thing:

| | `theme_editorial.scss` | `clean.scss` + `module2.scss` |
|---|---|---|
| Heading font | Georgia serif | Roboto, `font-weight: lighter` |
| Root size | `$presentation-font-size-root: 24px` | `28px` |
| Palette | `#0E6E80` / `#A9561F` | `#107895` / `#9a2515` |
| Look | rule-and-indent, nothing filled | rounded cards, shadows, filled table headers |
| Chart container | plain, no box | card with border, radius, shadow |

**One consequence that still matters.** The scrollbar fix (section 6) exists only
in `theme_editorial.scss`. `module2.scss` has no `.cell-output-display` overflow
rule, so any deck put back on that theme shows a stray scrollbar beside every
pixel-sized chart. The rule is load-bearing and must not be removed in a tidy-up.

---

## 2 · YAML header, exactly as Session 1 has it

Copy this block verbatim and change only `title` / `subtitle`.

```yaml
---
title: "…"
subtitle: "Module 2 · Day 1, Session 2: …"
author: "Dr. Lucas Sempé"
always_allow_html: yes
# revealjs only in this folder: the charts are interactive (plotly/htmlwidgets),
# and pandoc cannot carry an htmlwidget into pptx. Export to PDF for a portable copy.
format:
  revealjs:
    theme: [theme_editorial.scss]
    slide-number: true
    width: 1280
    height: 720
    fig-align: center
    slide-level: 2
    embed-resources: true
knitr:
  opts_chunk:
    echo: false
    warning: false
    message: false
    dev: "png"
    # dpi 96 is deliberate. knitr sizes every htmlwidget container as
    # fig.width * dpi, so an inherited dpi: 200 silently inflated each chart
    # tenfold (11.5in became 2300px) and pushed slide content off the bottom.
    # At 96, fig.width in inches maps 1:1 onto CSS pixels. If a raster
    # ggplot chunk is ever added, set its dpi per chunk.
    dpi: 96
editor_options:
  chunk_output_type: console
---
```

Non-obvious keys, each of which cost time to get right:

- **`slide-level: 2`** — `#` is a section divider, `##` is a slide. Mandatory.
- **`dpi: 96`** — not cosmetic. See section 5.
- **`embed-resources: true`** — makes the `.html` a single portable file. Every
  deliverable depends on it, including the PDF export.
- **No `pptx:` block** in Session 1. `CLAUDE.md` says both formats were planned,
  but pptx cannot carry a plotly widget and ignores SCSS entirely, so the chart
  decks dropped it. Of the five decks, only `Oct12_session3` still declares one.
  Add it only if someone genuinely needs editable slides.

### The `author:` field is inconsistent — decide before Session 2

| Deck | `author:` |
|---|---|
| `Oct12_session1` | `Dr. Lucas Sempé` |
| `Oct12_session3`, `Oct13_session1/2/3` | `3ie` |

`CLAUDE.md` is explicit that the author should be **3ie**, and warns not to carry
"Dr. Lucas Sempé" over from the legacy decks without asking. Session 1 does carry
it, and that deck is now **published publicly** at `sempe.dev/R-course`. Settle
which is right before Session 2, so the twelve decks do not end up split.

---

## 3 · The setup chunk

Session 1's setup chunk is the template. It carries four things, in this order:

1. **Libraries** — `tidyverse`, `plotly`, `knitr`, `kableExtra`, `qrcode`.
2. **Palette + chart sizing helpers** — `ACCENT`, `ACCENT2`, `ALERT`, `INK`,
   `MUTED`, `RULE`, plus the `pl_m2()` and `ax()` functions.
3. **Live Menti block** — see section 8.
4. **All scenario numbers**, grouped by the slide that uses them, each block
   commented with what it is for.

Reuse `pl_m2()` and `ax()` unchanged. They are the reason every chart in the deck
is the same size and uses the same axis styling, and `pl_m2()` carries three
fixes that are painful to rediscover:

```r
pl_m2 <- function(p, width = PL_W, height = 290, t = 30, b = 54,
                  title = NULL, legend_y = 1.02) {
  p <- p %>%
    layout(
      width  = width,          # explicit px, never autosize
      height = height,
      font = list(family = CHART_FONT, size = 13, color = INK),
      paper_bgcolor = "rgba(0,0,0,0)",   # transparent, so the slide shows
      plot_bgcolor  = "rgba(0,0,0,0)",
      margin = list(l = 70, r = 24, t = t, b = b),
      legend = list(orientation = "h", x = 0.5, xanchor = "center",
                    y = legend_y, yanchor = "bottom", title = list(text = "")),
      hoverlabel = list(bgcolor = "white", bordercolor = RULE,
                        font = list(color = INK, size = 12))
    )
  if (!is.null(title)) { … }
  p %>% config(displayModeBar = FALSE)   # no plotly toolbar over the slide
}
```

**Why explicit pixel sizes matter.** Plotly's autosize inside revealjs measures
its container while the slide is hidden, gets a narrow width, and never
corrects. Every chart must be given `width` and `height` in pixels, and the
chunk's `fig.width`/`fig.height` must stay in step, because knitr sizes the
htmlwidgets wrapper as `fig.width × dpi`. That is why `dpi: 96` is load-bearing:
at 96, inches map 1:1 onto pixels.

The sizing constants:

```r
PL_W  <- 1100   # full-width chart
PL_WC <- 520    # chart in a half-width column
PL_WT <- 340    # chart in a third-width column
```

---

## 4 · The teaching pattern of Session 1

This is the part to copy for Session 2. Six movements, in this order.

| # | Section | What it does | Time badge |
|---|---|---|---|
| 0 | Opening | A decision the room must commit to before any teaching | — |
| 1 | What are we comparing? | The headline number, then the two worlds it could mean | `[17 min]` |
| 2 | Three questions for any number | The transferable frame: compared to what / how big / how sure | `[4 min]` |
| 3 | The five words | Mean · treatment effect · coefficient · p-value · confidence interval | `[39 min]` |
| 4 | Put AI to work | Planted AI error, cards, debrief | `[10 min]` |
| 5 | Terms bingo | Eight quoted excerpts the room classifies | `[9 min]` |
| 6 | Take this back to your desk | The three questions, from memory | `[5 min]` |

### The mechanics behind it

**Commit before you teach.** The deck opens with a Menti poll on a single
convincing number. The room votes, and only then does the deck reveal that the
number is ambiguous. This is the engine of the whole session: people defend a
position they have already taken.

**One headline, two worlds.** Section 1 shows the same "fatalities fell 30%"
figure against two sets of driving data, producing opposite verdicts. The
ambiguity is resolved by arithmetic the room can check, not by assertion.
A coda slide runs the trap the other way (a programme that looks like a failure
but held up 4 points).

**Reveal, don't assert.** Where something is explained, the explanation is
hidden behind `.fragment` and appears on a keypress, after the room has guessed.
Five fragments in Session 1, on the warning that follows the poll, the Word 2
table, the World A/B warnings, and the closing panel.

**Make the arithmetic visible.** The clearest lesson from Session 1: the first
version of the Word 2 reveal was three paragraphs of prose and was judged "too
complicated". The reason was structural — the ask promised three numbers (17, 6,
2) but the prose needed five (it introduced 15 and 4 mid-flow), and it gave two
routes to the answer. Replacing it with a table ended the problem:

| | Before | After | Change |
|---|---|---|---|
| Programme schools | 54 | 71 | 17 |
| Comparison schools | 50 | 65 | 15 |
| **Difference** | 4 | 6 | 2 |

Every number sits in the grid, and the bottom row is visibly the two above it
subtracted, so the effect reads off both the Change column (17 − 15) and the
After column (71 − 65). Nothing has to be held in the head.

**Rule of thumb:** if a reveal needs a number that appears nowhere else on the
slide, put it on the slide.

**One idea per slide.** Section 3 gives each of the five words its own slide
group (Word 1, Word 2, Word 2 continued, Word 3, Word 3 continued, Word 4 ×3,
Word 5). Session 1 runs to 29 slides for 90 minutes.

**Interaction is built into the charts.** The charts are plotly, not ggplot:
hover for values, click a legend entry to isolate a series, drag a slider to
animate. The `.ask` callouts tell the room what to click. This is why the deck
is HTML and not pptx.

---

## 5 · Custom components, and the one trap

Each of these is a fenced div. Use them instead of bold paragraphs — they are
what makes twelve sessions read as one course.

| Class | Use | Count in Session 1 |
|---|---|---|
| `.panel` | Neutral framing: context, the decision at stake | 17 |
| `.ask` | A question put to the room | 16 |
| `.warn` | A caution, a limitation, a "hold that thought" | 11 |
| `.excerpt` | Quoted material the room classifies (bingo) | 8 |
| `.facts` | Key/value at-a-glance grid | 5 |
| `.hero` | The single number a slide exists to deliver | 3 |
| `.stat-row` | A row of figures below a hero | 3 |
| `.ai-output` | Verbatim AI response, with `[...]{.flag}` on planted errors | 1 |
| `.mins` | Not used on slides (see below); timing goes in speaker notes | none |
| `.fragment` | Hidden until a keypress | 5 |

Counts are literal occurrences in the Session 1 source.

**`.ask` carries two meanings and they behave differently.** Across the twelve
decks, 168 of 186 `.ask` blocks put a question to the room and 18 instruct the
facilitator ("Commit before we look further", "Take two or three answers out
loud"). Both read fine on the slide, but only the first should ever be
fragmented — hiding an instruction from the person who has to give it is a bug.

When auditing reveals, sort the `.ask` blocks first. A block that opens with an
imperative to the trainer, or that mentions "the room", "two people" or "out
loud", is an instruction and is correctly always visible.

### The trap: `.fragment` must go on the same div

To reveal a component on a keypress, add the class to the existing one:

```markdown
::: {.warn .fragment}
…
:::
```

Not `::: {.warn}` followed by a nested fragment. Both classes belong on one div,
because the stylesheet targets `.warn`, not `.warn.something`, so the
combination picks up the styling with no CSS change.

### There are two reveal mechanisms. Pick one deliberately.

A course-wide audit found the decks using two different ways to hold an answer
back, and no rule about which to use where. That produced three sessions with
questions whose answers were visible beside them.

**Mechanism A — keypress (`.fragment`).** The answer is on the slide but hidden
until a key is pressed. Right when the answer is short and the question and
answer belong in one frame.

**Mechanism B — page turn.** The question sits at the foot of one slide and the
answer opens the next. Right when the answer needs a fresh, uncluttered slide —
a chart, a table, a worked calculation. There is an idiom for it, used
throughout:

> **Before you turn the page:** what share of the enrolled businesses paid more
> than the average non-enrolled business? Write a number down. Then turn.

Both are legitimate. What is not legitimate is **neither**: a question posed and
answered on the same slide with no fragment and no turn. The room cannot answer
first, so the question is decoration.

**The check.** For every slide that asks something, confirm the answer is
behind one mechanism or the other:

```powershell
# For each slide in the deck, does it ask a question AND show its answer
# in the same view with no .fragment and no turn-the-page idiom?
```

Read the flagged slides by hand. Two false-positive patterns are common and
both are fine:

- A `.panel` that sets context rather than giving a verdict ("Where we are",
  "The decision on the table"). Leave it visible.
- A two-part reveal where the left half poses and the right half answers in the
  same column. Fragment the answering half only.

**Counts follow from the choice, so do not target a count.** After the audit the
course runs at 1–27 fragments per deck, and the spread is deliberate: a clinic
built entirely of questions genuinely needs one per beat, while a chart-led
session needs few. Session 1, the reference deck, has five.

### No timing badges on dividers

**Do not put `[18 min]{.mins}` on a section divider.** Session 1 has none, so its
sections read `# 1 · What are we comparing?` and nothing else. Sessions 2 and 3
briefly carried badges and looked different from the deck they follow on the day;
both were stripped. Timing belongs in the facilitator's plan and the speaker
notes, not on the slide the room is reading.

The `.mins` style is still defined in `theme_editorial.scss` if a badge is ever
wanted, but nothing currently uses it.

**This has now been reintroduced three times** while drafting a new deck, because
it is natural to reach for a timing marker on a divider when writing to a
90-minute outline. Treat it as a build step, not a preference:

```powershell
# must print nothing. Run it after every render.
Select-String -Path Module_2_Oct_2026_v2\*.qmd -Pattern '\{\.mins\}'
```

### Watch `color` inheritance inside a divider

Reveal writes a section's colour onto the divider's `h1` as an inline `color:`,
and children inherit it. Anything added inside a divider must set `color`
explicitly or it will inherit whatever the section colour happens to be. That is
why the `.mins` block sets its own colour. Relevant when adding any new element
to a section divider.

### Two components are built in raw HTML

`.hero` and `.stat-row` are emitted from an R chunk with `results='asis'`, so the
numbers come from the setup chunk rather than being typed twice:

````markdown
```{r results='asis'}
cat(sprintf('
<div class="hero">
  <div class="value">-%.0f%%</div>
  <div class="label">Traffic fatalities, year on year</div>
</div>
<div class="stat-row">
  <div><span class="n">%d</span><span class="k">Deaths, year before</span></div>
</div>', af_headline_fall, af_fatal_before))
```
````

The same applies to `.facts`, which is written inline as `{.=html}`.

### `.hero` and descenders: measure the ink, not the line box

`.hero .value` sets `line-height: 1`, which is tighter than the font's own line
box, so glyphs overflow the element. Because `overflow` is `visible` this never
clips, but a **descender** can reach down into the `.label` below it.

Descenders include `g j p q y` and, easily missed, the **comma**. So `1,000`
descends further than `1.87` does, and prose in a hero descends further still.

Before adding a hero, check the string. The reliable test measures actual glyph
ink, not the element box:

```js
const cs = getComputedStyle(el), ctx = document.createElement('canvas').getContext('2d');
ctx.font = cs.fontWeight + ' ' + cs.fontSize + ' ' + cs.fontFamily;
const m = ctx.measureText(text);
const lh = parseFloat(cs.lineHeight);
const inkBottom = (lh - (m.fontBoundingBoxAscent + m.fontBoundingBoxDescent)) / 2
                  + m.fontBoundingBoxAscent + m.actualBoundingBoxDescent;
// collides only if (inkBottom - lh) > the label's margin-top (5px by default)
```

**Do not use a `Range` bounding box for this.** A Range measures the *line box*,
which overhangs the glyphs, so it reports collisions of 2–13px on every hero in
the deck including ones that look perfectly fine. That false positive cost an
hour. The canvas measurement above is the one that agrees with what you see.

Measured values, for reference: `1.87` ink descent 1px, `1,000` 10px (margin is
5px, so it clears), `Sign off?` roughly 16px and it does **not** clear. State the
number in the hero and put the question in the heading, which is what Day 3
Session 3 does.

### Layout constraints

- **1280 × 720.** Any content more than 720 logical px tall spills. Check after
  every change (section 7).
- **Nested fenced divs need more colons outside than inside:**
  `:::::: {.columns}` → `::::: {.column}` → `::: {.panel}`.
- **Column widths** used in Session 1: 62/38 for text-beside-QR, 50/50 for two
  charts, 44/56 for facts-beside-table.
- **Half-width charts** use `pl_m2(width = PL_WC, height = 250)` with
  `fig.height=2.6, fig.width=5.4`. Full-width charts use `pl_m2(height = 290)`
  with `fig.height=3, fig.width=11.5`.
- **Animations** (slider charts) need extra bottom margin: `pl_m2(height = 320,
  t = 34, b = 92)`.

---

## 6 · The scrollbar fix — already applied, keep it

**Symptom:** a thin scrollbar beside every chart.

**Cause:** Quarto gives `.cell-output-display` `overflow: auto` by default. The
charts here are sized in explicit pixels, so the widget and its wrapper can
disagree by a fraction of a pixel. Any excess makes an `auto` container
scrollable.

**Fix**, in `theme_editorial.scss`:

```scss
// Quarto's default gives .cell-output-display `overflow: auto`. Every chart
// here is sized in explicit pixels (pl_m2 sets width), so a rounding
// difference of a pixel or two between the widget and its wrapper is enough
// to make the wrapper scrollable, and a stray scrollbar then appears beside
// every chart. Nothing on a slide is ever meant to scroll, so it is off.
.reveal .cell-output-display { overflow: visible; }
```

**How to test it properly** — this matters, because the obvious test gives a
false negative:

```js
el.offsetWidth - el.clientWidth   // > 0 means a scrollbar is really rendered
```

Comparing `scrollWidth > clientWidth` is **not** reliable here and will report
zero when a scrollbar is visible. That mistake cost real time. The gutter-width
test above is the one that works; before the fix it returned 15 px on each of
the two charts on the "What else happened that year" slide.

---

## 7 · Verification loop

Run this after every editing session. It caught a wrong-chart-size bug, the
scrollbar, and a stale render.

**1. Render and check the exit code.**

```powershell
$env:PATH = "C:\Program Files\R\R-4.4.1\bin;" + $env:PATH
quarto render "Module_2_Oct_2026_v2\Oct12_session2.qmd" 2>&1 | Select-String -Pattern "^ERROR|Quitting|Execution halted"
```

**2. Check the render is fresh.** This one bit hard: a stale `.html` was scanned
for scrollbars, the scan came back clean, and the conclusion was wrong. Compare
timestamps, or grep the HTML for a string you just added:

```powershell
Get-Item "Module_2_Oct_2026_v2\Oct12_session2.qmd","Module_2_Oct_2026_v2\Oct12_session2.html" |
  Select-Object Name,LastWriteTime
```

**3. Check for overflow and scrollbars** in the browser (see section 6 for the
right test). Content bottom must be ≤ 720 logical px.

**4. Confirm the numbers.** Session 1's Word 2 bug — a heading over the wrong
scenario — was found by comparing each heading against the numbers beneath it,
not by reading the prose. Do that check explicitly on any slide where a label
and a figure sit together.

**Known false alarm:** level-1 `h1` dividers always report a 1 px overflow on
`offsetHeight - clientHeight`. That is the line-height, not a scrollbar. Ignore
`h1`/`h2` in gutter scans.

**Check the check before changing the data.** In Session 2 the RDD verification
reported `FAIL`. The data was fine; the test was wrong twice over. It pooled all
sectors when the cut-off only applies within phase 1, and it tested
`ave_speed_kmh` — the *mechanism*, which moves by construction — instead of
`injury_collisions`, the outcome. A failing check is a hypothesis about the
data, not a verdict on it.

### The sign trap: `abs(conf.low)` is the OPTIMISTIC end

When a coefficient is negative (fewer collisions is the good outcome), an
interval of `[-3.43, -1.75]` reads as: `conf.low` (-3.43) is the **larger**
effect, `conf.high` (-1.75) the smaller one. So `abs(conf.low)` is the *most*
the programme could be achieving, not the least. Taking `abs(conf.low)` and
labelling it "least it could be" prints the most flattering figure under a
pessimistic label — which is exactly what Session 3 did on its Police slide,
and it was caught by comparing the printed number against the rule.

Safe pattern:

```r
avoided <- sort(abs(ci))     # [1] is always the end closest to zero
least   <- avoided[1]        # pessimistic end
most    <- avoided[2]        # optimistic end
```

Session 2's interval is `[-1.76, -0.51]`, which lies entirely short of the 2.0
rule; Session 3's is `[-3.43, -1.75]`, which straddles it. Those are genuinely
different findings, so the two decks say different things on purpose.

### Simulating a design, to check it is identifiable

Before building an RDD or DiD slide, confirm the structure can support it:

- **DiD** — is there a clean treated × before/after grid with controls?
- **RDD** — is the assignment rule *sharp* (deterministic at the cut-off)? Is
  there mass on both sides? Does the jump beat the same comparison where no
  treatment exists (a placebo at the same nominal cut-off)?
- **Matching** — do covariates predict selection, so matching has work to do?

Package versions in use, verified: R 4.4.1, tidyverse 2.0.0, plotly 4.12.1,
knitr 1.50, kableExtra 1.4.0, qrcode 0.3.0, estimatr (for `lm_robust`).

---

## 8 · The Menti block, and one thing to fix

Session 1 has three pieces driven from one place:

```r
MENTI_CODE  <- "1234 5678"                                  # the join code
MENTI_JOIN  <- paste0("https://www.menti.com/", gsub(" ", "", MENTI_CODE))
MENTI_EMBED <- "https://www.mentimeter.com/app/presentation/<id>/embed"
```

- **Opening slide:** printed code plus a QR, generated at render time by
  `menti_qr()` (900 × 900, 300 dpi, `ecl = "H"` for error correction).
- **Reveal slide:** a live results iframe.

Three things learned the hard way:

1. **`data-external="1"` is required on the iframe.** Without it,
   `embed-resources: true` rewrites the `src` to a base64 `data:` URI with
   `role="img"`, turning the live embed into a frozen screenshot. This is
   Quarto's own idiom — its video shortcode emits the same attribute.
2. **The `/embed` URL is the results view, not a voting view.** Mentimeter does
   not expose voting to embeds, so the room still votes on their own phones.
   The QR and printed code do the voting; the iframe only shows results.
3. **Size the QR with `out.width='330px'`.** `fig.width`/`fig.height` instead
   rendered it 450 px and pushed the slide 4 px past the bottom edge.

**Outstanding before Session 2 is shared:** `MENTI_CODE` is still the placeholder
`"1234 5678"`. On the published site the QR decodes to
`https://www.menti.com/12345678`, which points nowhere. Set a real code, and set
it while the Menti is live — the participant URL only resolves while running.

---

## 9 · Gotchas, each one observed

| Symptom | Cause | Fix |
|---|---|---|
| `hline.after()` fails to render | `kableExtra` here is **1.4.0**, an old API | Use `row_spec(2, hline_after = TRUE)` — `hline_after` is an argument, not a function |
| Charts half-drawn or oversized | knitr sizes the widget as `fig.width × dpi` | Keep `dpi: 96` and set `fig.width` to match the chart's pixel width |
| Nested divs break the layout | Fence colons | Outer fence needs more colons than inner |
| Scrollbar beside every chart | `.cell-output-display` defaults to `overflow: auto` | Section 6 |
| LaTeX error on `quarto render --to pdf` | Reveal + a kable table is not a LaTeX path | Do not use `--to pdf`; see section 10 |
| Two-slide-looking PDF pages | Long slides split across pages | Accept it, or trim the slide |
| Word/phrase appears twice in a deck | The same number typed into a slide and into the setup chunk | Emit it from R with `r …` or `results='asis'` |
| A label contradicts its numbers | Heading and content edited separately | Check every label against its figure (section 7) |
| Columns container squashes, contents overflow | Slide content exceeds 720 px | Trim the slide — see below |

### A slide that is too tall squashes its columns

This one produces a confusing symptom. The theme makes each slide a flex column
with `justify-content: safe center` and `height: 100%`. When content exceeds
720 px, a `.columns` child gets **squashed** (31 px instead of its natural 300),
and the overflow is the column contents spilling out, not the container growing.

Measured on the Session 2 "table you would actually be handed" slide: content
was 966 px against a 720 px slide, and the columns block collapsed to 31 px.

Detect it by comparing each slide's content height against 720:

```js
// for each section.slide.level2: max bottom of any visible child,
// minus the slide's own bottom, converted to logical px using
// scale = slideWidth / 1280.  > 2 means trouble.
```

**Use print mode, not navigation.** Stepping slides with `Reveal.next()` advances
through *fragments*, so a deck with several `.fragment` blocks takes dozens of
steps and most slides never get laid out — the scan then reports a clean result
that is simply missing data. This produced a false all-clear on Day 2 Session 1,
and two real overflows (6 px and 88 px) were only found afterwards.

The reliable method is to load the deck with `?print-pdf`, wait for reveal to lay
every slide out at once, then measure all `section.slide` elements in a single
pass. No navigation, no fragments, no gaps:

```js
await page.goto(deckUrl + '?print-pdf');
await page.setViewportSize({ width: 1410, height: 800 });
await page.waitForTimeout(6000);      // reveal needs time to lay out 30+ slides
const out = await page.evaluate(() => {
  const secs = [...document.querySelectorAll('section.slide')];
  const over = [], scroll = [];
  for (const s of secs) {
    const r = s.getBoundingClientRect();
    if (r.width === 0) continue;
    const scale = r.width / 1280;
    let maxB = 0;
    for (const n of s.querySelectorAll('*')) {
      const b = n.getBoundingClientRect();
      if (b.height > 0) maxB = Math.max(maxB, b.bottom);
    }
    const o = Math.round((maxB - r.bottom) / scale);
    const h2 = s.querySelector('h2')?.innerText.replace(/\s+/g,' ').slice(0,44) || '(divider)';
    if (o > 2) over.push({ h2, over: o });
    s.querySelectorAll('.cell-output-display').forEach(el => {
      const w = el.offsetWidth - el.clientWidth;
      const h = el.offsetHeight - el.clientHeight;
      if (w > 0 || h > 0) scroll.push({ h2, w, h });
    });
  }
  return { laidOut: secs.filter(s => s.getBoundingClientRect().width > 0).length,
           overflow: over, scrollbars: scroll };
});
```

`laidOut` should equal the number of `section.slide` elements. If it does not,
the measurement is incomplete — do not read the result as a pass.

Fix by removing content, not by shrinking type: drop a panel, move a panel to a
neighbouring slide, or shorten prose. Session 2's fix was merging three panels
into two and moving the takeaway sentence inside an existing panel.

**Budget per slide:** roughly 720 px. A `.facts` grid is ~200, a `.panel` of
three lines ~90, an `h2` ~50, a half-width plotly chart at
`fig.height=2.7` ~270.

### Verify a render is self-contained

`embed-resources: true` should inline everything. Confirm rather than assume:

```powershell
$h = Get-Content Oct12_session2.html -Raw
([regex]::Matches($h,'Oct12_session2_files')).Count   # must be 0
```

A browser may log `ERR_UNEXPECTED` for a stale `<name>_files/...` path from an
earlier render. That is browser cache, not the deck — check the count above
before chasing it.

---

## 10 · Publishing

The repo is `github.com/lsempe77/R-course`, **public**, and GitHub Pages is
configured on `main` / `docs`. The site is:

**https://sempe.dev/R-course/**

Workflow:

1. Render the deck.
2. Copy the `.html` into `docs/`.
3. Commit and push.
4. The Pages build triggers automatically. Verify with
   `gh api repos/lsempe77/R-course/pages/builds/latest`.

`docs/` currently holds all five decks plus an `index.html` landing page and a
`.nojekyll` file (which stops GitHub stripping underscore-prefixed paths).

**Things to check before publishing, because the site is public:**

- The Menti code must be real, not the placeholder.
- Any `[PLACEHOLDER]` text left in a deck will be visible. `Oct12_session3` still
  has placeholders and dummy Abu Dhabi Police figures marked as such.
- The repo and everything in it is world-readable.

**PDF export.** `quarto render --to pdf` fails — that path goes through LaTeX
and chokes on the kable table. The working method is Chrome headless on the
deck's own print mode:

```powershell
$chrome = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$url = "file:///…/Oct12_session2.html?print-pdf"
& $chrome --headless=new --disable-gpu --no-pdf-header-footer `
  --window-size=1408,792 --virtual-time-budget=90000 `
  --print-to-pdf="$env:TEMP\deck.pdf" $url
```

Three details that matter:

- **`?print-pdf` on the URL** activates reveal's print stylesheet. Without it the
  output is US Letter portrait. With it, `@page` becomes `size:1408px 792px`.
- **`--window-size` matching the slide dimensions** keeps the landscape size.
- **Write to `$env:TEMP`, not the OneDrive folder.** Headless Chrome gets
  "Access is denied" writing there; copy the finished PDF in afterwards.

Expect about 33 pages for a 29-slide deck — some long slides split. That is
normal and acceptable for a print copy.

---

## 11 · Starting a new session — checklist

1. **Read `Module2_outline.xlsx`** for that session's brief (section 0). Also
   check `Module2_exercise_plan.docx` and `Module2_task_checklist.docx`.
2. **Check whether the data exists.** If not, design a generated dataset whose
   columns serve every session that will use it (section 0b), and write a
   `check_*.R` that proves each intended use.
3. **Use `[theme_editorial.scss]`.** The theme fork is settled (section 1); do not
   load `clean.scss` or `module2.scss`.
4. Copy the YAML block (section 2) and the setup chunk skeleton (section 3),
   including `pl_m2()` and `ax()` unchanged.
5. Copy the Menti block (section 8) and **set a real `MENTI_CODE`**.
6. Draft to the six-movement shape (section 4), with `::: {.warn}` marking any
   invented data on the slide where it appears.
7. For each reveal: if it needs a number, put that number on the slide.
8. Use the components (section 5); put `.fragment` on the same div.
9. Run the verification loop (section 7) after every editing round, including
   the 720 px height check.
10. Publish (section 10) only after checking for placeholders.

### Reference implementations

| Deck | Slides | What it demonstrates |
|---|---|---|
| `Oct12_session1.qmd` | 29 | the pattern; five-words structure; a reveal rebuilt as a table |
| `Oct12_session2.qmd` | 25 | a real-output sitting; planted AI errors; both leak types |
