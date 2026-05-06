# Section 4. Empirical Models (Revised)

> 변경 매핑: R1-Minor-3, R1-3 (changelog.md 참고)

---

## 4.1 Identification strategy

The platform-level introduction of the order-assignment AI provides a natural experiment. The principal identification challenge is that adoption of the AI mode is not random: riders may opt in or out, and adopters may differ from non-adopters in unobservable ways that also influence productivity (e.g., motivation, technological savvy, or fatigue management). To address this concern, we combine **propensity-score matching (PSM)** at the rider level with **difference-in-differences (DID)** and **triple-difference (DDD)** estimation across pre-AI proficiency groups. We supplement this design with three robustness exercises detailed in Section 5.3: (i) an event-study with leads and lags around the rollout to test parallel trends formally; (ii) Oster (2019) bounds quantifying the selection on unobservables required to nullify the effect; and (iii) a stable-workers restriction that excludes riders with patchy attendance.

## 4.2 Propensity-score matching

We estimate each rider's propensity to adopt AI assignment using logistic regression on pre-treatment observable covariates: average daily delivered stores, average weekly working days, average shift-level waiting time, average orders per shift, average shift duration, daily total labor time, and daily idle duration. We perform one-to-one nearest-neighbor matching without replacement, with a caliper of 0.05 of the standard deviation of the estimated propensity score. The matched analytic sample consists of **336 riders** (168 treated and 168 control). After matching, *t*-tests cannot reject the equality of means between treated and control on any covariate at the 5% level. Matching diagnostics appear in Appendix Table A1.

## 4.3 DID and DDD specifications

For each rider-period observation $(i, t)$, where $i$ indexes riders and $t$ indexes time (day or stack, depending on the specification), our **DID** specification is

$$Y_{i, t} = \beta_1 \cdot \text{After}_t \cdot \text{Treat}_i + \mu_i + \nu_{j(i), t} + \epsilon_{i, t},$$

where $\text{After}_t = 1$ if the observation is on or after October 26, 2020; $\text{Treat}_i = 1$ if rider $i$ ever completes an AI-assigned order during the observation window; $\mu_i$ is a rider fixed effect (which absorbs $\text{Treat}_i$); $\nu_{j(i), t}$ is a branch-date fixed effect (which absorbs $\text{After}_t$); and $\epsilon_{i, t}$ is the disturbance term. **[R1-Minor-3]** Standard errors are clustered at the rider level. Stack-level specifications additionally include hour-of-day-of-week fixed effects $\theta_{h, w}$.

Our **DDD** specification interacts $\text{After}_t \cdot \text{Treat}_i$ with the pre-AI proficiency tercile indicators $G_i \in \{\text{prof\_low}, \text{prof\_med}, \text{prof\_high}\}$:

$$Y_{i, t} = \sum_{g} \beta_g \cdot \text{After}_t \cdot \text{Treat}_i \cdot \mathbb{1}\{G_i = g\} + \sum_{g \in \{\text{med}, \text{high}\}} \gamma_g \cdot \text{After}_t \cdot \mathbb{1}\{G_i = g\} + \mu_i + \nu_{j(i), t} + \theta_{h, w} + \epsilon_{i, t}.$$

The $\text{After} \times \text{Group}$ terms (excluding the prof_low baseline) absorb group-specific time trends, while the three triple-interaction coefficients $\beta_g$ identify the treatment effect *separately for each proficiency group*. Standard errors are clustered at the rider level.

For customer waiting time (Section 5.2), we add a control for the restaurant-to-destination distance (`avg_dist` at the stack level) and report results separately for (i) all stacks, (ii) single-order stacks, and (iii) stacked-order stacks.

## 4.4 Event-study specification (R1-3A)

To allow the DID effect to vary over time and to formally test the parallel-trends assumption, we estimate the **event-study** form

$$Y_{i, t} = \sum_{k = -K,\ k \neq -1}^{K} \beta_k \cdot \text{Treat}_i \cdot \mathbb{1}\{w_k\} + \mu_i + \nu_{j(i), t} + \epsilon_{i, t},$$

where the $w_k$ indicators correspond to weeks before the rollout (`wb5, wb4, wb3, wb2`; `wb1` is the omitted reference) and after the rollout (`w1, w2, w3, w4, w5`). We test the joint hypothesis $\beta_{-5} = \beta_{-4} = \beta_{-3} = \beta_{-2} = 0$ as a pre-trend test using a cluster-robust Wald F-test.

## 4.5 Dose-response specification (R1-3B, supplementary)

To address the concern that the binary "ever-adopter" indicator may be too coarse, we additionally report a **continuous dose-response** specification using the daily share of orders assigned by the AI system,

$$\text{Productivity}_{i, t} = \delta \cdot \text{share\_aiorders\_day}_{i, t} + \mu_i + \nu_{j(i), t} + \epsilon_{i, t}.$$

We report this as supplementary evidence (Section 5.3.5), not as a substitute for the main DID/DDD analysis. The continuous specification addresses adoption-intensity gradients within the same identification framework.

## 4.6 Estimation choices and summary

Outcomes are reported in their **linear units** (orders per hour, minutes, KRW), consistent with the specification of Tables 4–7 in the original manuscript. All fixed effects are absorbed via the `lfe` framework (Gaure, 2013), enabling high-dimensional fixed-effects estimation while clustering standard errors at the rider level. Sample sizes for each specification are reported in the corresponding tables.
