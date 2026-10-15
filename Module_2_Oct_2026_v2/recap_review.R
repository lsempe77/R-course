# Values and figures for the Days 1-3 recap deck (Oct15_recap.qmd).
# Each session's helper script is loaded into its own environment, so the recap
# reuses the exact figures and numbers taught in that session.
load_session <- function(file) {
  e <- new.env(parent = globalenv())
  e$source <- function(file, ...) sys.source(file, envir = e)
  sys.source(file, envir = e)
  e
}
s1 <- load_session('session1_hybrid.R')
s2 <- load_session('session2_review.R')
s3 <- load_session('session3_hybrid.R')
d4 <- load_session('day2_session1_review.R')
d5 <- load_session('day2_session2_review.R')
d6 <- load_session('day2_session3_review.R')
d7 <- load_session('day3_session1_review.R')

case <- s1$case
fmt <- s1$fmt
html_out <- s1$html_out
city <- s1$city
tp <- s1$tp

# Headline numbers, quoted in the slide text.
v <- list(
  before = mean(tp$cost_before), after = mean(tp$cost_after),
  ba = case$before_after, ba_ci = s1$ba_ci,
  city_mean = mean(city$cost_before), city_median = median(city$cost_before),
  ww = case$with_without, gap_before = case$gap_before,
  others_change = mean(city$change[!s1$took]),
  rct = case$rct, rct_ci = case$rct_ci,
  did = case$did, did_ci = d6$did_ci,
  rdd2 = case$rdd2, rdd5 = case$rdd5, age_jump = case$age_jump,
  quartic = unname(coef(d5$d5_poly_model(4))['below']),
  match = d6$match_A, match_no_age = d6$match_B,
  saving = d7$model$saving, cost = d7$model$cost, rate = d7$model$rate,
  pv1 = d7$model$saving / (1 + d7$model$rate),
  benefits = d7$d7_benefits, npv = d7$d7_npv, ratio = d7$ratio(),
  ratio_3y = d7$ratio(years = 3), ratio_fade = d7$ratio(decay = .3),
  ratio_combo = d7$ratio(decay = .3, extra = 800),
  break_even = d7$model$cost / d7$pv_factor())
stopifnot(round(v$ba) == -669, round(v$rct) == -1014, round(v$did) == -812,
          round(v$rdd2[['estimate']]) == -721, round(v$match$est) == -1029,
          round(v$ratio, 2) == 2.44, round(v$benefits) == 4392,
          length(v$did_ci) == 2, all(is.finite(v$did_ci)))

# A saving is the cost difference with its sign reversed; the interval flips too.
saving_ci <- function(ci) paste(fmt(-max(ci)), 'to', fmt(-min(ci)))

# Balance before and after matching, in city standard deviations.
recap_balance <- function() with(d6, {
  cols <- c(d6_vars, 'cost_before')
  labels <- c('Manager age', 'Staff', 'Premises area', 'Filtration', 'Cost before (not matched on)')
  s <- vapply(city[, cols], sd, 0)
  p <- colMeans(city[d6_ids, cols])
  before <- (p - colMeans(city[d6_controls, cols])) / s
  after <- (p - colMeans(city[d6_twins, cols])) / s
  x <- function(z) 420 + (z + 2) / 2.5 * 600
  ys <- 70 + (seq_along(cols) - 1) * 46
  rows <- paste(vapply(seq_along(cols), function(i) sprintf(
    '<text x="400" y="%.0f" text-anchor="end" font-size="23">%s</text><line x1="420" x2="1020" y1="%.0f" y2="%.0f" stroke="#D5DEE8"/><line x1="%.1f" x2="%.1f" y1="%.0f" y2="%.0f" stroke="#7da1c4" stroke-width="3"/><circle cx="%.1f" cy="%.0f" r="10" fill="#9aa3ad"/><circle cx="%.1f" cy="%.0f" r="10" fill="#215a9e"/>',
    ys[i] + 8, labels[i], ys[i], ys[i], x(before[i]), x(after[i]), ys[i], ys[i],
    x(before[i]), ys[i], x(after[i]), ys[i]), ''), collapse = '')
  ticks <- paste(vapply(seq(-2, 0.5, 0.5), function(z) sprintf(
    '<text x="%.1f" y="%.0f" text-anchor="middle" font-size="21">%s</text>', x(z), max(ys) + 50, fmt(z, 1)), ''), collapse = '')
  s2$s2_svg(paste0(
    '<circle cx="430" cy="22" r="10" fill="#9aa3ad"/><text x="448" y="30" font-size="23">All comparison businesses</text>',
    '<circle cx="770" cy="22" r="10" fill="#215a9e"/><text x="788" y="30" font-size="23">Matched comparison businesses</text>',
    sprintf('<line x1="%.1f" x2="%.1f" y1="50" y2="%.0f" stroke="#B8272C" stroke-width="3" stroke-dasharray="7 5"/>', x(0), x(0), max(ys) + 22),
    rows, ticks,
    sprintf('<text x="720" y="%.0f" text-anchor="middle" font-size="22">Participant mean minus comparison mean, in city standard deviations (0 = balanced)</text>', max(ys) + 82)),
    'Balance before and after matching, in city standard deviations. Manager age moves from -1.66 to -0.27; staff, area and filtration move close to zero; cost before matching moves from -1.21 to -0.24.',
    h = max(ys) + 95)
})

# Three kinds of economic evaluation: the unit of the result is what differs.
recap_methods <- function() {
  panel <- function(x, name, top, bottom, result, note) sprintf(
    '<g transform="translate(%d,0)"><rect x="0" y="10" width="330" height="270" rx="14" fill="#f4f7fb" stroke="#D5DEE8" stroke-width="2"/><text x="165" y="58" text-anchor="middle" font-size="34" font-weight="700" fill="#063360">%s</text><text x="165" y="118" text-anchor="middle" font-size="23">%s</text><line x1="45" x2="285" y1="134" y2="134" stroke="#063360" stroke-width="3"/><text x="165" y="166" text-anchor="middle" font-size="23">%s</text><text x="165" y="220" text-anchor="middle" font-size="24" font-weight="700" fill="#215a9e">%s</text><text x="165" y="256" text-anchor="middle" font-size="19" fill="#545860">%s</text></g>',
    x, name, top, bottom, result, note)
  s2$s2_svg(paste0(
    panel(25, 'CEA', 'extra cost', 'extra tonnes avoided', 'AED per tonne', 'outcome in its natural unit'),
    panel(385, 'CUA', 'extra cost', 'extra QALYs gained', 'AED per QALY', 'health studies only'),
    panel(745, 'CBA', 'benefits in AED', 'costs in AED', 'ratio or net AED', 'GreenWaste cost saving fits here')),
    'Three kinds of economic evaluation. CEA: extra cost divided by extra tonnes of landfill avoided. CUA: extra cost divided by extra QALYs gained. CBA: benefits and costs both in AED, compared as a ratio or a net amount.',
    h = 295)
}
