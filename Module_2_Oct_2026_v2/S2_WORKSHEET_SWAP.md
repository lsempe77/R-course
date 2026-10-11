# Session 2 worksheet on the course hub: Word file, and how to swap it

## What is live now (11 October, evening)
The Session 2 "Worksheet" button on `docs/index.html` downloads
`docs/handouts/Oct12_session2_review_worksheet.docx`, the new 7-page worksheet as a Word file (A4, Arial).
It was built from the rendered HTML worksheet by `review_2026_10_06/make_s2_worksheet_docx.py`.
The HTML version and the old Word file stay in `docs/handouts/`.

## Swap tomorrow morning if the old sheets were the ones printed
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
  `Oct12_session2_review_cards.html` / `.pdf`, which the hub does not link.
- The swap changes only the worksheet link. The slides are separate: `Oct12_session2.html` is the live review deck.
  If the old sheets are the printed ones, either use the notes in `Oct12_session2_flex.qmd`
  or the hybrid deck (see `Oct12_session2_hybrid_notes.md`), rendered and copied to `docs/`.
- `switch_session.py revert d1s2` also puts the old link back, but it restores the whole
  index.html from the morning backup, so use `swap_s2_worksheet.py old` instead.
- If the worksheet HTML is re-rendered, run `python Module_2_Oct_2026_v2/review_2026_10_06/make_s2_worksheet_docx.py`
  again and copy the .docx to `docs/handouts/`. It needs LibreOffice for the three charts.
- Checked in LibreOffice: 7 pages, each "Page n" starting a new sheet. Please open it once in Word to confirm
  before printing; Word can break lines slightly differently.
