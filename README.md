# R course · Module 2 teaching decks

Slide decks for the **Module 2** impact-evaluation training (Abu Dhabi, 12–15 October 2026),
plus the older Module 1 materials they grew out of.

**Live site:** https://sempe.dev/R-course/

Each deck is a Quarto reveal.js file rendered to a single self-contained HTML file, so it runs
offline from a USB stick with no network and no R installation. Everything published lives in
`docs/`, which is what GitHub Pages serves.

---

## Where the Module 2 decks live

All current work is in **`Module_2_Oct_2026_v2/`**. The older `session_1/` … `session_4/` and
`sessions_in_Abu_Dhabi/` folders are the Module 1 material and are kept for reference only.

| Day | Session | Deck | Slides | Status |
|-----|---------|------|--------|--------|
| 1 · Mon 12 Oct | 1 · Compared to What? | `Oct12_session1.qmd` | 29 | Built |
| 1 · Mon 12 Oct | 2 · What Do the Numbers Say? | `Oct12_session2.qmd` | 24 | Built |
| 1 · Mon 12 Oct | 3 · Spot the Problem | `Oct12_session3.qmd` | 33 | Built |
| 2 · Tue 13 Oct | 1 · Reading DiD Results | `Oct13_session1.qmd` | 32 | Built |
| 2 · Tue 13 Oct | 2 · Reading RDD Results | `Oct13_session2.qmd` | 28 | Built |
| 2 · Tue 13 Oct | 3 · Reading Matching Results | `Oct13_session3.qmd` | 32 | Built |
| 3 · Wed 14 Oct | 1 · Was It Worth It? | `Oct14_session1.qmd` | 31 | Built |
| 3 · Wed 14 Oct | 2 · What Can You Read? | `Oct14_session2.qmd` | 30 | Built |
| **3 · Wed 14 Oct** | **3 · Interrogate the Analyst** | — | — | **Not started** |
| **4 · Thu 15 Oct** | **1 · Is This Evidence Credible?** | — | — | **Not started** |
| **4 · Thu 15 Oct** | **2 · From Findings to Policy** | — | — | **Not started** |
| **4 · Thu 15 Oct** | **3 · Plan Your Own Evaluation** | — | — | **Not started** |

### Sessions still to build

Four of the twelve sessions have no deck. Each needs an artefact that does not yet exist, which is
the main reason they are still open:

- **Day 3 Session 3 — "Interrogate the Analyst" (QA clinic).** The trainer plays the evaluator and
  participants use a QA checklist to challenge methodology, assumptions, data quality and
  conclusions. Needs a **QA checklist** artefact.
- **Day 4 Session 1 — "Is This Evidence Credible?"** Applies that same checklist to a fictitious
  evaluation report with deliberate strengths and weaknesses; groups rate each section on a
  traffic-light scale. Needs the **fictitious report** and the **traffic-light rating sheet**.
- **Day 4 Session 2 — "From Findings to Policy".** Participants turn a set of findings into a short
  policy brief — headline finding, key implications, one recommendation, one risk — then swap and
  critique. Needs a **brief template** and a **findings set**.
- **Day 4 Session 3 — "Plan Your Own Evaluation".** Teams return to the design they started in
  Module 1 and add a results presentation plan, a cost-benefit framework, a visualisation sketch and
  an evidence translation plan, then pitch for five minutes. Needs the **Evaluation Design Update
  template**.

The authoritative brief for every session is `Module_2_Oct_2026_v2/Module2_outline.xlsx`. Read it
before drafting anything.

---

## Building a deck

Prerequisites: **Quarto 1.7+** and **R 4.4**. R must be on `PATH` for the render to find it.

```powershell
$env:PATH = "C:\Program Files\R\R-4.4.1\bin;" + $env:PATH
cd Module_2_Oct_2026_v2
quarto render Oct14_session1.qmd
```

Then publish by copying the HTML into `docs/` and pushing:

```powershell
Copy-Item Oct14_session1.html ..\docs\ -Force
git add Oct14_session1.qmd Oct14_session1.html ..\docs\Oct14_session1.html
git commit -m "…"
git push origin main
```

GitHub Pages rebuilds automatically from `main`. Confirm the build finished with:

```powershell
gh api repos/lsempe77/R-course/pages/builds/latest | ConvertFrom-Json | Select-Object status
```

### Data

The decks do not use real programme data. The synthetic datasets sit alongside the decks, and the
generators that produce them are checked in so the numbers can be rebuilt from scratch:

| File | Built by | Used by |
|------|----------|---------|
| `evaluation_data_GreenWaste.csv` | (original corpus) | Days 1–3 |
| `evaluation_data_GreenWaste_IV.csv` | (adds `intent_to_treat`, `enrolled_rp`) | Module 1 IV/matching decks |
| `evaluation_data_TrafficCameras.csv` | `make_traffic_camera_data.R` | Day 1 S2, Day 2 S1, Day 2 S2 |
| `evaluation_data_SchoolZoneRCT.csv` | `make_school_zone_rct_data.R` | Day 1 S3 |

`check_traffic_camera_data.R` re-verifies that the camera data still supports all four intended
teaching uses, and should be run after any change to the generator.

> **Note.** `evaluation_data.csv` at the repository root holds the *same records* as
> `evaluation_data_GreenWaste.csv` but with the cost column multiplied by 100. Never mix the two.
> See `Module_2_Oct_2026_v2/SESSION_BUILD_GUIDE.md`, section 0b.

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
