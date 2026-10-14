# PDF and PowerPoint snapshots of the decks

The decks run R in the browser, so a plain PDF export would show code without
results. These two scripts capture each published deck slide by slide in a
headless browser, with every fragment shown and every live cell run, then turn
the images into a PDF and a PowerPoint (one picture per slide, speaker notes in
the notes pane). The files are snapshots for sharing, not editable slides.

1. Serve the site locally: `python -m http.server 8767` in `docs/`.
2. For each deck: `node capture.js http://localhost:8767/<deck>.html cap/<deck>`
   (needs Node with Playwright; set `WAIT=120000` if a deck shows a
   "Downloading package" banner on its first slides).
3. `python build_exports.py ../../docs/exports` (needs PyMuPDF and python-pptx).

Re-run after changing a deck, or the files on the site go stale.

## Keeping the exports current

The exports are snapshots, so they go stale whenever a deck changes. Before every push run `python check_stale.py` (from this folder, or `python export_tools/check_stale.py` from `Module_2_Oct_2026_v2`). It lists each deck whose published HTML is newer than its PDF or PowerPoint and exits 1 if any are stale. Re-run steps 1 to 3 above for those decks. Mind OneDrive: a sync can change file times, so treat a surprise list as a prompt to check, not proof.
