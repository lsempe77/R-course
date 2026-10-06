# ===========================================================================
# Print materials for all twelve sessions
# ===========================================================================
#   source("make_session_materials.R")
#
# Writes one Word pack per session into this folder, <deck>_materials.docx:
#   Lucas's six live sessions first (Oct12 S1, Oct12 S3, Oct13 S2, Oct14 S1,
#   Oct14 S3, Oct15 S2), then Fiona's six (Oct12 S2, Oct13 S1, Oct13 S3,
#   Oct14 S2, Oct15 S1, Oct15 S3).
#
# Every number is computed here from the same CSVs the live decks read, so
# the paper cannot disagree with the screen. Each item starts with a print
# line (how many copies, cut or not). The facilitator key is the last item of
# each pack; print it for the trainer only.
#
# Editing a .docx by hand is overwritten on the next run: change this file.
# Materials that already exist and are generated elsewhere are not repeated:
#   Oct14_session3_qa_checklist.docx (qa_checklist.R)
#   Oct15_session2_findings.docx, Oct15_session2_brief_template.docx (qa_translation.R)
#   Oct15_session1_report.docx (quarto render Oct15_session1_report.qmd)
# Oct15 S1's rating sheet and Oct15 S3's design template now live in their
# packs here, so Oct15_session1_rating_sheet.qmd and
# Oct15_session3_design_template.qmd are retired.

suppressPackageStartupMessages({
  library(officer)
  library(flextable)
})

FONT  <- "Arial"
BLUE  <- "#215a9e"; DARK <- "#063360"; LIGHT <- "#7da1c4"; GREY <- "#545860"; RED <- "#B8272C"
set_flextable_defaults(font.family = FONT, font.size = 10.5, padding = 4,
                       border.color = "#9AA8B8")

cut_line  <- fp_border(color = "#9AA8B8", style = "dashed", width = 1)
thin_line <- fp_border(color = "#9AA8B8", width = 0.75)

# ---- small building blocks -------------------------------------------------
new_pack <- function() {
  read_docx() |>
    body_set_default_section(prop_section(
      page_size = page_size(orient = "portrait"),
      page_margins = page_mar(top = 0.7, bottom = 0.7, left = 0.8, right = 0.8)))
}
txt <- function(x, size = 11, bold = FALSE, italic = FALSE, color = "black")
  ftext(x, fp_text(font.family = FONT, font.size = size, bold = bold, italic = italic, color = color))
par_ <- function(doc, ..., align = "left", space_after = 4)
  body_add_fpar(doc, fpar(..., fp_p = fp_par(text.align = align, padding.bottom = space_after)))
title_ <- function(doc, x, session) {
  doc |>
    par_(txt(session, 9, color = GREY), space_after = 0) |>
    par_(txt(x, 18, bold = TRUE, color = DARK), space_after = 2)
}
print_line <- function(doc, x) par_(doc, txt(paste("Print:", x), 9, italic = TRUE, color = BLUE), space_after = 8)
h2_ <- function(doc, x) par_(doc, txt(x, 13, bold = TRUE, color = BLUE), space_after = 3)
p_  <- function(doc, x, ..., space_after = 4) par_(doc, txt(x, ...), space_after = space_after)
write_lines <- function(doc, n = 3) {
  for (i in seq_len(n)) doc <- par_(doc, txt(strrep("_", 76), 11, color = "#B5BEC9"), space_after = 6)
  doc
}
illustrative <- function(doc)
  p_(doc, "Illustrative case, with invented figures. Not a real programme.", 8.5, italic = TRUE, color = GREY)
new_page <- function(doc) body_add_break(doc)

# A plain table with a header row in blue.
plain_table <- function(df, widths = NULL) {
  ft <- flextable(df) |>
    bold(part = "header") |> color(part = "header", color = DARK) |>
    border_remove() |> hline_top(border = fp_border(color = DARK, width = 1.5), part = "header") |>
    hline(border = fp_border(color = DARK, width = 1), part = "header") |>
    hline(border = thin_line, part = "body") |>
    align(align = "left", part = "all")
  if (!is.null(widths)) ft <- width(ft, width = widths) else ft <- autofit(ft)
  ft
}

# Cards laid out in a grid with dashed cut lines. `cards` is a list of
# character vectors: first element bold (the card title), the rest body lines.
card_grid <- function(cards, ncol = 2, card_width = 3.4, min_height = 1.6, title_size = 11, body_size = 10.5) {
  n <- length(cards); nrow <- ceiling(n / ncol)
  m <- matrix("", nrow, ncol)
  df <- as.data.frame(m, stringsAsFactors = FALSE)
  names(df) <- paste0("c", seq_len(ncol))
  ft <- flextable(df) |> delete_part("header") |> border_remove() |>
    border_outer(border = cut_line) |> border_inner(border = cut_line) |>
    width(width = card_width) |> height_all(height = min_height) |> hrule(rule = "atleast") |>
    valign(valign = "top") |> padding(padding = 10)
  for (k in seq_len(n)) {
    i <- (k - 1) %/% ncol + 1; j <- (k - 1) %% ncol + 1
    card <- cards[[k]]
    chunks <- list(as_chunk(card[1], props = fp_text(font.family = FONT, font.size = title_size,
                                                      bold = TRUE, color = DARK)))
    for (line in card[-1]) chunks <- c(chunks, list(as_chunk(paste0("\n", line),
                                     props = fp_text(font.family = FONT, font.size = body_size))))
    ft <- compose(ft, i = i, j = j, value = do.call(as_paragraph, chunks))
  }
  ft
}
add_cards <- function(doc, cards, ...) body_add_flextable(doc, card_grid(cards, ...), align = "center")

# ---- Wall boards, printed at A1 ----------------------------------------------
# Each board is drawn once with grid graphics and written two ways: a PDF at A1
# landscape (<stem>_board_A1.pdf, the file the print shop gets) and a small
# preview image placed in the pack after the facilitator key. `s` scales every
# font so the preview looks like the poster.
A1_W <- 33.11; A1_H <- 23.39
board_gp <- function(s, size, col = DARK, bold = FALSE)
  grid::gpar(fontsize = size * s, col = col, fontface = if (bold) "bold" else "plain", fontfamily = "sans")
board_title <- function(s, title, sub) {
  grid::grid.text(title, x = 0.04, y = 0.95, just = c("left", "top"), gp = board_gp(s, 80, DARK, TRUE))
  grid::grid.text(sub, x = 0.04, y = 0.875, just = c("left", "top"), gp = board_gp(s, 40, GREY))
}
make_board <- function(stem, draws) {
  pdf(paste0(stem, "_board_A1.pdf"), width = A1_W, height = A1_H, onefile = TRUE)
  for (d in draws) { grid::grid.newpage(); d(1) }
  dev.off()
  lapply(draws, function(d) {
    f <- tempfile(fileext = ".png"); w <- 6.8
    png(f, width = w, height = w * A1_H / A1_W, units = "in", res = 200, bg = "white")
    grid::grid.newpage(); d(w / A1_W); dev.off(); f
  })
}
add_board_page <- function(doc, stem, previews, session, what) {
  doc <- doc |> new_page() |> title_(paste("Wall board:", what), session) |>
    print_line(sprintf("send %s_board_A1.pdf to the printer at A1 (landscape)%s; tape it to the wall. This page is only a preview",
                       stem, if (length(previews) > 1) sprintf(", %d sheets", length(previews)) else ""))
  for (f in previews) doc <- body_add_img(doc, src = f, width = 6.8, height = 6.8 * A1_H / A1_W, style = "Normal")
  doc
}
# A table board: column headers across the top, row labels down the left.
grid_board <- function(title, sub, cols, rows, row_fill = NULL, row_text = "white", label_w = 0.2,
                       top = 0.8, bottom = 0.04, foot = NULL) function(s) {
  board_title(s, title, sub)
  x0 <- 0.04; x1 <- 0.96; hh <- 0.07
  cw <- (x1 - x0 - label_w) / length(cols); rh <- (top - hh - bottom) / length(rows)
  for (j in seq_along(cols)) {
    grid::grid.rect(x0 + label_w + (j - 1) * cw, top, cw, hh, just = c("left", "top"),
                    gp = grid::gpar(fill = DARK, col = "white", lwd = 3 * s))
    grid::grid.text(cols[j], x0 + label_w + (j - 0.5) * cw, top - hh / 2, gp = board_gp(s, 50, "white", TRUE))
  }
  for (i in seq_along(rows)) {
    y <- top - hh - (i - 1) * rh
    fill <- if (is.null(row_fill)) "#DCE6F1" else row_fill[i]
    grid::grid.rect(x0, y, label_w, rh, just = c("left", "top"), gp = grid::gpar(fill = fill, col = "white", lwd = 3 * s))
    grid::grid.text(rows[i], x0 + 0.012, y - rh / 2, just = "left",
                    gp = board_gp(s, if (nchar(rows[i]) > 18) 40 else 50, row_text, TRUE))
    for (j in seq_along(cols))
      grid::grid.rect(x0 + label_w + (j - 1) * cw, y, cw, rh, just = c("left", "top"),
                      gp = grid::gpar(fill = NA, col = "#9AA8B8", lwd = 4 * s))
  }
  if (!is.null(foot)) grid::grid.text(foot, 0.96, 0.015, just = c("right", "bottom"), gp = board_gp(s, 28, GREY))
}
# A number line: an axis across the middle, a lane above it and a lane below it.
line_board <- function(title, sub, lim, major, minor, fmt, marks, lane_up, lane_down, shade = NULL) function(s) {
  board_title(s, title, sub)
  x0 <- 0.06; x1 <- 0.96; ya <- 0.42
  px <- function(v) x0 + (v - lim[1]) / diff(lim) * (x1 - x0)
  if (!is.null(shade)) for (sh in shade)
    grid::grid.rect(px(sh$from), 0.08, px(sh$to) - px(sh$from), 0.72, just = c("left", "bottom"),
                    gp = grid::gpar(fill = sh$fill, col = NA))
  grid::grid.text(lane_up, x0, 0.79, just = c("left", "top"), gp = board_gp(s, 36, GREY, TRUE))
  grid::grid.text(lane_down, x0, 0.30, just = c("left", "top"), gp = board_gp(s, 36, GREY, TRUE))
  grid::grid.lines(c(px(lim[1]), px(lim[2])), c(ya, ya), gp = grid::gpar(col = DARK, lwd = 10 * s))
  for (v in minor) grid::grid.lines(c(px(v), px(v)), c(ya - 0.01, ya + 0.01), gp = grid::gpar(col = DARK, lwd = 4 * s))
  for (v in major) {
    grid::grid.lines(c(px(v), px(v)), c(ya - 0.025, ya + 0.025), gp = grid::gpar(col = DARK, lwd = 8 * s))
    grid::grid.text(fmt(v), px(v), ya - 0.045, just = "top", gp = board_gp(s, 48, DARK, TRUE))
  }
  for (m in marks) {
    for (seg in list(c(0.08, ya - if (nzchar(lane_down)) 0.17 else 0.1), c(ya + 0.03, 0.8)))
      grid::grid.lines(c(px(m$at), px(m$at)), seg, gp = grid::gpar(col = m$col, lwd = 12 * s, lty = m$lty))
    right <- px(m$at) > 0.75
    grid::grid.text(m$label, px(m$at) + if (right) -0.006 else 0.006, if (is.null(m$y)) 0.8 else m$y,
                    just = c(if (right) "right" else "left", "top"), gp = board_gp(s, 38, m$col, TRUE))
  }
}

gfmt <- function(x, d = 0) formatC(x, format = "f", digits = d, big.mark = ",")

# ---- data --------------------------------------------------------------------
tc <- read.csv("evaluation_data_TrafficCameras.csv")
gw <- read.csv("evaluation_data_GreenWaste.csv")

# ===========================================================================
# Oct12 S1 · Compared to What?
# ===========================================================================
S1 <- "Module 2 · Day 1, Session 1 · Compared to What?"
# The simple GreenWaste case, LANDFILL only (tonnes per business per year, the
# rest of the city), as in Oct12_session1_live.qmd. Costs are not shown in S1.
s1_env <- new.env()
s1_env$gw <- read.csv("evaluation_data_GreenWaste_simple.csv")
sys.source("greenwaste_case.R", envir = s1_env)
s1_city <- s1_env$city; s1_took <- s1_env$took
s1_city$change <- s1_city$landfill_after - s1_city$landfill_before   # landfill, not costs
s1_pct  <- 100 * (mean(s1_city$landfill_after[s1_took]) / mean(s1_city$landfill_before[s1_took]) - 1)
s1_rest <- 100 * (mean(s1_city$landfill_after[!s1_took]) / mean(s1_city$landfill_before[!s1_took]) - 1)
# The same ten businesses as the deck (chosen by ID; the last is the large one).
s1_TEN <- c("B02136", "B00755", "B03791", "B05600", "B01274",
            "B07507", "B01673", "B04954", "B08013", "B03836")
s1_ten <- subset(s1_city, business %in% s1_TEN)
s1_ten <- s1_ten[order(s1_ten$landfill_before), ]
s1_x <- s1_ten$landfill_before
stopifnot(nrow(s1_ten) == 10, s1_ten$business[10] == "B03836", mean(s1_x) > median(s1_x))
s1_r2 <- function(x) round(x, 2)
s1_lf <- c(t0 = s1_r2(mean(s1_city$landfill_before[s1_took])), t1 = s1_r2(mean(s1_city$landfill_after[s1_took])),
           o0 = s1_r2(mean(s1_city$landfill_before[!s1_took])), o1 = s1_r2(mean(s1_city$landfill_after[!s1_took])))
s1_eff <- (s1_lf[["t1"]] - s1_lf[["t0"]]) - (s1_lf[["o1"]] - s1_lf[["o0"]])
s1_fit <- lm(change ~ took_part, data = s1_city)
s1_b   <- coef(s1_fit)[["took_part"]]; s1_ci <- confint(s1_fit)["took_part", ]
s1_area <- coef(lm(change ~ took_part + staff + area, data = s1_city))[["area"]]
s1_f2 <- function(x) sprintf("%.2f", x)

