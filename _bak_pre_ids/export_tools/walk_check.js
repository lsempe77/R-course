const { chromium } = require('playwright');
(async () => {
  const [url, out] = [process.argv[2], process.argv[3]];
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: 1280, height: 720 } });
  const errs = [];
  p.on('pageerror', e => errs.push('PAGEERROR ' + e.message.slice(0, 150)));
  p.on('console', m => { if (m.type() === 'error') errs.push('CONSOLE ' + m.text().slice(0, 150)); });
  await p.goto(url);
  await p.waitForTimeout(40000);
  const n = await p.evaluate(() => Reveal.getTotalSlides());
  for (let i = 0; i < n; i++) {
    await p.evaluate(i => { const sl = Reveal.getSlides()[i]; const ix = Reveal.getIndices(sl); Reveal.slide(ix.h, ix.v); }, i);
    // show all fragments
    await p.evaluate(() => { const s = Reveal.getCurrentSlide(); s.querySelectorAll('.fragment').forEach(f => f.classList.add('visible')); });
    await p.waitForTimeout(800);
    const nr = await p.evaluate(() => { const b = [...Reveal.getCurrentSlide().querySelectorAll('.exercise-editor-btn-run-code')]; b.forEach(x => x.click()); return b.length; });
    if (nr) await p.waitForTimeout(16000); else await p.waitForTimeout(1500);
    const info = await p.evaluate(() => {
      const s = Reveal.getCurrentSlide();
      const sr = s.getBoundingClientRect();
      const scale = sr.width / 1280; let maxB = 0;
      s.querySelectorAll('*').forEach(e => { const r = e.getBoundingClientRect(); if (r.height > 0 && getComputedStyle(e).visibility !== 'hidden') maxB = Math.max(maxB, r.bottom); });
      const outs = [...s.querySelectorAll('.cell-output-webr')].map(o => o.innerText.replace(/\s+/g, ' ').slice(0, 140) + (o.querySelector('img,canvas') ? ' [plot]' : ''));
      return { h2: (s.querySelector('h2,h1')?.innerText || '').slice(0, 50), over: Math.round((maxB - sr.top) / scale - 720), outs };
    });
    console.log(`#${i} ${info.h2} | over=${info.over}${info.outs.length ? ' | ' + info.outs.join(' || ') : ''}`);
    await p.screenshot({ path: `${out}/s${String(i).padStart(2, '0')}.png` });
  }
  console.log(errs.slice(0, 15).join('\n'));
  await b.close();
})();
