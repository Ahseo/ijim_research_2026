# Section 3. Background and Data (Revised)

> 변경 매핑: R1-2, AE-3 (changelog.md 참고)

---

## 3.1 Platform overview and the order-assignment AI system

We collaborated with a major food delivery platform in Korea. The platform receives delivery requests from multiple food-ordering platforms and dispatches them to a network of more than 42,200 gig workers across over 500 regional management branches, serving 67,000 restaurants nationwide. As in many food delivery contexts, riders complete either single-order deliveries or *stacked* deliveries — multiple orders within a continuous trip, which we refer to as a "stack." Single deliveries minimize per-customer waiting; stacked deliveries reduce per-rider idle time and can raise rider earnings but typically prolong customer waiting time for individual orders within the stack.

Prior to October 26, 2020, the platform's default order-assignment mechanism in Busan was **manual broadcast dispatch**: each new customer order was broadcast to nearby riders, and the first rider to accept the order received the assignment. Under this scheme, riders had to evaluate, within seconds, several factors simultaneously — current location relative to pick-up and drop-off points, expected fees, time constraints, and how the new order would integrate with in-progress orders within the existing stack. Less-experienced riders were known to miss high-value or well-fitting orders under this regime, whereas more-experienced riders developed heuristics that conferred order-selection advantages.

On October 26, 2020, the platform deployed an **order-assignment AI system** in Busan. The system replaced the broadcast-and-accept loop with automated one-to-one assignment between an incoming order and a candidate rider on the basis of a real-time match-quality score. Three design features distinguish the AI system from earlier rule-based dispatch: **[R1-2]**

1. **Revealed-preference learning at the individual rider level.** The system draws on each rider's historical accept-decline and completion record to estimate a probabilistic distribution of order preferences conditional on the rider's logistical situation. This is a learning component, not a static rule.

2. **Dynamic, real-time match scoring.** The system evaluates rider-order match quality on the basis of the rider's current location, in-progress orders within the existing stack, and likely subsequent delivery routes. Match scores are updated continuously, allowing the system to respond to micro-level shifts in demand and supply.

3. **Automated assignment without broadcast.** When the AI mode is enabled, the system assigns the best-matched order directly; the rider must then accept and complete it. This design feature limits selective acceptance ("cherry-picking") and gaming of the broadcast mechanism.

Three points about the system's design objective merit emphasis. First, the system was designed to improve match quality between orders and riders, not to address inequality among riders. **[AE-3]** Second, the system optimizes only the order-to-rider match — the *first* stage of a multi-stage workflow that also includes stacking, pickup and drop-off sequencing, and routing. The AI does not direct or optimize these downstream stages. Third, riders are not required to use AI mode: they can switch it on or off in the rider app at any time. This adoption-decision element introduces the endogeneity that our matched DID/DDD design is built to address.

## 3.2 Data and variables

Our empirical analysis uses an order-level dataset covering one month before and one month after the AI rollout in Busan. The dataset records, for each completed delivery: an anonymized rider identifier, the rider's regional management branch, timestamps for each delivery step (order placement, assignment, pickup, drop-off), service fees, and the assignment mode (AI versus manual). The observation window contains more than 800,000 orders from over 900 riders. We retain riders who joined the platform before the observation window and were active in both periods, yielding 581 candidate riders, which we then propensity-score-match to obtain the 336-rider analytic sample (Section 4).

For the extension analysis in Section 5.3, we additionally use Busan-exclusive Dec 2020 – Feb 2021 order data, which provide approximately three additional months of post-AI activity. Of the 336 riders in the main matched sample, 290 (86%) remain active in this extension window, allowing us to assess whether the productivity effects persist beyond the original one-month post-AI horizon. **[AE-4, R2-7]**

We work at three levels of aggregation: order-level, *stack*-level (where a stack is the set of orders the rider handles within a continuous trip), and *day*-level. Our key dependent variable, **daily productivity**, is defined as completed orders divided by total daily working time, where total daily working time is the sum of working duration and between-stack idle duration. This definition captures a rider's joint ability to (i) complete more orders per stack and (ii) reduce idle time between stacks — both of which are channels through which order-assignment AI can affect productivity.

We classify riders by **pre-AI proficiency**, defined as their average daily productivity over the 30-day pre-AI window. **[AE-1]** Throughout the manuscript, we use the term *proficiency* rather than *skill* to make explicit that the classification reflects pre-treatment performance under the manual broadcast regime rather than a fixed worker trait.¹ Riders are partitioned into terciles based on this measure: low-proficiency (n = 110, mean 3.56 orders/hour), medium-proficiency (n = 113, mean 4.59), and high-proficiency (n = 113, mean 5.91). These pre-AI fixed groupings serve as interaction variables in our DDD specification.

> ¹ Proficiency is operationalized as the rider's average orders/hour during 2020-09-26 to 2020-10-25 under the manual broadcast system. The classification is fixed at the rider level and does not vary over the post-AI period.

## 3.3 Treatment and control

Our treatment indicator equals 1 if the rider ever completes an order assigned by the AI system within the observation window, and 0 otherwise. This binary measure is supplemented in robustness checks by a continuous AI-intensity measure — the daily share of AI-assigned orders (Section 5.3.5). Riders are observed in both pre-AI and post-AI periods, with the After indicator equal to 1 for observations on or after October 26, 2020. The propensity-score matching procedure described next yields the analytic sample of 336 matched riders that supports all main analyses.