s1_excerpts <- c(
  sprintf("Landfill waste from businesses in GreenWaste fell %s%% in a year.", gfmt(abs(s1_pct))),
  sprintf("The effect of GreenWaste on landfill is %s tonnes per business, 95%% confidence interval %s to %s.",
          s1_f2(s1_b), s1_f2(s1_ci[1]), s1_f2(s1_ci[2])),
  "The fall in landfill is statistically significant (p < 0.001), so every business in the country should join GreenWaste.",
  sprintf("Landfill fell %s tonnes per business among those that took part and %s tonnes among those that did not.",
          gfmt(abs(s1_lf[["t1"]] - s1_lf[["t0"]]), 1), gfmt(abs(s1_lf[["o1"]] - s1_lf[["o0"]]), 1)),
  sprintf("The average business in our sample sent %s tonnes to landfill.", gfmt(mean(s1_city$landfill_before), 1)),
  "A study of 6 businesses found no significant change in landfill.",
  sprintf("The coefficient on area is %s, so businesses should move to larger premises.", s1_f2(s1_area)),
  sprintf("Landfill fell %s tonnes per business more than among businesses that did not take part; the target was at least 2 tonnes.",
          gfmt(abs(s1_eff), 1)))

s1 <- new_pack() |>
  title_("By hand: ten businesses", S1) |>
  print_line("1 per participant (double-sided with the next page)") |>
  p_("Ten businesses in the rest of the city. Waste each one sent to landfill in the year before GreenWaste, in tonnes.") |>
  body_add_flextable(plain_table(data.frame(Business = s1_ten$business, Staff = s1_ten$staff,
                                            `Landfill (tonnes)` = s1_x, check.names = FALSE),
                                 widths = c(1.6, 1.2, 1.8))) |>
  illustrative() |>
  h2_("1. Work it out by hand") |>
  p_("The mean (the average) landfill per business:  ________") |>
  p_("How many of the ten businesses are below the mean?  ________") |>
  p_("The median (the middle business when they are in order):  ________") |>
  h2_("2. Remove the largest business") |>
  p_("New mean:  ________      New median:  ________") |>
  p_("Which changed more, the mean or the median? What does this tell you about an average in a report?") |>
  write_lines(2) |>
  new_page() |>
  title_("By hand: the landfill table", S1) |>
  print_line("on the back of the ten-businesses sheet") |>
  p_("Average landfill per business in the rest of the city (tonnes per year), before GreenWaste and 12 months after. Fill in the empty cells.") |>
  body_add_flextable(plain_table(data.frame(
    `Average landfill (tonnes)` = c("Took part", "Did not take part", "Difference"),
    Before = c(gfmt(s1_lf[["t0"]], 2), gfmt(s1_lf[["o0"]], 2), ""),
    After  = c(gfmt(s1_lf[["t1"]], 2), gfmt(s1_lf[["o1"]], 2), ""),
    Change = c("", "", ""), check.names = FALSE), widths = c(2.4, 1.2, 1.2, 1.2))) |>
  illustrative() |>
  p_("Copy these three numbers from your table:") |>
  p_("The change for those that took part:  ________     The gap after:  ________     The gap before:  ________") |>
  p_("Which of these three numbers is the effect of GreenWaste on landfill? Why are the other two numbers not the effect?") |>
  write_lines(2) |>
  h2_("3. Which report would you act on?") |>
  p_("Three evaluations of GreenWaste each report 1.8 tonnes less landfill per business per year. The city's target: at least 2.0 tonnes less. For each report, tick one box.") |>
  body_add_flextable(plain_table(data.frame(
    Report = c("A", "B", "C"), `95% interval` = c("0.4 to 3.2", "1.6 to 2.0", "-0.9 to 4.5"),
    Act = c("[   ]", "[   ]", "[   ]"), `Do not act` = c("[   ]", "[   ]", "[   ]"),
    `Cannot tell yet` = c("[   ]", "[   ]", "[   ]"), check.names = FALSE),
    widths = c(0.8, 1.6, 0.8, 1.1, 1.4))) |>
  p_("These three results and the target are invented for the exercise.", 8.5, italic = TRUE, color = GREY) |>
  new_page() |>
  title_("AI prompt cards", S1) |>
  print_line("1 set per group, cut along the dashed lines; each group takes one card") |>
  add_cards(list(
    c("Card 1", "Paste into your AI tool:",
      "\"Explain a 95% confidence interval, in one paragraph, for someone who is not a statistician.\"",
      "", "Did the AI's answer contain mistakes, or claim more than is true?", "", "", ""),
    c("Card 2", "Paste into your AI tool:", "\"Explain what a p-value means.\"",
      "", "Did the AI's answer contain mistakes, or claim more than is true?", "", "", ""),
    c("Card 3", "Paste into your AI tool:",
      sprintf("\"Landfill waste from businesses in our programme fell %s%%. Is that a good result?\"", gfmt(abs(s1_pct))),
      "", sprintf("Did the AI ask what the %s%% was compared with?", gfmt(abs(s1_pct))), "", "", ""),
    c("Card 4", "Paste into your AI tool:",
      sprintf("\"The coefficient on area is %s. What should I do about it?\"", s1_f2(s1_area)),
      "", "Did the AI give you advice about premises?", "", "", "")), min_height = 3.2)

# The triage uses the first four excerpts only (6 Oct); the other four stay in
# `s1_excerpts` and in the key for reference.
NT <- 4
board1 <- make_board("Oct12_session1", list(grid_board(
  "Triage the claims",
  "Write the excerpt number (1 to 4) in your group's colour, in the cell that matches your answer.",
  cols = c("Act", "Ask first", "Do not act"),
  rows = c("Compared to what?", "How big?", "How sure?", "None: it answers all three"),
  row_text = DARK, label_w = 0.24,
  foot = "Module 2 \u00b7 Day 1, Session 1 \u00b7 Illustrative case, with invented figures")))
s1 <- s1 |> new_page() |> title_("Triage the claims", S1) |>
  print_line("1 per group (8), with one set of the excerpt slips (next page)") |>
  p_("You are the commissioner. You receive four sentences from reports on GreenWaste. For each sentence: which of the three questions (compared to what? how big? how sure?) does the sentence not answer? Would you act on the sentence, not act, or ask a question first?") |>
  body_add_flextable(plain_table(data.frame(
    Excerpt = seq_len(NT),
    `Question the sentence does not answer: compared to what? / how big? / how sure? / none` = rep("", NT),
    `Act / do not act / ask first` = rep("", NT),
    `The question you would ask the evaluator` = rep("", NT), check.names = FALSE),
    widths = c(0.8, 2.3, 1.4, 2.4)) |> height_all(height = 0.8, part = "body") |>
    hrule(rule = "atleast", part = "body")) |>
  p_("If the trainer uses the wall board: write each excerpt number (1 to 4) in your group's colour in the cell that matches your answer (row: the question it does not answer; column: act, ask first or do not act).", bold = TRUE) |>
  p_("Which excerpt would you most want to act on? What would you need to know before acting on that excerpt?") |>
  write_lines(2) |>
  new_page() |> title_("Triage the claims: the excerpts", S1) |>
  print_line("1 set per group (8 sets); cut into slips. The same slips go on the wall matrix if it is used") |>
  add_cards(lapply(seq_len(NT), function(i) c(sprintf("Excerpt %d", i), s1_excerpts[i])),
            ncol = 2, min_height = 2.2, title_size = 14, body_size = 16) |>
  illustrative() |>
  new_page() |> title_("Take-away card: three questions for any number", S1) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions for any number", "1. Compared to what?",
                       "2. How big is the number, in units that matter to the decision?",
                       "3. How sure are we?", "", "Back at work, I will ask these questions about:", "______________________________")), 8), min_height = 1.8) |>
  new_page() |> title_("Facilitator key", S1) |> print_line("trainer only") |>
  h2_("Ten businesses") |>
  p_(sprintf("Mean %s tonnes; %d of the ten businesses are below it; median %s. Without the largest business (%s staff, %s tonnes): mean %s, median %s. One business moved the mean further than the median.",
             gfmt(mean(s1_x), 1), sum(s1_x < mean(s1_x)), gfmt(median(s1_x), 1), s1_ten$staff[10], gfmt(max(s1_x)),
             gfmt(mean(s1_x[-length(s1_x)]), 1), gfmt(median(s1_x[-length(s1_x)]), 1))) |>
  h2_("Landfill table") |>
  p_(sprintf("Changes: took part %s, did not take part %s. Differences: before %s (the head start: the businesses that took part are smaller), after %s (still carries the head start), change %s. The effect is %s tonnes per business per year, smaller than the fall for those that took part because the rest fell too.",
             gfmt(s1_lf[["t1"]] - s1_lf[["t0"]], 2), gfmt(s1_lf[["o1"]] - s1_lf[["o0"]], 2),
             gfmt(s1_lf[["t0"]] - s1_lf[["o0"]], 2), gfmt(s1_lf[["t1"]] - s1_lf[["o1"]], 2),
             gfmt(s1_eff, 2), gfmt(s1_eff, 2))) |>
  h2_("Which one would you act on?") |>
  p_("B: do not act, it is precise and below the target. A and C: cannot tell yet; the intervals span the target. The interval decides, not the point estimate.") |>
  h2_("AI prompt cards") |>
  p_(sprintf("Card 1: look for \"95%% probability that the true value is in this interval\". 95%% describes the method over many studies. Card 2: look for \"the probability the result is due to chance\" or \"the probability the programme works\". Card 3: a good answer asks what the %s%% was compared with and what happened to businesses outside the programme. Card 4: look for advice about premises; the row adjusts the comparison, it is not a policy lever.",
             gfmt(abs(s1_pct)))) |>
  h2_("Triage key (the session uses excerpts 1 to 4; 5 to 8 are kept for reference)") |>
  body_add_flextable(plain_table(data.frame(
    Excerpt = 1:8,
    Unanswered = c(sprintf("Compared to what? (before and after; businesses that did not take part fell %s%% too)", gfmt(abs(s1_rest))),
                   "How big, in units that matter? (landfill, not the waste costs the decision rests on)",
                   "How big? Significance is not a decision rule",
                   "How sure? (no interval)",
                   "How big, for a typical business? (a few large businesses pull the mean)",
                   "How sure? (6 businesses is too few to see anything)",
                   "Misread coefficient: not a policy lever",
                   "None: a comparison, an effect and a bar"),
    Call = c("Ask first", "Ask first", "Do not act on this", "Ask first",
             "Ask for the spread", "Do not conclude 'no effect'", "Do not act on this", "Act"),
    check.names = FALSE), widths = c(0.8, 4.0, 2.0))) |>
  p_("Debrief: groups disagree most on 2 and 4, which is the point; take one group's reasoning for each.") |>
  h2_("Wall board (optional, alongside the triage sheet)") |>
  p_("Setup, before the session: print Oct12_session1_board_A1.pdf at A1 and tape it to the wall (preview at the end of this pack). It is a grid: three columns, Act / Ask first / Do not act, and four rows, Compared to what? / How big? / How sure? / None: it answers all three. Give each group a marker in its own colour (8 colours, for example blue, green, orange, purple, black, brown, pink and red).") |>
  p_("Running it: groups fill in the triage sheet at the table, then one person per group writes the four excerpt numbers in the matching cells, in the group's colour. Expected: 1 in Compared to what? / Ask first; 2 in How big? / Ask first; 3 in How big? / Do not act; 4 in How sure? / Ask first. Look for an excerpt number that appears in more than one cell (usually 2 and 4) and ask two groups of different colours to explain. The Act column will probably stay empty: ask what an excerpt would need to move there (excerpt 8 on the full list is an example: a comparison, an effect and a target).") |>
  add_board_page("Oct12_session1", board1, S1, "triage the claims (A1)")
print(s1, target = "Oct12_session1_materials.docx")

# ===========================================================================
# Oct12 S3 · Spot the Problem
# ===========================================================================
S3 <- "Module 2 · Day 1, Session 3 · Spot the Problem"
# The simple GreenWaste case (SIMPLE_GREENWASTE_PLAN.md); numbers from greenwaste_case.R,
# sourced into its own environment because it defines RULE.
s3_env <- new.env()
s3_env$gw <- read.csv("evaluation_data_GreenWaste_simple.csv")
sys.source("greenwaste_case.R", envir = s3_env)
s3_case <- s3_env$case; s3_pilot <- s3_env$pilot; s3_city <- s3_env$city; s3_took <- s3_env$took
ba  <- s3_case$before_after
ww  <- s3_case$with_without
ww0 <- s3_case$gap_before
rct <- s3_case$rct
rct_ci <- sort(abs(s3_case$rct_ci))
city_rise <- mean(s3_city$change[!s3_took])
s3_off <- order(s3_pilot$cost_before)[seq_len(nrow(s3_pilot) / 2)]
officials_gap <- mean(s3_pilot$cost_before[s3_off]) - mean(s3_pilot$cost_before[-s3_off])
crowd_q <- function(k, draws = 1000) {
  set.seed(7)
  quantile(abs(replicate(draws, { s <- sample(nrow(s3_pilot), k)
    mean(s3_pilot$cost_before[s[seq_len(k / 2)]]) - mean(s3_pilot$cost_before[s[-seq_len(k / 2)]]) })), 0.95)
}
q4 <- crowd_q(4); q400 <- crowd_q(400)

