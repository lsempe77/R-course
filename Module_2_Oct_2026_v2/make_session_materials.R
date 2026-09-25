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
card_grid <- function(cards, ncol = 2, card_width = 3.4, min_height = 1.6) {
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
    chunks <- list(as_chunk(card[1], props = fp_text(font.family = FONT, font.size = 11,
                                                      bold = TRUE, color = DARK)))
    for (line in card[-1]) chunks <- c(chunks, list(as_chunk(paste0("\n", line),
                                     props = fp_text(font.family = FONT, font.size = 10.5))))
    ft <- compose(ft, i = i, j = j, value = do.call(as_paragraph, chunks))
  }
  ft
}
add_cards <- function(doc, cards, ...) body_add_flextable(doc, card_grid(cards, ...), align = "center")

gfmt <- function(x, d = 0) formatC(x, format = "f", digits = d, big.mark = ",")

# ---- data --------------------------------------------------------------------
tc <- read.csv("evaluation_data_TrafficCameras.csv")
gw <- read.csv("evaluation_data_GreenWaste.csv")

# ===========================================================================
# Oct12 S1 · Compared to What?
# ===========================================================================
S1 <- "Module 2 · Day 1, Session 1 · Compared to What?"
TEN <- c("SEC08-013", "SEC10-021", "SEC10-024", "SEC12-020", "SEC04-033",
         "SEC02-023", "SEC10-047", "SEC08-002", "SEC06-011", "SEC05-018")
ten <- subset(tc, year == 2019 & segment_id %in% TEN)
ten <- ten[order(ten$injury_collisions), ]
ten_x <- ten$injury_collisions
spd <- function(t, yr) round(mean(tc$ave_speed_kmh[tc$treated == t & tc$year == yr]), 2)
sp <- c(c0 = spd(1, 2019), c1 = spd(1, 2021), o0 = spd(0, 2019), o1 = spd(0, 2021))

excerpts <- c(
  "Fatal collisions on camera roads fell 32% over two years.",
  "The effect of cameras on speed is -3.4 km/h, 95% confidence interval -3.6 to -3.1.",
  "The fall in speed is statistically significant (p < 0.001), so every road should get a camera.",
  "Speed fell 3.4 km/h on camera roads and did not change on roads without them.",
  "The average road in our sample had 13.5 injury collisions.",
  "A study of 20 roads found no significant change in speed.",
  "The coefficient on school_within_500m is -0.37, so schools near roads slow traffic.",
  "Speed fell 3.4 km/h more than on roads without cameras; the target was at least 3 km/h.")

s1 <- new_pack() |>
  title_("By hand: ten roads", S1) |>
  print_line("1 per participant (double-sided with the next page)") |>
  p_("Ten roads that got speed cameras. Injury collisions per road in 2019, before the cameras.") |>
  body_add_flextable(plain_table(data.frame(Road = ten$segment_id, Type = ten$corridor_type,
                                            `Injury collisions` = ten_x, check.names = FALSE),
                                 widths = c(1.4, 2.2, 1.6))) |>
  illustrative() |>
  h2_("1. Work it out by hand") |>
  p_("The mean (the average) number of collisions per road:  ________") |>
  p_("How many of the ten roads are below the mean?  ________") |>
  p_("The median (the middle road when they are in order):  ________") |>
  h2_("2. Remove the busiest road") |>
  p_("New mean:  ________      New median:  ________") |>
  p_("Which moved more, and what does that tell you about a reported average?") |>
  write_lines(2) |>
  new_page() |>
  title_("By hand: the speed table", S1) |>
  print_line("on the back of the ten-roads sheet") |>
  p_("Average speed on the roads, before and after the cameras. Fill in the empty cells.") |>
  body_add_flextable(plain_table(data.frame(
    `Average speed (km/h)` = c("Camera roads", "Roads without cameras", "Difference"),
    `2019` = c(gfmt(sp["c0"], 2), gfmt(sp["o0"], 2), ""),
    `2021` = c(gfmt(sp["c1"], 2), gfmt(sp["o1"], 2), ""),
    Change = c("", "", ""), check.names = FALSE), widths = c(2.4, 1.2, 1.2, 1.2))) |>
  illustrative() |>
  p_("Three numbers describe this result. Write each one and say what it is:") |>
  p_("The change on camera roads:  ________     The gap in 2021:  ________     The gap in 2019:  ________") |>
  p_("Which is the effect of the cameras on speed, and why not the other two?") |>
  write_lines(2) |>
  h2_("3. Which one would you act on?") |>
  p_("Three evaluations each report 1.8 fewer injury collisions per road. The bar is 2.0. Tick one for each.") |>
  body_add_flextable(plain_table(data.frame(
    Report = c("A", "B", "C"), `95% interval` = c("0.4 to 3.2", "1.6 to 2.0", "-0.9 to 4.5"),
    Act = c("[   ]", "[   ]", "[   ]"), `Do not act` = c("[   ]", "[   ]", "[   ]"),
    `Cannot tell yet` = c("[   ]", "[   ]", "[   ]"), check.names = FALSE),
    widths = c(0.8, 1.6, 0.8, 1.1, 1.4))) |>
  p_("These three results are invented for the exercise.", 8.5, italic = TRUE, color = GREY) |>
  new_page() |>
  title_("AI prompt cards", S1) |>
  print_line("1 set per group, cut along the dashed lines; each group takes one card") |>
  add_cards(list(
    c("Card 1", "Paste into your AI tool:",
      "\"Explain a 95% confidence interval, in one paragraph, for someone who is not a statistician.\"",
      "", "What did it get wrong or overstate?", "", "", ""),
    c("Card 2", "Paste into your AI tool:", "\"Explain what a p-value means.\"",
      "", "What did it get wrong or overstate?", "", "", ""),
    c("Card 3", "Paste into your AI tool:",
      "\"Fatal collisions on our camera roads fell 32%. Is that a good result?\"",
      "", "Did it ask what the 32% was compared with?", "", "", ""),
    c("Card 4", "Paste into your AI tool:",
      "\"The coefficient on school_within_500m is -0.37. What should I do about it?\"",
      "", "Did it give you advice about schools?", "", "", "")), min_height = 3.2)

s1 <- s1 |> new_page() |> title_("Triage the claims", S1) |>
  print_line("1 per group, with one set of the excerpt slips (next page)") |>
  p_("You are the commissioner. Eight sentences from reports on the camera programme land on your desk. For each one: which of the three questions does it leave unanswered, and what do you do with it?") |>
  body_add_flextable(plain_table(data.frame(
    Excerpt = 1:8,
    `Unanswered: compared to what? / how big? / how sure? / none` = rep("", 8),
    `Act / do not act / ask first` = rep("", 8),
    `The question you would send back` = rep("", 8), check.names = FALSE),
    widths = c(0.8, 2.3, 1.4, 2.4)) |> height_all(height = 0.55, part = "body") |>
    hrule(rule = "atleast", part = "body")) |>
  p_("Then pick the one excerpt you would be most tempted to act on, and say what would have to be true first.") |>
  write_lines(2) |>
  new_page() |> title_("Triage the claims: the excerpts", S1) |>
  print_line("1 set per group; cut into slips") |>
  add_cards(lapply(seq_along(excerpts), function(i) c(sprintf("Excerpt %d", i), excerpts[i])),
            ncol = 2, min_height = 1.1) |>
  illustrative() |>
  new_page() |> title_("Take-away card: three questions for any number", S1) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions for any number", "1. Compared to what?",
                       "2. How big is it, in units that matter to the decision?",
                       "3. How sure are we?", "", "On my desk, I will ask these about:", "______________________________")), 8), min_height = 1.8) |>
  new_page() |> title_("Facilitator key", S1) |> print_line("trainer only") |>
  h2_("Ten roads") |>
  p_(sprintf("Mean %s; %d of the ten roads are below it; median %s. Without the busiest road (%d collisions): mean %s, median %s. One road moved the mean further than the median.",
             gfmt(mean(ten_x), 1), sum(ten_x < mean(ten_x)), gfmt(median(ten_x), 1), max(ten_x),
             gfmt(mean(ten_x[-length(ten_x)]), 1), gfmt(median(ten_x[-length(ten_x)]), 1))) |>
  h2_("Speed table") |>
  p_(sprintf("Changes: camera roads %s, other roads %s. Differences: 2019 %s (the head start), 2021 %s (still carries the head start), change %s. The effect is %s km/h, close to the camera roads' own change only because the other roads barely moved.",
             gfmt(sp["c1"] - sp["c0"], 2), gfmt(sp["o1"] - sp["o0"], 2), gfmt(sp["c0"] - sp["o0"], 2),
             gfmt(sp["c1"] - sp["o1"], 2), gfmt((sp["c1"] - sp["c0"]) - (sp["o1"] - sp["o0"]), 2),
             gfmt((sp["c1"] - sp["c0"]) - (sp["o1"] - sp["o0"]), 2))) |>
  h2_("Which one would you act on?") |>
  p_("B: do not act, it is precise and below the bar. A and C: cannot tell yet; the intervals span the bar. The interval decides, not the point estimate.") |>
  h2_("AI prompt cards") |>
  p_("Card 1: look for \"95% probability that the true value is in this interval\". 95% describes the method over many studies. Card 2: look for \"the probability the result is due to chance\" or \"the probability the programme works\". Card 3: a good answer asks what the 32% was compared with and how much driving changed. Card 4: the row adjusts the comparison; it is not a policy lever.") |>
  h2_("Triage key") |>
  body_add_flextable(plain_table(data.frame(
    Excerpt = 1:8,
    Unanswered = c("Compared to what? (before and after; driving rose 4%)",
                   "How big, in units that matter? (speed, not collisions)",
                   "How big? Significance is not a decision rule",
                   "How sure? (no interval)",
                   "How big, for a typical road? (one road pulls the mean)",
                   "How sure? (20 roads is too few to see anything)",
                   "Misread coefficient: not a policy lever",
                   "None: a comparison, an effect and a bar"),
    Call = c("Ask first", "Ask first", "Do not act on this", "Ask first",
             "Ask for the spread", "Do not conclude 'no effect'", "Do not act on this", "Act"),
    check.names = FALSE), widths = c(0.8, 4.0, 2.0))) |>
  p_("Debrief: groups disagree most on 2 and 4, which is the point; take one group's reasoning for each.")
