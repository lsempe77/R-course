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
 'qcut': dict(kind='q', x=850, y=108, w=340, h=80,  wrap=28, text='Did a score or cut-off decide who could take part?'),
 'q2':   dict(kind='q', x=850, y=245, w=340, h=100, wrap=27, text='Do we have, or can we collect, before and after data for participants and a comparison group?'),
 'q3':   dict(kind='q', x=850, y=385, w=340, h=100, wrap=27, text='Would participant and comparison outcomes likely follow similar paths without the programme?'),
 'qobs': dict(kind='q', x=420, y=270, w=330, h=96,  wrap=26, text='Do the recorded characteristics explain who took part, with nothing important missing?'),
 'm_rct':   dict(kind='m', x=15,  y=525, w=170, h=72, title='Lottery', sub='Randomised trial'),
 'm_rdd':   dict(kind='m', x=560, y=160, w=190, h=72, title='Regression discontinuity', sub='Day 2 Session 2'),
 'm_match': dict(kind='m', x=490, y=525, w=190, h=72, title='Matching', sub='Day 2 Session 3'),
 'm_did':   dict(kind='m', x=910, y=525, w=220, h=72, title='Difference-in-differences', sub='Day 2 Session 1'),
 'x_none':  dict(kind='x', x=170, y=265, w=170, h=110, title='No credible comparison', sub='Ask for another design or more data'),
}

# edges: id, from, to, label, polyline points, label centre
E = [
 ('q0>q1',   'q0','q1','Before',[(370,39),(180,39),(180,107)],(290,39)),
 ('q0>qcut', 'q0','qcut','After',[(830,39),(1020,39),(1020,108)],(910,39)),
 ('q1>m_rct','q1','m_rct','Yes',[(100,203),(100,525)],(100,365)),
 ('q1>qcut', 'q1','qcut','No',  [(340,128),(850,128)],(595,128)),
 ('qcut>m_rdd','qcut','m_rdd','Yes',[(850,170),(750,170)],(800,170)),
 ('qcut>q2', 'qcut','q2','No',  [(1020,188),(1020,245)],(1058,216)),
 ('q2>q3',   'q2','q3','Yes',   [(1020,345),(1020,385)],(1058,365)),
 ('q2>qobs', 'q2','qobs','No',  [(850,295),(750,295)],(800,295)),
 ('q3>m_did','q3','m_did','Yes',[(1020,485),(1020,525)],(1058,505)),
 ('q3>qobs', 'q3','qobs','No',  [(850,435),(790,435),(790,345),(750,345)],(820,435)),
 ('qobs>m_match','qobs','m_match','Yes',[(585,366),(585,525)],(585,445)),
 ('qobs>x_none','qobs','x_none','No',[(420,318),(340,318)],(380,318)),
]