s3 <- new_pack() |>
  title_("Session tracker", S3) |>
  print_line("1 per participant; filled in as the session runs") |>
  p_("Today the trainer calculates three GreenWaste numbers from the data. Your task: decide what is wrong with each one. The decision rule for national scale-up: the programme must save at least 1,000 AED per business per year.") |>
  body_add_flextable(plain_table(data.frame(
    Comparison = c("Before and after (rest of the city)", "Took part vs did not (rest of the city)", "Randomised (the pilot district lottery)"),
    `The number` = c("", "", ""),
    `Too big, too small, or about right?` = c("", "", ""),
    `Why?` = c("", "", ""), check.names = FALSE), widths = c(2.3, 1.0, 1.6, 2.1)) |>
    height_all(height = 0.55, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  h2_("The lottery") |>
  p_("The trainer draws the pilot lottery again five times. Each time, look at the difference in costs before the programme between the businesses picked and the ones not picked. Write the largest difference:  ________ AED") |>
  p_("The same difference when officials choose the businesses instead:  ________ AED") |>
  p_("With 4 businesses in the lottery, in 95 out of 100 draws the starting difference is smaller than ± ________ AED. With 400 businesses: ± ________ AED.") |>
  h2_("Reading the randomised result") |>
  p_("The effect of the programme: ________ AED.   The 95% confidence interval for the effect: ________ to ________") |>
  p_("Look at the end of the interval with the smallest saving. Is that saving at least 1,000 AED?   Yes  /  No") |>
  p_("One question I would ask the evaluator:") |> write_lines(2) |>
  new_page() |>
  title_("AI Snapshot: a paragraph for the minister", S3) |>
  print_line("1 per pair") |>
  p_("The prompt, written the way a busy official might write it:", bold = TRUE) |>
  p_(sprintf("\"Our pilot cut waste costs by %s AED per business (costs before vs after, p < 0.001). Write a short paragraph for the minister on what this shows.\"", gfmt(abs(ba))), italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_(sprintf("The GreenWaste pilot produced a clear result: waste-management costs fell by %s AED per business, and with p < 0.001 we can be confident the programme caused this reduction. Because the same businesses were measured before and after, differences between businesses are already accounted for, so the %s AED saving can be attributed to the programme. This makes a strong case for national scale-up. As with any pilot, results should be monitored as the programme expands.", gfmt(abs(ba)), gfmt(abs(ba)))) |>
  p_("Underline every claim in the response that the evidence does not support. Then run the same prompt yourselves: did your AI write something similar?", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_(sprintf("\"Costs for participating businesses were %s AED lower after the pilot than before (p < 0.001). We also have businesses that did not take part and a randomised comparison. The scale-up rule is at least 1,000 AED. Before writing anything, tell me what this before-and-after number can and cannot show. Ask me questions before you answer.\"", gfmt(abs(ba))), italic = TRUE) |>
  p_(sprintf("Which answer checks whether %s AED is a fair measure of the effect before writing the paragraph? Paste the better answer into a new chat and ask the AI to check that answer for errors.", gfmt(abs(ba)))) |>
  new_page() |> title_("Take-away card: three questions for an RCT", S3) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions to ask the evaluator",
                       "1. Compared to what? Before-and-after, with-and-without, or a fair comparison?",
                       "2. Show me the balance table. How do you know the groups started out alike?",
                       "3. How many units were randomised? Does the whole confidence interval meet our decision rule?", "", "Back at work, I will ask these questions about:", "______________________________")), 6),
            min_height = 2.2) |>
  new_page() |> title_("Facilitator key", S3) |> print_line("trainer only") |>
  h2_("Session tracker") |>
  p_(sprintf("Before and after %s: too small; costs for city businesses that did not take part rose about %s AED, so the fall understates the effect. Took part vs did not %s: too big; the groups differed by %s AED before the programme. Randomised %s: fair. 95%% interval -%s to -%s: the estimate clears 1,000, the interval spans it.",
             gfmt(ba), gfmt(city_rise), gfmt(ww), gfmt(ww0), gfmt(rct), gfmt(rct_ci[2]), gfmt(rct_ci[1]))) |>
  p_(sprintf("Lottery: random draws among the 400 pilot businesses start within a few dozen AED; officials picking the cheapest-to-run businesses start about %s AED apart. 4 businesses: about ± %s AED; 400: about ± %s AED.",
             gfmt(abs(officials_gap)), gfmt(q4), gfmt(q400))) |>
  h2_("AI Snapshot: four errors") |>
  p_(sprintf("1. Significant is not causal: p < 0.001 says the fall is unlikely to be chance, not what caused it. 2. Half right: following the same businesses removes fixed differences but not what changed for everyone. 3. It reports %s as the effect; the randomised estimate is about %s. 4. It recommends scale-up without asking what bar the programme must clear.", gfmt(abs(ba)), gfmt(abs(rct))))
print(s3, target = "Oct12_session3_materials.docx")

# ===========================================================================
# Oct13 S2 · Reading RDD Results
# ===========================================================================
S5 <- "Module 2 · Day 2, Session 2 · Reading RDD Results"
# The simple GreenWaste case: the rest of the city, where businesses scoring
# 58 or below took part. Numbers from greenwaste_case.R, in its own environment.
s5_env <- new.env()
s5_env$gw <- read.csv("evaluation_data_GreenWaste_simple.csv")
sys.source("greenwaste_case.R", envir = s5_env)
s5_city <- s5_env$city
s5_city$distance <- s5_city$score - 58; s5_city$below <- as.integer(s5_city$score <= 58)
s5_at <- function(width, cut = 58, adjust = FALSE) {
  d <- s5_city; d$distance <- d$score - cut; d$below <- as.integer(d$score <= cut)
  d <- subset(d, abs(distance) <= width)
  f <- estimatr::lm_robust(if (adjust) cost_after ~ below * distance + manager_age
                 else cost_after ~ below * distance, data = d)
  list(est = coef(f)[["below"]], ci = confint(f)["below", ], n = nrow(d))
}
s5_w2 <- s5_at(2); s5_w2_age <- s5_at(2, adjust = TRUE)
s5_win <- abs(sapply(1:10, function(w) s5_at(w)$est))
s5_best <- max(sapply(1:10, function(w) max(abs(s5_at(w)$ci))))
s5_age <- abs(sapply(1:8, function(w) {
  d <- subset(s5_city, abs(distance) <= w)
  coef(lm(manager_age ~ below * distance, data = d))[["below"]]
}))
s5_tp <- s5_city[s5_city$took_part == 1, ]
s5_tp_near <- abs(s5_tp$distance) <= 2
# Eight cards (A-H), one per group, each with a different random six businesses
# on each side of the line. Groups put their jumps on a number line on the
# wall; the spread is the lesson. The seeds were chosen to give a wide spread
# (one card, H, even goes the wrong way).
jump_card <- function(seed) {
  set.seed(seed)
  b <- s5_city[sample(which(s5_city$score > 57 & s5_city$score <= 58), 6), ]
  a <- s5_city[sample(which(s5_city$score > 58 & s5_city$score <= 59), 6), ]
  list(rows = data.frame(`Just below 58 (took part): score` = gfmt(b$score, 1),
                         `Waste cost after (AED)` = gfmt(round(b$cost_after, -1)),
                         `Just above 58 (did not): score` = gfmt(a$score, 1),
                         `Waste cost after (AED) ` = gfmt(round(a$cost_after, -1)),
                         check.names = FALSE),
       below = mean(round(b$cost_after, -1)), above = mean(round(a$cost_after, -1)))
}
cards5 <- lapply(c(A = 4, B = 11, C = 37, D = 22, E = 9, F = 21, G = 33, H = 5), jump_card)
jumps5 <- sapply(cards5, function(x) x$below - x$above)
board5 <- make_board("Oct13_session2", list(line_board(
  "The jump at the line: what did your group find?",
  "Write your jump and your card letter on a sticky note. Put it above the line, at your number.",
  lim = c(-2000, 500), major = seq(-2000, 500, 500), minor = seq(-2000, 500, 100),
  fmt = function(v) ifelse(v > 0, paste0("+", gfmt(v)), gfmt(v)),
  marks = list(list(at = -1000, col = RED, lty = "solid", label = "The rule: at least 1,000 AED saved"),
               list(at = 0, col = GREY, lty = "dashed", label = "No change", y = 0.72)),
  lane_up = "Our groups' jumps (AED, below minus above)",
  lane_down = "")))

s5 <- new_pack()
for (k in names(cards5)) {
  s5 <- s5 |>
    title_(sprintf("By hand: the jump at the line (card %s)", k), S5) |>
    print_line("eight different cards (A-H); one card per group, so every group holds a different card") |>
    p_("Twelve GreenWaste businesses in the rest of the city, all within one point of the cut-off at 58. Businesses scoring 58 or below took part. Costs after the programme, rounded to the nearest 10 AED.") |>
    body_add_flextable(plain_table(cards5[[k]]$rows, widths = c(1.8, 1.3, 1.9, 1.3))) |>
    h2_("Work it out") |>
    p_("Average cost just below the line:  ________      Average cost just above:  ________") |>
    p_("The jump (below minus above):  ________ AED.") |>
    p_(sprintf("Write the jump and your card letter (%s) on a sticky note. Put the sticky note on the number line on the wall, at your jump.", k), bold = TRUE) |>
    p_("The other groups had cards with different businesses, and found different jumps. Look at the wall: why are the jumps so different? What would you need before you trusted one jump as the effect of the programme?") |>
    write_lines(2) |>
    new_page()
}
s5 <- s5 |>
  title_("Scorecard: can we trust the jump at 58?", S5) |>
  print_line("1 per group; mark each check as the trainer runs it") |>
  p_("The trainer runs each check on screen. For each check, write pass, fail or unclear, and add a short note.") |>
  body_add_flextable(plain_table(data.frame(
    Check = c("1. A different window around 58", "1b. Placebo (fake) cut-offs",
              "2. Bending the rule", "3. Are the two sides alike?", "4. Who does the result apply to?"),
    `What to look for` = c("Does the decision against 1,000 AED change when the window is wider or narrower?",
                           "No jump at other cut-offs, where no rule applies",
                           "No unusual crowding of businesses just below 58 (a sign that businesses changed their score to qualify)",
                           "Characteristics such as size and manager age do not jump at 58",
                           "Are the businesses near 58 like the businesses the roll-out would reach?"),
    `Pass / fail / unclear` = rep("", 5), Note = rep("", 5), check.names = FALSE),
    widths = c(1.6, 2.6, 1.0, 1.7)) |> height_all(height = 0.55, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  p_("Overall: would you act on this estimate?   Act  /  Act with conditions  /  Send back to the evaluator") |>
  p_("One question you would ask the evaluator:") |> write_lines(2) |>
  new_page() |>
  title_("AI Snapshot: who does this apply to?", S5) |>
  print_line("1 per group") |>
  p_("The prompt: \"Explain, without jargon, who this result actually applies to.\"", bold = TRUE) |>
  h2_("A response like this is possible") |>
  p_(sprintf("This study found that the GreenWaste programme reduced costs by around %s AED for participating businesses. Because the study uses a cut-off at an efficiency score of 58, the findings apply to all businesses in the programme. The cut-off design means the result generalises to the wider population of inefficient businesses. The estimate is therefore a reasonable basis for scaling the programme to every business below average efficiency.", gfmt(abs(s5_w2$est)))) |>
  p_("Underline every claim that the study supports. Cross out every claim that the study does not support. What important information did the AI's answer leave out?", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"This is a regression discontinuity result with the cut-off at an efficiency score of 58, estimated within 2 points either side. Most participants score well below 58, and manager age differs across the line. Name which businesses the estimate describes and what it cannot tell us. Ask me questions before you answer.\"", italic = TRUE) |>
  p_("Run this prompt. Which businesses does the new answer say the result applies to? Then paste the answer into a new chat and ask the AI to check that answer for claims the study does not support.") |>
  new_page() |> title_("Take-away card: five questions for an RDD result", S5) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Five questions for an RDD result",
                       "1. Where is the cut-off, which side is eligible, and exactly which units are compared?",
                       "2. Does the jump stay when the window is wider or narrower? Is there no jump at placebo (fake) cut-offs?",
                       "3. Are there about the same number of units just above and just below the cut-off?",
                       "4. Do other characteristics (such as size or manager age) change suddenly at the cut-off?",
                       "5. Who is near the cut-off, and does the estimate meet our decision rule for them?", "", "Back at work, I will ask these questions about:", "______________________________")), 6),
            min_height = 2.5) |>
  new_page() |> title_("Facilitator key", S5) |> print_line("trainer only") |>
  h2_("The jump by hand") |>
  body_add_flextable(plain_table(data.frame(
    Card = names(cards5),
    `Below (AED)` = sapply(cards5, function(x) gfmt(x$below)),
    `Above (AED)` = sapply(cards5, function(x) gfmt(x$above)),
    Jump = sapply(cards5, function(x) gfmt(x$below - x$above)), check.names = FALSE),
    widths = c(0.8, 1.4, 1.4, 1.2))) |>
  p_(sprintf("Groups put their jumps on the wall number line. They spread widely because six businesses a side is too few; the regression uses the %s businesses within two points and reports an interval (%s, from %s to %s). The rough gap is also inflated by the slope of costs along the score, which the regression removes.",
             gfmt(s5_w2$n), gfmt(s5_w2$est), gfmt(s5_w2$ci[1]), gfmt(s5_w2$ci[2]))) |>
  h2_("Number line board") |>
  p_(sprintf("Setup, before the session: print Oct13_session2_board_A1.pdf at A1 and tape it to the wall (preview at the end of this pack). It is a number line from -2,000 to +500 AED with the 1,000 AED rule marked in red, space above the line for the groups' sticky notes and empty space below it, where you draw the regression after Run. Each group needs one sticky note and a marker. The eight jumps run from %s to %s; their average is %s.",
             gfmt(min(jumps5)), gfmt(max(jumps5)), gfmt(mean(jumps5)))) |>
  p_(sprintf("After the groups have posted, press Run. Then draw the regression below the line: a star at %s and a line (or a strip of coloured tape) from %s to %s for its interval. Ask: how many of the sticky notes fall inside the interval? Which side of the rule is most of the interval on? Card H goes the wrong way: six businesses a side can point anywhere.", gfmt(s5_w2$est), gfmt(s5_w2$ci[1]), gfmt(s5_w2$ci[2]))) |>
  h2_("Scorecard") |>
  p_(sprintf("1: the estimate moves between about %s and %s, always short of 1,000; even the most generous end of the interval reaches only about %s (verdict: does not clear). 1b: pass, no jump at 50, 54, 62 or 66. 2: pass. 3: FAIL, managers are %d to %d years younger just below the line at every window; adjusting for manager age moves the jump from %s to %s. 4: of the %s businesses that took part, only %s score within 2 points of 58 (average score %.0f against %.0f for the rest); the pilot lottery, over scores 20 to 58, found %s.",
             gfmt(min(s5_win)), gfmt(max(s5_win)), gfmt(s5_best), floor(min(s5_age)), ceiling(max(s5_age)),
             gfmt(s5_w2$est), gfmt(s5_w2_age$est), gfmt(nrow(s5_tp)), gfmt(sum(s5_tp_near)),
             mean(s5_tp$score[s5_tp_near]), mean(s5_tp$score[!s5_tp_near]), gfmt(s5_env$case$rct))) |>
  h2_("AI Snapshot") |>
  p_("Wrong: 'applies to all businesses', 'generalises to the wider population', 'basis for scaling to every business'. The estimate is local to the line. Left out: the manager-age jump, and the 1,000 AED rule.") |>
  add_board_page("Oct13_session2", board5, S5, "the jump at the line (A1)")