print(s1, target = "Oct12_session1_materials.docx")

# ===========================================================================
# Oct12 S3 · Spot the Problem
# ===========================================================================
S3 <- "Module 2 · Day 1, Session 3 · Spot the Problem"
mc <- function(keep) mean(gw$waste_management_costs[keep])
ba <- mc(gw$enrolled == 1 & gw$round == 1) - mc(gw$enrolled == 1 & gw$round == 0)
ww <- mc(gw$treatment_neighborhood == 1 & gw$enrolled == 1 & gw$round == 1) -
      mc(gw$treatment_neighborhood == 1 & gw$enrolled == 0 & gw$round == 1)
ww0 <- mc(gw$treatment_neighborhood == 1 & gw$enrolled == 1 & gw$round == 0) -
       mc(gw$treatment_neighborhood == 1 & gw$enrolled == 0 & gw$round == 0)
fu <- subset(gw, round == 1 & eligible == 1)
rct <- mean(fu$waste_management_costs[fu$treatment_neighborhood == 1]) -
       mean(fu$waste_management_costs[fu$treatment_neighborhood == 0])

s3 <- new_pack() |>
  title_("Session tracker", S3) |>
  print_line("1 per participant; filled in as the session runs") |>
  p_("Module 1 gave you three GreenWaste numbers. Today you rebuild each one from the data and decide what is wrong with it. The bar for national scale-up: at least 1,000 AED.") |>
  body_add_flextable(plain_table(data.frame(
    Comparison = c("Before and after", "Enrolled vs not enrolled", "Randomised (drawn neighbourhoods)"),
    `Module 1 said` = c(gfmt(ba), gfmt(ww), gfmt(rct)),
    `We got` = c("", "", ""),
    `Too big / too small / fair?` = c("", "", ""),
    `Why?` = c("", "", ""), check.names = FALSE), widths = c(1.8, 1.0, 0.9, 1.5, 1.8)) |>
    height_all(height = 0.55, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  h2_("The lottery") |>
  p_("Gap between offered and not-offered neighbourhoods before the programme, after five random draws: largest gap ________ AED") |>
  p_("The same gap when officials pick the neighbourhoods:  ________ AED") |>
  p_("With 4 neighbourhoods in the lottery, 95% of draws start within ± ________ AED. With 196: ± ________ AED.") |>
  h2_("Reading the randomised result") |>
  p_("The effect: ________ AED.   Its 95% interval, counted by neighbourhood: ________ to ________") |>
  p_("Does it clear 1,000 AED at its least generous end?   Yes  /  No") |>
  p_("One question I would ask the evaluator:") |> write_lines(2) |>
  new_page() |>
  title_("AI Snapshot: a paragraph for the minister", S3) |>
  print_line("1 per pair") |>
  p_("The prompt, written the way a busy official might write it:", bold = TRUE) |>
  p_("\"Our pilot cut waste costs by 665 AED per business (costs before vs after, p < 0.001). Write a short paragraph for the minister on what this shows.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("The GreenWaste pilot produced a clear result: waste-management costs fell by 665 AED per business, and with p < 0.001 we can be confident the programme caused this reduction. Because the same businesses were measured before and after, differences between businesses are already accounted for, so the 665 AED saving can be attributed to the programme. This makes a strong case for national scale-up. As with any pilot, results should be monitored as the programme expands.") |>
  p_("Underline every claim the evidence does not support. Then run the same prompt yourselves: did your AI write something similar?", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"Costs for participating businesses were 665 AED lower after the pilot than before (p < 0.001). We also have businesses that did not take part and a randomised comparison. The scale-up rule is at least 1,000 AED. Before writing anything, tell me what this before-and-after number can and cannot show. Ask me questions before you answer.\"", italic = TRUE) |>
  p_("Which answer questions the 665 before writing the paragraph? Paste the better answer into a fresh chat and ask it to check for errors.") |>
  new_page() |> title_("Take-away card: three questions for an RCT", S3) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions to ask the evaluator",
                       "1. Compared to what? Before-and-after, with-and-without, or a fair comparison?",
                       "2. Show me the balance table. How do you know the groups started out alike?",
                       "3. Were errors clustered where you randomised, and does the interval clear our rule?", "", "On my desk, I will ask these about:", "______________________________")), 6),
            min_height = 2.2) |>
  new_page() |> title_("Facilitator key", S3) |> print_line("trainer only") |>
  h2_("Session tracker") |>
  p_(sprintf("Before and after %s: too small; costs for non-participants rose about 150 AED, so the fall understates the effect. Enrolled vs not %s: too big; the groups differed by %s AED before the programme. Randomised %s: fair. Interval counted by neighbourhood about -1,093 to -935: the estimate clears 1,000, the interval spans it.",
             gfmt(ba), gfmt(ww), gfmt(ww0), gfmt(rct))) |>
  p_("Lottery: random draws start within a few dozen AED; officials picking the cheapest-to-run neighbourhoods start hundreds of AED ahead. 4 neighbourhoods: about ± 400 AED; 196: a few dozen.") |>
  h2_("AI Snapshot: four errors") |>
  p_("1. Significant is not causal: p < 0.001 says the fall is unlikely to be chance, not what caused it. 2. Half right: following the same businesses removes fixed differences but not what changed for everyone. 3. It reports 665 as the effect; the randomised estimate is about 1,014. 4. It recommends scale-up without asking what bar the programme must clear.")
print(s3, target = "Oct12_session3_materials.docx")

# ===========================================================================
# Oct13 S2 · Reading RDD Results
# ===========================================================================
S5 <- "Module 2 · Day 2, Session 2 · Reading RDD Results"
off <- subset(gw, round == 1 & treatment_neighborhood == 1)
# Four cards (A-D), each with a different random six businesses on each side of
# the line. Pairs call out their gaps; the spread is the lesson.
jump_card <- function(seed) {
  set.seed(seed)
  b <- off[sample(which(off$efficiency_index > 57 & off$efficiency_index <= 58), 6), ]
  a <- off[sample(which(off$efficiency_index > 58 & off$efficiency_index <= 59), 6), ]
  list(rows = data.frame(`Just below 58 (offered): index` = gfmt(b$efficiency_index, 2),
                         `Waste cost (AED)` = gfmt(round(b$waste_management_costs, -1)),
                         `Just above 58 (not offered): index` = gfmt(a$efficiency_index, 2),
                         `Waste cost (AED) ` = gfmt(round(a$waste_management_costs, -1)),
                         check.names = FALSE),
       below = mean(round(b$waste_management_costs, -1)), above = mean(round(a$waste_management_costs, -1)))
}
cards5 <- lapply(c(A = 1, B = 4, C = 3, D = 6), jump_card)

