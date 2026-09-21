import sys

src = "/mnt/user-data/uploads/R-course/Module_2_Oct_2026_v2/Oct12_session2.qmd"
dst = "/mnt/user-data/outputs/Oct12_session2_v2.qmd"

with open(src, encoding="utf-8") as f:
    t = f.read()

edits = []  # (label, old, new)

# ---- Edit A1: load qrcode ---------------------------------------------------
edits.append((
    "A1 load qrcode",
    'library(estimatr)   # lm_robust, clustered standard errors\n',
    'library(estimatr)   # lm_robust, clustered standard errors\n'
    'library(qrcode)     # live poll QR, generated below so it cannot drift\n',
))

# ---- Edit A2: Menti setup block ---------------------------------------------
edits.append((
    "A2 menti setup",
    'tlev <- function(x) factor(x, levels = c("Before", "After"))\n\n'
    '# ---- Session 2: the traffic camera programme -------------------------------',
    'tlev <- function(x) factor(x, levels = c("Before", "After"))\n\n'
    '# ---- Live Menti poll -------------------------------------------------------\n'
    '# ONE place to set the join code. The QR and printed link on the vote slide\n'
    '# and the results iframe on the reveal slide all read from here: change\n'
    '# MENTI_CODE only and all three move together.\n'
    '#\n'
    '# PLACEHOLDER until this session\'s Menti is built. MENTI_CODE is the short\n'
    '# JOIN code participants type at menti.com (usually 8 digits), NOT the long\n'
    '# ID in the editor URL. Confirm it while the Menti is live: a code that is\n'
    '# not running sends the room to a "no longer active" page.\n'
    'MENTI_CODE  <- "1234 5678"   # <!-- PLACEHOLDER: this session\'s join code -->\n'
    'MENTI_JOIN  <- paste0("https://www.menti.com/", gsub(" ", "", MENTI_CODE))\n'
    '\n'
    '# The results embed: the SLIDES view for a webpage, not the voting view (the\n'
    '# room still votes on their phones). Set to the long ID from the editor URL.\n'
    'MENTI_EMBED <- "https://www.mentimeter.com/app/presentation/PLACEHOLDER/embed"  # <!-- PLACEHOLDER -->\n'
    '\n'
    '# Distinct filename so this QR never overwrites Session 1\'s menti_qr.png.\n'
    'menti_qr <- function(path = "menti_qr_s2.png", url = MENTI_JOIN) {\n'
    '  png(path, width = 900, height = 900, res = 300, bg = "white")\n'
    '  on.exit(dev.off(), add = TRUE)\n'
    '  par(mar = c(0, 0, 0, 0))\n'
    '  plot(qr_code(url, ecl = "H"))   # ecl H = highest error correction\n'
    '  path\n'
    '}\n'
    'MENTI_QR <- menti_qr()\n\n'
    '# ---- Session 2: the traffic camera programme -------------------------------',
))

# ---- Edit B: convert the [MENTI PLACEHOLDER] vote slide ---------------------
edits.append((
    "B vote slide",
    '## `[MENTI PLACEHOLDER]` Would you fund the extension?\n'
    '\n'
    '::: {.ask}\n'
    'On the number you have just seen: **would you commit the money?**\n'
    '\n'
    'Yes &nbsp;·&nbsp; No &nbsp;·&nbsp; Not on this alone\n'
    ':::\n'
    '\n'
    '::: {.panel}\n'
    'Commit before we look further. This is the same poll shape as Session 1, and it\n'
    'worked there for the same reason: the room has to hold a position before it can\n'
    'feel it move.\n'
    ':::',
    '## Would you fund the extension?\n'
    '\n'
    ':::::: {.columns}\n'
    '\n'
    '::::: {.column width="62%"}\n'
    '::: {.ask style="font-size: 120%;"}\n'
    'On the number you have just seen, a `r sprintf("%.0f", pol_headline_fall)`% fall\n'
    'where cameras went: **would you commit the money to extend them?**\n'
    '\n'
    'Yes &nbsp;·&nbsp; No &nbsp;·&nbsp; Not on this alone\n'
    ':::\n'
    '\n'
    'Go to **menti.com** and enter code **`r MENTI_CODE`**, or scan the code on the\n'
    'right. Commit before we look further.\n'
    ':::::\n'
    '\n'
    '::::: {.column width="38%"}\n'
    '```{r out.width=\'330px\', out.extra=\'style="display:block; margin:0 auto;"\'}\n'
    'knitr::include_graphics(MENTI_QR)\n'
    '```\n'
    ':::::\n'
    '\n'
    '::::::\n'
    '\n'
    '::: {.warn .fragment}\n'
    'Same poll shape as Session 1: the room has to hold a position before it can feel\n'
    'it move. Keep your answer in mind.\n'
    ':::',
))

