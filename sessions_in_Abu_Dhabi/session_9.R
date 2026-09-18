## ----echo=FALSE, fig.height=4------------------------------------------------
library(tidyverse)
library(estimatr)
library(kableExtra)
library(modelsummary)

set.seed(123)

df <- read.csv("./evaluation_data.csv")
df$waste_management_costs<-df$waste_management_costs*1000

# Create data for DiD visualization
set.seed(123)
time_points <- c(0, 1)
treatment_group <- c(40, 30)
control_group <- c(50, 50)

# Create data frame
did_data <- data.frame(
  Time = rep(time_points, 2),
  Group = rep(c("Treatment", "Control"), each = 2),
  Outcome = c(treatment_group, control_group)
)

# Plot DiD
ggplot(did_data, aes(x = Time, y = Outcome, color = Group, group = Group)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  scale_x_continuous(breaks = c(0, 1), labels = c("Before", "After")) +
  annotate("segment", x = 1, xend = 1, y = 30, yend = 50, 
           arrow = arrow(ends = "both", length = unit(0.1, "inches")), 
           linetype = "dashed") +
  annotate("text", x = 1.05, y = 40, label = "Treatment\nEffect") +
  labs(title = "Difference-in-Differences",
       y = "Outcome") +
  theme_minimal() +
  theme(legend.position = "bottom")


## ----echo=FALSE--------------------------------------------------------------
library(knitr)

# Create DiD table
did_table <- data.frame(
  Group = c("Treatment", "Control", "Difference"),
  Before = c(40, 50, -10),
  After = c(30, 50, -20),
  Difference = c(-10, 0, -10)
)

kable(did_table, align = "lccc", caption = "DiD Calculation Example")


## ----eval=T, echo=TRUE-------------------------------------------------------
# DiD regression without covariates
out_did <- lm_robust(waste_management_costs ~ round * enrolled, 
                    data = df %>% filter(treatment_zone == 1),
                    clusters = zone_identifier)

# DiD regression with covariates
out_did_wcov <- lm_robust(waste_management_costs ~ round * enrolled +
                         age_manager + age_deputy +
                  female_manager + foreign_owned + 
                  staff_size +
                  advanced_filtration + facility_area +
                  recycling_center_distance, 
                       data = df %>% filter(treatment_zone == 1),
                       clusters = zone_identifier)


## ----echo=FALSE--------------------------------------------------------------
library(knitr)

# Create coefficient interpretation table
coef_table <- data.frame(
  Period = c("Before (Round=0)", "After (Round=1)", "Difference"),
  Not_Enrolled = c("β₀", "β₀ + β₁", "β₁"),
  Enrolled = c("β₀ + β₂", "β₀ + β₁ + β₂ + β₃", "β₁ + β₃"),
  Difference = c("β₂", "β₂ + β₃", "β₃")
)

kable(coef_table, 
      col.names = c("Period", "Not Enrolled", "Enrolled", "Difference"),
      caption = "Interpretation of DiD Coefficients")


## ----echo=FALSE--------------------------------------------------------------
library(knitr)

modelsummary(list("No covariate adj."= out_did, "With covariate adj." = out_did_wcov), stars = TRUE,
             gof_map = c("nobs", "r.squared","adj.r.squared"), output = 'kableExtra') %>%
  kable_styling(font_size = 13) 



## ----echo=FALSE, fig.height=6.5----------------------------------------------
# Extract values from model coefficients
beta0 <- out_did$coefficients["(Intercept)"]
beta1 <- out_did$coefficients["round"]
beta2 <- out_did$coefficients["enrolled"]
beta3 <- out_did$coefficients["round:enrolled"]

# Calculate cell values based on DiD model
not_enrolled_before <- beta0
not_enrolled_after <- beta0 + beta1
enrolled_before <- beta0 + beta2
enrolled_after <- beta0 + beta1 + beta2 + beta3

# Create data for DiD visualization
time_points <- c("Baseline", "Follow-up")
enrolled <- c(enrolled_before/1000, enrolled_after/1000)  # Converting to thousands
not_enrolled <- c(not_enrolled_before/1000, not_enrolled_after/1000)  # Converting to thousands

# Create data frame
did_viz_data <- data.frame(
  Time = rep(time_points, 2),
  Group = rep(c("Enrolled", "Not Enrolled"), each = 2),
  Expenditure = c(enrolled, not_enrolled)
)

# Calculate differences for annotations
diff_after <- not_enrolled_after/1000 - enrolled_after/1000
diff_before <- not_enrolled_before/1000 - enrolled_before/1000
diff_in_diff <- diff_after - diff_before

# Plot DiD
ggplot(did_viz_data, aes(x = Time, y = Expenditure, color = Group, group = Group)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  annotate("segment", x = 2, xend = 2, y = enrolled_after/1000, yend = not_enrolled_after/1000, 
           arrow = arrow(ends = "both", length = unit(0.1, "inches")), 
           linetype = "dashed") +
  annotate("text", x = 2.1, y = (enrolled_after/1000 + not_enrolled_after/1000)/2, 
           label = sprintf("%.2f", diff_after)) +
  annotate("segment", x = 1, xend = 1, y = enrolled_before/1000, yend = not_enrolled_before/1000, 
           arrow = arrow(ends = "both", length = unit(0.1, "inches")), 
           linetype = "dashed") +
  annotate("text", x = 1.1, y = (enrolled_before/1000 + not_enrolled_before/1000)/2, 
           label = sprintf("%.2f", diff_before)) +
  annotate("text", x = 1.5, y = min(enrolled, not_enrolled) - .2, 
           label = sprintf("Difference-in-Differences:\n%.2f - %.2f = %.2f", 
                          diff_after, diff_before, diff_in_diff), 
           fontface = "bold") +
  labs(title = "", x = "",
       y = "Waste Expenditures (thousands USD)") +
  theme_minimal() +
  theme(legend.position = "bottom")


## ----echo=FALSE, fig.height=4------------------------------------------------
library(ggplot2)

# Create data for parallel trends visualization
periods <- seq(1, 5)
treated_actual <- c(40, 40, 40, 30, 25)
treated_counterfactual <- c(40, 40, 40, 40, 40)
control <- c(50, 50, 50, 50, 50)

# Create data frame
trends_data <- data.frame(
  Period = rep(periods, 3),
  Group = c(rep("Treated (Actual)", 5), rep("Treated (Counterfactual)", 5), rep("Control", 5)),
  Value = c(treated_actual, treated_counterfactual, control)
)

# Plot parallel trends
ggplot(trends_data, aes(x = Period, y = Value, color = Group, linetype = Group)) +
  geom_line(size = 1) +
  geom_vline(xintercept = 3.5, linetype = "dashed") +
  annotate("text", x = 3.5, y = 55, label = "Treatment", hjust = -0.2) +
  annotate("rect", xmin = 3.5, xmax = 5, ymin = 25, ymax = 40, alpha = 0.1, fill = "blue") +
  annotate("text", x = 4.2, y = 35, label = "Treatment\nEffect", color = "blue") +
  scale_linetype_manual(values = c("Treated (Actual)" = "solid", 
                                   "Treated (Counterfactual)" = "dotted", 
                                   "Control" = "solid")) +
  labs(title = "Parallel Trends Assumption",
       y = "Outcome") +
  theme_minimal() +
  theme(legend.position = "bottom")


## ----eval=T, echo=TRUE-------------------------------------------------------
#| class: small-code

# Create simple dataset with 20 observations
did_data <- data.frame(
  # 4 time periods (0-3), treatment in period 2
  time = rep(0:3, 5),
  # 10 units (5 treated, 5 control)
  unit = rep(1:10, each = 4),
  # Treatment indicator
  treated = rep(c(rep(0, 5), rep(1, 5)), each = 4),
  # Period indicator (pre/post)
  post = rep(c(0,0,1,1), 10)
)

# Base outcome - parallel trends
did_data$y_parallel <- 10 + 2*did_data$time + 3*did_data$treated + 
                      5*(did_data$post*did_data$treated) + rnorm(40, 0, 1)

# Non-parallel trends
did_data$y_nonparallel <- did_data$y_parallel + 
                         2*did_data$time*did_data$treated





## ----------------------------------------------------------------------------
# Quick visual check of parallel trends
ggplot(did_data, aes(x = time, y = y_parallel, color = factor(treated), group = factor(treated))) +
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun = mean, geom = "point", size = 3) +
  geom_vline(xintercept = 1.5, linetype = "dashed") +
  labs(title = "Parallel Trends Example", x = "Time", y = "Outcome", color = "Treated") +
  theme_minimal()


## ----eval=FALSE, echo=TRUE---------------------------------------------------
## # Basic DiD implementation
## 
## # Step 1: Basic DiD regression
## did_model <- lm(
##   outcome ~ treatment*post + controls,
##   data = data
## )
## 
## # Step 2: With fixed effects
## library(fixest)
## did_fe <- feols(
##   outcome ~ treatment*post | unit + time,
##   data = data,
##   cluster = "group_id"
## )
## 
## # Step 3: Staggered adoption with modern methods
## library(did)
## staggered_did <- att_gt(
##   yname = "outcome",
##   tname = "time",
##   idname = "id",
##   gname = "first_treated",
##   data = data
## )

