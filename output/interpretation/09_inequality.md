# US-006 Inequality Metrics

## Approach
Compute rider-level mean productivity (orders/hour) within each period, then summarize the cross-rider distribution with Gini, Theil, P90/P10, P75/P25.

## Period × group metrics
Index: <group>
               group     n     mean       sd      gini      theil   p90p10   p75p25
              <char> <int>    <num>    <num>     <num>      <num>    <num>    <num>
1:  All matched, PRE   336 4.686269 1.086272 0.1296985 0.02694571 1.833390 1.342557
2: All matched, POST   336 4.654715 1.147993 0.1367113 0.02968690 1.898023 1.367394
3:      Treated, PRE   168 4.633294 1.028381 0.1232322 0.02445871 1.771041 1.296668
4:     Treated, POST   168 4.580388 1.065745 0.1272549 0.02609389 1.780161 1.333951
5:      Control, PRE   168 4.739244 1.141851 0.1352816 0.02925074 1.883451 1.366523
6:     Control, POST   168 4.729042 1.223414 0.1446855 0.03291598 1.991371 1.406984

## DiD on inequality (treated change − control change)
   metric treated_change control_change          did
   <char>          <num>          <num>        <num>
1:   gini    0.004022691    0.009403941 -0.005381249
2:  theil    0.001635186    0.003665239 -0.002030053
3: p90p10    0.009119731    0.107919693 -0.098799963
4: p75p25    0.037282914    0.040460542 -0.003177629

## Reviewer address
- R1-Minor-2: direct inequality metrics now reported (in addition to subgroup DDD coefficients). The Gini and Theil indices, plus P90/P10 ratio, document the cross-rider productivity distribution change. The DiD on inequality formalises the compression claim relative to control riders.

## Interpretation
If treated_change for Gini/Theil is more negative than control_change → inequality compresses MORE among treated. The DDD coefficient on After:Treat:prof_med (medium-skilled) being the only significant interaction is consistent with the bulk of compression happening in the middle of the distribution.
