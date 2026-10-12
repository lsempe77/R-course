#!/usr/bin/env python3
"""Builds the GreenWaste methods decision tree from one definition.

Outputs (next to this script, or in OUT if given as argv[1]):
  _methods_tree.qmd                    interactive tree for the Day 2 S3 deck (included raw HTML)
  _day2_session3_review_interactions.html   the click logic for the deck
  methods_decision_tree.html / .svg    static copy for the website (print to PDF from the browser)
"""
import sys, os, json, textwrap, html

OUT = sys.argv[1] if len(sys.argv) > 1 else os.path.dirname(os.path.abspath(__file__))
W, H = 1200, 605
FONT = '"Noto Kufi Arabic","Segoe UI",Arial,sans-serif'

# ---- the tree -------------------------------------------------------------
# kind q = question, m = method (end), x = no credible comparison (end)
N = {
 'q0':   dict(kind='q', x=370, y=8,   w=460, h=62,  wrap=38, text='Are you designing the evaluation before or after the programme starts?'),
 'q1':   dict(kind='q', x=20,  y=107, w=320, h=96,  wrap=24, text='Is it ethical and feasible to randomise who gets the programme?'),
 'q2':   dict(kind='q', x=850, y=108, w=340, h=108, wrap=25, text='Do we have before and after data for participants and a comparison group?'),
 'q3':   dict(kind='q', x=850, y=260, w=340, h=108, wrap=25, text='Did participant and comparison costs follow a similar path before the programme?'),
 'qcut': dict(kind='q', x=360, y=277, w=320, h=74,  wrap=26, text='Did a score or cut-off decide who could take part?'),
 'qobs': dict(kind='q', x=330, y=395, w=360, h=96,  wrap=27, text='Do the recorded characteristics explain who took part, with nothing important missing?'),
 'm_rct':   dict(kind='m', x=15,  y=525, w=170, h=72, title='Lottery', sub='Randomised trial'),
 'm_rdd':   dict(kind='m', x=205, y=525, w=170, h=72, title='Regression', sub='discontinuity'),
 'm_match': dict(kind='m', x=425, y=525, w=190, h=72, title='Matching', sub='Day 2 Session 3'),
 'm_did':   dict(kind='m', x=910, y=525, w=220, h=72, title='Difference-in-', sub='differences'),
 'x_none':  dict(kind='x', x=790, y=388, w=200, h=110, title='No credible comparison', sub='Ask for another design or more data'),
}
N['m_rct']['sub'] = 'Randomised trial'
N['m_rdd']['sub'] = 'Day 2 Session 2'
N['m_did']['sub'] = 'Day 2 Session 1'
N['m_rdd']['title'] = 'Regression discontinuity'
N['m_did']['title'] = 'Difference-in-differences'

# edges: id, from, to, label, polyline points, label centre
E = [
 ('q0>q1',   'q0','q1','Before',[(370,39),(180,39),(180,107)],(290,39)),
 ('q0>q2',   'q0','q2','After', [(830,39),(1020,39),(1020,108)],(910,39)),
 ('q1>m_rct','q1','m_rct','Yes',[(100,203),(100,525)],(100,365)),
 ('q1>qcut', 'q1','qcut','No',  [(340,155),(520,155),(520,277)],(430,155)),
 ('q2>q3',   'q2','q3','Yes',   [(1020,216),(1020,260)],(1058,238)),
 ('q2>qcut', 'q2','qcut','No',  [(850,166),(520,166),(520,277)],(780,166)),
 ('q3>m_did','q3','m_did','Yes',[(1020,368),(1020,525)],(1020,500)),
 ('q3>qcut', 'q3','qcut','No',  [(850,314),(680,314)],(765,314)),
 ('qcut>m_rdd','qcut','m_rdd','Yes',[(360,314),(290,314),(290,525)],(325,314)),
 ('qcut>qobs','qcut','qobs','No',[(520,351),(520,395)],(558,373)),
 ('qobs>m_match','qobs','m_match','Yes',[(520,491),(520,525)],(558,508)),
 ('qobs>x_none','qobs','x_none','No',[(690,443),(790,443)],(740,443)),
]

