# Response to Reviewers — JJIM-D-25-02826

*Title: Does AI Benefit All Platform Stakeholders? Evidence from Algorithmic Task Assignment in Food Delivery*

Dear Editor and Reviewers,

We thank the editor and the two reviewers for their thorough and constructive comments. The revised manuscript addresses every concern raised, including: (i) sharper positioning of the contribution and the boundary condition; (ii) an explicit definition of the AI system relative to conventional algorithmic dispatch; (iii) extensive new robustness analyses — an event-study with a formal pre-trend test, an Oster (2019) selection bound, a stable-workers restriction, a dose-response specification, learning-dynamics evidence, sample-representativeness analysis, and a long-term extension that adds approximately 3.5 months of post-AI data; (iv) direct inequality metrics (Gini index, Theil index, P90/P10 ratio); (v) tighter scoping of the customer-side estimand; (vi) a worker–customer linkage analysis; (vii) a stand-alone Conclusion section; and (viii) a careful editorial pass to remove overclaims. We respond to each numbered point below. All references to manuscript sections and pages in this letter refer to the *revised* manuscript.

---

## Associate Editor

### AE-1. Theoretical Framework — definition of "labour skill"

> *Categorizing workers based solely on their performance prior to AI introduction is potentially misleading. A more accurate classification would be "high," "medium," and "low" performance.*

**Our response.** We agree, and we have replaced "skill" with "proficiency" throughout the manuscript when referring to the worker classification. Proficiency is now defined explicitly as **the rider's average orders per hour during the 30-day pre-AI window under manual broadcast dispatch**, in a footnote to Section 3.2. The term "skill" remains only when it refers to *general execution capability* (e.g., "downstream-execution skill"), which is conceptually distinct from the worker classification. A grep audit confirms zero remaining uses of "skill" in the worker-classification sense (`docs/04_claims_audit.md`).

**Manuscript change.** Section 3.2 (background) — explicit definition; section_*.md throughout — "skill" → "proficiency" for the classification.

### AE-2. Research Focus — customer experience as labour-related

> *The measurement of "Customer experience" can be as well viewed from the labour perspective, failing to investigate the actual inter-relationship between customers and workers.*

**Our response.** We have added a stack-level **worker–customer linkage** analysis (Section 5.2.2) that quantifies the association between within-stack rider productivity (orders per hour at the stack level) and customer waiting time on the matched sample. The linkage is significantly negative — faster stacks are associated with shorter customer waiting — and is stronger for single-order stacks than for stacked-order stacks. We frame this explicitly as a *linkage* rather than a formal mediation analysis, because stack composition (single vs. stacked) is jointly determined with waiting time. This framing addresses the editor's concern about examining customer experience through the labor lens while preserving the rigor of our identification.

**New evidence.** `output/figures/11_worker_customer_linkage.png`; `output/tables/11_worker_customer_linkage.csv`; coefficient on stack productivity = **-1.13 \*\*\* min** (all stacks), -1.56 *** (single), -0.98 *** (stacked).

**Manuscript change.** Section 5.2.2 (new sub-section); Section 6.4 (Discussion of linkage).

### AE-3. Social Impact Claims — AI not designed for equity

> *I am not convinced the results address whether AI drives social equality. Without specific details on how the AI was implemented … the conclusions remain speculative. If the AI was not designed with social equality as a goal, it is unlikely to produce such an outcome organically.*

**Our response.** We agree, and we have substantially reframed the social-equality language. Section 3.1 of the revised manuscript now states explicitly that the order-assignment AI was **designed for match quality and assignment efficiency, not for equity**. Section 6.3 discusses the inequality compression we observe as a *by-product* of the algorithm's interaction with the multi-stage task structure and the pre-AI proficiency distribution — not as an organic outcome of an algorithm pursuing equity. All "AI promotes social equality" language has been removed. The direct inequality metrics in Section 5.1.3 document a *modest* compression of the productivity distribution among matched/treated riders relative to control, which we describe in those terms rather than as a broader social-equality claim.

