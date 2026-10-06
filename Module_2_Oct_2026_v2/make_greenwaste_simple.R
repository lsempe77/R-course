# ===========================================================================
# The simple GreenWaste dataset: one row per business
# ===========================================================================
#   Rscript make_greenwaste_simple.R   ->  evaluation_data_GreenWaste_simple.csv
#
# Invented data for training. GreenWaste reached businesses two ways:
#   setting = "pilot"  400 businesses scoring 58 or below; a lottery decided
#                      who took part (the randomised comparison)
#   setting = "pool"   6,000 businesses across the whole efficiency score; the
#                      programme went to those scoring 58 or below (before and
#                      after, with and without, DiD, RDD, matching)
#
# Columns: business, setting, score, took_part, cost_before, cost_after,
#          manager_age, staff, area, filtration
#
# What is built in, and what each method should find:
#   - The effect is larger for less efficient businesses: about -1,020 AED on
#     average for those who took part, -650 at the cut-off.
#   - Costs were rising anyway, faster for less efficient businesses (so
#     before-and-after understates and DiD falls about 200 AED short).
#   - Businesses that took part were cheaper to begin with (with-and-without
#     overstates).
#   - Manager age drives costs and differs a lot between the groups: matching
#     on all four characteristics works, leaving manager age out does not.
#   - Managers are about 6 years younger just below 58: the RDD balance check
#     fails, and part of the jump at the line is the managers.
# The pilot is calibrated so the randomised estimate is Module 1's -1,014.

set.seed(2026)
EFFECT_AT_58 <- -650; EFFECT_SLOPE <- 19.5       # the effect grows as the score falls

characteristics <- function(n, score) {
  data.frame(
    score       = round(score, 1),
    manager_age = round(rnorm(n, 30 + 0.3 * score, 5) - 6 * (score <= 58)),
    staff       = pmax(1, round(rnorm(n, 4 + 0.03 * score, 1.5))),
    area        = round(pmax(0.3, rnorm(n, 1.3 + 0.012 * score, 0.5)), 1),   # premises, 100 m2
    filtration  = rbinom(n, 1, plogis(-1.5 + 0.02 * score)))
}

outcomes <- function(d, took_part) {
  base  <- 1450 + 2 * (d$score - 39) + 27 * (d$manager_age - 36) + 70 * (d$staff - 5.2) +
           120 * (d$area - 1.8) - 100 * d$filtration + rnorm(nrow(d), 0, 150)
  trend <- 355 - (d$score - 39) * 204 / 40                         # smooth along the score
  eff   <- EFFECT_AT_58 - (58 - d$score) * EFFECT_SLOPE
  d$took_part   <- as.integer(took_part)
  d$cost_before <- round(base)
  d$cost_after  <- round(base + trend + d$took_part * eff + rnorm(nrow(d), 0, 140))
  d
}

pilot <- outcomes(characteristics(400, runif(400, 20, 58)), sample(rep(0:1, 200)))
gap   <- mean(pilot$cost_after[pilot$took_part == 1]) - mean(pilot$cost_after[pilot$took_part == 0])
pilot$cost_after[pilot$took_part == 1] <- round(pilot$cost_after[pilot$took_part == 1] - 1014 - gap)
pilot$setting <- "pilot"

s    <- runif(6000, 20, 100)
pool <- outcomes(characteristics(6000, s), s <= 58)
pool$setting <- "pool"

gw <- rbind(pilot, pool)
gw$business <- sprintf("B%04d", seq_len(nrow(gw)))
gw <- gw[, c("business", "setting", "score", "took_part", "cost_before", "cost_after",
             "manager_age", "staff", "area", "filtration")]
write.csv(gw, "evaluation_data_GreenWaste_simple.csv", row.names = FALSE)
cat("Wrote evaluation_data_GreenWaste_simple.csv:", nrow(gw), "rows\n")