s5 <- new_pack()
for (k in names(cards5)) {
  s5 <- s5 |>
    title_(sprintf("By hand: the jump at the line (card %s)", k), S5) |>
    print_line("four different cards (A-D); give each pair one card, so neighbours hold different cards") |>
    p_("Twelve GreenWaste businesses in the offered neighbourhoods, all within one index point of the cut-off at 58. Businesses at 58 or below got the programme. Costs are rounded to the nearest 10 AED.") |>
    body_add_flextable(plain_table(cards5[[k]]$rows, widths = c(1.8, 1.3, 1.9, 1.3))) |>
    h2_("Work it out") |>
    p_("Average cost just below the line:  ________      Average cost just above:  ________") |>
    p_("The jump (below minus above):  ________ AED.   Write it on the flipchart when the trainer asks.") |>
    p_("Your neighbours had different businesses. Why do the jumps differ, and what would you need to trust one number?") |>
    write_lines(2) |>
    new_page()
}
s5 <- s5 |>
  title_("Four checks scorecard", S5) |>
  print_line("1 per group; mark each check as the trainer runs it") |>
  body_add_flextable(plain_table(data.frame(
    Check = c("0. Who is compared?", "1. A different window", "1b. Placebo cut-offs",
              "2. Bending the rule", "3. Are the two sides alike?", "4. Who does it apply to?"),
    `What to look for` = c("Only businesses that could have been offered it",
                           "Does the verdict against 1,000 AED change?",
                           "No jump where there is no rule",
                           "No pile-up of businesses just below 58",
                           "No characteristic jumps at the line",
                           "Who sits near the line, and who the roll-out would reach"),
    `Pass / fail / unclear` = rep("", 6), Note = rep("", 6), check.names = FALSE),
    widths = c(1.6, 2.6, 1.0, 1.7)) |> height_all(height = 0.55, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  p_("Overall: would you act on this estimate?   Act  /  Act with conditions  /  Send back") |>
  p_("The one question for the evaluator:") |> write_lines(2) |>
  new_page() |>
  title_("AI Snapshot: who does this apply to?", S5) |>
  print_line("1 per group") |>
  p_("The prompt: \"Explain, without jargon, who this result actually applies to.\"", bold = TRUE) |>
  h2_("A response like this is possible") |>
  p_("This study found that the GreenWaste programme reduced costs by around 790 AED for participating businesses. Because the study uses a cut-off at an efficiency index of 58, the findings apply to all businesses in the programme. The cut-off design means the result generalises to the wider population of inefficient businesses. The estimate is therefore a reasonable basis for scaling the programme to every business below average efficiency.") |>
  p_("Underline every claim the study supports and cross out every one it does not. What did it leave out?", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead") |>
  p_("\"This is a regression discontinuity result with the cut-off at an efficiency index of 58, estimated within 2 points either side. The businesses near the line are smaller than average, and manager age differs across the line. Name which businesses the estimate describes and what it cannot tell us. Ask me questions before you answer.\"", italic = TRUE) |>
  new_page() |> title_("Take-away card: five questions for an RDD result", S5) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Five questions for an RDD result",
                       "1. Where is the cut-off, which side is eligible, and exactly which units are compared?",
                       "2. Does the jump survive other windows, and is there none at placebo cut-offs?",
                       "3. Is the number of units smooth at the line?",
                       "4. Does anything else jump at the line?",
                       "5. Who is near the line, and does the estimate clear our rule for them?", "", "On my desk, I will ask these about:", "______________________________")), 6),
            min_height = 2.5) |>
  new_page() |> title_("Facilitator key", S5) |> print_line("trainer only") |>
  h2_("The jump by hand") |>
  body_add_flextable(plain_table(data.frame(
    Card = names(cards5),
    `Below (AED)` = sapply(cards5, function(x) gfmt(x$below)),
    `Above (AED)` = sapply(cards5, function(x) gfmt(x$above)),
    Jump = sapply(cards5, function(x) gfmt(x$below - x$above)), check.names = FALSE),
    widths = c(0.8, 1.4, 1.4, 1.2))) |>
  p_("Write the pairs' jumps on the flipchart. They spread widely because six businesses a side is too few; the regression uses the 773 businesses within two points and reports an interval (-791, from -1,084 to -498). The rough gap is also inflated by the slope of costs along the index, which the regression removes.") |>
  h2_("Scorecard") |>
  p_("0: pass only with the offered neighbourhoods (pooling every neighbourhood waters the jump down to about -249). 1: the estimate moves between about 790 and 1,120; the least generous end never reaches 1,000 (verdict: does not clear). 1b: pass. 2: pass. 3: FAIL, manager age is 5 to 9 years younger just below the line at every window. 4: the 773 businesses near the line are smaller than the rest.") |>
  h2_("AI Snapshot") |>
  p_("Wrong: 'applies to all businesses', 'generalises to the wider population', 'basis for scaling to every business'. The estimate is local to the line. Left out: the manager-age jump, and the 1,000 AED rule.")
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

