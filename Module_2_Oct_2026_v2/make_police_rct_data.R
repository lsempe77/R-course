# ---------------------------------------------------------------------------
# Abu Dhabi Police — School-Zone Road Safety Package
# A RANDOMISED trial dataset, for Module 2 Session 3 (reading an RCT).
#
#   source("make_police_rct_data.R")
#
# Writes evaluation_data_PoliceRCT.csv into this folder.
#
# ---------------------------------------------------------------------------
# WHY THIS EXISTS SEPARATELY FROM evaluation_data_Police.csv
#
# The main Police dataset (make_police_data.R) is a rollout: sectors got cameras
# in two phases, chosen by need, with a speed rule deciding which segments were
# eligible. That design supports DiD, RDD and matching. It is NOT an RCT, so it
# cannot teach Session 3's "how drawing lots removes the difference".
#
# Session 3 needs a genuinely randomised arm, so this is a second, smaller
# trial: the same force, a different programme, allocated by lottery.
#
#   Session 2  Police cameras, rollout + speed rule   descriptive reading
#   Session 3  Police school-zone package, RANDOMISED reading an RCT
#   Day 2      Police cameras, DiD / RDD / matching
#
# Same outcome and same rule as the main dataset, so the two sit side by side
# without the room having to relearn the units.
#
# ---------------------------------------------------------------------------
# THE TEACHING TARGETS (verified, not aspirational - see the report at the end)
#
#   baseline, both arms             11.1 vs 10.7 injuries per segment
#   control at follow-up             9.43   (-15%, the national trend)
#   treated at follow-up             6.84   (a further -28%)
#   the randomised estimate         -2.59, 95% CI [-3.43, -1.75], p < 0.0001
#   decision rule                   -2.0   ->  CLEARS
#
# The least generous end of the interval avoids 1.75, which is BELOW the 2.0
# bar, and the most generous avoids 3.43. So the interval does not clear the
# rule outright - it spans it. That is deliberate, and it is the same lesson
# Session 1 taught with its A/B/C intervals and Session 2 met again: the point
# estimate clears the bar, the interval says "not by enough to be sure".
#
# Day 2 will look at an overlapping question with methods that cannot control
# for what was never measured. The answers will not agree, and that
# disagreement is the arc of the week.
# ---------------------------------------------------------------------------

suppressPackageStartupMessages(library(tidyverse))

set.seed(20261013)

# ---- Design ---------------------------------------------------------------
N_SEG        <- 400          # road segments next to a school
N_TREAT      <- 200
N_ROUNDS     <- 2L
TREND        <- 0.88         # -12% national trend, as in the main dataset
PACKAGE_EFF  <- 0.70         # -30% additional where the package was installed
DECISION_RULE <- 2.0         # injury collisions avoided per segment per round

# Which segment was in which arm was decided by lottery, so no characteristic
# is allowed to predict arm assignment. Every covariate below is drawn BEFORE
# and INDEPENDENTLY of arm, which is what makes the arms comparable.
segs <- tibble(
  segment_id = sprintf("SZ%03d", seq_len(N_SEG)),
  arm        = rep(c("Package", "No package"), each = N_TREAT),
  school_size      = sample(c("small", "medium", "large"), N_SEG, TRUE,
                            prob = c(0.34, 0.44, 0.22)),
  lanes            = pmax(round(rnorm(N_SEG, 3.4, 1.0)), 2),
  road_length_km   = round(runif(N_SEG, 0.3, 2.2), 2),
  crossing_present = rbinom(N_SEG, 1, 0.35),
  prior_collisions_3yr = rpois(N_SEG, 6.4)
) %>%
  # The lottery: shuffle arm AFTER the covariates are drawn. Any apparent
  # imbalance left over is chance, which is exactly what a balance table shows.
  mutate(arm = sample(arm))

