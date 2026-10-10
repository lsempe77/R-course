# ---------------------------------------------------------------------------
# Verification: does evaluation_data_TrafficCameras.csv actually support the four
# sessions it is meant to? Run after make_traffic_camera_data.R.
#
#   source("check_traffic_camera_data.R")
#
# This is a check, not a deliverable. It exists because the dataset was built
# for Session 2 but is claimed to serve DiD, RDD and matching later; that claim
# should be tested once rather than discovered to be false in October.
# ---------------------------------------------------------------------------

suppressPackageStartupMessages(library(tidyverse))

d <- read.csv("evaluation_data_TrafficCameras.csv")
ok <- function(label, cond) cat(sprintf("  [%s] %s\n", if (cond) "ok" else "FAIL", label))

cat("=== shape ===\n")
cat("  rows:", nrow(d), " segments:", n_distinct(d$segment_id),
    " sectors:", n_distinct(d$sector_id), "\n")
ok("two rounds per segment (2400 = 1200 x 2)",
   nrow(d) == 2 * n_distinct(d$segment_id))
ok("no missing values in key columns",
   !any(is.na(d[c("injury_collisions", "baseline_speed_85th", "treated",
                  "round", "vehicles_km_millions")])))

cat("\n=== Session 2: descriptive reading ===\n")
ok("headline before/after is a big, convincing fall",
   with(d %>% filter(treated == 1, round == 1), mean(injury_collisions)) /
   with(d %>% filter(treated == 1, round == 0), mean(injury_collisions)) < 0.85)
ok("comparison sectors also fell (so before/after overstates)",
   with(d %>% filter(treated == 0, round == 1), mean(injury_collisions)) /
   with(d %>% filter(treated == 0, round == 0), mean(injury_collisions)) < 1)
ok("a rate column exists alongside the count",
   "injuries_per_million_vkm" %in% names(d))
ok("traffic grew between rounds (count vs rate can disagree)",
   with(d %>% group_by(round) %>% summarise(v = mean(vehicles_km_millions)),
        v[2] > v[1]))

cat("\n=== Oct13 S1: difference-in-differences ===\n")
if (requireNamespace("estimatr", quietly = TRUE)) {
  f <- estimatr::lm_robust(injury_collisions ~ treated * round, d,
                           clusters = segment_id)
  b <- coef(f)[["treated:round"]]
  ok("DiD interaction is negative (programme helped)", b < 0)
  ok("DiD is statistically clear (p < 0.01)",
     f$p.value[["treated:round"]] < 0.01)
  ok("but the interval does NOT reach the decision rule",
     abs(confint(f)["treated:round", 1]) < 2.0)
}

cat("\n=== Oct13 S2: regression discontinuity ===\n")
# Two things this check has to get right, both learned the hard way.
#
#   1. The cut-off applies WITHIN the phase-1 sectors. Pooling all sectors
#      (some of which never got cameras) mixes a real discontinuity with a
#      smooth gradient and washes the jump out.
#   2. The outcome is injury_collisions. ave_speed_kmh is the MECHANISM - it
#      moves by construction - so testing it proves nothing about the estimate.
p1  <- d %>% filter(treated == 1, round == 1)
win <- p1 %>% filter(abs(baseline_speed_85th - 70) <= 6)

ok("the design is SHARP: within phase 1, eligibility == camera",
   all(p1$cameras_installed == p1$eligible_speed))
ok("enough mass within +/-6 km/h of the cut-off (>=200 rows)",
   nrow(win) >= 200)
ok("both sides of the cut-off are populated",
   sum(win$eligible_speed == 1) > 40 && sum(win$eligible_speed == 0) > 40)

jump <- with(win, mean(injury_collisions[eligible_speed == 1]) -
                  mean(injury_collisions[eligible_speed == 0]))
# A placebo at the same nominal cut-off in sectors that never got cameras:
# if the jump there is comparable, the "discontinuity" is just curvature.
placebo_win <- d %>% filter(treated == 0, round == 1,
                            abs(baseline_speed_85th - 70) <= 6)
placebo <- with(placebo_win, mean(injury_collisions[eligible_speed == 1]) -
                             mean(injury_collisions[eligible_speed == 0]))
ok("there IS a jump at the cut-off, in the right direction", jump < 0)
ok("the jump clearly beats the same comparison where no camera exists",
   abs(jump - placebo) > abs(placebo) && jump < 0)
cat(sprintf("      jump %+.2f   placebo %+.2f   diff-in-disc %+.2f\n",
            jump, placebo, jump - placebo))

cat("\n=== Oct13 S3: matching ===\n")
ok("covariates vary enough to match on (lanes has >1 level)",
   n_distinct(d$lanes) > 2)
ok("a covariate predicts selection (so matching on observables matters)",
   with(d %>% filter(round == 0),
        abs(cor(baseline_speed_85th, treated)) > 0.1))
ok("lighting_quality is categorical with 3 levels",
   n_distinct(d$lighting_quality) == 3)

cat("\n=== plausibility (nothing looks synthetic) ===\n")
ok("injury counts are integers",
   all(d$injury_collisions == round(d$injury_collisions)))
ok("no negative counts", min(d$injury_collisions) >= 0)
ok("enforcement intensity is zero exactly where no camera",
   all(d$enforcement_intensity[d$cameras_installed == 0] == 0))
ok("fatal is always a small share of injury",
   all(d$fatal_collisions <= d$injury_collisions))
ok("speed limit is consistent with observed speed",
   all(abs(d$speed_limit_kmh - d$baseline_speed_85th) < 40))

cat("\n=== the callbacks to Session 1 ===\n")
cat(sprintf("  before/after in treated sectors: %+.1f%%\n",
            100 * (with(d %>% filter(treated == 1, round == 1),
                        mean(injury_collisions)) /
                   with(d %>% filter(treated == 1, round == 0),
                        mean(injury_collisions)) - 1)))
cat(sprintf("  same period, comparison sectors: %+.1f%%\n",
            100 * (with(d %>% filter(treated == 0, round == 1),
                        mean(injury_collisions)) /
                   with(d %>% filter(treated == 0, round == 0),
                        mean(injury_collisions)) - 1)))
