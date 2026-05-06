# =============================================================================
# 05_event_study.R  (US-002)
# Reviewer 1 #3A + R2 #7 address: dynamic DID with leads/lags + pre-trend test.
#
# Spec: y ~ Treat:wb4 + Treat:wb3 + Treat:wb2 + Treat:w1 + Treat:w2 + Treat:w3
#           + Treat:w4 + Treat:w5 (wb1 omitted as reference)
#       | rider_id + station_date | 0 | rider_id
# Outcomes: orders_per_hour (LINEAR per manuscript-exact spec)
# Pre-trend F-test: joint H0: Treat:wb4 = Treat:wb3 = Treat:wb2 = 0
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

# Verify week dummies exist
stopifnot(all(c("wb5","wb4","wb3","wb2","wb1","w1","w2","w3","w4","w5") %in% names(day)))

# Event-study regression (wb1 = reference week omitted)
m_es <- felm(orders_per_hour ~ Treat:wb5 + Treat:wb4 + Treat:wb3 + Treat:wb2 +
                                Treat:w1  + Treat:w2  + Treat:w3  + Treat:w4 + Treat:w5
              | rider_id + station_date | 0 | rider_id, data = day)
print(summary(m_es))

# Extract coefficients
ct <- as.data.frame(summary(m_es)$coefficients)
ct$term <- rownames(ct)
ct <- ct[, c("term","Estimate","Cluster s.e.","Pr(>|t|)")]
names(ct) <- c("term","estimate","se","p_value")

# Add week labels
week_map <- data.table(
  term = c("Treat:wb5","Treat:wb4","Treat:wb3","Treat:wb2",
           "Treat:w1","Treat:w2","Treat:w3","Treat:w4","Treat:w5"),
  week_index = c(-5, -4, -3, -2, 1, 2, 3, 4, 5),
  week_label = c("wb5","wb4","wb3","wb2","w1","w2","w3","w4","w5")
)
ct <- merge(as.data.table(ct), week_map, by = "term", all.x = TRUE)
ct <- ct[order(week_index)]

# Add reference point (wb1 = 0)
ref_row <- data.table(term = "Treat:wb1", estimate = 0, se = NA_real_, p_value = NA_real_,
                      week_index = -1, week_label = "wb1 (ref)")
ct_full <- rbind(ct, ref_row)[order(week_index)]
fwrite(ct_full, "output/tables/05_event_study_coefficients.csv")
cat("\nSaved → output/tables/05_event_study_coefficients.csv\n")

# Pre-trend F-test (joint H0: pre-period leads = 0)
pre_terms <- c("Treat:wb5", "Treat:wb4", "Treat:wb3", "Treat:wb2")
pre_terms_in_model <- intersect(pre_terms, rownames(summary(m_es)$coefficients))

if (length(pre_terms_in_model) >= 2) {
  R <- matrix(0, nrow = length(pre_terms_in_model), ncol = length(coef(m_es)))
  for (i in seq_along(pre_terms_in_model)) {
    R[i, which(names(coef(m_es)) == pre_terms_in_model[i])] <- 1
  }
  ftest <- waldtest(m_es, R = R, type = "cluster")
  cat("\n=== Pre-trend joint F-test (H0: leads = 0) ===\n")
  print(ftest)
  fwrite(data.table(test = "pre-trend joint", statistic = ftest["F"],
                    p_value = ftest["p.F"], df1 = ftest["df1"]),
         "output/tables/05_event_study_pretrend_test.csv")
}

# Event-study coefficient plot
ct_plot <- ct_full[!is.na(week_index)]
ct_plot[, ci_low  := estimate - 1.96 * se]
ct_plot[, ci_high := estimate + 1.96 * se]

p <- ggplot(ct_plot, aes(x = week_index, y = estimate)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50") +
  geom_vline(xintercept = 0.5, linetype = "dashed", color = "red", alpha = 0.6) +
  geom_pointrange(aes(ymin = ci_low, ymax = ci_high), size = 0.6) +
  geom_line(aes(group = 1), alpha = 0.5) +
  scale_x_continuous(breaks = c(-5,-4,-3,-2,-1,1,2,3,4,5),
                     labels = c("wb5","wb4","wb3","wb2","wb1\n(ref)","w1","w2","w3","w4","w5")) +
  labs(x = "Week relative to AI rollout (2020-10-26)",
       y = "Treatment effect (orders/hour)",
       title = "Event-study: AI adoption effect on daily productivity",
       subtitle = "DID with rider FE + branch-date FE; cluster by rider; 95% CI") +
  theme_bw(base_size = 12)
ggsave("output/figures/05_event_study_productivity.png", p, width = 8, height = 5, dpi = 200)
cat("Saved → output/figures/05_event_study_productivity.png\n")

# Interpretation note
note <- c(
  "# US-002 Event-study (Productivity)",
  "",
  "## Spec",
  "- Outcome: `orders_per_hour` (LINEAR; manuscript-exact)",
  "- Leads/lags: Treat × {wb5, wb4, wb3, wb2, w1, w2, w3, w4, w5} (wb1 = reference)",
  "- FE: rider_id + station_date; cluster: rider_id",
  "- Sample: data_day_matched1 (336 riders, 14,102 day-rows)",
  "",
  "## Pre-trend F-test",
  "Joint H0: Treat:wb5 = Treat:wb4 = Treat:wb3 = Treat:wb2 = 0",
  sprintf("F = %.3f, p = %.3f → %s", ftest["F"], ftest["p.F"],
          ifelse(ftest["p.F"] > 0.10, "no significant pre-trend (parallel trends supported)",
                                       "pre-trend present — interpret with caution")),
  "",
  "## Coefficients (LINEAR, orders/hour)",
  paste(capture.output(print(ct_plot[, .(week_label, estimate, se, p_value)])), collapse = "\n"),
  "",
  "## Reviewer address",
  "- R1-3A: dynamic DID estimates provided; pre-trends jointly tested (above)",
  "- R2-7: while observation window is still 1-month before/after, the event-study form makes the dynamic effects (and their stability) transparent. Long-term extension via Dec-Feb data (US-010) supplements this."
)
writeLines(note, "output/interpretation/05_event_study.md")
cat("Saved → output/interpretation/05_event_study.md\n")
cat("\n[US-002] DONE\n")
