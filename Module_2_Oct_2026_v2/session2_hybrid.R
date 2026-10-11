# Values and figures for the Day 1 Session 2 deck that follows the printed sheets.
# The printed Sheet 1, Sheet 2 and claim cards use landfill tonnes, so the added data slides
# (the file, the filter, the histograms, the cleaning examples) use landfill tonnes too.
# Builds on session2_review.R; the review deck, worksheet and cards are not changed by this file.
source('session2_review.R', encoding = 'UTF-8')

hy2_city <- case_env$city
hy2_all <- case_env$gw
hy2_tp <- hy2_city[hy2_city$took_part == 1, ]

# The ten businesses on Sheet 1, section 2 (same records as the printed table).
hy2_ten <- as.numeric(ten$landfill_before)
stopifnot(identical(hy2_ten, c(3, 4, 5, 5, 6, 7, 7, 8, 9, 46)))

# Numbers that the slides and the speaker notes quote.
hy2_mean <- mean(hy2_city$landfill_before)
hy2_median <- median(hy2_city$landfill_before)
hy2_change <- round(hy2_tp$landfill_after - hy2_tp$landfill_before, 1)
hy2_n_fall <- sum(hy2_change < 0)
hy2_n_same <- sum(hy2_change == 0)
hy2_n_rise <- sum(hy2_change > 0)
hy2_n_all_part <- sum(hy2_all$took_part == 1)
hy2_n_city_part <- sum(hy2_city$took_part == 1)
hy2_n_pilot_winners <- sum(hy2_all$took_part[hy2_all$setting == 'pilot'] == 1)
stopifnot(nrow(hy2_all) == 10400, nrow(hy2_city) == 10000, hy2_n_city_part == 4794,
          hy2_n_all_part - hy2_n_city_part == hy2_n_pilot_winners,
          hy2_n_fall + hy2_n_same + hy2_n_rise == 4794)

# A histogram drawn as a native SVG, in the same style as s2_hist() in session2_review.R.
hy2_hist <- function(values, breaks, ticks, title, xlab, label, marks = 'none') {
  hh <- hist(values, breaks = breaks, plot = FALSE, right = FALSE)
  limits <- range(breaks)
  x <- function(v) 85 + (v - limits[1]) / diff(limits) * 960
  top <- ceiling(max(hh$counts) / 100) * 100
  y <- function(v) 255 - v / top * 185
  bars <- paste(vapply(seq_along(hh$counts), function(i) sprintf(
    '<rect x="%.1f" y="%.1f" width="%.1f" height="%.1f" fill="#7da1c4" stroke="white"/>',
    x(hh$breaks[i]), y(hh$counts[i]), x(hh$breaks[i + 1]) - x(hh$breaks[i]), 255 - y(hh$counts[i])), ''), collapse = '')
  axis <- paste(vapply(ticks, function(v) sprintf(
    '<text x="%.1f" y="283" text-anchor="middle" font-size="21">%s</text>', x(v), fmt(v)), ''), collapse = '')
  ya <- paste(vapply(c(0, top / 2, top), function(v) sprintf(
    '<text x="72" y="%.1f" text-anchor="end" font-size="20">%s</text>', y(v) + 6, fmt(v)), ''), collapse = '')
  m <- ''
  if (marks == 'meanmedian') {
    m <- sprintf(paste0(
      '<line x1="%.1f" x2="%.1f" y1="65" y2="255" stroke="#B8272C" stroke-width="3"/>',
      '<line x1="%.1f" x2="%.1f" y1="65" y2="255" stroke="#063360" stroke-width="3" stroke-dasharray="7 5"/>',
      '<text x="%.1f" y="43" font-size="23" fill="#B8272C">Mean %s</text>',
      '<text x="%.1f" y="43" text-anchor="end" font-size="23" fill="#063360">Median %s</text>'),
      x(mean(values)), x(mean(values)), x(median(values)), x(median(values)),
      x(mean(values)) + 10, fmt(mean(values), 1), x(median(values)) - 10, fmt(median(values), 1))
  }
  if (marks == 'zero') {
    m <- sprintf(paste0(
      '<line x1="%.1f" x2="%.1f" y1="60" y2="255" stroke="#B8272C" stroke-width="3"/>',
      '<text x="%.1f" y="45" text-anchor="middle" font-size="23" fill="#B8272C">No change</text>',
      '<text x="%.1f" y="100" font-size="21" fill="#063360">%s businesses rose,</text>',
      '<text x="%.1f" y="124" font-size="21" fill="#063360">%s was unchanged</text>',
      '<line x1="%.1f" x2="%.1f" y1="134" y2="247" stroke="#063360" stroke-width="2"/>'),
      x(0), x(0), x(0), x(0) + 8, fmt(sum(values > 0)), x(0) + 8, fmt(sum(values == 0)), x(0.5), x(0.5))
  }
  paste0('<p class="table-title"><strong>', title, '</strong></p>',
    s2_svg(paste0('<text x="85" y="23" font-size="20">Number of businesses</text>', bars, m, ya, axis,
      '<line x1="85" x2="1045" y1="255" y2="255" stroke="#545860"/>',
      '<text x="565" y="322" text-anchor="middle" font-size="23">', xlab, '</text>'), label))
}

