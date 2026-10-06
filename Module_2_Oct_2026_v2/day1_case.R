# Shared Day 1 screen and paper values from the corrected score-rule CSV.
case_env <- new.env()
case_env$gw <- read.csv('evaluation_data_GreenWaste_simple.csv')
sys.source('greenwaste_case.R', envir = case_env)
case <- case_env$case
city <- case_env$city
pilot <- case_env$pilot
took <- case_env$took
decision_rule <- case_env$RULE
fmt <- function(x, digits = 0) formatC(x, format = 'f', digits = digits, big.mark = ',')
html_out <- function(x) cat('\n', strrep('`', 3), '{=html}\n', x, '\n', strrep('`', 3), '\n', sep = '')
tp <- city[took, ]
ba_mean <- c(before = mean(tp$cost_before), after = mean(tp$cost_after))
ba_long <- data.frame(business = rep(tp$business, 2), after = rep(0:1, each = nrow(tp)),
                      cost = c(tp$cost_before, tp$cost_after))
ba_fit <- estimatr::lm_robust(cost ~ after, data = ba_long, clusters = business, se_type = 'stata')
ba_ci <- unname(confint(ba_fit)['after', ])
ba_p <- ba_fit$p.value[which(names(coef(ba_fit)) == 'after')]
landfill <- c(before = mean(city$landfill_before[took]), after = mean(city$landfill_after[took]),
             other_before = mean(city$landfill_before[!took]), other_after = mean(city$landfill_after[!took]))
landfill_fall <- 100 * (1 - landfill['after'] / landfill['before'])
ten_ids <- c('B02136', 'B00755', 'B03791', 'B05600', 'B01274', 'B07507', 'B01673', 'B04954', 'B08013', 'B03836')
ten <- subset(city, business %in% ten_ids)
ten <- ten[order(ten$landfill_before), ]
land_fit <- lm(I(landfill_after - landfill_before) ~ took_part, data = city)
land_ci <- confint(land_fit)['took_part', ]
claims <- c(
  sprintf('Landfill waste from businesses in GreenWaste fell %s%% in a year.', fmt(landfill_fall)),
  sprintf('The effect of GreenWaste on landfill is %s tonnes per business, 95%% confidence interval %s to %s.',
          fmt(coef(land_fit)[['took_part']], 2), fmt(land_ci[1], 2), fmt(land_ci[2], 2)),
  'The fall in landfill is statistically significant (p < 0.001), so every business in the country should join GreenWaste.',
  sprintf('Landfill fell %s tonnes per business among those that took part and %s tonnes among those that did not.',
          fmt(landfill['before'] - landfill['after'], 1), fmt(landfill['other_before'] - landfill['other_after'], 1)))
fiction <- '<p class="fiction">Fictional GreenWaste case | invented figures</p>'
reading_table <- function(kind = 'before', highlight = FALSE) {
  trial <- kind == 'trial'
  b <- if (trial) case$rct else case$before_after
  ci <- if (trial) case$rct_ci else ba_ci
  row <- if (trial) 'Took part (lottery)' else 'After GreenWaste'
  h <- if (highlight) ' class="result-row"' else ''
  p <- if (trial) summary(case_env$rct_fit)$coefficients['took_part', 'Pr(>|t|)'] else ba_p
  p_label <- if (p < .001) '&lt; 0.001' else fmt(p, 3)
  paste0('<table class="reading-table"><thead><tr><th>Result row</th><th>Coefficient<br>AED</th><th>95% confidence<br>interval, AED</th><th>p-value</th></tr></thead><tbody><tr', h,
         '><th>', row, '</th><td>', fmt(b), '</td><td>', fmt(ci[1]), ' to ', fmt(ci[2]), '</td><td>', p_label,
         '</td></tr></tbody></table><p class="caption">',
         if (trial) 'Pilot district: lottery winners compared with businesses waiting, after 12 months.' else 'City participants: the same businesses before and 12 months after.',
         ' Annual waste cost per business. Negative means lower costs.</p>', fiction)
}
interval_svg <- function(kind = 'before', reveal = FALSE) {
  trial <- kind == 'trial'
  b <- abs(if (trial) case$rct else case$before_after)
  ci <- sort(abs(if (trial) case$rct_ci else ba_ci))
  x <- function(v) 70 + v / 1400 * 930
  id <- paste0('interval-', kind)
  visibility <- if (reveal) ' hidden' else ''
  paste0('<svg class="interval-visual" viewBox="0 0 1100 240" role="img" aria-label="Estimated annual saving ', fmt(b),
         ' AED, 95 percent confidence interval ', fmt(ci[1]), ' to ', fmt(ci[2]), ', decision rule ', fmt(decision_rule), ' AED.">',
         '<line x1="70" x2="1000" y1="155" y2="155" stroke="#545860" stroke-width="2"/>',
         paste(vapply(seq(0, 1400, 200), function(v) sprintf('<text x="%.1f" y="185" text-anchor="middle" font-size="22">%s</text>', x(v), fmt(v)), ''), collapse = ''),
         sprintf('<line x1="%.1f" x2="%.1f" y1="40" y2="155" stroke="#B8272C" stroke-width="3" stroke-dasharray="8 6"/><text x="%.1f" y="28" text-anchor="middle" fill="#B8272C" font-size="24">Rule %s</text>', x(decision_rule), x(decision_rule), x(decision_rule), fmt(decision_rule)),
         '<g id="', id, '"', visibility, '>',
         sprintf('<line x1="%.1f" x2="%.1f" y1="90" y2="90" stroke="#215a9e" stroke-width="9"/><text x="%.1f" y="68" text-anchor="end" font-size="24">%s</text><text x="%.1f" y="68" font-size="24">%s</text>', x(ci[1]), x(ci[2]), x(ci[1]) - 6, fmt(ci[1]), x(ci[2]) + 6, fmt(ci[2])),
         '</g>', sprintf('<circle cx="%.1f" cy="90" r="10" fill="#063360"/><text x="%.1f" y="131" text-anchor="middle" font-size="24" font-weight="bold">Estimate %s</text>', x(b), x(b), fmt(b)),
         '<text x="550" y="226" text-anchor="middle" font-size="24">Annual saving per business (AED)</text></svg>', fiction)
}