print(s5, target = "Oct13_session2_materials.docx")

# ===========================================================================
# Oct14 S1 · Was It Worth It?
# ===========================================================================
S7 <- "Module 2 · Day 3, Session 1 · Was It Worth It?"
pv <- function(r, y, lag = 1, decay = 0) {
  t <- seq_len(lag + y)
  s <- ifelse(t <= lag, 0, (1 - decay)^pmax(t - lag - 1, 0))
  sum(s / (1 + r)^t)
}
ratio <- function(rate = 0.05, years = 5, decay = 0, extra = 0) 816 * pv(rate, years, decay = decay) / (1800 + extra)
scen <- data.frame(
  card = 1:5,
  name = c("Old habits", "The hidden costs", "The finance ministry's rate",
           "A shorter life", "Old habits and hidden costs"),
  story = c("Businesses drift back to their old waste practices. The saving shrinks by 30% every year after the first.",
            "The authority's set-up, administration and the businesses' own time add 600 AED per business that the headline left out.",
            "The finance ministry insists on its standard discount rate of 8% instead of 5%.",
            "The new equipment is replaced after three years, so the saving lasts three years, not five.",
            "Both card 1 and card 2 happen."),
  settings = c("Saving shrinks each year: 30%", "Costs left out: 600 AED", "Discount rate: 8%",
               "Years the saving lasts: 3", "Shrinks 30% a year, and 600 AED left out"),
  value = c(ratio(decay = 0.3), ratio(extra = 600), ratio(rate = 0.08), ratio(years = 3),
            ratio(decay = 0.3, extra = 600)))

board7 <- make_board("Oct14_session1", list(line_board(
  "Does it still pay for itself?",
  "Before the trainer runs your card: a sticky note with your card number at your prediction. After: your card at the real ratio.",
  lim = c(0, 2), major = seq(0, 2, 0.5), minor = seq(0, 2, 0.1), fmt = function(v) sprintf("%.1f", v),
  marks = list(list(at = 1, col = RED, lty = "solid", label = "Break-even: 1.0"),
               list(at = ratio(), col = BLUE, lty = "dashed", label = sprintf("Headline: %.2f", ratio()))),
  lane_up = "Our prediction (sticky note)",
  lane_down = "The real ratio (put your card here)",
  shade = list(list(from = 0, to = 1, fill = "#F8E9EA"), list(from = 1, to = 2, fill = "#EAF2EC")))))

s7 <- new_pack() |>
  title_("What went into the ratio", S7) |>
  print_line("1 per group (also the table groups paste into AI)") |>
  body_add_flextable(plain_table(data.frame(
    Step = c("Cost per business", "Annual saving", "Years of saving assumed", "Discount rate assumed",
             "Savings, in today's money", "Benefit-cost ratio"),
    Value = c("1,800 AED", "816 AED", "5, starting in year 2", "5% a year",
              paste(gfmt(816 * pv(0.05, 5)), "AED"), sprintf("%s / 1,800 = %.2f", gfmt(816 * pv(0.05, 5)), ratio())),
    Source = c("programme records", "measured (Day 2 difference-in-differences)", "ASSUMED", "ASSUMED",
               "calculated", "calculated")), widths = c(2.2, 2.4, 2.3))) |>
  h2_("AI prompt, version 1") |>
  p_("\"Generate one plausible scenario in which this programme's benefit-cost ratio falls below 1. Then tell me whether that scenario is realistic.\"", italic = TRUE) |>
  h2_("AI prompt, version 2") |>
  p_("\"Here is a cost-benefit model. The cost and annual saving are measured; the discount rate and the number of benefit years are assumptions. Tell me which single assumption moves the ratio most, give the ratio under a realistic alternative, and say whether a government agency would normally make that assumption. Ask me questions before you answer.\"", italic = TRUE) |>
  p_("Run both prompts. Which answer compares all the assumptions before picking one? Which answer gives you a number you could use to make a decision?") |>
  new_page() |>
  title_("Stress-test scenario cards", S7) |>
  print_line("2 sets, cut; hand out cards 1 to 5, then cards 1 to 3 again, so each of the 8 groups holds one card") |>
  add_cards(lapply(seq_len(nrow(scen)), function(i)
    c(sprintf("Card %d · %s", scen$card[i], scen$name[i]), scen$story[i], "",
      "Predict the ratio: ______  Post a sticky note with your card number and prediction on the ratio wall.",
      paste("Tell the trainer:", scen$settings[i]),
      "Then put this card on the wall at the ratio shown on screen.", "",
      "Could this realistically happen in a programme like GreenWaste?", "Your verdict: does the programme still pay for itself (ratio above 1)?")),
    min_height = 2.4) |>
  new_page() |>
  title_("Group recording sheet", S7) |>
  print_line("1 per group") |>
  body_add_flextable(plain_table(data.frame(
    ` ` = c("Our card", "Settings we gave the trainer", "Our prediction (before the trainer ran it)", "Benefit-cost ratio shown on screen", "Realistic? Why or why not?",
            "Does the programme still pay for itself (ratio above 1)?", "One question for the evaluator"),
    Answer = rep("", 7), check.names = FALSE), widths = c(2.3, 4.6)) |>
    height_all(height = 0.6, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  h2_("The three questions, for GreenWaste") |>
  p_("1. Are the benefits realistic? Circle where the benefit figure comes from:  Measured  /  Modelled  /  Assumed") |>
  p_("2. Are all the costs included?  What is missing?") |> write_lines(1) |>
  p_("3. What change would make the benefit-cost ratio fall below 1?") |> write_lines(1) |>
  new_page() |> title_("Take-away card: judging a cost-benefit claim", S7) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions for any cost-benefit ratio",
                       "1. Are the benefits realistic? Were they measured, modelled or assumed?",
                       "2. Are all the costs included? What was left out?",
                       "3. What would make the ratio fall below 1? Which assumption, and by how much?",
                       "", "Ask: \"What assumption would have to change for this ratio to fall below 1, and what is your evidence for it?\"", "", "Back at work, I will ask these questions about:", "______________________________")), 6),
            min_height = 2.5) |>
  new_page() |> title_("Facilitator key", S7) |> print_line("trainer only") |>
  body_add_flextable(plain_table(data.frame(
    Card = scen$card, Scenario = scen$name, Ratio = sprintf("%.2f", scen$value),
    Verdict = ifelse(scen$value >= 1, "pays for itself", "does not pay"),
    check.names = FALSE), widths = c(0.6, 2.8, 0.9, 1.6))) |>
  p_("Base case 1.87. The rate alone does not flip it until about 24%. Two years of saving gives 0.80; break-even is about 2.5 years. Missing costs flip it at about 1,600 AED per business.") |>
  p_("AI Snapshot: the arithmetic in version 1 holds (40% does push the ratio below 1) but it picks the easiest lever, gives no number for 'benefits delayed', and claims unsourced authority ('commonly observed in infrastructure appraisal').") |>
  h2_("Ratio wall") |>
  p_(sprintf("Setup, before the session: print Oct14_session1_board_A1.pdf at A1 and tape it to the wall (preview at the end of this pack). It is a line from 0 to 2.0 with break-even (1.0) in red and the headline (%.2f) marked, a lane above for the predictions and a lane below for the cards. Each group needs one sticky note and a marker.", ratio())) |>
  p_("Running it: each group predicts its ratio and posts a sticky note, then reads out its settings. Enter them in the calculator on the \"Your turn\" slide; the group puts its card at the real ratio. Debrief from the wall: how far was each prediction from the real ratio? Only card 5 (two things going wrong at once) lands left of the red line. Groups holding the same card will often have predicted differently.") |>
  add_board_page("Oct14_session1", board7, S7, "the ratio wall (A1)")
print(s7, target = "Oct14_session1_materials.docx")

# ===========================================================================
# Oct14 S3 · Interrogate the Analyst
# ===========================================================================
S9 <- "Module 2 · Day 3, Session 3 · Interrogate the Analyst"
cands <- c("Did the programme work?",
           "What would have happened to these businesses without the programme?",
           "Was the sample large enough?",
           "How many businesses dropped out between the two survey rounds?",
           "Were the results statistically significant?",
           "Which assumption, if wrong, would flip the finding?",
           "Is this good quality data?",
           "If the effect were half this size, would you still recommend scale-up?")

s9 <- new_pack() |>
  title_("Sort these: strong or weak?", S9) |>
  print_line("1 set per group, cut into slips") |>
  p_("Mark each question S or W. Strong (S): the analyst must give a fact or a number to answer the question. Weak (W): the analyst can answer with one word, such as \"yes\". Then sort the slips into two piles.") |>
  add_cards(lapply(seq_along(cands), function(i) c(sprintf("%d", i), cands[i], "", "S   /   W")),
            min_height = 1.1) |>
  new_page() |>
  title_("Clinic record sheet", S9) |>
  print_line("1 per group") |>
  p_("Your area:   Methodology  /  Assumptions  /  Data quality  /  Conclusions") |>
  body_add_flextable(plain_table(data.frame(
    `Our question` = c("1.", "2.", "3.", "Follow-up:"),
    `What the analyst said` = rep("", 4),
    `Answered / Admitted they do not know / Avoided the question / Cannot be answered with this data` = rep("", 4), check.names = FALSE),
    widths = c(2.4, 2.8, 1.8)) |> height_all(height = 1.0, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  h2_("After the clinic") |>
  p_("Which unanswered question matters most? If the answer to that question were bad news, would it change your decision?") |> write_lines(2) |>
  p_("Would you approve scale-up?   Before the clinic:  Yes / No / Not without more answers.     After the clinic:  Yes / No / Not without more answers.") |>
  new_page() |>
  title_("AI prompt card", S9) |>
  print_line("1 per group") |>
  add_cards(list(
    c("Prompt A (the one people type)",
      "\"I have an evaluation of a programme that subsidised waste-management technology for businesses. It used difference-in-differences, regression discontinuity, a randomised comparison and matching. All four methods found a cost reduction of roughly 1,000 AED per business per year. List the critical questions a commissioner should ask before acting on this result.\"",
      "", "How many of the AI's questions are strong (S) questions?"),
    c("Prompt B (better)",
      "\"I am advising on whether to scale up a programme nationally. An evaluator reports a cost reduction of about 1,000 AED per business per year from difference-in-differences, with a decision threshold of 1,000 AED. First, tell me which single assumption this design rests on. Second, tell me what evidence would show that assumption holds, and what it would look like if it failed. Third, tell me what you cannot determine from the information I have given you.\"",
      "", "What did the AI say it cannot know from the information you gave?")), ncol = 1, card_width = 6.8, min_height = 2.3) |>
  new_page() |> title_("Take-away card: three questions for any analyst", S9) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("The three you will use",
                       "1. What is the comparison, and how was it chosen?",
                       "2. What has to be true for this to be causal, and did you test that assumption?",
                       "3. Does the conclusion follow, or does it go beyond the evidence?", "", "Back at work, I will ask these questions about:", "______________________________")), 8),
            min_height = 1.9) |>
  new_page() |> title_("Facilitator key", S9) |> print_line("trainer only") |>
  p_("Strong: 2, 4, 6, 8. Weak: 1, 3, 5, 7.") |>
  p_("The analyst's answers with the data (section 4 of the deck): intervals DiD -873 to -760, RDD -992 to -818, randomised -1,093 to -935, none clears 1,000 at its least generous end; the discontinuity moves from about -790 to -1,080 with the window; no business dropped out, but recycling compliance is recorded only for eligible businesses (8,570 empty rows); only two rounds, so parallel trends cannot be checked.") |>
  p_("AI list: none of its six questions needs a fact to answer, so all fail the sort. Its two flagged errors confuse sample size with selection bias.")
print(s9, target = "Oct14_session3_materials.docx")

# ===========================================================================
# Oct15 S2 · From Findings to Policy
# ===========================================================================
S11 <- "Module 2 · Day 4, Session 2 · From Findings to Policy"
s11 <- new_pack() |>
  title_("Peer critique sheet", S11) |>
  print_line("1 per pair, used when briefs are swapped") |>
  p_("Read your partner's brief as if you were the person making the decision. Answer these three questions in order.") |>
  p_("1. What does this brief want me to do?") |> write_lines(1) |>
  p_("2. What is the brief's strongest claim? Does the findings pack support that claim?") |> write_lines(1) |>
  p_("3. What has the brief left out that I would have wanted to know?") |> write_lines(1) |>
  h2_("The six checks") |>
  body_add_flextable(plain_table(data.frame(
    Check = c("The headline sentence contains the number (743)",
              "The brief states the 900 AED threshold",
              "The brief does not claim customers benefited from lower freight rates (Finding 3)",
              "The brief gives the enrolment figure (34%) and does not guess why operators did not join",
              "The brief mentions the 22% overrun in administration costs",
              "The brief does not say Finding 6 shows 'no effect'"),
    `Yes / No` = rep("", 6), check.names = FALSE), widths = c(5.6, 1.2)) |>
    height_all(height = 0.45, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  p_("Illustrative case (Tariff Shield), with invented figures.", 8.5, italic = TRUE, color = GREY) |>
  new_page() |>
  title_("The AI draft: edit the draft as a team", S11) |>
  print_line("1 per group") |>
  p_("The prompt: \"Here are six findings from an evaluation of a fuel-price stabilisation scheme for small freight operators. Write a one-page policy brief for the commissioning authority with a headline finding, key implications, a recommendation, and one risk to flag.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("Headline finding. The scheme reduced fuel costs for participating operators, delivering a net saving of 743 AED per vehicle per year. The result is statistically significant and the evaluation was rigorously conducted.") |>
  p_("Key implications. Operators passed part of the saving on to customers, with freight rates falling by 1.8%, suggesting a wider economic benefit. Some operators chose not to enrol, which may indicate a need for better communication.") |>
  p_("Recommendation. Roll the scheme out more widely, with targeted outreach to operators who did not participate.") |>
  p_("Risk to flag. Results from a pilot may not generalise to a full rollout.") |>
  p_("Correct the AI draft on this page. Find four problems in what the draft says. Then find two important things that the draft does not mention at all.", bold = TRUE) |>
  write_lines(4) |>
  new_page() |> title_("Take-away card: a brief you can trust", S11) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("What makes a brief trustworthy",
                       "1. The number is in the headline sentence.",
                       "2. The threshold is stated, even when it is missed.",
                       "3. Findings that do not support the recommendation are mentioned.",
                       "4. The recommendation is an action the reader can take or refuse.",
                       "5. The risk could really happen, and it can be monitored.",
                       "6. What was not established is stated plainly.", "", "Back at work, I will ask these questions about:", "______________________________")), 6),
            min_height = 2.5) |>
  new_page() |> title_("Facilitator key", S11) |> print_line("trainer only") |>
  p_("The AI draft: says what the scheme did and drops the threshold (743 against 900 is never mentioned); calls a non-significant pass-through (p = 0.11) a wider benefit; turns 34% enrolment into 'some operators chose not to'; recommends outreach as if it explained non-participation. Left out: the 900 AED threshold and the 22% cost overrun. The risk named is a caveat that cannot be watched.") |>
  p_("The six checks: a strong brief passes all six. Most first drafts miss the overrun or the threshold.")
