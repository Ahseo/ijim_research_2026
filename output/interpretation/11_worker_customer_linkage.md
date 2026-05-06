# US-008 Worker–Customer Linkage

## Approach
Stack-level regression: customer waiting time ~ stack-level productivity (num_orders / total_duration in hours) + controls (avg_dist, num_orders).
FE: rider + station-date + hour-of-DOW. Cluster: rider.

**Important framing:** This is a *linkage* analysis, not formal mediation. The estimand is correlative within the matched-rider sample, conditional on rider/branch/time fixed effects. We do NOT make a causal mediation claim.

## Coefficients
                                    model                  term   Estimate Cluster s.e.      Pr(>|t|)
stack_orders_per_hour          all stacks stack_orders_per_hour -1.1291609   0.02831882 3.077171e-129
avg_dist                       all stacks              avg_dist  1.5959606   0.05241762  1.667084e-98
num_orders                     all stacks            num_orders  0.6354329   0.03342419  3.498911e-55
stack_orders_per_hour1  single-order only stack_orders_per_hour -1.5562653   0.03350837 4.919625e-148
avg_dist1               single-order only              avg_dist  0.7106329   0.04478445  1.110314e-42
stack_orders_per_hour2 stacked-order only stack_orders_per_hour -0.9844191   0.02997699 9.386730e-107
avg_dist2              stacked-order only              avg_dist  2.1730797   0.06403041 1.934846e-110
num_orders1            stacked-order only            num_orders  0.3178057   0.01572268  5.838667e-60

## Reviewer address
- AE-2: addresses the request to view customer experience through the labour lens, by quantifying the stack-level association between rider productivity and customer waiting. Avoids over-claim by framing as linkage, not mediation. The estimand is explicitly limited to customers served by treated/matched riders.

## Caveat
Because productivity (orders per stack time) and stack composition (single vs stacked) jointly determine waiting time, the conditional association in the all-stacks regression mixes two channels. Splits by single vs stacked clarify each.
