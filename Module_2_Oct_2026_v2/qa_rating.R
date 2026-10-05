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
    "Credible as it stands. You can trust this section without asking for more information.",
    "Credible, but with one specific concern. Name the concern and say what information would remove that concern.",
    "Not credible. A problem in this section means you cannot trust a claim the section makes."
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
  # Which of yesterday's four checklist areas (qa_checklist.R) to apply.
  area = c(
    "Conclusions",
    "Methodology; Assumptions",
    "Data quality",
    "Methodology; Conclusions",
    "Assumptions; Data quality",
    "Conclusions"
  ),
  # What is genuinely good. Deliberately real, so the exercise is not "find the
  # errors" but "separate the good from the weak in the same document".
  strength = c(
    "States the decision threshold up front and reports an estimate against it. The reader knows what is being claimed and by what standard.",
    "Four methods reported with their different target populations named. Most reports of this kind give one number and no way to interrogate it.",
    "Names the outcome, gives sample sizes, and discloses that the survey instrument changed between rounds. Disclosure is the right instinct.",
    "A full table with confidence intervals for every method, plus an annex of robustness specifications. Nothing is hidden in a footnote.",
    "Three limitations stated plainly, and the offer-versus-enrolment and near-the-cut-off points are technically correct.",
    "Recommendations are specific enough to act on."
  ),
  # The planted defect. Each is answerable from the report itself.
  weakness = c(
    "It claims the programme \u201Cmeets the threshold\u201D and reports \u201Capproximately 1,000\u201D as if all four methods agreed. Only the matched comparison gives 1,000, and the preferred specification gives 816.",
    "It asserts that parallel trends is \u201Csatisfied by construction\u201D because the neighbourhoods share an administrative area. That is not what the assumption requires, and no pre-trend test is reported. The defence is also about the wrong groups: the DiD compares enrolled with non-enrolled businesses inside treatment neighbourhoods, but the argument is about treatment and control neighbourhoods.",
    "Recycling compliance is missing for 8,570 of 19,826 observations, and the gap is put down to \u201Cthe inspection schedule\u201D without saying which businesses are missing. (In the data, it is every ineligible business.) The instrument change is called a refinement without any test that it did not shift the outcome.",
    "The headline result is the largest of the four estimates, chosen because of the population it covers rather than because the design is stronger. The preferred specification fails the threshold and the report does not say so.",
    "All three are boilerplate that leave the conclusion intact. The problems raised in the data section (the instrument change and the unexplained gap in the compliance data) are never carried through to here.",
    "Recommendations 2 and 3 are not supported by anything in the evaluation: nothing was estimated about subsidy rates, and the cut-off finding is about a different population from the one being scaled up."
  ),
  stringsAsFactors = FALSE
)

# The single most important defect, for the closing reveal.
rating_decisive <- paste0(
  "The results section. ",
  "The headline is the one estimate that clears the threshold, and the report ",
  "never says that its own preferred specification, named in Section 3, does not. ",
  "A reader who stops after the executive summary would ",
  "conclude the programme pays for itself. It does not, on the evidence reported here."
)