RESULT = {
 'm_rct':   ('Lottery (randomised trial)', 'Groups were assigned by chance. Ask how the draw was done and who dropped out.'),
 'm_did':   ('Difference-in-differences', 'Compares the change in participants with the change in a comparison group. Ask whether earlier measurements show similar paths.'),
 'm_rdd':   ('Regression discontinuity', 'Compares businesses just either side of the cut-off. It describes businesses near the cut-off. Ask whether the result holds in a wider window.'),
 'm_match': ('Matching', 'Compares participants with similar non-participants. Ask what was not measured and how close the matches are.'),
 'x_none':  ('No credible comparison yet', 'Ask for another design or more data. Until then, read any difference as descriptive, not as the effect of the programme.'),
}

CSS = f"""
.mtree{{font-family:{FONT};}}
.mtree svg{{width:100%;height:auto;display:block;margin:0 auto}}
.mtree .mt-line{{fill:none;stroke:#063360;stroke-width:2.6}}
.mtree .mt-q rect{{fill:#E4EBF3;stroke:#215a9e;stroke-width:2.5}}
.mtree .mt-m rect{{fill:#215a9e;stroke:#063360;stroke-width:2.5}}
.mtree .mt-x rect{{fill:#F8E9EA;stroke:#B8272C;stroke-width:2.5}}
.mtree .mt-t{{font-size:18px;fill:#111418;text-anchor:middle}}
.mtree .mt-m .mt-t{{fill:#fff;font-weight:700}}
.mtree .mt-m .mt-s{{fill:#E4EBF3;font-size:15px;font-weight:400}}
.mtree .mt-x .mt-s{{font-size:15px;fill:#545860}}
.mtree .mt-pill rect{{fill:#fff;stroke:#063360;stroke-width:2}}
.mtree .mt-pill text{{font-size:17px;font-weight:700;fill:#063360;text-anchor:middle}}
.mtree[data-interactive] .mt-node,.mtree[data-interactive] .mt-edge{{opacity:.22;transition:opacity .3s}}
.mtree[data-interactive] .mt-node.on,.mtree[data-interactive] .mt-edge.on{{opacity:1}}
.mtree[data-interactive] .mt-node.current rect{{stroke:#063360;stroke-width:5;fill:#cfe0f3}}
.mtree[data-interactive] .mt-node.result rect{{stroke:#111418;stroke-width:6}}
.mtree[data-interactive] .mt-edge.taken{{opacity:1}}
.mtree[data-interactive] .mt-edge.taken .mt-line{{stroke:#215a9e;stroke-width:6;marker-end:url(#mt-arrow-on)}}
.mtree[data-interactive] .mt-edge.taken .mt-pill rect{{fill:#215a9e;stroke:#215a9e}}
.mtree[data-interactive] .mt-edge.taken .mt-pill text{{fill:#fff}}
.mtree[data-interactive] .mt-node.on rect{{stroke-width:3.5}}
.mtree[data-interactive] .mt-edge.next{{opacity:1;cursor:pointer}}
.mtree[data-interactive] .mt-edge.next .mt-pill rect{{fill:#063360}}
.mtree[data-interactive] .mt-edge.next .mt-pill text{{fill:#fff}}
.mtree .mtree-ctl{{display:grid;grid-template-columns:1fr auto;gap:8px 18px;align-items:center;margin-top:6px}}
.mtree .mtree-q{{font-size:26px;line-height:1.25;color:#063360;font-weight:700}}
.mtree .mtree-msg{{font-size:22px;line-height:1.3;color:#111418;grid-column:1/-1}}
.mtree .mtree-msg strong{{color:#063360}}
.mtree .mtree-btns{{display:flex;gap:10px;flex-wrap:wrap;justify-content:flex-end}}
.mtree button{{font:inherit;font-size:22px;padding:6px 20px;border:2px solid #063360;background:#fff;color:#063360;border-radius:6px;cursor:pointer}}
.mtree button.mt-go{{background:#215a9e;color:#fff;border-color:#215a9e}}
.mtree button:disabled{{opacity:.35;cursor:default}}
"""

def esc(s): return html.escape(s, quote=False)

