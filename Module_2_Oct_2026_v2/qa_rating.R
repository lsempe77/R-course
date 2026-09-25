# ===========================================================================
# The QA deep-dive: report sections, their planted strengths and weaknesses,
# and the traffic-light scale.
# ===========================================================================
# Used by BOTH:
#   - Oct15_session1.qmd                     (the deck: reveal slides)
#   - Oct15_session1_rating_sheet.qmd        (the printable rating sheet)
# Defined once so the deck and the handout cannot disagree about what is in the
# report, which matters because the whole exercise is the room finding these.

rating_scale <- data.frame(
  light = c("Green", "Amber", "Red"),
  meaning = c(
    "Credible as it stands. You would rely on this section without further work.",
    "Credible with a specific caveat. Name the caveat and say what would settle it.",
    "Not credible. The problem undermines a claim made in this section."
  ),
  stringsAsFactors = FALSE
)

# One row per report section the room rates, in report order.
rating_sections <- data.frame(
  id = c("summary", "design", "data", "results", "limitations", "conclusions"),
  section = c(
    "1. Executive summary",
    "3. Evaluation design",
    "4. Data",
    "5. Results",
    "6. Limitations",
    "7. Conclusions and recommendations"
  ),
  # What is genuinely good. Deliberately real, so the exercise is not "find the
  # errors" but "separate the good from the weak in the same document".
  strength = c(
    "States the decision threshold up front and reports an estimate against it. The reader knows what is being claimed and by what standard.",
    "Four methods reported with their different target populations named. Most reports of this kind give one number and no way to interrogate it.",
    "Names the outcome, gives sample sizes, and discloses that the survey instrument changed between rounds. Disclosure is the right instinct.",
    "A full table with confidence intervals for every method, plus an annex of robustness specifications. Nothing is hidden in a footnote.",
    "Three limitations stated plainly, and the offer-versus-enrolment and near-the-cut-off points are technically correct.",
    "Recommendations are specific enough to act on, and the first follows from the stated threshold."
  ),
  # The planted defect. Each is answerable from the report itself.
  weakness = c(
    "It claims the programme \u201Cmeets the threshold\u201D and reports \u201Capproximately 1,000\u201D, which is not an estimate any of the four methods produced. The preferred specification, stated later, is 816.",
    "It asserts that parallel trends is \u201Csatisfied by construction\u201D because the neighbourhoods share an administrative area. That is not what the assumption requires, and no pre-trend test is reported.",
    "Twelve per cent attrition is disclosed and then dismissed as \u201Cnormal churn\u201D, with no comparison of leavers to stayers. The instrument change is called a refinement without any test that it did not shift the outcome.",
    "The headline result is the largest of the four estimates, chosen because of the population it covers rather than because the design is stronger. The preferred specification fails the threshold and the report does not say so.",
    "All three are boilerplate that leave the conclusion intact. The two limitations that do threaten it (attrition and the instrument change) are in the data section and never carried through to here.",
    "Recommendations 2 and 3 are not supported by anything in the evaluation: nothing was estimated about subsidy rates, and the cut-off finding is about a different population from the one being scaled up."
  ),
  stringsAsFactors = FALSE
)

# The single most important defect, for the closing reveal.
rating_decisive <- paste0(
  "The results section. Everything else in the report is a symptom of it. ",
  "The headline estimate was selected because it clears the threshold, and the ",
  "one number that fails the threshold is described as the preferred specification ",
  "four sections later. A reader who stops after the executive summary would ",
  "conclude the programme pays for itself. It does not, on the evidence reported here."
)
