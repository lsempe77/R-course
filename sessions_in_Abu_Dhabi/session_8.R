## ----echo=FALSE, fig.height=4.5----------------------------------------------
library(tidyverse)
library(estimatr)
library(kableExtra)
library(modelsummary)

set.seed(123)

df <- read.csv("./evaluation_data.csv")
df$waste_management_costs<-df$waste_management_costs*1000
# Create data subset with only treatment localities
df_treat <- df %>%
  filter(treatment_zone == 1)

# Create simulated RDD data
n <- 200
cutoff <- 0
data <- data.frame(
  running_var = runif(n, -5, 5),
  noise = rnorm(n, 0, 0.5)
)

# Generate outcome with discontinuity at cutoff
data$outcome <- 0.2 * data$running_var + 
                ifelse(data$running_var >= cutoff, -1.5, 0) + 
                data$noise

# Create RDD plot
ggplot(data, aes(x = running_var, y = outcome)) +
  geom_point(alpha = 0.5) +
  geom_vline(xintercept = cutoff, linetype = "dashed") +
  geom_smooth(data = subset(data, running_var < cutoff), 
              method = "lm", color = "blue") +
  geom_smooth(data = subset(data, running_var >= cutoff), 
              method = "lm", color = "red") +
  annotate("text", x = -2.5, y = 0, label = "Control Group") +
  annotate("text", x = 2.5, y = -1.5, label = "Treatment Group") +
  labs(title = "Regression Discontinuity Design",
       x = "Running Variable",
       y = "Outcome") +
  theme_minimal()


## ----eval=T, echo=TRUE-------------------------------------------------------
# Plot density of efficiency index
ggplot(df_treat, aes(x = efficiency_index )) +
  geom_vline(xintercept = 58) +
  geom_density() +
  labs(x = "Efficiency Index") + theme_minimal()



## ----echo=FALSE, fig.height=4------------------------------------------------

# Formal test for manipulation
library(rddensity)

test_density <- rdplotdensity(rdd = rddensity(df_treat$efficiency_index, c = 58), 
                              X = df_treat$efficiency_index, 
                              type = "both")



## ----eval=T, echo=TRUE-------------------------------------------------------
# Check if eligibility rules were followed
ggplot(df_treat, aes(y = enrolled, x = efficiency_index)) +
  geom_vline(xintercept = 58) +
  geom_point() +
  labs(title = "Enrollment by Efficiency Index (Sharp RDD)",
       x = "Efficiency Index",
       y = "Enrolled (1 = Yes, 0 = No)") +
  scale_y_continuous(breaks = c(0, 1)) +
  theme_minimal()


## ----eval=T, echo=T----------------------------------------------------------
# Plot relationship between efficiency index and health expenditures
df_treat %>%
  filter(round == 1) %>%
  mutate(enrolled_lab = ifelse(enrolled == 1, "Enrolled", "Not Enrolled")) %>%
  ggplot(aes(x = efficiency_index, y = waste_management_costs,
             group = enrolled_lab, colour = enrolled_lab)) +
  geom_point(alpha = 0.03) +
  geom_smooth(method = "lm") +
  geom_vline(xintercept = 58) +
  labs(x = "Efficiency Index", y = "Waste Expenditures") + theme_minimal()


## ----eval=T, echo=TRUE-------------------------------------------------------
#| class: small-code

# Prepare data by centering the running variable
df_treat <- df_treat %>%
  mutate(efficiency_index_c0 = efficiency_index - 58)

# Basic RDD regression with covariates
out_rdd <- lm_robust(waste_management_costs ~ 
                  efficiency_index_c0 * enrolled +
                  age_manager + age_deputy +
                  female_manager + foreign_owned + 
                  staff_size +
                  advanced_filtration + facility_area +
                  recycling_center_distance,
                  data = df_treat %>% filter(round == 1))


## ----------------------------------------------------------------------------

modelsummary(list("Sharp RDD"= out_rdd), stars = TRUE,coef_omit = c(-3),
             gof_map = c("nobs", "r.squared","adj.r.squared"),output = 'kableExtra') %>%
  kable_styling (font_size = 15) 



