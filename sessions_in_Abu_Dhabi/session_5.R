## ----echo=FALSE, fig.cap="Impact = Actual - Counterfactual", fig.height= 12----
library(broom)
library(estimatr)
library(fishmethods)
library(haven)
library(kableExtra)
library(modelsummary)
library(tidyverse)

# Create example data

data <- data.frame(
  Time = c(0, 1, 0, 1),
  Outcome = c(14.5, 7.8, 14.5, 18),
  Group = c("Treatment", "Treatment", "Counterfactual", "Counterfactual")
)

# Create plot
ggplot(data, aes(x = Time, y = Outcome, color = Group, group = Group)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  annotate("segment", x = 1, xend = 1, y = 7.8, yend = 18, 
           arrow = arrow(length = unit(0.3, "cm")), linetype = "dashed") +
  annotate("text", x = 1.05, y = 13, label = "Impact", hjust = 0) +
  scale_x_continuous(breaks = c(0, 1), labels = c("Before", "After")) +
  labs(title = "Visualizing Impact", y = "Outcome", x = "") +
  theme_minimal()


## ----echo=TRUE---------------------------------------------------------------
# Let's start by uploading our data.
# It is important to know in which folder your dataset is so you can use the right path.

df <- read.csv("./evaluation_data.csv")

# We multiply the outcome variable by 1,000

df$waste_management_costs<-df$waste_management_costs*1000


df_w <- df %>%
  # Create wide format
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
  # remove the industries that have missing values
  filter(!is.na(waste_management_costs_0))
# Check the first few rows to confirm format
head(select(df_w, facility_identifier, enrolled, 
            waste_management_costs_0, waste_management_costs_1))


## ----eval=T, echo=TRUE-------------------------------------------------------
# Compare waste management costs before and after for enrolled industries
m_ba1 <- lm_robust(waste_management_costs   ~ round, 
                  clusters = zone_identifier,
                  data = df %>% dplyr::filter(treatment_zone ==1 & enrolled ==1))



## ----eval=T, echo=TRUE-------------------------------------------------------
# Compare enrolled vs. non-enrolled households after program implementation
m_ba2 <- lm_robust(waste_management_costs ~ enrolled, 
                  clusters = zone_identifier,
                  data = df %>% filter(treatment_zone==1 & round ==1))



## ----------------------------------------------------------------------------

modelsummary(list(m_ba1, m_ba2), stars = TRUE,
             gof_map = c("nobs", "r.squared","r2.adjusted"))



