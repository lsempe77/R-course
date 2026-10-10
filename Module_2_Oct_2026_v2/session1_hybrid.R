# Values and figures for the Day 1 Session 1 deck that follows the printed worksheet.
# Builds on session1_review.R; the review deck and review worksheet are not changed by this file.
source('session1_review.R', encoding = 'UTF-8')

# Section 1 of the printed worksheet uses ten landfill records in tonnes.
hy_tonnes <- as.numeric(ten$landfill_before)
stopifnot(identical(hy_tonnes, c(3, 4, 5, 5, 6, 7, 7, 8, 9, 46)))
hy_without <- hy_tonnes[-which.max(hy_tonnes)]

hy_dots <- function(remove = FALSE) {
  vals <- if (remove) hy_without else hy_tonnes
  x <- function(v) 60 + v / 50 * 980
  dots <- paste(vapply(seq_along(vals), function(i) {
    yy <- 110 - (i %% 2) * 25
    sprintf('<circle cx="%.1f" cy="%s" r="9" fill="#215a9e"/>', x(vals[i]), yy)
  }, ''), collapse = '')
  axis <- paste(vapply(seq(0, 50, 10), function(v)
    paste0(review_line(x(v), 160, x(v), 170, '#545860'), review_text(x(v), 195, fmt(v), 21, anchor = 'middle')), ''), collapse = '')
  marks <- paste0(
    review_line(x(mean(vals)), 55, x(mean(vals)), 160, '#B8272C', 3),
    review_text(x(mean(vals)) + 9, 42, paste('Mean', fmt(mean(vals), 1)), 23, '#B8272C'),
    review_line(x(median(vals)), 120, x(median(vals)), 160, '#063360', 3, '5 4'),
    review_text(x(median(vals)) - 8, 143, paste('Median', fmt(median(vals), 1)), 21, '#063360', 'end'))
  review_svg(paste0(review_line(60, 160, 1040, 160, '#545860'), axis, dots, marks,
    review_text(550, 239, 'Landfill waste of ten selected businesses (tonnes in one year)', 22, anchor = 'middle')), 260,
    'Landfill tonnes for ten selected businesses with mean and median markers. The horizontal scale is the same with and without the largest record.')
}

# Regression table with the row and column labels printed on the worksheet.
hy_table <- function() {
  ci <- confint(ba_fit); est <- coef(ba_fit); pv <- ba_fit$p.value
  labs <- c('Before GreenWaste', 'After minus before')
  pf <- function(v) if (v < .001) '&lt; 0.001' else fmt(v, 3)
  rows <- paste(vapply(seq_along(est), function(i) paste0('<tr><th>', labs[i], '</th><td>', fmt(est[i]), '</td><td>',
    fmt(ci[i, 1]), ' to ', fmt(ci[i, 2]), '</td><td>', pf(pv[i]), '</td></tr>'), ''), collapse = '')
  paste0('<p class="table-title"><strong>Annual waste cost regression</strong></p>',
    '<p class="caption">The same 4,794 city participant businesses before GreenWaste and 12 months later. The outcome is annual waste management cost, in AED per business. The starting mean and the change are different rows. The intervals allow for each business being measured twice.</p>',
    '<table class="reading-table"><thead><tr><th>Result row</th><th>Coefficient AED</th><th>95% interval AED</th><th>p-value</th></tr></thead><tbody>',
    rows, '</tbody></table>')
}

# AI exercise texts. The prompt carries the table in words, so that it can be typed or pasted into Copilot.
hy_table_text <- paste0(
  'The table (annual waste management cost in AED per business). Before GreenWaste: coefficient 1,432, 95% interval 1,418 to 1,446, p < 0.001. ',
  'After minus before: coefficient -669, 95% interval -684 to -654, p < 0.001.')
hy_ai <- review_ai
hy_prompt <- paste0(
  'Help me read a GreenWaste before-and-after regression table for a director. ',
  'The outcome is annual waste management cost in AED per business, measured before and ',
  '12 months after GreenWaste. The same 4,794 participant businesses were measured twice. ',
  'No comparison businesses that did not receive GreenWaste are included. Our rule is a ',
  'reduction in annual waste management cost of at least 1,000 AED per business per year.\n\n',
  hy_table_text, '\n\n',
  'Ask me any essential clarifying questions before you recommend action. ',
  'Separate the recorded change, the statistical uncertainty, the question of whether GreenWaste ',
  'caused the change, and the importance of the change for our decision. Explain the coefficient, ',
  'the confidence interval and the p-value in plain language. Cite the table for factual claims. ',
  'Do not invent missing evidence, and do not assume the interval describes individual businesses.'
)
hy_fallback <- review_fallback