## ----eval=T, echo=TRUE-------------------------------------------------------
#| class: small-code

out_rdd_quadratic  <- lm_robust(waste_management_costs ~ 
                  efficiency_index_c0 * enrolled +
                    enrolled * I(efficiency_index_c0^2) +
                  age_manager + age_deputy +
                  female_manager + foreign_owned + 
                  staff_size +
                  advanced_filtration + facility_area +
                  recycling_center_distance,
                  data = df_treat %>% filter(round == 1))

out_rdd_cubic  <- lm_robust(waste_management_costs ~ 
                  efficiency_index_c0 * enrolled +
                    enrolled * I(efficiency_index_c0^2) + 
                        enrolled * I(efficiency_index_c0^3) +
                  age_manager + age_deputy +
                  female_manager + foreign_owned + 
                  staff_size +
                  advanced_filtration + facility_area +
                  recycling_center_distance,
                  data = df_treat %>% filter(round == 1))


## ----------------------------------------------------------------------------

modelsummary(coef_omit = c(-3),
             list("Quadratic RDD"= out_rdd_quadratic,"Cubic RDD" = out_rdd_cubic), stars = TRUE,
             gof_map = c("nobs", "r.squared","adj.r.squared"), output = 'kableExtra') %>%
  kable_styling (font_size = 15)



## ----eval=T, echo=TRUE-------------------------------------------------------
# Restrict to observations near cutoff
out_rdd5 <- lm_robust(
  waste_management_costs ~ 
    enrolled * efficiency_index_c0 +
          age_manager + age_deputy +
           female_manager + foreign_owned + 
           staff_size +
                  advanced_filtration + facility_area +
                  recycling_center_distance,
  data = df_treat %>% 
    filter(round == 1 & 
           abs(efficiency_index_c0) <= 53))



## ----------------------------------------------------------------------------

modelsummary(coef_omit = c(-2),
             out_rdd5, stars = TRUE,
             gof_map = c("nobs", "r.squared","adj.r.squared"), output = 'kableExtra') %>%
  kable_styling (font_size = 15)



## ----echo=FALSE, fig.height=4------------------------------------------------
library(ggplot2)

# Create data for local effect illustration
x_range <- seq(40, 80, by = 0.1)
cutoff <- 58

# Generate treatment effects that vary with efficiency index
effects <- data.frame(
  efficiency_index = x_range,
  effect_size = -15 + 0.1 * (x_range - 40)
)

# Plot varying treatment effects
ggplot(effects, aes(x = efficiency_index, y = effect_size)) +
  geom_line(size = 1, color = "blue") +
  geom_vline(xintercept = cutoff, linetype = "dashed", color = "red") +
  geom_hline(yintercept = -9, linetype = "dotted") +
  annotate("text", x = 70, y = -9, label = "RDD Estimate", hjust = 0) +
  annotate("segment", x = cutoff, xend = cutoff, y = -15, yend = -9, 
           arrow = arrow(length = unit(0.3, "cm")), color = "red") +
  annotate("text", x = cutoff + 0.5, y = -12, label = "Local Effect", hjust = 0) +
  labs(title = "Treatment Effects May Vary with efficiency Index",
       x = "efficiency Index",
       y = "Treatment Effect on Health Expenditures") +
  ylim(-15, -5) +
  theme_minimal()


## ----eval=FALSE, echo=TRUE---------------------------------------------------
## # Basic steps for RDD analysis
## 
## # Step 1: Check for manipulation
## library(rddensity)
## rdd_test <- rddensity(data$running_var, c = cutoff)
## rdplotdensity(rdd_test, data$running_var)
## 
## # Step 2: Center the running variable
## data$centered_var <- data$running_var - cutoff
## 
## # Step 3: Estimate RDD effect (parametric)
## model <- lm_robust(
##   outcome ~ centered_var * treatment + controls,
##   data = data
## )
## 
## # Step 4: Non-parametric approach
## library(rdrobust)
## rd_robust <- rdrobust(
##   y = data$outcome,
##   x = data$running_var,
##   c = cutoff
## )

