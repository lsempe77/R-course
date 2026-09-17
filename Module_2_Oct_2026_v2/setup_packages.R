# ---------------------------------------------------------------------------
# Module 2 — one-time package setup
#
# Run this ONCE in RStudio before rendering any session file:
#     source("setup_packages.R")
#
# It checks every package the Module 2 decks need, installs only what is
# missing, and reports anything that failed. Safe to re-run at any time.
# ---------------------------------------------------------------------------

needed <- c(
  "tidyverse",    # dplyr, ggplot2, tibble, tidyr, forcats, stringr
  "gtable",       # ggplot2 dependency — the one that was missing
  "scales",       # axis label formatting (scales::comma)
  "estimatr",     # lm_robust(), clustered standard errors
  "knitr",        # kable()
  "kableExtra",   # kable_styling(), row_spec()
  "qrcode",       # QR for the live Menti poll
  "rmarkdown"     # required by Quarto for R chunks
)

cat("Checking", length(needed), "packages...\n\n")

is_installed <- function(p) requireNamespace(p, quietly = TRUE)
missing <- needed[!vapply(needed, is_installed, logical(1))]

if (length(missing) == 0) {
  cat("All packages already installed.\n")
} else {
  cat("Missing:", paste(missing, collapse = ", "), "\n")
  cat("Installing (this can take a few minutes)...\n\n")
  install.packages(missing, dependencies = TRUE)
}

# ---- Verify: actually load each one, don't just check it exists -------------
# A package can be "installed" but broken if one of its own dependencies is
# missing — which is exactly the gtable/ggplot2 failure. Loading catches that.

cat("\nVerifying each package loads...\n\n")
failed <- character(0)
for (p in needed) {
  ok <- tryCatch({
    suppressPackageStartupMessages(library(p, character.only = TRUE))
    TRUE
  }, error = function(e) {
    cat("  FAILED:", p, "-", conditionMessage(e), "\n")
    FALSE
  })
  if (ok) cat("  ok:", p, "\n") else failed <- c(failed, p)
}

cat("\n")
if (length(failed) == 0) {
  cat("All good. You can now render the session files.\n")
} else {
  cat("Still failing:", paste(failed, collapse = ", "), "\n")
  cat("Try: install.packages(c(\"", paste(failed, collapse = "\",\""),
      "\"), dependencies = TRUE)\n", sep = "")
  cat("If that does not work, restart R (Session > Restart R) and re-run this script.\n")
}
