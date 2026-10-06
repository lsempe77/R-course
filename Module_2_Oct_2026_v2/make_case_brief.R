# ===========================================================================
# GreenWaste case brief: the one-page handout participants keep all week
# ===========================================================================
#   Rscript make_case_brief.R  ->  GreenWaste_case_brief.docx
# Same content as the case introduction slides (greenwaste_case_intro.qmd);
# every number comes from evaluation_data_GreenWaste_simple.csv. No results:
# the estimates belong to the sessions.

suppressPackageStartupMessages({ library(officer); library(flextable) })
gw <- read.csv("evaluation_data_GreenWaste_simple.csv")
source("greenwaste_case.R")

FONT <- "Arial"; DARK <- "#063360"; BLUE <- "#215a9e"; GREY <- "#545860"; RED <- "#B8272C"
n  <- function(x) format(x, big.mark = ",")
av <- function(x) format(round(mean(x)), big.mark = ",")
set_flextable_defaults(font.family = FONT, font.size = 10, padding = 4, border.color = "#9AA8B8")
txt <- function(x, size = 10.5, bold = FALSE, color = "black", italic = FALSE)
  ftext(x, fp_text(font.family = FONT, font.size = size, bold = bold, color = color, italic = italic))
par_ <- function(doc, ..., after = 4) body_add_fpar(doc, fpar(..., fp_p = fp_par(padding.bottom = after)))
h2 <- function(doc, x) par_(doc, txt(x, 12.5, TRUE, BLUE), after = 3)

tbl <- function(df, widths, header_fill = "#e3ebf5") {
  flextable(df) |> width(width = widths) |>
    bold(part = "header") |> color(part = "header", color = DARK) |> bg(part = "header", bg = header_fill) |>
    border_remove() |> hline(border = fp_border(color = "#9AA8B8", width = 0.75), part = "body") |>
    hline_top(border = fp_border(color = DARK, width = 1.2), part = "header") |>
    valign(valign = "top", part = "all") |> align(align = "left", part = "all")
}

