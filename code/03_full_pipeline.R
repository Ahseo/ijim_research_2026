# =============================================================================
# 03_full_pipeline.R  (V2 — fast version)
# Use data_order from RData (already preprocessed = datap_order),
# rebuild datap_shift, datap_day, run psmatch2_peak from scratch,
# run all regressions, compare to manuscript.
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
t0 <- Sys.time()
cat(sprintf("\n[%s] PIPELINE START\n", Sys.time()))

suppressPackageStartupMessages({
  for (p in c("data.table","dplyr","lubridate","lfe","MatchIt")) {
    if (!requireNamespace(p, quietly = TRUE)) install.packages(p, repos = "https://cloud.r-project.org")
  }
  library(data.table); library(dplyr); library(lubridate); library(lfe); library(MatchIt)
})
ln <- log
`%!in%` <- function(x,y) !(x %in% y)

# ----- Load preprocessed data_order from RData ------------------------------
cat(sprintf("[%s] [01] loading RData (data_order = datap_order, fully preprocessed)\n", Sys.time()))
load("previous_resource/ISR_submitted ver_data.RData")
datap_order <- as.data.frame(data_order)
cat(sprintf("[%s]    datap_order: %d rows, %d riders\n",
            Sys.time(), nrow(datap_order), length(unique(datap_order$rider_id))))

# treatp_riders (replicate from line 30-35)
treatp_riders <- datap_order %>% group_by(rider_id) %>%
  summarise(total_orders = n(),
            ai_completed_orders = sum(is_rec_completed),
            adopt_date = min(date[is_rec_completed == 1]),
            share_aiorder = ai_completed_orders / total_orders, .groups = "drop") %>%
  filter(ai_completed_orders >= 1)
cat(sprintf("[%s]    treatp_riders: %d adopters\n", Sys.time(), nrow(treatp_riders)))

# ----- Build datap_shift (replicate of 02 lines 79-164) --------------------
cat(sprintf("\n[%s] [02] building datap_shift...\n", Sys.time()))
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
datap_shift <- datap_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, rider_date) %>%
  arrange(shift, .by_group = TRUE) %>% mutate(pre_shift_orders = lag(num_orders)) %>% ungroup()
datap_shift <- as.data.frame(datap_shift)
cat(sprintf("[%s]    datap_shift: %d rows\n", Sys.time(), nrow(datap_shift)))

# ----- Build datap_day (replicate 02 lines 174-235) ------------------------
cat(sprintf("\n[%s] [03] building datap_day...\n", Sys.time()))
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
rm(datap_day1, datap_day2, datap_day3); gc(verbose = FALSE)
datap_day$wday <- wday(datap_day$date)
datap_day <- datap_day %>% mutate(riderDOW = paste(rider_id, wday, sep = "_"))
cat(sprintf("[%s]    datap_day: %d rows\n", Sys.time(), nrow(datap_day)))

# ----- Proficiency (replicate 02 lines 240-279) ----------------------------
cat(sprintf("\n[%s] [04] proficiency + matching covariates...\n", Sys.time()))
proficiency_peak <- datap_day %>% filter(date < "2020-10-26") %>%
  group_by(rider_id) %>% summarise(prof = mean(orders_per_hour), .groups = "drop")
qts <- quantile(proficiency_peak$prof, probs = c(.333, .667))
proficiency_peak <- proficiency_peak %>%
  mutate(prof_low  = ifelse(prof < qts[1], 1, 0),
         prof_med  = ifelse(prof >= qts[1] & prof < qts[2], 1, 0),
         prof_high = ifelse(prof >= qts[2], 1, 0))

# Merge
datap_shift <- left_join(datap_shift, proficiency_peak, by = "rider_id")
datap_day   <- left_join(datap_day,   proficiency_peak, by = "rider_id")

# ----- Matching covariates (02 lines 290-400) -----------------------------
datap_order_pre <- datap_order %>% filter(After == 0)

# daily_delivered_stores
pre_var_peak <- datap_order_pre %>% group_by(rider_id, date) %>%
  summarise(num_delivered_stores = length(unique(store_id)), .groups = "drop") %>%
  group_by(rider_id) %>%
  summarise(daily_delivered_stores = mean(num_delivered_stores), .groups = "drop")

# weekly working days (weeks 2-5 in pre period)
datap_order_pre_w <- datap_order_pre %>% mutate(date_chr = as.character(date)) %>%
  mutate(week = case_when(
    date_chr == "2020-09-26" ~ 1,
    date_chr %in% c("2020-09-27","2020-09-28","2020-09-29","2020-09-30","2020-10-01","2020-10-02","2020-10-03") ~ 2,
    date_chr %in% c("2020-10-04","2020-10-05","2020-10-06","2020-10-07","2020-10-08","2020-10-09","2020-10-10") ~ 3,
    date_chr %in% c("2020-10-11","2020-10-12","2020-10-13","2020-10-14","2020-10-15","2020-10-16","2020-10-17") ~ 4,
    date_chr %in% c("2020-10-18","2020-10-19","2020-10-20","2020-10-21","2020-10-22","2020-10-23","2020-10-24") ~ 5,
    date_chr == "2020-10-25" ~ 6, TRUE ~ NA_real_))
test <- datap_order_pre_w %>% filter(week %in% 2:5) %>%
  group_by(rider_id, week) %>% summarise(num_working_days = length(unique(date)), .groups = "drop") %>%
  group_by(rider_id) %>% summarise(num_working_days = mean(num_working_days), .groups = "drop")
pre_var_peak <- left_join(pre_var_peak, test, by = "rider_id")

