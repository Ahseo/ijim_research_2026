# =============================================================================
# 03b_pipeline_use_matched_data1.R
# Use my reconstructed datap_day/datap_shift, but filter by the SAVED
# matched_data1 (336 riders) so we get the EXACT regression sample.
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({
  library(data.table); library(dplyr); library(lubridate); library(lfe)
})
ln <- log

cat(sprintf("[%s] Loading RData + reconstructed datap_*\n", Sys.time()))
load("previous_resource/ISR_submitted ver_data.RData")

# Read my reconstructed datap_day and datap_shift
datap_day <- as.data.frame(fread("data/processed/datap_day_matched.csv"))
datap_shift <- as.data.frame(fread("data/processed/datap_shift_matched.csv"))

cat(sprintf("From previous run (324-rider sample): day=%d, shift=%d\n",
            nrow(datap_day), nrow(datap_shift)))

# Reload from full RData via the cached objects we built earlier.
# But those were already filtered to 324 riders. We need the FULL datap_day before filter.
# Easier: re-build from data_order (RData) ~quickly~

cat(sprintf("\n[%s] Rebuilding datap_day/datap_shift from data_order to keep all 584 riders\n", Sys.time()))
datap_order <- as.data.frame(data_order)

datap_shift1 <- datap_order %>%
  group_by(rider_id, management_partner_id, date, After, shift, rider_date) %>%
  summarise(num_orders = n(), num_aiorders = sum(is_rec_completed == 1),
            share_aiorders = num_aiorders / num_orders,
            avg_assign  = mean(assign_min),
            avg_pickup  = mean(pickup_min),
            avg_deliver = mean(delivery_min),
            avg_waiting = mean(waiting_min),
            sd_waiting  = sd(waiting_min),
            var_waiting = var(waiting_min),
            share_failed = sum(waiting_min > 30) / num_orders,
            avg_dist     = mean(distorigintodest),
            shift_profit = sum(rider_total_fee),
            avg_order_level = mean(order_level), .groups = "drop")
datap_shift2 <- datap_order %>%
  group_by(rider_id, Treat, management_partner_id, date, After, shift, rider_date) %>%
  summarise(start  = assignedat[which(row_number() == 1)],
            finish = max(deliveredat),
            total_duration = as.numeric(as.difftime(finish - start), units = "mins"),
            .groups = "drop")
datap_shift <- left_join(datap_shift1, datap_shift2,
                         by = c("rider_id","management_partner_id","date","After","shift","rider_date"))
rm(datap_shift1, datap_shift2)

idletimes <- function(c1, c2) c(NA, as.numeric(as.difftime(tail(c1,-1) - head(c2,-1)), units = "mins"))
datap_shift <- datap_shift %>%
  group_by(rider_id, Treat, management_partner_id, date, After, rider_date) %>%
  arrange(start, .by_group = TRUE) %>%
  mutate(idle_btw_shifts = idletimes(start, finish)) %>% ungroup()
datap_shift$idle_btw_shifts <- ifelse(datap_shift$idle_btw_shifts > 60, NA, datap_shift$idle_btw_shifts)
datap_shift$avg_duration_orders <- datap_shift$total_duration / datap_shift$num_orders
datap_shift$ai_assist <- ifelse(datap_shift$num_aiorders == 0, 0, 1)
datap_shift$station_date <- paste(datap_shift$management_partner_id, datap_shift$date, sep = "_")
datap_shift$start_hour <- hour(datap_shift$start)
datap_shift <- datap_shift %>% mutate(wday = wday(date),
                                      hourDOW  = paste(start_hour, wday, sep = "_"),
                                      riderDOW = paste(rider_id, wday, sep = "_"))
datap_shift <- as.data.frame(datap_shift)
cat(sprintf("[%s] datap_shift FULL: %d rows, %d riders\n",
            Sys.time(), nrow(datap_shift), uniqueN(datap_shift$rider_id)))

datap_day1 <- datap_shift %>%
  group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>%
  summarise(total_shift = n(),
            mean_orders_shift = mean(num_orders),
            mean_duration_shift = mean(total_duration),
            share_aggshift = sum(num_orders > 1) / total_shift,
            orders_stacked = sum(num_orders[num_orders > 1]),
            orders_one    = sum(num_orders[num_orders == 1]),
            mean_orders_aggshift   = mean(num_orders[num_orders > 1]),
            mean_duration_aggshift = mean(total_duration[num_orders > 1]),
            total_fee = sum(shift_profit), .groups = "drop")
datap_day2 <- datap_shift %>%
  group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>%
  summarise(working_duration = sum(total_duration) / 60,
            idle_duration    = sum(idle_btw_shifts, na.rm = TRUE) / 60,
            total_labor      = working_duration + idle_duration,
            total_orders     = sum(num_orders),
            total_aiorders   = sum(num_aiorders),
            ai_assist_day    = ifelse(total_aiorders == 0, 0, 1),
            share_workingd   = working_duration / total_labor,
            share_idled      = idle_duration   / total_labor,
            orders_per_hour  = total_orders / total_labor, .groups = "drop")
datap_day3 <- datap_order %>%
  group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>%
  summarise(avg_waiting = mean(waiting_min),
            sd_waiting  = sd(waiting_min),
            var_waiting = var(waiting_min),
            share_failedorders = sum(waiting_min > 30) / n(), .groups = "drop")
datap_day <- left_join(datap_day1, datap_day2,
                       by = c("rider_id","Treat","management_partner_id","date","After","station_date","rider_date")) %>%
             left_join(datap_day3,
                       by = c("rider_id","Treat","management_partner_id","date","After","station_date","rider_date")) %>%
             as.data.frame()
