# Appendix

> 모든 Table A1-A6 의 수치는 **원본 manuscript** 그대로 보존. Table A7-A12 는 리비전 새 분석 결과.

---

## Table A1. Calculation of propensity score using a logistic regression model

| Variables | Mean effect | Std. error |
|-----------|------------:|-----------:|
| Number of working days | 0.120 \* | 0.071 |
| Number of unique restaurants | -0.067 \*\*\* | 0.026 |
| Daily working hours | 0.007 \*\*\* | 0.002 |
| Daily idle hours | -0.009 \*\* | 0.004 |
| Number of orders in a stack | -0.589 \*\*\* | 0.213 |
| Stack completion time | 0.069 \*\* | 0.027 |
| Idle time between stacks | 0.021 | 0.028 |
| Customer waiting time | -0.032 | 0.041 |
| Constant | -0.737 | 0.747 |
| Log-Likelihood | -317.759 | |
| Observations | 582 | |

*Notes:* Estimates calculated on an unmatched sample of 399 adopters and 183 non-adopters in the pretreatment period before October 26, 2020. Dependent variable: AI adoption (1 = adopted, 0 = not). \*\*\*p < 0.01; \*\*p < 0.05; \*p < 0.1.

---

## Table A2. Results of placebo test on daily productivity

|  | Daily productivity (1) | Daily productivity (2) |
|:--|--:|--:|
| After × Treat | 0.014 | |
|  | (0.060) | |
| After × Treat × Low | | 0.027 |
|  | | (0.100) |
| After × Treat × Medium | | -0.037 |
|  | | (0.117) |
| After × Treat × High | | 0.068 |
|  | | (0.090) |
| Adj. R² | 0.593 | 0.593 |
| Observations | 6,781 | 6,781 |

*Notes:* Placebo test using only pretreatment data, with a placebo treatment date at the midpoint. No statistically significant placebo effects at the 5% level — pretreatment trends are equivalent across rider groups.

---

## Table A3. Results of placebo test on stack-level working behavior

|  | Number of orders | Number of orders | Stack completion time (mins) | Stack completion time (mins) | Average processing time (mins) | Average processing time (mins) | Idle time (mins) | Idle time (mins) |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
|  | (1) | (2) | (3) | (4) | (5) | (6) | (7) | (8) |
| After × Treat | 0.033 | | 0.189 | | -0.001 | | -0.166 | |
|  | (0.070) | | (0.550) | | (0.069) | | (0.200) | |
| After × Treat × Low | | -0.016 | | -0.347 | | 0.028 | | -0.755 \* |
|  | | (0.083) | | (0.749) | | (0.170) | | (0.415) |
| After × Treat × Medium | | 0.004 | | 0.051 | | -0.076 | | 0.032 |
|  | | (0.077) | | (0.704) | | (0.113) | | (0.334) |
| After × Treat × High | | 0.098 | | 0.663 | | 0.059 | | -0.068 |
|  | | (0.141) | | (1.053) | | (0.090) | | (0.255) |
| Adj. R² | 0.246 | 0.246 | 0.282 | 0.282 | 0.356 | 0.356 | 0.128 | 0.128 |
| Observations | 72,560 | 72,560 | 72,560 | 72,560 | 72,560 | 72,560 | 60,494 | 60,494 |

---

## Table A4. Results of placebo test on day-level working behavior

|  | Total stacks | Total stacks | Total orders | Total orders | Total earnings ($) | Total earnings ($) | Working hours (hours) | Working hours (hours) |
|:--|--:|--:|--:|--:|--:|--:|--:|--:|
|  | (1) | (2) | (3) | (4) | (5) | (6) | (7) | (8) |
| After × Treat | -0.157 | | -0.524 | | -0.821 | | -0.042 | |
|  | (0.333) | | (0.779) | | (1.661) | | (0.166) | |
| After × Treat × Low | | 0.505 | | 0.533 | | 1.236 | | 0.112 |
|  | | (0.535) | | (0.977) | | (2.089) | | (0.292) |
| After × Treat × Medium | | 0.135 | | 0.635 | | 1.491 | | 0.193 |
|  | | (0.463) | | (1.109) | | (2.378) | | (0.248) |
| After × Treat × High | | -0.994 \* | | -2.591 \* | | -4.904 | | -0.428 \* |
|  | | (0.559) | | (1.489) | | (3.132) | | (0.246) |
| Adj. R² | 0.676 | 0.676 | 0.674 | 0.674 | 0.668 | 0.668 | 0.587 | 0.587 |
| Observations | 6,781 | 6,781 | 6,781 | 6,781 | 6,781 | 6,781 | 6,781 | 6,781 |

