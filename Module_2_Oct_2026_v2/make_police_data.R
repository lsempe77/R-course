# ---------------------------------------------------------------------------
# Abu Dhabi Police — Automated Speed Enforcement Programme
# Synthetic evaluation dataset for Module 2 (Session 2 onward).
#
#   source("make_police_data.R")
#
# Writes evaluation_data_Police.csv into this folder.
#
# ---------------------------------------------------------------------------
# WHY THIS FILE IS SHAPED THE WAY IT IS
#
# There is no real Abu Dhabi Police evaluation dataset in this workspace. The
# outline for Session 2 calls for one, so this generates a plausible stand-in.
# It is FICTIONAL and every deck must say so on the slide (Session 1 sets the
# precedent with "Illustrative example, not a real Abu Dhabi case study").
#
# The columns are chosen so that ONE dataset carries four later sessions:
#
#   Session 2  descriptive reading  - base table, counts, rates, exposure
#   Oct13 S1   difference-in-differences
#                 sector-level rollout in two phases, before/after rounds
#                 -> treated x round interaction is the DiD estimate
#   Oct13 S2   regression discontinuity
#                 cameras went only to segments whose baseline 85th-percentile
#                 speed was at or above 70 km/h
#                 -> running variable = baseline_speed_85th, cut-off = 70
#   Oct13 S3   matching
#                 covariates predict both selection and the outcome, so
#                 matching on observables moves the answer
#
# Designing the columns for all four now is far cheaper than retrofitting a
# dataset three sessions later.
#
# ---------------------------------------------------------------------------
# THE TEACHING TARGETS
#
# The numbers are engineered so the deck lands on this sequence:
#
#   naive before-and-after in treated sectors   about -30%   looks decisive
#   same period, comparison sectors             about -12%   the national trend
#   difference-in-differences                   about -1.6 injuries per
#                                               segment per round
#   decision rule (below) needs                 -2.0 or better
#
# So the result is statistically clear and decision-wise insufficient, which is
# exactly Session 1's "statistically significant does not mean worth funding".
# The 30% figure is also a deliberate callback to Session 1's road-safety case.
# ---------------------------------------------------------------------------

suppressPackageStartupMessages(library(tidyverse))

set.seed(20261012)

# ---- Design ---------------------------------------------------------------
N_SECTOR     <- 24      # 12 phase 1 (cameras 2020), 12 phase 2 (cameras 2022)
SEG_PER_SEC  <- 50
N_SEG        <- N_SECTOR * SEG_PER_SEC          # 1,200 road segments
ROUNDS       <- c(0L, 1L)                        # 0 = 2019, 1 = 2021
SPEED_CUTOFF <- 70                               # km/h, RDD running variable

# National road-safety trend and the camera effect, as multipliers per round.
TREND        <- 0.88     # -12% everywhere: safer vehicles, national campaigns
CAMERA_EFF   <- 0.865    # additional -13.5% where cameras were installed.
# Deliberately tuned so the DiD lands near -1.5 against a rule of 2.0: clearly
# short of the bar, but with an interval that reaches it. A point estimate of
# -1.99 would have sat a hair under the threshold and read as a contrivance;
# the teaching point needs daylight between the estimate and the rule, plus
# an interval that still spans it (Session 1, Word 5).

# The bar the force has to clear before a national roll-out.
DECISION_RULE <- 2.0     # injury collisions avoided per segment per round

sectors <- tibble(
  sector_id   = sprintf("SEC%02d", 1:N_SECTOR),
  phase       = c(rep(1L, 12), rep(2L, 12)),
  # The programme went to the worst roads first, so phase 1 is a little faster
  # and a little busier on average. That is what creates an honest baseline gap.
  speed_bias  = if_else(phase == 1L, 3.0, -3.0),
  sector_re   = rnorm(N_SECTOR, 0, 0.12)
)

