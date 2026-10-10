# ===========================================================================
# Render the REVIEW (preview) decks and handouts to ../docs/preview/
# ===========================================================================
#   setwd(".../R-course/Module_2_Oct_2026_v2")
#   source("render_review_decks.R")
#
# Same idea as render_all_decks.R, but for the *_review files. It never touches the
# live decks in ../docs/. Each file is rendered in place (rendering straight into
# docs/ fails on the OneDrive path) and the .html is then moved to ../docs/preview/.
# To render only some files, shorten `files` or `decks` below.

stopifnot(file.exists("Oct12_session2_review.qmd"))
dir.create("../docs/preview", showWarnings = FALSE, recursive = TRUE)

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

# Decks: the format is the one named in each file's YAML.
decks <- c(Oct12_session1_review = "live-revealjs", Oct12_session2_review = "revealjs",
           Oct12_session3_review = "live-revealjs", Oct13_session1_review = "live-revealjs",
           Oct13_session3_review = "live-revealjs", Oct14_session1_review = "live-revealjs",
           Oct14_session2_review = "live-revealjs")
# Handouts, cards and slips use the default html format.
files <- c("Oct12_session1_review_worksheet", "Oct12_session2_review_worksheet", "Oct12_session2_review_cards",
           "Oct12_session3_review_worksheet", "Oct12_session3_review_slips",
           "Oct13_session1_review_worksheet", "Oct13_session3_review_worksheet", "Oct13_session3_review_cards",
           "Oct14_session1_review_worksheet", "Oct14_session1_review_cards", "Oct14_session2_review_worksheet",
           "AI_good_practice_review")

todo <- c(setNames(rep(list(NULL), length(files)), files), as.list(decks))
failed <- c()
for (d in names(todo)) {
  message("\nRendering ", d, " ...")
  args <- c("render", shQuote(paste0(d, ".qmd")), if (!is.null(todo[[d]])) c("--to", todo[[d]]))
  status <- system2(QUARTO, args)
  out <- paste0(d, ".html")
  if (identical(status, 0L) && file.exists(out)) {
    file.copy(out, file.path("../docs/preview", out), overwrite = TRUE)
    file.remove(out)
    message("Copied to docs/preview: ", d)
  } else {
    message("FAILED: ", d); failed <- c(failed, d)
  }
}
if (length(failed)) message("\nCheck these: ", paste(failed, collapse = ", ")) else message("\nAll files are in ../docs/preview/. Open them to check, then commit and push.")
