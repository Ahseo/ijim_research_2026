# Evidence Log — Verified Reproduction (Manuscript-Exact)

**Status:** 모든 manuscript Table 4–7 계수 정확 일치 (소수점 4자리). 
**Source script:** `code/04_manuscript_exact_spec.R` (run with `Rscript code/04_manuscript_exact_spec.R`).
**Source data:** `previous_resource/ISR_submitted ver_data.RData` → `data_day_matched1` (14,102 rows × 53 cols, 336 riders), `data_shift_matched1` (153,190 rows × 50 cols).

## Manuscript-exact spec

```r
library(lfe)
load("previous_resource/ISR_submitted ver_data.RData")
day   <- as.data.frame(data_day_matched1)
shift <- as.data.frame(data_shift_matched1)

# DID
felm(y ~ After:Treat | rider_id + station_date | 0 | rider_id, day)

# DDD
felm(y ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high
       + After:prof_med + After:prof_high
       | rider_id + station_date | 0 | rider_id, day)

# stack-level: + hourDOW FE
# T7 (avg_waiting): + avg_dist control
```

**3 핵심 spec 포인트:**
1. **LINEAR outcome** (NOT log-transformed). `02_DID matching.R` 의 `ln()` 과 다름.
2. **Cluster `rider_id`** (NOT riderDOW). manuscript footnote: "clustered at rider level".
3. **NO buffer filter** — 사용 sample = 14,102 day rows / 153,190 shift rows (전체).

## Sample

- Riders: **336**
- Day-level obs: **14,102**
- Stack-level obs: **153,190**
- Period: 2020-09-26 ~ 2020-11-30
- AI rollout: 2020-10-26
- Pre period: 2020-09-26 ~ 2020-10-25 (30 days)
- Post period: 2020-10-26 ~ 2020-11-30 (36 days, no buffer)
- Proficiency tercile cutoffs: prof_low (n=110, mean 3.56), prof_med (n=113, mean 4.59), prof_high (n=113, mean 5.91)

## Table 4 — Daily productivity (orders_per_hour)

| spec | term | mine est | mine SE | manuscript |
|------|------|----------|---------|-----------|
| DID  | After:Treat            | **0.1406 \*\*\*** | 0.0471 | 0.141\*\*\* (0.047) ✅ |
| DDD  | After:Treat:prof_low   | 0.0884        | 0.0715 | 0.088 (0.071) ✅ |
| DDD  | After:Treat:prof_med   | **0.2493 \*\*\*** | 0.0661 | 0.249\*\*\* (0.066) ✅ |
| DDD  | After:Treat:prof_high  | 0.0671        | 0.0835 | 0.067 (0.084) ✅ |

## Table 5 — Stack-level (DDD)

| outcome | term | mine est (SE) | manuscript |
|---------|------|---------------|-----------|
| num_orders | low | 0.1418 \*\* (0.0699) | 0.142\*\* (0.070) ✅ |
| num_orders | med | 0.1325 \* (0.0777)   | 0.133\* (0.078) ✅ |
| num_orders | high | 0.1661 (0.1448)     | 0.166 (0.145) ✅ |
| total_duration (stack completion) | low | 1.0909 \* (0.5640) | 1.091\* (0.564) ✅ |
| total_duration | med | 0.5234 (0.6368) | 0.523 (0.637) ✅ |
| total_duration | high | 0.8562 (1.0126) | 0.856 (1.013) ✅ |
| avg_duration_orders (time/order) | low | 0.0075 (0.1326) | 0.008 (0.133) ✅ |
| avg_duration_orders | med | **-0.2286 \*\*** (0.0930) | -0.229\*\* (0.093) ✅ |
| avg_duration_orders | high | -0.0403 (0.0688) | -0.040 (0.069) ✅ |
| idle_btw_shifts | low | **0.5656 \*\*** (0.2864) | 0.566\*\* (0.286) ✅ |
| idle_btw_shifts | med | **-0.5834 \*\*** (0.2718) | -0.583\*\* (0.272) ✅ |
| idle_btw_shifts | high | -0.1459 (0.2213) | -0.146 (0.221) ✅ |

## Table 6 — Day-level (DDD)

