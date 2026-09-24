# ===========================================================================
# The findings set for the evidence-translation session.
# ===========================================================================
# Shared by:
#   - Oct15_session2.qmd                 (the deck)
#   - Oct15_session2_findings.qmd        (the printable findings pack)
#   - Oct15_session2_brief_template.qmd  (the printable brief template)
#
# This is a DIFFERENT programme from the GreenWaste case study used all week.
# The point of the session is translation, not reading: the room has spent two
# days interrogating one programme, and the risk is that they translate a case
# study they have already memorised. A new programme forces them to read the
# findings first and then write, which is what the job actually involves.
#
# The evaluation is deliberately strong. The session's difficulty is editorial,
# not methodological: every finding here survives the Day 4 Session 1 checklist,
# so nothing can be dismissed, and the room has to decide what matters.

transl_programme <- list(
  name    = "Tariff Shield",
  what    = "A fuel-price stabilisation scheme for small freight operators",
  where   = "Abu Dhabi emirate",
  when    = "Piloted 2024\u20132026",
  rule    = "Commissioning authority's threshold: a net saving of at least 900 AED per vehicle per year"
)

# Each finding carries: what was found, the numbers behind it, how much it can
# bear, and what it does NOT license you to say. The last column is the session.
transl_findings <- data.frame(
  id = c("f1", "f2", "f3", "f4", "f5", "f6"),
  finding = c(
    "Fuel costs fell for participating operators",
    "The saving is real but smaller than the threshold",
    "Operators passed some of the saving to customers",
    "Two-thirds of eligible operators did not join",
    "The scheme's administration cost more than budgeted",
    "No measurable effect on vehicle maintenance or fleet renewal"
  ),
  numbers = c(
    "Net saving of 743 AED per vehicle per year (95% CI: 690 to 796). Statistically significant at conventional levels.",
    "The commissioning authority set a threshold of 900 AED per vehicle per year. The upper bound of the confidence interval, 796 AED, lies below it.",
    "Freight rates charged by participating operators fell by an average of 1.8%, against 0.4% among non-participants. The difference is not statistically significant (p = 0.11).",
    "34% of eligible operators enrolled. Non-participants were more likely to be small fleets and to operate on fixed public-sector contracts.",
    "Administration ran 22% over budget. The overrun is concentrated in verification of fuel purchase records, which required manual inspection in 41% of cases.",
    "Point estimates for both outcomes are close to zero with wide confidence intervals. The evaluation cannot rule out effects of either sign."
  ),
  bears = c(
    "A direct, well-measured effect on the primary outcome, from a randomised allocation of the subsidy.",
    "This is the finding that decides the commissioning decision, and it is stated plainly in the evaluation.",
    "The direction is suggestive, but the estimate is not distinguishable from zero.",
    "A measured participation rate with a described pattern. The evaluation reports it; it does not explain it.",
    "A cost figure from the scheme's own accounts, not an estimate.",
    "A null result with wide intervals. Absence of evidence, and the evaluation says so."
  ),
  does_not_license = c(
    "\u201CThe scheme works.\u201D A saving below the threshold is still below the threshold.",
    "\u201CThe scheme failed.\u201D A shortfall of 157 AED against a threshold is not the same as no effect, and the interval is narrow.",
    "\u201CConsumers benefited.\u201D The estimate is not significant; this is a hypothesis, not a result.",
    "\u201COperators did not want it.\u201D The evaluation measured who did not join, not why.",
    "\u201CThe scheme is badly run.\u201D The overrun is a fact about cost, not about delivery quality.",
    "\u201CThere is no effect.\u201D The intervals are wide enough to contain a meaningful effect in either direction."
  ),
  stringsAsFactors = FALSE
)

# The brief the room must produce. Kept to four elements, per the outline.
brief_elements <- data.frame(
  element = c("Headline finding", "Key implications", "Recommendation", "One risk"),
  asks = c(
    "One sentence, with the number in it, that a non-specialist would understand and would not misread.",
    "Two or three sentences. What follows for the commissioning authority, given what the evaluation did and did not establish.",
    "One specific action. It must be something the authority can actually decide.",
    "The one thing most likely to make this recommendation wrong, stated so that it can be watched."
  ),
  length_guide = c("1 sentence", "2\u20133 sentences", "1 sentence", "1\u20132 sentences"),
  stringsAsFactors = FALSE
)

# The AI draft the room edits. Each flaw is named so the deck can reveal it.
transl_ai_flaws <- c(
  headline = "It opens with the scheme's direction of effect and drops the number, so a reader cannot tell that the saving falls short of the threshold.",
  threshold = "It never mentions the 900 AED threshold at all. The whole commissioning decision turns on it.",
  overstate = "It calls the pass-through to customers a benefit of the scheme. The evaluation says the estimate is not statistically significant.",
  soften = "It describes non-participation as \u201Csome operators chose not to enrol\u201D. A third enrolled, so two-thirds did not.",
  miss = "It omits the administration cost overrun entirely, which is the one finding that bears directly on whether to repeat the scheme."
)
