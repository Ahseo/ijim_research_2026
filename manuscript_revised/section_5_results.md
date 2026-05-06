# Section 5. Results (Revised)

> 변경 매핑: R1-Minor-2, R1-4, AE-2, R2-6, R2-7, R2-8, R2-9 (changelog.md 참고)

---

## 5.1 AI impact on labor outcomes and within-platform inequality

### 5.1.1 Average and heterogeneous productivity effects

Table 4 reports the DID and DDD estimates for daily productivity (orders/hour). The DID coefficient on $\text{After} \cdot \text{Treat}$ is **0.141 \*\*\* (SE 0.047, $p = 0.005$)**, indicating that AI adoption raises average daily productivity by approximately 3.0% relative to the sample mean of 4.69 orders/hour. The DDD specification reveals the underlying heterogeneity: medium-proficiency riders gain **0.249 \*\*\* (SE 0.066, $p < 0.001$)**, equivalent to a 5.4% increase relative to the sample mean, whereas neither low-proficiency riders (0.088, SE 0.071, $p = 0.22$) nor high-proficiency riders (0.067, SE 0.084, $p = 0.42$) show a statistically significant gain. The pairwise test for the medium-versus-others contrast on log productivity yields **$p = 0.026$** (joint test on log-transformed daily productivity), confirming that the medium-proficiency gain is statistically distinguishable from the low- and high-proficiency effects (`output/tables/14_pairwise_tests.csv`; the corresponding linear-outcome test gives a closely comparable $p = 0.039$).

### 5.1.2 Stack- and day-level mechanisms

Tables 5 and 6 unpack the channels through which AI assignment affects productivity. At the **stack level** (Table 5), AI adoption enables both low- and medium-proficiency riders to operate **longer stacks** — that is, to handle more orders within a continuous trip. For low-proficiency riders, the per-stack number of orders rises by 0.142 \*\* (Table 5, col. 1), but the stack-completion time also lengthens by 1.091 \* minutes (Table 5, col. 2), yielding no improvement in time per order (0.008, NS). Medium-proficiency riders, by contrast, exhibit a similar increase in stack size (0.133 \*) without the corresponding lengthening of stack duration (0.523, NS), translating into a **shorter time per order within a stack** (-0.229 \*\*). High-proficiency riders show no statistically significant change on either dimension, consistent with their already operating near the operational frontier. Idle time between stacks (Table 5, col. 4) reveals a striking divergence: low-proficiency riders' between-stack idle time *increases* by 0.566 \*\* minutes, while medium-proficiency riders' *decreases* by 0.583 \*\* — that is, medium-proficiency riders both stack more efficiently *and* recover more quickly between stacks.

At the **day level** (Table 6), AI adoption is associated with significant increases in daily total orders for both low-proficiency (2.060 \*\*) and medium-proficiency riders (2.086 \*\*), with no significant change for high-proficiency riders (-0.164, NS). Daily total earnings track the same pattern (4.384 \*\*, 4.409 \*, -0.205 NS for low, medium, and high, respectively). Daily working hours, however, increase only for low-proficiency riders (0.438 \*) and remain unchanged for medium- and high-proficiency riders. The combination — more orders *with* longer hours for low-proficiency riders, more orders *without* longer hours for medium-proficiency riders — explains why the productivity gain (orders per hour) is concentrated among medium-proficiency riders. **[R1-Minor-3]**

### 5.1.3 Direct inequality metrics

To quantify how the productivity distribution changes around the AI rollout, we compute direct inequality measures (Table A10, Figure A3). Using rider-level mean productivity within each period, we compute the Gini index, Theil index, P90/P10 ratio, and P75/P25 ratio separately for treated and control riders, before and after the rollout. **[R1-Minor-2]** The DiD-on-inequality estimate (treated change minus control change) yields a Gini reduction of **−0.005**, a Theil reduction of **−0.002**, and a P90/P10 reduction of **−0.099** for the treated group relative to control. While the absolute compression is modest, the *direction* — productivity dispersion compressing among the treated — is consistent with the DDD finding that the medium-proficiency mass shifts upward without a corresponding shift at the tails. We deliberately avoid claiming a "social-equality" effect; the appropriate interpretation is that AI assignment compresses the *observed productivity distribution among matched/treated riders* within this one-month window.

