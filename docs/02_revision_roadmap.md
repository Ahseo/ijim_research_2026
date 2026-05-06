# Revision Roadmap — 단계별 실행 계획

목표: **2026-05-30 deadline 까지 reviewer 코멘트 전부 address + revision 받을 수 있는 완전한 패키지 완성.**

각 단계는 OMC ralph 가 검증 가능하도록 구체적 산출물(deliverable) + acceptance criteria 를 갖습니다.

---

## Phase 0. 환경 셋업 (✅ 완료)

- [x] `ijim_research_2026/` 폴더 구조 (data/, code/, docs/, output/, response/, manuscript_revised/, previous_resource/)
- [x] Downloads 리소스 → previous_resource/ (R 스크립트 + RData)
- [x] csv 데이터 → data/raw/
- [x] manuscript / review docx → 텍스트 추출 (docs/00_*.md)
- [x] reviewer 코멘트 매핑 (docs/01_reviewer_comments_mapped.md)
- [x] OMC PRD 작성 (.omc/prd.json)

---

## Phase 1. 원본 결과 재현 (Reproduction)

**목적:** 모든 추가 분석의 출발점은 원문과 동일한 baseline 결과. 재현이 안 되면 어떤 추가 분석도 의미가 없음.

### 1.1 Data load 검증
- `previous_resource/ISR_submitted ver_data.RData` 로딩
- `data_day_matched1`, `data_shift_matched1` 객체 존재 확인
- 기본 통계 (n_riders, n_rider-days, 관측기간) 출력

### 1.2 원문 Table 4 재현 (productivity DID/DDD)
- DID coefficient ~ 0.03 (3% 증가)
- DDD: medium-skilled 의 interaction 만 유의

### 1.3 원문 Table 5 재현 (stack-level)
- 주문수↑, idle time 감소(medium), 증가(low)

### 1.4 원문 Table 6 재현 (day-level)
- 일일 주문수, 수입 ↑ (low + medium)
- 노동시간: low 만 ↑

### 1.5 원문 Table 7 재현 (waiting time)
- 평균 waiting: 무의미
- single-order: 감소

**Acceptance Criteria:**
- 모든 main coefficient 가 원문 ±5% 이내 일치
- SE 가 원문과 동일한 cluster level (rider) 로 보고
- `code/01_reproduce_results.R` 실행만으로 재현 가능
- `output/tables/01_reproduction_*.csv` 생성

---

## Phase 2. 핵심 새 분석 추가 (Reviewer-required)

각 분석은 R 스크립트로 standalone 실행 가능, output 은 `output/tables/`, `output/figures/`, `output/interpretation/` 에 저장.

### 2.1 Event-study (R1-3A, R2-7)
- Script: `code/02_event_study.R`
- 결과: leads/lags coefficient + F-test for pre-trend
- 산출물: 회귀표 + figure + 1-page interpretation note

### 2.2 Oster bounds (R1-3C, R2-8)
- Script: `code/03_oster_bounds.R`
- 결과: delta* 값 보고 (목표 |delta*| > 1)
- 산출물: 표 + interpretation note

### 2.3 Dose-response (R1-3B)
- Script: `code/04_dose_response.R`
- 결과: AI assignment intensity 의 비선형 영향
- 산출물: binscatter + 회귀 + interpretation note (supplementary로 한정)

### 2.4 Stable workers (R1-3C, R2-8)
- Script: `code/05_stable_workers.R`
- 결과: 양 기간 active rider 만으로 재추정
- 산출물: 표 + interpretation note

### 2.5 Inequality metrics (R1-Minor-2)
- Script: `code/06_inequality.R`
- 결과: Gini, Theil, P90/P10 사전/사후 비교
- 산출물: 표 + density plot + interpretation note

### 2.6 Learning dynamics (R2-9)
- Script: `code/07_learning_dynamics.R`
- 결과: week-by-week coefficient (그룹별)
- 산출물: figure + interpretation note

### 2.7 Worker–customer linkage (AE-2)
- Script: `code/08_worker_customer_linkage.R`
- 결과: rider productivity → customer waiting time 의 stack-level 연결
- formal mediation 회피, "linkage" 용어 사용
- 산출물: 표 + interpretation note

### 2.8 Submission diagnostics (R2-6, R1-4)
- Script: `code/09_submission_diagnostics.R`
- 결과 (a): analytic sample vs Busan active rider 분포 비교
- 결과 (b): MDE benchmark
- 산출물: 표 + density plot + interpretation note

### 2.9 (선택) Long-term extension — Dec–Feb 데이터 (AE-4, R2-7)
- Script: `code/02_event_study_extended.R`
- 데이터: `data/raw/recommendation_data_busan_exclusive_dec_feb.csv`
- 결과: 3+개월 post-AI event study
- 결과 비교: 1-month vs extended sample 의 coefficient stability
- 산출물: 표 + figure + interpretation note

