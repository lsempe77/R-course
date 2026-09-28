// Capture every slide of a deck as a JPEG, with all fragments shown and every
// live R cell run, plus its title and speaker notes (slides.json).
//   node capture.js <url> <outdir>
const { chromium } = require('playwright');
const fs = require('fs');
(async () => {
  const [url, out] = [process.argv[2], process.argv[3]];
  fs.mkdirSync(out, { recursive: true });
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: 1280, height: 720 }, deviceScaleFactor: 1.5 });
  await p.goto(url);
  await p.waitForFunction(() => window.Reveal && Reveal.isReady(), null, { timeout: 60000 });
  await p.evaluate(() => Reveal.configure({ controls: false, progress: false, transition: 'none' }));
  await p.addStyleTag({ content: '.slide-menu-button, .reveal .slide-menu-button, .quarto-reveal-menu { display: none !important; }' });
  await p.waitForTimeout(parseInt(process.env.WAIT || '40000'));   // webR and packages load
  const n = await p.evaluate(() => Reveal.getTotalSlides());
  const meta = [];
  for (let i = 0; i < n; i++) {
    await p.evaluate(i => { const sl = Reveal.getSlides()[i]; const ix = Reveal.getIndices(sl); Reveal.slide(ix.h, ix.v); }, i);
    await p.evaluate(() => Reveal.getCurrentSlide().querySelectorAll('.fragment').forEach(f => f.classList.add('visible')));
    await p.waitForTimeout(700);
    const nr = await p.evaluate(() => { const b = [...Reveal.getCurrentSlide().querySelectorAll('.exercise-editor-btn-run-code')]; b.forEach(x => x.click()); return b.length; });
    // wait for live output (or a fixed pause for slides without run buttons)
    if (nr) {
      for (let t = 0; t < 30; t++) {
        await p.waitForTimeout(1000);
        const busy = await p.evaluate(() => [...Reveal.getCurrentSlide().querySelectorAll('.exercise-editor-btn-run-code')]
          .some(x => x.disabled || x.querySelector('.spinner-grow, .spinner-border')));
        const outs = await p.evaluate(() => Reveal.getCurrentSlide().querySelectorAll('.cell-output-webr').length);
        if (!busy && outs > 0 && t >= 3) break;
      }
      await p.waitForTimeout(1500);
    } else {
      await p.waitForTimeout(1200);
    }
    const info = await p.evaluate(() => {
      const s = Reveal.getCurrentSlide();
      const notes = s.querySelector('aside.notes');
      return { title: (s.querySelector('h1,h2')?.innerText || '').trim(), notes: notes ? notes.innerText.trim() : '' };
    });
    const file = `s${String(i + 1).padStart(3, '0')}.jpg`;
    await p.screenshot({ path: `${out}/${file}`, type: 'jpeg', quality: 85 });
    meta.push({ file, ...info });
  }
  fs.writeFileSync(`${out}/slides.json`, JSON.stringify(meta, null, 1));
  console.log(`${url}: ${n} slides`);
  await b.close();
})().catch(e => { console.log('FAILED ' + process.argv[2] + ' ' + e.message); process.exit(1); });