# ---- Edit C: insert the results-reveal slide before "Two reasons ..." -------
edits.append((
    "C reveal slide",
    '## Two reasons the headline overstates',
    '## Look back at your vote\n'
    '\n'
    '```{r results=\'asis\'}\n'
    '# Shows the live Menti results once this session\'s Menti exists. Until\n'
    '# MENTI_EMBED is set (still a placeholder), a marked placeholder box renders\n'
    '# instead, so the deck never shows a broken iframe. data-external="1" keeps\n'
    '# embed-resources from freezing the live view into a static image.\n'
    'if (!grepl("PLACEHOLDER", MENTI_EMBED)) {\n'
    '  cat(sprintf(\'\n'
    '<iframe data-external="1" allowfullscreen="true" allowtransparency="true"\n'
    '        frameborder="0" src="%s"\n'
    '        style="width:100%%; height:66%%; border:none;"></iframe>\', MENTI_EMBED))\n'
    '} else {\n'
    '  cat(\'<div class="panel note-ctr"><strong>[PLACEHOLDER] Live Menti results.</strong> Set <code>MENTI_EMBED</code> in the setup chunk to show the room vote here.</div>\')\n'
    '}\n'
    '```\n'
    '\n'
    '::: {.warn}\n'
    'You voted on the `r sprintf("%.0f", pol_headline_fall)`% headline. The honest\n'
    'estimate is `r sprintf("%.2f", abs(pol_did))` avoided, short of the\n'
    '`r sprintf("%.1f", POL_RULE)` the rule needs. If the room leaned "yes", that is\n'
    'the headline doing the work, not the programme.\n'
    ':::\n'
    '\n'
    '## Two reasons the headline overstates',
))

