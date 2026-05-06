# =============================================================================
# 10_learning_dynamics.R  (US-007)
# Reviewer 2 #9 address: empirical evidence for learning curve.
# Week-level treatment-effect coefficient evolution (by proficiency group).
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({
  for (p in c("data.table","lfe","ggplot2")) {
    if (!requireNamespace(p, quietly = TRUE)) install.packages(p, repos = "https://cloud.r-project.org")
  }
  library(data.table); library(lfe); library(ggplot2)
})

load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)

# Group-specific event-study: for each prof group, run leads/lags
# y ~ Treat:wb4 + ... + Treat:w5 (wb1 omitted)
groups <- c("prof_low", "prof_med", "prof_high")
group_labels <- c("Low-proficiency","Medium-proficiency","High-proficiency")

results <- list()
for (i in seq_along(groups)) {
  g <- groups[i]; lbl <- group_labels[i]
  d <- day[get(g) == 1]
  cat(sprintf("\n=== %s: %d riders, %d obs ===\n", lbl, uniqueN(d$rider_id), nrow(d)))
  m <- felm(orders_per_hour ~ Treat:wb5 + Treat:wb4 + Treat:wb3 + Treat:wb2 +
                              Treat:w1  + Treat:w2  + Treat:w3  + Treat:w4 + Treat:w5
            | rider_id + station_date | 0 | rider_id, data = d)
  ct <- as.data.frame(summary(m)$coefficients)
  ct$term <- rownames(ct); ct$group <- lbl
  results[[i]] <- ct[, c("group","term","Estimate","Cluster s.e.","Pr(>|t|)")]
}
all_res <- rbindlist(results)
names(all_res) <- c("group","term","estimate","se","p_value")

# Add week index
week_map <- data.table(
  term = c("Treat:wb5","Treat:wb4","Treat:wb3","Treat:wb2",
           "Treat:w1","Treat:w2","Treat:w3","Treat:w4","Treat:w5"),
  week_index = c(-5,-4,-3,-2, 1, 2, 3, 4, 5)
)
all_res <- merge(all_res, week_map, by = "term", all.x = TRUE)
all_res <- all_res[order(group, week_index)]
fwrite(all_res, "output/tables/10_learning_dynamics.csv")
cat("\nSaved → output/tables/10_learning_dynamics.csv\n")

# Plot
all_res[, ci_low  := estimate - 1.96 * se]
all_res[, ci_high := estimate + 1.96 * se]
p <- ggplot(all_res, aes(x = week_index, y = estimate, color = group)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50") +
  geom_vline(xintercept = 0.5, linetype = "dashed", color = "red", alpha = 0.6) +
  geom_pointrange(aes(ymin = ci_low, ymax = ci_high), size = 0.5,
                  position = position_dodge(width = 0.4)) +
  geom_line(aes(group = group), alpha = 0.6, position = position_dodge(width = 0.4)) +
  scale_x_continuous(breaks = c(-5,-4,-3,-2,1,2,3,4,5)) +
  scale_color_manual(values = c("Low-proficiency" = "tomato",
                                 "Medium-proficiency" = "steelblue",
                                 "High-proficiency" = "darkgreen")) +
  labs(x = "Week relative to AI rollout",
       y = "Treatment effect (orders/hour)",
       color = "Group",
       title = "Learning dynamics by proficiency group",
       subtitle = "Week-level Treat coefficients; rider FE + station-date FE; cluster by rider; 95% CI") +
  theme_bw(base_size = 12)
ggsave("output/figures/10_learning_curves_by_group.png", p, width = 9, height = 5.5, dpi = 200)
cat("Saved → output/figures/10_learning_curves_by_group.png\n")

note <- c(
  "# US-007 Learning Dynamics by Proficiency Group",
  "",
  "## Spec",
  "For each proficiency group separately:",
  "y ~ Treat × {wb5,wb4,wb3,wb2, w1,w2,w3,w4,w5} | rider + station-date | cluster rider",
  "(wb1 = reference week)",
  "",
  "## Coefficients",
  paste(capture.output(print(all_res)), collapse = "\n"),
  "",
  "## Reviewer address",
  "- R2-9: empirical evidence on the learning curve. The per-week treatment effect series shows whether benefits emerge gradually (consistent with learning) or appear immediately. By proficiency group, this also speaks to differential adaptation patterns.",
  "",
  "## Limitation",
  "Observation window is 5 weeks post-rollout (1 month + buffer). Long-term adaptation cannot be inferred. The Dec-Feb extension (US-010) helps address this."
)
writeLines(note, "output/interpretation/10_learning_dynamics.md")
cat("Saved → output/interpretation/10_learning_dynamics.md\n[US-007] DONE\n")
