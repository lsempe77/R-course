## ----echo=FALSE, fig.height=12-----------------------------------------------
library(broom)
library(estimatr)
library(fishmethods)
library(haven)
library(kableExtra)
library(modelsummary)
library(tidyverse)

set.seed(123)

# Create data
n <- 100
data <- data.frame(
  id = 1:n,
  potential_outcome = rnorm(n, mean = 50, sd = 10)
)

# Randomly assign treatment
data$treatment <- sample(c(0, 1), n, replace = TRUE)

# Add some treatment effect
data$actual_outcome <- data$potential_outcome + data$treatment * 10 + rnorm(n, 0, 2)

# Plot
ggplot(data, aes(x = treatment, y = actual_outcome, group = treatment)) +
  geom_jitter(width = 0.1, alpha = 0.5) +
  stat_summary(fun = mean, geom = "point", size = 4, color = "red") +
  stat_summary(fun = mean, geom = "line", aes(group = 1), color = "red") +
  labs(title = "Treatment Effect with Random Assignment",
       x = "Treatment Status",
       y = "Outcome") +
  scale_x_continuous(breaks = c(0, 1), labels = c("Control", "Treatment")) +
  theme_minimal()


## ----echo=F------------------------------------------------------------------
df <- read.csv("./evaluation_data.csv")
df$waste_management_costs<-df$waste_management_costs*1000


## ----eval=T, echo=F----------------------------------------------------------
# Check if treatment and control industries are balanced at baseline

m<-df %>%
  filter(round == 0) %>%
  select(treatment_zone, age_manager, age_deputy, educ_manager, educ_deputy, 
         female_manager, foreign_owned, staff_size, advanced_filtration, water_treatment_system, 
         facility_area, recycling_center_distance) %>%
  pivot_longer(-c("treatment_zone")) %>%
  group_by(name) %>%
  do(tidy(lm_robust(value ~ treatment_zone, data = .))) %>%
  filter(term == "treatment_zone") %>%
  select(name, estimate, std.error, p.value) %>%
  mutate(across(c(estimate, std.error, p.value), ~ round(.x,2)))  #



## ----------------------------------------------------------------------------

kable(m) %>% scroll_box(width = "600px", height = "400px")



## ----eval=F, echo=TRUE-------------------------------------------------------
#| class: small-code
## # Check if treatment and control industries are balanced at baseline
## 
## df %>%
##   filter(round == 0) %>%
##   select(treatment_zone, age_manager, age_deputy,
##          educ_manager, educ_deputy,
##          female_manager, foreign_owned, staff_size,
##          advanced_filtration, water_treatment_system,
##          facility_area, recycling_center_distance) %>%
##   pivot_longer(-c("treatment_zone")) %>%
##   group_by(name) %>%
##   do(tidy(lm_robust(value ~ treatment_zone, data = .))) %>%
##   filter(term == "treatment_zone") %>%
##   select(name, estimate, std.error, p.value)


## ----eval=T, echo=TRUE-------------------------------------------------------
#| class: small-code

# Compare waste expenditures in treatment and control industries at follow-up
out_round0 <- lm_robust(waste_management_costs ~ treatment_zone,
                        data = df %>% filter(round == 0 & eligible ==1),
                        clusters = zone_identifier)

out_round1 <- lm_robust(waste_management_costs ~ treatment_zone,
                        data = df %>% filter(round == 1 & eligible ==1),
                        clusters = zone_identifier)


## ----------------------------------------------------------------------------

modelsummary(list("Round 0"= out_round0, "Round 1"=out_round1), stars = TRUE,
             gof_map = c("nobs", "r.squared","adj.r.squared"), output = 'kableExtra') 


## ----eval=T, echo=TRUE-------------------------------------------------------
#| class: small-code

# Compare waste expenditures in T and C industries at follow-up
out_round2 <- lm_robust(waste_management_costs ~ treatment_zone +
                    age_manager + age_deputy +
                    female_manager + foreign_owned + 
                    staff_size +
                    advanced_filtration + facility_area +
                    recycling_center_distance,
                    data = df %>% filter(round == 1 & eligible ==1),
                    clusters = zone_identifier)


## ----------------------------------------------------------------------------
#| class: small-code

modelsummary(list("No covariate adj."= out_round1,
                  "With covariate adj."=out_round2), stars = TRUE,
             gof_map = c("nobs", "r.squared","adj.r.squared"),output = 'kableExtra') %>%
  kable_styling (font_size = 13) %>% scroll_box(width = "600px", height = "300px")



## ----eval = F, echo=T--------------------------------------------------------
#| class: small-code

## df %>% group_by(enrolled, round) %>%
##   mutate(enrolled = recode(as.factor(enrolled), `0` = "Control", `1` = "Treatment"),
##              round = recode(as.factor(round), `0` = "Before", `1` = "After")) %>%
##   summarise(waste_management_costs = mean(waste_management_costs)) %>%
##   ggplot(aes(x = round, y = waste_management_costs, group = enrolled, color = enrolled)) +
##   geom_line(size = 1.2) + geom_point(size = 3) +
##   labs(title = "Program Impact on Waste Expenditures", x = "Round",
##        y = "Waste Expenditures (USD)") +
##   theme_minimal() +  theme(legend.position = "bottom")
## 


## ----echo=F, fig.height=7----------------------------------------------------
#| class: small-code

df %>% group_by(enrolled, round) %>% 
  mutate(enrolled = recode(as.factor(enrolled), `0` = "Control", `1` = "Treatment"),
             round = recode(as.factor(round), `0` = "Before", `1` = "After")) %>%
  summarise(waste_management_costs = mean(waste_management_costs)) %>%
  ggplot(aes(x = round, y = waste_management_costs, group = enrolled, color = enrolled)) +
  geom_line(size = 1.2) + geom_point(size = 3) +
  labs(title = "Program Impact on Waste Expenditures", x = "Round",
       y = "Waste Expenditures (USD)") +
  theme_minimal() +  theme(legend.position = "bottom")


