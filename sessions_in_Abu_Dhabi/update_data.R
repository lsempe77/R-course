# Update GreenWaste Program data

# Load in data

library(ggplot2)
library(dplyr)
library(modelsummary)
library(estimatr)
library(kableExtra)

df <- read.csv("./evaluation_data.csv")

# Change waste management cost to reasonable about in Dirham (AED)
df$waste_management_costs<-df$waste_management_costs*100

# Change variable names
df <- df %>%
  rename(neighborhood_identifier = zone_identifier,
         business_identifier = facility_identifier,
         business_area = facility_area,
         treatment_neighborhood = treatment_zone, 
         intent_to_treat = enrolled)

# Drop variables we no longer need
df <- subset(df, select = -c(promotion_zone))

# Save new data
write.csv(df, "C:/Users/FionaKastel/OneDrive - 3ie/Documents/GitHub/R-course/sessions_in_Abu_Dhabi/evaluation_data_GreenWaste.csv")




######### Create Table of Means
# df <- read.csv("C:/Users/FionaKastel/OneDrive - 3ie/Documents/GitHub/R-course/sessions_in_Abu_Dhabi/update_data.R/evaluation_data_GreenWaste.csv")
df <- read.csv("./evaluation_data_GreenWaste.csv")
## Table of means
m <- df %>%
  filter(round == 0) %>% 
  select(treatment_neighborhood, age_manager, age_deputy,
         educ_manager, educ_deputy, 
         female_manager, foreign_owned, staff_size,
         advanced_filtration, water_treatment_system, 
         business_area, recycling_center_distance) %>%
  pivot_longer(-c("treatment_neighborhood")) %>%
  group_by(name, treatment_neighborhood) %>%  # Group by both name and treatment_neighborhood
  summarise(
    Mean = mean(value, na.rm = TRUE),      # Calculate the mean
    .groups = 'drop'                       # Drop the grouping after summarising
  ) %>%
  # Optionally reshape to a wider format if you want separate columns for each treatment neighborhood
  pivot_wider(
    names_from = treatment_neighborhood,
    values_from = c(Mean),
    names_glue = "{.value}_{treatment_neighborhood}"
  ) %>%
  mutate(name = recode(name,
                       "age_manager" = "Manager Age",
                       "age_deputy" = "Deputy Age",
                       "educ_manager" = "Manager Education",
                       "educ_deputy" = "Deputy Education",
                       "female_manager" = "Female Manager",
                       "foreign_owned" = "Foreign Owned",
                       "staff_size" = "Staff Size",
                       "advanced_filtration" = "Advanced Filtration",
                       "water_treatment_system" = "Water Treatment System",
                       "business_area" = "Business Area",
                       "recycling_center_distance" = "Distance from Nearest Recycling Center"
  )) %>%
  rename(Variable = name) %>%
  mutate(across(starts_with("Mean_"), ~ round(.x, 2))) 
# %>% 
#   rename(`Control Neighborhoods` = Mean_0, 
#          `Treatment Neighborhoods` = Mean_1)

# m
# kable(m) %>% scroll_box(width = "600px", height = "400px")
# # Now, format the table using kable
# m %>%
#   kable(
#     format = "html", # Or "latex" for PDF output
#     booktabs = TRUE,
#     # caption = "Mean Baseline Characteristics", # This is your table title
#     caption = "<center><span style='font-size:20px; color: black; font-weight: bold;'>Mean Baseline Characteristics</span>",
#     col.names = c(
#       "Variable", 
#       "Control Neighborhoods",
#       "Treatment Neighborhoods"
#     ), 
#     align = c("l", "c", "c"), # Left-align 'Variable', Center-align others
#     escape = FALSE # Crucial for HTML tags to render correctly
#   ) %>%
#   kable_styling(
#     full_width = FALSE,
#     bootstrap_options = c("striped", "hover", "condensed"),
#     position = "left"
#   ) %>%
#   scroll_box(width = "600px", height = "400px")