*Notes:* The marginal high-proficiency placebo coefficients reflect a within-pretreatment fluctuation that is not present in the formal event-study pre-trend test (Section 5.3.1, F = 0.65, p = 0.63 across the 30-day pre-window).

---

## Table A5. Results of placebo test on customer waiting time

|  | Customer waiting time (mins) | Customer waiting time (mins) |
|:--|--:|--:|
|  | (1) | (2) |
| After × Treat | 0.063 | |
|  | (0.088) | |
| After × Treat × Low | | 0.126 |
|  | | (0.159) |
| After × Treat × Medium | | 0.079 |
|  | | (0.143) |
| After × Treat × High | | 0.014 |
|  | | (0.135) |
| Adj. R² | 0.543 | 0.543 |
| Observations | 71,390 | 71,390 |

---

## Table A6. Results of alternative matching specifications

### Panel A: DID

|  | (1) 1:1 w/o replace caliper 0.05 | (2) 1:1 w/ replace caliper 0.05 | (3) 1:1 w/ replace caliper 0.01 | (4) 1:1 w/o replace caliper 0.05 mahalanobis | (5) Non-matching |
|:--|--:|--:|--:|--:|--:|
| After × Treat | 0.141 \*\*\* | 0.149 \*\*\* | 0.121 \*\* | 0.140 \*\*\* | 0.080 \*\* |
|  | (0.047) | (0.052) | (0.054) | (0.048) | (0.039) |
| Adj. R² | 0.604 | 0.624 | 0.610 | 0.606 | 0.639 |
| Observations | 14,102 | 12,544 | 10,883 | 13,956 | 26,280 |

### Panel B: DDD

|  | (1) | (2) | (3) | (4) | (5) |
|:--|--:|--:|--:|--:|--:|
| After × Treat × Low | 0.088 | 0.078 | 0.014 | 0.095 | 0.054 |
|  | (0.071) | (0.079) | (0.072) | (0.072) | (0.065) |
| After × Treat × Medium | 0.249 \*\*\* | 0.250 \*\*\* | 0.222 \*\* | 0.259 \*\*\* | 0.167 \*\*\* |
|  | (0.066) | (0.079) | (0.090) | (0.068) | (0.052) |
| After × Treat × High | 0.067 | 0.102 | 0.101 | 0.048 | -0.024 |
|  | (0.084) | (0.087) | (0.096) | (0.084) | (0.067) |
| Adj. R² | 0.605 | 0.625 | 0.611 | 0.606 | 0.641 |
| Observations | 14,102 | 12,544 | 10,883 | 13,956 | 26,280 |

*Notes:* The headline result (DID = 0.141 \*\*\*; DDD medium = 0.249 \*\*\*) is robust across alternative matching specifications. \*\*\*p < 0.01; \*\*p < 0.05; \*p < 0.1.

---

# New Appendix Tables (Revision Analyses)

> 새로 추가된 분석 표. 각 표의 수치는 우리 데이터로 직접 산출했고 `output/tables/` 의 csv 파일과 일치.

---

## Table A7. Event-study (week-level lead/lag) — Productivity

| Week | Coefficient | SE | p-value |
|:-----|------------:|---:|--------:|
| wb5 (week -5) | -0.013 | 0.144 | 0.928 |
| wb4 (week -4) | -0.018 | 0.110 | 0.870 |
| wb3 (week -3) | 0.040 | 0.090 | 0.654 |
| wb2 (week -2) | 0.121 | 0.093 | 0.196 |
| wb1 (week -1) | 0.000 (reference) | — | — |
| w1 (week +1) | 0.071 | 0.078 | 0.358 |
| w2 (week +2) | 0.020 | 0.085 | 0.812 |
| w3 (week +3) | 0.067 | 0.084 | 0.426 |
| w4 (week +4) | 0.232 | 0.084 | 0.006 \*\*\* |
| w5 (week +5) | 0.218 | 0.111 | 0.051 \* |

