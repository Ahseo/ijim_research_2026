# US-003 Oster (2019) Bound — Productivity

## Approach
- Restricted model: `orders_per_hour ~ After:Treat | rider_id + station_date`
- Full model: + observable controls (share_aggshift + share_singleshift + share_failedorders)
- Conservative R_max = 1.3 × R²_full (Oster 2019 recommendation)

## Results
- β (restricted): 0.1406
- β (full):       0.1409
- R² (restricted): 0.6592
- R² (full):       0.7063
- β* (bias-adjusted under R_max): 0.1422
- **delta\* = -105.2029**
- |delta\*| > 1 → selection on unobservables would need to exceed selection on observables to nullify the effect: ROBUST.

## Reviewer address
- R1-3C / R2-8 / AE-4: provides explicit selection-on-unobservables sensitivity bound. The DID estimate is robust under conservative R_max assumption (β*'s sign preserves), with delta* exceeding 1 (rule of thumb).
