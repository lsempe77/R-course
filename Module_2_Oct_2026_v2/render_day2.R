# Render the two edited Day 2 decks (S1 DiD, S3 matching) and copy them into the website folder.
# In RStudio: open this file and click Source. Needs R and Quarto (RStudio includes Quarto).
here <- tryCatch(dirname(rstudioapi::getSourceEditorContext()$path), error = function(e) getwd())
if (!file.exists(file.path(here, "Oct13_session1_review.qmd"))) here <- getwd()
setwd(here)
quarto <- Sys.which("quarto")
if (quarto == "") quarto <- Sys.getenv("QUARTO_PATH")
if (quarto == "") stop("Quarto not found. Open the project in RStudio or add Quarto to PATH.")
docs <- normalizePath(file.path(here, "..", "docs"))
for (d in c("Oct13_session1", "Oct13_session3")) {
  src <- paste0(d, "_review.qmd"); out <- paste0(d, "_review.html")
  status <- system2(quarto, c("render", shQuote(src)))
  if (status != 0) stop("Render failed for ", src)
  file.copy(out, file.path(docs, paste0(d, ".html")), overwrite = TRUE)
  file.copy(out, file.path(docs, "preview", out), overwrite = TRUE)
  cat(d, ": rendered", file.size(out), "bytes; copied to docs and docs/preview\n")
}
