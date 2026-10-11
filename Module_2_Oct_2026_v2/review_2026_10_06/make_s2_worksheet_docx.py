"""Build the Day 1 Session 2 worksheet as a Word file from the rendered HTML worksheet.

Usage (from Module_2_Oct_2026_v2/):
  python review_2026_10_06/make_s2_worksheet_docx.py

Reads  Oct12_session2_review_worksheet.html  (render the .qmd first)
Writes Oct12_session2_review_worksheet.docx  (A4, Arial, same look as the other handouts)

The three charts are SVG in the HTML. They are converted to PNG with LibreOffice (soffice),
which must be installed. Re-run this script after every re-render of the worksheet HTML.
"""
import re, subprocess, sys, tempfile
from pathlib import Path
from bs4 import BeautifulSoup, NavigableString
import docx
from docx.shared import Pt, Mm, RGBColor
from docx.enum.text import WD_BREAK
from docx.oxml.ns import qn
from docx.oxml import OxmlElement

MOD = Path(__file__).resolve().parents[1]
SRC = MOD / 'Oct12_session2_review_worksheet.html'
OUT = MOD / 'Oct12_session2_review_worksheet.docx'
NAVY, GREY = RGBColor(0x06, 0x33, 0x60), RGBColor(0x54, 0x58, 0x60)
BODY = 10.5

html = SRC.read_text(encoding='utf-8')
soup = BeautifulSoup(html, 'html.parser')

# ---- charts: SVG to PNG -------------------------------------------------------------
tmp = Path(tempfile.mkdtemp())
png = []
for i, m in enumerate(re.finditer(r'<svg class="review-svg".*?</svg>', html, flags=re.S)):
    s = re.sub(r'<svg class="review-svg" viewbox="0 0 (\d+) (\d+)"[^>]*>',
               lambda k: f'<svg xmlns="http://www.w3.org/2000/svg" width="{int(k.group(1))*2}" height="{int(k.group(2))*2}" '
                         f'viewBox="0 0 {k.group(1)} {k.group(2)}" font-family="Arial, Liberation Sans, sans-serif">'
                         '<rect width="100%" height="100%" fill="white"/>', m.group(0), count=1)
    f = tmp / f'fig{i}.svg'; f.write_text(s, encoding='utf-8')
    subprocess.run(['soffice', '--headless', '--convert-to', 'png', '--outdir', str(tmp), str(f)],
                   check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=120)
    png.append(tmp / f'fig{i}.png')
if len(png) != 3: sys.exit(f'Expected 3 charts, found {len(png)}')
png_iter = iter(png)

# ---- document -----------------------------------------------------------------------
d = docx.Document(str(MOD / 'reader_template.docx'))
sec = d.sections[0]
sec.page_width, sec.page_height = Mm(210), Mm(297)
sec.left_margin = sec.right_margin = Mm(17.8); sec.top_margin = sec.bottom_margin = Mm(16.5)
st = d.styles['Normal']; st.font.name = 'Arial'; st.font.size = Pt(BODY)
st.element.rPr.rFonts.set(qn('w:eastAsia'), 'Arial')
st.paragraph_format.space_after = Pt(4); st.paragraph_format.space_before = Pt(0)

def fmt_run(r, size=None, bold=None, italic=None, color=None):
    r.font.name = 'Arial'; r._element.rPr.rFonts.set(qn('w:eastAsia'), 'Arial')
    if size: r.font.size = Pt(size)
    if bold is not None: r.bold = bold
    if italic is not None: r.italic = italic
    if color is not None: r.font.color.rgb = color

def border(p, side, color='7DA1C4', sz=6, space=1):
    ppr = p._p.get_or_add_pPr(); b = ppr.find(qn('w:pBdr'))
    if b is None: b = OxmlElement('w:pBdr'); ppr.append(b)
    e = OxmlElement(f'w:{side}'); e.set(qn('w:val'), 'single'); e.set(qn('w:sz'), str(sz))
    e.set(qn('w:space'), str(space)); e.set(qn('w:color'), color); b.append(e)

def add_inline(p, node, size=BODY, bold=False, italic=False, color=None):
    for c in node.children:
        if isinstance(c, NavigableString):
            t = re.sub(r'\s+', ' ', str(c))
            if t: fmt_run(p.add_run(t), size, bold, italic, color)
        elif c.name == 'br': p.add_run().add_break()
        elif c.name in ('strong', 'b'): add_inline(p, c, size, True, italic, color)
        elif c.name in ('em', 'i'): add_inline(p, c, size, bold, True, color)
        else: add_inline(p, c, size, bold, italic, color)