## 5.2 AI impact on customer service quality

### 5.2.1 Estimand and main results

Table 7 reports the customer-side estimates. We emphasize that our customer-side estimand is **the change in waiting time for customers served by treated/matched riders**, not platform-level consumer welfare. **[R1-4]** Equilibrium effects across all customers — through changes in non-treated riders' behavior, demand reallocation, or station-level supply shifts — are not identified by our matched design and would require additional aggregate evidence beyond the matched sample.

Within this estimand, the average customer waiting time does not change significantly (DID coefficient = -0.025, SE 0.084, $p = 0.76$). Decomposing by stack type, however, single-order deliveries become **0.184 \*\* minutes shorter** (SE 0.085, $p = 0.03$), while stacked-order deliveries show no significant change (0.084, SE 0.095, $p = 0.38$). The DDD on single-order waiting reveals that this gain is concentrated among medium-proficiency riders (-0.260 \*\*) — the same group that drives the productivity gain.

We interpret this pattern as **conditional consumer benefit**: customers benefit when the rider is delivering a single order, but the benefit dissipates when the rider is stacking. We deliberately avoid framing this finding as "AI improves customer service" or "single-order waiting time improved" as a headline result, because the average effect is not significant and the heterogeneity itself is the substantive contribution. The absence of an average waiting-time effect — despite worker-side productivity gains — reflects the boundary condition discussed in Section 1: AI optimizes the *match* but not the *downstream stacking and sequencing* under which most stacked-customer deliveries are completed.

### 5.2.2 Worker–customer linkage

To clarify the channel between worker productivity and customer waiting time, we report a stack-level **linkage** regression (`code/11_worker_customer_linkage.R`). Within the matched sample, stack-level productivity — orders per hour within a stack — is associated with shorter customer waiting time (coefficient -1.13 \*\*\*), and the linkage is stronger for single-order stacks (-1.56 \*\*\*) than for stacked-order stacks (-0.98 \*\*\*). **[AE-2]** We report this analysis as a *linkage* rather than a formal mediation analysis: the conditional association is informative about the channel, but we do not claim to identify the share of the customer-side change that is causally mediated by worker productivity, because the joint determination of stack composition (single vs. stacked) and waiting time precludes a clean mediation decomposition.

## 5.3 Robustness

### 5.3.1 Pre-trend test (event-study)

Figure A1 plots the event-study coefficients $\beta_k$ for $k \in \{-5, -4, -3, -2, 1, 2, 3, 4, 5\}$ weeks relative to the AI rollout (`wb1`, the week immediately preceding rollout, is the omitted reference). Pre-rollout coefficients (`wb5` through `wb2`) are statistically indistinguishable from zero both individually and jointly: **$F(4, 335) = 0.65$, $p = 0.63$**, supporting the parallel-trends assumption. **[R1-3A]** Post-rollout coefficients are positive and rise within the first two weeks, consistent with rapid adoption and a stable productivity effect.

### 5.3.2 Oster (2019) selection bound

To address concerns about residual selection on unobservables, we report the Oster (2019) bound under the conservative assumption $R_{\max} = 1.3 \times R^2_{\text{full}}$. The implied selection ratio $\delta^*$ — the proportional selection on unobservables required to drive $\beta = 0$ — is **far in excess of 1** in absolute value, indicating that the productivity result is robust to plausible unobservable selection by Oster's rule of thumb. **[R1-3C, R2-8, AE-4]**

### 5.3.3 Stable workers

Restricting the sample to riders with at least seven working days in *both* pre- and post-AI periods (the *stable-workers* restriction) preserves the headline pattern: the DID coefficient is 0.164 \*\*\* (versus 0.141 \*\*\* in the full sample) and the medium-proficiency DDD remains 0.282 \*\*\* (versus 0.249 \*\*\*). The result is therefore not driven by selective attrition. **[R1-3C, R2-8]**