# Table of means filtered for eligible units (RCT)
# Calculate means for eligible units
eligible_means <- df %>%
  filter(round == 0, eligible == 1) %>% # Filter for round 0 and eligible == 1
  select(treatment_neighborhood, age_manager, age_deputy,
         educ_manager, educ_deputy, 
         female_manager, foreign_owned, staff_size,
         advanced_filtration, water_treatment_system, 
         business_area, recycling_center_distance) %>%
  pivot_longer(-c("treatment_neighborhood")) %>%
  group_by(name, treatment_neighborhood) %>%
  summarise(
    Eligible_Mean = mean(value, na.rm = TRUE), # Calculate mean for eligible units
    .groups = 'drop'
  ) %>%
  pivot_wider(
    names_from = treatment_neighborhood,
    values_from = Eligible_Mean,
    names_glue = "Eligible_{.value}_{treatment_neighborhood}"
  ) %>%
  mutate(name = recode(name,
                       "age_manager" = "Manager Age",
                       "age_deputy" = "Deputy Age",
                       "educ_manager" = "Manager Education",
                       "educ_deputy" = "Deputy Education",
                       "female_manager" = "Female Manager",
                       "foreign_owned" = "Foreign Owned",
                       "staff_size" = "Staff Size",
                       "advanced_filtration" = "Advanced Filtration",
                       "water_treatment_system" = "Water Treatment System",
                       "business_area" = "Business Area",
                       "recycling_center_distance" = "Distance from Nearest Recycling Center"
  )) %>%
  rename(Variable = name) %>%
  mutate(across(starts_with("Eligible_"), ~ round(.x, 2)))

# Table of means filtered for treatment neighborhood enrolled vs un-enrolled units (RDD, DID)
# Calculate means for enrolled treatment units
enrolled_means <- df %>%
  filter(round == 0, treatment_neighborhood == 1) %>% # Filter for round 0 and treat == 1
  select(enrolled, age_manager, age_deputy,
         educ_manager, educ_deputy, 
         female_manager, foreign_owned, staff_size,
         advanced_filtration, water_treatment_system, 
         business_area, recycling_center_distance) %>%
  pivot_longer(-c("enrolled")) %>%
  group_by(name, enrolled) %>%
  summarise(
    Treatment_Mean = mean(value, na.rm = TRUE), # Calculate mean for eligible units
    .groups = 'drop'
  ) %>%
  pivot_wider(
    names_from = enrolled,
    values_from = Treatment_Mean,
    names_glue = "Treatment_{.value}_{enrolled}"
  ) %>%
  mutate(name = recode(name,
                       "age_manager" = "Manager Age",
                       "age_deputy" = "Deputy Age",
                       "educ_manager" = "Manager Education",
                       "educ_deputy" = "Deputy Education",
                       "female_manager" = "Female Manager",
                       "foreign_owned" = "Foreign Owned",
                       "staff_size" = "Staff Size",
                       "advanced_filtration" = "Advanced Filtration",
                       "water_treatment_system" = "Water Treatment System",
                       "business_area" = "Business Area",
                       "recycling_center_distance" = "Distance from Nearest Recycling Center"
  )) %>%
  rename(Variable = name) %>%
  mutate(across(starts_with("Treatment_"), ~ round(.x, 2)))

# Calculate means for enrolled treatment units before vs after (Before-After)
before_after_means <- df %>%
  filter(enrolled == 1) %>% # Filter for round 0 and treat == 1
  select(round, age_manager, age_deputy,
         educ_manager, educ_deputy, 
         female_manager, foreign_owned, staff_size,
         advanced_filtration, water_treatment_system, 
         business_area, recycling_center_distance) %>%
  pivot_longer(-c("round")) %>%
  group_by(name, round) %>%
  summarise(
    After_Mean = mean(value, na.rm = TRUE), # Calculate mean for eligible units
    .groups = 'drop'
  ) %>%
  pivot_wider(
    names_from = round,
    values_from = After_Mean,
    names_glue = "Before_{.value}_{round}"
  ) %>%
  mutate(name = recode(name,
                       "age_manager" = "Manager Age",
                       "age_deputy" = "Deputy Age",
                       "educ_manager" = "Manager Education",
                       "educ_deputy" = "Deputy Education",
                       "female_manager" = "Female Manager",
                       "foreign_owned" = "Foreign Owned",
                       "staff_size" = "Staff Size",
                       "advanced_filtration" = "Advanced Filtration",
                       "water_treatment_system" = "Water Treatment System",
                       "business_area" = "Business Area",
                       "recycling_center_distance" = "Distance from Nearest Recycling Center"
  )) %>%
  rename(Variable = name) %>%
  mutate(across(starts_with("Before_"), ~ round(.x, 2)))

