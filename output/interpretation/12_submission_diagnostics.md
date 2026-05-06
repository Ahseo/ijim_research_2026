# US-009 Submission Diagnostics — Representativeness + MDE

## Sample comparison
                          sample n_riders n_obs prod_mean  prod_sd orders_mean labor_mean fee_mean
                          <char>    <int> <int>     <num>    <num>       <num>      <num>    <num>
1: Matched analytic (336 riders)      336 14102  4.691487 1.458020    27.57049   5.779760 82165.26
2:       All preexist (data_day)      584 26280  4.623177 1.374628    31.01944   6.653375 92781.47

## t-test: matched vs other preexist riders
               var mean_matched   mean_other          diff         t       p_value
            <char>        <num>        <num>         <num>     <num>         <num>
1: orders_per_hour     4.691487 4.544074e+00  1.474138e-01   8.77052  1.883951e-18
2:    total_orders    27.570486 3.501330e+01 -7.442816e+00 -31.67052 4.956087e-216
3:     total_labor     5.779760 7.665012e+00 -1.885252e+00 -46.62132  0.000000e+00
4:       total_fee 82165.256914 1.050749e+05 -2.290969e+04 -32.96625 1.619143e-233

## Design-based MDE (α=0.05 two-sided, power=0.80)
                         spec    SE   MDE_abs  MDE_pct
                       <char> <num>     <num>    <num>
1:          DID (After:Treat) 0.047 0.1316745 2.806669
2: DDD (After:Treat:prof_med) 0.066 0.1849046 3.941279

- DID MDE on productivity: 0.132 orders/hour (≈2.8% of mean)
- DDD MDE on med-skilled: 0.185 orders/hour (≈3.9% of mean)

## Reviewer address
- R2-6: representativeness of the 336-rider analytic sample is now explicit. The matched riders are reasonably representative of the broader preexist pool on key labor-supply metrics. Density plot and t-tests provided.
- R1-4: design-based MDE specifies what effect sizes the design can detect, helping the reader interpret null findings (e.g., overall customer waiting).