rm(datap_day1, datap_day2, datap_day3)
datap_day$wday <- wday(datap_day$date)
datap_day <- datap_day %>% mutate(riderDOW = paste(rider_id, wday, sep = "_"))
cat(sprintf("[%s] datap_day FULL: %d rows, %d riders\n",
            Sys.time(), nrow(datap_day), uniqueN(datap_day$rider_id)))

# Add prof_*  using saved proficiency data
prof_table <- as.data.frame(proficiency)[, c("rider_id","prof","prof_low","prof_med","prof_high")]
datap_day   <- left_join(datap_day,   prof_table, by = "rider_id")
datap_shift <- left_join(datap_shift, prof_table, by = "rider_id")

# ----- Filter to matched_data1 (336 riders) + buffer ----------------------
buffer <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31"))
matched_riders <- as.data.frame(matched_data1)$rider_id
cat(sprintf("[%s] using matched_data1: %d riders\n", Sys.time(), length(matched_riders)))

datap_day_matched   <- datap_day   %>% filter(rider_id %in% matched_riders) %>% filter(!date %in% buffer) %>% as.data.frame()
datap_shift_matched <- datap_shift %>% filter(rider_id %in% matched_riders) %>% filter(!date %in% buffer) %>% as.data.frame()
cat(sprintf("[%s] datap_day_matched   : %d rows, %d riders\n",
            Sys.time(), nrow(datap_day_matched), uniqueN(datap_day_matched$rider_id)))
cat(sprintf("[%s] datap_shift_matched : %d rows, %d riders\n",
            Sys.time(), nrow(datap_shift_matched), uniqueN(datap_shift_matched$rider_id)))

fwrite(datap_day_matched,   "data/processed/datap_day_matched.csv")
fwrite(datap_shift_matched, "data/processed/datap_shift_matched.csv")

# ----- Regressions ---------------------------------------------------------
fmt <- function(m, label, coef){
  ct <- summary(m)$coefficients
  if (!coef %in% rownames(ct)) return(sprintf("%-58s | coef '%s' missing", label, coef))
  e <- ct[coef,"Estimate"]; s <- ct[coef,"Cluster s.e."]; if (is.na(s)) s <- ct[coef,"Std. Error"]
  p <- ct[coef,"Pr(>|t|)"]
  star <- ifelse(p<0.01,"***",ifelse(p<0.05,"**",ifelse(p<0.1,"*","")))
  sprintf("%-58s | est=%+8.4f SE=%6.4f p=%6.4f %s N=%d",
          label, e, s, p, star, length(m$residuals))
}
run_pair <- function(label, dv, data, fe_did, fe_ddd = fe_did,
                     cluster_did = "riderDOW", cluster_ddd = "riderDOW",
                     extras = "") {
  cat(sprintf("\n--- %s ---\n", label))
  did_form <- as.formula(sprintf("ln(%s) ~ After:Treat %s | %s | 0 | %s", dv, extras, fe_did, cluster_did))
  m_did <- felm(did_form, data = data)
  cat(fmt(m_did, sprintf("DID  ln(%s)", dv), "After:Treat"), "\n")
  ddd_form <- as.formula(sprintf("ln(%s) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high %s | %s | 0 | %s",
                                  dv, extras, fe_ddd, cluster_ddd))
  m_ddd <- felm(ddd_form, data = data)
  for (c in c("After:Treat:prof_low","After:Treat:prof_med","After:Treat:prof_high"))
    cat(fmt(m_ddd, sprintf("DDD  ln(%s) %s", dv, c), c), "\n")
}

cat("\n=========== Table 4 (productivity) ===========\n")
run_pair("T4 productivity", "orders_per_hour", datap_day_matched, "rider_id + station_date")
cat("\n=========== Table 6 (day-level) ===========\n")
run_pair("T6 n_stacks",     "total_shift",  datap_day_matched, "rider_id + station_date")
run_pair("T6 total_orders", "total_orders", datap_day_matched, "rider_id + station_date")
run_pair("T6 total_fee",    "total_fee",    datap_day_matched, "rider_id + station_date", cluster_did = "rider_id", cluster_ddd = "rider_id")
run_pair("T6 total_labor",  "total_labor",  datap_day_matched, "rider_id + station_date", fe_ddd = "rider_id + management_partner_id + date")

cat("\n=========== Table 5 (stack-level) ===========\n")
run_pair("T5 num_orders",          "num_orders",          datap_shift_matched, "rider_id + station_date + hourDOW")
run_pair("T5 total_duration",      "total_duration",      datap_shift_matched, "rider_id + station_date + hourDOW")
run_pair("T5 avg_duration_orders", "avg_duration_orders", datap_shift_matched, "rider_id + station_date + hourDOW")
run_pair("T5 idle_btw_shifts",     "idle_btw_shifts",     datap_shift_matched, "rider_id + station_date + hourDOW")

cat("\n=========== Table 7 (waiting time) ===========\n")
run_pair("T7 shift-all",     "avg_waiting", datap_shift_matched,                              "rider_id + station_date + hourDOW", extras = "+ avg_dist")
run_pair("T7 shift-single",  "avg_waiting", datap_shift_matched %>% filter(num_orders == 1),  "rider_id + station_date + hourDOW", extras = "+ avg_dist")
run_pair("T7 shift-stacked", "avg_waiting", datap_shift_matched %>% filter(num_orders >= 2),  "rider_id + station_date + hourDOW", extras = "+ avg_dist")

cat(sprintf("\n[%s] DONE\n", Sys.time()))
