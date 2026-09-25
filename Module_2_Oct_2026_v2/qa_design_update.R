# ===========================================================================
# The Evaluation Design Update template — Day 4 Session 3.
# ===========================================================================
# Shared by:
#   - Oct15_session3.qmd                (the deck)
#   - Oct15_session3_design_template.qmd (the printable template)
#
# The outline says teams "return to the evaluation design started in Module 1"
# and add four things. Module 1's design content is the eight conditions for a
# credible impact evaluation (session_5.qmd): intervention, outcomes, problem
# diagnosis, theory of change, dose and duration, counterfactual, data quality,
# data sufficiency. Teams may or may not have a written design to hand, so the
# template OPENS by recapping those eight rather than assuming the document
# exists. That makes the session self-contained without contradicting Module 1.

# Module 1's eight conditions, as the recap. Verbatim in substance from
# session_5.qmd so the two modules do not disagree.
design_conditions <- data.frame(
  condition = c("Intervention", "Outcomes", "Problem diagnosis",
                "Theory of change", "Dose and duration", "Counterfactual",
                "Data quality", "Data sufficiency"),
  recap = c(
    "The programme itself: clearly defined, with a known start and duration, and stated eligibility criteria.",
    "One or more observable, measurable outcomes of interest.",
    "Evidence that the programme addresses a real need and a binding constraint, so that the solution matches the problem.",
    "The causal pathway from inputs to outcomes, with the key assumption at each step.",
    "Enough scope, scale and duration that the intended effect could plausibly appear within the observation window.",
    "A clearly defined counterfactual, made operational by a credible identification strategy.",
    "Reasonably accurate and complete data, with minimal systematic bias.",
    "Enough data to compare outcomes between programme and comparison groups."
  ),
  stringsAsFactors = FALSE
)

# The four additions this session makes. Each carries the Module 2 session it
# comes from, so the pitch can be traced back.
design_additions <- data.frame(
  id = c("present", "cost", "figure", "translate"),
  addition = c("Results presentation plan", "Cost-benefit framework",
               "Data visualisation sketch", "Evidence translation plan"),
  from = c("Day 2 and Day 4 Session 1", "Day 3 Session 1",
           "Day 3 Session 2", "Day 4 Session 2"),
  asks = c(
    "What will you show, to whom, and in what order? Name the one number you will lead with, and say what the reader must not be able to conclude from it.",
    "What is the threshold, what is the estimated benefit per unit per year, over what horizon, and at what discount rate? State which of those choices decides the answer.",
    "Sketch the figure that carries your headline result. Then sketch the same data presented a second way, and say what the second version hides.",
    "Write the headline sentence of your brief, with the number in it, and name the one thing you will state plainly that your evaluation did not establish."
  ),
  stringsAsFactors = FALSE
)

# The five-minute pitch structure, timed.
pitch_structure <- data.frame(
  part = c("The question", "The design", "The four additions", "The main limit",
           "What you want"),
  minutes = c("0:45", "0:45", "2:00", "0:45", "0:45"),
  says = c(
    "The decision this evaluation informs, and the counterfactual you will use.",
    "Why that design identifies the effect, in two sentences and no jargon.",
    "One minute on presentation and costing, one on the figure and the translation.",
    "What your design cannot establish, said first rather than last.",
    "The specific decision or resource you are asking for."
  ),
  stringsAsFactors = FALSE
)
