# Section 7. Conclusion

> 신설 — R2-11 address. Section 6 Discussion 과 분리하여 (i) theoretical contribution, (ii) practical/policy implication, (iii) limitations, (iv) future research direction 을 명시적으로 정리.

---

## 7.1 Theoretical contributions

This study contributes three theoretical insights to the literature on algorithmic management in on-demand platforms.

**First**, we identify and operationalize a *boundary condition* that determines when, and for whom, algorithmic task assignment generates productivity gains. The algorithm's value depends on the alignment between (i) the bottleneck the algorithm relieves and (ii) the worker's downstream-execution capability. This framing reconciles the apparently conflicting findings in the broader AI-and-labor literature: an algorithm can simultaneously raise average productivity, compress disparities at the middle of the distribution, and leave the tails unchanged, depending on where the binding constraint lies for each group of workers. The multi-stage task structure of food delivery (assignment → stacking → sequencing → routing) is a particularly clean setting in which to examine this boundary condition, but the framework extends to any platform setting where automation targets one stage of a multi-step workflow.

**Second**, we provide rare empirical evidence on the *joint* distribution of algorithmic management's effects across worker groups and end-use customers within a single platform. Most prior empirical work has examined either workers or customers in isolation; our matched DID/DDD framework — combined with a stack-level linkage analysis — quantifies how a worker-side intervention propagates (or fails to propagate) into customer-facing outcomes, with the propagation conditional on stack composition.

**Third**, we problematize the social-equality framing of algorithmic interventions. Our results show that an algorithm that was not designed for equity can still produce *modest* compression of the productivity distribution as a by-product of its interaction with the workforce's pre-treatment proficiency distribution. This nuance — by-product, not goal — is theoretically important. It cautions against attributing equity-relevant outcomes to algorithmic design intent and motivates a research agenda on the conditions under which algorithmic structures incidentally compress versus amplify disparities.

## 7.2 Practical and policy implications

Our findings yield three actionable implications for platform operators:

1. **Augment task-assignment AI with downstream-execution support.** The largest unrealized productivity reservoir lies with low-proficiency riders, who can accept more orders but lack the execution capability to convert volume into throughput. Complementary tools — algorithmic sequencing and routing recommendations, food-preparation-aware pickup timing, drop-off parking guidance — could materially raise their productivity and earnings.

2. **Set algorithmic constraints that balance worker and customer outcomes.** A maximum stack size, or a sequencing recommendation that weights customer waiting time alongside rider throughput, could redirect a portion of the worker-side productivity gain toward customer-facing service in stacked-order deliveries.

3. **Frame algorithmic assignment as a *complement* to rider development rather than a substitute.** Because the value of task-assignment AI is conditional on downstream-execution capability, training, mentoring, or progression-pathway tools that build that capability have multiplier effects on the algorithm's productivity gains.

For policy, our analysis cautions against treating algorithmic assignment as inherently equity-promoting. Equity-relevant outcomes from algorithmic deployment depend on workforce composition and on the alignment between the algorithm's target and the binding constraint for each worker group. Policy that mandates equity outcomes should attend to these structural conditions rather than assume that algorithmic management automatically produces them.

## 7.3 Limitations

We acknowledge the following limitations. **[R2-3, R2-10]**

1. **Single platform, single country, single task.** Our evidence is drawn from one major Korean food delivery platform over a five-month observation window. While the multi-stage task structure is shared by most food delivery platforms worldwide, the magnitude and distributional pattern of effects may differ on platforms with different pre-AI dispatch mechanisms, rider-population characteristics, or regulatory environments.

2. **Identification rests on PSM combined with DID/DDD.** Although we report event-study pre-trend tests, Oster bounds, and a stable-workers restriction — all of which support our identification — residual selection on unobservables that varies systematically with treatment cannot be ruled out completely.

3. **The customer-side estimand is restricted to matched-rider customers.** We do not identify platform-wide consumer welfare effects, and equilibrium or spillover effects across non-matched riders fall outside our design.

4. **The observation window is moderate.** Our extended event-study covers through January 2021 (approximately 3.5 months post-AI), but longer-horizon adaptation, learning, or strategic responses cannot be tested with our data.

5. **Worker outcomes beyond productivity.** We do not directly measure worker stress, well-being, or autonomy. The literature on algorithmic management cautions about these dimensions; our productivity-focused analysis is necessarily silent on them.

## 7.4 Future research

Three directions follow naturally from our analysis. **[R2-3]**

**First**, a comparative study across platforms — ideally exploiting natural variation in algorithmic-assistance design (assignment-only vs. assignment-plus-sequencing) — would test the boundary condition more cleanly. Platforms that deploy downstream-execution tools offer a natural experiment for the *multiplicative* relationship between task-assignment AI and downstream support that we hypothesize.

**Second**, longer-horizon panel data would help determine whether the productivity-distribution compression we document is a transient by-product of immediate adaptation or a durable equilibrium. The slight attenuation we observe between November 2020 and January 2021 hints at the former; multi-year data would resolve the question.

**Third**, complementary qualitative or survey work on the *worker experience* of algorithmic assignment — autonomy, perceived fairness, monitoring intensity — would address the dimensions our quantitative design cannot. The customer-side question similarly merits more targeted investigation through aggregate platform-level data and consumer surveys.

These directions would also help generalize our boundary-condition framework — the alignment between algorithmic relief and downstream complement — to a broader range of algorithmic management interventions.
