setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
suppressPackageStartupMessages({ library(data.table); library(lfe) })
ln <- log

load("previous_resource/ISR_submitted ver_data.RData")
csv_stack <- fread("previous_resource/drive_4/data_stack_matched.csv")
csv_day   <- fread("previous_resource/drive_4/data_day_matched.csv")

cat("=== RData data_shift_matched1 ===\n")
cat(sprintf("rows: %d, riders: %d, cols: %d\n",
            nrow(data_shift_matched1), uniqueN(data_shift_matched1$rider_id), ncol(data_shift_matched1)))
cat("cols:", paste(names(data_shift_matched1), collapse=", "), "\n\n")

cat("=== drive_4/data_stack_matched.csv ===\n")
cat(sprintf("rows: %d, riders: %d, cols: %d\n",
            nrow(csv_stack), uniqueN(csv_stack$rider_id), ncol(csv_stack)))
cat("cols:", paste(names(csv_stack), collapse=", "), "\n\n")

# rider overlap
rdata_riders <- unique(data_shift_matched1$rider_id)
csv_riders   <- unique(csv_stack$rider_id)
cat(sprintf("riders in BOTH: %d\n", length(intersect(rdata_riders, csv_riders))))
cat(sprintf("only RData: %d, only CSV: %d\n",
            length(setdiff(rdata_riders, csv_riders)),
            length(setdiff(csv_riders, rdata_riders))))

# T4 productivity from CSV-day to verify if they ALSO match
csv_day[, riderDOW := paste(rider_id, wday, sep="_")]
buffer <- as.Date(c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30","2020-10-31"))
csv_day[, date := as.Date(date)]
d <- csv_day[!date %in% buffer]
cat(sprintf("\nCSV day-matched after buffer: %d rows\n", nrow(d)))

# T6 ln(total_orders) DDD on CSV
m <- felm(ln(total_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
            After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=d)
cat("\n=== CSV T6 ln(total_orders) DDD ===\n")
print(summary(m)$coefficients)