# Table of means filtered for treatment neighborhood enrolled vs ALL un-enrolled units (PSM)
enrolled_all_means <- df %>%
  filter(round == 0) %>% # Filter for round 0
  select(enrolled, age_manager, age_deputy,
         educ_manager, educ_deputy, 
         female_manager, foreign_owned, staff_size,
         advanced_filtration, water_treatment_system, 
         business_area, recycling_center_distance) %>%
  pivot_longer(-c("enrolled")) %>%
  group_by(name, enrolled) %>%
  summarise(
    Enrolled_Mean = mean(value, na.rm = TRUE), # Calculate mean for enrolled units
    .groups = 'drop'
  ) %>%
  pivot_wider(
    names_from = enrolled,
    values_from = Enrolled_Mean,
    names_glue = "Enrolled_{.value}_{enrolled}"
  ) %>%
  mutate(name = recode(name,
                       "age_manager" = "Manager Age",
                       "age_deputy" = "Deputy Age",
                       "educ_manager" = "Manager Education",
                       "educ_deputy" = "Deputy Education",
                       "female_manager" = "Female Manager",
                       "foreign_owned" = "Foreign Owned",
                       "staff_size" = "Staff Size",
                       "advanced_filtration" = "Advanced Filtration",
                       "water_treatment_system" = "Water Treatment System",
                       "business_area" = "Business Area",
                       "recycling_center_distance" = "Distance from Nearest Recycling Center"
  )) %>%
  rename(Variable = name) %>%
  mutate(across(starts_with("Enrolled_"), ~ round(.x, 2)))

# Eligible enrolled (IV)
eligible_enrolled_means <- df %>%
  filter(round == 0, eligible == 1) %>% # Filter for round 0 and eligible == 1
  select(enrolled_rp, age_manager, age_deputy,
         educ_manager, educ_deputy, 
         female_manager, foreign_owned, staff_size,
         advanced_filtration, water_treatment_system, 
         business_area, recycling_center_distance) %>%
  pivot_longer(-c("enrolled_rp")) %>%
  group_by(name, enrolled_rp) %>%
  summarise(
    Mean = mean(value, na.rm = TRUE), # Calculate mean for eligible units
    .groups = 'drop'
  ) %>%
  pivot_wider(
    names_from = enrolled_rp,
    values_from = Mean,
    names_glue = "Eligible_Enrolled_{.value}_{enrolled_rp}"
  ) %>%
  mutate(name = recode(name,
                       "age_manager" = "Manager Age",
                       "age_deputy" = "Deputy Age",
                       "educ_manager" = "Manager Education",
                       "educ_deputy" = "Deputy Education",
                       "female_manager" = "Female Manager",
                       "foreign_owned" = "Foreign Owned",
                       "staff_size" = "Staff Size",
                       "advanced_filtration" = "Advanced Filtration",
                       "water_treatment_system" = "Water Treatment System",
                       "business_area" = "Business Area",
                       "recycling_center_distance" = "Distance from Nearest Recycling Center"
  )) %>%
  rename(Variable = name) %>%
  mutate(across(starts_with("Eligible_"), ~ round(.x, 2)))



# Combine tables
# Join the tables together
final_table <- m %>%
  left_join(before_after_means, by="Variable") %>%
  left_join(eligible_means, by = "Variable") %>%
  left_join(enrolled_means, by = "Variable") %>%
  left_join(enrolled_all_means, by = "Variable")

