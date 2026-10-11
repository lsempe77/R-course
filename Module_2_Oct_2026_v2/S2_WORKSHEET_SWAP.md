# Session 2 worksheet on the course hub: Word file, and how to swap it

## What is live now (12 October 2026)

The full rollout is deployed in `89c2577`. [README.md](README.md) and the [teaching guide](../docs/teaching_materials.html) identify the selected versions. Day 1 Session 2 has 22 screens, including Fiona's latest cleaning activity; its hybrid/flex alternatives are not selected. This document describes a contingency, not a request to revert the current bundle.

The Session 2 "Worksheet" button on `docs/index.html` downloads
`docs/handouts/Oct12_session2_review_worksheet.docx`, the new 7-page worksheet as a Word file (A4, Arial).
It was built from the rendered HTML worksheet by `review_2026_10_06/make_s2_worksheet_docx.py`.
The HTML version and the old Word file stay in `docs/handouts/`.

## Contingency: only if Fiona confirms the old sheets were printed

Changing just the hub link does not align the deck, guide or ZIP downloads. Coordinate the teaching version with Fiona first, then update all affected distribution surfaces together and verify deployment. Do not restore an old whole-hub backup.

From the repository folder:

    python Module_2_Oct_2026_v2/review_2026_10_06/swap_s2_worksheet.py old

This points the button at `handouts/Oct12_session2_handouts.docx` (Sheet 1 and Sheet 2, the printed pair).
Then commit and push `docs/index.html`, and open https://3ie.academy to check the button.
To go back: the same command with `new`. `status` shows which link is live. `html` gives the HTML page.

By hand (if Python is not available): in `docs/index.html`, change the one link
`handouts/Oct12_session2_review_worksheet.docx` to `handouts/Oct12_session2_handouts.docx`.

## Things to know
- The old Word file has Sheet 1 and Sheet 2 only. The four old claim cards are in
  `docs/trainer/Oct12_session2_materials.docx` (page 3). The new decision cards are
  [the published HTML cards](../docs/handouts/Oct12_session2_review_cards.html), included in the current print download. HTML prints to five pages: four cards plus the board.
- The swap changes only the worksheet link. The slides are separate: `Oct12_session2.html` is the live review deck.
  If the old sheets are the printed ones, either use the notes in `Oct12_session2_flex.qmd`
  or the hybrid deck (see `Oct12_session2_hybrid_notes.md`), rendered and copied to `docs/`.
- `switch_session.py revert d1s2` also puts the old link back, but it restores the whole
  index.html from the morning backup, so use `swap_s2_worksheet.py old` instead.
- Regenerate Word only when worksheet content changes, not for HTML-only print styling. For content changes, run `python Module_2_Oct_2026_v2/review_2026_10_06/make_s2_worksheet_docx.py`
  and copy the .docx to `docs/handouts/`, then refresh the print ZIP. It needs LibreOffice for the three charts.
- Checked in LibreOffice: 7 pages, each "Page n" starting a new sheet. Please open it once in Word to confirm
  before printing; Word can break lines slightly differently.