# ---- One row per road segment ---------------------------------------------
segments <- tidyr::expand_grid(sector_id = sectors$sector_id,
                               seg = seq_len(SEG_PER_SEC)) %>%
  left_join(sectors, by = "sector_id") %>%
  mutate(
    segment_id = sprintf("%s-%03d", sector_id, seg),

    # 85th-percentile speed measured in 2019, before anything was installed.
    # This is the RDD running variable: continuous, centred near the cut-off so
    # there is plenty of mass on both sides of 70.
    baseline_speed_85th = round(rnorm(n(), SPEED_CUTOFF + speed_bias, 9), 1),

    # Road characteristics. Speed limit is derived from the observed speed so
    # the dataset is internally consistent rather than two independent draws.
    speed_limit_kmh = case_when(
      baseline_speed_85th < 65 ~ 60,
      baseline_speed_85th < 85 ~ 80,
      TRUE                     ~ 100
    ),
    lanes      = pmin(pmax(round(rnorm(n(), 4, 1.1)), 2), 6),
    road_length_km = round(runif(n(), 0.4, 3.4), 2),
    lighting_quality = sample(c("poor", "adequate", "good"), n(),
                              replace = TRUE, prob = c(0.18, 0.55, 0.27)),
    school_within_500m = rbinom(n(), 1, 0.22),
    corridor_type = sample(c("urban arterial", "suburban arterial", "ring road",
                             "school corridor"), n(), replace = TRUE,
                           prob = c(0.38, 0.28, 0.20, 0.14))
  ) %>%
  mutate(
    # Three years of history, before the programme. Used both as a covariate and
    # as pre-programme evidence of where the problem already was.
    prior_collisions_3yr = rpois(
      n(),
      exp(log(11) + 0.32 * (road_length_km - 1.9) + 0.09 * (lanes - 4) +
            0.014 * (baseline_speed_85th - 70) +
            if_else(lighting_quality == "poor", 0.14,
                    if_else(lighting_quality == "good", -0.12, 0)) +
            0.10 * school_within_500m)
    )
  )

# Exposure: million vehicle-km per segment per round. Traffic grew slightly
# between the two rounds, which is the detail that makes a count and a RATE
# tell different stories - the Session 1 lesson, reused.
# Exposure: million vehicle-km per segment per round. Traffic grew slightly
# between the two rounds, which is the detail that makes a count and a RATE
# tell different stories - the Session 1 lesson, reused.
#
# This carries the whole segment record (rather than a few columns), because
# both the assignment step and the outcome step below need segment attributes.
# Joining once here avoids re-joining later and keeps the column list in one
# place.
exposure <- tidyr::expand_grid(segment_id = segments$segment_id, round = ROUNDS) %>%
  left_join(segments, by = "segment_id") %>%
  mutate(
    vehicles_km_millions = round(
      road_length_km * lanes * 1.15 *
        if_else(round == 0L, 1.00, 1.04) *        # traffic grew 4%
        exp(rnorm(n(), 0, 0.10)),
      2)
  )

# ---- Assignment -----------------------------------------------------------
# Two real mechanisms, both common in enforcement rollouts:
#   (a) the force rolled out sector by sector  -> DiD
#   (b) within the rollout, cameras went first to the fastest roads, chosen by
#       a transparent speed rule              -> RDD
# This is why `treated` (sector level) and `eligible_speed` (segment level) are
# two different columns rather than one.
dat <- exposure %>%
  mutate(
    treated         = as.integer(phase == 1L),
    eligible_speed  = as.integer(baseline_speed_85th >= SPEED_CUTOFF),
    cameras_installed = as.integer(treated == 1L & eligible_speed == 1L)
  )