print(s11, target = "Oct15_session2_materials.docx")

message("Wrote six session packs.")

# ===========================================================================
# Fiona's six sessions
# ===========================================================================
# Same building blocks and the same page order as the six packs above: the
# exercise sheets, the AI Snapshot page, the take-away card, then the
# facilitator key. Prompts, AI responses and closing questions are copied from
# each deck word for word, so the paper and the screen agree. Two packs carry a
# chart (the AI Snapshot pages of Oct12 S2 and Oct14 S2), drawn with ggplot2
# in the deck palette. Oct15 S1 and S3 read their content from qa_rating.R and
# qa_design_update.R, which the decks also read.

suppressPackageStartupMessages({
  library(estimatr)
  library(ggplot2)
})
source("qa_rating.R")
source("qa_design_update.R")

RULEBAR <- 1000
HABITS  <- "Two habits: ask the AI to ask you questions before it answers, and paste the AI's answer into a new chat and ask the AI to check that answer."

# A small chart for the page, in the deck palette.
theme_page <- function() {
  theme_minimal(base_family = "sans", base_size = 11) +
    theme(panel.grid.major.x = element_blank(), panel.grid.minor = element_blank(),
          axis.text = element_text(colour = GREY), axis.title = element_text(colour = GREY),
          plot.title = element_text(colour = DARK, face = "bold", size = 11),
          legend.position = "none")
}
# Two charts side by side, drawn into one PNG with base R's grid package.
side_by_side <- function(doc, p1, p2, w = 6.4, h = 2.6) {
  f <- tempfile(fileext = ".png")
  png(f, width = w, height = h, units = "in", res = 200, bg = "white")
  grid::grid.newpage()
  grid::pushViewport(grid::viewport(layout = grid::grid.layout(1, 2)))
  print(p1, vp = grid::viewport(layout.pos.row = 1, layout.pos.col = 1))
  print(p2, vp = grid::viewport(layout.pos.row = 1, layout.pos.col = 2))
  dev.off()
  body_add_img(doc, src = f, width = w, height = h, style = "Normal")
}
# Blank write-in rows for a table.
tall_rows <- function(ft, h = 0.55) ft |> height_all(height = h, part = "body") |> hrule(rule = "atleast", part = "body")
pfmt <- function(p) ifelse(p < 0.001, "<0.001", sprintf("%.3f", p))

# ===========================================================================
# Oct12 S2 · What Do the Numbers Say?
# ===========================================================================
S2 <- "Module 2 · Day 1, Session 2 · What Do the Numbers Say?"
# The simple GreenWaste case (SIMPLE_GREENWASTE_PLAN.md): the before-and-after
# change in waste costs for the city businesses that took part. Numbers from
# greenwaste_case.R, sourced into its own environment because it defines RULE.
s2_env <- new.env()
s2_env$gw <- read.csv("evaluation_data_GreenWaste_simple.csv")
sys.source("greenwaste_case.R", envir = s2_env)
s2_case <- s2_env$case; s2_city <- s2_env$city; s2_took <- s2_env$took
s2_tp     <- s2_city[s2_took, ]                       # city businesses that took part
s2_before <- mean(s2_tp$cost_before)
s2_after  <- mean(s2_tp$cost_after)
s2_change <- s2_case$before_after                     # after minus before
s2_pct    <- 100 * abs(s2_change) / s2_before
s2_up     <- 100 * mean(s2_tp$change > 0)             # ended with higher costs
s2_rise   <- mean(s2_city$change[!s2_took])           # did not take part
# Each business twice (after = 0, then 1), errors clustered by business: the
# same regression as the deck.
s2_long <- data.frame(business = rep(s2_tp$business, 2), after = rep(0:1, each = nrow(s2_tp)),
                      cost = c(s2_tp$cost_before, s2_tp$cost_after))
s2_fit  <- lm_robust(cost ~ after, data = s2_long, clusters = business, se_type = "stata")
s2_ci   <- sort(abs(confint(s2_fit)["after", ]))     # [1] = the smaller fall

# The AI response and the better prompt, word for word as on the slides.
S2_AI <- sprintf("\"The chart shows a %.0f%% reduction in waste costs after businesses joined GreenWaste, from %s to %s AED per business. This reduction is statistically significant (p < 0.001), confirming that the programme caused the decline. The fall was consistent across all types of business, which suggests the effect is robust. Given the size of the effect, the programme should be scaled up nationally.\"",
                 s2_pct, gfmt(s2_before), gfmt(s2_after))
S2_PROMPT <- "\"This chart shows average waste costs per business, before the GreenWaste programme and 12 months after, for the city businesses that took part. The rule for scaling up is a fall of at least 1,000 AED per business per year. Describe only what the chart shows. Then list what else could explain the change, and what comparison you would need before saying the programme caused it. Before you answer, ask me any questions you need.\""

p_s2 <- ggplot(data.frame(when = factor(c("Before", "After"), levels = c("Before", "After")),
                          y = c(s2_before, s2_after)), aes(when, y)) +
  geom_col(fill = BLUE, width = 0.6) +
  geom_text(aes(label = paste(gfmt(y), "AED")), vjust = -0.5, size = 4.2) +
  scale_y_continuous(limits = c(0, s2_before * 1.15), expand = c(0, 0)) +
  labs(x = NULL, y = "Waste costs per business, AED") + theme_page()

s2 <- new_pack() |>
  title_("Annotate this output", S2) |>
  print_line("1 per participant") |>
  p_("The before-and-after regression for the city businesses that took part in GreenWaste. Outcome: waste costs in AED per business per year, before the programme (after = 0) and 12 months later (after = 1). Standard errors are clustered by business. The p-value is the column R printed as Pr(>|t|).") |>
  body_add_flextable(plain_table(data.frame(
    ` ` = c("(Intercept)", "after"),
    Estimate = gfmt(coef(s2_fit), 1), `Std. Error` = gfmt(s2_fit$std.error, 1),
    `p-value` = pfmt(s2_fit$p.value), `CI Lower` = gfmt(s2_fit$conf.low, 1),
    `CI Upper` = gfmt(s2_fit$conf.high, 1), check.names = FALSE),
    widths = c(1.2, 1.0, 1.1, 0.9, 1.0, 1.0))) |>
  illustrative() |>
  h2_("On the table above") |>
  p_("1. Which number is the before-and-after change? Circle that number.") |>
  p_("2. Where is the confidence interval for that change? Draw a box around the interval.") |>
  p_("3. Which number is the average before the programme? Underline that number. Why is it not the effect of GreenWaste?") |>
  write_lines(2) |>
  p_("4. To know whether GreenWaste caused the change, what would you compare these businesses with? Write the question you would ask the evaluator.") |>
  write_lines(2) |>
  new_page() |>
  title_("AI Snapshot: ask AI to read the chart", S2) |>
  print_line("1 per pair") |>
  p_("Average waste costs per business, before GreenWaste and 12 months after, for the city businesses that took part.") |>
  body_add_gg(p_s2, width = 3.6, height = 2.4) |>
  illustrative() |>
  p_("To give the AI the chart, photograph the chart on this sheet and attach the photo to your prompt.") |>
  p_("The prompt most people would type, with a picture of the chart:", bold = TRUE) |>
  p_("\"What does this chart show? Did GreenWaste work?\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_(S2_AI) |>
  p_("In pairs: underline each claim in the response that you can see in the chart. Cross out each claim that the chart does not show.", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_(S2_PROMPT, italic = TRUE) |>
  p_("1. Run both prompts with the same chart.") |>
  p_("2. What does the second answer include that the first answer left out?") |>
  p_("3. Paste the second answer into a new chat and ask: which of these claims does the chart not support? Which claims does the new chat find?") |>
  new_page() |> title_("Take-away card: three questions to ask the evaluator", S2) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions to ask the evaluator",
                       "1. How big? In the units the decision is written in, not a percentage.",
                       "2. How sure? Does the whole confidence interval meet the decision rule, not just exclude zero?",
                       "3. Compared to what? Which group, which period, and did that group change too?",
                       "", "Back at work: think of the last figure you received. Was it a before-and-after comparison? What would you compare it with?",
                       "______________________________")), 6),
            min_height = 2.2) |>
  new_page() |> title_("Facilitator key", S2) |> print_line("trainer only") |>
  h2_("Annotate this output") |>
  p_(sprintf("1. The change is the after row: %s AED per business (the slides round it to %s). 2. Its interval runs from %s to %s. 3. The intercept, %s AED, is the average before the programme for the city businesses that took part. It is a starting level with nothing to compare it against, so it says nothing about what GreenWaste did. 4. Businesses that did not take part, over the same 12 months. Their costs rose by %s AED per business with no programme, so the fall of %s likely understates what GreenWaste did. Whether they are a fair comparison (they all scored above 58) is the question for Session 3.",
             gfmt(coef(s2_fit)[["after"]], 1), gfmt(s2_change), gfmt(s2_fit$conf.low[["after"]], 1),
             gfmt(s2_fit$conf.high[["after"]], 1), gfmt(coef(s2_fit)[["(Intercept)"]], 1),
             gfmt(s2_rise), gfmt(abs(s2_change)))) |>
  p_(sprintf("Against the rule of %s AED: the estimate (%s) and the whole interval (%s to %s) fall short. The result is precise, so on how big and how sure the before-and-after number says do not scale up; compared to what is still open.",
             gfmt(RULEBAR), gfmt(abs(s2_change)), gfmt(s2_ci[1]), gfmt(s2_ci[2]))) |>
  h2_("AI Snapshot") |>
  p_(sprintf("Correct: \"%.0f%% reduction, %s to %s\". The bars show %s and %s; the %.0f%% can be worked out from them. Not on the chart: \"p < 0.001\"; the model supplied a p-value it was never given. \"Confirming that the programme caused\": a before-and-after chart cannot show cause, and a small p-value says the fall is unlikely to be noise, not what caused it. \"Consistent across all types of business\": invented; the chart has no types of business, and %.0f%% of the businesses that took part ended with higher costs. \"Should be scaled up nationally\": a recommendation with no rule and no comparison; the rule asks for %s AED and the bars show a fall of %s.",
             s2_pct, gfmt(s2_before), gfmt(s2_after), gfmt(s2_before), gfmt(s2_after), s2_pct, s2_up,
             gfmt(RULEBAR), gfmt(abs(s2_change)))) |>
  p_("With the second prompt, listen for answers that check the fall against the 1,000 AED rule, ask what happened to businesses that did not take part, and ask whether prices or waste fees changed.")
print(s2, target = "Oct12_session2_materials.docx")

# ===========================================================================
# Oct13 S1 · Reading DiD Results
# ===========================================================================
S4 <- "Module 2 · Day 2, Session 1 · Reading DiD Results"
# The simple GreenWaste case: the rest of the city, where businesses scoring
# 58 or below took part. Numbers from greenwaste_case.R, in its own environment.
s4_env <- new.env()
s4_env$gw <- read.csv("evaluation_data_GreenWaste_simple.csv")
sys.source("greenwaste_case.R", envir = s4_env)
s4_city <- s4_env$city; s4_took <- s4_env$took; s4_pilot <- s4_env$pilot
off_b <- mean(s4_city$cost_before[s4_took]);  off_a <- mean(s4_city$cost_after[s4_took])
ctl_b <- mean(s4_city$cost_before[!s4_took]); ctl_a <- mean(s4_city$cost_after[!s4_took])
off_chg <- off_a - off_b; ctl_chg <- ctl_a - ctl_b; did_hand <- off_chg - ctl_chg
s4_long <- data.frame(business = rep(s4_city$business, 2), after = rep(0:1, each = nrow(s4_city)),
                      took_part = rep(s4_city$took_part, 2),
                      cost = c(s4_city$cost_before, s4_city$cost_after))
fit_did <- lm_robust(cost ~ after * took_part, data = s4_long,
                     clusters = business, se_type = "stata")
did_ci  <- confint(fit_did)["after:took_part", ]
did_av  <- sort(abs(did_ci))
s4_wait <- s4_pilot[s4_pilot$took_part == 0, ]
wait_chg <- mean(s4_wait$cost_after - s4_wait$cost_before)
did_rows <- data.frame(
  ` ` = c("(Intercept)", "After", "Took part", "After x Took part"),
  Coefficient = gfmt(coef(fit_did)), `Std. error` = gfmt(fit_did$std.error),
  p = pfmt(fit_did$p.value),
  `95% CI` = sprintf("[%s, %s]", gfmt(fit_did$conf.low), gfmt(fit_did$conf.high)),
  check.names = FALSE)