**Acceptance Criteria (Phase 2 전체):**
- 9개 분석 모두 standalone R script 로 재현 가능
- 모든 결과가 `output/interpretation/` 에 1-page note 형식으로 정리됨
- 본문에 사용 가능한 final number 가 docs/03_evidence_log.md 에 정리됨

---

## Phase 3. Manuscript Revision Draft

**원본 보존, 새 폴더에 작업.** `manuscript_revised/` 에서 진행.

### 3.1 Section 1 (Introduction) 재작성
- (R1-1) sharper novelty positioning: multi-stage task structure 강조
- (R1-2) AI vs algorithmic dispatch 정의
- (R2-1) "creates value" 가정 톤다운
- (R2-2) customer-side question 병렬 배치

### 3.2 Section 2 (Related Literature) 재작성
- (R2-4) competing views 비판적 검토
- (R2-5) platform-specific evidence 강조
- (R1-Minor-1) 중복 인용 정리

### 3.3 Section 3 (Background) 보완
- (R1-2) AI 시스템 정의 명확화 (revealed preference, dynamic match scoring)
- (AE-3) 사회적 형평이 시스템 설계 목표 아니었음을 명시

### 3.4 Section 4 (Empirical Models) 보완
- (R1-Minor-3) FE/clustering 명세
- (R1-3) event-study + dose-response 명세 추가

### 3.5 Section 5 (Results) 확장
- 5.1: 기존 + (R1-Minor-2) inequality metric (Gini/Theil/P90-P10)
- 5.2: 기존 + (R1-4) consumer estimand 명확화 + (AE-2) worker–customer linkage
- 5.3: 기존 robustness + Oster + stable workers + (R2-7) extended long-term + (R2-6) representativeness

### 3.6 Section 6 (Discussion) 분리
- 본문 implication 만 유지

### 3.7 Section 7 (Conclusion) 신설 (R2-11)
- (i) theoretical contribution
- (ii) practical/policy implication
- (iii) limitation (R2-3, R2-10): Korea-only, single platform, short window, residual selection
- (iv) future research

### 3.8 Skill → Proficiency 통일 (AE-1)
- 본문/표/figure 전체에 "skill" → "proficiency" 또는 "pre-AI performance" 로 일괄 교체.
- Footnote: 분류 기준 명시

**Acceptance Criteria (Phase 3 전체):**
- `manuscript_revised/manuscript_v1.md` (또는 .docx) 생성
- 모든 reviewer 코멘트 ID 가 매핑된 changelog (`manuscript_revised/changelog.md`)
- 원본 manuscript .docx 는 `Manuscript/` 에 그대로 보존

---

## Phase 4. Response Letter

각 reviewer 코멘트에 numbered response.

### 4.1 형식
- Cover letter (editor-facing)
- Reviewer #1 responses (1-1 ~ Minor-3)
- Reviewer #2 responses (1 ~ 11)
- Associate Editor responses (AE-1 ~ AE-4)

### 4.2 각 response 의 표준 구조
1. **[Original comment]** 인용
2. **[Our response]** 어떻게 address 했는지
3. **[Manuscript revision]** 어느 섹션/페이지/줄에서 변경되었는지
4. **[New evidence]** 새 분석 결과 (있는 경우)

**Acceptance Criteria:**
- `response/response_letter_v1.md` 생성
- 25개 코멘트 모두 매핑된 numbered response 존재
- 각 response 에 manuscript section 참조

---

## Phase 5. Final Submission Readiness Check

### 5.1 Reference audit
- (R1-Minor-1) Chen 2024a/b 중복 제거
- Allon 2018 SSRN → final published version 검색
- Brynjolfsson 2025 `*` 제거
- 모든 reference 가 본문에 인용되는지 verify

### 5.2 Claims-to-avoid 점검
- "formal mediation"
- "platform-wide consumer welfare"
- "AI promotes social equality"
- "single-order waiting time improved" 가 headline 으로 노출되는지
- "low-skilled workers benefited the most" 류 표현

### 5.3 결과-본문 정합성
- 본문의 모든 숫자가 `output/tables/` 의 산출 결과와 일치하는지
- Confidentiality 조항 (mean/SD 비공개) 위배 없음

**Acceptance Criteria:**
- `docs/99_submission_readiness_check.md` 모든 항목 ✅
- 원본 파일 (manuscript .docx, review .docx, raw csv, RData) 전부 그대로 존재

---

## Ralph 실행 가이드

PRD 는 `.omc/prd.json` 에 위 Phase 들을 user story 단위로 분해.

`/ralph` 실행 시:
1. `.omc/prd.json` 의 첫 미완료 story 를 픽업
2. acceptance criteria 별 검증
3. story 완료 후 다음 story
4. 모든 story `passes: true` 가 될 때까지 반복

**원칙:**
- 원본 파일 (Manuscript/, Review/, data/raw/, previous_resource/RData) 절대 수정 금지
- 모든 산출물은 새 폴더 (output/, manuscript_revised/, response/, docs/) 에만
- R 분석은 standalone script + reproducibility 우선
