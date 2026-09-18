---
title: "Instrumental Variables"
subtitle: "Econometrics with R"
author: "Dr. Lucas Sempé"
always_allow_html: yes
keep-md: true
format: 
  pptx:
    incremental: true  
  revealjs:
    theme: [clean.scss]
    slide-number: true
    code-fold: false
    highlight-style: github
editor_options: 
  chunk_output_type: console
---
## The Challenge of Imperfect Compliance

- Sometimes we can't randomly assign the treatment itself
- But we can randomly assign encouragement to take up the treatment
- Example: National scale-up of the Program means we can't deny eligibility
- But we can randomly promote the program in some industries

**Central question:** How do we measure impact when actual participation is voluntary?


::: {.cell}

:::



## Instrumental Variables Framework

:::: {.columns}

::: {.column width="50%"}
**Instrumental Variable (IV)** must:

1. **Affect participation**: The instrument increases likelihood of enrollment
2. **Exclusion restriction**: The instrument affects outcomes only through enrollment
3. **Independence**: The instrument is as good as randomly assigned
4. **Monotonicity**: The instrument doesn't discourage anyone from enrolling
:::

::: {.column width="50%"}

<!-- ```{mermaid} -->
<!-- %%| label: fig-mermaid -->
<!-- %%| fig-width: 6 -->
<!-- %%| fig-cap: | -->
<!-- %%|   A valid instrument affects the Treatment, and **only** affects the outcomes through the treatment. -->
<!-- flowchart LR -->
<!--   A[Instrument] --> B(Treatment) -->
<!--   A -.-> |No| C(Outcome) -->
<!--   B --> C -->
<!-- ``` -->

:::

::::

## Example Case: Randomized Promotion Design

- The ministry wants to make the program available to all industries
- We design an evaluation with random promotion in some zones of the Emirate
- Promotion includes communication and social marketing
- This creates exogenous variation in enrollment


::: {.cell}

:::


If the promotion is effective, then we should have a higher likelihood of participation in the intervention for those who received it. If we are just interested in the question of whether encouraging enrollment in the project using messages improved our outcomes compared to providing the program without messaging, then we can run the regression for those that randomly received messaging versus those that did not. This is what we learned about randomization so far. 

However, we ideally want an estimate of the program not the messaging, and there also may be some individuals that received the promotion but still didn’t take up the program. This creates selection bias since those that actually take up the program may have higher outcomes to begin with. We want to run our analyses to see if receiving the promotion encouraged participants to take part in the project AND if that participation impacted their crop yields.

How do we do this? In two stages.

## 1. First Stage: Effect of Promotion on Enrollment
:::: {.columns}

::: {.column width="50%"}

In the first stage, we measure the effect of encouragement on participation in program (e.g., how much more likely someone is to participate due to the encouragement).



::: {.cell}

```{.r .cell-code}
# Estimate effect of promotion on enrollment (First Stage)
m_first_stage <- lm_robust(enrolled_rp ~ promotion_zone,
                      clusters = facility_identifier,
                      data = df %>% filter(round == 1))
```
:::



**First Stage Results**:

- Promotion increases enrollment by 40.8 percentage points
- Without promotion, only 8.4% enroll
- With promotion, 49.2% enroll
- Strong first stage (F-statistic > 10): 2552.2

> **What is the F-statistic?**  
> The F-statistic tests whether the instrument (promotion) is a **strong predictor** of the endogenous variable (enrollment).  
> - A **high F-statistic** (greater than 10) suggests the instrument is strong and relevant.  
> - A **low F-statistic** (below 10) would indicate a **weak instrument**, which could bias IV estimates and make them unreliable.
:::

::: {.column width="50%"}

::: {.cell}
::: {.cell-output-display}
`````{=html}
<table style="NAborder-bottom: 0; width: auto !important; margin-left: auto; margin-right: auto;" class="table">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:center;"> Enrollment </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:center;"> 0.084*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (0.004) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> promotion_zone </td>
   <td style="text-align:center;"> 0.408*** </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.008) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 9914 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:center;"> 0.200 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Adj. </td>
   <td style="text-align:center;"> 0.200 </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> + p &lt; 0.1, * p &lt; 0.05, ** p &lt; 0.01, *** p &lt; 0.001</td></tr></tfoot>
</table>

`````
:::
:::

:::

::::

## 2. Intention-to-Treat (ITT) Effect

The second stage is the link between participation on our outcomes of interest. This second stage is the effect of the *encouragement* on the outcome (referred to as the “reduced form”). This is also known as the Intention-to-Treat (ITT) Effect or the effect on outcomes based on the original randomization, regardless of the actual treatment or compliance with the program.


:::: {.columns}

