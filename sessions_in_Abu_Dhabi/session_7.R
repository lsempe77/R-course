## ----echo=FALSE--------------------------------------------------------------
library(ggplot2)
library(dplyr)
library(modelsummary)
library(estimatr)
library(kableExtra)

getwd()

## ----echo=F------------------------------------------------------------------
df <- read.csv("evaluation_data.csv")
df$waste_management_costs<-df$waste_management_costs*1000


## ----eval=T, echo=TRUE-------------------------------------------------------
# Estimate effect of promotion on enrollment (First Stage)
m_first_stage <- lm_robust(enrolled_rp ~ promotion_zone,
                      clusters = facility_identifier,
                      data = df %>% filter(round == 1))

## ----echo=FALSE--------------------------------------------------------------
modelsummary(list("Enrollment"= m_first_stage), stars = TRUE,
             gof_map = c("nobs", "r.squared","adj.r.squared"), output = 'kableExtra') 


## ----eval=T, echo=TRUE-------------------------------------------------------
#| class: small-code

# Estimate ITT effect (reduced form)
m_itt <- lm_robust(waste_management_costs ~ promotion_zone,
                   clusters = zone_identifier,
                   data = df %>% filter(round == 1))

# With covariate adjustment
m_itt_wcov <- lm_robust(waste_management_costs ~ promotion_zone + 
                        age_manager + age_deputy +
                        female_manager + foreign_owned + 
                        staff_size +
                        advanced_filtration + 
                        facility_area +
                        recycling_center_distance,
                        clusters = zone_identifier,
                        data = df %>% filter(round == 1))


## ----echo=FALSE--------------------------------------------------------------
modelsummary(list("No covariate adj."= m_itt, "With covariate adj." = m_itt_wcov), stars = TRUE,
             gof_map = c("nobs", "r.squared","adj.r.squared"), output = 'kableExtra') %>%
  kable_styling(font_size = 13) %>% scroll_box(width = "700px", height = "400px")


jtools::export_summs(m_itt,m_itt_wcov,
                     to.file = "docx", file.name = "itt.docx")

## ----eval=T, echo=TRUE-------------------------------------------------------
# Estimate LATE using IV regression (2SLS)
m_late <- iv_robust(waste_management_costs ~ enrolled_rp |
                     promotion_zone,
                   clusters = zone_identifier,
                   data = df %>% filter(round == 1))

# With covariate adjustment
m_late_wcov <- iv_robust(waste_management_costs ~ enrolled_rp + 
                         age_manager + age_deputy +
                         female_manager + foreign_owned + 
                         staff_size +
                         advanced_filtration + 
                         facility_area +
                         recycling_center_distance | 
                         promotion_zone + 
                         age_manager + age_deputy +
                         female_manager + foreign_owned + 
                         staff_size +
                         advanced_filtration + facility_area +
                         recycling_center_distance,
                         clusters = zone_identifier,
                         data = df %>% filter(round == 1))


## ----echo=FALSE--------------------------------------------------------------
modelsummary(list("No covariate adj."= m_late, "With covariate adj." = m_late_wcov), stars = TRUE,
             gof_map = c("nobs", "r.squared","adj.r.squared"), output = 'kableExtra') %>%
  kable_styling(font_size = 15) %>% scroll_box(width = "600px", height = "300px")