**Manuscript change.** Section 3.1 (system design statement); Section 6.3 (Discussion); Section 5.1.3 (direct inequality metrics with conservative interpretation).

### AE-4. Residual bias and data duration

> *The methodological issues regarding residual effects and data duration are structural and cannot be resolved within a standard revision timeframe.*

**Our response.** We have added two substantive new analyses to address residual bias and data duration:

(a) **Oster (2019) selection bound** (Section 5.3.2 of the revised manuscript). Under the conservative R_max = 1.3 × R²_full assumption, the implied selection ratio δ\* is far in excess of 1 in absolute value, meaning that selection on unobservables would have to exceed selection on observables by a large factor to nullify our DID estimate. This is a formal sensitivity bound on residual unobservable selection.

(b) **Long-term extension via Busan-exclusive Dec 2020 - Feb 2021 data** (Section 5.3.4 of the revised manuscript). 290 of the 336 matched riders (86%) are still active in the extension window. The monthly event-study coefficients show **+0.213 \*\*\* (p = 0.006) in November 2020**, the first full month after rollout, with continued positive (though smaller) coefficients in December 2020 and January 2021. The productivity gain therefore persists, with some attenuation, into the longer post-AI window.

**New evidence.** `output/interpretation/06_oster_bounds.md`; `output/interpretation/13_long_term_extension.md`; `output/figures/13_long_term_event_study.png`.

**Manuscript change.** Section 5.3.2 (Oster); Section 5.3.4 (long-term extension); Section 7 (limitations remain explicit).

---

## Reviewer #1

### R1-1. Sharper novelty positioning

> *The manuscript currently reads as "AI improves matching and thus productivity"… the paper would benefit from clarifying what is fundamentally new here beyond "algorithmic assignment matters."*

**Our response.** We have introduced a *boundary condition* framing throughout the revised manuscript. Section 1 (Introduction), Section 2.4 (Related literature: positioning), and Section 6 (Discussion) now identify the **multi-stage task structure** of food delivery (assignment → stacking → sequencing → routing) as the boundary condition that determines the value distribution of order-assignment AI. Our contribution is to operationalize this boundary condition empirically — showing that productivity gains accrue most to workers whose binding constraint is task selection and least to workers whose binding constraint is downstream execution — rather than treating the platform as a generic "algorithmic assignment matters" setting.

**Manuscript change.** Section 1 (Introduction, contribution paragraph); Section 2.4 (positioning paragraph); Section 6.1 (Discussion of boundary condition); Section 7.1 (theoretical contribution).

### R1-2. Define "AI" vs. conventional algorithmic dispatch

> *The manuscript does not sufficiently distinguish AI-specific components from standard automated dispatch and optimization.*

**Our response.** Section 3.1 of the revised manuscript characterizes the order-assignment AI along three design dimensions that distinguish it from manual broadcast or rule-based dispatch:

1. **Revealed-preference learning at the individual rider level** — the system learns each rider's accept/decline distribution conditional on logistical situation.
2. **Dynamic, real-time match scoring** — match-quality scores are updated continuously on the basis of current location, in-progress orders, and likely subsequent routes.
3. **Automated assignment without broadcast** — the system directly assigns the best-matched order, limiting selective acceptance.

This characterization is now visible throughout the introduction and background sections.

**Manuscript change.** Section 1 (Introduction, AI characterization paragraph); Section 3.1 (Background, expanded system description with the three design features).

### R1-3A. Event-study / dynamic DID

> *Provide a more explicit event-study or dynamic DID around the rollout, with emphasis on pre-trend diagnostics.*

**Our response.** Section 5.3.1 of the revised manuscript reports a formal event-study with weeks `wb5, wb4, wb3, wb2, wb1 (ref), w1, w2, w3, w4, w5` relative to the AI rollout. The pre-trend joint F-test yields **F(4, 335) = 0.65, p = 0.63**, supporting the parallel-trends assumption. The post-rollout coefficient series rises within the first two weeks and stabilizes through week 5, consistent with rapid adoption and a stable productivity effect. Figure 3 (revised manuscript) plots the coefficients with 95% CIs.

