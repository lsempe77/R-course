## ----echo=FALSE, fig.height=4------------------------------------------------

# Load required packages
library(tidyverse)
library(MatchIt)
library(estimatr)
library(kableExtra)
library(modelsummary)

# Set rendering options
knitr::opts_chunk$set(
  warning = FALSE,
  message = FALSE,
  echo = TRUE,
  fig.width = 10, 
  fig.height = 6
)

set.seed(123)

df <- read.csv("./evaluation_data.csv")
df$waste_management_costs<-df$waste_management_costs*1000

# Create simulated data for matching visualization
set.seed(123)
n <- 200

# Create two variables that predict both treatment and outcome
x1 <- runif(n, -2, 2)
x2 <- runif(n, -2, 2)

# Generate treatment with higher probability for larger x1, x2
p_treat <- plogis(0.5 + 0.7*x1 + 0.7*x2)
treatment <- rbinom(n, 1, p_treat)

# Create data frame
matching_data <- data.frame(
  x1 = x1,
  x2 = x2,
  treatment = factor(treatment, labels = c("Control", "Treatment"))
)

# Plot
ggplot(matching_data, aes(x = x1, y = x2, color = treatment, shape = treatment)) +
  geom_point(size = 2) +
  labs(title = "Before Matching: Imbalanced Groups",
       x = "Variable X1",
       y = "Variable X2",
       color = "Group",
       shape = "Group") +
  theme_minimal() +
  theme(legend.position = "bottom")


## ----------------------------------------------------------------------------
# Create a wide-format dataset
df_w <- df %>%
  # Then create wide format
  pivot_wider(
    id_cols = c(zone_identifier, facility_identifier, treatment_zone, 
                promotion_zone, eligible, enrolled, enrolled_rp),
    names_from = round, # variable that determines new columns
    # variables that should be made "wide"
    values_from = c(waste_management_costs, 
                    efficiency_index, age_manager, age_deputy,
                    educ_manager, educ_deputy, female_manager,
                    foreign_owned, staff_size, advanced_filtration,
                    water_treatment_system, facility_area,
                    recycling_center_distance, recycling_compliance)) %>%
  # remove the industries that has missing values
  # as missing values are not allowed when using matchit
  filter(!is.na(waste_management_costs_0)) 

# Also check the first few rows to confirm format
head(select(df_w, facility_identifier, enrolled, 
           waste_management_costs_0, waste_management_costs_1))


## ----------------------------------------------------------------------------
# Limited set of variables
psm_r <- matchit(enrolled ~ age_manager_0 + educ_manager_0,
                 data = df_w %>% dplyr::select(-recycling_compliance_0,
                                               -recycling_compliance_1), 
                    distance = "glm",
                  link = "probit")

# Full set of variables
psm_ur <- matchit(enrolled ~ age_manager_0 + educ_manager_0 + 
                   age_deputy_0 + educ_deputy_0 +
                   female_manager_0 + foreign_owned_0 + staff_size_0 + 
                   advanced_filtration_0 + water_treatment_system_0 + 
                   facility_area_0 + recycling_center_distance_0,
   data = df_w %>% dplyr::select(-recycling_compliance_0,
                                               -recycling_compliance_1), 
   distance = "glm",link = "probit")


## ----------------------------------------------------------------------------
# Create a model summary table
modelsummary(list("Limited Set" = psm_r$model, 
                  "Full Set" = psm_ur$model),
             coef_map = c('age_manager_0' = "Age (Manager) at Baseline",
                          'educ_manager_0' = "Education (Manager) at Baseline",
                          'age_deputy_0' = "Age (Deputy) at Baseline",
                          'educ_deputy_0' = "Education (Deputy) at Baseline",
                          'female_manager_0' = "Female Manager at Baseline",
                          'foreign_owned_0' = "Foreign Owned at Baseline",
                          'staff_size_0' = "Number of Staff at Baseline",
                          'advanced_filtration_0' = "Advanced Filtration at Baseline",
                          'water_treatment_system_0' = "Water Treatment System at Baseline",
                          'facility_area_0' = "Facility Area at Baseline",
                          'recycling_center_distance_0' = "Distance From Recycling Center"),
             title = "Estimating the Propensity Score Based on Baseline Characteristics")


## ----------------------------------------------------------------------------
# Add propensity scores to our dataset
df_w <- df_w %>%
  mutate(ps_ur = psm_ur$model$fitted.values)

# Plot the distribution
df_w %>%
  mutate(enrolled_lab = ifelse(enrolled == 1, "Enrolled", "Not Enrolled")) %>%
  ggplot(aes(x = ps_ur,
             group = enrolled_lab, colour = enrolled_lab, fill = enrolled_lab)) +
  geom_density(alpha = 0.2) +
  xlab("Propensity Score") +
  labs(title = "Distribution of Propensity Score by Enrollment Status") +
  scale_fill_viridis_d("Status:", end = 0.7) +
  scale_colour_viridis_d("Status:", end = 0.7) +
  theme_minimal() +
  theme(legend.position = "bottom")


## ----------------------------------------------------------------------------
kableExtra::kable(summary(psm_ur)$sum.all,
      caption = "Balance Before Matching") %>%
  kable_styling(font_size = 10)


## ----------------------------------------------------------------------------
kableExtra::kable(summary(psm_ur)$sum.matched,
      caption = "Balance After Matching") %>%
  kable_styling(font_size = 10)


## ----------------------------------------------------------------------------
# Extract matched datasets
match_df_r <- match.data(psm_r)   # Limited set
match_df_ur <- match.data(psm_ur) # Full set


## ----------------------------------------------------------------------------
# Regression with matched data
out_lm_r <- lm_robust(waste_management_costs_1 ~ enrolled,
                      data = match_df_r,  weights = weights,
                      clusters = zone_identifier)

out_lm_ur <- lm_robust(waste_management_costs_1 ~ enrolled,
                      data = match_df_ur, weights = weights,
                      clusters = zone_identifier)

# Show results
modelsummary(list("Limited Set" = out_lm_r, 
                  "Full Set" = out_lm_ur),
             title = "Impact on Waste Management Costs: Matching Approach")


## ----------------------------------------------------------------------------
# Merge matching weights back into long format
df_long_match_r <- df %>%
  left_join(match_df_r %>% dplyr::select(facility_identifier, weights)) %>%
  filter(!is.na(weights))

df_long_match_ur <- df %>%
  left_join(match_df_ur %>% dplyr::select(facility_identifier, weights)) %>%
  filter(!is.na(weights))


## ----------------------------------------------------------------------------
# Run DiD regression
did_reg_r <- lm_robust(waste_management_costs ~ enrolled * round,
                        data = df_long_match_r, weights = weights,
                        clusters = zone_identifier)

did_reg_ur <- lm_robust(waste_management_costs ~ enrolled * round,
                        data = df_long_match_ur, weights = weights,
                        clusters = zone_identifier)

# Show results
modelsummary(list("Limited Set" = did_reg_r, 
                  "Full Set" = did_reg_ur),
             coef_map = c('enrolled' = "Enrollment",
                          'round' = "Round",
                          'enrolled:round' = "Enrollment × Round"),
             title = "Impact on Waste Management Costs: Matched DiD Approach")

