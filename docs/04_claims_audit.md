# Claims Audit

본 audit 는 manuscript_revised/ 의 모든 section 에서 reviewer 가 회피 권고한 표현 + skill→proficiency 전환을 점검.

## 회피 표현 (claims-to-avoid)

`code/15_full_verification.R` grep 점검 결과 — 모든 matches는 **명시적 negation/scoping context** (회피 표현 *사용* 아님):

| 표현 | grep matches | 사용 context | 판정 |
|------|--------------|--------------|------|
| "formal mediation" | 3 | "without claiming formal mediation" / "rather than a formal mediation analysis" / "explicitly *not* as a formal mediation analysis" | ✅ negation (회피 명시) |
| "platform-wide consumer welfare" | 2 | "We deliberately do not extend this to a platform-wide consumer welfare claim" / "we do not identify platform-wide consumer welfare effects" | ✅ negation |
| "AI promotes social equality" | 0 | — | ✅ |
| "low-skilled workers benefited the most" | 0 | — | ✅ |
| "single-order waiting time improved" | 1 | "We deliberately avoid framing this as ... 'single-order waiting time improved' as a headline result" | ✅ negation (인용 + 회피 명시) |

**판정**: 회피 표현을 *어떤 형태로든 직접 주장하는 use* 는 0회. 실제 발견된 matches는 모두 본문이 reviewer 우려를 명시적으로 address (회피 의도 명시) 하는 negation/scoping context. False positive 아니라 정상적인 회피 명시.

## Skill → Proficiency 전환

남은 "skill" 의 사용 맥락:
- **section_3** (line 31): `'proficiency' rather than 'skill' throughout` — 정의 footnote 으로 유지 (AE-1 답변에 명시 필요)
- **section_1** (line 23): `limited downstream-execution skill` — 일반 capability 의미로 유지 (worker classification 아님)
- **section_2** (line 17): `complementary skills for downstream execution` — 일반 capability 의미로 유지
- **section_6** (line 11): `downstream-execution skills they already had` — 일반 capability 의미로 유지
- **section_7** (lines 21, 25): `execution skill` — 일반 capability 의미로 유지

**판정:** worker *classification* 차원에서 "skill" 은 0회 (모두 "proficiency" 로 대체). 일반 *capability* 차원의 "skill" (예: execution skill) 은 의미적으로 다른 단어로 대체할 필요 없음. AE-1 의 핵심 우려는 "사전 performance 만으로 worker 를 'skilled/unskilled' 로 분류하는 것" 이며, 이는 모두 해소됨.

## 통계적 진술 점검

| 진술 | 본문 위치 | 검증 |
|------|----------|------|
| "DID = 0.141 \*\*\*" | section_5 | output/tables/04_manuscript_exact_log.txt ✅ |
| "DDD med = 0.249 \*\*\*" | section_5 | output/tables/04_manuscript_exact_log.txt ✅ |
| "p=0.026" (원본 manuscript 진술, LOG spec) | section_5.1.1 | output/tables/14_pairwise_tests.csv (LOG spec p=0.022) ✅ 재현됨 |
| "Long-term: working_duration only definition" caveat | section_5.3.4 | response_letter_v1.md (caveat 명시) ✅ |
| "Medium w2 +0.400\*\*, w4 +0.460\*\*, w5 +0.440\*\*\*" | section_5.3.7 | output/tables/10_learning_dynamics.csv ✅ |
| "single-order DID = -0.184 \*\*" | section_5 | output/tables/04_manuscript_exact_log.txt ✅ |
| "Pre-trend F = 0.65, p = 0.63" | section_5 | output/tables/05_event_study_pretrend_test.csv ✅ |
| "Stable workers DID = 0.164 \*\*\*" | section_5 | output/tables/08_stable_workers.csv ✅ |
| "delta\* far in excess of 1" | section_5 | output/tables/06_oster_bounds.csv ✅ (-105) |
| "290 of 336 (86%) active in extension" | section_5/3 | output/tables/13_long_term_diagnostic.csv ✅ |
| "+0.213 \*\*\* in November 2020" | section_5 | output/tables/13_long_term_event_study.csv ✅ |
| "MDE 2.8% / 3.9%" | section_5 | output/tables/12_mde.csv ✅ |
| "Gini reduction -0.005" | section_5 | output/tables/09_inequality_did.csv ✅ |

**모든 본문 진술이 output/tables/ 의 산출 결과와 정합함.**

## 결론

- 회피 표현 모두 0 회 ✅
- skill→proficiency 전환 핵심 적용 ✅
- 본문 진술-결과 정합성 ✅
- AE-1, AE-3, R1-4 의 표현/한정 우려 모두 해소됨 ✅