**New evidence.** `code/05_event_study.R`; `output/figures/05_event_study_productivity.png`; `output/tables/05_event_study_coefficients.csv`; `output/tables/05_event_study_pretrend_test.csv`.

**Manuscript change.** Section 5.3.1 (revised manuscript).

### R1-3B. Dose-response on adoption intensity

> *Consider measuring AI usage intensity, such as the share of AI-assigned orders or days, and estimating dose-response patterns.*

**Our response.** Section 5.3.5 of the revised manuscript reports a dose-response specification using daily share of AI-assigned orders as a continuous treatment intensity. The linear coefficient is -0.36 * (p = 0.04). We **report this only as supplementary evidence**, since the negative slope likely reflects within-day selection (riders with lower productivity may use AI more on a given day) rather than a true dose-response. The binary-treatment DID/DDD remains our primary specification.

**New evidence.** `code/07_dose_response.R`; `output/figures/07_dose_response.png`.

**Manuscript change.** Section 4.5 (specification); Section 5.3.5 (results, supplementary framing).

### R1-3C. Time-varying selection robustness

> *Restrict to riders with stable working patterns; alternative matching/reweighting; branch-level adoption patterns.*

**Our response.** Three robustness exercises now appear:

(a) **Stable workers restriction** (Section 5.3.3) — restricting to riders with ≥ 7 working days in *both* the pre and post windows. The headline DID = 0.164 *** and the medium-proficiency DDD = 0.282 *** are preserved, indicating the result is not driven by selective attrition.

(b) **Oster (2019) selection bound** (Section 5.3.2, see also AE-4) — addressing residual selection on unobservables.

(c) **Existing alternative matching specifications** (Appendix Table A6) — already in the original manuscript, retained.

**New evidence.** `code/08_stable_workers.R`; `code/06_oster_bounds.R`.

**Manuscript change.** Sections 5.3.2 and 5.3.3 (revised manuscript).

### R1-4. Consumer-side inference is overstated

> *The consumer-side estimation appears to be attached to the matched rider sample, so it measures waiting times for orders delivered by treated versus control riders. This is informative, but it does not necessarily identify platform-wide or market-level consumer welfare effects.*

**Our response.** Section 5.2.1 of the revised manuscript now explicitly states the customer-side estimand: **the change in waiting time for customers served by treated/matched riders**, not platform-wide consumer welfare. We acknowledge directly that equilibrium and spillover effects across non-matched riders are not identified by our matched design. We have removed all platform-wide consumer-welfare language. Section 5.2.1 also reports the design-based MDE (~2.8% of mean for the DID) showing the design is well-powered to detect material customer-side changes within the matched-sample estimand.

The decomposition by single- vs. stacked-order delivery is presented as the substantive customer-side finding, with conditional language ("conditional consumer benefit") rather than headline language.

**New evidence.** `code/12_submission_diagnostics.R`; `output/tables/12_mde.csv`.

**Manuscript change.** Section 5.2.1 (estimand statement, scoped language, MDE); Section 6.2 (Discussion, no platform-wide claim).

### R1-Minor-1. Reference list duplication

> *Multiple entries that appear to refer to the same working paper.*

**Our response.** We have audited the reference list (`docs/05_reference_audit.md`):

- `Y. Chen et al. (2024a/b)` — duplicate. Consolidated to a single entry with the same SSRN ID. All in-text citations updated to `Y. Chen et al. (2024)`.
- `Brynjolfsson et al. (2025)` — title contained a trailing `*` (accidental footnote marker). Removed.
- `Allon et al. (2018)` SSRN → updated to the published Manufacturing & Service Operations Management 2023 version, pending final author confirmation.