doc <- read_docx() |>
  body_set_default_section(prop_section(page_size = page_size(orient = "portrait"),
    page_margins = page_mar(top = 0.6, bottom = 0.6, left = 0.75, right = 0.75))) |>
  par_(txt("Module 2 · Reading Impact Evaluation Results · the case for the week", 9, color = GREY), after = 0) |>
  par_(txt("The GreenWaste programme", 20, TRUE, DARK), after = 2) |>
  par_(txt("Invented for this training. Keep this page: every GreenWaste session uses it.", 9.5, color = GREY, italic = TRUE), after = 8) |>

  h2("What it is") |>
  body_add_flextable(tbl(data.frame(
    `What it does` = "A subsidy for new waste equipment, technical help to install it, and training for staff.",
    `Who it is for` = "Businesses with an efficiency score of 58 or below. Every business has a score from 0 to 100; higher means more efficient.",
    `The decision` = sprintf("Scale up nationally only if waste costs fall by at least %s AED per business per year.", n(RULE)),
    check.names = FALSE), widths = c(2.3, 2.3, 2.3)) |> color(j = 3, part = "header", color = RED)) |>
  par_(txt(""), after = 4) |>

  h2("How it reached businesses") |>
  body_add_flextable(tbl(data.frame(
    ` ` = c("Pilot district", "Rest of the city"),
    Businesses = c(sprintf("%s, all scoring 58 or below", n(nrow(pilot))), sprintf("%s, every score", n(nrow(city)))),
    `Who took part` = c(sprintf("A lottery picked %s; the other %s waited", n(sum(pilot$took_part)), n(sum(pilot$took_part == 0))),
                        sprintf("A rule: every business scoring 58 or below took part (%s); the %s above did not", n(sum(took)), n(sum(!took)))),
    Measured = c("Waste costs before, and 12 months after", "Waste costs before, and 12 months after"),
    check.names = FALSE), widths = c(1.3, 1.6, 2.6, 1.5)) |> bold(j = 1, part = "body") |> color(j = 1, color = DARK, part = "body")) |>
  par_(txt(""), after = 4) |>

  h2("Four groups of businesses") |>
  par_(txt("Average waste costs per business, in AED, before and 12 months after.", 9.5, color = GREY), after = 3) |>
  body_add_flextable(tbl(data.frame(
    ` ` = c("Pilot district (lottery)", "Rest of the city (score rule)"),
    `Took part` = c(sprintf("%s businesses:  %s → %s", n(sum(pilot$took_part)), av(pilot$cost_before[pilot$took_part == 1]), av(pilot$cost_after[pilot$took_part == 1])),
                    sprintf("%s businesses:  %s → %s", n(sum(took)), av(city$cost_before[took]), av(city$cost_after[took]))),
    `Did not take part` = c(sprintf("%s businesses:  %s → %s", n(sum(pilot$took_part == 0)), av(pilot$cost_before[pilot$took_part == 0]), av(pilot$cost_after[pilot$took_part == 0])),
                            sprintf("%s businesses:  %s → %s", n(sum(!took)), av(city$cost_before[!took]), av(city$cost_after[!took]))),
    check.names = FALSE), widths = c(2.0, 2.45, 2.45)) |> bold(j = 1, part = "body") |> color(j = 1, color = DARK, part = "body")) |>
  par_(txt("Every method this week compares the businesses that took part with one of the other groups. The question each session asks: compared with whom, and is that a fair comparison?", 10, italic = TRUE), after = 8) |>

  h2("The data: one row per business") |>
  body_add_flextable(tbl(data.frame(
    Column = c("business", "setting", "score", "took_part", "cost_before, cost_after", "manager_age, staff, area, filtration"),
    Meaning = c("an identifier", "pilot (the lottery) or city (the rule)", "efficiency score, 0 to 100",
                "1 if the business took part in GreenWaste",
                "waste-management costs in AED, before and 12 months after",
                "manager's age; number of staff; premises area (100 m2); 1 if advanced filtration was already installed"),
    check.names = FALSE), widths = c(2.2, 4.7)) |> bold(j = 1, part = "body") |> font(j = 1, fontname = "Consolas", part = "body"))

print(doc, target = "GreenWaste_case_brief.docx")
cat("Wrote GreenWaste_case_brief.docx\n")

# ---------------------------------------------------------------------------
# The picture card: handed out with the case introduction (Oct12 S3, slide 1).
# Only the story: no numbers, no decision rule. The map is the slide's own
# graphic (assets/greenwaste_city_map.png, captured from the rendered deck).
# ---------------------------------------------------------------------------
card <- read_docx() |>
  body_set_default_section(prop_section(page_size = page_size(orient = "landscape"),
    page_margins = page_mar(top = 0.6, bottom = 0.6, left = 0.7, right = 0.7))) |>
  par_(txt("Module 2 · Reading Impact Evaluation Results · the case for the week", 9, color = GREY), after = 0) |>
  par_(txt("The GreenWaste programme", 22, TRUE, DARK), after = 4) |>
  par_(txt("GreenWaste helps businesses cut their waste costs. Here is how it reached them.", 13), after = 8) |>
  body_add_img("assets/greenwaste_city_map.png", width = 9.6, height = 9.6 * 1356 / 3456) |>
  par_(txt(""), after = 6) |>
  par_(txt("In the pilot district, ", 13), txt("a lottery", 13, TRUE), txt(" chose which shops joined. Everywhere else, shops scoring ", 13),
       txt("58 or below", 13, TRUE), txt(" joined. Every business has an efficiency score from 0 to 100; higher means more efficient.", 13), after = 4) |>
  par_(txt("Invented for this training.", 9.5, color = GREY, italic = TRUE))
print(card, target = "GreenWaste_case_card.docx")
cat("Wrote GreenWaste_case_card.docx\n")
