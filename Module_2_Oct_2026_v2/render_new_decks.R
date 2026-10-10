# ===========================================================================
# Render the new Day 1 files and the four wording-pass decks
# ===========================================================================
#   setwd(".../R-course/Module_2_Oct_2026_v2")
#   source("render_new_decks.R")
#
# Same method as render_review_decks.R (finds Quarto itself, renders in place).
# Part 1 renders the Day 1 files and leaves the .html beside the .qmd, because
#   review_2026_10_06/switch_session.py reads them from here.
# Part 2 renders the four wording-pass decks and moves each .html into ../docs/.
# When it finishes, run (from this folder, in PowerShell or the RStudio Terminal):
#   python review_2026_10_06/switch_session.py status
#   python review_2026_10_06/switch_session.py apply d1s1 d1s2 d1s3

stopifnot(file.exists("Oct12_session1_hybrid.qmd"))

find_quarto <- function() {
  cands <- c(Sys.getenv("QUARTO_PATH"), Sys.which("quarto"),
             "C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe",
             "C:/Program Files/Posit/RStudio/resources/app/bin/quarto/bin/quarto.exe",
             "C:/Program Files/Quarto/bin/quarto.exe",
             file.path(Sys.getenv("LOCALAPPDATA"), "Programs/Quarto/bin/quarto.exe"),
             file.path(Sys.getenv("LOCALAPPDATA"), "Programs/RStudio/resources/app/bin/quarto/bin/quarto.exe"))
  cands <- cands[nzchar(cands) & file.exists(cands)]
  if (!length(cands)) stop("Could not find Quarto. Run Sys.getenv('QUARTO_PATH') in RStudio and set QUARTO to that path.")
  normalizePath(cands[1])
}
QUARTO <- find_quarto()
message("Using Quarto at: ", QUARTO)

# name = output format named in the file's YAML (NULL = default html)
part1 <- list(Oct12_session1_hybrid = "live-revealjs",
              Oct12_session2_review = "revealjs",
              Oct12_session2_review_worksheet = NULL,
              Oct12_session2_review_cards = NULL,
              Oct12_session3_hybrid = "live-revealjs")
part2 <- list(Oct13_session2_live = "live-revealjs",
              Oct14_session3_live = "live-revealjs",
              Oct15_session1 = "revealjs",
              Oct15_session2_live = "revealjs")

failed <- c()
render_one <- function(d, fmt, to_docs) {
  message("\nRendering ", d, " ...")
  args <- c("render", shQuote(paste0(d, ".qmd")), if (!is.null(fmt)) c("--to", fmt))
  status <- system2(QUARTO, args)
  out <- paste0(d, ".html")
  if (identical(status, 0L) && file.exists(out)) {
    if (to_docs) { file.copy(out, file.path("../docs", out), overwrite = TRUE); file.remove(out); message("Moved to docs: ", d) }
    else message("Rendered: ", d)
  } else { message("FAILED: ", d); failed <<- c(failed, d) }
}
for (d in names(part1)) render_one(d, part1[[d]], FALSE)
for (d in names(part2)) render_one(d, part2[[d]], TRUE)

if (length(failed)) {
  message("\nCheck these: ", paste(failed, collapse = ", "), "\nDo not run apply until they render.")
} else {
  message("\nAll rendered. Open the decks to check them (live decks need quarto preview, see HANDOFF.md), then run switch_session.py apply.")
}
