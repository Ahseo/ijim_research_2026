
========== Table #1 (11r × 6c) ==========
 | Variable | Definition | Mean | Standard|deviation | Coefficient of variation
Stack-level | Number of orders | The number of orders delivered in a stack | 2.871 | 3.676 | 1.280
 | Stack completion time | The time between the assignment of the first order and the drop-off of the last order in a stack (mins) | 29.597 | 32.987 | 1.115
 | Average processing time | The average time to process an order in a stack from the rider-side (Stack completion time/Number of orders) (mins) | 11.374 | 4.399 | 0.387
 | Idle time | The time between stacks (mins) | 8.796 | 11.436 | 1.300
 | Customer waiting time | The average time between order placement and delivery completion per order in a stack from the customer-side (mins) | 16.560 | 6.822 | 0.412
Day-level | Total stacks | The number of stacks completed in a day | 10.803 | 6.737 | 0.624
 | Total orders | The number of orders delivered in a day | - | - | 0.626
 | Total earnings | The total earnings from delivery fees in a day ($) | - | - | 0.619
 | Working hours | The total amount of time spent delivering orders and idling in search for new orders (hours) | 6.653 | 3.408 | 0.512
 | Productivity | The number of completed orders per working hour | 4.623 | 1.375 | 0.297

========== Table #2 (18r × 5c) ==========
 |  | Rider group | Rider group | Rider group
 | Variable | Low-skilled | Medium-skilled | High-skilled
Stack-level | Number of orders | 2.187 | 3.135 | 4.688
 |  | (0.720) | (1.431) | (2.719)
 | Stack completion time (mins) | 28.485 | 34.739 | 41.847
 |  | (10.536) | (18.410) | (25.279)
 | Average processing time (mins) | 14.025 | 11.683 | 9.766
 |  | (2.580) | (1.701) | (1.413)
 | Idle time (mins) | 11.371 | 9.042 | 7.417
 |  | (4.113) | (3.658) | (3.371)
 | Customer waiting time (mins) | 19.343 | 18.094 | 16.463
 |  | (4.200) | (4.554) | (4.318)
Day-level | Total stacks | 10.605 | 10.318 | 9.636
 |  | (4.930) | (6.315) | (5.433)
 | Working hours (hours) | 6.334 | 6.235 | 6.586
 |  | (2.664) | (2.693) | (2.796)
 | Productivity | 3.576 | 4.568 | 5.864
 |  | (0.483) | (0.212) | (0.753)

========== Table #3 (14r × 9c) ==========
 | Before matching | Before matching | Before matching | Before matching | After matching | After matching | After matching | After matching
Variable | Control | Treat | Difference | t-value | Control | Treat | Difference | t-value
Week-level |  |  |  |  |  |  |  | 
Number of working days | 4.849 | 5.288 | 0.438 | 3.288 | 4.948 | 4.815 | 0.132 | 0.806
Day-level |  |  |  |  |  |  |  | 
Number of unique restaurants | 14.811 | 14.977 | 0.166 | 0.226 | 14.389 | 13.826 | 0.563 | 0.644
Working hours | 5.492 | 6.794 | 1.302 | 5.656 | 5.585 | 5.491 | 0.094 | 0.329
Idle hours | 1.190 | 1.236 | 0.046 | 0.648 | 1.235 | 1.211 | 0.024 | 0.270
Stack-level |  |  |  |  |  |  |  | 
Number of orders | 3.012 | 3.479 | 0.467 | 2.597 | 2.846 | 2.820 | 0.026 | 0.144
Stack completion time (mins) | 29.320 | 37.606 | 8.286 | 5.234 | 28.757 | 29.186 | 0.429 | 0.261
Idle time (mins) | 9.155 | 9.342 | 0.187 | 0.493 | 9.431 | 9.820 | 0.389 | 0.774
Customer waiting time (mins) | 16.455 | 18.667 | 2.212 | 5.528 | 16.574 | 17.317 | 0.743 | 1.479
# of riders | 183 | 399 |  |  | 168 | 168 |  | 

========== Table #4 (15r × 4c) ==========
Variables | Daily productivity | Daily productivity | 
 | (1) | (2) | 
AfterTreat | 0.141*** |  | 
 | (0.047) |  | 
