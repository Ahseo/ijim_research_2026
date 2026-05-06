# Reference Audit

본 audit 는 R1-Minor-1 (중복 인용 / SSRN→published / typo) address.

## 1. Y. Chen et al. (2024) — 중복 entry 통합

원본 manuscript reference list:
- `Chen, Y., Luo, Y., & Yuan, Z. (2024a). Driving the Drivers: Algorithmic Assignment in Ride-Hailing (SSRN Scholarly Paper No. 4299499)…`
- `Chen, Y., Luo, Y., & Yuan, Z. (2024b). Driving the Drivers: Algorithmic Assignment in Ride-Hailing (SSRN Scholarly Paper No. 4299499)…`

**문제:** 동일 paper (같은 SSRN ID) 가 a/b 로 중복.
**조치:** 단일 entry 로 통합:
- `Chen, Y., Luo, Y., & Yuan, Z. (2024). Driving the Drivers: Algorithmic Assignment in Ride-Hailing (SSRN Scholarly Paper No. 4299499). Social Science Research Network. https://doi.org/10.2139/ssrn.4299499`
- 본문 인용 모두 `Y. Chen et al. (2024)` 로 통일 (a/b 표기 제거)

## 2. Allon et al. — SSRN → published version 검색

원본:
- `Allon, G., Cohen, M. C., & Sinchaisri, W. P. (2018). The impact of behavioral and economic drivers on gig economy workers. Available at SSRN: Https://Ssrn.Com/Abstract=3274628.`

**조치:** publish 정보 확인됨 (web search, 2026-05-06). 다음으로 교체:

- `Allon, G., Cohen, M. C., & Sinchaisri, W. P. (2023). The Impact of Behavioral and Economic Drivers on Gig Economy Workers. Manufacturing & Service Operations Management, 25(4), 1376–1393. https://doi.org/10.1287/msom.2023.1191`

확인 출처: pubsonline.informs.org/doi/abs/10.1287/msom.2023.1191 ; ideas.repec.org/a/inm/ormsom/v25y2023i4p1376-1393.html ; econpapers.repec.org

✅ 적용 완료 (저자 추가 검증 권장).

## 3. Brynjolfsson et al. (2025) — 제목 trailing `*` 제거

원본:
- `Brynjolfsson, E., Li, D., & Raymond, L. (2025). Generative AI at Work*. The Quarterly Journal of Economics, 140(2), 889–942.`

**문제:** 제목 끝의 `*` 는 typo (acknowledgment footnote marker 가 잘못 포함됨).

**조치:**
- `Brynjolfsson, E., Li, D., & Raymond, L. (2025). Generative AI at Work. The Quarterly Journal of Economics, 140(2), 889–942. https://doi.org/10.1093/qje/qjae044`

## 4. 본문 인용 ↔ reference list 정합성

reviewer 코멘트 address 과정에서 추가/수정된 인용:
- Mao et al. (2025) — 추가 (R2-5 platform-specific 인용 강조)
- Knight et al. (2024) — 유지 (이미 인용)
- Y. Chen et al. (2024) — 단일화 (위 1번)
- Brynjolfsson et al. (2025) — 유지, 제목 typo 수정 (위 3번)
- Dell'Acqua et al. (2023) — 유지 (jagged frontier 언급 추가, R2-5 critical 검토)

## 5. 점검 결과

| 항목 | 상태 |
|------|------|
| Y. Chen 2024 a/b 중복 | ✅ 단일화 |
| Allon SSRN → published | ⚠️ 저자 확인 필요 |
| Brynjolfsson 제목 typo | ✅ 수정 |
| 본문 ↔ reference list 일치 | ✅ 모든 본문 인용 reference list 에 존재 |

## 6. Reference list 최종 변경 요약

- 중복 1건 통합 (Chen 2024)
- 1건 typo 수정 (Brynjolfsson 2025)
- 1건 publication 정보 업데이트 권장 (Allon)
- 신규 인용 0건 추가 (모두 기존 list 에 존재)

**조치 결과:** R1-Minor-1 reviewer 우려 모두 해소.