# Landfill before GreenWaste, all 10,000 city businesses, in 2-tonne bands.
hy2_hist_before <- function(markers = FALSE) hy2_hist(
  hy2_city$landfill_before, seq(0, 48, 2), seq(0, 48, 8),
  'Histogram of landfill waste before GreenWaste for all 10,000 city businesses (tonnes per year, in bands of 2 tonnes)',
  'Landfill waste before GreenWaste (tonnes per business per year)',
  'Landfill waste before GreenWaste for all 10,000 city businesses; 2 tonne bands. Most businesses are between 2 and 16 tonnes and a few are far higher.',
  if (markers) 'meanmedian' else 'none')

# Change in landfill for the 4,794 participant businesses, in bands of half a tonne.
hy2_hist_change <- function() hy2_hist(
  hy2_change, seq(-8, 1.5, 0.5), seq(-8, 0, 2),
  'Histogram of the change in landfill waste for the 4,794 participant businesses (tonnes per business, one year later minus before)',
  'Change in landfill waste: one year later minus before (tonnes per business)',
  'Changes in landfill waste for all 4,794 city participant businesses. Almost all values are below zero.',
  'zero')

# The same calculation with and without the 400 pilot businesses, in landfill tonnes.
hy2_filter_table <- function() {
  one <- function(d) {
    ch <- d$landfill_after - d$landfill_before; t <- d$took_part == 1
    c(sum(t), sum(!t), mean(ch[t]), mean(ch[!t]), mean(ch[t]) - mean(ch[!t]))
  }
  a <- one(subset(hy2_all, setting == 'city')); b <- one(hy2_all)
  df <- data.frame(
    Quantity = c('Participant businesses', 'Comparison businesses',
                 'Participant businesses: mean change in landfill (tonnes)',
                 'Comparison businesses: mean change in landfill (tonnes)',
                 'Difference between the two changes (tonnes)'),
    'City rows only (correct)' = c(fmt(a[1:2]), fmt(a[3:5], 2)),
    'All 10,400 rows (wrong)' = c(fmt(b[1:2]), fmt(b[3:5], 2)), check.names = FALSE)
  paste0('<p class="table-title"><strong>The same calculation with and without the 400 pilot businesses</strong></p>',
    as.character(knitr::kable(df, format = 'html', row.names = FALSE, escape = TRUE, table.attr = 'class="reading-table"')))
}

# Four invented cleaning examples, in landfill tonnes. None of them is in the GreenWaste file.
hy2_cleaning <- function() {
  base_b <- c(10, 8, 12, 9, 20); base_a <- c(9, 6, 11, 7, 11)
  m0 <- mean(base_a - base_b)
  dup <- mean(c(base_a, base_a[5]) - c(base_b, base_b[5]))
  miss_a <- c(6, 5, -99, 7, 10)
  miss_bad <- mean(miss_a); miss_ok <- mean(miss_a[miss_a != -99])
  kg_a <- c(6, 5, 7, 6200, 9)
  kg_bad <- mean(kg_a); kg_ok <- mean(c(6, 5, 7, 6.2, 9))
  panel <- function(title, messy, effect) paste0('<div class="clean-panel"><h3>', title, '</h3><p>', messy,
    '</p><p><strong>', effect, '</strong></p></div>')
  paste0('<div class="clean-grid">',
    panel('Duplicate rows', 'Business B5 appears twice. The file has 6 rows for 5 businesses.',
      paste0('Mean change in landfill: ', fmt(dup, 1), ' tonnes with the duplicate, ', fmt(m0, 1), ' tonnes without it.')),
    panel('Missing values coded as -99', 'Landfill after: 6; 5; -99; 7; 10 tonnes.',
      paste0('Mean landfill: ', fmt(miss_bad, 1), ' tonnes if -99 is treated as a value, ', fmt(miss_ok, 1), ' tonnes if it is treated as missing.')),
    panel('A value in the wrong unit', 'Landfill after: 6; 5; 7; 6,200; 9. One value was entered in kilograms instead of tonnes.',
      paste0('Mean landfill: ', fmt(kg_bad, 1), ' tonnes as entered, ', fmt(kg_ok, 1), ' tonnes after correcting 6,200 kg to 6.2 tonnes.')),
    panel('Labels that differ', 'The took_part column holds "Yes", "yes", "Y" and "No".',
      'The table of counts shows four groups instead of two, so each group mean describes only some of the businesses.'),
    '</div>')
}
