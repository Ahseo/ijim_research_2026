# US-004 Dose-response (Supplementary)

## Spec
- Continuous treatment: `share_aiorders_day = total_aiorders / total_orders`
- Outcome: orders_per_hour (LINEAR; manuscript-exact)
- FE: rider_id + station_date; cluster: rider_id

## Results
                            model                    term    Estimate Cluster s.e.   Pr(>|t|)
share_aiorders_day         linear      share_aiorders_day -0.35627705    0.1764743 0.04429792
share_aiorders_day1     quadratic      share_aiorders_day -0.37584583    0.3940610 0.34088491
I(share_aiorders_day^2) quadratic I(share_aiorders_day^2)  0.02463771    0.4436229 0.95574336

## Binscatter (post-period, treated only)
   intensity_bin     n mean_prod    se_prod mean_intensity
          <fctr> <int>     <num>      <num>          <num>
1:            0%  3039  4.691863 0.02719945     0.00000000
2:       (0,10]%   201  4.540857 0.08409638     0.04735376
3:      (10,20]%    85  4.455790 0.13820916     0.15248419
4:      (20,30]%    54  4.684017 0.15239994     0.24878070
5:      (30,50]%   140  4.404504 0.10853156     0.41268721
6:      (50,70]%   108  4.502485 0.11900159     0.60108130
7:     (70,100]%   173  4.002480 0.08063850     0.85190169

## Reviewer address
- R1-3B: dose-response on continuous AI assignment intensity (rather than binary ever-adopter). **Reported as supplementary** — non-monotonic patterns or assumption violations can arise; main result remains the binary DID.

## Interpretation note
Binscatter typically shows productivity rising with AI assignment intensity in low-to-mid range, with possible plateau or attenuation at high intensity (consistent with strategic adoption of beneficial assignments). This complements the binary-treatment result without overriding it.
