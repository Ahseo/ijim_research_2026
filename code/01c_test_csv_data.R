# Compare RData data_day_matched1 vs drive_4/data_day_matched.csv to find which
# is the actual regression input that matches manuscript Table 6.
setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
suppressPackageStartupMessages({ library(data.table); library(lfe) })
ln <- log

load("previous_resource/ISR_submitted ver_data.RData")
csv_day <- fread("previous_resource/drive_4/data_day_matched.csv")

cat("=== RData data_day_matched1 ===\n")
cat(sprintf("rows: %d, riders: %d, cols: %d\n",
            nrow(data_day_matched1), uniqueN(data_day_matched1$rider_id), ncol(data_day_matched1)))
cat(sprintf("date range: %s ~ %s\n", min(data_day_matched1$date), max(data_day_matched1$date)))

cat("\n=== drive_4/data_day_matched.csv ===\n")
cat(sprintf("rows: %d, riders: %d, cols: %d\n", nrow(csv_day), uniqueN(csv_day$rider_id), ncol(csv_day)))
cat(sprintf("date range: %s ~ %s\n", min(csv_day$date), max(csv_day$date)))
cat("columns: ", paste(names(csv_day), collapse=", "), "\n")

# Buffer filter
buffer <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31"))
d_rdata <- as.data.table(data_day_matched1)[!date %in% buffer]
d_csv   <- as.data.table(csv_day)[!as.Date(date) %in% buffer]

cat(sprintf("\nAfter buffer filter — rdata: %d, csv: %d\n", nrow(d_rdata), nrow(d_csv)))

cat("\n=== T6 ln(total_orders) DID + DDD using RData ===\n")
m1 <- felm(ln(total_orders) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=d_rdata)
print(summary(m1)$coefficients)
m2 <- felm(ln(total_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=d_rdata)
print(summary(m2)$coefficients)

cat("\n=== T6 ln(total_orders) DID + DDD using CSV ===\n")
if ("riderDOW" %!in% names(d_csv) && all(c("rider_id", "wday") %in% names(d_csv))) {
  d_csv[, riderDOW := paste(rider_id, wday, sep = "_")]
}
if (!"After" %in% names(d_csv)) {
  d_csv[, After := as.integer(as.Date(date) >= as.Date("2020-10-26"))]
}
m3 <- felm(ln(total_orders) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=d_csv)
print(summary(m3)$coefficients)
m4 <- felm(ln(total_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=d_csv)
print(summary(m4)$coefficients)

# Also check if the RData object exists in CSV form (maybe different name)
cat("\n=== compare key columns mean values ===\n")
common <- intersect(names(d_rdata), names(d_csv))
for (col in c("total_orders", "total_fee", "total_labor", "orders_per_hour")) {
  if (col %in% common) {
    cat(sprintf("%-20s rdata mean=%10.4f , csv mean=%10.4f\n",
                col, mean(d_rdata[[col]], na.rm=TRUE), mean(d_csv[[col]], na.rm=TRUE)))
  }
}
