# ===========================================================================
# The GreenWaste case: every headline number, computed once
# ===========================================================================
# source("greenwaste_case.R") after reading evaluation_data_GreenWaste_simple.csv
# into `gw`. Decks and the pack script quote these objects instead of typing
# numbers, so the week cannot drift.

RULE <- 1000
pilot <- subset(gw, setting == "pilot")
city  <- subset(gw, setting == "city")
city$change <- city$cost_after - city$cost_before
took  <- city$took_part == 1

case <- list()
case$before_after <- mean(city$change[took])
case$gap_before   <- mean(city$cost_before[took]) - mean(city$cost_before[!took])
case$with_without <- mean(city$cost_after[took]) - mean(city$cost_after[!took])
case$did          <- mean(city$change[took]) - mean(city$change[!took])

rct_fit  <- lm(cost_after ~ took_part, data = pilot)
case$rct    <- coef(rct_fit)[["took_part"]]
case$rct_ci <- unname(confint(rct_fit)["took_part", ])

rdd_at <- function(width, adjust = FALSE, cut = 58, data = city) {
  d <- subset(data, abs(score - cut) <= width)
  d$below <- as.integer(d$score <= cut); d$dist <- d$score - cut
  f <- estimatr::lm_robust(if (adjust) cost_after ~ below * dist + manager_age else cost_after ~ below * dist, data = d)
  c(estimate = coef(f)[["below"]], confint(f)["below", ], businesses = nrow(d))
}
case$rdd2     <- rdd_at(2)
case$rdd5     <- rdd_at(5)
case$rdd2_age <- rdd_at(2, adjust = TRUE)

# Nearest neighbour on standardised characteristics, with replacement.
match_on <- function(vars, data = city) {
  t <- data$took_part == 1
  X <- scale(data[, vars, drop = FALSE]); co <- which(!t)
  m <- vapply(which(t), function(i) co[which.min(colSums((t(X[co, , drop = FALSE]) - X[i, ])^2))], 1L)
  mean(data$cost_after[t] - data$cost_after[m])
}
MATCH_VARS <- c("manager_age", "staff", "area", "filtration")
case$matching        <- match_on(MATCH_VARS)
case$matching_no_age <- match_on(setdiff(MATCH_VARS, "manager_age"))

# Manager age just either side of the cut-off.
age_jump <- function(width = 5) {
  d <- subset(city, abs(score - 58) <= width); d$below <- as.integer(d$score <= 58); d$dist <- d$score - 58
  coef(lm(manager_age ~ below * dist, data = d))[["below"]]
}
case$age_jump <- age_jump()