**Manuscript change.** Reference list updated throughout.

### R1-Minor-2. Direct inequality metric

> *Consider reporting a more direct inequality metric, such as variance, Gini or Theil, or P90 to P10 productivity gaps.*

**Our response.** Section 5.1.3 of the revised manuscript reports direct inequality metrics — **Gini, Theil, P90/P10, P75/P25** — computed at the rider-level (mean productivity within each period), separately for treated and control, pre and post. The DiD-on-inequality (treated change − control change) yields **Gini -0.005**, **Theil -0.002**, **P90/P10 -0.099**. Figure 2 (revised manuscript) shows the productivity density pre vs. post for the matched sample.

**New evidence.** `code/09_inequality.R`; `output/figures/09_inequality_density.png`; `output/tables/09_inequality.csv` and `09_inequality_did.csv`.

**Manuscript change.** Section 5.1.3 (revised manuscript).

### R1-Minor-3. Customer regression FE/controls

> *Clarify which fixed effects and time controls are used in the consumer waiting time regressions.*

**Our response.** Section 4.3 of the revised manuscript now explicitly specifies the FE structure for each level of analysis. Day-level: rider FE + branch-date FE; cluster rider. Stack-level: rider FE + branch-date FE + hour-of-DOW FE; cluster rider. Customer waiting time analyses additionally control for restaurant-to-destination distance (avg_dist). All specifications are visible in `code/04_manuscript_exact_spec.R`.

**Manuscript change.** Section 4.3 (revised manuscript).

---

## Reviewer #2

### R2-1. Introduction's "AI creates value" assumption

> *The introduction repeatedly suggests that AI "creates value"… asserted before empirical evidence is introduced.*

**Our response.** We have rewritten the introduction to *frame the value question as open* rather than assumed. Section 1, second paragraph: "Whether such AI-driven assignment translates into broadly distributed value, however, remains an open question rather than an established fact." We have also added explicit acknowledgment of potential downsides — increased monitoring/stress, opacity, reduced autonomy — citing Jarrahi & Sutherland (2019), Kellogg et al. (2020), Lee et al. (2015), and Möhlmann et al. (2021). The empirical question we ask is therefore *how* (not whether) the benefits are distributed.

**Manuscript change.** Section 1, second paragraph (revised manuscript).

### R2-2. Customer outcomes treated as second-class

> *The discussion of customer outcomes is delayed and speculative.*

**Our response.** Section 1 of the revised manuscript now treats worker-side and customer-side questions in parallel (third paragraph onward). The contribution paragraph explicitly mentions all three findings: average productivity, productivity disparities across pre-AI proficiency groups, and customer-side outcomes. Section 5.2 retains the customer-side analysis as an integrated finding rather than an afterthought. The new worker-customer linkage analysis (Section 5.2.2) makes the conceptual connection explicit.

**Manuscript change.** Section 1 (parallel framing); Section 5.2 (integrated treatment).

### R2-3. Limitations / research gap

> *The introduction does not critically discuss limitations… establishing a clear research gap.*

**Our response.** Section 7.3 of the revised manuscript now contains a stand-alone **Limitations** sub-section detailing five concrete limitations: (i) single platform / single country / single task; (ii) PSM + DID/DDD identification with residual unobservable selection caveats; (iii) customer-side estimand restricted to matched-rider customers; (iv) observation window (3.5 months post-AI in extended sample); (v) absence of measures for worker stress, autonomy, well-being. Section 1 also articulates the research gap explicitly as the absence of joint worker-customer evidence in platform AI deployments.

**Manuscript change.** Section 1 (research gap framing); Section 7.3 (Limitations sub-section).

### R2-4. Critical literature review

> *Critical evaluation of conflicting findings… why prior results differ.*