# tenure
datap_order_pre$created_at <- as.Date(datap_order_pre$created_at)
datap_order_pre <- datap_order_pre %>% mutate(tenure = as.numeric(as.Date("2020-10-26") - created_at))
test <- datap_order_pre %>% group_by(rider_id) %>% summarise(tenure = unique(tenure), .groups = "drop")
pre_var_peak <- left_join(pre_var_peak, test, by = "rider_id")

# shift-level pre averages
test <- datap_shift %>% filter(date < "2020-10-26") %>% group_by(rider_id) %>%
  summarise(avg_assign_shift   = mean(avg_assign),
            avg_pickup_shift   = mean(avg_pickup),
            avg_deliver_shift  = mean(avg_deliver),
            avg_waiting_shift  = mean(avg_waiting),
            avg_orders_shift   = mean(num_orders),
            avg_duration_shift = mean(total_duration),
            avg_idle_shift     = mean(idle_btw_shifts, na.rm = TRUE),
            avg_duration_orders = mean(avg_duration_orders), .groups = "drop")
pre_var_peak <- left_join(pre_var_peak, test, by = "rider_id")

# day-level pre averages
test <- datap_day %>% filter(date < "2020-10-26") %>% group_by(rider_id) %>%
  summarise(daily_total_shift = mean(total_shift),
            daily_working_duration = mean(working_duration),
            daily_idle_duration = mean(idle_duration),
            daily_total_labor = mean(total_labor),
            daily_total_order = mean(total_orders),
            daily_share_idled = mean(share_idled),
            daily_orders_per_hour = mean(orders_per_hour),
            daily_profit = mean(total_fee), .groups = "drop")
pre_var_peak <- left_join(pre_var_peak, test, by = "rider_id")
pre_var_peak$Treat <- ifelse(pre_var_peak$rider_id %in% treatp_riders$rider_id, 1, 0)
pre_var_peak <- left_join(pre_var_peak, proficiency_peak, by = "rider_id")
pre_var_peak_nona <- na.omit(pre_var_peak)
cat(sprintf("[%s]    pre_var_peak_nona: %d riders\n", Sys.time(), nrow(pre_var_peak_nona)))

# ----- psmatch2_peak (caliper 0.05) ----------------------------------------
cat(sprintf("\n[%s] [05] psmatch2_peak (caliper 0.05)...\n", Sys.time()))
set.seed(42)
psmatch2_peak <- matchit(Treat ~ daily_delivered_stores + num_working_days +
                            avg_waiting_shift + avg_orders_shift + avg_duration_shift +
                            daily_total_labor + daily_idle_duration,
                          method = "nearest", data = pre_var_peak_nona,
                          caliper = 0.05, std.caliper = TRUE, discard = "both")
matched_data <- match.data(psmatch2_peak)
cat(sprintf("[%s]    matched riders: %d\n", Sys.time(), nrow(matched_data)))

# ----- Filter to matched + buffer -----------------------------------------
buffer <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31"))
datap_day_matched   <- datap_day   %>% filter(rider_id %in% matched_data$rider_id) %>% filter(!date %in% buffer) %>% as.data.frame()
datap_shift_matched <- datap_shift %>% filter(rider_id %in% matched_data$rider_id) %>% filter(!date %in% buffer) %>% as.data.frame()
cat(sprintf("[%s]    datap_day_matched   : %d rows, %d riders\n",
            Sys.time(), nrow(datap_day_matched), length(unique(datap_day_matched$rider_id))))
cat(sprintf("[%s]    datap_shift_matched : %d rows, %d riders\n",
            Sys.time(), nrow(datap_shift_matched), length(unique(datap_shift_matched$rider_id))))

# Save final datasets
fwrite(datap_day_matched,   "data/processed/datap_day_matched.csv")
fwrite(datap_shift_matched, "data/processed/datap_shift_matched.csv")

# ----- Regressions ---------------------------------------------------------
cat(sprintf("\n[%s] [06] regressions...\n", Sys.time()))

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
run_pair("T6 n_stacks",       "total_shift",  datap_day_matched, "rider_id + station_date")
run_pair("T6 total_orders",   "total_orders", datap_day_matched, "rider_id + station_date")
run_pair("T6 total_fee",      "total_fee",    datap_day_matched, "rider_id + station_date", cluster_did = "rider_id", cluster_ddd = "rider_id")
run_pair("T6 total_labor",    "total_labor",  datap_day_matched, "rider_id + station_date", fe_ddd = "rider_id + management_partner_id + date")

cat("\n=========== Table 5 (stack-level) ===========\n")
run_pair("T5 num_orders",          "num_orders",          datap_shift_matched, "rider_id + station_date + hourDOW")
run_pair("T5 total_duration",      "total_duration",      datap_shift_matched, "rider_id + station_date + hourDOW")
run_pair("T5 avg_duration_orders", "avg_duration_orders", datap_shift_matched, "rider_id + station_date + hourDOW")
run_pair("T5 idle_btw_shifts",     "idle_btw_shifts",     datap_shift_matched, "rider_id + station_date + hourDOW")

cat("\n=========== Table 7 (waiting time) ===========\n")
run_pair("T7 shift-all",     "avg_waiting", datap_shift_matched,                                     "rider_id + station_date + hourDOW", extras = "+ avg_dist")
run_pair("T7 shift-single",  "avg_waiting", datap_shift_matched %>% filter(num_orders == 1),         "rider_id + station_date + hourDOW", extras = "+ avg_dist")
run_pair("T7 shift-stacked", "avg_waiting", datap_shift_matched %>% filter(num_orders >= 2),         "rider_id + station_date + hourDOW", extras = "+ avg_dist")

cat(sprintf("\n[%s] PIPELINE END  total = %.1f min\n",
            Sys.time(), as.numeric(difftime(Sys.time(), t0, units = "mins"))))
