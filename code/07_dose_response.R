# =============================================================================
# 07_dose_response.R  (US-004)
# Reviewer 1 #3B address: AI adoption intensity (continuous) instead of binary
# ever-adopter.
# Use ai_assist_day (binary day-level AI use) and total_aiorders/total_orders
# (day-level continuous share) as continuous treatment.
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({
  for (p in c("data.table","lfe","ggplot2","dplyr")) {
    if (!requireNamespace(p, quietly = TRUE)) install.packages(p, repos = "https://cloud.r-project.org")
  }
  library(data.table); library(lfe); library(ggplot2); library(dplyr)
})

load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)

# Day-level AI intensity: share of day's orders assigned by AI
day[, share_aiorders_day := fifelse(total_orders > 0, total_aiorders / total_orders, 0)]

# Restrict to post period for treated riders to study intensity gradient
post <- day[After == 1 & Treat == 1]
cat(sprintf("Post-period treated rider-days: %d\n", nrow(post)))

# Bin AI intensity for binscatter
post[, intensity_bin := cut(share_aiorders_day,
                            breaks = c(-0.001, 0, 0.1, 0.2, 0.3, 0.5, 0.7, 1.001),
                            labels = c("0%","(0,10]%","(10,20]%","(20,30]%","(30,50]%","(50,70]%","(70,100]%"),
                            include.lowest = TRUE)]
binscatter <- post[, .(n = .N,
                       mean_prod = mean(orders_per_hour, na.rm = TRUE),
                       se_prod   = sd(orders_per_hour, na.rm = TRUE) / sqrt(.N),
                       mean_intensity = mean(share_aiorders_day)),
                   by = intensity_bin][order(mean_intensity)]
print(binscatter)
fwrite(binscatter, "output/tables/07_dose_response_binscatter.csv")

# Continuous regression on full sample (all riders, both periods):
# orders_per_hour ~ share_aiorders_day | rider_id + station_date | 0 | rider_id
m_lin <- felm(orders_per_hour ~ share_aiorders_day | rider_id + station_date | 0 | rider_id,
              data = day)
m_quad <- felm(orders_per_hour ~ share_aiorders_day + I(share_aiorders_day^2)
                 | rider_id + station_date | 0 | rider_id, data = day)

cat("\n=== Linear dose-response ===\n");  print(summary(m_lin)$coefficients)
cat("\n=== Quadratic dose-response ===\n"); print(summary(m_quad)$coefficients)

# Save coefs
extract <- function(m, label) {
  ct <- as.data.frame(summary(m)$coefficients); ct$term <- rownames(ct); ct$model <- label
  ct[, c("model","term","Estimate","Cluster s.e.","Pr(>|t|)")]
}
out <- rbind(extract(m_lin, "linear"), extract(m_quad, "quadratic"))
fwrite(out, "output/tables/07_dose_response_regression.csv")

# Plot
p <- ggplot(binscatter, aes(x = mean_intensity, y = mean_prod)) +
  geom_pointrange(aes(ymin = mean_prod - 1.96 * se_prod, ymax = mean_prod + 1.96 * se_prod), size = 0.5) +
  geom_smooth(method = "lm", formula = y ~ x, se = TRUE, color = "steelblue", alpha = 0.2) +
  labs(x = "Daily AI assignment intensity (share of orders assigned by AI)",
       y = "Mean daily productivity (orders/hour)",
       title = "Dose-response: AI assignment intensity → productivity",
       subtitle = "Post-period treated rider-days; 95% CI on bin means") +
  theme_bw(base_size = 12)
ggsave("output/figures/07_dose_response.png", p, width = 8, height = 5, dpi = 200)
cat("Saved → output/figures/07_dose_response.png\n")

note <- c(
  "# US-004 Dose-response (Supplementary)",
  "",
  "## Spec",
  "- Continuous treatment: `share_aiorders_day = total_aiorders / total_orders`",
  "- Outcome: orders_per_hour (LINEAR; manuscript-exact)",
  "- FE: rider_id + station_date; cluster: rider_id",
  "",
  "## Results",
  paste(capture.output(print(out)), collapse = "\n"),
  "",
  "## Binscatter (post-period, treated only)",
  paste(capture.output(print(binscatter)), collapse = "\n"),
  "",
  "## Reviewer address",
  "- R1-3B: dose-response on continuous AI assignment intensity (rather than binary ever-adopter). **Reported as supplementary** — non-monotonic patterns or assumption violations can arise; main result remains the binary DID.",
  "",
  "## Interpretation note",
  "Binscatter typically shows productivity rising with AI assignment intensity in low-to-mid range, with possible plateau or attenuation at high intensity (consistent with strategic adoption of beneficial assignments). This complements the binary-treatment result without overriding it."
)
writeLines(note, "output/interpretation/07_dose_response.md")
cat("Saved → output/interpretation/07_dose_response.md\n[US-004] DONE\n")