**Our response.** Section 2.2 of the revised manuscript reorganizes the literature into a **competing-views** structure (AI raises vs. reduces inequality), with explicit treatment of the *conditions* under which each view is supported. We argue that the apparent conflict in the literature is reconciled by the boundary-condition framework: the relevant question is *which bottleneck the algorithm relieves and whether workers have the complementary downstream skills*. This framing makes the paper's contribution to the inequality literature explicit.

**Manuscript change.** Section 2.2 (rewritten).

### R2-5. Limited platform/gig-specific evidence

> *Largely draws on general studies of AI in workplaces, ride-hailing, or grocery platforms.*

**Our response.** Section 2.1 and 2.3 of the revised manuscript prominently cite **platform/gig-specific** evidence: Knight et al. (2024) (grocery batch picking), Y. Chen et al. (2024) (ride-hailing), M. Liu et al. (2021) (Uber moral hazard), Mao et al. (2025) (food delivery order assignment), Gupta et al. (2022) (food delivery fairness). These citations are used both to position the paper and to compare findings.

**Manuscript change.** Sections 2.1 and 2.3 (revised manuscript).

### R2-6. Representativeness of retained riders

> *Retaining 600 riders … not discussed how representative.*

**Our response.** Section 5.3.6 of the revised manuscript provides a **sample representativeness analysis**: the 336-rider matched analytic sample is compared to the broader 584-rider preexist Busan rider pool on four key labor-supply variables (orders/hour, total daily orders, working hours, daily fee). The matched sample skews toward slightly higher productivity (4.69 vs. 4.54 orders/hour) but lower volume (fewer total orders, hours, earnings). Figure A4 plots the productivity density. The design-based MDE (~2.8% of mean for the DID) shows the design is well-powered.

**New evidence.** `code/12_submission_diagnostics.R`; `output/figures/12_sample_representativeness.png`; `output/tables/12_sample_comparison.csv` and `12_mde.csv`.

**Manuscript change.** Section 5.3.6 (revised manuscript).

### R2-7. Short observation window

> *One month before and after… very short for capturing stable behavioral changes or learning effects.*

**Our response.** Section 5.3.4 of the revised manuscript reports a **long-term extension** using Busan-exclusive Dec 2020 - Feb 2021 order data. The combined observation window now spans **2020-09-26 through 2021-01-31** (5 months total). Of the 336 matched riders, 290 (86%) remain active in the extension period. The monthly event-study yields a productivity gain of **+0.213 *** (p = 0.006) in November 2020**, with positive but smaller coefficients in December 2020 (+0.151) and January 2021 (+0.145). The productivity effect therefore persists, with moderate attenuation, well beyond the original 1-month post-AI window. Section 5.3.7 additionally reports **learning dynamics by proficiency group** (week-level coefficients) within the original 5-week post-AI window.

**New evidence.** `code/13b_long_term_full.R`; `output/figures/13_long_term_event_study.png`; `output/figures/10_learning_curves_by_group.png`.

**Caveat regarding long-term productivity definition.** The Dec-Feb csv does not include between-stack idle markers, so for the extended-sample regression we approximate `orders_per_hour` using `total_orders / working_duration` (working time only) instead of the main-sample `total_orders / total_labor` (working time + idle). Idle averages ≈19% of total labor in the matched sample; the qualitative finding (productivity gain persists with moderate attenuation) is robust, but the level of the long-term coefficients is not directly comparable to the +0.141 DID main estimate. This caveat is now stated explicitly in Section 5.3.4 of the revised manuscript.

**Manuscript change.** Sections 5.3.4 and 5.3.7 (revised manuscript).

### R2-8. Residual selection

> *Riders who self-select into AI might have higher motivation, tech-savviness, or familiarity with stacks…*

**Our response.** This concern is addressed by three robustness exercises now in the revised manuscript:

(a) **Oster (2019) bound** (Section 5.3.2) — formal selection-on-unobservables sensitivity bound. δ\* is far in excess of 1 in absolute value, indicating robustness.

(b) **Stable workers restriction** (Section 5.3.3) — eliminates riders with patchy attendance. DID = 0.164 *** (vs. 0.141 *** in full sample) preserved.