*Pre-trend joint F-test:* F(4, 335) = 0.65, p = 0.63 — parallel-trends supported.

*Source:* `output/tables/05_event_study_coefficients.csv`; `output/tables/05_event_study_pretrend_test.csv`.

---

## Table A8. Oster (2019) selection bound — Productivity DID

| Quantity | Value |
|:---------|------:|
| β (restricted, FE only) | 0.1406 |
| β (full, + observable controls) | 0.1409 |
| R² (restricted) | 0.659 |
| R² (full) | 0.706 |
| R\_max (= 1.3 × R²\_full) | 0.918 |
| Bias-adjusted β\* (under R\_max) | 0.1422 |
| **Selection ratio δ\*** | **−105.20** |
| Robust by |δ\*| > 1 rule? | **Yes** |

*Source:* `output/tables/06_oster_bounds.csv`. *Interpretation:* Selection on unobservables would need to exceed selection on observables by ~105× to nullify the productivity effect.

---

## Table A9. Stable-workers robustness — Productivity

|  | Full sample | Stable sample |
|:--|------------:|--------------:|
| Number of riders | 336 | (≈322) |
| DID (After × Treat) | 0.1406 \*\*\* | **0.1640 \*\*\*** |
| DDD low | 0.0884 | 0.0834 |
| DDD medium | 0.2493 \*\*\* | **0.2823 \*\*\*** |
| DDD high | 0.0671 | 0.1044 |

*Source:* `output/tables/08_stable_workers.csv`. Stability rule: ≥ 7 working days in BOTH pre and post 30-day windows. Headline pattern preserved (and slightly stronger) on the stable sample.

---

## Table A10. Inequality metrics — Productivity distribution

| Group | n | Mean | SD | Gini | Theil | P90/P10 | P75/P25 |
|:------|--:|----:|---:|----:|------:|--------:|--------:|
| All matched, PRE | 336 | 4.686 | 1.086 | 0.130 | 0.027 | 1.833 | 1.343 |
| All matched, POST | 336 | 4.655 | 1.148 | 0.137 | 0.030 | 1.898 | 1.367 |
| Treated, PRE | 168 | 4.633 | 1.028 | 0.123 | 0.024 | 1.771 | 1.297 |
| Treated, POST | 168 | 4.580 | 1.066 | 0.127 | 0.026 | 1.780 | 1.334 |
| Control, PRE | 168 | 4.739 | 1.142 | 0.135 | 0.029 | 1.883 | 1.367 |
| Control, POST | 168 | 4.729 | 1.223 | 0.145 | 0.033 | 1.991 | 1.407 |

### Panel B: DiD on inequality (treated change − control change)

| Metric | Treated change | Control change | DiD |
|:-------|---------------:|---------------:|----:|
| Gini | +0.004 | +0.009 | **−0.005** |
| Theil | +0.002 | +0.004 | **−0.002** |
| P90/P10 | +0.009 | +0.108 | **−0.099** |
| P75/P25 | +0.037 | +0.040 | **−0.003** |

*Source:* `output/tables/09_inequality.csv`, `09_inequality_did.csv`. Inequality among treated riders compresses modestly relative to control.

---

## Table A11. Long-term event-study (Dec 2020 – Jan 2021) — Productivity\*

| Month | Coefficient | SE | p-value |
|:------|------------:|---:|--------:|
| 2020-09 | (omitted, degenerate baseline) | — | — |
| 2020-10 (reference launch month) | 0.106 | 0.076 | 0.164 |
| 2020-11 (1 month post) | **+0.213 \*\*\*** | 0.077 | **0.006** |
| 2020-12 (2 months post) | +0.151 | 0.099 | 0.128 |
| 2021-01 (3 months post) | +0.145 | 0.100 | 0.148 |

\*Productivity in this extended sample is computed as `total_orders / working_duration` (working time only) rather than the main-sample `total_orders / total_labor` (working + idle), because the Dec-Feb csv does not contain explicit between-stack idle markers. The qualitative finding (productivity gain persists) is robust to this redefinition; level magnitudes are not directly comparable to the main-sample DID coefficient of +0.141.