s4 <- new_pack() |>
  title_("By hand: four numbers", S4) |>
  print_line("1 per participant, single-sided: the next sheet is handed out later") |>
  p_("GreenWaste businesses in the rest of the city: those scoring 58 or below took part, the rest did not. Average annual waste costs (AED), before and after. The decision rule for scale-up: the programme must save at least 1,000 AED per business.") |>
  body_add_flextable(plain_table(data.frame(
    ` ` = c("Took part", "Did not take part", "Difference of the changes"),
    Before = c(gfmt(off_b), gfmt(ctl_b), ""), After = c(gfmt(off_a), gfmt(ctl_a), ""),
    Change = c("", "", ""), check.names = FALSE), widths = c(2.6, 1.2, 1.2, 1.4)) |> tall_rows(0.45)) |>
  h2_("Two subtractions") |>
  p_("First difference: each group's change over time. This change removes fixed differences between the groups, but it still contains the general time trend.") |>
  p_("Change for \"took part\":  ________      Change for \"did not take part\":  ________") |>
  p_("Second difference: the difference between those two changes. This second subtraction removes the time trend and leaves the estimated effect.") |>
  p_("Difference-in-differences = (change for \"took part\") minus (change for \"did not\") =  ________ AED") |>
  p_("Is the saving at least 1,000 AED?   Yes  /  No") |>
  new_page() |>
  title_("Which row is the impact?", S4) |>
  print_line("1 per participant, separate sheet; hand out at 'Running the regression', after the hand calculation") |>
  p_("The same data as a regression, the way an evaluator would report it. Each business appears twice (before and after), so standard errors are clustered by business.") |>
  body_add_flextable(plain_table(did_rows, widths = c(2.3, 1.1, 1.0, 0.7, 1.6))) |>
  p_("1. Circle the row that is the programme's effect. Is that row's coefficient the same number you got by hand?") |>
  p_("2. Two other rows are often reported as the effect by mistake. What does each of these two rows actually measure?") |>
  p_("After measures  __________________      Took part measures  __________________") |>
  p_("3. Look at the end of the effect's confidence interval with the smallest saving:  ________ AED.   Is that saving at least 1,000 AED?   Yes  /  No") |>
  p_("4. Costs were measured only once before the programme and once after. Because of this, what can you not check about the two groups before the programme started?") |>
  write_lines(2) |>
  new_page() |>
  title_("AI Snapshot: explaining the table", S4) |>
  print_line("1 per pair") |>
  p_("Paste the regression table into an AI tool with this prompt:", bold = TRUE) |>
  p_("\"Explain this regression table to a non-technical decision-maker, and say what should be checked before believing the result.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_(sprintf("The table reports a difference-in-differences estimate. The programme reduced costs by %s AED, and the effect is highly statistically significant (p < 0.001), so the programme was a success. The confidence interval does not include zero, which confirms the finding is robust.", gfmt(abs(did_hand)))) |>
  p_("The parallel trends assumption has been satisfied. The result clears the 1,000 AED threshold required for scale-up.") |>
  p_("Underline the sentences that the table supports. Cross out the sentences that the table does not support.", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"We have a difference-in-differences table. The data has two waves only, one before and one after, so no pre-trend test is possible. The decision rule is 1,000 AED. Explain what the table supports and, separately, list what it cannot tell us. Ask me questions before you answer.\"", italic = TRUE) |>
  p_("With the second prompt, does the AI still claim that parallel trends were satisfied? Then paste the second answer into a new chat and ask the AI to check that answer for claims about tests that were never run.") |>
  h2_("If you have time: a prompt that pushes the AI towards an answer") |>
  p_(sprintf("\"Our DiD shows an %s AED cut in costs (p<0.001). Write two sentences for the minister recommending scale-up.\"", gfmt(abs(did_hand))), italic = TRUE) |>
  p_("Does the AI mention the 1,000 AED rule or parallel trends without being asked?") |>
  new_page() |> title_("Take-away card: three questions for a DiD result", S4) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions to ask any evaluator presenting DiD",
                       "1. Which row is the estimate? Does its whole confidence interval meet our decision rule, not just exclude zero?",
                       "2. How many periods of data before the programme? Were the two groups changing in the same way before the programme?",
                       "3. Which comparison group was used, how was it chosen, and how did it differ before the programme?",
                       "", "Back at work, I will ask these questions about:", "______________________________")), 6),
            min_height = 2.3) |>
  new_page() |> title_("Facilitator key", S4) |> print_line("trainer only") |>
  h2_("Four numbers") |>
  p_(sprintf("Took part %s to %s: change %+.0f. Did not take part %s to %s: change %+.0f. Difference of the changes: %.0f AED. It does not clear 1,000. Watch the sign: the comparison group went up, so the effect is bigger than the %.0f fall in the top row.",
             gfmt(off_b), gfmt(off_a), off_chg, gfmt(ctl_b), gfmt(ctl_a), ctl_chg, did_hand, abs(off_chg))) |>
  h2_("Which row is the impact?") |>
  p_(sprintf("1. After x Took part, %s AED: the same number as by hand. 2. After (%s) is the time trend, what happened to everyone; Took part (%s) is the baseline gap, how far apart the groups started. Many pick Took part because it is large and has the words in it. 3. %s AED; the interval is %s to %s, and even its most generous end (%s) is short of 1,000. 4. Whether the groups were already moving in parallel: a pre-trend check needs at least two periods before the programme. In the deck, the pilot's waiting businesses (score 58 or below, no programme) give a partial check: their costs rose %s AED against %s for the city businesses that did not take part, so the DiD understates the effect.",
             gfmt(coef(fit_did)[["after:took_part"]]), gfmt(coef(fit_did)[["after"]]),
             gfmt(coef(fit_did)[["took_part"]]), gfmt(did_av[1]), gfmt(did_ci[1]), gfmt(did_ci[2]),
             gfmt(did_av[2]), gfmt(wait_chg), gfmt(ctl_chg))) |>
  h2_("AI Snapshot") |>
  p_(sprintf("Supported by the table: the %s AED estimate and p < 0.001. Not supported: \"so the programme was a success\" answers whether the effect is non-zero, not whether it clears 1,000. \"Does not include zero, which confirms the finding is robust\": not zero and big enough are different claims. \"The parallel trends assumption has been satisfied\" is the serious one: with one period before the programme it cannot be tested, so the model reported a test that was never run, and the pilot's waiting businesses suggest it fails. \"Clears the 1,000 AED threshold\" is false: even the interval's most generous end is %s AED.", gfmt(abs(did_hand)), gfmt(did_av[2]))) |>
  p_("With the second prompt, check whether the parallel-trends claim disappears. Supplying the constraint makes the error less likely; it does not rule it out.")
print(s4, target = "Oct13_session1_materials.docx")

# ===========================================================================
# Oct13 S3 · Reading Matching Results
# ===========================================================================
S6 <- "Module 2 · Day 2, Session 3 · Reading Matching Results"
# The simple GreenWaste case: the rest of the city. Evaluator A matches on four
# characteristics; evaluator B never measured manager age. The same matcher as
# the deck (nearest neighbour on standardised characteristics, with
# replacement), so the numbers agree with greenwaste_case.R's match_on().
s6_env <- new.env()
s6_env$gw <- read.csv("evaluation_data_GreenWaste_simple.csv")
sys.source("greenwaste_case.R", envir = s6_env)
s6_city <- s6_env$city; s6_took <- s6_city$took_part == 1
S6_VARS <- c("manager_age", "staff", "area", "filtration")
s6_match <- function(vars) {
  X  <- scale(s6_city[, vars, drop = FALSE])
  t  <- which(s6_took); co <- which(!s6_took)
  Xc <- t(X[co, , drop = FALSE])
  tw <- co[vapply(t, function(i) which.min(colSums((Xc - X[i, ])^2)), 1L)]
  m  <- rbind(s6_city[t, ], s6_city[tw, ])
  r  <- lm_robust(cost_after ~ took_part, data = m, clusters = business)
  sdv <- function(v) (mean(s6_city[[v]][t]) - mean(s6_city[[v]][tw])) / sd(s6_city[[v]])
  list(est = coef(r)[["took_part"]], ci = c(r$conf.low[["took_part"]], r$conf.high[["took_part"]]),
       used = length(unique(tw)), sd = sapply(vars, sdv),
       age_gap = abs(mean(s6_city$manager_age[t]) - mean(s6_city$manager_age[tw])),
       base_gap = abs(mean(s6_city$cost_before[t]) - mean(s6_city$cost_before[tw])))
}
s6_A <- s6_match(S6_VARS)
s6_B <- s6_match(setdiff(S6_VARS, "manager_age"))
stopifnot(abs(s6_A$est - s6_env$case$matching) < 1e-6, abs(s6_B$est - s6_env$case$matching_no_age) < 1e-6)
s6_avA <- sort(abs(s6_A$ci)); s6_avB <- sort(abs(s6_B$ci))
s6_n <- sum(s6_took)
# Honest balance cell: "yes" only when every matched characteristic is within 0.1.
bal_cell <- function(sds) {
  sds <- abs(sds)
  if (max(sds) <= 0.1) sprintf("yes (largest difference %.2f)", max(sds))
  else sprintf("partly: %d of %d over 0.1 (largest difference %.2f)", sum(sds > 0.1), length(sds), max(sds))
}
verdict <- function(av) sprintf("%s against %s: %s", gfmt(av[1]), gfmt(RULEBAR),
                                if (av[1] >= RULEBAR) "clears" else "below the rule")

compare_rows <- data.frame(
  ` ` = c("Matched on", "Comparison businesses used as twins (some more than once)",
          "Balanced on what they matched on?", "Manager age after matching (not in B's table)",
          "Was the outcome similar before the programme?", "Estimate, costs after the programme",
          "Least generous end of the 95% interval, against the rule"),
  `Evaluator A` = c("manager age, staff, premises, filtration",
                    sprintf("%s twins for %s businesses", gfmt(s6_A$used), gfmt(s6_n)),
                    bal_cell(s6_A$sd), sprintf("%.0f years apart", s6_A$age_gap),
                    sprintf("close (%s AED apart)", gfmt(s6_A$base_gap)),
                    sprintf("%s AED", gfmt(s6_A$est)), verdict(s6_avA)),
  `Evaluator B` = c("staff, premises, filtration",
                    sprintf("%s twins for %s businesses", gfmt(s6_B$used), gfmt(s6_n)),
                    bal_cell(s6_B$sd), sprintf("%.0f years apart", s6_B$age_gap),
                    sprintf("no (%s AED apart)", gfmt(s6_B$base_gap)),
                    sprintf("%s AED", gfmt(s6_B$est)), verdict(s6_avB)),
  check.names = FALSE)

s6 <- new_pack() |>
  title_("By hand: find the twins", S6) |>
  print_line("1 per group (8); the profile cards on the next page are for the card or walking version") |>
  p_("As a group: three businesses that took part in GreenWaste and four that did not. Pair each business that took part with its closest twin, matching on who they are (manager age and size), not on their cost. Then take the average cost difference across the three pairs. Your group reports one answer: the three pairs, the average, and the business that is nobody's twin.") |>
  p_("Took part", bold = TRUE, color = DARK) |>
  body_add_flextable(plain_table(data.frame(` ` = c("A", "B", "C"), `Manager age` = c(45, 38, 52),
    Size = c("small", "large", "small"), `Cost after (AED)` = c("900", "1,400", "700"), check.names = FALSE),
    widths = c(0.6, 1.4, 1.2, 1.6))) |>
  p_("Did not take part", bold = TRUE, color = DARK) |>
  body_add_flextable(plain_table(data.frame(` ` = c("1", "2", "3", "4"), `Manager age` = c(39, 46, 51, 29),
    Size = c("large", "small", "small", "large"), `Cost after (AED)` = c("2,300", "1,900", "1,800", "2,600"),
    check.names = FALSE), widths = c(0.6, 1.4, 1.2, 1.6))) |>
  p_("These seven businesses are invented for the exercise.", 8.5, italic = TRUE, color = GREY) |>
  h2_("Your pairs") |>
  body_add_flextable(plain_table(data.frame(`Took part` = c("A", "B", "C"), `Its twin` = "",
    `Cost difference (took part minus twin)` = "", check.names = FALSE), widths = c(1.2, 1.4, 3.0)) |> tall_rows(0.4)) |>
  p_("Average difference across the three pairs:  ________ AED") |>
  p_("One business that did not take part is nobody's twin. Which business? What happens to that business in the analysis?") |>
  write_lines(2) |>
  new_page() |>
  title_("Find the twins: profile cards", S6) |>
  print_line("1 set of seven cards per group (8 sets), cut. Groups can pair the cards on the table, or the trainer runs the walking version with one set") |>
  add_cards(c(
    lapply(1:3, function(i) c(sprintf("%s  ·  Took part", c("A", "B", "C")[i]),
      sprintf("Manager age: %d", c(45, 38, 52)[i]), sprintf("Size: %s", c("small", "large", "small")[i]),
      sprintf("Cost after: %s AED", c("900", "1,400", "700")[i]), "", "Find your closest twin. Match on who you are, not on cost.")),
    lapply(1:4, function(i) c(sprintf("%d  ·  Did not take part", i),
      sprintf("Manager age: %d", c(39, 46, 51, 29)[i]), sprintf("Size: %s", c("large", "small", "small", "large")[i]),
      sprintf("Cost after: %s AED", c("2,300", "1,900", "1,800", "2,600")[i]), "", "Wait to be chosen as someone's twin."))),
    ncol = 2, min_height = 2.25, title_size = 20, body_size = 15) |>
  p_("These seven businesses are invented for the exercise.", 8.5, italic = TRUE, color = GREY) |>
  new_page() |>
  title_("Which evaluator would you trust?", S6) |>
  print_line("1 per group") |>
  p_(sprintf("Two matching studies of the same GreenWaste businesses. Evaluator A matched on manager age, staff, premises and filtration. Evaluator B used a survey that never asked the manager's age. The decision rule: GreenWaste must cut costs by at least %s AED.", gfmt(RULEBAR))) |>
  body_add_flextable(plain_table(compare_rows, widths = c(2.4, 2.2, 2.2)) |>
    bg(i = c(4, 5), bg = "#F8E9EA", part = "body")) |>
  h2_("In your group, ten minutes") |>
  p_("1. Which evaluator gives you more confidence, and why?") |> write_lines(1) |>
  p_("2. What would you ask evaluator B that A does not raise?") |> write_lines(1) |>
  p_("3. B's whole interval clears the rule; A's straddles it. Does that change your answer?") |> write_lines(1) |>
  p_("Our verdict on A:   Act  /  Act with conditions  /  Send back to the evaluator") |>
  p_("Our verdict on B:   Act  /  Act with conditions  /  Send back to the evaluator") |>
  new_page() |>
  title_("AI Snapshot: comparing two studies", S6) |>
  print_line("1 per group") |>
  p_("The prompt, with the side-by-side table and both balance tables pasted in:", bold = TRUE) |>
  p_("\"Summarise the key differences between these two studies and identify what a commissioner should flag.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_(sprintf("Evaluator A: Manager age remains somewhat imbalanced. The programme reduced costs by around %s AED, with an interval that straddles the 1,000 AED threshold.", gfmt(round(abs(s6_A$est), -1)))) |>
  p_(sprintf("Evaluator B: Matching was even stronger, with near-perfect balance on every characteristic. The matched estimate shows a cut of %s AED, comfortably exceeding the 1,000 AED threshold, so the programme should be scaled.", gfmt(abs(s6_B$est)))) |>
  p_("In groups (four minutes): underline each sentence you agree is correct. Cross out each sentence that is wrong or claims too much.", bold = TRUE) |>
  write_lines(3) |>
  new_page() |> title_("The same question, a better prompt", S6) |>
  print_line("1 per group, cut into strips. Take-home: hand out after the debrief, since the prompt names the checks") |>
  add_cards(rep(list(c("Take home: run this prompt too, and compare",
                       "\"Two matching studies of the same businesses. For each: what was left off the list; were the pairs' costs similar before the programme; how far apart are characteristics that were not matched on? Our decision rule is below. Ask me questions before you answer.\"",
                       "Run both prompts, then compare: what did each answer get wrong, and what did each answer explain well? Then paste the second answer into a new chat and ask the AI to check that answer for claims that go further than the evidence.")), 4),
            ncol = 1, card_width = 6.8, min_height = 1.9) |>
  new_page() |> title_("Take-away card: five questions for a matching result", S6) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Five questions to ask any evaluator presenting matching",
                       "1. What did you match on, and what was left out?",
                       "2. How many treated units had no close match, and how often was each twin reused?",
                       "3. Are the matched groups similar on their characteristics? Was the outcome itself similar before the programme?",
                       "4. Does the answer hold if you change what you matched on?",
                       "5. What else might differ that you could not measure?",
                       "", "Back at work, I will ask these questions about:", "______________________________")), 6),
            min_height = 2.6) |>
  new_page() |> title_("Facilitator key", S6) |> print_line("trainer only") |>
  h2_("Find the twins") |>
  p_("A with 2, B with 1, C with 3. Differences of -1,000, -900 and -1,100: an average of -1,000 AED. Business 4 is nobody's twin, so it is set aside. Listen for anyone matching on cost: that is matching on the outcome, which builds the answer into the comparison.") |>
  p_("Three ways to run it; decide on the day. (1) Worksheet: each group works through the sheet together and reports one answer. (2) Cards on the table: each group lays out its seven profile cards and pairs them physically, then fills in the sheet. (3) Walking version: take one set of cards and give one card to a volunteer from each of seven groups; the eighth group checks the matches. A, B and C walk to the person they think is their twin; their own groups explain the match. Business 4 is left standing alone: ask the room what happens to it in the analysis (it is set aside, the overlap idea that returns in Section 2). Few people walk, and each group reports through its volunteer.") |>
  h2_("Which evaluator would you trust?") |>
  p_(sprintf("A is the more trustworthy study, and it cannot show it clears the rule: it estimates %s AED, and the least generous end is %s. B gives the more attractive answer (%s AED, least generous end %s) because it left out manager age, which went with the efficiency score that decided who took part: B's pairs have managers %.0f years apart and costs already %s AED apart before the programme. The lottery in the pilot district found %s, close to A. Rows 4 and 5 separate the two studies, and neither appears in a typical results table.",
             gfmt(s6_A$est), gfmt(s6_avA[1]), gfmt(s6_B$est), gfmt(s6_avB[1]), s6_B$age_gap,
             gfmt(s6_B$base_gap), gfmt(s6_env$case$rct))) |>
  p_("For the question to evaluator B, the sharpest is: what decided who took part, and is all of it on your list? A close second: were the pairs' costs similar before the programme?") |>
  p_("Question 3: B's interval clears the rule only because B's pairs differ in something B did not measure. A clean-looking interval does not rescue a comparison that is not like with like.") |>
  p_("Suggested verdicts. A: act with conditions (a sound study whose interval straddles the rule; ask whether the answer holds on a different list). B: send back (ask for manager age, or for the pairs' costs before the programme).") |>
  h2_("AI Snapshot") |>
  p_(sprintf("A is reported accurately, including the interval that straddles the rule. Three false assurances about B: \"near-perfect balance on every characteristic\" holds only for the three it matched on, and the pairs' managers are %.0f years apart; \"comfortably exceeding\" ignores that the pairs were already %s AED apart before the programme; \"should be scaled\" rests on the first two and is stated most confidently. The model had the details in front of it and still went with the headline. Check its summary against the table you gave it.",
             s6_B$age_gap, gfmt(s6_B$base_gap)))
