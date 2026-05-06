# =============================================================================
# 01_reproduce_results.R
# Reproduction with EXACT spec from previous_resource/drive_2/02_DID matching.R
#
# Key points (extracted from original 02_DID matching.R):
#   1. Use lfe::felm  (NOT fixest)
#   2. Outcomes are LOG-transformed: ln(orders_per_hour), ln(avg_waiting),
#      ln(total_orders), ln(total_fee), ln(total_labor), ln(working_duration),
#      ln(idle_duration+1), ln(num_orders), ln(total_duration),
#      ln(avg_duration_orders), ln(idle_btw_shifts), ln(avg_assign+1),
#      ln(avg_pickup+1), ln(avg_deliver+1), ln(orders_stacked+1), ln(orders_one+1).
#      Linear (no log): share_aggshift, share_idled, share_failedorders.
#   3. Filter: exclude 2020-10-26 ~ 2020-10-31 (6-day rollout buffer)
#   4. DID:  outcome ~ After:Treat | rider_id + station_date | 0 | riderDOW
#      shift-level adds + hourDOW FE
#   5. DDD:  outcome ~ After:Treat:prof_low + After:Treat:prof_med +
#                      After:Treat:prof_high + After:prof_med + After:prof_high
#            | rider_id + station_date (+ hourDOW for shift) | 0 | riderDOW
#   6. Some specs cluster by rider_id instead of riderDOW (total_fee, var_waiting,
#      share_failedorders use rider_id cluster).
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")

suppressPackageStartupMessages({
  for (p in c("data.table", "lfe", "dplyr")) {
    if (!requireNamespace(p, quietly = TRUE)) install.packages(p, repos = "https://cloud.r-project.org")
  }
  library(data.table); library(lfe); library(dplyr)
})

# `ln` alias used in original code
ln <- log

load("previous_resource/ISR_submitted ver_data.RData")

# ----- apply 6-day rollout buffer filter (per original line 762-764) -----
buffer_dates <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31"))
day   <- as.data.table(data_day_matched1)[!date %in% buffer_dates]
shift <- as.data.table(data_shift_matched1)[!date %in% buffer_dates]
cat(sprintf("After buffer filter — day: %d rows, %d riders ; shift: %d rows\n",
            nrow(day), uniqueN(day$rider_id), nrow(shift)))

# helper to extract a felm coefficient
fmt <- function(model, label, coef) {
  s <- summary(model); ct <- s$coefficients
  if (!coef %in% rownames(ct)) {
    return(sprintf("%-58s | coef '%s' missing. avail=[%s]", label, coef,
                   paste(rownames(ct), collapse = ", ")))
  }
  est <- ct[coef, "Estimate"]
  se  <- ct[coef, "Cluster s.e."]
  if (is.na(se)) se <- ct[coef, "Std. Error"]
  pv  <- ct[coef, "Pr(>|t|)"]
  star <- ifelse(pv < 0.01, "***", ifelse(pv < 0.05, "**", ifelse(pv < 0.1, "*", "")))
  sprintf("%-58s | est=%+8.4f  SE=%6.4f  p=%6.4f %s  N=%d",
          label, est, se, pv, star, length(model$residuals))
}

run <- function(form_did, form_ddd, data, label, cluster_did = "riderDOW", cluster_ddd = "riderDOW") {
  cat("\n--- ", label, " ---\n", sep = "")
  m1 <- tryCatch(felm(form_did, data = data), error = function(e) {cat("DID ERR:", conditionMessage(e), "\n"); NULL})
  if (!is.null(m1)) cat(fmt(m1, paste(label, "DID  After:Treat"), "After:Treat"), "\n")
  m2 <- tryCatch(felm(form_ddd, data = data), error = function(e) {cat("DDD ERR:", conditionMessage(e), "\n"); NULL})
  if (!is.null(m2)) {
    for (c in c("After:Treat:prof_low", "After:Treat:prof_med", "After:Treat:prof_high"))
      cat(fmt(m2, paste(label, "DDD ", c), c), "\n")
  }
  invisible(list(did=m1, ddd=m2))
}

# ============================ Day-level (Table 4, 6) ============================
cat("\n========================================================\n")
cat(  "================  DAY-LEVEL (Tables 4, 6)  =============\n")
cat(  "========================================================\n")

# Table 4 — productivity
run(
  ln(orders_per_hour) ~ After:Treat | rider_id + station_date | 0 | riderDOW,
  ln(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                          After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW,
  data = day, label = "T4 ln(orders_per_hour)"
)

# Table 6 — total_orders
run(
  ln(total_orders) ~ After:Treat | rider_id + station_date | 0 | riderDOW,
  ln(total_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                       After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW,
  data = day, label = "T6 ln(total_orders)"
)

# Table 6 — total_shift (n_stacks)
run(
  ln(total_shift) ~ After:Treat | rider_id + station_date | 0 | riderDOW,
  ln(total_shift) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                      After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW,
  data = day, label = "T6 ln(total_shift)"
)

# Table 6 — total_fee (cluster by rider_id, per original line 1005-1008)
run(
  ln(total_fee) ~ After:Treat | rider_id + station_date | 0 | rider_id,
  ln(total_fee) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                    After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id,
  data = day, label = "T6 ln(total_fee)"
)

# Table 6 — total_labor (working hours)
run(
  ln(total_labor) ~ After:Treat | rider_id + station_date | 0 | riderDOW,
  ln(total_labor) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                     After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW,
  data = day, label = "T6 ln(total_labor)"
)

# ============================ Shift-level (Table 5) ============================
cat("\n========================================================\n")
cat(  "================  SHIFT-LEVEL (Table 5)  ==============\n")
cat(  "========================================================\n")

# T5 — num_orders per stack
run(
  ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW,
  ln(num_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                     After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW,
  data = shift, label = "T5 ln(num_orders)"
)

# T5 — total_duration (stack completion time)
run(
  ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW,
  ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                        After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW,
  data = shift, label = "T5 ln(total_duration)"
)

# T5 — avg_duration_orders (time per order in stack)
run(
  ln(avg_duration_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW,
  ln(avg_duration_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW,
  data = shift, label = "T5 ln(avg_duration_orders)"
)

# T5 — idle_btw_shifts
run(
  ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW,
  ln(idle_btw_shifts) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                          After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW,
  data = shift, label = "T5 ln(idle_btw_shifts)"
)

# ============================ Table 7 — waiting time ============================
cat("\n========================================================\n")
cat(  "================  TABLE 7 — waiting time  =============\n")
cat(  "========================================================\n")

# Shift-all
run(
  ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW,
  ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                     After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW,
  data = shift, label = "T7 shift-all ln(avg_waiting)"
)

# Single-order
run(
  ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW,
  ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                     After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW,
  data = shift[num_orders == 1], label = "T7 single ln(avg_waiting)"
)

# Stacked
run(
  ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW,
  ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                     After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW,
  data = shift[num_orders >= 2], label = "T7 stacked ln(avg_waiting)"
)

cat("\n=== reproduction (corrected spec) done ===\n")
