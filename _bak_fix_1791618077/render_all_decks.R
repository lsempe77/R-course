# ===========================================================================
# Render all twelve decks and publish them to ../docs/
# ===========================================================================
#   setwd(".../R-course/Module_2_Oct_2026_v2")   # or open R course.Rproj, then setwd("Module_2_Oct_2026_v2")
#   source("render_all_decks.R")
#
# Renders each deck in place (rendering straight into docs/ fails on the
# OneDrive path), then moves the .html into ../docs/. Only the HTML formats
# are rendered, so the pptx versions are skipped. Afterwards: commit and push.
# To render just some decks, shorten `decks` below.
#
# Uses the Quarto program that comes with RStudio (the same one the Render
# button uses), so the quarto R package is not needed.

stopifnot(file.exists("Oct12_session2.qmd"), dir.exists("../docs"))

# ---- find the Quarto program -------------------------------------------------
find_quarto <- function() {
  cands <- c(Sys.getenv("QUARTO_PATH"), Sys.which("quarto"),
             "C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe",
             "C:/Program Files/Posit/RStudio/resources/app/bin/quarto/bin/quarto.exe",
             "C:/Program Files/Quarto/bin/quarto.exe",
             file.path(Sys.getenv("LOCALAPPDATA"), "Programs/Quarto/bin/quarto.exe"),
             file.path(Sys.getenv("LOCALAPPDATA"), "Programs/RStudio/resources/app/bin/quarto/bin/quarto.exe"))
  cands <- cands[nzchar(cands) & file.exists(cands)]
  if (!length(cands)) stop("Could not find Quarto. In RStudio, run Sys.getenv('QUARTO_PATH') and set QUARTO below to that path.")
  normalizePath(cands[1])
}
QUARTO <- find_quarto()
message("Using Quarto at: ", QUARTO)

decks <- c("Oct12_session1_live", "Oct12_session2", "Oct12_session3_live",
           "Oct13_session1", "Oct13_session2_live", "Oct13_session3",
           "Oct14_session1_live", "Oct14_session2", "Oct14_session3_live",
           "Oct15_session1", "Oct15_session2_live", "Oct15_session3")
plain <- c("Oct15_session1", "Oct15_session3")   # the two non-live decks

failed <- c()
for (d in decks) {
  fmt <- if (d %in% plain) "revealjs" else "live-revealjs"
  message("\nRendering ", d, " ...")
  status <- system2(QUARTO, c("render", shQuote(paste0(d, ".qmd")), "--to", fmt))
  if (identical(status, 0L) && file.exists(paste0(d, ".html"))) {
    file.copy(paste0(d, ".html"), file.path("../docs", paste0(d, ".html")), overwrite = TRUE)
    file.remove(paste0(d, ".html"))
    message("Published: ", d)
  } else {
    message("FAILED: ", d)
    failed <- c(failed, d)
  }
}
if (length(failed)) message("\nCheck these: ", paste(failed, collapse = ", ")) else message("\nAll ", length(decks), " decks published to ../docs/. Now commit and push.")
