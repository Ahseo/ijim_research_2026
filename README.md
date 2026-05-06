# ijim_research_2026

JJIM-D-25-02826 — *Does AI Benefit All Platform Stakeholders?* major revision workspace.
Submission deadline: **2026-05-30**.

## 0. 리소스 링크 (외부)

- 모든 rawdata: https://drive.google.com/drive/folders/1HDO3ByxGIljWx_pHzOnX6G0xyjdteq4z?usp=sharing
- 기존 리소스(코드, .RData): https://drive.google.com/drive/folders/19dZFSwOHzrneZcukS-UZl0HK_A1rRHYi?usp=sharing

## 1. 폴더 구조

```
ijim_research_2026/
├── Manuscript/                  # 원본 (수정 금지)
│   └── Algorithmic task assignment_manuscript_final.docx
├── Review/                      # 원본 (수정 금지)
│   └── review.docx
├── previous_resource/           # 원본 R 스크립트 + RData (수정 금지)
│   ├── ISR_submitted ver_data.RData   (data_day_matched1, data_shift_matched1)
│   └── *.R   (기존 분석 코드 22개)
├── data/
│   ├── raw/                     # 원본 csv (수정 금지)
│   └── processed/               # 가공 산출 (regenerable)
├── code/                        # 새 R 분석 스크립트
├── docs/                        # 리뷰어 코멘트 매핑, roadmap, audit
├── output/
│   ├── tables/
│   ├── figures/
│   └── interpretation/
├── manuscript_revised/          # 수정 본문 초안
├── response/                    # response letter
├── .omc/                        # OMC Ralph state (prd.json, progress.txt)
├── CLAUDE.md
└── README.md
```

## 2. 핵심 문서

| 파일 | 역할 |
|------|------|
| `docs/00_review_extracted.md` | review.docx 텍스트 추출 |
| `docs/00_manuscript_extracted.md` | manuscript .docx 텍스트 추출 |
| `docs/01_reviewer_comments_mapped.md` | 25개 reviewer 코멘트 (R1-#, R2-#, AE-#) + address 전략 |
| `docs/02_revision_roadmap.md` | Phase 0–5 단계별 계획 |
| `.omc/prd.json` | OMC Ralph 용 21개 user stories |

## 3. 재현 시작점

```r
load("previous_resource/ISR_submitted ver_data.RData")
# 사용: data_day_matched1, data_shift_matched1
```

장기 확장 분석은 `data/raw/recommendation_data_busan_exclusive_dec_feb.csv` 사용.

## 4. Ralph 실행

```
/ralph "address all reviewer comments per .omc/prd.json"
```

Ralph 가 `.omc/prd.json` 의 user story 를 순서대로 검증하며 진행.

## 5. 원본 보존 원칙

- `Manuscript/`, `Review/`, `previous_resource/`, `data/raw/` 의 모든 파일 **수정 금지**.
- 모든 산출물은 `code/`, `docs/`, `output/`, `manuscript_revised/`, `response/`, `.omc/` 에만 작성.