::: {.column width="40%"}

::: {.cell class='small-code'}

```{.r .cell-code}
# Estimate ITT effect (reduced form)
m_itt <- lm_robust(waste_management_costs ~ promotion_zone,
                   clusters = zone_identifier,
                   data = df %>% filter(round == 1))

# With covariate adjustment
m_itt_wcov <- lm_robust(waste_management_costs ~ promotion_zone + 
                        age_manager + age_deputy +
                        female_manager + foreign_owned + 
                        staff_size +
                        advanced_filtration + 
                        facility_area +
                        recycling_center_distance,
                        clusters = zone_identifier,
                        data = df %>% filter(round == 1))
```
:::


**ITT Results**:

- Promotion directly reduces waste management costs by -387 units
- Promotion directly reduces waste management costs
- This is the policy-relevant effect of offering promotion
- But this underestimates the effect on those who actually enroll
:::

::: {.column width="60%"}

::: {.cell}
::: {.cell-output-display}
`````{=html}
<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:400px; overflow-x: scroll; width:700px; "><table style="NAborder-bottom: 0; width: auto !important; margin-left: auto; margin-right: auto; font-size: 13px; margin-left: auto; margin-right: auto;" class="table table">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> No covariate adj. </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> With covariate adj. </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:center;"> 1884.538*** </td>
   <td style="text-align:center;"> 2948.054*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (48.382) </td>
   <td style="text-align:center;"> (71.439) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> promotion_zone </td>
   <td style="text-align:center;"> −387.386*** </td>
   <td style="text-align:center;"> −402.509*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (63.733) </td>
   <td style="text-align:center;"> (52.253) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_manager </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 10.505*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (1.535) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_deputy </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0.461 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (1.691) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> female_manager </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 92.953+ </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (48.965) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> foreign_owned </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −317.771*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (47.308) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> staff_size </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −238.508*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (7.040) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> advanced_filtration </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −323.317*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (31.162) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> facility_area </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 15.568** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (4.790) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> recycling_center_distance </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −0.658 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.526) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 9914 </td>
   <td style="text-align:center;"> 9914 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:center;"> 0.027 </td>
   <td style="text-align:center;"> 0.304 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Adj. </td>
   <td style="text-align:center;"> 0.026 </td>
   <td style="text-align:center;"> 0.304 </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> + p &lt; 0.1, * p &lt; 0.05, ** p &lt; 0.01, *** p &lt; 0.001</td></tr></tfoot>
</table></div>

`````
:::
:::

:::

::::

## 3. Local Average Treatment Effect (LATE)

We still don’t know the effect of the participation on outcomes, which is what we want. To get the estimate of interest (effect of participation on outcomes), we need to divide the “reduced form” (the effect of encouragement on outcomes) by the first stage (effect of encouragement on participation).

:::: {.columns}

::: {.column width="50%"}

::: {.cell}

```{.r .cell-code}
# Estimate LATE using IV regression (2SLS)
m_late <- iv_robust(waste_management_costs ~ enrolled_rp |
                     promotion_zone,
                   clusters = zone_identifier,
                   data = df %>% filter(round == 1))

# With covariate adjustment
m_late_wcov <- iv_robust(waste_management_costs ~ enrolled_rp + 
                         age_manager + age_deputy +
                         female_manager + foreign_owned + 
                         staff_size +
                         advanced_filtration + 
                         facility_area +
                         recycling_center_distance | 
                         promotion_zone + 
                         age_manager + age_deputy +
                         female_manager + foreign_owned + 
                         staff_size +
                         advanced_filtration + facility_area +
                         recycling_center_distance,
                         clusters = zone_identifier,
                         data = df %>% filter(round == 1))
```
:::

:::

::: {.column width="50%"}

::: {.cell}
::: {.cell-output-display}
`````{=html}
<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:300px; overflow-x: scroll; width:600px; "><table style="NAborder-bottom: 0; width: auto !important; margin-left: auto; margin-right: auto; font-size: 15px; margin-left: auto; margin-right: auto;" class="table table">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> No covariate adj. </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> With covariate adj. </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> (Intercept) </td>
   <td style="text-align:center;"> 1964.571*** </td>
   <td style="text-align:center;"> 2938.574*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (47.009) </td>
   <td style="text-align:center;"> (67.184) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> enrolled_rp </td>
   <td style="text-align:center;"> −949.977*** </td>
   <td style="text-align:center;"> −982.878*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (114.223) </td>
   <td style="text-align:center;"> (94.670) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_manager </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 7.304*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (1.406) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_deputy </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −1.031 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (1.671) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> female_manager </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 97.258* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (45.709) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> foreign_owned </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −227.702*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (38.752) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> staff_size </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −202.957*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (6.708) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> advanced_filtration </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −216.624*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (26.332) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> facility_area </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 10.232* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (4.567) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> recycling_center_distance </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −0.335 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (0.468) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Num.Obs. </td>
   <td style="text-align:center;"> 9914 </td>
   <td style="text-align:center;"> 9914 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 </td>
   <td style="text-align:center;"> 0.222 </td>
   <td style="text-align:center;"> 0.405 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> R2 Adj. </td>
   <td style="text-align:center;"> 0.222 </td>
   <td style="text-align:center;"> 0.404 </td>
  </tr>
</tbody>
<tfoot><tr><td style="padding: 0; " colspan="100%">
<sup></sup> + p &lt; 0.1, * p &lt; 0.05, ** p &lt; 0.01, *** p &lt; 0.001</td></tr></tfoot>
</table></div>

`````
:::
:::


