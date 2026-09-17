# ============================================================
# means_table_noIV.R
# Standalone script: Table 1 - Mean Baseline Characteristics (No IV)
#
# Builds the descriptive/baseline means table WITHOUT the Instrumental
# Variables (eligible-enrolled) columns, using the analysis dataset
# evaluation_data_GreenWaste.csv. That dataset's treatment/enrollment
# indicator is `enrolled` (= 1 for eligible businesses in treatment
# neighborhoods that enrolled, 0 otherwise). It does NOT contain the
# `intent_to_treat` or `enrolled_rp` variables, so this script is fully
# self-contained and does not depend on update_data.R.
#
# Outputs:
#   ./case_study_outputs/means_table_noIV.png        (kableExtra image)
#   ./case_study_outputs/mean_baseline_stats_noIV.docx (editable Word table)
# ============================================================

library(dplyr)
library(tidyr)
library(kableExtra)
library(flextable)
library(officer)
# webshot2 + magick are only needed for the optional PNG export (see below);
# they are NOT required for the editable Word (.docx) output.

# ---- Data ----
df <- read.csv("./evaluation_data_GreenWaste.csv")

# Baseline covariates summarised in the table
covars <- c("age_manager", "age_deputy", "educ_manager", "educ_deputy",
            "female_manager", "foreign_owned", "staff_size",
            "advanced_filtration", "water_treatment_system",
            "business_area", "recycling_center_distance")

# Helper: mean of each covariate by a 0/1 grouping variable, returned wide
# (one column per group value) with a "Variable" key column.
group_means <- function(data, groupvar, prefix) {
  d <- data %>% select(all_of(c(groupvar, covars)))
  names(d)[1] <- "grp"   # rename the grouping column to a fixed name
  d %>%
    pivot_longer(cols = all_of(covars), names_to = "name", values_to = "value") %>%
    group_by(name, grp) %>%
    summarise(m = mean(value, na.rm = TRUE), .groups = "drop") %>%
    pivot_wider(names_from = grp, values_from = m,
                names_prefix = paste0(prefix, "_")) %>%
    rename(Variable = name)
}

# ---- Column blocks (each = 2 columns) ----

# Before-After: enrolled units, baseline (round 0) vs follow-up (round 1)
before_after <- group_means(df %>% filter(enrolled == 1), "round", "BA")

# RCT (Eligible): eligible units at baseline, control vs treatment neighborhood
rct <- group_means(df %>% filter(round == 0, eligible == 1),
                   "treatment_neighborhood", "RCT")

# With-Without / RDD / DID: treatment-neighborhood units at baseline,
# not enrolled (0) vs enrolled (1)
ww <- group_means(df %>% filter(round == 0, treatment_neighborhood == 1),
                  "enrolled", "WW")

# PSM (Overall): all units at baseline, not enrolled (0, treat + control) vs enrolled (1)
psm <- group_means(df %>% filter(round == 0), "enrolled", "PSM")

# ---- Combine + relabel + round ----
final_table <- before_after %>%
  left_join(rct, by = "Variable") %>%
  left_join(ww,  by = "Variable") %>%
  left_join(psm, by = "Variable") %>%
  mutate(Variable = recode(Variable,
    "age_manager"               = "Manager Age",
    "age_deputy"                = "Deputy Age",
    "educ_manager"              = "Manager Education",
    "educ_deputy"               = "Deputy Education",
    "female_manager"            = "Female Manager",
    "foreign_owned"             = "Foreign Owned",
    "staff_size"                = "Staff Size",
    "advanced_filtration"       = "Advanced Filtration",
    "water_treatment_system"    = "Water Treatment System",
    "business_area"             = "Business Area",
    "recycling_center_distance" = "Distance from Nearest Recycling Center"
  )) %>%
  mutate(across(-Variable, ~ round(.x, 2)))

# Ensure the covariate rows keep a sensible order
var_order <- c("Manager Age","Deputy Age","Manager Education","Deputy Education",
               "Female Manager","Foreign Owned","Staff Size","Advanced Filtration",
               "Water Treatment System","Business Area",
               "Distance from Nearest Recycling Center")
final_table <- final_table %>% arrange(match(Variable, var_order))

# ---- N row (number of observations per column) ----
N_row <- data.frame(
  Variable = "N",
  BA_0   = sum(df$round == 0 & df$enrolled == 1, na.rm = TRUE),
  BA_1   = sum(df$round == 1 & df$enrolled == 1, na.rm = TRUE),
  RCT_0  = sum(df$round == 0 & df$eligible == 1 & df$treatment_neighborhood == 0, na.rm = TRUE),
  RCT_1  = sum(df$round == 0 & df$eligible == 1 & df$treatment_neighborhood == 1, na.rm = TRUE),
  WW_0   = sum(df$round == 0 & df$treatment_neighborhood == 1 & df$enrolled == 0, na.rm = TRUE),
  WW_1   = sum(df$round == 0 & df$treatment_neighborhood == 1 & df$enrolled == 1, na.rm = TRUE),
  PSM_0  = sum(df$round == 0 & df$enrolled == 0, na.rm = TRUE),
  PSM_1  = sum(df$round == 0 & df$enrolled == 1, na.rm = TRUE),
  stringsAsFactors = FALSE
)
# Align N_row column names to final_table (group_means names them e.g. BA_0/BA_1)
names(N_row) <- names(final_table)

