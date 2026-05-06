# Reviewer Comments — 분류 + Address 전략 매핑

Manuscript: JJIM-D-25-02826 — *Does AI Benefit All Platform Stakeholders? Evidence from Algorithmic Task Assignment in Food Delivery*
Submission deadline: **2026-05-30**

본 문서는 review.docx의 모든 리뷰어 코멘트를 식별자(R1-#, R2-#, AE-#)로 분리하고, 각 코멘트에 대한 **address 전략**을 정리합니다. 응답 전략은 (a) 새로운 분석, (b) 본문 재작성, (c) 명확화/제한 표명 — 세 카테고리 중 하나로 분류됩니다.

---

## Associate Editor (AE)

### AE-1. Theoretical Framework — "labour skill" 정의 문제
> Categorizing workers based solely on their performance prior to AI introduction is potentially misleading. A more accurate classification would be "high," "medium," and "low" performance.

**전략 (b) 본문 재작성:**
- 본문 전체에서 "skill" → "proficiency" 또는 "pre-AI performance" 로 통일.
- 분류 정의를 "사전 기간(1개월) 시간당 주문완료수 분포의 하위/중위/상위 1/3" 으로 명시적으로 문구화.
- "skill" 단어가 인적 자본/일반화된 능력을 함축하지 않도록 footnote 추가.

### AE-2. Research Focus — Customer experience를 노동 관점에서도 봐야
> The measurement of "Customer experience" can be as well viewed from the labour perspective, failing to investigate the actual inter-relationship between customers and workers in the context of AI adoption.

**전략 (a) 새로운 분석 + (b) 본문 재작성:**
- worker–customer linkage 분석 추가: rider productivity → customer waiting time 의 stack-level 매개적 연결.
- Customer 결과를 "AI-driven worker behavior change → customer outcome" 의 연쇄적 framework 로 재배치.
- formal mediation 주장은 회피 (식별 불충분) — "linkage" 표현으로 한정.

### AE-3. Social Impact Claims — AI가 사회적 형평을 추구하지 않음
> If the AI was not designed with social equality as a goal, it is unlikely to produce such an outcome organically.

**전략 (b) 본문 재작성 + (c) 한정:**
- "AI promotes social equality" 류 표현 전면 삭제.
- "Algorithm reduces *observed* productivity dispersion among the matched sample" 정도로 한정.
- AI 시스템의 설계 목표(rider–order match quality + revealed preference)를 더 명확히 기술하고, 형평성은 부수적 결과(by-product)로 frame.

### AE-4. Residual bias + Data duration
> Methodological issues regarding residual effects and data duration are structural and cannot be resolved within a standard revision timeframe.

**전략 (a) 새로운 분석:**
- **Dec–Feb 부산 데이터 (recommendation_data_busan_exclusive_dec_feb.csv) 통합** → 관찰 기간 확장.
- Long-term event-study 추가 (post-AI 3+개월).
- Oster (2019) bound test 적용으로 unobservable selection bound 제시.
- Stable-workers robustness (양 기간 모두 active 한 rider만).

---

## Reviewer #1 (긍정적, 핵심 분석 보강 요구)

### R1-1. Sharper novelty positioning
> The paper currently reads as "AI improves matching and thus productivity"... what makes this paper different from other platform/operational settings.

**전략 (b) 본문 재작성:**
- Introduction + Discussion contribution 부분에 **multi-stage task structure (assignment → stacking → sequencing → routing)** 를 boundary condition 으로 명시.
- 기존 ride-hailing 연구와 달리 본 연구는 *downstream execution heterogeneity* 가 productivity gain 분배를 결정함을 강조.

### R1-2. Define "AI" vs conventional algorithmic dispatch
> Specify what makes the new system AI-driven... versus conventional automated dispatch/optimization.

**전략 (b) 본문 재작성:**
- Section 3 (Background) 에서 도입된 시스템을 다음으로 명시: (i) revealed preference learning (per-rider history), (ii) dynamic match probability scoring, (iii) automated assignment without rider choice. 기존 manual dispatch (broadcast + first-come-first-serve) 와 명확히 차별화.

### R1-3A. Event-study / dynamic DID
> Provide a more explicit event-study or dynamic DID around the rollout... pre-trend diagnostics.

**전략 (a) 새로운 분석:**
- `02_event_study.R` — leads/lags 방식의 event-study 회귀, F-test for joint pre-trend = 0.
- 결과: F=1.41, p=0.229 (재현 검증 후 보고).
- Figure: event-study coefficient plot.

### R1-3B. Dose-response on adoption intensity
> The "ever adopter" indicator can be too coarse... measure AI usage intensity, share of AI-assigned orders or days, dose-response patterns.

**전략 (a) 새로운 분석:**
- `04_dose_response.R` — AI assignment share 를 연속변수로 한 회귀 + non-parametric binscatter.
- 본 분석은 supplementary 로 한정 (선형성 가정 위반 가능).

### R1-3C. Time-varying selection robustness
> Restrict to riders with stable working patterns, alternative matching/reweighting, branch-level adoption patterns.

**전략 (a) 새로운 분석:**
- `05_stable_workers.R` — 양 기간 모두 active 한 rider 만으로 main spec 재추정.
- `03_oster_bounds.R` — Oster delta* 값 (목표 |delta*| > 1) 보고.
- Alternative matching 결과는 이미 Table A6 존재 → robustness narrative 강화.

### R1-4. Consumer-side estimand 명확화 + platform-level evidence
> The consumer-side estimation appears to be attached to the matched rider sample... add platform-level aggregate analyses.

**전략 (a) 새로운 분석 + (b) 한정:**
- 본문/abstract 의 "AI does not benefit customers" → "customers served by *treated/matched* riders" 으로 estimand 한정.
- Branch-day level aggregate waiting time descriptive evidence 추가 (가능한 경우).
- 중요: "platform-wide consumer welfare" 주장 회피.

### R1-Minor-1. Reference duplication
> Multiple entries that appear to refer to the same working paper.

**전략 (b) 본문 재작성:**
- Y. Chen et al. (2024a/b) 중복 제거 → 단일 인용으로 통일.
- Allon et al. (SSRN, 2018) → 가능한 경우 final published version으로 교체.
- Brynjolfsson et al. (2025) 제목 trailing `*` 제거.

### R1-Minor-2. Direct inequality metric (Gini/Theil/P90-P10)
> Consider reporting a more direct inequality metric.

**전략 (a) 새로운 분석:**
- `06_inequality.R` — Gini, Theil index, P90/P10 productivity ratio 사전/사후 비교.
- 결과: Gini 0.181 → 0.152, Theil 0.128 → 0.055 (재현 검증 후).

### R1-Minor-3. Customer regression FE/controls
> Clarify which fixed effects and time controls are used in the consumer waiting time regressions.

**전략 (b) 본문 재작성:**
- Equation 명시 + appendix table 에 FE 상세 기재.

---

## Reviewer #2 (비판적, 데이터 한계 + 구조 개선 요구)

### R2-1. Introduction의 "AI creates value" 가정 선행
> AI "creates value"... asserted before empirical evidence is introduced.

**전략 (b) 본문 재작성:**
- Introduction 첫 문단을 "claims of value" → "open question of value distribution" 으로 톤 다운.
- Worker stress, algorithmic bias, reduced autonomy 가능성을 명시적 언급 + 본 연구가 productivity 차원에 한정됨을 적시.

### R2-2. Customer outcomes의 후순위 처리
> Discussion of customer outcomes is delayed and speculative.

**전략 (b) 본문 재작성:**
- Introduction 에 customer-side question 을 worker-side 와 병렬 배치.
- Hypothesis 도 worker-side / customer-side 두 파트로 명시.

### R2-3. Limitation/research gap 명시 부족
> Does not critically discuss limitations (selection bias, generalizability, cultural context).

**전략 (b) 본문 재작성:**
- Limitation 섹션 확장 (Korea-only, 단일 platform, short window, residual selection).
- Research gap → "platform 환경에서 worker–customer 동시 분석의 부재" 로 명시화.

### R2-4. Critical literature review
> Does not critically evaluate conflicting findings or gaps... why prior results differ.

**전략 (b) 본문 재작성:**
- Section 2 를 "competing views" 구조로 재작성: (i) AI raises inequality vs (ii) AI reduces inequality, 각 view 의 *조건* 을 본 연구가 어떻게 식별하는지 연결.

### R2-5. Platform/gig worker 증거 부족
> Largely draws on general studies of AI in workplaces.

**전략 (b) 본문 재작성:**
- Knight et al. (2024), Y. Chen et al. (2024), M. Liu et al. (2021), Mao et al. (2025), Gupta et al. (2022) 등 platform-specific 인용 강조.

### R2-6. Representativeness of retained 600 riders
> Retaining 600 riders... not discussed how representative.

**전략 (a) 새로운 분석:**
- `09_submission_diagnostics.R` — analytic full sample vs. all active Busan riders 의 4가지 변수(orders/hour, daily orders, labor hours, fee) 비교 표 + density plot.
- Design-based MDE 보고.

### R2-7. 1-month before/after 너무 짧음
> Very short for capturing stable behavioral changes or learning effects.

**전략 (a) 새로운 분석:**
- Dec–Feb 데이터로 long-term event-study (`02_event_study_extended.R`).
- Learning dynamics 분석 (`07_learning_dynamics.R`) — week-by-week coefficient evolution.

### R2-8. Residual selection (motivation, tech-savvy)
> Riders who self-select into AI might have higher motivation, tech-savviness.

**전략 (a) 새로운 분석:**
- Oster bound (`03_oster_bounds.R`).
- Stable workers spec (`05_stable_workers.R`).
- Time-invariant rider FE 강조.

### R2-9. Learning curve empirical evidence 부재
> The learning curve argument is mentioned but no empirical evidence.

**전략 (a) 새로운 분석:**
- `07_learning_dynamics.R` — week-level treatment-effect coefficient time-series + 그룹별 학습 곡선 비교.

### R2-10. External validity (Korea single platform, single task)
> Limits the external validity.

**전략 (b) 본문 재작성:**
- Limitation 섹션에 "single country / single platform / single task" 명시.
- Discussion 에 ride-hailing/grocery 등 다른 platform 으로의 generalization scope 토의.

### R2-11. 별도 Conclusion 섹션 부재
> No proper conclusion section, no theoretical and practical policy implications.

**전략 (b) 본문 재작성:**
- 기존 Section 6 (Discussion) 분리 → Section 6 (Discussion) + Section 7 (Conclusion) 구조.
- Section 7 에 (i) theoretical contribution, (ii) practical/policy implication, (iii) limitation, (iv) future research 정리.

### R2-Other. Language editing
**전략 (c) 명확화:**
- Final pass 에서 native English editing.

---

## 전체 카테고리 요약

| Category | Count | Comments |
|----------|-------|----------|
| (a) 새로운 분석 필요 | 9 | AE-2,4 / R1-3A,3B,3C,4,Minor-2 / R2-6,7,8,9 |
| (b) 본문 재작성 | 14 | AE-1,3 / R1-1,2,4,Minor-1,3 / R2-1,2,3,4,5,10,11 |
| (c) 명확화/한정 | 2 | R1-4 (consumer estimand) / R2-Other |

총 25개 식별 가능 코멘트. 모두 response letter 에서 numbered response 형식으로 address 됨.
