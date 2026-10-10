"""Switch a Day 1 session between the live v1 files and the new files, and switch it back.

Usage (run from anywhere):
  python review_2026_10_06/switch_session.py status
  python review_2026_10_06/switch_session.py apply d1s1 d1s2 d1s3
  python review_2026_10_06/switch_session.py revert d1s2

Before it overwrites a file for the first time it copies the file in use to
backups/switch_2026_10_10/ . `revert` puts that copy back. The git tag live-v1-2026-10-10
holds the whole live version as a second way back.
The new HTML files must be rendered first (quarto render, in this folder). The script refuses
to copy a rendered file that is older than its source, so a stale file cannot go live by mistake.
"""
import sys, shutil, json, hashlib, time
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
MOD = ROOT / 'Module_2_Oct_2026_v2'
DOCS = ROOT / 'docs'
BACK = MOD / 'backups' / 'switch_2026_10_10'
LOG = MOD / 'review_2026_10_06' / 'qa' / 'switch_log.json'

SESSIONS = {
 'd1s1': dict(label='Day 1 S1 (slides follow the printed worksheet) + AI handout',
   copy=[('Oct12_session1_hybrid.html', 'docs/Oct12_session1_live.html'),
         ('Oct12_session1_ai_handout.docx', 'docs/handouts/Oct12_session1_ai_handout.docx')],
   sources={'Oct12_session1_hybrid.html': ['Oct12_session1_hybrid.qmd', 'session1_hybrid.R', 'session1_review.R', 'session1_review.css']}),
 'd1s2': dict(label='Day 1 S2 (preview version: new slides, worksheet and cards)',
   copy=[('Oct12_session2_review.html', 'docs/Oct12_session2.html'),
         ('Oct12_session2_review_worksheet.html', 'docs/handouts/Oct12_session2_review_worksheet.html'),
         ('Oct12_session2_review_cards.html', 'docs/handouts/Oct12_session2_review_cards.html')],
   sources={'Oct12_session2_review.html': ['Oct12_session2_review.qmd', 'session2_review.R', 'session2_review.css'],
            'Oct12_session2_review_worksheet.html': ['Oct12_session2_review_worksheet.qmd', 'session2_review.R'],
            'Oct12_session2_review_cards.html': ['Oct12_session2_review_cards.qmd', 'session2_review.R']},
   hub=('handouts/Oct12_session2_handouts.docx', 'handouts/Oct12_session2_review_worksheet.html')),
 'd1s3': dict(label='Day 1 S3 (slides follow the printed worksheet) + AI handout',
   copy=[('Oct12_session3_hybrid.html', 'docs/Oct12_session3_live.html'),
         ('Oct12_session3_ai_handout.docx', 'docs/handouts/Oct12_session3_ai_handout.docx')],
   sources={'Oct12_session3_hybrid.html': ['Oct12_session3_hybrid.qmd', 'session3_hybrid.R', 'session3_review.R', 'session1_review.css', 'session3_review.css']}),
}
INDEX = 'docs/index.html'

def sha(p): return hashlib.sha256(p.read_bytes()).hexdigest()[:12]
def backup(dest):
    b = BACK / dest.relative_to(ROOT)
    if dest.exists() and not b.exists():
        b.parent.mkdir(parents=True, exist_ok=True); shutil.copy2(dest, b)
    return b

def apply(key):
    s = SESSIONS[key]; done = []
    for src_name, dest_rel in s['copy']:
        src = MOD / src_name
        if not src.is_file(): sys.exit(f'{key}: {src_name} has not been rendered yet. Render it first.')
        for dep in s['sources'].get(src_name, []):
            if (MOD / dep).stat().st_mtime > src.stat().st_mtime:
                sys.exit(f'{key}: {src_name} is older than {dep}. Render it again first.')
    for src_name, dest_rel in s['copy']:
        src, dest = MOD / src_name, ROOT / dest_rel
        backup(dest); dest.parent.mkdir(parents=True, exist_ok=True); shutil.copy2(src, dest)
        assert sha(src) == sha(dest); done.append((dest_rel, sha(dest)))
    if 'hub' in s:
        idx = ROOT / INDEX; backup(idx)
        t = idx.read_text(encoding='utf-8')
        if s['hub'][0] in t: idx.write_text(t.replace(s['hub'][0], s['hub'][1]), encoding='utf-8')
    LOG.parent.mkdir(parents=True, exist_ok=True)
    log = json.loads(LOG.read_text()) if LOG.exists() else []
    log.append({'time': time.strftime('%Y-%m-%d %H:%M:%S'), 'action': 'apply', 'session': key, 'files': done})
    LOG.write_text(json.dumps(log, indent=2)); print(key, 'applied:', done)

def revert(key):
    s = SESSIONS[key]; targets = [d for _, d in s['copy']] + ([INDEX] if 'hub' in s else [])
    for dest_rel in targets:
        dest = ROOT / dest_rel; b = BACK / dest_rel
        if b.exists(): shutil.copy2(b, dest); print('restored', dest_rel)
        elif dest.exists() and dest_rel.endswith('ai_handout.docx'): dest.unlink(); print('removed', dest_rel)
        else: print('no backup for', dest_rel, '(nothing changed)')
    log = json.loads(LOG.read_text()) if LOG.exists() else []
    log.append({'time': time.strftime('%Y-%m-%d %H:%M:%S'), 'action': 'revert', 'session': key}); LOG.write_text(json.dumps(log, indent=2))

def status():
    for k, s in SESSIONS.items():
        print(k, '-', s['label'])
        for src_name, dest_rel in s['copy']:
            src, dest = MOD / src_name, ROOT / dest_rel
            print('   ', src_name, 'rendered' if src.is_file() else 'NOT RENDERED', '| live file', sha(dest) if dest.exists() else 'absent',
                  '| backed up' if (BACK / dest_rel).exists() else '')

if __name__ == '__main__':
    a = sys.argv[1:] or ['status']
    if a[0] == 'status': status()
    elif a[0] == 'apply': [apply(k) for k in a[1:]]
    elif a[0] == 'revert': [revert(k) for k in a[1:]]
    else: sys.exit(__doc__)
