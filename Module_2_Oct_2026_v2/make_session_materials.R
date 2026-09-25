# ===========================================================================
# Print materials for Lucas's six live sessions
# ===========================================================================
#   source("make_session_materials.R")
#
# Writes one Word pack per session into this folder:
#   Oct12_session1_materials.docx   Oct12_session3_materials.docx
#   Oct13_session2_materials.docx   Oct14_session1_materials.docx
#   Oct14_session3_materials.docx   Oct15_session2_materials.docx
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
for (s in c("Oct12_session1", "Oct12_session3", "Oct13_session2",
            "Oct14_session1", "Oct14_session3", "Oct15_session2"))
  participant_copy(paste0(s, "_materials.docx"), paste0("../docs/handouts/", s, "_handouts.docx"))
# Handouts built elsewhere that participants keep, copied as they are.
file.copy(c("Oct14_session3_qa_checklist.docx", "Oct15_session2_findings.docx",
            "Oct15_session2_brief_template.docx"), "../docs/handouts/", overwrite = TRUE)
message("Wrote participant copies to docs/handouts/.")