def node_svg(i, n):
    x, y, w, h = n['x'], n['y'], n['w'], n['h']
    cx = x + w/2
    cls = {'q': 'mt-q', 'm': 'mt-m', 'x': 'mt-x'}[n['kind']]
    out = [f'<g id="n-{i}" class="mt-node {cls}" data-id="{i}"><rect x="{x}" y="{y}" width="{w}" height="{h}" rx="6"/>']
    if n['kind'] == 'q':
        lines = textwrap.wrap(n['text'], n['wrap'])
        lh = 23; top = y + h/2 - (len(lines)-1)*lh/2 + 6
        for k, ln in enumerate(lines):
            out.append(f'<text class="mt-t" x="{cx}" y="{top + k*lh:.1f}">{esc(ln)}</text>')
    else:
        sub = textwrap.wrap(n['sub'], 19) if n['kind'] == 'x' else [n['sub']]
        tl = textwrap.wrap(n['title'], 18 if n['kind'] == 'm' else 14)
        lh = 22; total = len(tl) + len(sub)
        top = y + h/2 - (total-1)*lh/2 + 6
        for k, ln in enumerate(tl):
            out.append(f'<text class="mt-t" x="{cx}" y="{top + k*lh:.1f}">{esc(ln)}</text>')
        for k, ln in enumerate(sub):
            out.append(f'<text class="mt-t mt-s" x="{cx}" y="{top + (len(tl)+k)*lh:.1f}">{esc(ln)}</text>')
    out.append('</g>')
    return ''.join(out)

def edge_svg(e):
    eid, a, b, lab, pts, (lx, ly) = e
    d = 'M' + ' L'.join(f'{px} {py}' for px, py in pts)
    pw = 86 if lab in ('Before', 'After') else 56
    return (f'<g id="e-{eid}" class="mt-edge" data-from="{a}" data-to="{b}" data-label="{lab}">'
            f'<path class="mt-line" d="{d}" marker-end="url(#mt-arrow)"/>'
            f'<g class="mt-pill"><rect x="{lx-pw/2}" y="{ly-15}" width="{pw}" height="30" rx="6"/><text x="{lx}" y="{ly+6}">{lab}</text></g></g>')

def svg(label):
    parts = [f'<svg viewBox="0 0 {W} {H}" role="img" aria-label="{esc(label)}">',
             '<defs><marker id="mt-arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto"><path d="M0 0 L10 5 L0 10 z" fill="#063360"/></marker>'
             '<marker id="mt-arrow-on" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="3.2" markerHeight="3.2" orient="auto"><path d="M0 0 L10 5 L0 10 z" fill="#215a9e"/></marker></defs>']
    parts += [edge_svg(e) for e in E]
    parts += [node_svg(i, n) for i, n in N.items()]
    parts.append('</svg>')
    return ''.join(parts)

LABEL = ('Decision tree for choosing between a lottery, difference-in-differences, regression discontinuity and matching. '
         'Start by asking whether the evaluation is designed before or after the programme. Before: randomise if ethical and feasible. '
         'Otherwise, or after: difference-in-differences needs before and after data and similar earlier paths; '
         'regression discontinuity needs a score cut-off; matching needs recorded characteristics that explain who took part; '
         'otherwise there is no credible comparison yet.')

# ---- deck fragment ----------------------------------------------------------
tree = {i: {'opts': [{'label': e[3], 'to': e[2], 'edge': e[0]} for e in E if e[1] == i]} for i in N if N[i]['kind'] == 'q'}
question = {i: N[i]['text'] for i in N if N[i]['kind'] == 'q'}

deck = ('```{=html}\n<style>' + CSS + '.reveal .mtree svg{max-width:900px}.reveal .mtree .mtree-q{font-size:24px}.reveal .mtree .mtree-msg{font-size:21px}.reveal .mtree button{font-size:20px;padding:4px 16px}</style>\n'
        '<div class="mtree" data-interactive id="mtree">' + svg(LABEL) +
        '<div class="mtree-ctl"><div class="mtree-q" aria-live="polite"></div>'
        '<div class="mtree-btns"><button class="mt-back" type="button">Back</button><button class="mt-reset" type="button">Start over</button></div>'
        '<div class="mtree-opts mtree-btns" style="grid-column:1/-1;justify-content:flex-start"></div>'
        '<div class="mtree-msg" aria-live="polite"></div></div></div>\n```\n')
open(os.path.join(OUT, '_methods_tree.qmd'), 'w', encoding='utf-8', newline='\n').write(deck)