s7 <- new_pack() |>
  title_("What went into the ratio", S7) |>
  print_line("1 per group (also the table groups paste into AI)") |>
  body_add_flextable(plain_table(data.frame(
    Step = c("Cost per business", "Annual saving", "Years of saving assumed", "Discount rate assumed",
             "Savings, in today's money", "Benefit-cost ratio"),
    Value = c("1,800 AED", "816 AED", "5, starting in year 2", "5% a year",
              gfmt(816 * pv(0.05, 5)), sprintf("%s / 1,800 = %.2f", gfmt(816 * pv(0.05, 5)), ratio())),
    Source = c("programme records", "measured (Day 2 difference-in-differences)", "ASSUMED", "ASSUMED",
               "calculated", "calculated")), widths = c(2.2, 2.4, 2.3))) |>
  h2_("AI prompt, version 1") |>
  p_("\"Generate one plausible scenario in which this programme's benefit-cost ratio falls below 1. Then tell me whether that scenario is realistic.\"", italic = TRUE) |>
  h2_("AI prompt, version 2") |>
  p_("\"Here is a cost-benefit model. The cost and annual saving are measured; the discount rate and the number of benefit years are assumptions. Tell me which single assumption moves the ratio most, give the ratio under a realistic alternative, and say whether a government agency would normally make that assumption. Ask me questions before you answer.\"", italic = TRUE) |>
  p_("Run both. Which one ranks the assumptions before choosing one? Which one gives you a number you can act on?") |>
  new_page() |>
  title_("Stress-test scenario cards", S7) |>
  print_line("1 set, cut; each group takes one card") |>
  add_cards(lapply(seq_len(nrow(scen)), function(i)
    c(sprintf("Card %d · %s", scen$card[i], scen$name[i]), scen$story[i], "",
      paste("Tell the trainer:", scen$settings[i]), "",
      "Is this plausible for a waste-cost programme?", "Your verdict:")),
    min_height = 2.2) |>
  new_page() |>
  title_("Group recording sheet", S7) |>
  print_line("1 per group") |>
  body_add_flextable(plain_table(data.frame(
    ` ` = c("Our card", "Settings we called", "Ratio on the screen", "Plausible? Why?",
            "Verdict: pays for itself?", "One question for the evaluator"),
    Answer = rep("", 6), check.names = FALSE), widths = c(2.3, 4.6)) |>
    height_all(height = 0.7, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  h2_("The three questions, for GreenWaste") |>
  p_("1. Are the benefits plausible?  Measured  /  Modelled  /  Assumed") |>
  p_("2. Are all the costs included?  What is missing?") |> write_lines(1) |>
  p_("3. What would flip the result?") |> write_lines(1) |>
  new_page() |> title_("Take-away card: judging a cost-benefit claim", S7) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions for any cost-benefit ratio",
                       "1. Are the benefits plausible? Measured, modelled or assumed?",
                       "2. Are all the costs included? What was left out?",
                       "3. What would flip the result? Which assumption, and by how much?",
                       "", "Ask: \"What assumption would have to change for this ratio to fall below 1, and what is your evidence for it?\"", "", "On my desk, I will ask these about:", "______________________________")), 6),
            min_height = 2.5) |>
  new_page() |> title_("Facilitator key", S7) |> print_line("trainer only") |>
  body_add_flextable(plain_table(data.frame(
    Card = scen$card, Scenario = scen$name, Ratio = sprintf("%.2f", scen$value),
    Verdict = ifelse(scen$value >= 1, "pays for itself", "does not pay"),
    check.names = FALSE), widths = c(0.6, 2.8, 0.9, 1.6))) |>
  p_("Base case 1.87. The rate alone does not flip it until about 24%. Two years of saving gives 0.80; break-even is about 2.5 years. Missing costs flip it at about 1,600 AED per business.") |>
  p_("AI Snapshot: the arithmetic in version 1 holds (40% does push the ratio below 1) but it picks the easiest lever, gives no number for 'benefits delayed', and claims unsourced authority ('commonly observed in infrastructure appraisal').")
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
  p_("Mark each slip S (strong: needs a fact to answer) or W (weak: can be answered with a word). Then sort them into two piles.") |>
  add_cards(lapply(seq_along(cands), function(i) c(sprintf("%d", i), cands[i], "", "S   /   W")),
            min_height = 1.1) |>
  new_page() |>
  title_("Clinic record sheet", S9) |>
  print_line("1 per group") |>
  p_("Your area:   Methodology  /  Assumptions  /  Data quality  /  Conclusions") |>
  body_add_flextable(plain_table(data.frame(
    `Our question` = c("1.", "2.", "3.", "Follow-up:"),
    `What the analyst said` = rep("", 4),
    `Answered / admitted / deflected / unanswerable` = rep("", 4), check.names = FALSE),
    widths = c(2.4, 2.8, 1.8)) |> height_all(height = 1.0, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  h2_("After the clinic") |>
  p_("Which unanswered question would change your sign-off if it came back the wrong way?") |> write_lines(2) |>
  p_("Your vote before the clinic:  Yes / No / Not without more answers.     After:  Yes / No / Not without more answers.") |>
  new_page() |>
  title_("AI prompt card", S9) |>
  print_line("1 per group") |>
  add_cards(list(
    c("Prompt A (the one people type)",
      "\"I have an evaluation of a programme that subsidised waste-management technology for businesses. It used difference-in-differences, regression discontinuity, a randomised comparison and matching. All four methods found a cost reduction of roughly 1,000 AED per business per year. List the critical questions a commissioner should ask before acting on this result.\"",
      "", "How many of its questions would pass the S/W sort as strong?"),
    c("Prompt B (better)",
      "\"I am advising on whether to scale up a programme nationally. An evaluator reports a cost reduction of about 1,000 AED per business per year from difference-in-differences, with a decision threshold of 1,000 AED. First, tell me which single assumption this design rests on. Second, tell me what evidence would show that assumption holds, and what it would look like if it failed. Third, tell me what you cannot determine from the information I have given you.\"",
      "", "What did it tell you it cannot determine?")), ncol = 1, card_width = 6.8, min_height = 2.3) |>
  new_page() |> title_("Take-away card: three questions for any analyst", S9) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("The three you will use",
                       "1. What is the comparison, and how was it chosen?",
                       "2. What has to be true for this to be causal, and did you test it?",
                       "3. Does the conclusion follow, or does it go beyond the evidence?", "", "On my desk, I will ask these about:", "______________________________")), 8),
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
  p_("Read your partner's brief as the person deciding. Answer in this order.") |>
  p_("1. What does this brief want me to do?") |> write_lines(1) |>
  p_("2. What is its strongest claim, and does the findings pack support it?") |> write_lines(1) |>
  p_("3. What has it left out that I would have wanted to know?") |> write_lines(1) |>
  h2_("The six checks") |>
  body_add_flextable(plain_table(data.frame(
    Check = c("The headline sentence contains the number (743)",
              "It states the 900 AED threshold",
              "It does not claim customers benefited from the pass-through",
              "It gives the enrolment figure (34%) without explaining why",
              "It mentions the 22% cost overrun",
              "It does not turn the null finding into 'no effect'"),
    `Yes / No` = rep("", 6), check.names = FALSE), widths = c(5.6, 1.2)) |>
    height_all(height = 0.45, part = "body") |> hrule(rule = "atleast", part = "body")) |>
  p_("Illustrative case (Tariff Shield), with invented figures.", 8.5, italic = TRUE, color = GREY) |>
  new_page() |>
  title_("The AI draft: edit it as a team", S11) |>
  print_line("1 per group") |>
  p_("The prompt: \"Here are six findings from an evaluation of a fuel-price stabilisation scheme for small freight operators. Write a one-page policy brief for the commissioning authority with a headline finding, key implications, a recommendation, and one risk to flag.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("Headline finding. The scheme reduced fuel costs for participating operators, delivering a net saving of 743 AED per vehicle per year. The result is statistically significant and the evaluation was rigorously conducted.") |>
  p_("Key implications. Operators passed part of the saving on to customers, with freight rates falling by 1.8%, suggesting a wider economic benefit. Some operators chose not to enrol, which may indicate a need for better communication.") |>
  p_("Recommendation. Roll the scheme out more widely, with targeted outreach to operators who did not participate.") |>
  p_("Risk to flag. Results from a pilot may not generalise to a full rollout.") |>
  p_("Edit it on this page. Find four problems in what it says, then the two things it leaves out entirely.", bold = TRUE) |>
  write_lines(4) |>
  new_page() |> title_("Take-away card: a brief you can trust", S11) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("What makes a brief trustworthy",
                       "1. The number is in the headline sentence.",
                       "2. The threshold is stated, even when it is missed.",
                       "3. Findings against the recommendation are named.",
                       "4. The recommendation is an action the reader can take or refuse.",
                       "5. The risk can happen and can be watched.",
                       "6. What was not established is stated plainly.", "", "On my desk, I will ask these about:", "______________________________")), 6),
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
HABITS  <- "Two habits: ask the AI to ask you questions before it answers, and paste its answer into a fresh chat to check it."

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
POL_RULE   <- 2.0
cams       <- subset(tc, treated == 1)
cam_before <- mean(cams$injury_collisions[cams$round == 0])
cam_after  <- mean(cams$injury_collisions[cams$round == 1])
cam_fall   <- cam_before - cam_after
cam_pct    <- 100 * cam_fall / cam_before
oth_before <- mean(tc$injury_collisions[tc$treated == 0 & tc$round == 0])
oth_after  <- mean(tc$injury_collisions[tc$treated == 0 & tc$round == 1])
oth_fall   <- oth_before - oth_after
seg_w      <- reshape(cams[, c("segment_id", "round", "injury_collisions")],
                      idvar = "segment_id", timevar = "round", direction = "wide")
share_fell <- 100 * mean(seg_w$injury_collisions.1 - seg_w$injury_collisions.0 < 0)
ba_fit     <- lm_robust(injury_collisions ~ round, data = cams, clusters = segment_id)
ba_ci      <- sort(abs(confint(ba_fit)["round", ]))

p_cam <- ggplot(data.frame(year = c("2019", "2021"), y = c(cam_before, cam_after)),
                aes(year, y)) +
  geom_col(fill = BLUE, width = 0.6) +
  geom_text(aes(label = sprintf("%.1f", y)), vjust = -0.5, size = 4.2) +
  scale_y_continuous(limits = c(0, 14), expand = c(0, 0)) +
  labs(x = NULL, y = "Collisions per segment") + theme_page()

s2 <- new_pack() |>
  title_("Annotate this output", S2) |>
  print_line("1 per participant") |>
  p_("The before-and-after regression for the road segments that got speed cameras. Outcome: injury collisions per road segment, 2019 (round 0) and 2021 (round 1). Standard errors are clustered by road segment. The p-value is the column R printed as Pr(>|t|).") |>
  body_add_flextable(plain_table(data.frame(
    ` ` = c("(Intercept)", "round"),
    Estimate = sprintf("%.3f", coef(ba_fit)), `Std. Error` = sprintf("%.3f", ba_fit$std.error),
    `p-value` = sprintf("%.3f", ba_fit$p.value), `CI Lower` = sprintf("%.3f", ba_fit$conf.low),
    `CI Upper` = sprintf("%.3f", ba_fit$conf.high), check.names = FALSE),
    widths = c(1.2, 1.0, 1.1, 0.9, 1.0, 1.0))) |>
  illustrative() |>
  h2_("On the table above") |>
  p_("1. Circle the before-and-after change.") |>
  p_("2. Draw a box around its confidence interval.") |>
  p_("3. Underline the 2019 average, and say in one line why it is not an effect.") |>
  write_lines(2) |>
  p_("4. Write the comparison you would ask the evaluator for.") |>
  write_lines(2) |>
  new_page() |>
  title_("AI Snapshot: ask AI to read the chart", S2) |>
  print_line("1 per pair") |>
  p_("Average injury collisions per road segment in the sectors that got speed cameras.") |>
  body_add_gg(p_cam, width = 3.6, height = 2.4) |>
  illustrative() |>
  p_("The prompt most people would type, with a picture of the chart:", bold = TRUE) |>
  p_("\"What does this chart show? Did the cameras work?\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("\"The chart shows a 22% reduction in injury collisions after speed cameras were installed, from 11.5 to 9.0 per road segment. This reduction is statistically significant (p < 0.001), confirming that the cameras caused the decline. The fall was consistent across all road types, which suggests the effect is robust. Given the size of the effect, the programme should be extended to the remaining sectors.\"") |>
  p_("In pairs: mark every claim you can check against the chart. Which ones can the chart support?", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"This chart shows average injury collisions per road segment in the sectors that got speed cameras, in 2019 and 2021. Describe only what the chart shows. Then list what else could explain the change, and what comparison you would need before saying the cameras caused it. Before you answer, ask me any questions you need.\"", italic = TRUE) |>
  p_("Run both prompts on the same chart. What does the second answer include that the first left out? Then paste the second answer into a fresh chat and ask it to check for claims the chart cannot support.") |>
  new_page() |> title_("Take-away card: three questions to ask the evaluator", S2) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions to ask the evaluator",
                       "1. How big? In the units the decision is written in, not a percentage.",
                       "2. How sure? Does the confidence interval clear the rule, not just zero?",
                       "3. Compared to what? Which group, which period, and did it move too?",
                       "", "On my desk, I will ask these about:", "______________________________")), 6),
            min_height = 2.2) |>
  new_page() |> title_("Facilitator key", S2) |> print_line("trainer only") |>
  h2_("Annotate this output") |>
  p_(sprintf("1. The change is the round row: %.2f collisions per segment. 2. Its interval runs from %.2f to %.2f. 3. The intercept, %.2f, is the 2019 average on camera roads. It is a starting level with nothing to compare it against, so it says nothing about what the cameras did. 4. Roads without cameras over the same two years. Their collisions fell too, by %.2f per segment (%.0f%%), so some of the %.2f would have happened anyway.",
             coef(ba_fit)[["round"]], ba_fit$conf.low[["round"]], ba_fit$conf.high[["round"]],
             coef(ba_fit)[["(Intercept)"]], oth_fall, 100 * oth_fall / oth_before, cam_fall)) |>
  p_(sprintf("Against the rule of %.1f fewer collisions: the estimate (%.2f) and the whole interval (%.2f to %.2f) clear it. The camera result passes how big and how sure; compared to what is still open.",
             POL_RULE, cam_fall, ba_ci[1], ba_ci[2])) |>
  h2_("AI Snapshot") |>
  p_(sprintf("Correct: \"22%% reduction, 11.5 to 9.0\" is on the chart (%.1f to %.1f, %.0f%%). Not on the chart: \"p < 0.001\"; the model supplied a p-value it was never given. \"Confirming that the cameras caused\": a before-and-after chart cannot show cause, and a small p-value says the fall is unlikely to be noise, not what caused it. \"Consistent across all road types\": invented; the chart has no road types, and %.0f%% of camera roads did not fall. \"Should be extended\": a recommendation with no rule and no comparison.",
             cam_before, cam_after, cam_pct, 100 - share_fell)) |>
  p_("With the second prompt, listen for answers that ask what happened on roads without cameras and whether traffic changed.")
