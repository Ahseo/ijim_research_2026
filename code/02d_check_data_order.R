setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
load("previous_resource/ISR_submitted ver_data.RData")
cat("=== data_order columns ===\n")
print(names(data_order))
cat("\n=== data_order date range ===\n")
print(range(data_order$date, na.rm=TRUE))
cat(sprintf("\nrows: %d, riders: %d\n", nrow(data_order), length(unique(data_order$rider_id))))

# check if shift, prof_low, etc. are present
key_cols <- c("shift","Treat","After","prof_low","prof_med","prof_high","riderDOW","station_date","hourDOW","is_rec_completed","waiting_min","rider_total_fee","order_level")
for (k in key_cols) cat(sprintf("  %-25s %s\n", k, ifelse(k %in% names(data_order), "OK", "MISSING")))