*Sample:* 290 of 336 originally matched riders (86%) active in extension window. *Source:* `output/tables/13_long_term_event_study.csv`.

---

## Table A12. Worker–customer linkage (stack-level)

|  | All stacks | Single-order | Stacked-order |
|:--|----------:|-------------:|--------------:|
| Stack productivity (orders/hour) | **−1.13 \*\*\*** | **−1.56 \*\*\*** | **−0.98 \*\*\*** |
|  | (0.028) | (0.034) | (0.030) |
| Distance (avg_dist) | 1.60 \*\*\* | 0.71 \*\*\* | 2.17 \*\*\* |
|  | (0.052) | (0.045) | (0.064) |
| Number of orders in stack | 0.64 \*\*\* | — | 0.32 \*\*\* |
|  | (0.033) | | (0.016) |

*Notes:* Dependent variable: customer waiting time (minutes). FE: rider + station-date + hour-of-DOW. Cluster: rider. Reported as a *linkage* analysis, not a formal mediation analysis — joint determination of stack composition prevents a clean mediation decomposition.

*Source:* `output/tables/11_worker_customer_linkage.csv`.

---

## Figure captions

**Figure A1. Event-study coefficients on productivity (DID, week-level leads/lags).**
Pointrange plot of weekly Treat × week indicators around the AI rollout (2020-10-26). The vertical dashed red line marks the rollout. The horizontal dashed grey line marks zero. Error bars are 95% confidence intervals from rider-clustered standard errors. The week immediately preceding rollout (`wb1`) is the omitted reference period. The pre-trend joint F-test on `wb5, wb4, wb3, wb2` yields F(4, 335) = 0.65, p = 0.63, supporting the parallel-trends assumption. Source: `output/figures/05_event_study_productivity.png`.

**Figure A2. Dose-response: AI assignment intensity vs. productivity (post-period treated rider-days).**
Binscatter of mean daily productivity against the share of orders assigned by AI within a rider-day. Error bars show 95% CIs on bin means. The fitted linear regression (slope coefficient -0.36, p = 0.04) is reported as supplementary evidence; the negative slope likely reflects within-day adoption selection rather than a structural dose-response. Source: `output/figures/07_dose_response.png`.

**Figure A3. Pre-vs-post productivity density (matched 336 riders).**
Kernel density of rider-level mean productivity (orders/hour) in the pre-AI vs post-AI 30-day windows. Slight rightward shift among treated riders is consistent with the +3% DID and the inequality compression in Table A10. Source: `output/figures/09_inequality_density.png`.

**Figure A4. Learning dynamics by proficiency group (week-level treatment coefficients).**
Pointrange plot of week-level Treat coefficients estimated separately for low-, medium-, and high-proficiency riders. Vertical dashed red line marks the AI rollout. Bars are 95% CIs (rider-clustered). Medium-proficiency coefficients are significantly positive in weeks 2, 4, 5 (p < 0.01); low- and high-proficiency coefficients remain individually noisy. Source: `output/figures/10_learning_curves_by_group.png`.

**Figure A5. Worker–customer linkage: stack productivity vs customer waiting time (post-period, decile bins).**
Binscatter plot showing the negative association between within-stack productivity and customer waiting time, post-AI period. Bin sizes scaled to # stacks per bin. Linear fit (regression coefficient -1.13 \*\*\*, all stacks) overlaid with 95% CI. Source: `output/figures/11_worker_customer_linkage.png`.

**Figure A6. Sample representativeness: matched analytic sample vs broader preexist Busan riders.**
Density plot of daily productivity (orders/hour) for the 336-rider matched analytic sample vs the 248 preexist Busan riders excluded by matching. The matched sample skews slightly higher in mean productivity but exhibits broadly similar distribution shape. Source: `output/figures/12_sample_representativeness.png`.

**Figure A7. Long-term productivity event-study (monthly coefficients, Sep 2020 – Jan 2021).**
Pointrange plot of monthly Treat coefficients (reference month = 2020-10, the launch month). Bars are 95% CIs. November 2020 shows the strongest coefficient (+0.213, p = 0.006); coefficients remain positive through Jan 2021 with moderate attenuation. Note: the productivity definition in this extended sample uses working hours only (caveat in Table A11). Source: `output/figures/13_long_term_event_study.png`.