js = """<script>
(function(){
 var TREE=%s, Q=%s, RES=%s;
 document.querySelectorAll('.mtree[data-interactive]').forEach(function(root){
  var path, q=root.querySelector('.mtree-q'), opts=root.querySelector('.mtree-opts'), msg=root.querySelector('.mtree-msg'),
      back=root.querySelector('.mt-back'), reset=root.querySelector('.mt-reset');
  function $(id){return root.querySelector('[id="'+id+'"]');}
  function render(){
   root.querySelectorAll('.mt-node,.mt-edge').forEach(function(e){e.classList.remove('on','current','result','next','taken');});
   var cur=path[path.length-1], visited=path.map(function(p){return p.node;});
   path.forEach(function(p){ var n=$('n-'+p.node); if(n)n.classList.add('on'); if(p.edge){var ed=$('e-'+p.edge); if(ed)ed.classList.add('on','taken'); var t=$('n-'+p.to); if(t)t.classList.add('on');} });
   var node=cur.to||cur.node, tn=$('n-'+node); if(tn)tn.classList.add('on');
   opts.innerHTML=''; msg.innerHTML='';
   if(TREE[node]){
    tn.classList.add('current'); q.textContent=Q[node];
    TREE[node].opts.forEach(function(o){
     var ed=$('e-'+o.edge); if(ed)ed.classList.add('next');
     var b=document.createElement('button'); b.type='button'; b.className='mt-go'; b.textContent=o.label;
     b.addEventListener('click',function(){choose(node,o);}); opts.appendChild(b);
    });
   } else {
    tn.classList.add('result'); q.textContent='Result';
    var r=RES[node]; msg.innerHTML='<strong>'+r[0]+'.</strong> '+r[1];
   }
   back.disabled=path.length<2;
  }
  function choose(node,o){ path[path.length-1]={node:node,edge:o.edge,to:o.to}; path.push({node:o.to}); render(); }
  root.addEventListener('click',function(ev){
   var ed=ev.target.closest('.mt-edge.next'); if(!ed)return;
   var node=path[path.length-1].node, o=TREE[node].opts.filter(function(x){return x.edge===ed.id.slice(2);})[0];
   if(o)choose(node,o);
  });
  back.addEventListener('click',function(){ if(path.length>1){path.pop(); var l=path[path.length-1]; delete l.edge; delete l.to; render();} });
  reset.addEventListener('click',function(){ path=[{node:'q0'}]; render(); });
  path=[{node:'q0'}]; render();
 });
})();
</script>
""" % (json.dumps(tree), json.dumps(question), json.dumps({k: list(v) for k, v in RESULT.items()}))
open(os.path.join(OUT, '_day2_session3_review_interactions.html'), 'w', encoding='utf-8', newline='\n').write(js)

# ---- static page --------------------------------------------------------------
rows = ''.join(f'<tr><th>{esc(RESULT[k][0])}</th><td>{esc(RESULT[k][1])}</td></tr>' for k in ['m_rct', 'm_did', 'm_rdd', 'm_match', 'x_none'])
page = f"""<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Which method fits? A decision tree</title>
<style>{CSS}
body{{margin:0;padding:24px 32px;background:#fff;color:#111418;font-family:{FONT}}}
h1{{font-size:28px;color:#063360;margin:0 0 4px}} p.lead{{margin:0 0 14px;color:#545860;font-size:16px}}
table.leg{{border-collapse:collapse;margin-top:14px;font-size:15px;width:100%}}
table.leg th,table.leg td{{border:1px solid #D5DEE8;padding:6px 10px;text-align:left;vertical-align:top}} table.leg th{{background:#E4EBF3;width:24%;color:#063360}}
.foot{{font-size:13px;color:#545860;margin-top:10px}}
@media print{{@page{{size:A4 landscape;margin:10mm}} body{{padding:0}} h1{{font-size:22px}} table.leg{{font-size:12px}}}}
</style></head><body>
<h1>Which method fits? A decision tree for four impact evaluation methods</h1>
<p class="lead">Start at the top and answer each question for the evaluation you are reading or commissioning. GreenWaste training, Module 2, October 2026.</p>
<div class="mtree">{svg(LABEL)}</div>
<table class="leg"><tbody>{rows}</tbody></table>
<p class="foot">The tree covers the four methods taught in this module. Other designs exist; the questions point to the assumption each method rests on, not to a guarantee that the method was done well. Print this page (landscape) to save it as a PDF.</p>
</body></html>
"""
open(os.path.join(OUT, 'methods_decision_tree.html'), 'w', encoding='utf-8', newline='\n').write(page)
standalone = svg(LABEL).replace('<svg ', '<svg xmlns="http://www.w3.org/2000/svg" ', 1).replace('<defs>', '<style>' + CSS.replace('.mtree ', '') + '</style><defs>', 1)
open(os.path.join(OUT, 'methods_decision_tree.svg'), 'w', encoding='utf-8', newline='\n').write(standalone)
print('written to', OUT)