print(s6, target = "Oct13_session3_materials.docx")

# ===========================================================================
# Oct14 S2 · What Can You Read? What Might Be Wrong?
# ===========================================================================
S8 <- "Module 2 · Day 3, Session 2 · What Can You Read? What Might Be Wrong?"
base0 <- subset(gw, treatment_neighborhood == 1 & round == 0)
enr <- base0$waste_management_costs[base0$enrolled == 1]
non <- base0$waste_management_costs[base0$enrolled == 0]
mean_enr <- mean(enr); mean_non <- mean(non); vgap <- mean_non - mean_enr
sd_gap <- vgap / sd(c(enr, non))
sz <- read.csv("evaluation_data_SchoolZoneRCT.csv")
szp <- subset(sz, arm == "Package")   # pair 3 uses the package segments only, as the deck does
sc <- merge(setNames(subset(szp, round == 0, c(segment_id, child_collisions)), c("segment_id", "base")),
            setNames(subset(szp, round == 1, c(segment_id, child_collisions)), c("segment_id", "follow")))
pooled_pct  <- 100 * (sum(sc$follow) - sum(sc$base)) / sum(sc$base)
has_base    <- sc$base > 0
sc_pos      <- transform(sc[has_base, ], pct = 100 * (follow - base) / base, absolute = follow - base)
big_pct     <- head(sc_pos[order(sc_pos$pct), ], 6)
big_abs     <- head(sc_pos[order(sc_pos$absolute), ], 6)
n_to_zero   <- sum(sc_pos$follow == 0)
n_to_zero_small <- sum(sc_pos$follow == 0 & sc_pos$base <= 4)
big_overlap <- length(intersect(big_pct$segment_id, big_abs$segment_id))
average_pct <- mean(100 * (sc$follow - sc$base)[has_base] / sc$base[has_base])
cb_nom <- 816 * 5; cb_dis <- sum(816 / 1.05^(2:6))
flip_rate <- uniroot(function(r) sum(816 / (1 + r)^(2:6)) - 1800, c(0, 1))$root
sev <- c(minor = sum(sz$minor_collisions), injury = sum(sz$injury_collisions), child = sum(sz$child_collisions))

bars <- data.frame(g = c("Enrolled", "Not enrolled"), y = c(mean_enr, mean_non))
fig_axis <- function(floor, top, title) {
  ggplot(bars) +
    geom_rect(aes(xmin = as.numeric(factor(g)) - 0.3, xmax = as.numeric(factor(g)) + 0.3,
                  ymin = floor, ymax = y, fill = g)) +
    geom_text(aes(x = as.numeric(factor(g)), y = y, label = gfmt(y)), vjust = -0.5, size = 3.6) +
    scale_fill_manual(values = c(BLUE, LIGHT)) +
    scale_x_continuous(breaks = 1:2, labels = bars$g) +
    scale_y_continuous(limits = c(floor, top), expand = c(0, 0), labels = function(v) gfmt(v)) +
    labs(x = NULL, y = "Mean annual waste cost (AED)", title = title) + theme_page()
}

s8 <- new_pack() |>
  title_("Six pairs tracker", S8) |>
  print_line("1 per participant; filled in as the session runs") |>
  p_("Each section of this session shows the same data drawn two ways. For every pair, discuss in groups: what is the figure telling you, and what might be wrong or misleading about the figure?") |>
  body_add_flextable(plain_table(data.frame(
    Pair = c("1. The same gap, two axes", "2. A bar of means, then the distributions",
             "3. Percentages: zero bases, biggest wins, two averages", "4. After only, then before and after",
             "5. Savings added up, then discounted", "6. The pie, then the counts"),
    `What is the figure telling you?` = "", `What might be wrong or misleading?` = "", check.names = FALSE),
    widths = c(2.0, 2.4, 2.4)) |> tall_rows(0.85)) |>
  h2_("Predict before the reveal") |>
  p_("Share of enrolled businesses that paid more than the average non-enrolled business:  ________ %") |>
  p_("The percentage change in child collisions with all segments added together, and the average of each segment's own percentage change: are these two numbers close, or far apart?  ________") |>
  p_("The discount rate at which five years of savings no longer cover the 1,800 AED cost:  ________ %") |>
  new_page() |>
  title_("AI Snapshot: which chart is fairer?", S8) |>
  print_line("1 per group") |>
  p_("The two GreenWaste baseline figures: the same gap between enrolled and not-enrolled businesses, drawn twice.") |>
  side_by_side(fig_axis(0, 2400, "Figure A"), fig_axis(1300, 2200, "Figure B")) |>
  p_("Give the model both figures and this prompt:", bold = TRUE) |>
  p_("\"Which of these two charts better represents the difference between the two groups, and why?\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("Both charts present the same underlying data accurately. The truncated-axis chart is often preferable for a policy audience because it makes the difference visible, and a y-axis that starts at zero is not a requirement in professional data visualisation. On balance the truncated version communicates the finding more effectively, and a reader who wants the absolute values can consult the data labels.") |>
  p_("Four minutes. Is the AI's answer correct? Does the answer respond to the question that was asked? What does the answer explain well?", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"This chart will sit beside the claim 'the programme reduced costs substantially'. Is the axis appropriate for that claim, for a non-technical reader?\"", italic = TRUE) |>
  p_("What changes in the AI's answer with this prompt?") |>
  p_(HABITS) |>
  new_page() |> title_("Take-away card: five rules for any figure", S8) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Five rules for any figure",
                       "1. Read the axis before the shape.",
                       "2. Ask what each bar is an average of.",
                       "3. Check what each percentage is a percentage of.",
                       "4. Compare changes, not levels.",
                       "5. Show future savings at today's value (discounted).",
                       "", "The fastest check: read the y-axis, then the sentence under the figure. Large compared to what?",
                       "", "Questions I will bring to the next session (the QA clinic):", "______________________________", "______________________________")), 4),
            min_height = 3.6) |>
  new_page() |> title_("Facilitator key", S8) |> print_line("trainer only") |>
  h2_("The six pairs") |>
  p_(sprintf("1. The gap is %s AED in both figures (%.0f%% of the non-enrolled mean, %.2f standard deviations). The truncated axis starts at 1,300, so the gap fills the frame. Cover the bars, read the axis, uncover.", gfmt(vgap), 100 * vgap / mean_non, sd_gap)) |>
  p_(sprintf("2. The two groups overlap very little: only %.1f%% of enrolled businesses paid more than the average non-enrolled business. A bar of means cannot show that.", 100 * mean(enr > mean_non))) |>
  p_(sprintf("3. %d of the %d package segments had no child collisions at baseline, so a percentage change is undefined for them. %d package segments fell to zero, a 100%% cut, %d of them from four collisions or fewer. The two top-six lists share %d segment%s and answer different questions: where the package worked best, and where it prevented the most harm (%d collisions removed).",
             sum(sc$base == 0), nrow(sc), n_to_zero, n_to_zero_small, big_overlap,
             if (big_overlap == 1) "" else "s", as.integer(-sum(big_abs$absolute)))) |>
  p_(sprintf("4. After only, the gap is %s AED. The comparison group started %s AED worse off and its costs were rising anyway; the DiD estimate is %s AED.", gfmt(ctl_a - off_a), gfmt(ctl_b - off_b), gfmt(abs(did_hand)))) |>
  p_(sprintf("5. Added up, five years of savings reach %s AED; discounted at 5%%, %s. The %s AED gap comes from the discount rate alone. Ratio %.2f.", gfmt(cb_nom), gfmt(cb_dis), gfmt(cb_nom - cb_dis), cb_dis / 1800)) |>
  p_(sprintf("6. The slices overlap: every child collision is also an injury collision, so the percentages are wrong as drawn. The pie also pools both rounds and hides the counts (minor %s, injury %s, of which child %s).", gfmt(sev[["minor"]]), gfmt(sev[["injury"]]), gfmt(sev[["child"]]))) |>
  h2_("Predictions") |>
  p_(sprintf("%.1f%%. Pooled %.1f%% against an average of %.1f%% across the %d package segments with a baseline: far apart, because the pooled figure weights segments by their collisions. About %.0f%%.",
             100 * mean(enr > mean_non), pooled_pct, average_pct, sum(has_base), 100 * flip_rate)) |>
  h2_("AI Snapshot") |>
  p_(sprintf("Each sentence is accurate. The answer skips who is reading the figure and the sentence beside it: a truncated axis suits \"a difference exists\", not \"a large difference\". It never checks either picture against the number (%s AED, %.2f standard deviations), and it does not ask who the audience is. The better prompt names both.", gfmt(vgap), sd_gap))
print(s8, target = "Oct14_session2_materials.docx")

