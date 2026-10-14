#!/usr/bin/env python3
"""List decks whose PDF/PowerPoint export is older than the published deck.

The exports in docs/exports/ are snapshots of the published decks, so any deck
edit leaves them out of date until export_tools/capture.js and build_exports.py
are re-run. Run this before every push:

    python export_tools/check_stale.py          (from Module_2_Oct_2026_v2)

Exit code 1 if any export is stale, 0 if all are current.
"""
import os, sys, datetime

DOCS = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'docs')
EXPORTS = os.path.join(DOCS, 'exports')
stale = 0
for f in sorted(os.listdir(EXPORTS)):
    name, ext = os.path.splitext(f)
    if ext not in ('.pptx', '.pdf'):
        continue
    deck = os.path.join(DOCS, name + '.html')
    if not os.path.exists(deck):
        continue
    if os.path.getmtime(deck) > os.path.getmtime(os.path.join(EXPORTS, f)):
        stale += 1
        d = lambda p: datetime.datetime.fromtimestamp(os.path.getmtime(p)).strftime('%d %b %H:%M')
        print(f'STALE  {f:28s} deck {d(deck)}, export {d(os.path.join(EXPORTS, f))}')
print(f'{stale} stale export(s)' if stale else 'All exports are current.')
sys.exit(1 if stale else 0)
