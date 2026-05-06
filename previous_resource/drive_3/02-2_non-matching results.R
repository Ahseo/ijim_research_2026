################################################################################################################################################
##### DID, DDD model estimation #####
################################################################################################################################################
####################################################################################################################################
head(data_shift_matched)

data_shift_matched$peak <- ifelse(data_shift_matched$start_hour %in% c(11:13, 17:20),1,0)
data_shift_matched$midpeak <- ifelse(data_shift_matched$start_hour %in% c(14:16, 21:23),1,0)
data_shift_matched$offpeak <- ifelse(data_shift_matched$start_hour %in% c(0:10),1,0)

data_shift_matched$peak <- ifelse(data_shift_matched$start_hour %in% c(11:20),1,0)
data_shift_matched$offpeak <- ifelse(data_shift_matched$start_hour %in% c(0:10, 21:23),1,0)

model <- felm(ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)



test<-data_shift %>% filter(num_orders == 1)
model <- felm(ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)



test<-data_shift %>% filter(num_orders >= 2)
model <- felm(ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




model <- felm(ln(avg_assign+1) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)
model <- felm(ln(avg_assign+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)



model <- felm(ln(avg_pickup+1) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)
model <- felm(ln(avg_pickup+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)



model <- felm(ln(avg_deliver+1) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)
model <- felm(ln(avg_deliver+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)



model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)



model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)




model <- felm(ln(avg_duration_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)



test<-data_shift %>% filter(num_orders == 1)
model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-data_shift %>% filter(num_orders >=2)
model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-data_shift %>% filter(num_orders >=2)
model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-data_shift %>% filter(num_orders >=2)
model <- felm(ln(avg_duration_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)



model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift)
summary(model)


test<-data_shift %>% filter(pre_shift_orders == 1)
model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high| rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)


test<-data_shift %>% filter(pre_shift_orders >= 2)
model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high| rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)







########################################################################################################################
head(data_day_matched)

model <- felm(ln(total_orders) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(ln(total_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=data_day)
summary(model)




model <- felm(ln(total_shift) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(ln(total_shift) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=data_day)
summary(model)



model <- felm(share_aggshift ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(share_aggshift ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=data_day)
summary(model)



model <- felm(ln(orders_stacked+1) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(ln(orders_stacked+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=data_day)
summary(model)




model <- felm(ln(orders_one+1) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(ln(orders_one+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=data_day)
summary(model)




model <- felm(ln(working_duration) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(ln(working_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)


model <- felm(ln(idle_duration+1) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(ln(idle_duration+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)



model <- felm(ln(total_labor) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(ln(total_labor) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)




model <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(share_idled ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)




model <- felm(ln(orders_per_hour) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)
model <- felm(ln(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day)
summary(model)




model <- felm(ln(total_fee) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_fee) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_date, data=data_day_matched)
summary(model)
model <- felm(ln(total_fee) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)



model <- felm(ln(avg_waiting) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)



model <- felm(ln(var_waiting) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(var_waiting) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(var_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)


model <- felm(share_failedorders ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_failedorders ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_failedorders ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)