print(s2, target = "Oct12_session2_materials.docx")

# ===========================================================================
# Oct13 S1 · Reading DiD Results
# ===========================================================================
S4 <- "Module 2 · Day 2, Session 1 · Reading DiD Results"
tn  <- subset(gw, treatment_neighborhood == 1)
gvm <- function(e, r) mean(tn$waste_management_costs[tn$enrolled == e & tn$round == r])
off_b <- gvm(1, 0); off_a <- gvm(1, 1); ctl_b <- gvm(0, 0); ctl_a <- gvm(0, 1)
off_chg <- off_a - off_b; ctl_chg <- ctl_a - ctl_b; did_hand <- off_chg - ctl_chg
fit_did <- lm_robust(waste_management_costs ~ round * enrolled, data = tn,
                     clusters = neighborhood_identifier)
did_ci  <- confint(fit_did)["round:enrolled", ]
did_av  <- sort(abs(did_ci))
did_rows <- data.frame(
  ` ` = c("(Intercept)", "Round 2", "Enrolled", "Round 2 x Enrolled"),
  Coefficient = gfmt(coef(fit_did)), `Std. error` = gfmt(fit_did$std.error),
  p = pfmt(fit_did$p.value),
  `95% CI` = sprintf("[%s, %s]", gfmt(fit_did$conf.low), gfmt(fit_did$conf.high)),
  check.names = FALSE)

s4 <- new_pack() |>
  title_("By hand: four numbers", S4) |>
  print_line("1 per participant (double-sided with the next page)") |>
  p_("GreenWaste businesses in the neighbourhoods where the programme was offered. Average annual waste-management costs (AED), before and after. The bar for scale-up: at least 1,000 AED.") |>
  body_add_flextable(plain_table(data.frame(
    ` ` = c("Took part", "Did not take part", "Difference of the changes"),
    Before = c(gfmt(off_b), gfmt(ctl_b), ""), After = c(gfmt(off_a), gfmt(ctl_a), ""),
    Change = c("", "", ""), check.names = FALSE), widths = c(2.6, 1.2, 1.2, 1.4)) |> tall_rows(0.45)) |>
  h2_("Two subtractions") |>
  p_("First difference: each group's change over time. It removes fixed differences between the groups, and still contains the general time trend.") |>
  p_("Change for \"took part\":  ________      Change for \"did not take part\":  ________") |>
  p_("Second difference: the difference between those two changes. It removes the time trend and leaves the estimated effect.") |>
  p_("Difference-in-differences = (change for \"took part\") minus (change for \"did not\") =  ________ AED") |>
  p_("Does it clear 1,000 AED?   Yes  /  No") |>
  new_page() |>
  title_("Which row is the impact?", S4) |>
  print_line("on the back of the four-numbers sheet") |>
  p_("The same data as a regression, the way an evaluator would report it. Standard errors are clustered by neighbourhood.") |>
  body_add_flextable(plain_table(did_rows, widths = c(1.8, 1.2, 1.0, 0.8, 1.9))) |>
  p_("1. Circle the row that is the programme's effect. Is it the number you got by hand?") |>
  p_("2. Two rows are often reported as the effect by mistake. What are they?") |>
  p_("Round 2 is  ______________________      Enrolled is  ______________________") |>
  p_("3. The least generous end of the effect's interval:  ________ AED.   Does it clear 1,000?   Yes  /  No") |>
  p_("4. Costs were measured once before the programme and once after. What can this data not tell you about the two groups?") |>
  write_lines(2) |>
  new_page() |>
  title_("AI Snapshot: explaining the table", S4) |>
  print_line("1 per pair") |>
  p_("Paste the regression table into an AI tool with this prompt:", bold = TRUE) |>
  p_("\"Explain this regression table to a non-technical decision-maker, and say what should be checked before believing the result.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("The table reports a difference-in-differences estimate. The programme reduced costs by 816 AED, and the effect is highly statistically significant (p < 0.001), so the programme was a success. The confidence interval does not include zero, which confirms the finding is robust.") |>
  p_("The parallel trends assumption has been satisfied. The result clears the 1,000 AED threshold required for scale-up.") |>
  p_("Mark every sentence you can check against the table, and every sentence the table does not support.", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"We have a difference-in-differences table. The data has two waves only, one before and one after, so no pre-trend test is possible. The decision rule is 1,000 AED. Explain what the table supports and, separately, list what it cannot tell us. Ask me questions before you answer.\"", italic = TRUE) |>
  p_("Does the claim about parallel trends survive the second prompt? Then paste the second answer into a fresh chat and ask it to check for claims about tests that were never run.") |>
  new_page() |> title_("Take-away card: three questions for a DiD result", S4) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three questions to ask any evaluator presenting DiD",
                       "1. Which row is the estimate, and does its interval clear our rule, not just zero?",
                       "2. How many periods before the programme, and were the groups already moving together?",
                       "3. Which comparison group, chosen how, and how did it differ at baseline?",
                       "", "On my desk, I will ask these about:", "______________________________")), 6),
            min_height = 2.3) |>
  new_page() |> title_("Facilitator key", S4) |> print_line("trainer only") |>
  h2_("Four numbers") |>
  p_(sprintf("Took part %s to %s: change %+.0f. Did not take part %s to %s: change %+.0f. Difference of the changes: %.0f AED. It does not clear 1,000. Watch the sign: the comparison group went up, so the effect is bigger than the %.0f fall in the top row.",
             gfmt(off_b), gfmt(off_a), off_chg, gfmt(ctl_b), gfmt(ctl_a), ctl_chg, did_hand, abs(off_chg))) |>
  h2_("Which row is the impact?") |>
  p_(sprintf("1. Round 2 x Enrolled, %s AED: the same number as by hand. 2. Round 2 (%s) is the time trend, what happened to everyone; Enrolled (%s) is the baseline gap, how far apart the groups started. Many pick Enrolled because it is large and has the word in it. 3. %s AED; the interval is %s to %s, and even its most generous end (%s) is short of 1,000. 4. Whether the groups were already moving in parallel: a pre-trend check needs at least two periods before the programme.",
             gfmt(coef(fit_did)[["round:enrolled"]]), gfmt(coef(fit_did)[["round"]]),
             gfmt(coef(fit_did)[["enrolled"]]), gfmt(did_av[1]), gfmt(did_ci[1]), gfmt(did_ci[2]),
             gfmt(did_av[2]))) |>
  h2_("AI Snapshot") |>
  p_("Supported by the table: the 816 AED estimate and p < 0.001. Not supported: \"so the programme was a success\" answers whether the effect is non-zero, not whether it clears 1,000. \"Does not include zero, which confirms the finding is robust\": not zero and big enough are different claims. \"The parallel trends assumption has been satisfied\" is the serious one: with one period before the programme it cannot be tested, so the model reported a test that was never run. \"Clears the 1,000 AED threshold\" is false.") |>
  p_("With the second prompt, check whether the parallel-trends claim disappears. Supplying the constraint makes the error less likely; it does not rule it out.")
print(s4, target = "Oct13_session1_materials.docx")