AfterTreatLow |  | 0.088 | 
 |  | (0.071) | 
AfterTreatMedium |  | 0.249*** | 
 |  | (0.066) | 
AfterTreatHigh |  | 0.067 | 
 |  | (0.084) | 
Rider FE | Yes | Yes | 
Branch-date FE | Yes | Yes | 
Adj. R-squared | 0.604 | 0.605 | 
Observations | 14,102 | 14,102 | 
Notes: Robust standard errors clustered at rider level in parentheses.|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses.|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses.|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses.|  ***p < 0.01; **p < 0.05; * p<0.1

========== Table #5 (13r × 5c) ==========
Variables | (1)|Number of orders | (2)|Stack completion time|(mins) | (3)|Average processing time|(mins) | (4)|Idle time|(mins)
AfterTreatLow | 0.142** | 1.091* | 0.008 | 0.566**
 | (0.070) | (0.564) | (0.133) | (0.286)
AfterTreatMedium | 0.133* | 0.523 | -0.229** | -0.583**
 | (0.078) | (0.637) | (0.093) | (0.272)
AfterTreatHigh | 0.166 | 0.856 | -0.040 | -0.146
 | (0.145) | (1.013) | (0.069) | (0.221)
Rider FE | Yes | Yes | Yes | Yes
Branch-date FE | Yes | Yes | Yes | Yes
Hour-DOW FE | Yes | Yes | Yes | Yes
Adj. R-squared | 0.237 | 0.273 | 0.336 | 0.128
Observations | 153,190 | 153,190 | 153,190 | 127,955
Notes: Robust standard errors clustered at rider level in parentheses. In column 4, there are data points only between the stacks, so the number of observations is reduced compared to columns 1, 2, and 3. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses. In column 4, there are data points only between the stacks, so the number of observations is reduced compared to columns 1, 2, and 3. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses. In column 4, there are data points only between the stacks, so the number of observations is reduced compared to columns 1, 2, and 3. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses. In column 4, there are data points only between the stacks, so the number of observations is reduced compared to columns 1, 2, and 3. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses. In column 4, there are data points only between the stacks, so the number of observations is reduced compared to columns 1, 2, and 3. |  ***p < 0.01; **p < 0.05; * p<0.1

========== Table #6 (12r × 5c) ==========
Variables | (1)|Total stacks | (2)|Total orders | (3)|Total earnings ($) | (4)|Working hours (hours)
AfterTreatLow | 0.380 | 2.060** | 4.384** | 0.438*
 | (0.450) | (0.916) | (1.956) | (0.256)
AfterTreatMedium | 0.299 | 2.086** | 4.409* | 0.095
 | (0.445) | (1.048) | (2.266) | (0.215)
AfterTreatHigh | -0.548 | -0.164 | -0.205 | -0.147
 | (0.397) | (1.247) | (2.619) | (0.187)
Rider FE | Yes | Yes | Yes | Yes
Branch-date FE | Yes | Yes | Yes | Yes
Adj. R-squared | 0.647 | 0.674 | 0.668 | 0.580
Observations | 14,102 | 14,102 | 14,102 | 14,102
Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1

========== Table #7 (16r × 7c) ==========
Variables | Customer waiting time (mins) | Customer waiting time (mins) | Customer waiting time (mins) | Customer waiting time (mins) | Customer waiting time (mins) | Customer waiting time (mins)
Type | (1)|Total | (2)|Single order delivery | (3)|Stacked orders delivery | (4)|Total | (5)|Single order delivery | (6)|Stacked orders delivery
AfterTreat | -0.025 | -0.184** | 0.084 |  |  | 
 | (0.084) | (0.085) | (0.095) |  |  | 
AfterTreatLow |  |  |  | 0.029 | -0.009 | -0.003
 |  |  |  | (0.162) | (0.172) | (0.212)
AfterTreatMedium |  |  |  | -0.129 | -0.260** | -0.024
 |  |  |  | (0.135) | (0.125) | (0.160)
AfterTreatHigh |  |  |  | 0.082 | -0.178 | 0.226*
 |  |  |  | (0.131) | (0.120) | (0.128)
