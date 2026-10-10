"""Plain-language comments for the eight course trainer calculations."""
import re
COMMENTS = {
"change <- tp$cost_after - tp$cost_before": "# Find each business's change in annual waste cost (AED).",
"data.frame(Result = 'After minus before', AED = round(mean(change)))": "# Show the average change, rounded to whole AED.",
"draw <- draw + 1": "# Make a new lottery draw each time the trainer runs this.",
"group <- sample(rep(c('Join', 'Wait'), each = 10))": "# Randomly give 10 businesses a place and 10 a wait-list place.",
"group_ages(group)": "# Compare their manager ages: a balance check, not an effect.",
"round(mean(change[joined]) - mean(change[!joined]))": "# Compare the cost change in participants with the change in others.\n# This is the extra change, in AED; read the comparison assumptions.",
"fit <- lm(cost_after ~ below * distance, data = near)": "# Compare waste costs just below and above the score rule.\n# Allow costs to slope differently on either side.",
"round(coef(fit)['below'])": "# Show the estimated jump at the rule, in whole AED.",
"round(matched_difference())": "# Pair businesses using the four recorded characteristics.\n# Show participant cost minus matched comparison cost, in AED.",
"round(benefits / cost, 2)": "# Divide modelled benefits at today's value by the included cost.\n# Show the ratio to two decimal places; assumptions still matter.",
"total_fall <- 100 * (1 - sum(tp$landfill_after) /": "# Compare total landfill tonnes after GreenWaste with the total before.",
"round(total_fall, 1)": "# Show the percentage fall, rounded to one decimal place.",
"fit <- lm(cost_after ~ took_part, data = pilot)": "# Compare annual waste costs in the pilot lottery groups.",
"limits <- confint(fit)['took_part', ]": "# Find the 95% interval for their cost difference (AED).",
"sort(round(-unname(limits)))": "# Turn the cost difference into saving; show lower then upper limit."
}
def annotate_deck(text):
 def replace(match):
  body=match[1]
  if 'include: false' in body or any(comment.split('\n')[0] in body for comment in COMMENTS.values()):return match[0]
  lines=[]
  for line in body.rstrip().splitlines():
   if line in COMMENTS:lines.append(COMMENTS[line])
   lines.append(line)
  return '```{webr}\n'+ '\n'.join(lines)+'\n```'
 return re.sub(r'```\{webr\}\n(.*?)```',replace,text,flags=re.S)