# ===========================================================================
# Oct13 S3 · Reading Matching Results
# ===========================================================================
S6 <- "Module 2 · Day 2, Session 3 · Reading Matching Results"
CAM_RULE <- 2.0
# The matcher from the deck: nearest neighbour on the score, with replacement.
find_twins <- function(data, score, treat) {
  took <- data[data[[treat]] == 1, ]; rest <- data[data[[treat]] == 0, ]
  twin <- sapply(took[[score]], function(s) which.min(abs(s - rest[[score]])))
  out <- rbind(took, rest[twin, ]); attr(out, "twin_rows") <- twin; out
}
chars <- c("efficiency_index", "age_manager", "educ_manager", "female_manager",
           "foreign_owned", "staff_size", "advanced_filtration",
           "water_treatment_system", "business_area", "recycling_center_distance")
g0  <- gw[gw$round == 0, ]; g1 <- gw[gw$round == 1, ]
biz <- data.frame(g0[, c("business_identifier", "neighborhood_identifier", "enrolled", chars)],
                  y0 = g0$waste_management_costs,
                  y1 = g1$waste_management_costs[match(g0$business_identifier, g1$business_identifier)])
biz$dy <- biz$y1 - biz$y0
std_diff <- function(d, v, ref, t = "enrolled")
  (mean(d[[v]][d[[t]] == 1]) - mean(d[[v]][d[[t]] == 0])) / sd(ref[[v]])
match_fit <- function(f, outcome) {
  d <- biz; d$s <- fitted(glm(f, data = d, family = binomial))
  m <- find_twins(d, "s", "enrolled")
  r <- lm_robust(reformulate("enrolled", outcome), data = m, clusters = neighborhood_identifier)
  list(m = m, est = coef(r)[["enrolled"]], lo = r$conf.low[["enrolled"]], hi = r$conf.high[["enrolled"]])
}
g_lev <- match_fit(reformulate(chars, "enrolled"), "y1")
g_chg <- match_fit(reformulate(chars, "enrolled"), "dy")
m1 <- g_lev$m
biz$score <- fitted(glm(reformulate(chars, "enrolled"), data = biz, family = binomial))
ps_c <- range(biz$score[biz$enrolled == 0])
n_beyond <- sum(biz$score[biz$enrolled == 1] > ps_c[2] | biz$score[biz$enrolled == 1] < ps_c[1])
avoid1 <- sort(abs(c(g_lev$lo, g_lev$hi)))
g_worst <- max(abs(sapply(chars, function(v) std_diff(m1, v, biz))))

tc0 <- subset(tc, round == 0); tc1 <- subset(tc, round == 1)
d2 <- data.frame(segment_id = tc0$segment_id, cameras_installed = tc0$cameras_installed,
                 y0 = tc0$injury_collisions, tc0[, c("baseline_speed_85th", "lanes", "road_length_km",
                                                     "school_within_500m", "prior_collisions_3yr")],
                 lighting_poor = as.integer(tc0$lighting_quality == "poor"))
d2$y1 <- tc1$injury_collisions[match(d2$segment_id, tc1$segment_id)]
d2$dy <- d2$y1 - d2$y0
d2$score <- fitted(glm(cameras_installed ~ baseline_speed_85th + lanes + road_length_km +
                         school_within_500m + prior_collisions_3yr + lighting_poor,
                       data = d2, family = binomial))
m2 <- find_twins(d2, "score", "cameras_installed")
n_cam   <- sum(d2$cameras_installed == 1)
c2_used <- length(unique(attr(m2, "twin_rows")))
c2_ps_c <- range(d2$score[d2$cameras_installed == 0])
c2_out  <- sum(d2$score[d2$cameras_installed == 1] < c2_ps_c[1] | d2$score[d2$cameras_installed == 1] > c2_ps_c[2])
m2_t <- m2[m2$cameras_installed == 1, ]; m2_c <- m2[m2$cameras_installed == 0, ]
c2_base_sd <- (mean(m2_t$y0) - mean(m2_c$y0)) / sd(d2$y0)
c2_levels  <- -(mean(m2_t$y1) - mean(m2_c$y1))
pair_chg   <- -(m2_t$dy - m2_c$dy)
c2_changes <- mean(pair_chg)
c2_ci      <- c2_changes + c(-1.96, 1.96) * sd(pair_chg) / sqrt(length(pair_chg))
c2_worst   <- max(abs(sapply(c("baseline_speed_85th", "lanes", "road_length_km", "school_within_500m",
                               "prior_collisions_3yr"),
                             function(v) (mean(m2_t[[v]]) - mean(m2_c[[v]])) / sd(d2[[v]]))))

compare_rows <- data.frame(
  ` ` = c("Every treated unit had a real lookalike?", "Comparison units reused as twins",
          "Characteristics balanced after matching?", "Outcome's own baseline balanced?",
          "Estimate, follow-up levels", "Estimate, changes", "Least generous end vs the rule"),
  `Case 1 · GreenWaste` = c(sprintf("yes, all but %d", n_beyond),
                 sprintf("%s twins for %s businesses", gfmt(length(unique(attr(m1, "twin_rows")))),
                         gfmt(sum(biz$enrolled == 1))),
                 sprintf("yes (worst %.2f)", g_worst),
                 sprintf("yes (gap %s AED)", gfmt(mean(m1$y0[m1$enrolled == 1]) - mean(m1$y0[m1$enrolled == 0]))),
                 sprintf("%s AED", gfmt(g_lev$est)), sprintf("%s AED", gfmt(g_chg$est)),
                 sprintf("%s against %s: short", gfmt(avoid1[1]), gfmt(RULEBAR))),
  `Case 2 · Cameras` = c(sprintf("no, %d segments (%d%%) outside", c2_out, round(100 * c2_out / n_cam)),
                 sprintf("%d twins for %d segments", c2_used, n_cam),
                 sprintf("yes (worst %.2f)", c2_worst),
                 sprintf("no (std. diff %.2f)", c2_base_sd),
                 sprintf("%.2f avoided", c2_levels), sprintf("%.2f avoided", c2_changes),
                 sprintf("%.2f against %.1f: short", min(c2_ci), CAM_RULE)),
  check.names = FALSE)