# ---- Edit D: table slide -> two slides, table at top, larger, text under -----
edits.append((
    "D table slides",
    '## The table you would actually be handed\n'
    '\n'
    ':::::: {.columns}\n'
    '\n'
    '::::: {.column width="52%"}\n'
    '```{r}\n'
    'pol_tbl %>%\n'
    '  kable(align = "lrrrr", digits = 2,\n'
    '        col.names = c("", "Coef.", "Std. err.", "p", "95% CI")) %>%\n'
    '  kable_styling(full_width = FALSE, font_size = 16) %>%\n'
    '  row_spec(4, bold = TRUE, background = "#E6F1F5")\n'
    '```\n'
    ':::::\n'
    '\n'
    '::::: {.column width="48%"}\n'
    '::: {.panel}\n'
    '**Row 4 is the impact.** The interaction of programme and round: the extra change\n'
    'in the sectors that got cameras, over and above the change everywhere else.\n'
    '\n'
    '**Row 2** is the baseline difference. Cameras went to the worst roads, so they\n'
    'started higher.\n'
    ':::\n'
    '\n'
    '::: {.panel}\n'
    '**Row 3** is the national trend: what happened in the comparison sectors anyway.\n'
    '**Std. error** is the wobble.\n'
    '\n'
    'Most reports lead with their preferred number. **Find the row that is actually\n'
    'the impact.**\n'
    ':::\n'
    ':::::\n'
    '\n'
    '::::::',
    '## The table you would actually be handed\n'
    '\n'
    '```{r}\n'
    'pol_tbl %>%\n'
    '  kable(align = "lrrrr", digits = 2,\n'
    '        col.names = c("", "Coef.", "Std. err.", "p", "95% CI")) %>%\n'
    '  kable_styling(full_width = FALSE, font_size = 22) %>%\n'
    '  row_spec(4, bold = TRUE, background = "#E6F1F5") %>%\n'
    '  footnote(general = "Outcome: injury collisions per road segment per round. Standard errors clustered by road segment.",\n'
    '           general_title = "", footnote_as_chunk = TRUE)\n'
    '```\n'
    '\n'
    '::: {.panel}\n'
    '**Row 4 is the impact.** The interaction of programme and round: the extra change\n'
    'in the sectors that got cameras, over and above the change everywhere else. It is\n'
    'the one number the decision turns on.\n'
    '\n'
    'Most reports lead with their preferred number. **Find the row that is actually\n'
    'the impact**, not the one printed largest or first.\n'
    ':::\n'
    '\n'
    '## The same table: the other rows\n'
    '\n'
    '```{r}\n'
    'pol_tbl %>%\n'
    '  kable(align = "lrrrr", digits = 2,\n'
    '        col.names = c("", "Coef.", "Std. err.", "p", "95% CI")) %>%\n'
    '  kable_styling(full_width = FALSE, font_size = 22) %>%\n'
    '  row_spec(4, bold = TRUE, background = "#E6F1F5") %>%\n'
    '  footnote(general = "Outcome: injury collisions per road segment per round. Standard errors clustered by road segment.",\n'
    '           general_title = "", footnote_as_chunk = TRUE)\n'
    '```\n'
    '\n'
    '::: {.panel}\n'
    '**Row 2** is the baseline difference. Cameras went to the worst roads, so the\n'
    'programme sectors started higher. This gap is not the impact.\n'
    '\n'
    '**Row 3** is the national trend: what happened in the comparison sectors anyway.\n'
    '**Std. err.** is the wobble on each estimate: divide the coefficient by it to see\n'
    'how steady the number is.\n'
    ':::',
))

# ---- Edit E: Debrief -> .dense ---------------------------------------------
edits.append((
    "E debrief dense",
    '## Debrief\n',
    '## Debrief {.dense}\n',
))