**LATE Explanation**:

- Another way of calculating is: LATE = ITT / First Stage = -387 / 0.408 = -950
- Ultimately, we are able to isolate the effect of the program, by using the instrument. What we have now is called the LATE (local average treatment effect) – we have an estimate of an impact that is attributable to the program for those who complied with the promotion.
- This estimates the effect for "compliers": industries that enrolled because of the promotion but would not have enrolled otherwise

:::

::::
## Understanding LATE: The Complier Effect
The IV estimate (LATE) applies to compliers only:

:::: {.columns}
::: {.column width="50%"}
**Types of industries:**

- Always-takers: Enroll regardless of promotion (8%)
- Compliers: Enroll only with promotion (41%)
- Never-takers: Don't enroll regardless of promotion (51%)
- Defiers: Enroll only without promotion (0% by assumption)
:::

::: {.column width="50%"}
**Implications:**

- If treatment effects vary, LATE may not generalize
- External validity depends on how representative compliers are
- Policy relevant if we care about those influenced by promotion
:::
::::

## Key Assumptions of IV

- Relevance: Promotion effectively increases enrollment (✓ Strong first stage)

- Exclusion restriction: Promotion affects outcomes only through enrollment
  - Promotion must not directly affect waste management costs
  - Careful design focused only on awareness, not waste management behaviors

- Independence: Promotion randomly assigned (✓ Baseline balance)

- Monotonicity: Promotion doesn't discourage anyone from enrolling
  - No "defiers" who would enroll only without promotion

## From Analysis to Policy Decision
**Policy question:** Should the program be scaled up nationally?

**Decision criterion:** Program must reduce waste management costs by at least 1,000 AED.

**Results from IV estimation:**

- LATE: -1,033 AED (from our calculation above)
- Point estimate is above the 1,000 AED threshold
- The IV estimate represents the effect on compliers only

**Recommendation:** Based strictly on the estimate, the program should be scaled up nationally.

## IV vs. Randomized Assignment
:::: {.columns}
::: {.column width="50%"}
**IV Estimate:**

- LATE = -1,033 AED
- Effect on compliers only
- Larger standard errors

**Policy recommendation:**
Scale up since above threshold
:::
::: {.column width="50%"}
**Randomized Assignment:**

- ATE = -1,014 AED
- Effect on all eligible facilities
- More precise estimate

**Policy recommendation:**
Scale up nationally
:::
::::
Why the difference?

- Different populations: LATE vs. ATE
- Different precision: IV is less efficient
- Different contexts: National scale-up vs. pilot program

## When to Use Instrumental Variables
Use when:

- Random assignment of the actual treatment is not possible
- You have access to a valid instrument
- Partial compliance is expected
- You focus on the effect for compliers

Common applications:

- Randomized encouragement designs
- Natural experiments (lotteries, policy changes)
- Geographic or administrative discontinuities

## Common Pitfalls in IV Analysis

Weak instruments (First-stage F-statistic < 10):

- Leads to biased estimates and poor inference
- Solution: Find stronger instruments or use weak-IV robust methods

Violation of exclusion restriction:

- Instrument affects outcome through other channels
- Often untestable; requires strong theoretical justification

Heterogeneous treatment effects:

- LATE may not generalize to other populations
- Be careful about policy recommendations

Improper standard errors:

- Remember to cluster standard errors when appropriate
- Use robust methods for inference

## Key Takeaways

- IV addresses selection bias when randomization of treatment isn't possible
- LATE estimates the effect for compliers only
- IV requires strong assumptions, especially exclusion restriction
- The program reduced waste management costs by 1,033 AED for compliers, above the threshold
- IV estimates are less precise than randomized assignment estimates

## Next Session

Regression Discontinuity Design: Exploiting eligibility thresholds to estimate program effects