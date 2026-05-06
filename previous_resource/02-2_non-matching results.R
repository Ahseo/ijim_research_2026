####################################################################################################################################
##### Non-matching results #####
####################################################################################################################################

# data_order, data_shift, data_day
length(unique(data_shift$rider_id)) #584

####################################################################################################################################
head(data_shift)

model <- felm(ln(avg_waiting+1) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model <- felm(ln(avg_waiting+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(avg_waiting+1) ~ After:Treat+After:Treat:prof_50h | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)


model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(num_orders) ~ After+After:Treat+After:Treat:prof_50h | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)


model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(total_duration) ~ After:Treat+After:Treat:prof_50h | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)


model <- felm(ln(avg_duration_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(avg_duration_orders) ~ After:Treat+After:Treat:prof_50h | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)


model <- felm(ln(avg_order_level) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model <- felm(ln(avg_order_level) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(avg_order_level) ~ After:Treat+After:Treat:prof_50h | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)


model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(idle_btw_shifts) ~ After:Treat+After:Treat:prof_50h | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)


model <- felm(ln(avg_dist) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model <- felm(ln(avg_dist) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)



########################################################################################################################
head(data_day)

model <- felm(ln(total_orders) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(ln(total_orders) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(total_shift) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(ln(total_shift) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(share_aggshift ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(share_aggshift ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(working_duration) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(ln(working_duration) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(idle_duration+1) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(ln(idle_duration+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(total_labor) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(ln(total_labor) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(share_workingd ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(share_workingd ~ After+After:Treat+After:Treat:prof_50h | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)
model <- felm(share_workingd ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)



model <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(share_idled ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(orders_per_hour ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(orders_per_hour ~ After:prof_med + After:prof_high +
                After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(total_fee) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)
summary(model)
model <- felm(ln(total_fee) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_day) #감소
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)





########################################################################################################################

#오더레벨 데이터
model <- felm(ln(assign_sec+1) ~ After:Treat | rider_id + station_date + hourDOW + OD | 0 | rider_id, data=data_order)
summary(model)
model <- felm(ln(assign_sec+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW + OD | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(pickup_sec+1) ~ After:Treat | rider_id + station_date + hourDOW + OD | 0 | rider_id, data=data_order)
summary(model)
model <- felm(ln(pickup_sec+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW + OD | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(delivery_sec+1) ~ After:Treat | rider_id + station_date + hourDOW + OD | 0 | rider_id, data=data_order)
summary(model)
model <- felm(ln(delivery_sec+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW + OD | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(waiting_sec+1) ~ After:Treat | rider_id + station_date + hourDOW + OD| 0 | rider_id, data=data_order)
summary(model)
model <- felm(ln(waiting_sec+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW + OD| 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(distorigintodest+1) ~ After:Treat | rider_id + station_date + hourDOW| 0 | rider_id, data=data_order)
summary(model)
model <- felm(ln(distorigintodest+1) ~ After:Treat | rider_date + management_partner_id + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model <- felm(ln(distorigintodest+1) ~ After+After:Treat+After:Treat:prof_50h | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)
model <- felm(ln(distorigintodest+1) ~ After:Treat+After:Treat:prof_50h | rider_date + management_partner_id + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)
model <- felm(ln(distorigintodest+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(order_level) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model <- felm(ln(order_level) ~ After:Treat | rider_date + management_partner_id + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model <- felm(ln(order_level) ~ After+After:Treat+After:Treat:prof_50h | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)
model <- felm(ln(order_level) ~ After+After:Treat+After:Treat:prof_50h | rider_date + management_partner_id + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)
model <- felm(ln(order_level) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)



