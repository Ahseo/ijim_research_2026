# Section 6. Discussion (Revised)

> 변경 매핑: AE-2, AE-3, R1-1, R1-4 (changelog.md 참고)

---

## 6.1 What the algorithm does, and what it does not

A consistent thread through our results is that order-assignment AI optimizes only one stage of a multi-stage workflow. **[R1-1]** The algorithm produces better real-time matches between incoming orders and candidate riders on the basis of revealed-preference learning and dynamic match-quality scoring. It does not, however, advise riders on stacking decisions or on the sequencing and routing of orders within a stack. This boundary condition shapes the value distribution we observe.

For **medium-proficiency riders**, the algorithm relieves the bottleneck that previously bound them — selecting the right order under time pressure — without exceeding the downstream-execution skill that they already possessed. As a result, they translate better matches into more orders within the same elapsed time, and their between-stack idle time decreases. Their productivity rises by approximately 5%.

For **low-proficiency riders**, the algorithm helps with selection, and they accept more orders per stack as a result. Because they lack the downstream-execution proficiency required to manage longer stacks efficiently, however, they need *more time* to complete each stack and accumulate additional between-stack idle time. The outcome is more daily orders and higher earnings, but no productivity gain in terms of orders per hour. In effect, low-proficiency riders convert AI assistance into longer hours rather than higher throughput.

For **high-proficiency riders**, neither the selection bottleneck nor the execution bottleneck is binding. They already operate at an operational frontier, and the algorithm offers little marginal benefit on either dimension.

This decomposition — productivity gain ≈ match improvement × downstream-execution complementarity — clarifies why prior platform-AI studies have produced heterogeneous and at times conflicting results. The same algorithm can compress productivity disparities (when downstream execution is broadly accessible), preserve them (as in our setting, where it is not), or amplify them (when only the highest-proficiency workers can fully leverage the algorithmic output).

## 6.2 Implications for platform operations

Three implications emerge for platform operators:

**(1) Algorithmic assignment raises average productivity, but the gain is not evenly distributed.** Targeting policy-relevant outcomes — such as raising the productivity floor, or attracting and retaining new workers — requires complementing algorithmic assignment with non-algorithmic support for downstream execution: routing guidance, sequencing recommendations, food-preparation-aware pickup timing, and the like. The AI assignment system in our setting did not include such complements; as these tools mature and are deployed, the heterogeneity pattern we document is likely to evolve.

**(2) The customer-side benefit is conditional and bounded.** Our matched-sample analysis identifies a single-order waiting-time gain (driven by medium-proficiency riders) and no improvement on stacked-order waiting. We deliberately do not extend this finding to a platform-wide consumer welfare claim, because equilibrium effects across all customers and station-level supply shifts are not identified by our matched design. **[R1-4]** A platform-level customer evaluation would require aggregate evidence (e.g., branch-day average waiting times across all riders), which is outside our data.

**(3) Algorithmic constraints can reshape the worker–customer trade-off.** Within stacks, riders optimize sequencing and routing to maximize their own throughput rather than to minimize per-customer waiting. A platform-side constraint — for example, a maximum stack size, or a stacking-aware sequencing recommendation — could in principle redirect some of the productivity gain toward customer-facing speed, especially for stacked-order deliveries.

## 6.3 The social-equality framing — what we do and do not claim

We are explicit about what our evidence supports and does not support. **[AE-3]**

We **do** show that, within the matched sample of 336 riders observed before and after the AI rollout, the productivity distribution compresses: the medium-proficiency group's mean shifts up while the low- and high-proficiency means do not move significantly. Direct inequality measures (Gini, Theil, P90/P10) confirm a modest compression of the productivity distribution among treated riders relative to control. The effect is robust to the event-study pre-trend test, the Oster bound, the stable-workers restriction, and — importantly — a 3.5-month extension that shows the gain persists, with some attenuation, into the longer post-AI window.

We **do not** claim that this constitutes "AI promoting social equality." The order-assignment AI was not designed with social equality as an objective; its design objective is match quality and assignment efficiency. The compressing effect we observe is a *by-product* of the algorithm's interaction with the multi-stage task structure and the pre-AI proficiency distribution, not the organic outcome of an algorithm pursuing equity. Whether this by-product is durable, generalizes beyond our setting, or scales without complementary downstream tools — these are open questions.

## 6.4 Worker–customer linkage as a stack-level association

Our linkage analysis (Section 5.2.2) shows that, conditional on rider, branch-date, and hour-of-day-of-week fixed effects, faster stacks are associated with shorter customer waiting time, and the association is stronger for single-order stacks than for stacked-order stacks. **[AE-2]** We frame this as a *linkage* — an association that helps illuminate the channel — and explicitly *not* as a formal mediation analysis. Stack composition (single vs. stacked) is jointly determined with waiting time, and a formal mediation decomposition would require exogeneity assumptions that we do not believe are defensible here. The framing addresses the editor's concern that customer experience can be informatively viewed through the labor lens, while preserving the rigor of our identification.