# Calculate N for each group
# This data frame will have one row and columns matching your final_table structure
N_row <- df %>%
  summarise(
    Variable = "N", # Label for the row
    # Overall Ns
    `Mean_0` = sum(round == 0 & treatment_neighborhood == 0, na.rm = TRUE),
    `Mean_1` = sum(round == 0 & treatment_neighborhood == 1, na.rm = TRUE),
    
    # Before-After
    `Before_After_Mean_0` = sum(round == 0 & enrolled == 1, na.rm = TRUE),
    `Before_After_Mean_1` = sum(round == 1 & enrolled == 1, na.rm = TRUE),
    
    # Eligible Ns
    `Eligible_Eligible_Mean_0` = sum(round == 0 & treatment_neighborhood == 0 & eligible == 1, na.rm = TRUE),
    `Eligible_Eligible_Mean_1` = sum(round == 0 & treatment_neighborhood == 1 & eligible == 1, na.rm = TRUE),
    
    # Eligible Enrolled Ns
    `Eligible_Enrolled_Mean_0` = sum(round == 0 & enrolled_rp == 0 & eligible == 1, na.rm = TRUE),
    `Eligible_Enrolled_Mean_1` = sum(round == 0 & enrolled_rp == 1 & eligible == 1, na.rm = TRUE),
    
    # Treatment Enrolled Ns (based on 'enrolled' variable)
    # Assuming 'enrolled' is 0 for Not Enrolled, 1 for Enrolled
    `Treatment_Treatment_Mean_0` = sum(round == 0 & treatment_neighborhood == 1 & enrolled == 0, na.rm = TRUE), # Treatment Not Enrolled
    `Treatment_Treatment_Mean_1` = sum(round == 0 & treatment_neighborhood == 1 & enrolled == 1, na.rm = TRUE), # Enrolled Treatment
    
    # Overall Enrolled Ns (based on your 'enrolled_all_means' logic)
    `Enrolled_Enrolled_Mean_0` = sum(round == 0 & enrolled == 0, na.rm = TRUE), # Not Enrolled (Treat and Control)
    `Enrolled_Enrolled_Mean_1` = sum(round == 0 & enrolled == 1 & treatment_neighborhood == 1, na.rm = TRUE) # Enrolled Treatment
  ) %>%
  mutate(across(where(is.numeric), ~ round(.x, 0)))

# Combine tables
final_table_with_N <- final_table %>%
  bind_rows(N_row) # Add the N_row to the end of the final_table

# # Now, format the final_table_with_N using kable and kableExtra
# final_table_with_N %>%
#   kable(
#     format = "html",
#     booktabs = TRUE,
#     caption = "<center><span style='font-size:20px; color: black; font-weight: bold;'>Mean Baseline Characteristics</span></center>",
#     col.names = c(
#       "Variable", 
#       "Control",
#       "Treatment",
#       "Enrolled\nBefore",
#       "Enrolled\nAfter",
#       "Eligible\nControl",
#       "Eligible\nTreatment", 
#       "Not Enrolled\nTreatment", 
#       "Enrolled\nTreatment",
#       "Not Enrolled (Treat and Control)", 
#       "Enrolled\nTreatment"
#     ),
#     align = c("l", "c", "c", "c", "c", "c", "c", "c", "c", "c", "c"),
#     escape = FALSE
#   ) %>%
#   kable_styling(
#     full_width = FALSE,
#     bootstrap_options = c("striped", "hover", "condensed"),
#     position = "left"
#   ) %>%
#   add_header_above(
#     header = c(
#       " " = 1,
#       "Overall Means" = 2,
#       "Before-After Means" = 2,
#       "Eligible Units Means (RCT)" = 2,
#       "Treatment Units Means (With-Without, RDD, DID)" = 2,
#       "Overall Enrolled Means (PSM)" = 2
#     ),
#     bold = TRUE,
#     font_size = 12,
#     escape = FALSE
#   ) %>%
#   row_spec(nrow(final_table_with_N), bold = TRUE, background = "#F0F0F0") %>% # Bold and lightly shade the N row
#   scroll_box(width = "100%", height = "400px")


# Without Overall Means
# With Actually Enrolled (enrolled_rp)
# Join the tables together
final_table_IV <- before_after_means %>%
  left_join(eligible_means, by="Variable") %>%
  left_join(eligible_enrolled_means, by = "Variable") %>%
  left_join(enrolled_means, by = "Variable") %>%
  left_join(enrolled_all_means, by = "Variable")

# Combine tables
final_table_IV_with_N <- final_table_IV %>%
  bind_rows(N_row) # Add the N_row to the end of the final_table

# Drop Mean_0 and Mean_1
final_table_IV_with_N <- subset(final_table_IV_with_N, select=-c(Mean_0, Mean_1))

