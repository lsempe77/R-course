# Current translation route uses corrected GreenWaste evidence.
# The earlier Tariff Shield exercise is archived in the approved-day backup.
source('day4_case.R',encoding='UTF-8')
transl_programme <- list(name='GreenWaste',what='Waste-management support for businesses',where='One pilot district and the rest of the city',when='Before and 12 months after',rule='Minimum annual saving 1,000 AED per business')
transl_findings <- data.frame(id=paste0('f',1:4),finding=finding_titles,numbers=finding_text)