def para(node, size=BODY, bold=False, color=None, after=4, before=0, indent=None, left_rule=False, keep=False):
    p = d.add_paragraph(); pf = p.paragraph_format
    pf.space_after, pf.space_before = Pt(after), Pt(before)
    if indent: pf.left_indent = Mm(indent)
    if keep: pf.keep_with_next = True
    if left_rule: border(p, 'left', '7DA1C4', 18, 8)
    add_inline(p, node, size, bold, False, color)
    return p

def writing_line(n=1):
    for _ in range(n):
        p = d.add_paragraph(); p.paragraph_format.space_before = Pt(13); p.paragraph_format.space_after = Pt(0)
        border(p, 'bottom', 'A9BDD2', 6, 1)

def shade(cell, fill):
    tcpr = cell._tc.get_or_add_tcPr(); s = OxmlElement('w:shd')
    s.set(qn('w:val'), 'clear'); s.set(qn('w:color'), 'auto'); s.set(qn('w:fill'), fill); tcpr.append(s)

def table(node):
    rows = node.find_all('tr'); ncol = max(len(r.find_all(['td', 'th'])) for r in rows)
    t = d.add_table(rows=0, cols=ncol); t.autofit = True
    tblpr = t._tbl.tblPr; bd = OxmlElement('w:tblBorders')
    for side in ('top', 'bottom', 'insideH'):
        e = OxmlElement(f'w:{side}'); e.set(qn('w:val'), 'single'); e.set(qn('w:sz'), '4'); e.set(qn('w:color'), 'D5DEE8'); bd.append(e)
    tblpr.append(bd)
    for ri, r in enumerate(rows):
        cells = t.add_row().cells
        head = ri == 0 and r.find('th') is not None and r.find_parent('thead') is not None
        for ci, c in enumerate(r.find_all(['td', 'th'])):
            p = cells[ci].paragraphs[0]; p.paragraph_format.space_after = Pt(2); p.paragraph_format.space_before = Pt(2)
            add_inline(p, c, 9.5, bold=head or c.name == 'th' and not head and False,
                       color=RGBColor(255, 255, 255) if head else None)
            if head:
                shade(cells[ci], '063360')
                for run in p.runs: run.bold = True
    d.add_paragraph().paragraph_format.space_after = Pt(2)

def block(el):
    if isinstance(el, NavigableString): return
    cls = el.get('class') or []
    n = el.name
    if n == 'h2':
        para(el, 17, True, NAVY, after=6, keep=True)
    elif n == 'h3':
        para(el, 12, True, None, after=3, before=8, keep=True)
    elif n == 'p':
        if 'table-title' in cls: para(el, 10.5, True, NAVY, after=3, before=4, keep=True)
        elif 'caption' in cls: para(el, 9, False, GREY)
        else: para(el)
    elif n == 'table': table(el)
    elif n == 'svg':
        d.add_picture(str(next(png_iter)), width=Mm(150)); d.paragraphs[-1].paragraph_format.space_after = Pt(4)
    elif n == 'div' and 'writing' in cls:
        writing_line(2 if 'part' not in cls else 1)
    elif n == 'div' and 'ai-source' in cls:
        for c in el.find_all('p', recursive=False): para(c, 10.5, indent=4, left_rule=True)
    elif n == 'div' and 'prompt' in cls:
        for c in el.children:
            if isinstance(c, NavigableString): continue
            if c.name == 'p': para(c, 10, indent=4, left_rule=True)
            elif c.name == 'strong': p = d.add_paragraph(); add_inline(p, c, 10, True)
        pass
    elif n in ('div', 'section'):
        for c in el.children: block(c)
    elif n in ('ul', 'ol'):
        for k, li in enumerate(el.find_all('li', recursive=False)):
            label = f'({chr(97 + int(el.get("start", 1)) - 1 + k)}) ' if n == 'ol' else '\u2022 '
            p = d.add_paragraph(); pf = p.paragraph_format
            pf.left_indent = Mm(9); pf.first_line_indent = Mm(-6); pf.space_after = Pt(4)
            fmt_run(p.add_run(label), BODY)
            add_inline(p, li)

# svgs are inline in raw HTML blocks: swap each for a placeholder tag we can recognise
for s in soup.find_all('svg', class_='review-svg'):
    s.replace_with(soup.new_tag('svg'))
pages = soup.find_all(['div', 'section'], class_='sheet-page')
assert len(pages) == 7, len(pages)
for i, pg in enumerate(pages):
    start = len(d.paragraphs)
    p0 = d.add_paragraph(); fmt_run(p0.add_run('GreenWaste: comparing groups | Day 1 | Session 2 | GreenWaste is a fictional training case.'), 8.5, False, False, GREY)
    p0.paragraph_format.space_after = Pt(2)
    if i: p0.paragraph_format.page_break_before = True
    for c in pg.children: block(c)
# the template starts with no content; drop an empty first paragraph if one exists
d.save(str(OUT)); print('wrote', OUT)
