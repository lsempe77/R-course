# Texts for the Day 1 Session 3 deck that follows the printed worksheet.
# Builds on session3_review.R; the review deck and review worksheet are not changed by this file.
source('session3_review.R', encoding = 'UTF-8')
source('day1_regression_visual.R', encoding = 'UTF-8')

hy3_regression_plot <- function() day1_binary_fit_svg(
  c(mean(s3_wait$cost_after), mean(s3_join$cost_after)),
  c('0 = Control group', '1 = Treatment group'),
  'Lottery assignment indicator',
  'Fitted cost = 1,783 - 1,014 x took_part (rounded AED)')

# The illustrative AI draft printed on page 2 of the worksheet.
hy3_ai <- 'The pilot trial estimated an annual saving of 1,014 AED per business. The trial proves the minimum saving is met. Nationwide rollout is good value for money.'
hy3_prompt <- gsub('Cite H3-A.', 'Cite the pilot trial information.',
  gsub('Use only H3-A:', 'Use only this pilot trial information:', s3_prompt, fixed = TRUE), fixed = TRUE)
hy3_fallback <- gsub('H3-A reports', 'The pilot trial reports', s3_fallback, fixed = TRUE)
stopifnot(!grepl('H3-A', paste(hy3_prompt, hy3_fallback)))
