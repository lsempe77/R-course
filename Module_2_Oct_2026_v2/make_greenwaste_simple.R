# ===========================================================================
# The simple GreenWaste dataset: one row per business
# ===========================================================================
#   Rscript make_greenwaste_simple.R   ->  evaluation_data_GreenWaste_simple.csv
#
# Invented data for training, used by every Module 2 session. GreenWaste
# reached businesses two ways:
#   setting = "pilot"  400 businesses in the pilot district, all scoring 58 or
#                      below; a lottery decided who took part (the randomised
#                      comparison)
#   setting = "city"   10,000 businesses in the rest of the city, across the
#                      whole efficiency score; the programme went to those
#                      scoring 58 or below (before and after, with and without,
#                      DiD, RDD, matching)
#
# Columns: business, setting, score, took_part, cost_before, cost_after,
#          landfill_before, landfill_after, manager_age, staff, area, filtration
#
# Costs (AED per year) are the outcome the decision rests on. Landfill waste
# (tonnes per year) is a second outcome, used in Day 1 Session 1 to practise
# the vocabulary without giving away the cost results.
#
# What is built in, and what each method should find:
#   - The effect on costs is larger for less efficient businesses: about -1,020
#     AED on average for those who took part, -650 at the cut-off.
#   - Costs were rising anyway, faster for less efficient businesses (so
#     before-and-after understates and DiD falls about 200 AED short).
#   - Businesses that took part were cheaper to begin with (with-and-without
#     overstates).
#   - A few large businesses (many staff, big premises) give costs and landfill
#     a long right tail: the mean sits above the median.
#   - Changes vary: about one business in ten that took part ends with higher
#     costs.
#   - Manager age drives costs and differs a lot between the groups: matching
#     on all four characteristics works, leaving manager age out does not.
#   - Managers are about 6 years younger just below 58: the RDD balance check
#     fails, and part of the jump at the line is the managers.
#   - Landfill: smaller businesses send less (a head start for those who took
#     part); everyone's landfill fell a little anyway; taking part cut it by
#     about 4 tonnes a year.
# The pilot is calibrated so the randomised estimate on costs is -1,014.

set.seed(2026)
EFFECT_AT_58 <- -650; EFFECT_SLOPE <- 19.5       # the effect on costs grows as the score falls

characteristics <- function(n, score) {
  data.frame(
    score       = round(score, 1),
    manager_age = round(rnorm(n, 30 + 0.3 * score, 5) - 6 * (score <= 58)),
    staff       = pmax(1, round(exp(rnorm(n, log(3.6 + 0.03 * score), 0.45)))),     # long right tail
    area        = round(exp(rnorm(n, log(1.25 + 0.012 * score), 0.35)), 1),          # premises, 100 m2
    filtration  = rbinom(n, 1, plogis(-1.5 + 0.02 * score)))
}

outcomes <- function(d, took_part) {
  base  <- 1450 + 2 * (d$score - 39) + 27 * (d$manager_age - 36) + 160 * (d$staff - 5.2) +
           120 * (d$area - 1.8) - 100 * d$filtration + rnorm(nrow(d), 0, 150)
  trend <- 355 - (d$score - 39) * 204 / 40                         # smooth along the score
  eff   <- EFFECT_AT_58 - (58 - d$score) * EFFECT_SLOPE
  d$took_part   <- as.integer(took_part)
  d$cost_before <- round(base)
  d$cost_after  <- round(base + trend + d$took_part * eff + rnorm(nrow(d), 0, 500))
  # Landfill, tonnes per year: driven by size; a small fall for everyone; the programme cuts more.
  lf <- 6 + 1.4 * (d$staff - 5) + 3 * (d$area - 1.8) + 0.03 * (d$score - 39) + rnorm(nrow(d), 0, 1.5)
  lf <- pmax(1, lf)
  d$landfill_before <- round(lf, 1)
  d$landfill_after  <- round(pmax(0.5, lf - 0.6 - d$took_part * (3 + 0.03 * (58 - d$score)) +
                                       rnorm(nrow(d), 0, 1.2)), 1)
  d
}

pilot <- outcomes(characteristics(400, runif(400, 20, 58)), sample(rep(0:1, 200)))
gap   <- mean(pilot$cost_after[pilot$took_part == 1]) - mean(pilot$cost_after[pilot$took_part == 0])
pilot$cost_after[pilot$took_part == 1] <- round(pilot$cost_after[pilot$took_part == 1] - 1014 - gap)
pilot$setting <- "pilot"

s    <- runif(10000, 20, 100)
city <- outcomes(characteristics(10000, s), s <= 58)
city$setting <- "city"

gw <- rbind(pilot, city)
gw$business <- sprintf("B%05d", seq_len(nrow(gw)))
gw <- gw[, c("business", "setting", "score", "took_part", "cost_before", "cost_after",
             "landfill_before", "landfill_after", "manager_age", "staff", "area", "filtration")]
write.csv(gw, "evaluation_data_GreenWaste_simple.csv", row.names = FALSE)
cat("Wrote evaluation_data_GreenWaste_simple.csv:", nrow(gw), "rows\n")
