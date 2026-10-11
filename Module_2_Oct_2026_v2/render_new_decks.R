# ===========================================================================
# Render every preview deck, worksheet and handout changed on 11 October 2026
# ===========================================================================
#   setwd(".../R-course/Module_2_Oct_2026_v2")
#   source("render_new_decks.R")
#
# Finds Quarto itself, renders each file in place (rendering straight into docs/
# fails on the OneDrive path), then moves the .html into ../docs/preview/.
# It does not touch the live decks in ../docs/ and does not run switch_session.py.
# The old version of this script is in backups/preview_fix_2026_10_11/.
# To render fewer files, delete entries from `todo` below.

stopifnot(file.exists("Oct13_session2_review.qmd"))
dir.create("../docs/preview", showWarnings = FALSE, recursive = TRUE)

find_quarto <- function() {
  cands <- c(Sys.getenv("QUARTO_PATH"), Sys.which("quarto"),
             "C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe",
             "C:/Program Files/Posit/RStudio/resources/app/bin/quarto/bin/quarto.exe",
             "C:/Program Files/Quarto/bin/quarto.exe",
             file.path(Sys.getenv("LOCALAPPDATA"), "Programs/Quarto/bin/quarto.exe"),
             file.path(Sys.getenv("LOCALAPPDATA"), "Programs/RStudio/resources/app/bin/quarto/bin/quarto.exe"))
  cands <- cands[nzchar(cands) & file.exists(cands)]
  if (!length(cands)) stop("Could not find Quarto. Run Sys.getenv('QUARTO_PATH') in RStudio and set QUARTO_PATH to that path.")
  normalizePath(cands[1])
}
QUARTO <- find_quarto()
message("Using Quarto at: ", QUARTO)

# name = output format named in the file's YAML (NULL = default html)
todo <- list(
  # Decks
  Oct12_session1_review = "live-revealjs",   # Day 1 S1: slide Q-reference
  Oct12_session3_review = "live-revealjs",   # Day 1 S3: Q1 (a) wording
  Oct13_session1_review = "live-revealjs",   # Day 2 S1: slide 7 code, slide 12 labels
  Oct13_session2_review = "live-revealjs",   # Day 2 S2: language pass
  Oct13_session3_review = "live-revealjs",   # Day 2 S3: Q4 and Q5 references
  Oct14_session1_review = "live-revealjs",   # Day 3 S1: Q4 reference
  Oct14_session3_review = "live-revealjs",   # Day 3 S3: language pass
  Oct15_session1_review = "revealjs",        # Day 4 S1: language pass
  Oct15_session2_review = "revealjs",        # Day 4 S2: language pass
  # Worksheets, cards and source pages
  Oct13_session2_review_worksheet = NULL,
  Oct13_session2_review_cards = NULL,
  Oct14_session3_review_worksheet = NULL,
  Oct15_session1_review_worksheet = NULL,
  Oct15_session1_review_report = NULL,
  Oct15_session2_review_worksheet = NULL,
  Oct15_session2_review_findings = NULL
)

failed <- c()
for (d in names(todo)) {
  message("\nRendering ", d, " ...")
  fmt <- todo[[d]]
  args <- c("render", shQuote(paste0(d, ".qmd")), if (!is.null(fmt)) c("--to", fmt))
  status <- system2(QUARTO, args)
  out <- paste0(d, ".html")
  if (identical(status, 0L) && file.exists(out)) {
    file.copy(out, file.path("../docs/preview", out), overwrite = TRUE)
    file.remove(out)
    message("Moved to docs/preview: ", d)
  } else {
    message("FAILED: ", d); failed <- c(failed, d)
  }
}
if (length(failed)) {
  message("\nCheck these: ", paste(failed, collapse = ", "))
} else {
  message("\nAll files are in ../docs/preview/. Open them to check, then commit and push.")
}
