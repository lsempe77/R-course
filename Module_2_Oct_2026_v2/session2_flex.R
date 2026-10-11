# Worksheet-neutral version of the live Day 1 Session 2 deck.
# Same data and figures as session2_review.R. Table titles and AI texts lose their worksheet codes
# (H2-A1, H2-A2), so that the slides make sense whether the new worksheet or the old sheets were printed.
source('session2_review.R', encoding = 'UTF-8')

s2_table_with_codes <- s2_table
s2_table <- function(rows = FALSE) sub('H2-A[12]: ', '', s2_table_with_codes(rows))

s2_neutral <- function(x) gsub('H2-A2', 'the table of mean costs by group', x, fixed = TRUE)
s2_prompt <- s2_neutral(s2_prompt)
s2_ai <- s2_neutral(s2_ai)
s2_fallback <- s2_neutral(s2_fallback)
