# Save reproduction coefficient tables as csv for permanent reference
setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
suppressPackageStartupMessages({ library(data.table); library(lfe) })
ln <- log
load("previous_resource/ISR_submitted ver_data.RData")
buffer <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31"))
day   <- as.data.table(data_day_matched1)[!date %in% buffer]
shift <- as.data.table(data_shift_matched1)[!date %in% buffer]

extract_coefs <- function(model, label) {
  ct <- summary(model)$coefficients
  data.table(spec = label, term = rownames(ct),
             estimate = ct[,"Estimate"],
             std_error = ct[,"Cluster s.e."],
             p_value = ct[,"Pr(>|t|)"],
             N = length(model$residuals))
}

run <- function(label, dv, data, fe, cluster, log_outcome = TRUE, extras = "") {
  outcome <- if (log_outcome) sprintf("ln(%s)", dv) else dv
  did_form <- as.formula(sprintf("%s ~ After:Treat %s | %s | 0 | %s", outcome, extras, fe, cluster))
  ddd_form <- as.formula(sprintf("%s ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high %s | %s | 0 | %s",
                                  outcome, extras, fe, cluster))
  rbind(extract_coefs(felm(did_form, data = data), paste0(label, " DID")),
        extract_coefs(felm(ddd_form, data = data), paste0(label, " DDD")))
}

results <- list(
  run("T4 orders_per_hour",       "orders_per_hour",     day,   "rider_id + station_date", "riderDOW"),
  run("T6 total_shift (n_stacks)","total_shift",         day,   "rider_id + station_date", "riderDOW"),
  run("T6 total_orders",          "total_orders",        day,   "rider_id + station_date", "riderDOW"),
  run("T6 total_fee (earnings)",  "total_fee",           day,   "rider_id + station_date", "rider_id"),
  run("T6 total_labor (hours)",   "total_labor",         day,   "rider_id + station_date", "riderDOW"),
  run("T5 num_orders",            "num_orders",          shift, "rider_id + station_date + hourDOW", "riderDOW"),
  run("T5 total_duration",        "total_duration",      shift, "rider_id + station_date + hourDOW", "riderDOW"),
  run("T5 avg_duration_orders",   "avg_duration_orders", shift, "rider_id + station_date + hourDOW", "riderDOW"),
  run("T5 idle_btw_shifts",       "idle_btw_shifts",     shift, "rider_id + station_date + hourDOW", "riderDOW"),
  run("T7 shift-all avg_waiting",     "avg_waiting", shift,                       "rider_id + station_date + hourDOW", "riderDOW", extras = "+ avg_dist"),
  run("T7 shift-single avg_waiting",  "avg_waiting", shift[num_orders == 1],      "rider_id + station_date + hourDOW", "riderDOW", extras = "+ avg_dist"),
  run("T7 shift-stacked avg_waiting", "avg_waiting", shift[num_orders >= 2],      "rider_id + station_date + hourDOW", "riderDOW", extras = "+ avg_dist")
)
all_results <- rbindlist(results)
fwrite(all_results, "output/tables/01_reproduction_all_coefficients.csv")
cat(sprintf("Saved %d coefficient rows to output/tables/01_reproduction_all_coefficients.csv\n", nrow(all_results)))

# Mini summary table
key <- all_results[term %in% c("After:Treat", "After:Treat:prof_low", "After:Treat:prof_med", "After:Treat:prof_high")]
key[, sig := fcase(p_value < 0.01, "***",
                    p_value < 0.05, "**",
                    p_value < 0.1,  "*",
                    default = "")]
fwrite(key, "output/tables/01_reproduction_key_coefficients.csv")
cat(sprintf("Saved %d key rows to output/tables/01_reproduction_key_coefficients.csv\n", nrow(key)))
print(key)