s6 <- new_pack() |>
  title_("By hand: find the twins", S6) |>
  print_line("1 per participant") |>
  p_("Three businesses that enrolled in GreenWaste and four that did not. Pair each enrolled business with its closest twin, matching on who they are (manager age and size), not on their cost. Then take the average cost difference across the three pairs.") |>
  p_("Enrolled", bold = TRUE, color = DARK) |>
  body_add_flextable(plain_table(data.frame(` ` = c("A", "B", "C"), `Manager age` = c(45, 38, 52),
    Size = c("small", "large", "small"), `Cost after (AED)` = c("900", "1,400", "700"), check.names = FALSE),
    widths = c(0.6, 1.4, 1.2, 1.6))) |>
  p_("Not enrolled", bold = TRUE, color = DARK) |>
  body_add_flextable(plain_table(data.frame(` ` = c("1", "2", "3", "4"), `Manager age` = c(39, 46, 51, 29),
    Size = c("large", "small", "small", "large"), `Cost after (AED)` = c("2,300", "1,900", "1,800", "2,600"),
    check.names = FALSE), widths = c(0.6, 1.4, 1.2, 1.6))) |>
  p_("These seven businesses are invented for the exercise.", 8.5, italic = TRUE, color = GREY) |>
  h2_("Your pairs") |>
  body_add_flextable(plain_table(data.frame(Enrolled = c("A", "B", "C"), `Its twin` = "",
    `Cost difference (enrolled minus twin)` = "", check.names = FALSE), widths = c(1.2, 1.4, 3.0)) |> tall_rows(0.4)) |>
  p_("Average difference across the three pairs:  ________ AED") |>
  p_("One business is nobody's twin. Which one, and what happens to it?") |>
  write_lines(2) |>
  new_page() |>
  title_("Which case would you trust?", S6) |>
  print_line("1 per group") |>
  p_(sprintf("Two matching studies, read side by side. The rules: GreenWaste must cut costs by at least %s AED; cameras must avoid at least %.1f injury collisions per segment.", gfmt(RULEBAR), CAM_RULE)) |>
  body_add_flextable(plain_table(compare_rows, widths = c(2.4, 2.2, 2.2)) |>
    bg(i = c(1, 4), bg = "#F8E9EA", part = "body")) |>
  illustrative() |>
  h2_("In your group, ten minutes") |>
  p_("1. Which case gives you more confidence, and why?") |> write_lines(1) |>
  p_("2. What would you ask Case 2's evaluator that Case 1 does not raise?") |> write_lines(1) |>
  p_("3. Case 2 is the only one whose central estimate clears its rule. Does that change your answer?") |> write_lines(1) |>
  p_("Our verdict on Case 1:   Act  /  Act with conditions  /  Send back") |>
  p_("Our verdict on Case 2:   Act  /  Act with conditions  /  Send back") |>
  new_page() |>
  title_("AI Snapshot: comparing two studies", S6) |>
  print_line("1 per group") |>
  p_("The prompt, with the two-case table and both balance tables pasted in:", bold = TRUE) |>
  p_("\"Summarise the key differences between these two studies and identify what a commissioner should flag.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("Case 1: Matching was highly effective, with every business matched and excellent covariate balance. The programme reduced costs by around 1,000 AED, with an interval that straddles the 1,000 AED threshold.") |>
  p_("Case 2: Matching was similarly strong, with every segment matched and good balance. The matched estimate shows cameras avoided 2.10 collisions per segment, comfortably exceeding the 2.0 threshold, so this programme should be scaled.") |>
  p_("Which sentences would you sign your name to? Underline them, and cross out the rest. Four minutes, in groups.", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"Two matching studies. For each: how many treated units had no real lookalike; did the outcome's baseline balance; do levels and changes agree? Our decision rules are below. Ask me questions before you answer.\"", italic = TRUE) |>
  p_("Run both, then compare: what did each get wrong, and what did each explain well? Then paste the second answer into a fresh chat and ask it to check for overstatement.") |>
  new_page() |> title_("Take-away card: five questions for a matching result", S6) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Five questions to ask any evaluator presenting matching",
                       "1. What did you match on, and what was left out?",
                       "2. How many treated units had no real lookalike, and what happened to them?",
                       "3. Do the covariates balance, and does the outcome's baseline balance?",
                       "4. Does the answer hold if you change what you matched on, or compare changes instead of levels?",
                       "5. What else might differ that you could not measure?",
                       "", "On my desk, I will ask these about:", "______________________________")), 6),
            min_height = 2.6) |>
  new_page() |> title_("Facilitator key", S6) |> print_line("trainer only") |>
  h2_("Find the twins") |>
  p_("A with 2, B with 1, C with 3. Differences of -1,000, -900 and -1,100: an average of -1,000 AED. Business 4 is nobody's twin, so it is set aside. Listen for anyone matching on cost: that is matching on the outcome, which builds the answer into the comparison.") |>
  h2_("Which case would you trust?") |>
  p_(sprintf("Case 1 is the more trustworthy study, and it cannot show it clears the rule: it estimates %s AED saved, and the least generous end is %s. Case 2 gives the more attractive answer and carries the unquantified risk: %d camera segments (%d%%) have no real lookalike, %d segments share %d twins, and the outcome's own baseline is out of balance (%.2f). Levels say %.2f avoided, changes say %.2f; the interval for changes runs down to %.2f, short of %.1f. Rows 1 and 4 separate the two cases, and neither appears in a typical results table.",
             gfmt(abs(g_lev$est)), gfmt(avoid1[1]), c2_out, round(100 * c2_out / n_cam), n_cam, c2_used,
             c2_base_sd, c2_levels, c2_changes, min(c2_ci), CAM_RULE)) |>
  p_("For the question to Case 2's evaluator, the sharpest is: did the outcome's own baseline balance, and did you compare levels or changes?") |>
  h2_("AI Snapshot") |>
  p_(sprintf("Case 1 is reported accurately, including the interval that straddles the rule. Three false assurances in Case 2: \"similarly strong, every segment matched\" hides the %d segments with no real lookalike; \"comfortably exceeding\" holds only for the changes estimate, the levels estimate does not clear 2.0 and the interval dips to %.2f; \"should be scaled\" rests on the first two and is stated most confidently. The model repeated the study's own summary of itself, and that summary was the misleading part.",
             c2_out, min(c2_ci)))
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
sc <- merge(setNames(subset(sz, round == 0, c(segment_id, child_collisions)), c("segment_id", "base")),
            setNames(subset(sz, round == 1, c(segment_id, child_collisions)), c("segment_id", "follow")))
pooled_pct  <- 100 * (sum(sc$follow) - sum(sc$base)) / sum(sc$base)
has_base    <- sc$base > 0
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
  p_("Each section of this session shows the same data drawn two ways. For every pair, in groups: what is this figure telling you, and what might be wrong or misleading?") |>
  body_add_flextable(plain_table(data.frame(
    Pair = c("1. The same gap, two axes", "2. A bar of means, then the distributions",
             "3. Biggest wins: percentage, then number", "4. After only, then before and after",
             "5. Savings added up, then discounted", "6. The pie, then the counts"),
    `What is it telling you?` = "", `What might be wrong or misleading?` = "", check.names = FALSE),
    widths = c(2.0, 2.4, 2.4)) |> tall_rows(0.85)) |>
  h2_("Predict before the reveal") |>
  p_("Share of enrolled businesses that paid more than the average non-enrolled business:  ________ %") |>
  p_("The pooled change in child collisions and the average of each segment's change: close, or far apart?  ________") |>
  p_("The discount rate at which five years of savings no longer cover the 1,800 AED cost:  ________ %") |>
  new_page() |>
  title_("AI Snapshot: the chart that cannot be wrong", S8) |>
  print_line("1 per group") |>
  p_("The two GreenWaste baseline figures: the same gap between enrolled and not-enrolled businesses, drawn twice.") |>
  side_by_side(fig_axis(0, 2400, "Figure A"), fig_axis(1300, 2200, "Figure B")) |>
  p_("Give the model both figures and this prompt:", bold = TRUE) |>
  p_("\"Which of these two charts better represents the difference between the two groups, and why?\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("Both charts present the same underlying data accurately. The truncated-axis chart is often preferable for a policy audience because it makes the difference visible, and a y-axis that starts at zero is not a requirement in professional data visualisation. On balance the truncated version communicates the finding more effectively, and a reader who wants the absolute values can consult the data labels.") |>
  p_("Four minutes. Is it wrong? Is it right? Is it answering the question that was asked? What does it explain well?", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"This chart will sit beside the claim 'the programme reduced costs substantially'. Is the axis appropriate for that claim, for a non-technical reader?\"", italic = TRUE) |>
  p_(HABITS) |>
  new_page() |> title_("Take-away card: five rules for any figure", S8) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Five rules for any figure",
                       "1. Read the axis before the shape.",
                       "2. Ask what the bar is averaging over.",
                       "3. Check the denominator.",
                       "4. Compare changes, not levels.",
                       "5. Discount the future in front of the reader.",
                       "", "The fastest check: read the y-axis, then the sentence under the figure. Large compared to what?",
                       "", "Questions I will bring to the clinic:", "______________________________", "______________________________")), 4),
            min_height = 3.6) |>
  new_page() |> title_("Facilitator key", S8) |> print_line("trainer only") |>
  h2_("The six pairs") |>
  p_(sprintf("1. The gap is %s AED in both figures (%.0f%% of the non-enrolled mean, %.2f standard deviations). The truncated axis starts at 1,300, so the gap fills the frame. Cover the bars, read the axis, uncover.", gfmt(vgap), 100 * vgap / mean_non, sd_gap)) |>
  p_(sprintf("2. The two groups overlap very little: only %.1f%% of enrolled businesses paid more than the average non-enrolled business. A bar of means cannot show that.", 100 * mean(enr > mean_non))) |>
  p_(sprintf("3. %d of the 400 school-zone segments had no child collisions at baseline, so a percentage change is undefined for them. The largest percentage cuts come from segments that started with two to four collisions; the two top-six lists answer different questions.", sum(sc$base == 0))) |>
  p_(sprintf("4. After only, the gap is %s AED. The comparison group started %s AED worse off and its costs were rising anyway; the DiD estimate is %s AED.", gfmt(ctl_a - off_a), gfmt(ctl_b - off_b), gfmt(abs(did_hand)))) |>
  p_(sprintf("5. Added up, five years of savings reach %s AED; discounted at 5%%, %s. The %s AED gap comes from the discount rate alone. Ratio %.2f.", gfmt(cb_nom), gfmt(cb_dis), gfmt(cb_nom - cb_dis), cb_dis / 1800)) |>
  p_(sprintf("6. The slices overlap: every child collision is also an injury collision, so the percentages are wrong as drawn. The pie also pools both rounds and hides the counts (minor %s, injury %s, of which child %s).", gfmt(sev[["minor"]]), gfmt(sev[["injury"]]), gfmt(sev[["child"]]))) |>
  h2_("Predictions") |>
  p_(sprintf("%.1f%%. Pooled %.1f%% against an average of %.1f%% across the %d segments with a baseline: far apart, because the pooled figure weights segments by their collisions. About %.0f%%.",
             100 * mean(enr > mean_non), pooled_pct, average_pct, sum(has_base), 100 * flip_rate)) |>
  h2_("AI Snapshot") |>
  p_(sprintf("Each sentence is accurate. The answer skips who is reading the figure and the sentence beside it: a truncated axis suits \"a difference exists\", not \"a large difference\". It never checks either picture against the number (%s AED, %.2f standard deviations), and it does not ask who the audience is. The better prompt names both.", gfmt(vgap), sd_gap))