RESULT = {
 'm_rct':   ('Lottery (randomised trial)', 'Groups were assigned by chance. Ask how the draw was done and who dropped out.'),
 'm_did':   ('Difference-in-differences', 'Compares the change in participants with the change in a comparison group. Ask whether earlier measurements show similar paths.'),
 'm_rdd':   ('Regression discontinuity', 'Compares participants just either side of the cut-off. It describes those near the cut-off. Ask whether the result holds in a wider window.'),
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
.mtree .mtree-note{{font-size:15px;line-height:1.35;color:#545860;margin:10px 0 0}}
.mtree .mtree-btns{{display:flex;gap:10px;flex-wrap:wrap;justify-content:flex-end}}
.mtree button{{font:inherit;font-size:22px;padding:6px 20px;border:2px solid #063360;background:#fff;color:#063360;border-radius:6px;cursor:pointer}}
.mtree button.mt-go{{background:#215a9e;color:#fff;border-color:#215a9e}}
.mtree button:disabled{{opacity:.35;cursor:default}}
"""

DISCLAIMER = ('This tree is a starting guide. It helps you think through what each method needs and what would make it impossible. '
              'The order of questions follows how credible each method usually is, but other methods can still be possible: '
              'for example, with earlier data and no cut-off you could still plan a difference-in-differences. '
              'Every method also needs enough data and a large enough sample, especially when choosing between two options such as regression discontinuity and difference-in-differences. '
              'Evaluations are best planned before any data exist, whichever method is chosen.')

CARDS = [
 ('Lottery (randomised trial)',
  'Assign who gets the programme by chance, before it starts.',
  'Programme already running, must cover everyone, or the groups cannot be kept apart.',
  'Rollout is phased or places are limited, so a draw can decide who goes first.'),
 ('Regression discontinuity',
  'A score and cut-off that decided who took part, and enough units near the cut-off.',
  'No score or rule, a cut-off that was not followed, or scores that could be gamed.',
  'Eligibility is not set yet, so a score and cut-off can decide who joins.'),
 ('Difference-in-differences',
  'Outcome measured before and after, for participants and a comparison group on a similar path.',
  'No comparison group, no way to measure before, or groups already on different paths.',
  'Earlier data or a cut-off are missing: plan a baseline and follow-up for both groups.'),
 ('Matching',
  'Recorded characteristics that explain who took part, and similar non-participants.',
  'Take-up driven by something unrecorded, such as motivation, or no similar non-participants.',
  'Collect the key characteristics for both groups; combine with the before and after data if they exist.'),
]
CARD_ROWS = ['What it needs', 'What rules it out', 'Can still be planned if']
CARD_NOTE = 'Several methods can be possible at once. Each also needs enough data and a large enough sample, so planning early keeps more options open.'

def cards_table(cls):
    head = '<tr><th></th>' + ''.join(f'<th>{esc(c[0])}</th>' for c in CARDS) + '</tr>'
    body = ''.join('<tr><th class="rl">' + CARD_ROWS[r] + '</th>' + ''.join(f'<td>{esc(c[r+1])}</td>' for c in CARDS) + '</tr>' for r in range(3))
    return f'<table class="{cls}">{head}{body}</table>'

CARDS_CSS = f"""
table.mcards{{border-collapse:collapse;width:100%;font-family:{FONT}}}
table.mcards th,table.mcards td{{border:1px solid #D5DEE8;padding:8px 12px;text-align:left;vertical-align:top;line-height:1.3}}
table.mcards thead th,table.mcards tr:first-child th{{background:#215a9e;color:#fff;font-weight:700}}
table.mcards th.rl{{background:#E4EBF3;color:#063360;width:14%;font-weight:700}}
table.mcards td{{background:#fff;color:#111418}}
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
         'Otherwise, or after: difference-in-differences needs before and after data (existing or planned) and similar paths; '
         'regression discontinuity needs a score cut-off; matching needs recorded characteristics that explain who took part; '
         'otherwise there is no credible comparison yet.')

# ---- deck fragment ----------------------------------------------------------
tree = {i: {'opts': [{'label': e[3], 'to': e[2], 'edge': e[0]} for e in E if e[1] == i]} for i in N if N[i]['kind'] == 'q'}
question = {i: N[i]['text'] for i in N if N[i]['kind'] == 'q'}

deck = ('```{=html}\n<style>' + CSS + '.reveal .mtree svg{max-width:900px}.reveal .mtree .mtree-q{font-size:24px}.reveal .mtree .mtree-msg{font-size:21px}.reveal .mtree button{font-size:20px;padding:4px 16px}.reveal .mtree .mtree-note{font-size:15px;line-height:1.3;color:#545860;margin:8px 0 0;text-align:left}</style>\n'
        '<div class="mtree" data-interactive id="mtree">' + svg(LABEL) +
        '<div class="mtree-ctl"><div class="mtree-q" aria-live="polite"></div>'
        '<div class="mtree-btns"><button class="mt-back" type="button">Back</button><button class="mt-reset" type="button">Start over</button></div>'
        '<div class="mtree-opts mtree-btns" style="grid-column:1/-1;justify-content:flex-start"></div>'
        '<div class="mtree-msg" aria-live="polite"></div></div>'
        '<p class="mtree-note">' + DISCLAIMER + '</p></div>\n```\n')
cards_deck = ('```{=html}\n<style>' + CARDS_CSS + '.reveal table.mcards{font-size:18px}.reveal table.mcards th,.reveal table.mcards td{padding:8px 12px}.reveal p.mcards-note{font-size:20px;color:#063360;margin:12px 0 0;text-align:left}</style>\n'
              + cards_table('mcards') + '<p class="mcards-note">' + CARD_NOTE + '</p>\n```\n')
open(os.path.join(OUT, '_methods_cards.qmd'), 'w', encoding='utf-8', newline='\n').write(cards_deck)
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
<style>{CSS}{CARDS_CSS}
.cardpage{{margin-top:28px}}
body{{margin:0;padding:24px 32px;background:#fff;color:#111418;font-family:{FONT}}}
h1{{font-size:28px;color:#063360;margin:0 0 4px}} p.lead{{margin:0 0 14px;color:#545860;font-size:16px}}
table.leg{{border-collapse:collapse;margin-top:14px;font-size:15px;width:100%}}
table.leg th,table.leg td{{border:1px solid #D5DEE8;padding:6px 10px;text-align:left;vertical-align:top}} table.leg th{{background:#E4EBF3;width:24%;color:#063360}}
.foot{{font-size:13px;color:#545860;margin-top:10px}}
@media print{{.cardpage{{page-break-before:always;margin-top:0}} table.mcards{{font-size:15px}} @page{{size:A4 landscape;margin:10mm}} body{{padding:0}} h1{{font-size:20px}} p.lead{{font-size:12px;margin-bottom:6px}} .mtree svg{{width:74%}} .mtree-note{{font-size:11px!important;margin-top:6px!important;padding:4px 10px!important}} table.leg{{font-size:11px;margin-top:8px}} table.leg th,table.leg td{{padding:3px 8px}} .foot{{font-size:10px;margin-top:6px}}}}
</style></head><body>
<h1>Which method fits? A decision tree for four impact evaluation methods</h1>
<p class="lead">Start at the top and answer each question for the evaluation you are reading or commissioning. GreenWaste training, Module 2, October 2026.</p>
<div class="mtree">{svg(LABEL)}</div>
<p class="mtree-note" style="border-left:4px solid #215a9e;padding:6px 12px;background:#E4EBF3;color:#111418;font-size:15px;margin:12px 0 0">{DISCLAIMER}</p>
<table class="leg"><tbody>{rows}</tbody></table>
<div class="cardpage"><h1>What each method needs, and when it can still be planned</h1><p class="lead">Several methods can be possible at once. Use the cards to check the needs and what would rule a method out.</p>{cards_table('mcards')}<p class="mtree-note" style="margin-top:12px">{CARD_NOTE}</p></div>
<p class="foot">The tree covers the four methods taught in this module. Other designs exist; the questions point to the assumption each method rests on, not to a guarantee that the method was done well. Print this page (landscape) to save it as a PDF.</p>
</body></html>
"""
open(os.path.join(OUT, 'methods_decision_tree.html'), 'w', encoding='utf-8', newline='\n').write(page)
standalone = svg(LABEL).replace('<svg ', '<svg xmlns="http://www.w3.org/2000/svg" ', 1).replace('<defs>', '<style>' + CSS.replace('.mtree ', '') + '</style><defs>', 1)
open(os.path.join(OUT, 'methods_decision_tree.svg'), 'w', encoding='utf-8', newline='\n').write(standalone)
print('written to', OUT)
