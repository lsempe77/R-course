"""Build the separate review worksheet and comparison hub, never production decks."""
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
template=(ROOT/'Oct12_session3_review_worksheet.qmd').read_text(encoding='utf-8')
header=template.split("```{r, include=FALSE}")[0].replace('GreenWaste pilot: evidence and recommendation','GreenWaste city: what was the extra change?')
header=header.replace('</style>','''
        .trend-pair{display:grid;grid-template-columns:1fr 1fr;gap:12px}.trend-pair .review-svg{height:155px}.visual-reference .review-svg{height:185px}.visual-reference .trend-pair .review-svg{height:155px}.visual-reference .interval-figure .review-svg{height:135px}.blank-chart .review-svg{height:165px}.reading-table{font-size:13px}.reading-table td,.reading-table th{padding:6px}.source-note{font-size:12px}.source-page p{margin:6px 0}.source-page h3{margin:10px 0 5px}@media print{.source-page{font-size:10.5pt}.reading-table{font-size:9pt}.reading-table td,.reading-table th{padding:5px}.source-note{font-size:9pt}}
        </style>''')
body='''
```{r, include=FALSE}
source('day2_session1_review.R', encoding='UTF-8')
```

<header><p>Separate Day 2 Session 1 review worksheet.</p><button onclick="window.print()">Print worksheet</button></header>

<div class="sheet-page source-page">

## Page 1 | H4-A: city DiD study extract

**GreenWaste is a fictional training case.** This supplied extract is the source; there is no separate report to find.

### SECTION1 | Who, what and when?

GreenWaste provides equipment subsidies, installation help and staff training. The city study follows **10,000 businesses**: **4,794 participants** and **5,206 others**. Eligibility followed an efficiency-score rule, **not a lottery**. Annual waste cost in **AED per business** was recorded once before and once **12 months after**. These are city records, not the separate 400-business pilot.

### SECTION2 | What was compared?

Participants' mean costs went from **1,432 to 763 AED** (change **-669**). Others went from **2,258 to 2,401 AED** (change **+143**). Difference-in-differences (DiD) subtracts the other-group change from the participant change: about **-812 AED**. Calculations use unrounded records. This is the **extra recorded reduction**, not the participant group's own change or the after-only gap.

```{r, results='asis'}
html_out(d4_regression())
```

### SECTION3 | What is needed for a causal reading?

**Parallel trends** means that without GreenWaste the groups would have had the same mean cost change over this period. They need not start at equal cost levels. Under this assumption, participants' untreated after-cost would be about **1,575 AED**, not their observed 763. Comparable measurement, stable group composition and no important programme effects on the comparison group also matter. A competing change affecting the groups differently could undermine the reading.

### SECTION4 | What can this file establish?

One before measure cannot show earlier trends. The A/B histories on page 2 are hypothetical, not additional observations. The **95% extra-reduction interval is 792-833 AED**, conditional on the model; statistical precision does not verify parallel trends. Both estimate and interval are below the fictional **1,000 AED annual-saving minimum**. This table alone does not establish national effects or value for money; full programme costs are not provided.

<div class="source-note">Source: corrected evaluation_data_GreenWaste_simple.csv, city records; day2_session1_review.R. Regression uses the same businesses at both waves and business-clustered robust uncertainty. Paragraphs and table above are the material to inspect.</div>

</div>

<div class="sheet-page visual-reference">

## Page 2 | H4-A: visual reference

### Observed means and an assumed untreated path

```{r, results='asis'}
html_out(d4_lines(TRUE))
```

Solid lines join observed means. The dashed participant path is **assumed under parallel trends**. The programme-start marker is between waves, not an extra measurement or precise date.

### A and B: hypothetical earlier histories

```{r, results='asis'}
html_out(paste0('<div class="trend-pair"><div><strong>A</strong>',d4_trend(1),'</div><div><strong>B</strong>',d4_trend(2),'</div></div>'))
```

Identical scales, all before the programme. Different starting levels can coexist with similar changes. **Neither history is in the GreenWaste file.**

### Extra reduction compared with the rule

<div class="interval-figure">
```{r, results='asis'}
html_out(d4_interval())
```
</div>

The interval concerns uncertainty in the mean extra reduction under the model, not the savings of every individual business or every source of bias.

</div>

<div class="sheet-page">

## Page 3 | Q1-Q2: work as concepts are taught

### Q1 | Four numbers, two changes, one extra change

Use H4-A SECTION2 (page 1). Calculate **after minus before** in each row.

| Group | Before AED | After AED | Change AED |
|---|---|---|---|
| Participants | 1,432 | 763 | __________ |
| Others | 2,258 | 2,401 | __________ |

Participant change minus other-group change: __________________

Label the four observed means and connect each group's points. After the dashed-path explanation, add the assumed participant outcome and label it **assumed**.

<div class="blank-chart">
```{r, results='asis'}
html_out(d4_lines(blank=TRUE))
```
</div>

### Q2 | Find the extra change in the regression

Circle its row on page 1. Explain the sign, units, comparison and population in your own words.

<div class="writing tall"></div>

What does each of the other three rows describe? Why is the interaction not the participants' own -669 AED change?

<div class="writing tall"></div>

</div>

<div class="sheet-page">

## Page 4 | Q3-Q4: credibility and advice

### Q3 | What would have changed without GreenWaste?

Use H4-A SECTION3-4 (page 1) and page 2's figures. State parallel trends in this case without saying the groups must start at the same level.

<div class="writing"></div>

Which hypothetical history, A or B, makes you hesitate? Explain the feature. What does the more reassuring history still not prove?

<div class="writing"></div>

Can the actual file show earlier trends? Request specific evidence about earlier costs or a competing change, and explain why it matters.

<div class="writing tall"></div>

### Q4 | Some reduction, or enough reduction?

Use the interval on page 2. Where are the estimate and interval relative to 1,000 AED? What does a narrow interval leave unresolved?

<div class="writing"></div>

### Source check, then your independent reading

In H4-A, circle the interaction and interval, underline the assumption and mark the data limit. Check your annotations with a partner.

For the final task, keep **H4-A open** but close AI responses and peer comments. Write one supported interpretation and one specific evidence request. How could the answer change your advice?

<div class="writing tall"></div>

</div>

<div class="sheet-page">

## Page 5 | AI Snapshot: numbers and assurance

An authored practice response to: **Explain the regression table to a policy adviser considering GreenWaste expansion. Say what they should check.** It mixes accurate readings with questionable conclusions. Do not run this first prompt.

<div class="ai-source">
```{r, results='asis'}
html_out(d4_paragraphs(d4_ai))
```
</div>

Underline support and cross out overclaims. Check **H4-A on page 1**, not whether the prose sounds confident.

### Better prompt: run and compare

<div class="prompt">
```{r, results='asis'}
html_out(d4_paragraphs(d4_prompt))
```
</div>

Copy this prompt and H4-A into **Microsoft Copilot**. Use your AI good-practice card. If unavailable, compare page 6's prepared response.

Which claim improved? What still needs checking against the source?

<div class="writing"></div>

</div>

<div class="sheet-page">

## Page 6 | Prepared response: paper alternative

Use this for the same source-comparison task if Copilot is unavailable. This is an authored response to the better prompt, **not additional study evidence**.

<div class="ai-source">
```{r, results='asis'}
html_out(d4_paragraphs(d4_fallback))
```
</div>

### Check the response, even when it sounds careful

Match its numerical claims to H4-A SECTION2/table. Match conditions and missing evidence to SECTION3-4. Does it distinguish comparison, causal credibility and the decision rule?

<div class="writing tall"></div>

Compare with page 5. Which unsupported assurance has been removed? Could any remaining wording be clearer?

<div class="writing tall"></div>

Now return to page 4 for **your own** interpretation and evidence request, with AI responses closed.

</div>
'''
for i in range(1,5):body=body.replace('SECTION'+str(i),chr(167)+str(i))
(ROOT/'Oct13_session1_review_worksheet.qmd').write_text(header+body,encoding='utf-8')
hub=(ROOT/'session3_compare.html').read_text(encoding='utf-8')
hub=hub.replace('Session 3','Day 2 Session 1').replace('Oct12_session3','Oct13_session1')
hub=hub.replace('<a href="Oct13_session1_review_slips.html" target="_blank" rel="noopener">Open printable age slips</a> &middot; ','')
start=hub.index('<button data-pair=');end=hub.index('\n</nav>',start)
hub=hub[:start]+'''<button data-pair="1,1">City recap</button><button data-pair="2,2">Observed changes</button><button data-pair="3,3">Four numbers</button><button data-pair="4,5">Regression</button><button data-pair="5,6">Assumed path</button><button data-pair="6,8">Earlier histories</button><button data-pair="7,9">Data limit</button><button data-pair="8,11">Source reading</button><button data-pair="9,12">AI reading</button><button data-pair="10,14">Close</button>'''+hub[end:]
hub=hub.replace('13 content slides','10 content slides').replace('existing 75-minute','existing 60-minute').replace('16 content slides','14 content slides').replace('120-minute','90-minute')
hub=hub.replace(', including its original internal break','')
(ROOT/'day2_session1_compare.html').write_text(hub,encoding='utf-8')
