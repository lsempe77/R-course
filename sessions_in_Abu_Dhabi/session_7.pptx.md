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
- Example: National scale-up of Program means we can't deny eligibility
- But we can randomly promote the program in some industries

**Central question:** How to measure impact when actual participation is voluntary?


::: {.cell}

:::



## Instrumental Variables Framework

:::: {.columns}

::: {.column width="50%"}
**Instrumental variable (IV)** must:

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

- The ministry wants to make the Programm available to all industries
- We design an evaluation with random promotion in some zones of the Emirate
- Promotion includes communication and social marketing
- This creates exogenous variation in enrollment


::: {.cell}

:::


## 1. First Stage: Effect of Promotion on Enrollment
:::: {.columns}

::: {.column width="50%"}


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

- Promotion directly reduces waste management costs by -3874 units
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
   <td style="text-align:center;"> 18845.381*** </td>
   <td style="text-align:center;"> 29480.538*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (483.823) </td>
   <td style="text-align:center;"> (714.386) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> promotion_zone </td>
   <td style="text-align:center;"> −3873.860*** </td>
   <td style="text-align:center;"> −4025.088*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (637.332) </td>
   <td style="text-align:center;"> (522.531) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_manager </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 105.055*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (15.353) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_deputy </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 4.606 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (16.912) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> female_manager </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 929.526+ </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (489.650) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> foreign_owned </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −3177.705*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (473.076) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> staff_size </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −2385.077*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (70.400) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> advanced_filtration </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −3233.169*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (311.621) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> facility_area </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 155.682** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (47.898) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> recycling_center_distance </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −6.575 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (5.258) </td>
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
   <td style="text-align:center;"> 19645.713*** </td>
   <td style="text-align:center;"> 29385.742*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (470.093) </td>
   <td style="text-align:center;"> (671.841) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> enrolled_rp </td>
   <td style="text-align:center;"> −9499.769*** </td>
   <td style="text-align:center;"> −9828.779*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;"> (1142.234) </td>
   <td style="text-align:center;"> (946.697) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_manager </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 73.042*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (14.061) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> age_deputy </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −10.314 </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (16.713) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> female_manager </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 972.575* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (457.095) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> foreign_owned </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −2277.024*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (387.516) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> staff_size </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −2029.566*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (67.079) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> advanced_filtration </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −2166.238*** </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (263.325) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> facility_area </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 102.324* </td>
  </tr>
  <tr>
   <td style="text-align:left;">  </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> (45.673) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> recycling_center_distance </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> −3.355 </td>
  </tr>
  <tr>
   <td style="text-align:left;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px">  </td>
   <td style="text-align:center;box-shadow: 0px 1.5px"> (4.678) </td>
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

- Another way of calculating is: LATE = ITT / First Stage = -3874 / 0.408 = -9500
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

**Decision criterion:** Program must reduce waste management costs by at least $10,000.

**Results from IV estimation:**

- LATE: -$9,496 (from our calculation above)
- Point estimate is below the $10,000 threshold
- The IV estimate represents the effect on compliers only

**Recommendation:** Based strictly on the estimate, the program should not be scaled up nationally. However, the estimate is very close to the threshold.

## IV vs. Randomized Assignment
:::: {.columns}
::: {.column width="50%"}
**IV Estimate:**

LATE = -$9,496
Effect on compliers only
Larger standard errors

**Policy recommendation:**
Do not scale up (but close to threshold)
:::
::: {.column width="50%"}
**Randomized Assignment:**

ATE = -$10,140
Effect on all eligible facilities
More precise estimate

**Policy recommendation:**
Scale up nationally
:::
::::
Why the difference?

Different populations: LATE vs. ATE
Different precision: IV is less efficient
Different contexts: National scale-up vs. pilot program

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
- The program reduced waste management costs by $9,496 for compliers, slightly below the threshold
- IV estimates are less precise than randomized assignment estimates

## Next Session

Regression Discontinuity Design: Exploiting eligibility thresholds to estimate program effects