# Now, format the final_table_with_N using kable and kableExtra
means_table <- final_table_IV_with_N %>%
  kable(
    format = "html",
    booktabs = TRUE,
    caption = "<center><span style='font-size:20px; color: black; font-weight: bold;'>Table 1: Mean Baseline Characteristics</span></center>",
    col.names = c(
      "Variable",
      "Offered Treat\nBefore",
      "Offered Treat\nAfter",
      "Eligible\nControl",
      "Eligible\nTreatment", 
      "Eligible\nNot Enrolled",
      "Eligible\nEnrolled", 
      "Not Offered\nTreatment", 
      "Offered\nTreatment",
      "Not Offered (Treat and Control)", 
      "Offered\nTreatment"
    ),
    align = c("l", "c", "c", "c", "c", "c", "c", "c", "c", "c", "c"),
    escape = FALSE
  ) %>%
  kable_styling(
    full_width = FALSE,
    bootstrap_options = c("striped", "hover", "condensed"),
    position = "left"
  ) %>%
  add_header_above(
    header = c(
      " " = 1,
      "Before-After Means" = 2,
      "Eligible Units Means (RCT)" = 2,
      "Eligible Enrollment Units Means (IV)" = 2,
      "Treatment Offered Units Means (With-Without, RDD, DID)" = 2,
      "Overall Offered Means (PSM)" = 2
    ),
    bold = TRUE,
    font_size = 12,
    escape = FALSE
  ) %>%
  row_spec(nrow(final_table_IV_with_N), bold = TRUE, background = "#F0F0F0") 
# %>% # Bold and lightly shade the N row
#   scroll_box(width = "100%", height = "400px")

means_table 

# Save the table as a PNG image
library(webshot2) 
library(magick)
save_kable(means_table, file = "./means_table.png")

# # Use webshot2 to convert the HTML file to PNG (or PDF)
# save_kable(means_table, file = "./means_table.html")
# webshot2::webshot("./means_table.html", "./means_table.png")


## Create a version for word
# install.packages(c("flextable","officer"))
library(flextable)
library(officer)

df <- final_table_IV_with_N

# bottom header row (column labels)
labels <- c(
  "Variable",
  "Offered Treat\nBefore", "Offered Treat\nAfter",
  "Eligible\nControl", "Eligible\nTreatment",
  "Eligible\nNot Enrolled", "Eligible\nEnrolled",
  "Not Offered\nTreatment", "Offered\nTreatment",
  "Not Offered (Treat and Control)", "Offered\nTreatment"
)

# top header row (spanners)
groups <- c(
  "",                                   # over the first column only
  "Before-After Means", "Before-After Means",
  "Eligible Units Means (RCT)", "Eligible Units Means (RCT)",
  "Eligible Enrollment Units Means (IV)", "Eligible Enrollment Units Means (IV)",
  "Treatment Offered Units Means (With-Without, RDD, DID)", "Treatment Offered Units Means (With-Without, RDD, DID)",
  "Overall Offered Means (PSM)", "Overall Offered Means (PSM)"
)

head_map <- data.frame(
  col_keys = names(df),
  group    = groups,
  label    = labels,
  stringsAsFactors = FALSE
)

ft <- flextable(df)
ft <- set_header_df(ft, mapping = head_map, key = "col_keys")  # builds BOTH rows
ft <- merge_h(ft, part = "header")
ft <- align(ft, part = "header", j = 1:ncol(df), align = "center")
ft <- align(ft, part = "header", j = 1, align = "left")        # "Variable" left

# styling (like your kable)
ft <- theme_booktabs(ft)
ft <- bg(ft, i = seq_len(nrow(df)) %% 2 == 0, bg = "#F7F7F7", part = "body")
ft <- align(ft, j = 1, align = "left", part = "body")
ft <- align(ft, j = 2:ncol(df), align = "center", part = "body")
ft <- fontsize(ft, part = "all", size = 10)
ft <- padding(ft, part = "all", padding = 1)
ft <- autofit(ft); ft <- fit_to_width(ft, max_width = 6.8)
ft <- width(ft, j = 1, width = 2.7)
ft <- bold(ft, i = nrow(df), part = "body"); ft <- bg(ft, i = nrow(df), bg = "#F0F0F0")

# Write to Word
doc <- read_docx()
doc <- body_add_flextable(doc, ft)
print(doc, target = "C:/Users/FionaKastel/OneDrive - 3ie/Documents/GitHub/R-course/sessions_in_Abu_Dhabi/case_study_outputs/mean_baseline_stats.docx")

