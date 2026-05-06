# US-005 Stable Workers Robustness

## Stability rule
Rider must have ≥ 7 working-days in BOTH the 30-day pre and the 30-day post window.
- Original sample: 336 riders
- Stable sample: 283 riders (84.2% retained)
- Stable rider-day observations: 13250

## Comparison: full vs stable sample (productivity)
              spec        est
            <char>      <num>
1:        DID full 0.14059971
2:      DID stable 0.16397454
3:    DDD low full 0.08838331
4:  DDD low stable 0.08343051
5:    DDD med full 0.24929948
6:  DDD med stable 0.28226093
7:   DDD high full 0.06709169
8: DDD high stable 0.10437011

## Reviewer address
- R1-3C / R2-8: restricting to stable workers controls for selective attrition. The headline pattern (med-skilled benefit, low/high not significant) is preserved on the stable sub-sample, alleviating concerns that the result is driven by entry/exit composition changes.
