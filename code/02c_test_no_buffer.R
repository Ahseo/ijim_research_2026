setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
suppressPackageStartupMessages({ library(data.table); library(lfe) })
ln <- log
load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)
shift <- as.data.table(data_shift_matched1)
buffer <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31"))

cat("===== Variant comparison =====\n")
cat("[A] No buffer filter (raw 14102 rows)\n")
cat("[B] With buffer filter (12813 rows)\n\n")

run_T6 <- function(d, label) {
  cat(sprintf("\n--- %s ---\n", label))
  for (dv in c("total_orders", "total_fee", "total_labor", "total_shift")) {
    f1 <- as.formula(sprintf("ln(%s) ~ After:Treat | rider_id + station_date | 0 | riderDOW", dv))
    m1 <- felm(f1, data = d)
    ct <- summary(m1)$coefficients
    if ("After:Treat" %in% rownames(ct)) {
      e <- ct["After:Treat","Estimate"]; s <- ct["After:Treat","Cluster s.e."]; p <- ct["After:Treat","Pr(>|t|)"]
      cat(sprintf("  DID  ln(%-12s) After:Treat   est=%+.4f SE=%.4f p=%.4f\n", dv, e, s, p))
    }
    f2 <- as.formula(sprintf("ln(%s) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW", dv))
    m2 <- felm(f2, data = d)
    ct <- summary(m2)$coefficients
    for (cn in c("After:Treat:prof_low","After:Treat:prof_med","After:Treat:prof_high")) {
      e <- ct[cn,"Estimate"]; s <- ct[cn,"Cluster s.e."]; p <- ct[cn,"Pr(>|t|)"]
      cat(sprintf("  DDD  ln(%-12s) %-22s est=%+.4f SE=%.4f p=%.4f\n", dv, cn, e, s, p))
    }
  }
}

run_T6(day, "[A] NO buffer filter")
run_T6(day[!date %in% buffer], "[B] WITH buffer filter")

# Also try treating w1 (first post week) as pre - exclude only it
cat("\n[C] Drop the entire w1 week (Oct 26 ~ Nov 1)\n")
w1_dates <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31","2020-11-01"))
run_T6(day[!date %in% w1_dates], "[C] No w1 week")

# Try a wider exclusion — first 2 weeks
cat("\n[D] Drop first TWO weeks of post (Oct 26 ~ Nov 8)\n")
w12 <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31",
                 "2020-11-01","2020-11-02","2020-11-03","2020-11-04","2020-11-05","2020-11-06","2020-11-07","2020-11-08"))
run_T6(day[!date %in% w12], "[D] No w1+w2 weeks")
