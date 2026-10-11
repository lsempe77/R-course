# Day 1 Session 2 hybrid preview: what it keeps, adds and leaves out

Files: `Oct12_session2_hybrid.qmd` and `session2_hybrid.R`. Nothing existing was changed. Not rendered (no R or Quarto in the cloud workspace); the numbers were checked against the CSV in Python.
Render: `quarto render Oct12_session2_hybrid.qmd` in `Module_2_Oct_2026_v2`.

Assumed printed set: Sheet 1 and Sheet 2 (`Oct12_session2_materials.docx`, participant pages 1 and 2), the four landfill claim cards (page 3) and the optional A1 board.

## Printed item to slide

| Printed item | Slide |
|---|---|
| Sheet 1, section 1: Read alone first | 1 (and the extend poll on 3, the revisit on 9) |
| Sheet 1, section 2: What could an average hide | 11 |
| Sheet 2: Triage four claims, plus the four claim cards | 15, 16 |
| Sheet 2: My next question from memory | 18 |
| No printed item (old deck, kept) | 2, 4, 10, 17 |

## Added from the live (review) version

| Added content | Slide | How the questions are handled |
|---|---|---|
| The file in R (rows, columns, city and pilot) | 5 | Discussed on the slide |
| Filtering to the city rows | 6, 7 | Poll 2: what happened if a colleague reports 4,994 participants? |
| Cleaning examples (invented, in tonnes) | 8 | Discussed on the slide |
| Histogram of landfill before, with mean and median | 12 | Discussed on the slide |
| Histogram of changes, did landfill fall for every business? | 13 | Poll 3, with a record check |
| Exploring the data in R | 14 | Discussed on the slide |

All added slides use landfill tonnes so they match the printed sheets and cards. The live deck uses annual waste management cost in AED.

## In the live version but not in this preview

- H2-A1 and H2-A2 tables, the cost histograms, and worksheet Q1 to Q5 (they need the new 7-page worksheet).
- The with-and-without comparison of -669 AED and -1,638 AED (live slides p08 to p10). Slide 9 shows the same idea in landfill, without a printed question.
- The two-stage Copilot exercise (worksheet pages 5 and 6). The on-slide AI check (slide 17) is kept.
- The new decision cards (cost statements). The printed landfill cards stay.

## Timing and open points

- About 85 minutes against the 90-minute slot. If short: drop slide 14, then slide 8.
- Polls 2 and 3 are new; poll 1 is the existing extend question. Drop poll 3 if three is too many.
- Check slide fit at 1280x720, especially slides 6, 7, 13 (code or chart plus a poll) and 8.
- The 734 negative cost values flagged in `session2_review.R` do not affect this version, which uses landfill.

## Option B: worksheet-neutral live deck (`Oct12_session2_flex.qmd` + `session2_flex.R`)

Copy of the live (review) deck with the worksheet and page references removed from the slides. Each slide's notes end with a "HANDOUT VERSION" paragraph: what to say if the new worksheet was printed, and what to say if the old Sheet 1, Sheet 2 and claim cards were printed (the four old landfill statements are inserted from the case file). One slide was added (s2-p12b, the table of mean costs by group), because that table exists on paper only in the new worksheet. The code H2-A1 and H2-A2 is removed from table titles and AI texts. Costs stay in AED.

Slide 13 of the hybrid deck now labels the businesses whose landfill rose, because their bars are too small to see.