# ---- Outcome --------------------------------------------------------------
# Poisson counts with a segment-level random effect, so the dispersion is
# realistic and the standard errors are not artificially tight.
dat <- dat %>%
  mutate(
    segment_re     = rnorm(n(), 0, 0.22),
    camera_change  = cameras_installed * round,   # only bites in round 1

    log_mu = log(9.2) +
      sector_re +
      segment_re +
      0.06 * treated +                            # phase 1 roads are busier
      0.30 * (road_length_km - 1.9) +
      0.09 * (lanes - 4) +
      0.013 * (baseline_speed_85th - SPEED_CUTOFF) +
      if_else(lighting_quality == "poor", 0.13,
              if_else(lighting_quality == "good", -0.11, 0)) +
      0.09 * school_within_500m +
      0.11 * (prior_collisions_3yr - 11) / 11 +
      log(TREND)  * round +                       # national trend, -12%
      log(CAMERA_EFF) * camera_change,            # camera effect, extra -20%

    mu = exp(log_mu),

    injury_collisions = rpois(n(), mu),

    # Speed cameras do more against severity than against frequency, so the
    # fatal share falls a little faster than the total. Worth noticing when
    # reading the table.
    fatal_collisions = rpois(n(), injury_collisions * 0.034 * if_else(
      camera_change == 1L, 0.78, 1.0)),
    minor_collisions = rpois(n(), mu * 1.9),

    # Enforcement activity: tickets per 1,000 vehicles. Zero where no camera.
    enforcement_intensity = round(
      if_else(cameras_installed == 1L,
              pmax(rnorm(n(), 2.6, 0.8), 0.2), 0), 2),

    # Average speed in the round, so the mechanism is visible in the data and
    # not just asserted.
    ave_speed_kmh = round(baseline_speed_85th * if_else(
      camera_change == 1L, 0.93, 0.995) + rnorm(n(), 0, 1.1), 1),

    year = if_else(round == 0L, 2019L, 2021L),
    injuries_per_million_vkm = round(injury_collisions /
                                       vehicles_km_millions, 3)
  )

# ---- Final column order ---------------------------------------------------
out <- dat %>%
  transmute(
    segment_id, sector_id, corridor_type, year, round,
    treated, eligible_speed, cameras_installed, enforcement_intensity,
    baseline_speed_85th, ave_speed_kmh, speed_limit_kmh, lanes, road_length_km,
    lighting_quality, school_within_500m, prior_collisions_3yr,
    vehicles_km_millions,
    injury_collisions, fatal_collisions, minor_collisions,
    injuries_per_million_vkm
  ) %>%
  arrange(sector_id, segment_id, round)

write.csv(out, "evaluation_data_Police.csv", row.names = FALSE)

# ---- Report the teaching targets, so the deck can be built against facts ----
cat("rows:", nrow(out), " segments:", n_distinct(out$segment_id), "\n")
cat("file written: evaluation_data_Police.csv\n\n")

naive <- out %>% filter(treated == 1L) %>%
  group_by(round) %>% summarise(m = mean(injury_collisions), .groups = "drop")
comp <- out %>% filter(treated == 0L) %>%
  group_by(round) %>% summarise(m = mean(injury_collisions), .groups = "drop")

tr0 <- naive$m[naive$round == 0]; tr1 <- naive$m[naive$round == 1]
co0 <- comp$m[comp$round == 0];  co1 <- comp$m[comp$round == 1]

cat(sprintf("treated  sectors: %.2f -> %.2f  (%+.1f%%)\n", tr0, tr1,
            100 * (tr1 - tr0) / tr0))
cat(sprintf("comparison       : %.2f -> %.2f  (%+.1f%%)\n", co0, co1,
            100 * (co1 - co0) / co0))
cat(sprintf("DiD (means)      : %+.2f injuries per segment per round\n",
            (tr1 - tr0) - (co1 - co0)))

# The model the deck will actually project, with segment-clustered errors.
# Reported here so the slide's numbers come from the data and are not typed in.
if (requireNamespace("estimatr", quietly = TRUE)) {
  fit <- estimatr::lm_robust(
    injury_collisions ~ treated * round, data = out, clusters = segment_id)
  b  <- coef(fit)[["treated:round"]]
  ci <- confint(fit)["treated:round", ]
  cat(sprintf("DiD (model)      : %+.2f   95%% CI [%+.2f, %+.2f]  p = %.4f\n",
              b, ci[1], ci[2], fit$p.value[["treated:round"]]))

  # The rule is about how many collisions the programme AVOIDS, so compare the
  # magnitude of the interval's closest-to-zero end against it. If even the
  # optimistic end of the interval falls short, the answer is unambiguously
  # "not enough" rather than "too uncertain to call".
  avoided_hi <- abs(ci[1])   # most collisions the interval will allow
  cat(sprintf("avoided per round: %.2f  (interval's most generous end)\n",
              avoided_hi))
  cat(sprintf("clears the rule? : %s\n",
              if (avoided_hi >= DECISION_RULE)
                "yes - interval reaches the rule"
              else
                "NO - even the most generous end falls short"))
} else {
  cat("(estimatr not installed; skipping the model estimate)\n")
}
cat(sprintf("decision rule    : %.1f injuries per segment per round\n",
            DECISION_RULE))