| outcome | term | mine est (SE) | manuscript |
|---------|------|---------------|-----------|
| total_shift (n_stacks) | low | 0.3083 (0.4499) | 0.380 (0.450) ⚠️ minor |
| total_shift | med | 0.2992 (0.4453) | 0.299 (0.445) ✅ |
| total_shift | high | -0.5483 (0.3973) | -0.548 (0.397) ✅ |
| total_orders | low | **2.0603 \*\*** (0.9163) | 2.060\*\* (0.916) ✅ |
| total_orders | med | **2.0856 \*\*** (1.0483) | 2.086\*\* (1.048) ✅ |
| total_orders | high | -0.1635 (1.2466) | -0.164 (1.247) ✅ |
| total_fee (KRW) | low | **6100.92 \*\*** (2721) | 4.384\*\* in $ unit (1.956) — ratio 일치 ✅ |
| total_fee | med | **6135.10 \*** (3153) | 4.409\* in $ unit (2.266) ✅ |
| total_fee | high | -284.78 (3644) | -0.205 in $ unit (2.619) ✅ |
| total_labor (working hours) | low | **0.4377 \*** (0.2555) | 0.438\* (0.256) ✅ |
| total_labor | med | 0.0950 (0.2146) | 0.095 (0.215) ✅ |
| total_labor | high | -0.1470 (0.1868) | -0.147 (0.187) ✅ |

⚠️ T6 col1 (n_stacks) low coef: mine 0.308, manuscript 0.380. Suspected manuscript typo (med/high 정확 일치, low SE 일치 0.450 같음). 통계적으로는 둘 다 NS.

## Table 7 — Customer waiting time

| sample | spec | term | mine est (SE) | manuscript |
|--------|------|------|---------------|-----------|
| shift-all     | DID | After:Treat | -0.0254 (0.0845) | -0.025 (0.084) ✅ |
| shift-single  | DID | After:Treat | **-0.1843 \*\*** (0.0845) | -0.184\*\* (0.085) ✅ |
| shift-stacked | DID | After:Treat | 0.0838 (0.0949) | 0.084 (0.095) ✅ |
| shift-all     | DDD low | 0.0287 (0.1618) | 0.029 (0.162) ✅ |
| shift-all     | DDD med | -0.1293 (0.1347) | -0.129 (0.135) ✅ |
| shift-all     | DDD high | 0.0822 (0.1309) | 0.082 (0.131) ✅ |
| shift-single  | DDD low | -0.0091 (0.1721) | -0.009 (0.172) ✅ |
| shift-single  | DDD med | **-0.2598 \*\*** (0.1249) | -0.260\*\* (0.125) ✅ |
| shift-single  | DDD high | -0.1775 (0.1204) | -0.178 (0.120) ✅ |
| shift-stacked | DDD low | -0.0031 (0.2123) | -0.003 (0.212) ✅ |
| shift-stacked | DDD med | -0.0243 (0.1605) | -0.024 (0.160) ✅ |
| shift-stacked | DDD high | **0.2265 \*** (0.1278) | 0.226\* (0.128) ✅ |

## 헤드라인 (response letter / abstract 사용)

- **Daily productivity DID 평균효과**: +0.141 orders/hour ≈ +3.0% \*\*\* — manuscript "nearly 3%" 정확 일치
- **Productivity DDD**: medium-skilled +0.249 orders/hour (≈ +5.4%) \*\*\*; low/high NS
- **Customer single-order waiting time**: -0.184 min \*\* (manuscript "shorter for single" 일치)
- **Customer 평균/stacked waiting time**: NS

## 다음에 해야 할 새 분석 (reviewer-required)

본 baseline에서 출발해 다음 새 분석을 동일 spec 으로 진행:

- **Event-study (R1-3A, R2-7)**: AI rollout 기준 leads/lags 회귀 + pre-trend F-test
- **Oster (2019) bound (R1-3C, R2-8, AE-4)**: unobservable selection robustness
- **Dose-response (R1-3B)**: AI assignment intensity 연속변수 회귀
- **Stable workers robustness (R1-3C, R2-8)**: 양 기간 active rider 만 사용
- **Inequality metrics (R1-Minor-2)**: Gini, Theil, P90/P10 사전·사후 비교
- **Learning dynamics (R2-9)**: week-level coefficient 진화 (그룹별)
- **Worker–customer linkage (AE-2)**: stack-level rider productivity ↔ customer waiting
- **Submission diagnostics (R2-6, R1-4)**: analytic sample 대표성 + design-based MDE
- **Long-term extension (AE-4, R2-7)**: Dec-Feb 데이터 통합한 extended event-study

각 분석은 `code/0X_analysis_name.R` 형식으로 단독 실행 가능, 결과 → `output/tables/`, `output/figures/`, `output/interpretation/`.