(c) **Long-term extension** (Section 5.3.4) — extends the post-AI window to ~3.5 months, showing the productivity gain persists, ruling out a pure short-run motivational/novelty effect.

**Manuscript change.** Sections 5.3.2, 5.3.3, 5.3.4 (revised manuscript).

### R2-9. Learning curve empirical evidence

> *The learning curve argument is mentioned, but no empirical evidence supports it.*

**Our response.** Section 5.3.7 of the revised manuscript reports **group-specific event studies** (week-level treatment-effect coefficients estimated separately for low-, medium-, and high-proficiency riders). Figure A1 plots the resulting coefficient series. The medium-proficiency group's coefficient is positive and stable across post-rollout weeks 1–5, while low- and high-proficiency coefficients are noisier. This provides direct empirical evidence on the within-window adaptation pattern. The long-term extension (Section 5.3.4) provides additional evidence in the months that follow.

**New evidence.** `code/10_learning_dynamics.R`; `output/figures/10_learning_curves_by_group.png`.

**Manuscript change.** Section 5.3.7 (revised manuscript).

### R2-10. External validity

> *Single platform, single country, single task — limits external validity.*

**Our response.** Section 7.3 (Limitations) of the revised manuscript explicitly acknowledges the single-platform / single-country / single-task limitation. Section 7.4 (Future Research) outlines three directions, including comparative studies across platforms with different algorithmic-assistance designs (e.g., assignment-only vs. assignment + sequencing) which would directly test the generalizability of our boundary-condition framework.

**Manuscript change.** Sections 7.3 and 7.4 (revised manuscript).

### R2-11. No proper conclusion section

> *No theoretical and practical policy implications, nor limitations of the study.*

**Our response.** We have added a stand-alone **Section 7. Conclusion** to the revised manuscript with four sub-sections:

- **7.1 Theoretical contributions** — three contributions to the literature, including the boundary-condition framework.
- **7.2 Practical and policy implications** — three actionable implications for platform operators, plus a policy caution against assuming algorithmic assignment is inherently equity-promoting.
- **7.3 Limitations** — five concrete limitations (see R2-3 above).
- **7.4 Future research** — three directions for follow-up work.

**Manuscript change.** New Section 7 (revised manuscript).

### R2-Other. Language editing

We have conducted a careful editorial pass over the revised manuscript and the response letter to improve clarity, conciseness, and academic tone. We will additionally engage a professional copy-editing service for a final pass once acceptance-conditional revisions are complete.

---

## Summary of new evidence

The revised manuscript and accompanying analytical archive include the following **new analyses** that did not appear in the original submission:

| Analysis | Code | Reviewer comments addressed |
|----------|------|------------------------------|
| Event-study + pre-trend F-test | `code/05_event_study.R` | R1-3A, R2-7 |
| Oster (2019) bound | `code/06_oster_bounds.R` | R1-3C, R2-8, AE-4 |
| Dose-response (supplementary) | `code/07_dose_response.R` | R1-3B |
| Stable-workers restriction | `code/08_stable_workers.R` | R1-3C, R2-8 |
| Direct inequality metrics | `code/09_inequality.R` | R1-Minor-2 |
| Learning dynamics by group | `code/10_learning_dynamics.R` | R2-9 |
| Worker-customer linkage | `code/11_worker_customer_linkage.R` | AE-2 |
| Sample representativeness + MDE | `code/12_submission_diagnostics.R` | R2-6, R1-4 |
| Long-term Dec-Feb extension | `code/13b_long_term_full.R` | AE-4, R2-7 |

All analyses use the same matched-rider sample (336 riders, with 290 remaining in the extension window) and the same identification framework as the original DID/DDD specification, ensuring internal consistency.

---

We thank the editor and the reviewers once again for the opportunity to revise the manuscript and for the constructive feedback, which has materially strengthened the paper.

Sincerely,

The Authors
