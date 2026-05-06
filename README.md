# ijim_research_2026

- 모든 rawdata 링크: https://drive.google.com/drive/folders/1HDO3ByxGIljWx_pHzOnX6G0xyjdteq4z?usp=sharing
- 논문 원문 작성 및 분석을 위한 모든 기존 리소스(코드, .RData파일 등) 링크: https://drive.google.com/drive/folders/19dZFSwOHzrneZcukS-UZl0HK_A1rRHYi?usp=sharing

1. (사전 준비) 논문 원문의 결과 재현
- previous_resource 폴더의 ISR_submitted ver_data.RData 파일의 data_day_matched1, data_shift_matched1을 직접 로드하여 사용하면 논문 원문 내 테이블의 모든 coefficient와
  SE 정확히 재현 가능
- claude가 기존 결과를 재현한게 기존 리소스 링크의 reproduce_from_rdata.R 파일에 있으니 참고하면 빠르게 재현 가능할 것
- 리비전의 모든 추가분석은 기존 리소스 링크의 ISR_submitted ver_data.RData 파일의 data_day_matched1, data_shift_matched1 데이터 셋에서 출발해야함
- 리뷰어 코멘트에서 더 긴 기간 또는 더 많은 샘플에 대한 추가 분석을 요구할 경우 추가 데이터 셋 (recommendation_data_2023.csv, recommendation_data_busan_exclusive_dec_feb.csv, riders_2023.csv, store_2023.csv)을 추가 사용해서 분석 진행 해도됨

2. (리비전) 리뷰어 코멘트 address
-  리뷰어 주요 코멘트 address 및 단계적 논문 수정 계획 세워줘
-  리뷰어 코멘트에 대한 response note 준비도 필요해
-  논문 원문 수정 초안도 작성 부탁해

* 논문 원문, 리뷰어 코멘트 원문, 원본 데이터 등은 유지하고 수정사항들은 새로운 파일/폴더에 추가해