### 5.3.4 Long-term extension

Using Busan-exclusive Dec 2020 – Feb 2021 order data, we extend the post-AI window to approximately 3.5 months. Of the 336 originally matched riders, 290 (86%) remain active in the extension period. The monthly event-study coefficients (Figure A7) show a productivity gain of **+0.213 \*\*\* in November 2020** (the first full month after rollout), **+0.151 (NS) in December 2020**, and **+0.145 (NS) in January 2021** — that is, the gain is largest in the immediate post-window and attenuates moderately while remaining positive throughout the extended horizon. This pattern addresses the short-window concern (AE-4, R2-7) by showing that the productivity effect persists, with some decay, well beyond the original one-month observation window.

**Productivity-definition caveat for the extended sample.** The Dec–Feb data do not contain explicit between-stack idle markers, so for the extended-sample regression we operationalize productivity as `total_orders / working_duration` (working time only), rather than the main-sample definition `total_orders / total_labor` (working time plus between-stack idle time). The two definitions move closely together when idle time is small relative to working time (which is typical: idle time averages ≈19% of total labor in the matched sample), but the magnitudes are not strictly comparable to the Section 5.1 main estimates. The qualitative finding — that the productivity gain persists with moderate attenuation — is robust to this redefinition, but the levels of the November, December, and January coefficients should be interpreted relative to each other rather than against the main DID coefficient of +0.141. We treat the long-term result as evidence of *persistence with attenuation* rather than as a direct monthly estimate of the productivity gain.

### 5.3.5 Dose-response (supplementary)

The continuous-treatment dose-response specification using the daily share of AI-assigned orders yields a linear coefficient of -0.36 \* ($p = 0.04$). We report this result only as supplementary, because the negative slope likely reflects within-day adoption selection — riders with lower productivity may use AI more on a given day — rather than a structural dose-response. **[R1-3B]**

### 5.3.6 Sample representativeness

Comparing the 336-rider matched analytic sample to the broader pool of 584 preexist Busan riders (Table A4 / Figure A6), the matched sample exhibits slightly higher mean productivity (4.69 vs. 4.54 orders/hour) but lower mean total orders, working hours, and earnings — that is, the matched sample skews toward more productive but less heavily engaged riders. The design-based minimum detectable effect at $\alpha = 0.05$ and power of 0.80 is approximately **2.8% of the mean for the DID and 3.9% for the medium-proficiency DDD** coefficient — small enough that the null finding on average customer waiting time is informative rather than under-powered. **[R2-6, R1-4]**

### 5.3.7 Learning dynamics

We estimate group-specific event studies (Figure A4; `output/tables/10_learning_dynamics.csv`) to address the concern that the productivity gain might simply reflect learning rather than AI-specific complementarity. Within the available five-week post-rollout window:

- The **medium-proficiency** group shows a positive coefficient in every week, with **significant gains in weeks 2 (+0.400, $p = 0.004$), 4 (+0.460, $p = 0.007$), and 5 (+0.440, $p = 0.001$)**, and non-significant but still positive coefficients in weeks 1 (+0.111, $p = 0.47$) and 3 (+0.121, $p = 0.45$). The pattern is consistent with productivity gains emerging within the first one to two weeks and stabilizing thereafter.
- The **low-proficiency** group coefficients are individually noisy and not statistically distinguishable from zero in any post-rollout week (point estimates range from −0.17 to +0.07, all $p > 0.20$).
- The **high-proficiency** group coefficients are similarly noisy in the post period (point estimates range from −0.14 to +0.24, with one marginally significant week, $w_4$: +0.244, $p = 0.073$). One pre-period coefficient — the low-proficiency $w_{b4}$ coefficient of −0.313 ($p = 0.02$) — is marginally significant; we contextualize this against the joint pre-trend test of Section 5.3.1, which is not rejected ($F = 0.65$, $p = 0.63$).

We acknowledge that five weeks is too short to test genuine long-run learning curves; the long-term extension in Section 5.3.4 provides additional evidence over the subsequent months. **[R2-9]**
