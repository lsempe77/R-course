suppressPackageStartupMessages({
  library(tidyverse)
  library(plotly)
})

# The p-value demo from the session, unchanged across the three probes, so the
# only difference the eye sees is the theme.
set.seed(2026)
half <- 120
grp  <- rep(c("Comparison", "Programme"), each = half)
y    <- 60 + rnorm(2 * half, 0, 7)
y    <- y + (2.1 - (mean(y[grp == "Programme"]) -
                    mean(y[grp == "Comparison"]))) * (grp == "Programme")

perm <- replicate(1000, {
  i <- sample(2 * half)
  mean(y[i][1:half]) - mean(y[i][(half + 1):(2 * half)])
})

p_val  <- mean(abs(perm) >= 2.1)
p_bins <- seq(floor(min(perm) * 4) / 4, ceiling(max(perm) * 4) / 4, by = 0.25)
p_h0   <- hist(perm, breaks = p_bins, plot = FALSE)

p_tbl  <- tibble(mid = p_h0$mids, n = p_h0$counts)
p_ymax <- max(p_h0$counts) * 1.18
p_lo   <- min(perm)
p_hi   <- max(perm)
