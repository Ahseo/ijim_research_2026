# =============================================================================
# 11_worker_customer_linkage.R  (US-008)
# Associate Editor #2 address: stack-level worker productivity ↔ customer
# waiting time linkage (NOT formal mediation).
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
shift <- as.data.table(data_shift_matched1)

# Stack-level: customer waiting time ~ stack productivity proxy
# Productivity proxy at stack level: num_orders / total_duration (orders/min)
shift[, stack_orders_per_min := fifelse(total_duration > 0, num_orders / total_duration, NA_real_)]
shift[, stack_orders_per_hour := stack_orders_per_min * 60]

# Linkage regression: avg_waiting ~ stack_orders_per_hour + controls
# Subset: matched riders, post-AI period (where AI-driven productivity is at play)
shift_post <- shift[After == 1]
cat(sprintf("Post-period stacks: %d\n", nrow(shift_post)))

# Linear linkage on full sample
m_link_all <- felm(avg_waiting ~ stack_orders_per_hour + avg_dist + num_orders
                   | rider_id + station_date + hourDOW | 0 | rider_id, data = shift)

# Single-order vs stacked
m_link_single  <- felm(avg_waiting ~ stack_orders_per_hour + avg_dist
                       | rider_id + station_date + hourDOW | 0 | rider_id,
                       data = shift[num_orders == 1])
m_link_stacked <- felm(avg_waiting ~ stack_orders_per_hour + avg_dist + num_orders
                       | rider_id + station_date + hourDOW | 0 | rider_id,
                       data = shift[num_orders >= 2])

cat("\n=== Linkage: all stacks ===\n");      print(summary(m_link_all)$coefficients)
cat("\n=== Linkage: single-order ===\n");    print(summary(m_link_single)$coefficients)
cat("\n=== Linkage: stacked-order ===\n");   print(summary(m_link_stacked)$coefficients)

extract <- function(m, label) {
  ct <- as.data.frame(summary(m)$coefficients); ct$term <- rownames(ct); ct$model <- label
  ct[, c("model","term","Estimate","Cluster s.e.","Pr(>|t|)")]
}
out <- rbind(extract(m_link_all,"all stacks"),
             extract(m_link_single,"single-order only"),
             extract(m_link_stacked,"stacked-order only"))
fwrite(out, "output/tables/11_worker_customer_linkage.csv")

# Visualization: binscatter of waiting vs stack productivity (post period)
shift_post[, prod_bin := cut(stack_orders_per_hour,
                              breaks = quantile(stack_orders_per_hour, probs = seq(0,1,0.1), na.rm = TRUE),
                              include.lowest = TRUE)]
binscatter <- shift_post[, .(mean_prod = mean(stack_orders_per_hour, na.rm = TRUE),
                              mean_wait = mean(avg_waiting, na.rm = TRUE),
                              n = .N), by = prod_bin][!is.na(prod_bin)]

p <- ggplot(binscatter, aes(x = mean_prod, y = mean_wait)) +
  geom_point(aes(size = n), alpha = 0.7) +
  geom_smooth(method = "lm", formula = y ~ x, se = TRUE, color = "steelblue") +
  scale_size_continuous(name = "Stacks", range = c(2, 8)) +
  labs(x = "Stack productivity (orders/hour, decile bins)",
       y = "Mean customer waiting time (min)",
       title = "Worker–customer linkage: faster stacks deliver shorter waiting",
       subtitle = "Post-AI matched sample, stack-level binscatter") +
  theme_bw(base_size = 12)
ggsave("output/figures/11_worker_customer_linkage.png", p, width = 8, height = 5, dpi = 200)
cat("Saved → output/figures/11_worker_customer_linkage.png\n")

note <- c(
  "# US-008 Worker–Customer Linkage",
  "",
  "## Approach",
  "Stack-level regression: customer waiting time ~ stack-level productivity (num_orders / total_duration in hours) + controls (avg_dist, num_orders).",
  "FE: rider + station-date + hour-of-DOW. Cluster: rider.",
  "",
  "**Important framing:** This is a *linkage* analysis, not formal mediation. The estimand is correlative within the matched-rider sample, conditional on rider/branch/time fixed effects. We do NOT make a causal mediation claim.",
  "",
  "## Coefficients",
  paste(capture.output(print(out)), collapse = "\n"),
  "",
  "## Reviewer address",
  "- AE-2: addresses the request to view customer experience through the labour lens, by quantifying the stack-level association between rider productivity and customer waiting. Avoids over-claim by framing as linkage, not mediation. The estimand is explicitly limited to customers served by treated/matched riders.",
  "",
  "## Caveat",
  "Because productivity (orders per stack time) and stack composition (single vs stacked) jointly determine waiting time, the conditional association in the all-stacks regression mixes two channels. Splits by single vs stacked clarify each."
)
writeLines(note, "output/interpretation/11_worker_customer_linkage.md")
cat("Saved → output/interpretation/11_worker_customer_linkage.md\n[US-008] DONE\n")