print(s8, target = "Oct14_session2_materials.docx")

# ===========================================================================
# Oct15 S1 · Is This Evidence Credible?
# ===========================================================================
S10 <- "Module 2 · Day 4, Session 1 · Is This Evidence Credible?"
s10 <- new_pack() |>
  title_("Credibility rating sheet", S10) |>
  print_line("1 per participant, with the report") |>
  p_("Work through the report one section at a time. Circle a colour for each section and write the one reason that decided it. Rate the executive summary first, on your own, before reading on.") |>
  body_add_flextable(plain_table(setNames(rating_scale, c("Colour", "What it means")), widths = c(1.2, 5.6))) |>
  p_("Section 2, The programme, describes the programme and is not rated.", 8.5, italic = TRUE, color = GREY) |>
  body_add_flextable(plain_table(data.frame(
    Section = rating_sections$section, Colour = "Green  /  Amber  /  Red",
    `The reason that decided it` = "", `If amber or red: what would settle it` = "", check.names = FALSE),
    widths = c(1.6, 1.3, 2.1, 1.8)) |> tall_rows(0.95)) |>
  new_page() |>
  title_("Your verdict", S10) |>
  print_line("on the back of the rating sheet") |>
  p_("Would you sign off on this evaluation for national scale-up?") |>
  p_("Before reading:   Yes  /  No  /  Not without more answers") |>
  p_("At the end:          Yes  /  No  /  Not without more answers") |>
  p_("The single most important problem you found:") |> write_lines(2) |>
  p_("The strongest thing in the report, and whether it rescues the recommendation:") |> write_lines(2) |>
  p_("Compare your colour for the executive summary with your colour for the results section. If they differ, what did the summary lead you to believe?") |>
  write_lines(3) |>
  new_page() |>
  title_("AI Snapshot: a credibility verdict", S10) |>
  print_line("1 per group") |>
  p_("The prompt, with the report pasted in:", bold = TRUE) |>
  p_("\"Here is an evaluation report on a programme that subsidised waste-management technology for businesses. It found a cost reduction of approximately 1,000 AED per business per year and recommends national scale-up. Assess the credibility of this evidence and tell me whether the recommendation is sound.\"", italic = TRUE) |>
  h2_("A response like this is possible") |>
  p_("Assessment: the evidence is credible and the recommendation is sound. The report is unusually thorough for this kind of evaluation. Several points support its credibility:") |>
  p_("Multiple methods. The use of four estimation approaches, all producing consistent results, is a strong indicator of robustness. When independent methods agree, the finding is unlikely to be an artefact of any single specification.") |>
  p_("Large sample. With roughly 9,900 observations, the study is well powered and the estimates are precise.") |>
  p_("Transparency. The report discloses a change in the survey instrument between rounds and notes that 12 per cent of businesses were lost to follow-up. This level of disclosure suggests a careful and honest evaluation team.") |>
  p_("Appropriate limitations. The limitations section correctly identifies that the randomised comparison estimates the offer effect and that the RDD estimate is local to the cut-off.") |>
  p_("Recommendation. The headline estimate of 1,014 AED exceeds the 1,000 AED threshold, so the programme meets the criterion for scale-up. The recommendation is supported by the evidence.") |>
  p_("Underline the two claims the report does not support. Then find the larger problem the response never mentions. Compare with the answer your own AI gave.", bold = TRUE) |>
  write_lines(3) |>
  h2_("Then run this prompt instead, and compare") |>
  p_("\"The same report claims a cost reduction of approximately 1,000 AED against a decision threshold of 1,000 AED. Do three things. First, list every estimate the report gives, with its confidence interval, and say for each one whether it clears the threshold. Second, identify any claim in the executive summary that is not supported by the results section, and quote both. Third, tell me what the report does not tell me that I would need in order to decide.\"", italic = TRUE) |>
  p_(HABITS) |>
  new_page() |> title_("Take-away card: three habits for reading a report", S10) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("Three habits for reading a report",
                       "1. Tabulate the estimates yourself, with the threshold in its own column. Do not let the report choose which number you see first.",
                       "2. Read the limitations section, then check whether it names the limitations in the data section. If it does not, the analysis stopped early.",
                       "3. Find the preferred specification and check whether the headline is it. When they differ, ask why.",
                       "", "On my desk, I will ask these about:", "______________________________")), 6),
            min_height = 2.8) |>
  new_page() |> title_("Facilitator key", S10) |> print_line("trainer only") |>
  body_add_flextable(plain_table(data.frame(Section = rating_sections$section,
    `What is genuinely good` = rating_sections$strength, `The planted problem` = rating_sections$weakness,
    check.names = FALSE), widths = c(1.3, 2.7, 2.8)) |> fontsize(size = 9, part = "body")) |>
  h2_("The most important problem") |>
  p_(rating_decisive) |>
  h2_("AI Snapshot") |>
  p_("The two unsupported claims: \"the programme meets the criterion for scale-up\" and \"the recommendation is supported by the evidence\". The larger problem: the response reads \"approximately 1,000\" as if a method had produced 1,000, and never notices that the preferred specification is 816, which fails the threshold, or asks whether 1,014 was chosen as the headline because it clears the bar. It also treats disclosure of attrition as evidence of quality. What it did well: it found the real disclosures, described the offer-effect and locality limitations correctly, and reached a verdict. The better prompt asks for a comparison instead of a verdict, so the 816 is hard to miss.")
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
  p_("You started this design in Module 1. Write it down as it stands now, against the eight conditions. If you do not have the Module 1 document, use the recap in each row: the conditions have not changed.") |>
  body_add_flextable(plain_table(data.frame(
    Condition = sprintf("%d. %s. %s", seq_len(nrow(design_conditions)), design_conditions$condition,
                        design_conditions$recap),
    `Your design` = "", check.names = FALSE), widths = c(2.9, 3.9)) |> tall_rows(0.85) |>
    fontsize(j = 1, size = 9.5, part = "body")) |>
  p_("Your counterfactual, in one sentence. You will read it out in the pitch:") |> write_lines(2) |>
  new_page() |>
  title_("Part 2. The four additions (30 minutes)", S12) |>
  print_line("1 per team (continues the Design Update)")
for (i in seq_len(nrow(design_additions))) {
  s12 <- s12 |>
    h2_(sprintf("%d. %s", i, design_additions$addition[i])) |>
    p_(sprintf("From: %s", design_additions$from[i]), 9, italic = TRUE, color = GREY) |>
    p_(design_additions$asks[i]) |>
    write_lines(3)
}
s12 <- s12 |>
  new_page() |>
  title_("Part 3. Your five-minute pitch", S12) |>
  print_line("1 per team (continues the Design Update)") |>
  p_("Five minutes per team, then three minutes of feedback from the room. Say what your design cannot establish before you say what you want.") |>
  body_add_flextable(plain_table(data.frame(Part = pitch_structure$part, Time = pitch_structure$minutes,
    `What it says` = pitch_structure$says, `Our notes` = "", check.names = FALSE),
    widths = c(1.4, 0.6, 2.4, 2.4)) |> tall_rows(1.0)) |>
  new_page() |>
  title_("Feedback slips", S12) |>
  print_line("1 page per participant, cut into four slips; one slip per pitch you hear, handed to the team") |>
  add_cards(rep(list(c("Feedback for team: ____________________",
                       "1. What is the design? Say it back in one sentence.", "", "",
                       "2. What would make it fail? The one assumption that would have to break.", "", "",
                       "3. What is missing? One thing you would have wanted to hear.", "", "",
                       "Aim it at the design, not at the team.")), 4),
            min_height = 4.2) |>
  new_page() |> title_("Take-away card: the one question", S12) |>
  print_line("1 per participant, cut into cards") |>
  add_cards(rep(list(c("The question behind every session this week",
                       "What is being compared to what, and why should those two things be comparable?",
                       "", "The first evaluation decision I will make back at my desk:",
                       "______________________________", "______________________________")), 8),
            min_height = 1.9) |>
  new_page() |> title_("Facilitator key", S12) |> print_line("trainer only") |>
  p_("There are no right answers to the template. Use this page while circulating.") |>
  h2_("Timing") |>
  p_("Part 1: twenty minutes. Part 2: thirty minutes, then a five-minute break. Pitches: five minutes each, then three minutes of feedback in the fixed order (say it back, what would make it fail, what is missing).") |>
  h2_("Prompts on the slides") |>
  p_("The one condition that decides the rest: the counterfactual. Every method this week was a way of making it operational: randomisation, a cut-off, a matched comparison, a parallel trend.") |>
  p_("Hardest addition before any data: usually the cost-benefit framework, because the benefit per unit is the thing the evaluation has yet to estimate. Teams can still state the threshold, the horizon and the discount rate.") |>
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