Rider FE | Yes | Yes | Yes | Yes | Yes | Yes
Branch-date FE | Yes | Yes | Yes | Yes | Yes | Yes
Distance control | Yes | Yes | Yes | Yes | Yes | Yes
Adj. R-squared | 0.534 | 0.503 | 0.584 | 0.534 | 0.503 | 0.584
Observations | 150,691 | 74,333 | 76,358 | 150,691 | 74,333 | 76,358
Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1	` | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1	` | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1	` | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1	` | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1	` | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1	` | Notes: Robust standard errors clustered at rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1	`

========== Table #8 (13r × 3c) ==========
Variables | Mean effect | Std. error
Number of working days | 0.120* | 0.071
Number of unique restaurants | -0.067*** | 0.026
Daily working hours | 0.007*** | 0.002
Daily idle hours | -0.009** | 0.004
Number of orders in a stack | -0.589*** | 0.213
Stack completion time | 0.069** | 0.027
Idle time between stacks | 0.021 | 0.028
Customer waiting time | -0.032 | 0.041
Constant | -0.737 | 0.747
Log-Likelihood | -317.759 | 
Observations | 582 | 
Notes: Estimates are calculated on an unmatched sample of 399 adopters and 183 non-adopters in the pretreatment period before October 26, 2020. The dependent variable is whether a rider adopted order assignment AI (adopt=1), or not (adopt=0). |***p < 0.01; **p < 0.05; * p<0.1 | Notes: Estimates are calculated on an unmatched sample of 399 adopters and 183 non-adopters in the pretreatment period before October 26, 2020. The dependent variable is whether a rider adopted order assignment AI (adopt=1), or not (adopt=0). |***p < 0.01; **p < 0.05; * p<0.1 | Notes: Estimates are calculated on an unmatched sample of 399 adopters and 183 non-adopters in the pretreatment period before October 26, 2020. The dependent variable is whether a rider adopted order assignment AI (adopt=1), or not (adopt=0). |***p < 0.01; **p < 0.05; * p<0.1

========== Table #9 (13r × 3c) ==========
 | Daily productivity | Daily productivity
 | (1) | (2)
After×Treat | 0.014 | 
 | (0.060) | 
After×Treat×Low |  | 0.027
 |  | (0.100)
After×Treat×Medium |  | -0.037
 |  | (0.117)
After×Treat×High |  | 0.068
 |  | (0.090)
Adj. R squared | 0.593 | 0.593
Observations | 6,781 | 6,781
Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1

========== Table #10 (13r × 9c) ==========
 | Number of orders | Number of orders | Stack completion time |(mins) | Stack completion time |(mins) | Average processing |time |(mins) | Average processing |time |(mins) | Idle time |(mins) | Idle time |(mins)
 | (1) | (2) | (3) | (4) | (5) | (6) | (7) | (8)
After×Treat | 0.033 |  | 0.189 |  | -0.001 |  | -0.166 | 
 | (0.070) |  | (0.550) |  | (0.069) |  | (0.200) | 
After×Treat×Low |  | -0.016 |  | -0.347 |  | 0.028 |  | -0.755*
 |  | (0.083) |  | (0.749) |  | (0.170) |  | (0.415)
After×Treat×Medium |  | 0.004 |  | 0.051 |  | -0.076 |  | 0.032
 |  | (0.077) |  | (0.704) |  | (0.113) |  | (0.334)
After×Treat×High |  | 0.098 |  | 0.663 |  | 0.059 |  | -0.068
 |  | (0.141) |  | (1.053) |  | (0.090) |  | (0.255)
Adj. R squared | 0.246 | 0.246 | 0.282 | 0.282 | 0.356 | 0.356 | 0.128 | 0.128
Observations | 72,560 | 72,560 | 72,560 | 72,560 | 72,560 | 72,560 | 60,494 | 60,494
Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1

========== Table #11 (13r × 9c) ==========
 | Total stacks | Total stacks | Total orders | Total orders | Total earnings|($) | Total earnings|($) | Working hours (hours) | Working hours (hours)
 | (1) | (2) | (3) | (4) | (5) | (6) | (7) | (8)
After×Treat | -0.157 |  | -0.524 |  | -0.821 |  | -0.042 | 
 | (0.333) |  | (0.779) |  | (1.661) |  | (0.166) | 
After×Treat×Low |  | 0.505 |  | 0.533 |  | 1.236 |  | 0.112
 |  | (0.535) |  | (0.977) |  | (2.089) |  | (0.292)
After×Treat×Medium |  | 0.135 |  | 0.635 |  | 1.491 |  | 0.193
 |  | (0.463) |  | (1.109) |  | (2.378) |  | (0.248)
After×Treat×High |  | -0.994* |  | -2.591* |  | -4.904 |  | -0.428*
 |  | (0.559) |  | (1.489) |  | (3.132) |  | (0.246)
Adj. R squared | 0.676 | 0.676 | 0.674 | 0.674 | 0.668 | 0.668 | 0.587 | 0.587
Observations | 6,781 | 6,781 | 6,781 | 6,781 | 6,781 | 6,781 | 6,781 | 6,781
Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses. One may argue that the parallel trend assumption is violated for high-skilled workers. However, considering the trend shown in Figure A1, this may be because high-skilled riders in the treatment group outperformed those in the control group during the first weekend two days corresponding to week “-5” in the pretreatment period. Except for the first two days of the weekend, the performance of high-skilled workers does not seem to change over time in Figure A1. |  ***p < 0.01; **p < 0.05; * p<0.1

========== Table #12 (13r × 4c) ==========
 | Customer waiting time (mins) | Customer waiting time (mins) | Customer waiting time (mins)
 | (1) | (1) | (2)
After×Treat | 0.063 | 0.063 | 
 | (0.088) | (0.088) | 
After×Treat×Low |  |  | 0.126
 |  |  | (0.159)
After×Treat×Medium |  |  | 0.079
 |  |  | (0.143)
After×Treat×High |  |  | 0.014
 |  |  | (0.135)
Adj. R squared | 0.543 | 0.543 | 0.543
Observations | 71,390 | 71,390 | 71,390
Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1

========== Table #13 (7r × 8c) ==========
 | Daily productivity | Daily productivity | Daily productivity | Daily productivity | Daily productivity | Daily productivity | Daily productivity
 | (1)|1:1 w/o replace caliper 0.05 | (2)|1:1 w/ replace caliper 0.05 | (3)|1:1 w/ replace caliper 0.01 | (4)|1:1 w/o replace caliper 0.05|mahalanobis | (5)|Non-|matching | (5)|Non-|matching
After×Treat | 0.141*** | 0.149*** | 0.121** | 0.140*** | 0.080** | 0.080**
 | (0.047) | (0.052) | (0.054) | (0.048) | (0.039) | (0.039)
Adj. R squared | 0.604 | 0.624 | 0.610 | 0.606 | 0.639 | 0.639
Observations | 14,102 | 12,544 | 10,883 | 13,956 | 26,280 | 26,280
Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|***p < 0.01; **p < 0.05; * p<0.1 |  | 

========== Table #14 (11r × 7c) ==========
 | Daily productivity | Daily productivity | Daily productivity | Daily productivity | Daily productivity | Daily productivity
 | (1)|1:1 w/o replace caliper 0.05 | (2)|1:1 w/ replace caliper 0.05 | (3)|1:1 w/ replace caliper 0.01 | (4)|1:1 w/o replace caliper 0.05|mahalanobis | (5)|Non-|matching | (5)|Non-|matching
After×Treat×Low | 0.088 | 0.078 | 0.014 | 0.095 | 0.054 | 0.054
 | (0.071) | (0.079) | (0.072) | (0.072) | (0.065) | (0.065)
After×Treat×Medium | 0.249*** | 0.250*** | 0.222** | 0.259*** | 0.167*** | 0.167***
 | (0.066) | (0.079) | (0.090) | (0.068) | (0.052) | (0.052)
After×Treat×High | 0.067 | 0.102 | 0.101 | 0.048 | -0.024 | -0.024
 | (0.084) | (0.087) | (0.096) | (0.084) | (0.067) | (0.067)
Adj. R squared | 0.605 | 0.625 | 0.611 | 0.606 | 0.641 | 0.641
Observations | 14,102 | 12,544 | 10,883 | 13,956 | 26,280 | 26,280
Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | Notes: Robust standard errors clustered at the rider level in parentheses|  ***p < 0.01; **p < 0.05; * p<0.1 | 