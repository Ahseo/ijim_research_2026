# US-002 Event-study (Productivity)

## Spec
- Outcome: `orders_per_hour` (LINEAR; manuscript-exact)
- Leads/lags: Treat × {wb5, wb4, wb3, wb2, w1, w2, w3, w4, w5} (wb1 = reference)
- FE: rider_id + station_date; cluster: rider_id
- Sample: data_day_matched1 (336 riders, 14,102 day-rows)

## Pre-trend F-test
Joint H0: Treat:wb5 = Treat:wb4 = Treat:wb3 = Treat:wb2 = 0
F = 0.645, p = 0.631 → no significant pre-trend (parallel trends supported)

## Coefficients (LINEAR, orders/hour)
    week_label    estimate         se     p_value
        <char>       <num>      <num>       <num>
 1:        wb5 -0.02179979 0.09863598 0.825217312
 2:        wb4 -0.02930658 0.09189928 0.750001935
 3:        wb3  0.08086599 0.08084684 0.317917807
 4:        wb2  0.05754808 0.07460142 0.441009332
 5:  wb1 (ref)  0.00000000         NA          NA
 6:         w1  0.10087534 0.07634846 0.187320016
 7:         w2  0.08138178 0.08423729 0.334690253
 8:         w3  0.07823199 0.07484531 0.296661527
 9:         w4  0.25713010 0.08425935 0.002457708
10:         w5  0.32380662 0.08939039 0.000337102

## Reviewer address
- R1-3A: dynamic DID estimates provided; pre-trends jointly tested (above)
- R2-7: while observation window is still 1-month before/after, the event-study form makes the dynamic effects (and their stability) transparent. Long-term extension via Dec-Feb data (US-010) supplements this.
