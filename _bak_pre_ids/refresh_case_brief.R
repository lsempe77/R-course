# Optional two-page reference, refreshed with the corrected shared case.
# Give out after cost reading begins; use the picture card for the introduction.
suppressPackageStartupMessages({library(officer);library(flextable)})
source('day2_case.R',encoding='UTF-8')
reader_day <- 2
source('reader_material_helpers.R')
ref_title <- function(d,title) body_add_fpar(d,fpar(ftext(title,
  fp_text(font.family='Arial',font.size=22,bold=TRUE,color='black'))),style='Title')
d <- rdoc() |> ref_title('GreenWaste case reference') |>
  rp('Use this reference when reading the evaluation extracts. It describes the programme, the compared businesses and the recorded outcomes.') |> rf() |>
  rh('The programme and decision') |>
  rp('GreenWaste provides a subsidy for waste equipment, technical help with installation and staff training. Higher efficiency scores mean more efficient businesses.') |>
  rp(sprintf('Course decision rule: at least %s AED annual saving per business, measured after 12 months. A credible comparison is needed to estimate the saving GreenWaste caused. This rule alone is not a full value-for-money test.',fmt(decision_rule))) |>
  rh('How businesses joined') |>
  body_add_flextable(rtable(data.frame(Setting=c('Pilot district','Rest of city'),Businesses=c(fmt(nrow(pilot)),fmt(nrow(city))),
    Selection=c(sprintf('Lottery: %s joined and %s waited. All score 58 or below.',fmt(sum(pilot$took_part)),fmt(sum(pilot$took_part==0))),
    sprintf('Score rule: 58 or below joined (%s); above 58 did not (%s).',fmt(sum(took)),fmt(sum(!took)))),check.names=FALSE),c(1.4,1.2,3.7))) |>
  rh('What was measured') |>
  rp('One row per business. Annual waste cost in AED and annual landfill waste in tonnes, measured before and 12 months after. Manager age, staff, premises area and existing filtration were recorded before the programme.') |>
  rh('Read the comparison carefully') |>
  rp('Each method constructs a different comparison. Ask which businesses it describes, what assumption supports a causal interpretation, how uncertain the result is and what evidence is missing.') |>
  rp('Use the picture card when first introducing the case. This cost reference is optional once cost reading has begun.',11) |>
  body_add_break() |> ref_title('Recorded costs and column meanings') |>
  rh('Mean annual waste cost in AED') |>
  body_add_flextable(rtable(data.frame(Group=c('Pilot joined','Pilot waited','City took part','City did not take part'),
    Businesses=fmt(c(sum(pilot$took_part),sum(pilot$took_part==0),sum(took),sum(!took))),
    Before=fmt(c(mean(pilot$cost_before[pilot$took_part==1]),mean(pilot$cost_before[pilot$took_part==0]),means[1],means[3])),
    After=fmt(c(mean(pilot$cost_after[pilot$took_part==1]),mean(pilot$cost_after[pilot$took_part==0]),means[2],means[4])),check.names=FALSE),c(2.5,1.2,1.3,1.3))) |>
  rp('These are recorded means, not causal effect estimates. Values are rounded. The evaluation result belongs to the session extract.',11) |>
  rh('Column meanings') |>
  body_add_flextable(rtable(data.frame(Column=c('business and setting','score and took_part','cost_before\ncost_after','landfill_before\nlandfill_after','manager_age and staff','area and filtration'),
    Meaning=c('Identifier; pilot district or city','Efficiency score; 1 if joined, 0 otherwise','Annual waste cost in AED, before and after','Annual landfill tonnes, before and after','Manager age in years; number of staff','Premises area in 100 square metres; 1 if advanced filtration was already installed'),check.names=FALSE),c(2.7,3.6))) |> rf()
print(d,target='GreenWaste_case_brief.docx')
