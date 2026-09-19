# ===========================================================================
# The QA checklist — single source of truth
# ===========================================================================
# Used by BOTH:
#   - Oct14_session3.qmd              (the clinic deck: slides 5 headline questions)
#   - Oct14_session3_qa_checklist.qmd (the printable handout: full battery)
# Defined once here so the slide and the handout cannot drift apart.
#
# The four domains are the brief's own four areas: methodology, assumptions,
# data quality, conclusions. The comparison questions lead Methodology because
# "compared to what" is the spine of the whole week.

qa_domains <- c(
  "Methodology",
  "Assumptions",
  "Data quality",
  "Conclusions"
)

qa_purpose <- c(
  Methodology   = "Is the design capable of answering the question at all?",
  Assumptions   = "What has to be true, and was it actually tested?",
  `Data quality` = "Where did the numbers come from, and who is missing?",
  Conclusions   = "Does the claim follow, or does it outrun the evidence?"
)

qa_questions <- data.frame(
  domain = c(
    # ---- 1 · Methodology -------------------------------------------------
    rep("Methodology", 5),
    # ---- 2 · Assumptions -------------------------------------------------
    rep("Assumptions", 5),
    # ---- 3 · Data quality ------------------------------------------------
    rep("Data quality", 5),
    # ---- 4 · Conclusions -------------------------------------------------
    rep("Conclusions", 5)
  ),
  question = c(
    "What is the comparison, and how were those units chosen?",
    "What would have happened to the participants without the programme, and how do you know?",
    "Could anyone choose whether to take part, and if so who selected themselves in?",
    "Did anything else change at the same time that could produce this result?",
    "Was the study capable of detecting an effect this size, or was it always going to be inconclusive?",

    "State the one assumption this result rests on, in a single sentence.",
    "What evidence do you have that it holds here, not merely in general?",
    "What did you do to test it, and what would the result look like if it failed?",
    "Which assumption, if it were wrong, would reverse the sign of the finding?",
    "What can this design not tell us, even if every assumption holds?",

    "What exactly was measured, by whom, and how often?",
    "Who is missing from the data, and are they different from those present?",
    "How many units were dropped in preparing the sample, and why?",
    "Could any participant influence the measure, or the rule that decides eligibility?",
    "Is the outcome the one that matters, or a convenient stand-in for it?",

    "Does the headline claim match the size of what was actually estimated?",
    "Does the conclusion depend on a subgroup, a specification, or a period not shown?",
    "What is the confidence interval, and does your decision change across it?",
    "Who benefits and who does not, and is the average hiding a loss somewhere?",
    "If the effect were half this size, would your recommendation still hold?"
  ),
  stringsAsFactors = FALSE
)

# The five that go on the slide. One per area, plus the comparison spine, and
# each phrased so it can be asked out loud of an evaluator in the room.
qa_headline <- c(
  "What is the comparison, and how was it chosen?",
  "What has to be true for this to be causal, and did you test it?",
  "Where did the numbers come from, and who is missing from them?",
  "How big is the effect, and how sure are you of it?",
  "Does the conclusion follow, or does it outrun the evidence?"
)

# A quick lookup used by the deck's sorting exercise.
qa_lookup <- function(q) qa_questions$domain[match(q, qa_questions$question)]
