# ===========================================================================
# The GreenWaste lab: one invented world, every method, one chart
# ===========================================================================
# Used by the method sessions (Oct12 S3, Oct13 S1-S3, Oct14 S3). Each deck
# lists this file under `webr: resources` and sources it in its hidden setup
# cell, then calls lab() from a slide with sliders. Base R only, so it runs in
# a second in the browser.
#
# The world is GreenWaste-shaped and invented: 20,000 businesses in 800
# neighbourhoods, half the neighbourhoods drawn by lottery, eligibility at an
# efficiency index of 58 or below, costs measured before and after. Because it
# is invented we know the true effect: the programme cuts costs by 900 AED for
# every business that takes part. Each slider switches on one problem, and the
# chart shows which estimates it pushes away from the truth:
#
#   trend     costs rise for everyone between rounds   breaks before-and-after
#   size_gap  joiners are smaller (measured)            breaks with-and-without
#   hidden    joiners differ in something unmeasured     breaks with-and-without, matching
#   diverge   joiners' costs were already falling faster breaks DiD (and the naive ones, matching)
#   jump      something else changes at 58               breaks RDD (and with-and-without, matching)
#
# The measured and unmeasured differences grow smoothly as the index falls, so
# they open a gap between the groups without a step at the cut-off (which is
# what the RDD assumes).
#
# The randomised comparison survives all five.

LAB_TRUTH <- -900
LAB_RULE  <- -1000
LAB_LABEL <- c(before_after = "Before and after", with_without = "With and without",
               randomised = "Randomised", did = "Difference-in-differences",
               rdd = "Regression discontinuity", matching = "Matching")

local({
  set.seed(2026)
  n_nb <- 800; per <- 25; n <- n_nb * per
  nb <- rep(seq_len(n_nb), each = per)
  drawn <- sample(n_nb, n_nb / 2)
  index <- runif(n, 20, 100)
  LAB_BASE <<- data.frame(
    offered  = nb %in% drawn,
    index    = index,
    eligible = index <= 58,
    size_raw = rnorm(n),          # staff size, standardised (measured)
    u_raw    = rnorm(n),          # motivation, say (never measured)
    e0 = rnorm(n, 0, 150), e1 = rnorm(n, 0, 150))
  LAB_BASE$enrolled <<- LAB_BASE$offered & LAB_BASE$eligible
})

# Build the two rounds for a given set of problems (all in AED).
lab_world <- function(trend = 0, size_gap = 0, hidden = 0, diverge = 0, jump = 0) {
  d <- LAB_BASE
  g <- (80 - d$index) / 38                 # about 1 for joiners, about 0 for the rest, smooth at 58
  d$size <- d$size_raw - g * size_gap / 200
  u      <- d$u_raw    - g * hidden / 200
  base   <- 1800 + 200 * d$size + 200 * u - jump * d$eligible
  d$y0 <- base + d$e0
  d$y1 <- base + trend - diverge * g +
          LAB_TRUTH * d$enrolled + d$e1
  d
}

# Each method's estimate of the effect on costs after the programme.
lab_estimates <- function(d, models = names(LAB_LABEL)) {
  off <- d[d$offered, ]
  est <- list(
    before_after = function() mean(d$y1[d$enrolled] - d$y0[d$enrolled]),
    with_without = function() mean(off$y1[off$enrolled]) - mean(off$y1[!off$enrolled]),
    randomised   = function() mean(d$y1[d$eligible & d$offered]) - mean(d$y1[d$eligible & !d$offered]),
    did = function() mean(off$y1[off$enrolled] - off$y0[off$enrolled]) -
                     mean(off$y1[!off$enrolled] - off$y0[!off$enrolled]),
    rdd = function() {
      w <- off[abs(off$index - 58) <= 8, ]
      w$dist <- w$index - 58
      coef(lm(y1 ~ eligible * dist, data = w))[["eligibleTRUE"]]
    },
    matching = function() {                 # nearest neighbour on measured size
      tr <- off[off$enrolled, ]; co <- off[!off$enrolled, ]
      co <- co[order(co$size), ]
      k  <- findInterval(tr$size, co$size, all.inside = TRUE)
      k  <- ifelse(abs(co$size[k + 1] - tr$size) < abs(co$size[k] - tr$size), k + 1, k)
      mean(tr$y1 - co$y1[k])
    })
  sapply(models, function(m) est[[m]]())
}

# The slide: estimates against the truth and the rule, plus one line per model.
lab <- function(models, trend = 0, size_gap = 0, hidden = 0, diverge = 0, jump = 0) {
  e <- lab_estimates(lab_world(trend, size_gap, hidden, diverge, jump), models)
  k <- length(e); y <- rev(seq_len(k))
  muted <- "#545860"; accent <- "#215a9e"; alert <- "#B8272C"
  par(mar = c(4.2, 13, 2.2, 1), family = "sans", las = 1, cex = 1.15,
      col.axis = muted, col.lab = muted, fg = muted)
  lim <- c(-3200, 300)
  plot(NA, xlim = lim, ylim = c(0.5, k + 0.5), xaxt = "n", yaxt = "n", bty = "n",
       xlab = "Estimated effect on costs (AED)", ylab = "")
  ticks <- seq(-3200, 0, by = 400)
  axis(1, at = ticks, labels = format(ticks, big.mark = ","))
  axis(2, at = y, labels = LAB_LABEL[models], tick = FALSE)
  abline(v = LAB_TRUTH, col = muted, lwd = 3)
  abline(v = LAB_RULE, col = alert, lwd = 2, lty = 2)
  mtext("true effect -900", side = 3, at = LAB_TRUTH, col = muted, cex = 0.85, adj = -0.05, line = 0.3)
  mtext("rule -1,000", side = 3, at = LAB_RULE, col = alert, cex = 0.85, adj = 1.05, line = 0.3)
  off_by <- e - LAB_TRUTH
  bad <- abs(off_by) > 100
  x <- pmin(pmax(e, lim[1]), lim[2])
  segments(LAB_TRUTH, y, x, y, col = ifelse(bad, alert, accent), lwd = 3)
  points(x, y, pch = 19, cex = 2.2, col = ifelse(bad, alert, accent))
  text(x, y, format(round(e), big.mark = ","),
       pos = ifelse(bad & e < LAB_TRUTH, 2, 4), offset = 1.1, cex = 0.95,
       col = ifelse(bad, alert, muted), xpd = NA)
  invisible(e)
}
