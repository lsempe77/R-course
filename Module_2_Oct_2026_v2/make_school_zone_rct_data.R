# ---------------------------------------------------------------------------
# The school-zone safety package
# FICTIONAL randomised trial dataset, for Module 2 Session 3 (reading an RCT).
#
#   source("make_school_zone_rct_data.R")
#
# Writes evaluation_data_SchoolZoneRCT.csv into this folder.
#
# ---------------------------------------------------------------------------
# THIS CASE IS INVENTED, AND MUST ALWAYS BE LABELLED AS SUCH
#
# It is not an Abu Dhabi Police trial, and it is not any real programme. It was
# originally drafted as a stand-in for Police findings that do not exist in this
# workspace, and it named the force. That was wrong: it put fabricated numbers on
# a public site attributed to a real organisation. The case now names no real
# body. Every slide showing a number must carry a visible disclaimer.
#
# ---------------------------------------------------------------------------
# WHY THIS EXISTS SEPARATELY FROM evaluation_data_TrafficCameras.csv
#
# The main dataset (make_traffic_camera_data.R) is a rollout: sectors got cameras
# in two phases, chosen by need, with a speed rule deciding which segments were
# eligible. That design supports DiD, RDD and matching. It is NOT an RCT, so it
# cannot teach Session 3's "how drawing lots removes the difference".
#
# Session 3 needs a genuinely randomised arm, so this is a second, smaller
# trial: the same authority, a different programme, allocated by lottery.
#
#   Session 2  Traffic cameras, rollout + speed rule   descriptive reading
#   Session 3  School-zone package, RANDOMISED         reading an RCT
#   Day 2      Traffic cameras, DiD / RDD / matching
#
# Same outcome and same rule as the main dataset, so the two sit side by side
# without the room having to relearn the units.
#
# ---------------------------------------------------------------------------
# THE TEACHING TARGETS (verified by the report at the end of this script)
#
#   baseline, both arms             11.1 vs 10.7 injuries per segment
#   control at follow-up             9.43   (the national trend)
#   treated at follow-up             6.84   (a further fall)
#   the randomised estimate         -2.59, 95% CI [-3.43, -1.75], p < 0.0001
#   decision rule                   -2.0
#
# In "collisions avoided" terms the interval runs from 1.75 (pessimistic) to
# 3.43 (optimistic). The point estimate clears the 2.0 rule; the interval
# SPANS it, because 1.75 is below the bar. That is deliberate and it is the
# same shape Session 1 taught with its A/B/C intervals and Session 2 met again:
# "the interval decides, not the point estimate".
#
# Beware the sign trap when reading this: conf.low is -3.43 and conf.high is
# -1.75, so conf.low is the LARGER effect. abs(conf.low) is the OPTIMISTIC end.
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

write.csv(out, "evaluation_data_SchoolZoneRCT.csv", row.names = FALSE)

# ---- Report the teaching targets ------------------------------------------
cat("rows:", nrow(out), " segments:", n_distinct(out$segment_id), "\n")
cat("arms:", paste(sort(unique(out$arm)), collapse = " / "), "\n")
cat("file written: evaluation_data_SchoolZoneRCT.csv\n\n")

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

  # CAREFUL. The interval is negative because fewer collisions is the good
  # outcome, so conf.low (-3.43) is the LARGER effect and conf.high (-1.75) the
  # smaller one. Taking abs() of conf.low gives the OPTIMISTIC end, not the
  # pessimistic one. Sorting the absolute values removes the ambiguity: the
  # first element is always the end closest to zero.
  avoided <- sort(abs(ci))
  least   <- avoided[1]   # pessimistic end, closest to zero
  most    <- avoided[2]   # optimistic end

  cat(sprintf("\nRCT estimate: %+.2f per segment per round   95%% CI [%+.2f, %+.2f]  p = %.5f\n",
              b, ci[1], ci[2], fit$p.value[["armPackage"]]))
  cat(sprintf("avoids %.2f to %.2f per round across the interval\n", least, most))
  cat(sprintf("least it could avoid: %.2f   (rule is %.1f)\n", least, DECISION_RULE))
  cat(sprintf("clears the rule? %s\n",
              if (least >= DECISION_RULE)
                "YES - even the pessimistic end clears it"
              else
                "NO - the interval spans the rule (estimate clears, interval straddles)"))
}