final_table_noIV_with_N <- bind_rows(final_table, N_row)

# ---- Output directory ----
outdir <- "./case_study_outputs"
if (!dir.exists(outdir)) dir.create(outdir, recursive = TRUE)

col_labels <- c(
  "Variable",
  "Enrolled\nBefore", "Enrolled\nAfter",
  "Eligible\nControl", "Eligible\nTreatment",
  "Not Enrolled\nTreatment", "Enrolled\nTreatment",
  "Not Enrolled (Treat and Control)", "Enrolled\nTreatment"
)

# ---- Optional PNG export (kableExtra) --------------------------------------
# This step needs webshot2 + magick (a headless Chrome and ImageMagick). If they
# are not installed it is skipped with a message -- the editable Word table below
# is produced either way.
have_png <- requireNamespace("webshot2", quietly = TRUE) &&
            requireNamespace("magick",   quietly = TRUE)
if (have_png) {
means_table_noIV <- final_table_noIV_with_N %>%
  kable(
    format = "html",
    booktabs = TRUE,
    caption = "<center><span style='font-size:20px; color: black; font-weight: bold;'>Table 1: Mean Baseline Characteristics</span></center>",
    col.names = col_labels,
    align = c("l", rep("c", 8)),
    escape = FALSE
  ) %>%
  kable_styling(full_width = FALSE,
                bootstrap_options = c("striped", "hover", "condensed"),
                position = "left") %>%
  add_header_above(
    header = c(
      " " = 1,
      "Before-After Means" = 2,
      "Eligible Units Means (RCT)" = 2,
      "Treatment Enrolled Units Means (With-Without, RDD, DID)" = 2,
      "Overall Enrolled Means (PSM)" = 2
    ),
    bold = TRUE, font_size = 12, escape = FALSE
  ) %>%
  row_spec(nrow(final_table_noIV_with_N), bold = TRUE, background = "#F0F0F0")

save_kable(means_table_noIV, file = file.path(outdir, "means_table_noIV.png"))
} else {
  message("Skipping PNG export: install 'webshot2' and 'magick' to enable it. The editable .docx is still written.")
}

# ---- flextable (editable Word table) ----
df_noIV <- final_table_noIV_with_N

labels_noIV <- col_labels
groups_noIV <- c(
  "",
  "Before-After Means", "Before-After Means",
  "Eligible Units Means (RCT)", "Eligible Units Means (RCT)",
  "Treatment Enrolled Units Means (With-Without, RDD, DID)", "Treatment Enrolled Units Means (With-Without, RDD, DID)",
  "Overall Enrolled Means (PSM)", "Overall Enrolled Means (PSM)"
)
head_map_noIV <- data.frame(
  col_keys = names(df_noIV),
  group    = groups_noIV,
  label    = labels_noIV,
  stringsAsFactors = FALSE
)

ft_noIV <- flextable(df_noIV)
ft_noIV <- set_header_df(ft_noIV, mapping = head_map_noIV, key = "col_keys")
ft_noIV <- merge_h(ft_noIV, part = "header")
ft_noIV <- align(ft_noIV, part = "header", j = 1:ncol(df_noIV), align = "center")
ft_noIV <- align(ft_noIV, part = "header", j = 1, align = "left")
ft_noIV <- theme_booktabs(ft_noIV)
ft_noIV <- bg(ft_noIV, i = seq_len(nrow(df_noIV)) %% 2 == 0, bg = "#F7F7F7", part = "body")
ft_noIV <- align(ft_noIV, j = 1, align = "left", part = "body")
ft_noIV <- align(ft_noIV, j = 2:ncol(df_noIV), align = "center", part = "body")
ft_noIV <- fontsize(ft_noIV, part = "all", size = 10)
ft_noIV <- padding(ft_noIV, part = "all", padding = 1)
ft_noIV <- autofit(ft_noIV)
ft_noIV <- fit_to_width(ft_noIV, max_width = 6.8)
ft_noIV <- width(ft_noIV, j = 1, width = 2.7)
ft_noIV <- bold(ft_noIV, i = nrow(df_noIV), part = "body")
ft_noIV <- bg(ft_noIV, i = nrow(df_noIV), bg = "#F0F0F0")

doc_noIV <- read_docx()
doc_noIV <- body_add_flextable(doc_noIV, ft_noIV)
print(doc_noIV, target = file.path(outdir, "mean_baseline_stats_noIV.docx"))

cat("Done. Wrote:\n",
    file.path(outdir, "means_table_noIV.png"), "\n",
    file.path(outdir, "mean_baseline_stats_noIV.docx"), "\n")
