# Manuscript Revision Changelog (v1)

본 changelog는 각 변경의 근거 reviewer 코멘트 ID 와 새 evidence 파일을 매핑한다.

## Section 1 Introduction (`section_1_introduction.md`)

| 변경 | reviewer ID | evidence |
|------|-------------|----------|
| Multi-stage task structure (assignment → stacking → sequencing → routing) 를 boundary condition 으로 명시 | R1-1 | manuscript-exact spec |
| AI 시스템 정의 (revealed preference learning, dynamic match scoring) 본문 내 추가 | R1-2 | docs/03_evidence_log.md |
| "AI creates value" 가정형 → "open question" 으로 톤다운 | R2-1 | — |
| Worker stress / algorithmic bias / autonomy 부재 가능성 명시적 언급 | R2-1 | — |
| Customer-side question 을 worker-side 와 병렬 배치 (Introduction 내) | R2-2 | — |

## Section 2 Related Literature (`section_2_related_literature.md`)

| 변경 | reviewer ID | evidence |
|------|-------------|----------|
| Competing views 비판적 검토 구조 (AI raises vs reduces inequality, conditions) | R2-4 | — |
| Platform-specific 인용 강조 (Knight 2024, Y. Chen 2024, M. Liu 2021, Mao 2025, Gupta 2022) | R2-5 | — |
| Y. Chen et al. (2024a/b) 중복 → 단일 entry | R1-Minor-1 | docs/05_reference_audit.md |

## Section 3 Background (`section_3_background.md`)

| 변경 | reviewer ID | evidence |
|------|-------------|----------|
| AI 시스템의 (i) revealed preference learning, (ii) dynamic match scoring, (iii) automated assignment 명시 | R1-2 | manuscript-exact reproduction |
| 사회적 형평이 시스템 설계 목표가 아니었음 명시 | AE-3 | — |

## Section 4 Empirical Models (`section_4_empirical_models.md`)

| 변경 | reviewer ID | evidence |
|------|-------------|----------|
| FE/clustering 명시: rider_id + station_date FE; cluster rider_id | R1-Minor-3 | docs/03_evidence_log.md |
| Stack-level: + hourDOW FE 명시 | R1-Minor-3 | — |
| Customer waiting: + avg_dist control 명시 | R1-Minor-3 | — |
| Event-study spec 추가 (leads/lags) | R1-3A | output/interpretation/05_event_study.md |
| Dose-response spec (supplementary) 추가 | R1-3B | output/interpretation/07_dose_response.md |

## Section 5 Results (`section_5_results.md`)

| 변경 | reviewer ID | evidence |
|------|-------------|----------|
| Inequality metrics 본문 포함 (Gini, Theil, P90/P10, P75/P25) | R1-Minor-2 | output/tables/09_inequality.csv |
| Customer-side estimand 한정 ("customers served by treated/matched riders") | R1-4 | output/interpretation/11_worker_customer_linkage.md |
| Worker-customer linkage 결과 추가 (mediation 회피, linkage 표현) | AE-2 | output/figures/11_worker_customer_linkage.png |
| Event-study + pre-trend F-test 결과 (F=0.65, p=0.63) | R1-3A, R2-7 | output/interpretation/05_event_study.md |
| Oster bound 결과 (\|delta\*\|≫1, robust) | R1-3C, R2-8, AE-4 | output/interpretation/06_oster_bounds.md |
| Stable workers robustness | R1-3C, R2-8 | output/interpretation/08_stable_workers.md |
| Long-term extension (Dec-Feb) 결과 | AE-4, R2-7 | output/interpretation/13_long_term_extension.md |
| Sample representativeness | R2-6 | output/interpretation/12_submission_diagnostics.md |
| Skill → Proficiency 통일 | AE-1 | docs/04_claims_audit.md |

## Section 6 Discussion (`section_6_discussion.md`)

기존 implication 섹션 분리하여 유지. Conclusion 분리 (R2-11).

## Section 7 Conclusion (신설, `section_7_conclusion.md`) — R2-11

- Theoretical contribution
- Practical / policy implication
- Limitation (single country / single platform / single task / short window / residual selection) — R2-3, R2-10
- Future research

## Skill → Proficiency 일괄 교체 — AE-1

`section_*.md` 전체에 'skill' = 0회 (footnote 정의용 제외).

## 회피 표현 점검 (`docs/04_claims_audit.md`)

- "formal mediation" — 0회
- "platform-wide consumer welfare" — 0회
- "AI promotes social equality" — 0회
- "low-skilled workers benefited the most" (blanket) — 0회
- "single-order waiting time improved" (headline) — 0회

---

## 검증된 핵심 수치 (재확인용)

- Daily productivity DID: **+0.141 *** (≈3.0%)** ✓ manuscript 일치
- DDD med-skilled: **+0.249 *** (≈5.4%)** ✓
- Customer single-order DID: **-0.184 ** (NS for stacked, NS overall)** ✓
- Pre-trend F = 0.65, p = 0.63 (parallel trends supported)
- Oster delta* ≫ 1 (robust)
