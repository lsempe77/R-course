"""Change which Session 2 worksheet the course hub (docs/index.html) offers for download.

Usage (from anywhere):
  python Module_2_Oct_2026_v2/review_2026_10_06/swap_s2_worksheet.py status
  python Module_2_Oct_2026_v2/review_2026_10_06/swap_s2_worksheet.py new   # new 7-page worksheet, Word file (now live)
  python Module_2_Oct_2026_v2/review_2026_10_06/swap_s2_worksheet.py old   # the printed Sheet 1 and Sheet 2, Word file
  python Module_2_Oct_2026_v2/review_2026_10_06/swap_s2_worksheet.py html  # new worksheet, HTML page

It changes only the one link on the Session 2 card, and nothing else in index.html.
Then commit and push docs/index.html (GitHub Pages rebuilds in about a minute).
"""
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
INDEX = ROOT / 'docs' / 'index.html'
LINKS = {'new': 'handouts/Oct12_session2_review_worksheet.docx',
         'old': 'handouts/Oct12_session2_handouts.docx',
         'html': 'handouts/Oct12_session2_review_worksheet.html'}
def find(text):
    return [k for k, v in LINKS.items() if f'href="{v}"' in text]
text = INDEX.read_bytes().decode('utf-8')
now = find(text)
mode = sys.argv[1] if len(sys.argv) > 1 else 'status'
if mode == 'status':
    print('Session 2 worksheet link on the hub:', now or 'none of the known links')
    for k, v in LINKS.items(): print(' ', k, v, 'exists' if (ROOT / 'docs' / v).is_file() else 'MISSING')
elif mode in LINKS:
    if len(now) != 1: sys.exit(f'Expected exactly one known Session 2 worksheet link, found {now}. Edit docs/index.html by hand.')
    if not (ROOT / 'docs' / LINKS[mode]).is_file(): sys.exit(f'docs/{LINKS[mode]} does not exist.')
    if now[0] == mode: sys.exit(f'Already set to {mode}.')
    assert text.count(f'href="{LINKS[now[0]]}"') == 1
    INDEX.write_bytes(text.replace(f'href="{LINKS[now[0]]}"', f'href="{LINKS[mode]}"').encode('utf-8'))
    print(f'Hub link changed from {now[0]} to {mode}: {LINKS[mode]}')
else:
    sys.exit(__doc__)
