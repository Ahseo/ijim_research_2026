# =============================================================================
# 17_table_cell_compare.R
# Compare EVERY cell of manuscript Tables 4-7 against our reproduction.
# Print exact deltas. Find any remaining mismatch.
# =============================================================================
setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({ library(data.table); library(lfe) })
load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)
shift <- as.data.table(data_shift_matched1)

# Helper
get_coef <- function(m, name) {
  ct <- summary(m)$coefficients
  if (!name %in% rownames(ct)) return(c(NA, NA))
  c(ct[name, "Estimate"], ct[name, "Cluster s.e."])
}

cmp <- function(label, mine_e, mine_s, ms_e, ms_s, tol_e = 0.005, tol_s = 0.005) {
  ok_e <- !is.na(mine_e) && abs(mine_e - ms_e) < tol_e
  ok_s <- !is.na(mine_s) && abs(mine_s - ms_s) < tol_s
  flag <- ifelse(ok_e && ok_s, "PASS", "MISMATCH")
  cat(sprintf("%-9s %-50s mine=%+8.4f (%6.4f)  manuscript=%+8.4f (%6.4f)  Δest=%+7.4f  ΔSE=%+7.4f\n",
              flag, label, mine_e, mine_s, ms_e, ms_s,
              ifelse(is.na(mine_e), NA, mine_e - ms_e),
              ifelse(is.na(mine_s), NA, mine_s - ms_s)))
  ok_e && ok_s
}

# ============== TABLE 4 (productivity) ==============
cat("\n========== TABLE 4 (Daily productivity) ==========\n")
m_did <- felm(orders_per_hour ~ After:Treat | rider_id + station_date | 0 | rider_id, data = day)
m_ddd <- felm(orders_per_hour ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data = day)

c1 <- get_coef(m_did, "After:Treat")
cmp("T4 col1 After:Treat (DID)", c1[1], c1[2], 0.141, 0.047)
cl <- get_coef(m_ddd, "After:Treat:prof_low")
cmp("T4 col2 After:Treat:Low",   cl[1], cl[2], 0.088, 0.071)
cm <- get_coef(m_ddd, "After:Treat:prof_med")
cmp("T4 col2 After:Treat:Med",   cm[1], cm[2], 0.249, 0.066)
ch <- get_coef(m_ddd, "After:Treat:prof_high")
cmp("T4 col2 After:Treat:High",  ch[1], ch[2], 0.067, 0.084)

# ============== TABLE 5 (stack-level) ==============
cat("\n========== TABLE 5 (Stack-level) ==========\n")
ms <- list(
  c1 = list(dv="num_orders",          ms_low=c(0.142,0.070), ms_med=c(0.133,0.078), ms_high=c(0.166,0.145)),
  c2 = list(dv="total_duration",      ms_low=c(1.091,0.564), ms_med=c(0.523,0.637), ms_high=c(0.856,1.013)),
  c3 = list(dv="avg_duration_orders", ms_low=c(0.008,0.133), ms_med=c(-0.229,0.093),ms_high=c(-0.040,0.069)),
  c4 = list(dv="idle_btw_shifts",     ms_low=c(0.566,0.286), ms_med=c(-0.583,0.272),ms_high=c(-0.146,0.221))
)
for (k in names(ms)) {
  s <- ms[[k]]
  m <- felm(as.formula(sprintf("%s ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id", s$dv)), data = shift)
  for (g in c("low","med","high")) {
    coef_name <- sprintf("After:Treat:prof_%s", g)
    actual <- get_coef(m, coef_name)
    expected <- s[[paste0("ms_", g)]]
    cmp(sprintf("T5 %s %s (%s)", k, g, s$dv), actual[1], actual[2], expected[1], expected[2])
  }
}

# ============== TABLE 6 (day-level) ==============
cat("\n========== TABLE 6 (Day-level) ==========\n")
ms6 <- list(
  c1 = list(dv="total_shift",  ms_low=c(0.380,0.450),    ms_med=c(0.299,0.445),    ms_high=c(-0.548,0.397)),
  c2 = list(dv="total_orders", ms_low=c(2.060,0.916),    ms_med=c(2.086,1.048),    ms_high=c(-0.164,1.247)),
  c3 = list(dv="total_fee",    ms_low=c(4.384,1.956),    ms_med=c(4.409,2.266),    ms_high=c(-0.205,2.619),
            scale=0.001),  # manuscript reports in $ (×1000 KRW); we'll handle
  c4 = list(dv="total_labor",  ms_low=c(0.438,0.256),    ms_med=c(0.095,0.215),    ms_high=c(-0.147,0.187))
)
for (k in names(ms6)) {
  s <- ms6[[k]]
  m <- felm(as.formula(sprintf("%s ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id", s$dv)), data = day)
  for (g in c("low","med","high")) {
    coef_name <- sprintf("After:Treat:prof_%s", g)
    actual <- get_coef(m, coef_name)
    expected <- s[[paste0("ms_", g)]]
    if (s$dv == "total_fee") {
      tol_e <- 5000; tol_s <- 5000  # KRW units, manuscript $ thousands
    } else {
      tol_e <- 0.05; tol_s <- 0.05
    }
    cmp(sprintf("T6 %s %s (%s)", k, g, s$dv), actual[1], actual[2], expected[1], expected[2], tol_e, tol_s)
  }
}

# ============== TABLE 7 (waiting time) ==============
cat("\n========== TABLE 7 (Customer waiting time) ==========\n")
m_t7_all <- felm(avg_waiting ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data = shift)
c <- get_coef(m_t7_all, "After:Treat"); cmp("T7 col1 DID all", c[1], c[2], -0.025, 0.084)
m_t7_s <- felm(avg_waiting ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data = shift[num_orders == 1])
c <- get_coef(m_t7_s, "After:Treat"); cmp("T7 col2 DID single", c[1], c[2], -0.184, 0.085)
m_t7_st <- felm(avg_waiting ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data = shift[num_orders >= 2])
c <- get_coef(m_t7_st, "After:Treat"); cmp("T7 col3 DID stacked", c[1], c[2], 0.084, 0.095)

# T7 DDD
m_t7_all_ddd <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data = shift)
for (g in c("low","med","high")) {
  cn <- sprintf("After:Treat:prof_%s", g); a <- get_coef(m_t7_all_ddd, cn)
  ms <- list(low=c(0.029,0.162), med=c(-0.129,0.135), high=c(0.082,0.131))[[g]]
  cmp(sprintf("T7 col4 DDD all %s", g), a[1], a[2], ms[1], ms[2])
}
m_t7_s_ddd <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data = shift[num_orders == 1])
for (g in c("low","med","high")) {
  cn <- sprintf("After:Treat:prof_%s", g); a <- get_coef(m_t7_s_ddd, cn)
  ms <- list(low=c(-0.009,0.172), med=c(-0.260,0.125), high=c(-0.178,0.120))[[g]]
  cmp(sprintf("T7 col5 DDD single %s", g), a[1], a[2], ms[1], ms[2])
}
m_t7_st_ddd <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data = shift[num_orders >= 2])
for (g in c("low","med","high")) {
  cn <- sprintf("After:Treat:prof_%s", g); a <- get_coef(m_t7_st_ddd, cn)
  ms <- list(low=c(-0.003,0.212), med=c(-0.024,0.160), high=c(0.226,0.128))[[g]]
  cmp(sprintf("T7 col6 DDD stacked %s", g), a[1], a[2], ms[1], ms[2])
}

cat("\n=== All-cell comparison done ===\n")
