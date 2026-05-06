# =============================================================================
# 04_manuscript_exact_spec.R
# Match manuscript Table 4-7 EXACTLY using:
#   - LINEAR outcome (NOT log)
#   - DDD: After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high
#                + After:prof_med + After:prof_high
#   - FE: rider_id + station_date (+ hourDOW for stack-level)
#   - Cluster: rider_id  (manuscript footnote: "clustered at rider level")
#   - NO buffer filter (Tables show 14,102 obs = full sample)
#   - For Table 7: + avg_dist control
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({ library(data.table); library(lfe) })
load("previous_resource/ISR_submitted ver_data.RData")
day   <- as.data.table(data_day_matched1)
shift <- as.data.table(data_shift_matched1)

cat(sprintf("day rows = %d (manuscript expects 14,102)\n", nrow(day)))
cat(sprintf("shift rows = %d (manuscript expects 153,190)\n", nrow(shift)))

fmt <- function(m, label, coef){
  ct <- summary(m)$coefficients
  if (!coef %in% rownames(ct)) return(sprintf("%-58s | coef '%s' missing", label, coef))
  e <- ct[coef,"Estimate"]; s <- ct[coef,"Cluster s.e."]
  if (is.na(s)) s <- ct[coef,"Std. Error"]
  p <- ct[coef,"Pr(>|t|)"]
  star <- ifelse(p<0.01,"***",ifelse(p<0.05,"**",ifelse(p<0.1,"*","")))
  sprintf("%-58s | est=%+8.4f SE=%6.4f p=%6.4f %s N=%d",
          label, e, s, p, star, length(m$residuals))
}

run_pair <- function(label, dv, data, fe, extras = "") {
  cat(sprintf("\n--- %s ---\n", label))
  did_form <- as.formula(sprintf("%s ~ After:Treat %s | %s | 0 | rider_id", dv, extras, fe))
  m_did <- felm(did_form, data = data)
  cat(fmt(m_did, sprintf("DID  %s", dv), "After:Treat"), "\n")
  ddd_form <- as.formula(sprintf("%s ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high %s | %s | 0 | rider_id", dv, extras, fe))
  m_ddd <- felm(ddd_form, data = data)
  for (c in c("After:Treat:prof_low","After:Treat:prof_med","After:Treat:prof_high"))
    cat(fmt(m_ddd, sprintf("DDD  %s %s", dv, c), c), "\n")
}

cat("\n========================  Table 4 (productivity)  ==============================\n")
cat("Manuscript: DID 0.141***(0.047), low 0.088(0.071), med 0.249***(0.066), high 0.067(0.084)\n")
run_pair("T4 orders_per_hour (LINEAR)", "orders_per_hour", day, "rider_id + station_date")

cat("\n========================  Table 6 (day-level)  =================================\n")
cat("Manuscript T6 col1 DDD low 0.380(0.450), med 0.299(0.445), high -0.548(0.397) [n_stacks]\n")
run_pair("T6 total_shift (LINEAR)", "total_shift", day, "rider_id + station_date")
cat("\nManuscript T6 col2 DDD low 2.060**(0.916), med 2.086**(1.048), high -0.164(1.247) [total_orders]\n")
run_pair("T6 total_orders (LINEAR)", "total_orders", day, "rider_id + station_date")
cat("\nManuscript T6 col3 DDD low 4.384**(1.956), med 4.409*(2.266), high -0.205(2.619) [total_earnings, $]\n")
# total_fee (KRW) — manuscript shows in $; check unit
run_pair("T6 total_fee (LINEAR)", "total_fee", day, "rider_id + station_date")
cat("\nManuscript T6 col4 DDD low 0.438*(0.256), med 0.095(0.215), high -0.147(0.187) [working hours]\n")
run_pair("T6 total_labor (LINEAR)", "total_labor", day, "rider_id + station_date")

cat("\n========================  Table 5 (stack-level)  ===============================\n")
cat("Manuscript T5 col1 DDD low 0.142**(0.070), med 0.133*(0.078), high 0.166(0.145) [num_orders]\n")
run_pair("T5 num_orders (LINEAR)", "num_orders", shift, "rider_id + station_date + hourDOW")
cat("\nManuscript T5 col2 DDD low 1.091*(0.564), med 0.523(0.637), high 0.856(1.013) [stack_completion_time]\n")
run_pair("T5 total_duration (LINEAR)", "total_duration", shift, "rider_id + station_date + hourDOW")
cat("\nManuscript T5 col3 DDD low 0.008(0.133), med -0.229**(0.093), high -0.040(0.069) [time_per_order]\n")
run_pair("T5 avg_duration_orders (LINEAR)", "avg_duration_orders", shift, "rider_id + station_date + hourDOW")
cat("\nManuscript T5 col4 DDD low 0.566**(0.286), med -0.583**(0.272), high -0.146(0.221) [idle_time]\n")
run_pair("T5 idle_btw_shifts (LINEAR)", "idle_btw_shifts", shift, "rider_id + station_date + hourDOW")

cat("\n========================  Table 7 (waiting time)  ==============================\n")
cat("Manuscript T7 col1 DID -0.025(0.084) [shift-all]\n")
cat("Manuscript T7 col2 DID -0.184**(0.085) [shift-single]\n")
cat("Manuscript T7 col3 DID 0.084(0.095) [shift-stacked]\n")
run_pair("T7 avg_waiting all (LINEAR)",     "avg_waiting", shift,                          "rider_id + station_date + hourDOW", extras = "+ avg_dist")
run_pair("T7 avg_waiting single (LINEAR)",  "avg_waiting", shift[num_orders == 1],         "rider_id + station_date + hourDOW", extras = "+ avg_dist")
run_pair("T7 avg_waiting stacked (LINEAR)", "avg_waiting", shift[num_orders >= 2],         "rider_id + station_date + hourDOW", extras = "+ avg_dist")