# ---- Edit F: fix the interval chart ----------------------------------------
edits.append((
    "F interval chart",
    '```{r fig.height=2.9, fig.width=11.5}\n'
    'tibble(\n'
    '  what = factor(c("The estimate", "95% interval", "Decision rule"),\n'
    '                levels = c("Decision rule", "95% interval", "The estimate")),\n'
    '  lo   = c(pol_did, pol_did_ci[1], POL_RULE),\n'
    '  hi   = c(pol_did, pol_did_ci[2], POL_RULE),\n'
    '  pt   = c(pol_did, pol_did, POL_RULE),\n'
    '  col  = c(ACCENT, ACCENT, ALERT)\n'
    ') %>%\n'
    '  plot_ly() %>%\n'
    '  add_segments(x = ~abs(lo), xend = ~abs(hi), y = ~what, yend = ~what,\n'
    '               line = list(color = ~col, width = 5), showlegend = FALSE,\n'
    '               hovertemplate = "avoids %{x:.2f}<extra></extra>") %>%\n'
    '  add_markers(x = ~abs(pt), y = ~what, marker = list(color = ~col, size = 11),\n'
    '              showlegend = FALSE,\n'
    '              hovertemplate = "avoids %{x:.2f}<extra></extra>") %>%\n'
    '  layout(xaxis = ax("Injury collisions avoided per segment, per round",\n'
    '                    range = c(0, 2.4)),\n'
    '         yaxis = ax("", zeroline = FALSE)) %>%\n'
    '  pl_m2(height = 260)\n'
    '```\n'
    '\n'
    '::: {.warn}\n'
    'The whole interval sits to the left of the red line. This is not "we cannot\n'
    'tell": it is a clear result that falls short. **A precise answer below the bar\n'
    'is still a no.**\n'
    ':::',
    '```{r fig.height=2.6, fig.width=11.5}\n'
    '# One horizontal bar: the estimate (dot) with its 95% interval (whiskers), and\n'
    '# the decision rule as a vertical red line. That makes "the interval does not\n'
    '# reach the rule" something you can see: the whole bar sits to the line\'s left.\n'
    '# abs() flips the negative coefficient into "collisions avoided", so the CI\'s\n'
    '# lower (more negative) end becomes the higher avoided value.\n'
    'est <- abs(pol_did)\n'
    'lo  <- abs(pol_did_ci[2])   # least avoided (CI end nearer zero)\n'
    'hi  <- abs(pol_did_ci[1])   # most avoided (best case in the interval)\n'
    'plot_ly() %>%\n'
    '  add_segments(x = lo, xend = hi, y = 1, yend = 1, showlegend = FALSE,\n'
    '               line = list(color = ACCENT, width = 6), hoverinfo = "skip") %>%\n'
    '  add_markers(x = c(lo, hi), y = c(1, 1), showlegend = FALSE, hoverinfo = "skip",\n'
    '              marker = list(color = ACCENT, size = 18, symbol = "line-ns-open",\n'
    '                            line = list(color = ACCENT, width = 3))) %>%\n'
    '  add_markers(x = est, y = 1, showlegend = FALSE,\n'
    '              marker = list(color = ACCENT, size = 16),\n'
    '              hovertemplate = "estimate %{x:.2f} avoided<extra></extra>") %>%\n'
    '  layout(\n'
    '    shapes = list(list(type = "line", x0 = POL_RULE, x1 = POL_RULE,\n'
    '                       y0 = 0.4, y1 = 1.6, xref = "x", yref = "y",\n'
    '                       line = list(color = ALERT, width = 3, dash = "dash"))),\n'
    '    annotations = list(\n'
    '      list(x = POL_RULE, y = 1.68, xref = "x", yref = "y", showarrow = FALSE,\n'
    '           text = sprintf("Decision rule: %.1f", POL_RULE),\n'
    '           font = list(color = ALERT, size = 14), xanchor = "middle"),\n'
    '      list(x = est, y = 0.66, xref = "x", yref = "y", showarrow = FALSE,\n'
    '           text = sprintf("estimate %.2f", est),\n'
    '           font = list(color = INK, size = 13), xanchor = "middle")),\n'
    '    xaxis = ax("Injury collisions avoided per segment, per round",\n'
    '               range = c(0, 2.4)),\n'
    '    yaxis = list(range = c(0.4, 1.9), showticklabels = FALSE,\n'
    '                 showgrid = FALSE, zeroline = FALSE)) %>%\n'
    '  pl_m2(height = 260)\n'
    '```\n'
    '\n'
    '::: {.warn}\n'
    '**How to read it:** the blue dot is the estimate, `r sprintf("%.2f", abs(pol_did))`\n'
    'collisions avoided, and the blue bar is its 95% interval,\n'
    '`r sprintf("%.2f", abs(pol_did_ci[2]))` to `r sprintf("%.2f", abs(pol_did_ci[1]))`.\n'
    'The red dashed line is the rule: `r sprintf("%.1f", POL_RULE)`. The whole bar sits\n'
    'to its left, so even the best case falls short. This is not "we cannot tell": it\n'
    'is a clear result below the bar, and **a precise answer below the bar is still a\n'
    'no.**\n'
    ':::',
))

# Apply, asserting each anchor is found exactly once.
for label, old, new in edits:
    n = t.count(old)
    if n != 1:
        print(f"FAIL [{label}]: expected 1 match, found {n}")
        sys.exit(1)
    t = t.replace(old, new)
    print(f"OK   [{label}]")

with open(dst, "w", encoding="utf-8") as f:
    f.write(t)

print("WROTE", dst, len(t), "chars")
