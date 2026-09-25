# R course · Module 2 teaching decks

Slide decks for the **Module 2** impact-evaluation training (Abu Dhabi, 12–15 October 2026),
plus the older Module 1 materials they grew out of.

**Live site:** https://sempe.dev/R-course/

Each deck is a Quarto reveal.js file rendered to a single self-contained HTML file. Six decks
(Lucas's sessions) are **live** decks: they run R in the browser through quarto-live and webR, so
they need an internet connection on the day and about a minute to get ready after opening. The
other six still run offline from a USB stick. Everything published lives in `docs/`, which is
what GitHub Pages serves.

---

## Where the Module 2 decks live

All current work is in **`Module_2_Oct_2026_v2/`**. The older `session_1/` … `session_4/` and
`sessions_in_Abu_Dhabi/` folders are the Module 1 material and are kept for reference only.

| Day | Session | Owner | Source file | Length | Slides |
|-----|---------|-------|-------------|--------|--------|
| 1 · Mon 12 Oct | 1 · Compared to What? | Lucas | `Oct12_session1_live.qmd` (live) | 1.5 h | 23 |
| 1 · Mon 12 Oct | 2 · What Do the Numbers Say? | Fiona | `Oct12_session2.qmd` | 1.5 h | 21 |
| 1 · Mon 12 Oct | 3 · Spot the Problem | Lucas | `Oct12_session3_live.qmd` (live) | 2 h | 29 |
| 2 · Tue 13 Oct | 1 · Reading DiD Results | Fiona | `Oct13_session1.qmd` | 1.5 h | 22 |
| 2 · Tue 13 Oct | 2 · Reading RDD Results | Lucas | `Oct13_session2_live.qmd` (live) | 1.5 h | 25 |
| 2 · Tue 13 Oct | 3 · Reading Matching Results | Fiona | `Oct13_session3.qmd` | 2 h | 32 |
| 3 · Wed 14 Oct | 1 · Was It Worth It? | Lucas | `Oct14_session1_live.qmd` (live) | 1.5 h | 23 |
| 3 · Wed 14 Oct | 2 · What Can You Read? | Fiona | `Oct14_session2.qmd` | 1.5 h | 22 |
| 3 · Wed 14 Oct | 3 · Interrogate the Analyst | Lucas | `Oct14_session3_live.qmd` (live) | 2 h | 29 |
| 4 · Thu 15 Oct | 1 · Is This Evidence Credible? | Fiona | `Oct15_session1.qmd` | 1.5 h | 23 |
| 4 · Thu 15 Oct | 2 · From Findings to Policy | Lucas | `Oct15_session2_live.qmd` (live) | 1.5 h | 27 |
| 4 · Thu 15 Oct | 3 · Plan Your Own Evaluation | Fiona | `Oct15_session3.qmd` | 2 h | 18 |

**For Lucas's six sessions the `_live.qmd` file is the source.** The older `Oct12_session1.qmd`,
`Oct12_session3.qmd`, `Oct13_session2.qmd`, `Oct14_session1.qmd`, `Oct14_session3.qmd` and
`Oct15_session2.qmd` are retired: they stay in the folder for reference, but nothing publishes
them, and their old URLs on the site forward to the live decks. Edit the `_live.qmd` files.

Slide counts are those of the published decks in `docs/`, counted as `class="slide level2"`.
Counting `##` in the `.qmd` gives a higher and wrong number, because a heading inside a
speaker-notes block or a code chunk never becomes a slide.

**All twelve sessions are built and published.** The four 2-hour sessions still sit below the
30–36 slide budget, most of all Oct15 Session 3 (18). The live decks carry more time per slide
than a static deck, because each live cell is run and discussed in the room.

### What is still open

- **Real case data.** Fiona's Oct13 Sessions 1 and 3 carry `[PLACEHOLDER]` slots for the Abu
  Dhabi DOH and DCD findings. Lucas's live decks dropped their Abu Dhabi slots under the rule
  that each session uses one example only.
- **The Menti code is a placeholder** in all twelve decks, so the QR codes point at a Menti that
  does not exist. A poll built into the slides (Firebase) is planned for the live decks and needs
  a Firebase project first.
- **Fiona's retired `Oct13_session2.qmd` pools all neighbourhoods in its RDD** and reports -249.
  The live deck uses the offered neighbourhoods only, as Module 1 did (-791 within 2 points;
  -1,119, or -905 with covariates, over the full range). Anything still quoting -249 is stale.
- **Day 4 Session 2's policy brief.** The task checklist records an open request to SCO for real
  policy briefs as examples of an ideal one. The exercise works without them, but a real example
  would sharpen the critique.
- **Day 4 Session 3 assumes a Module 1 design exists.** Module 1's design content is the eight
  conditions for a credible impact evaluation, and the template recaps them so the session is
  self-contained. If Module 1 produced a written design document, the template should point at it.

### The generated artefacts, and their sources

Four printable handouts and six shared sources. Every handout is generated: **editing the `.docx`
by hand will be overwritten on the next render.**

| Source (`.R`) | Drives |
|---------------|--------|
| `qa_checklist.R` | The clinic deck and its checklist handout |
| `qa_rating.R` | The deep-dive deck, the fictitious report, and the rating sheet |
| `qa_translation.R` | The translation deck, the findings pack, and the brief template |
| `qa_design_update.R` | The final deck and the Evaluation Design Update template |

| Handout (`.docx`) | What it is |
|-------------------|------------|
| `Oct14_session3_qa_checklist.docx` | Twenty questions in four areas, with space to record answers |
| `Oct15_session1_report.docx` | The fictitious evaluation report the room rates |
| `Oct15_session1_rating_sheet.docx` | Traffic-light rating sheet, one page per six sections |
| `Oct15_session2_findings.docx` | The six Tariff Shield findings, and what each does not license |
| `Oct15_session2_brief_template.docx` | The four-element brief, one side of A4 |
| `Oct15_session3_design_template.docx` | The Evaluation Design Update, in three parts |

Two of these carry teaching content that must not drift from the deck: the fictitious report's
numbers, and the six Tariff Shield findings. Both are generated from their `.R` source, so the deck
and the paper cannot disagree.

The report is a **fictitious teaching artefact** and says so in a banner on its first page. It
contains deliberate strengths as well as deliberate weaknesses, so the exercise is not "find the
errors" but "separate the good from the weak in one document". Its numbers match the GreenWaste
canonical values above, and the preferred specification it quietly fails to act on is the 816 AED
difference-in-differences estimate.

Tariff Shield, the programme in Day 4 Session 2, is a **different fictitious programme** and is
labelled as such in its findings pack. It is deliberately not GreenWaste: the room has spent two
days on that case study, and translating a case study they have memorised would not test
translation.

The authoritative brief for every session is `Module_2_Oct_2026_v2/Module2_outline.xlsx`. Read it
before drafting anything.

---

## Building a deck

Prerequisites: **Quarto 1.7+** and **R 4.4**. R must be on `PATH` for the render to find it.

```powershell
$env:PATH = "C:\Program Files\R\R-4.4.1\bin;" + $env:PATH
cd Module_2_Oct_2026_v2
quarto render Oct14_session1_live.qmd
```

Then move the HTML into `docs/` (only `docs/` is tracked; HTML beside the `.qmd` is ignored) and push:

```powershell
Move-Item Oct14_session1_live.html ..\docs\ -Force
git add Oct14_session1_live.qmd ..\docs\Oct14_session1_live.html
git commit -m "…"
git push origin main
```

**Live decks** use `format: live-revealjs` (the quarto-live extension in `_extensions/`), the DGE
theme `[theme_dge.scss, theme_live.scss]`, and read their CSV from next to the page, so the CSV
must also be in `docs/`. A live cell does not run from a file opened by double-click; serve the
folder (`quarto preview`) or use the published URL. The DGE brand kit in `DGE_theme/` is
gitignored; the decks use only the two logos in `Module_2_Oct_2026_v2/assets/`.

GitHub Pages rebuilds automatically from `main`. Confirm the build finished with:

```powershell
gh api repos/lsempe77/R-course/pages/builds/latest | ConvertFrom-Json | Select-Object status
```

### Data

The decks do not use real programme data. The synthetic datasets sit alongside the decks, and the
generators that produce them are checked in so the numbers can be rebuilt from scratch:

| File | Built by | Used by |
|------|----------|---------|
| `evaluation_data_GreenWaste.csv` | (original corpus) | Day 1 S3, Days 2–3 |
| `evaluation_data_TrafficCameras.csv` | `make_traffic_camera_data.R` | Day 1 S1 (ten-road slice and speed), Day 1 S2 |
| `evaluation_data_SchoolZoneRCT.csv` | `make_school_zone_rct_data.R` | only the retired `Oct12_session3.qmd` |

`check_traffic_camera_data.R` re-verifies that the camera data still supports all four intended
teaching uses, and should be run after any change to the generator.

> **Note.** The Module 1 decks ship their own `evaluation_data.csv` beside them (`session_4/`,
> `sessions_in_Abu_Dhabi/`). It holds the *same records* as `evaluation_data_GreenWaste.csv`, but
> `waste_management_costs` is on a legacy scale 100x smaller (`15.19` where the Module 2 file reads
> `1518.55`). Never mix the two. See `Module_2_Oct_2026_v2/SESSION_BUILD_GUIDE.md`, section 0b.
>
> The exported regression tables `did.docx`, `itt.docx`, `late.docx`, `psm.docx`, `rdd.docx` and
> `regm.docx` at the repository root are **superseded provenance, not quotable numbers**. They are on
> the retired Module 1 scale, ten times the figures below (`did.docx` reports a DiD of `-8,162.93`
> where this document says `-816`; `rdd.docx` reports `-9,051.37` against `-905`).

### GreenWaste: one scale, 1,000 AED

GreenWaste is a fictitious waste-management programme used as the running case study. It must always
be quoted at the **AED** scale, against a **1,000 AED per year** decision threshold. The estimates,
all recomputed from the data rather than copied between decks:

| Method | Estimate |
|--------|----------|
| Randomized ATE | −1,014 AED |
| IV / LATE | −1,033 AED |
| RDD | −905 AED |
| DiD | −816 AED |
| Matching | −1,000 AED |

Older Module 1 material quoted the same programme at ten times this scale, against a `$10,000`
rule. That was a legacy convention, not a different programme; it has been retired. If you find a
`$10,000` or an `$8,000`-to-`$10,000` estimate anywhere, it is stale. Two decks also mislabelled the
case as *health* expenditures or as *HISP*; GreenWaste is a waste-management programme throughout.


---

## Conventions

`Module_2_Oct_2026_v2/SESSION_BUILD_GUIDE.md` is the build reference and is the place to look before
touching a deck. `Module_2_Oct_2026_v2/CLAUDE.md` holds the project overview, palette and session
map. Between them they cover the visual theme, the YAML header, the shared chart helpers, the
in-session teaching pattern, and the verification loop. The points that most often catch people out:

- **Verify in print mode.** Loading a deck normally and stepping through with the arrow keys walks
  *fragments*, so most slides never lay out. Load with `?print-pdf` instead, which lays out every
  slide at once, and check that the number of laid-out slides equals the total number of sections.
  Otherwise the scan is meaningless.
- **No timing badges.** The decks carry no `[n min]{.mins}` markers.
- **Never attribute invented numbers to a real organisation.** Every figure in a case study is
  either drawn from the synthetic data in this repository or visibly marked `[PLACEHOLDER]`.
- **The Menti code is still a placeholder.** `MENTI_CODE <- "1234 5678"` in every deck, so the QR
  codes currently point at a Menti that does not exist. Replace it before the training.

### Two traps when editing the Module 1 decks

Both of these have already bitten us once and neither is obvious from the error message.

- **Do not pass raw HTML to a `kable` caption.** `caption = "<center><span style=…>"` makes
  Quarto 1.7's Lua filter die with `main.lua:16935: attempt to get length of a nil value
  (field 'content')`. The error names the Lua file, not your slide, so it reads like a problem
  elsewhere in the deck. Use markdown instead — `caption = "**Bold text**"` renders the same and
  is safe.
- **`modelsummary(output = "tinytable")` needs `library(tinytable)`.** Returning a tinytable
  object does not attach the package, so a following `style_tt()` fails with
  `could not find function "style_tt"`. The setup chunk of `session_7_updated.qmd` loads it
  explicitly.

A quick way to find which slide is at fault when a render fails without naming one is to bisect by
slide: write prefixes of the `.qmd` to a scratch file and render each, halving the range until the
first failing prefix is one slide long.

---

## Repository layout

```
Module_2_Oct_2026_v2/   current decks, data, generators and build guide
docs/                   published HTML — this is what GitHub Pages serves
session_1..4/           Module 1 decks (reference only)
sessions_in_Abu_Dhabi/  Module 1 decks, Abu Dhabi edition (reference only)
Claude outputs/         earlier drafts and working files
```

---

## PDF export

`quarto render --to pdf` fails on the kable tables (`\cmrsideswitch` is undefined). Use Chrome
headless instead, appending `?print-pdf` to the deck's address:

```powershell
& "C:\Program Files\Google\Chrome\Application\chrome.exe" `
  --headless --disable-gpu --no-pdf-header-footer `
  --window-size=1408,792 `
  --print-to-pdf="$env:TEMP\deck.pdf" `
  "file:///…/Oct14_session1.html?print-pdf"
```

Write to `$env:TEMP`. Writing into the OneDrive folder fails with `Access is denied. (0x5)`.

---

International Initiative for Impact Evaluation (3ie) · Module 2 training materials.
