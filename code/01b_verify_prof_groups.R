# Quick verification: check prof_low/prof_med/prof_high labeling against
# pretreatment productivity. Try multiple DDD specs.
setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
suppressPackageStartupMessages({ library(data.table); library(fixest) })
load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)

cat("\n=== prof group → pretreatment productivity check ===\n")
pre <- day[After == 0]
prof_check <- pre[, .(
  n_riders = uniqueN(rider_id),
  n_obs    = .N,
  mean_prod = mean(orders_per_hour, na.rm = TRUE),
  median_prod = median(orders_per_hour, na.rm = TRUE)
), by = .(prof_low, prof_med, prof_high)]
print(prof_check)

cat("\nIf labeling is correct:\n")
cat("  prof_low=1  → lowest mean_prod\n")
cat("  prof_high=1 → highest mean_prod\n\n")

# Mean prof per group
cat("=== prof variable per group ===\n")
print(pre[, .(
  mean_prof = mean(prof, na.rm = TRUE),
  min_prof  = min(prof, na.rm = TRUE),
  max_prof  = max(prof, na.rm = TRUE)
), by = .(prof_low, prof_med, prof_high)])

# Alternative DDD: each group separately (no baseline, with NA-omitted prof groups)
cat("\n=== DDD spec A — each group as separate interaction (manuscript-style) ===\n")
m_A <- feols(orders_per_hour ~ I(After*Treat*prof_low) + I(After*Treat*prof_med) + I(After*Treat*prof_high)
             | rider_id + station_date, data = day, cluster = ~rider_id)
print(summary(m_A))

cat("\n=== DDD spec B — interaction with prof factor (3 levels) ===\n")
day[, prof_grp := factor(fcase(prof_low == 1, "low",
                                prof_med == 1, "med",
                                prof_high == 1, "high"),
                          levels = c("low", "med", "high"))]
m_B <- feols(orders_per_hour ~ After:Treat:prof_grp | rider_id + station_date,
             data = day, cluster = ~rider_id)
print(summary(m_B))

# Manuscript Table 2 mentions pretreatment group means
cat("\n=== Compare to manuscript Table 2 (pretreatment group means, matched riders) ===\n")
print(pre[Treat %in% c(0,1), .(
  n_riders  = uniqueN(rider_id),
  mean_prod = mean(orders_per_hour, na.rm = TRUE),
  sd_prod   = sd(orders_per_hour,   na.rm = TRUE)
), by = .(prof_low, prof_med, prof_high, Treat)])