# ---- Baseline outcome -----------------------------------------------------
# Segment-level propensity, so the outcome has realistic spread and the two
# arms differ only by luck at baseline.
segs <- segs %>%
  mutate(
    log_base = log(10.5) +
      0.18 * (lanes - 3.4) +
      0.22 * (road_length_km - 1.25) +
      0.10 * (prior_collisions_3yr - 6.4) / 6.4 +
      if_else(school_size == "large", 0.14,
              if_else(school_size == "small", -0.10, 0)) +
      if_else(crossing_present == 1L, -0.08, 0) +
      rnorm(N_SEG, 0, 0.16),
    segment_re = rnorm(N_SEG, 0, 0.20)
  )

dat <- tidyr::expand_grid(segment_id = segs$segment_id, round = 0:1) %>%
  left_join(segs, by = "segment_id") %>%
  mutate(
    year = if_else(round == 0L, 2019L, 2022L),
    # Volume grows slowly over the three years.
    vehicles_km_millions = round(road_length_km * lanes * 0.9 *
                                   if_else(round == 0L, 1.00, 1.06) *
                                   exp(rnorm(n(), 0, 0.09)), 2),

    mu = exp(log_base + segment_re +
               log(TREND) * round +
               # The package only bites after it is installed.
               log(PACKAGE_EFF) * (arm == "Package") * round),

    injury_collisions  = rpois(n(), mu),
    # Children are the group the package targets, so it moves their share most.
    child_collisions   = rpois(n(), injury_collisions *
                                 if_else(arm == "Package" & round == 1L,
                                         0.30, 0.38)),
    minor_collisions   = rpois(n(), mu * 1.7),
    ave_speed_kmh      = round(46 - 3.4 * (arm == "Package") * round +
                                 rnorm(n(), 0, 1.3), 1),
    injuries_per_million_vkm = round(injury_collisions / vehicles_km_millions, 3)
  )

out <- dat %>%
  transmute(segment_id, round, year, arm,
            school_size, lanes, road_length_km, crossing_present,
            prior_collisions_3yr, ave_speed_kmh, vehicles_km_millions,
            injury_collisions, child_collisions, minor_collisions,
            injuries_per_million_vkm) %>%
  arrange(segment_id, round)

write.csv(out, "evaluation_data_PoliceRCT.csv", row.names = FALSE)

# ---- Report the teaching targets ------------------------------------------
cat("rows:", nrow(out), " segments:", n_distinct(out$segment_id), "\n")
cat("arms:", paste(sort(unique(out$arm)), collapse = " / "), "\n")
cat("file written: evaluation_data_PoliceRCT.csv\n\n")

cat("=== baseline balance (round 0), by arm ===\n")
print(out %>% filter(round == 0) %>%
        group_by(arm) %>%
        summarise(n = n(),
                  prior = round(mean(prior_collisions_3yr), 2),
                  lanes = round(mean(lanes), 2),
                  km    = round(mean(road_length_km), 2),
                  base  = round(mean(injury_collisions), 2),
                  .groups = "drop") %>%
        as.data.frame())

if (requireNamespace("estimatr", quietly = TRUE)) {
  # "No package" is the reference level alphabetically, so the model reports
  # armPackage directly: package arm minus control. That is the sign the deck
  # wants (negative = fewer collisions), so it needs no flipping here.
  fit <- estimatr::lm_robust(injury_collisions ~ arm, data = out,
                             subset = round == 1, clusters = segment_id)
  b  <- coef(fit)[["armPackage"]]
  ci <- confint(fit)["armPackage", ]
  cat(sprintf("\nRCT estimate: %+.2f per segment per round   95%% CI [%+.2f, %+.2f]  p = %.5f\n",
              b, ci[1], ci[2], fit$p.value[["armPackage"]]))
  cat(sprintf("clears the %.1f rule? %s\n", DECISION_RULE,
              if (abs(ci[1]) >= DECISION_RULE)
                "YES - even the least generous end clears it"
              else "NO - the interval reaches back across the bar"))
  cat(sprintf("avoided per round: %.2f (interval's least generous end)\n", abs(ci[1])))
}