# ===========================================================================
# Oct15 S1 · Is This Evidence Credible?
# ===========================================================================
S10 <- "Module 2 · Day 4, Session 1 · Is This Evidence Credible?"
LIGHT_COL <- c(Green = "#2E7D4F", Amber = "#A9561F", Red = RED)
s10 <- new_pack() |>
  title_("Credibility rating sheet", S10) |>
  print_line("1 per participant, with the report") |>
  p_("Work through the report one section at a time. For each section, circle a colour and write the main reason for your colour. Rate the executive summary first, on your own, before reading the rest of the report. Then rate Sections 3 to 7 in pairs. The Area to check column tells you which part of yesterday's QA checklist to use.") |>
  p_("Wall grid: after each rating, put a sticky note with a few words of your reason on the wall grid, in the section's column and your colour's row. Summary: one note each. Sections 3 to 7: one note per pair. No names.", bold = TRUE) |>
  body_add_flextable(plain_table(setNames(rating_scale, c("Colour", "What it means")), widths = c(1.2, 5.6))) |>
  p_("Section 2, The programme, describes the programme and is not rated.", 8.5, italic = TRUE, color = GREY) |>
  body_add_flextable(plain_table(data.frame(
    Section = rating_sections$section, `Area to check` = rating_sections$area, Colour = "Green  /  Amber  /  Red",
    `Your reason for selecting this colour` = "", `If amber or red: what would be needed to shift the colour to green?` = "", check.names = FALSE),
    widths = c(1.4, 1.1, 1.1, 1.8, 1.4)) |> tall_rows(0.85)) |>
  new_page() |>
  title_("Your verdict", S10) |>
  print_line("on the back of the rating sheet") |>
  p_("Based on this evaluation, would you approve national scale-up?") |>
  p_("Before reading the report:   Yes  /  No  /  Not without more answers") |>
  p_("After reading the report:     Yes  /  No  /  Not without more answers") |>
  p_("The single most important problem you found:") |> write_lines(2) |>
  p_("The strongest part of the report. Is that part strong enough to support the recommendation, despite the problems you found?") |> write_lines(2) |>
  p_("Compare your colour for the executive summary with your colour for the results section. If they differ, what did the summary lead you to believe?") |>
  write_lines(3) |>
  new_page() |>
  title_("AI Snapshot: a credibility verdict", S10) |>
  print_line("1 per group") |>
  p_("The report is on the course website: download Oct15_session1_report.docx from the landing page.", 9, italic = TRUE, color = GREY) |>
  p_("The prompt, with the report pasted in:", bold = TRUE) |>
  p_("\"Here is an evaluation report on a programme that subsidised waste-management technology for businesses. It found a cost reduction of approximately 1,000 AED per business per year and recommends national scale-up. Assess the credibility of this evidence and tell me whether the recommendation is sound.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("Assessment: the evidence is credible and the recommendation is sound. The report is unusually thorough for this kind of evaluation. Several points support its credibility:") |>
  p_("Multiple methods. The use of four estimation approaches, all producing consistent results, is a strong indicator of robustness. When independent methods agree, the finding is unlikely to be an artefact of any single specification.") |>
  p_("Large sample. With roughly 9,900 observations, the study is well powered and the estimates are precise.") |>
  p_("Transparency. The report discloses a change in the survey instrument between rounds and notes the gaps in the recycling compliance data. This level of disclosure suggests a careful and honest evaluation team.") |>
  p_("Appropriate limitations. The limitations section correctly identifies that the randomised comparison estimates the offer effect and that the RDD estimate is local to the cut-off.") |>
  p_("Recommendation. The headline estimate of 1,014 AED exceeds the 1,000 AED threshold, so the programme meets the criterion for scale-up. The recommendation is supported by the evidence.") |>
  p_("1. Underline the two claims in the AI's response that the report does not support.", bold = TRUE) |>
  p_("2. There is a bigger problem that the response never mentions. What is that problem?", bold = TRUE) |>
  p_("3. Compare this response with the answer your own AI gave.", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"The same report claims a cost reduction of approximately 1,000 AED against a decision threshold of 1,000 AED. Do three things. First, list every estimate the report gives, with its confidence interval, and say for each one whether it clears the threshold. Second, identify any claim in the executive summary that is not supported by the results section, and quote both. Third, tell me what the report does not tell me that I would need in order to decide.\"", italic = TRUE) |>
  p_(HABITS) |>
  new_page() |> title_("Take-away card: three habits for reading a report", S10) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three habits for reading a report",
                       "1. Tabulate the estimates yourself, with the threshold in its own column. Do not let the report choose which number you see first.",
                       "2. Read the limitations section, then check whether the limitations section names the problems in the data section. If those problems are missing, ask why they were left out.",
                       "3. Find the preferred specification (the estimate the evaluators trust most). Check whether the headline number is that estimate. When the two differ, ask why.",
                       "", "Back at work, I will ask these questions about:", "______________________________")), 6),
            min_height = 2.8) |>
  new_page() |> title_("Facilitator key", S10) |> print_line("trainer only") |>
  body_add_flextable(plain_table(data.frame(Section = rating_sections$section,
    `What is genuinely good` = rating_sections$strength, `The planted problem` = rating_sections$weakness,
    check.names = FALSE), widths = c(1.3, 2.7, 2.8)) |> fontsize(size = 9, part = "body")) |>
  h2_("The most important problem") |>
  p_(rating_decisive) |>
  h2_("Wall grid") |>
  p_("Setup, before the session: print Oct15_session1_board_A1.pdf at A1 (two sheets) and tape the sheets side by side (preview at the end of this pack). Sheet 1 is the executive summary on its own, because everyone posts one note there; sheet 2 has a column for each of Sections 3 to 7. Both have three rows: Green, Amber, Red. Use small sticky notes (about 38 x 51 mm) so they fit: each participant needs about four, and a pen. The notes can be any colour, because the row gives the colour.") |>
  p_("Running it: participants post their executive-summary note after the five minutes alone, and pairs post one note per section as they finish each one. In the debrief, read each column from the wall before the slide's reveal, in place of a show of colours. The pattern to expect: the executive-summary column leans green and the Results column leans amber or red. Put the two columns side by side at \"The same question\": what did the summary lead people to believe?") |>
  h2_("AI Snapshot") |>
  p_("The two unsupported claims: \"the programme meets the criterion for scale-up\" and \"the recommendation is supported by the evidence\". The larger problem: the response reads \"approximately 1,000\" as if all four methods agreed (only the matched comparison gives 1,000), and never notices that the preferred specification is 816, which fails the threshold, or asks whether 1,014 was chosen as the headline because it clears the bar. It also treats the compliance gap as evidence of honesty instead of asking which businesses are missing. What it did well: it found the real disclosures, described the offer-effect and locality limitations correctly, and reached a verdict. The better prompt asks for a comparison instead of a verdict, so the 816 is hard to miss.")
board10 <- make_board("Oct15_session1", list(
  grid_board("Sheet 1 \u00b7 The executive summary",
             "On your own: one small sticky note each, in the row for your colour, with a few words of your reason.",
             cols = rating_sections$section[1], rows = c("Green", "Amber", "Red"),
             row_fill = unname(LIGHT_COL), label_w = 0.16),
  grid_board("Sheet 2 \u00b7 Sections 3 to 7",
             "In pairs: one small sticky note per section, in the row for your colour, with a few words of your reason.",
             cols = c("3. Design", "4. Data", "5. Results", "6. Limitations", "7. Conclusions"), rows = c("Green", "Amber", "Red"),
             row_fill = unname(LIGHT_COL), label_w = 0.12)))
s10 <- s10 |> add_board_page("Oct15_session1", board10, S10, "the credibility grid (A1, two sheets)")
print(s10, target = "Oct15_session1_materials.docx")

# ===========================================================================
# Oct15 S3 · Plan Your Own Evaluation
# ===========================================================================
S12 <- "Module 2 · Day 4, Session 3 · Plan Your Own Evaluation"
s12 <- new_pack() |>
  title_("Evaluation Design Update", S12) |>
  print_line("1 per team") |>
  p_("Team name:  ____________________________________________________________") |>
  p_("Members:  ______________________________________________________________") |>
  p_("The programme you are evaluating:  _______________________________________") |>
  h2_("Part 1. Where your design stands (20 minutes)") |>
  p_("You started this design in Module 1. Write your design as it is now, one row for each of the eight conditions. If you do not have your Module 1 document, use the short description in each row: the conditions are the same as in Module 1.") |>
  body_add_flextable(plain_table(data.frame(
    Condition = sprintf("%d. %s. %s", seq_len(nrow(design_conditions)), design_conditions$condition,
                        design_conditions$recap),
    `Your design` = "", check.names = FALSE), widths = c(2.9, 3.9)) |> tall_rows(0.78) |>
    fontsize(j = 1, size = 9.5, part = "body")) |>
  p_("Your counterfactual (what would have happened without the programme), in one sentence. You will read this sentence out in the pitch:") |> write_lines(2) |>
  new_page() |>
  title_("Part 2. The four additions (30 minutes)", S12) |>
  print_line("1 per team (continues the Design Update)")
for (i in seq_len(nrow(design_additions))) {
  s12 <- s12 |>
    h2_(sprintf("%d. %s", i, design_additions$addition[i])) |>
    p_(sprintf("Uses what you learned in: %s", design_additions$from[i]), 9, italic = TRUE, color = GREY) |>
    p_(design_additions$asks[i])
  if (design_additions$id[i] == "figure") {
    # Two blank drawing boxes, solid borders (not cut lines).
    s12 <- s12 |> body_add_flextable(
      card_grid(list("Figure A", "Figure B: what this version hides"), ncol = 2,
                card_width = 3.35, min_height = 1.9) |>
        border_outer(border = thin_line) |> border_inner(border = thin_line),
      align = "center")
  } else {
    s12 <- s12 |> write_lines(3)
  }
}
s12 <- s12 |>
  new_page() |>
  title_("Part 3. Your five-minute pitch", S12) |>
  print_line("1 per team (continues the Design Update)") |>
  p_("Five minutes per team, then three minutes of feedback from the room. Explain what your design cannot show before you make your request.") |>
  body_add_flextable(plain_table(data.frame(Part = pitch_structure$part, Time = pitch_structure$minutes,
    `What this part covers` = pitch_structure$says, `Our notes` = "", check.names = FALSE),
    widths = c(1.4, 0.6, 2.4, 2.4)) |> tall_rows(1.0)) |>
  new_page() |>
  title_("AI prompt card: stress-test your design", S12) |>
  print_line("1 card per team (four cards per page), cut along the dashed lines") |>
  add_cards(rep(list(c("Stress-test your design with AI",
                       "Type your Part 1 answers and your counterfactual sentence into the AI tool. Prompt:",
                       "\"You are a sceptical commissioner. Ask me three questions about this design before you comment. Then name the one assumption that, if it broke, would make the estimate wrong.\"",
                       "", "Paste the AI's answer into a new chat and ask the AI to check that answer.")), 4),
            min_height = 3.0) |>
  new_page() |>
  title_("Feedback slips", S12) |>
  print_line("One slip per participant for each other team (four slips per page); each slip goes to the team after its pitch") |>
  add_cards(rep(list(c("Feedback for team: ____________________",
                       "1. What is the design? Say it back in one sentence.", "", "",
                       "2. What would make the design fail? Name the one assumption that would have to break.", "", "",
                       "3. What is missing? One thing you would have wanted to hear.", "", "",
                       "4. Which mistake from this week could affect this design? (for example: headline vs preferred estimate, time horizon, truncated axis, missing threshold)", "", "",
                       "Comment on the design, not on the people.")), 4),
            min_height = 4.2) |>
  new_page() |> title_("Take-away card: the one question", S12) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("The question behind every session this week",
                       "What is being compared to what, and why should those two things be comparable?",
                       "", "The first evaluation decision I will make back at work:",
                       "______________________________", "______________________________")), 8),
            min_height = 1.9) |>
  new_page() |> title_("Facilitator key", S12) |> print_line("trainer only") |>
  p_("There are no right answers to the template. Use this page while circulating.") |>
  h2_("Timing") |>
  p_("Part 1: twenty minutes. Part 2: thirty minutes, with a checkpoint at 15 minutes (each team reads out its counterfactual sentence), then a five-minute break. Pitches from about 85 minutes in: five minutes each, then three minutes of feedback in the fixed order (say it back, what would make it fail, what is missing, which trap from this week could hit it).") |>
  p_("This fits three teams. More than three: cut each pitch to 3 minutes plus 2 of feedback, or Part 2 to 25 minutes.") |>
  h2_("Running the pitches") |>
  p_("Call time at 5:00; feedback in the fixed order.") |>
  h2_("Prompts on the slides") |>
  p_("The one condition that decides the rest: the counterfactual. Every method this week was a way of making it operational: randomisation, a cut-off, a matched comparison, a parallel trend.") |>
  p_("Hardest addition before any data: usually the cost-benefit framework, because the benefit per unit is the thing the evaluation has yet to estimate. Teams can still state the decision rule, the horizon and the discount rate.") |>
  h2_("What to check at each table") |>
  p_("Part 1: can the team say its counterfactual in one sentence? If not, the design is not finished.") |>
  p_("Addition 1: have they named the one number they will lead with, and what a reader must not conclude from it?") |>
  p_("Addition 2: is the horizon written down? Five years against two moves the GreenWaste ratio from 1.87 to 0.80.") |>
  p_("Addition 3: have they sketched the second version of the figure, and said what it hides?") |>
  p_("Addition 4: does the headline sentence contain the number, and does the plan name something the evaluation did not establish?") |>
  p_("Pitch: does the limit come before the ask?")
print(s12, target = "Oct15_session3_materials.docx")

message("Wrote Fiona's six session packs.")

# ===========================================================================
# Participant copies for the website (docs/handouts/)
# ===========================================================================
# The same packs without the facilitator key and without the "Print:" lines,
# which are instructions for whoever prints them. The key starts at the page
# break before its "Facilitator key" title and runs to the end of the pack.
participant_copy <- function(src, dest) {
  x    <- read_docx(src)
  body <- xml2::xml_find_first(x$doc_obj$get(), "w:body")
  kids <- xml2::xml_children(body)
  text <- xml2::xml_text(kids)
  k    <- which(text == "Facilitator key")[1]
  stopifnot(!is.na(k))
  breaks <- which(vapply(kids, function(n)
    length(xml2::xml_find_all(n, ".//w:br[@w:type='page']")) > 0, logical(1)))
  b    <- max(breaks[breaks < k])
  keep_last <- xml2::xml_name(kids[length(kids)]) == "sectPr"
  drop <- c(seq(b, length(kids) - keep_last), which(startsWith(text, "Print:")))
  xml2::xml_remove(kids[unique(drop)])
  print(x, target = dest)
}

dir.create("../docs/handouts", showWarnings = FALSE)
for (s in c("Oct12_session1", "Oct12_session2", "Oct12_session3", "Oct13_session1",
            "Oct13_session2", "Oct13_session3", "Oct14_session1", "Oct14_session2",
            "Oct14_session3", "Oct15_session1", "Oct15_session2", "Oct15_session3"))
  participant_copy(paste0(s, "_materials.docx"), paste0("../docs/handouts/", s, "_handouts.docx"))
# Handouts built elsewhere that participants keep, copied as they are.
file.copy(c("Oct14_session3_qa_checklist.docx", "Oct15_session2_findings.docx",
            "Oct15_session2_brief_template.docx", "Oct15_session1_report.docx"),
          "../docs/handouts/", overwrite = TRUE)
message("Wrote participant copies to docs/handouts/.")
