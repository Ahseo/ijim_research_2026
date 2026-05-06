##### check parallel trend assumption #####

###############################################################################################################################################
##### midpoint placebo treatment #####
###############################################################################################################################################

### psmatch1에서 추출한 data_order_matched, data_shift_matched, data_day_matched 사용 -> shift-level에서 초보자의 num_order가 유의하게나옴..
### psmatch4에서 추출한 data_order_matched, data_shift_matched, data_day_matched 사용



### matching sample 데이터 중에서 Pretreatment period 데이터만 추출
#data_order_matched_pre <- data_order_matched1 %>% filter(After==0)
data_shift_matched_pre <- data_shift_matched1 %>% filter(After==0)
data_day_matched_pre <- data_day_matched1 %>% filter(After==0)

test_shift <- data_shift_matched_pre %>% filter(date >= as.Date("2020-09-28"))
test_day <- data_day_matched_pre %>% filter(date >= as.Date("2020-09-28"))

### placebo treatment: 2020-10-12
#data_order_matched_pre$After_premid <- ifelse(data_order_matched_pre$date>=as.Date("2020-10-11"),1,0)
data_shift_matched_pre$After_premid <- ifelse(data_shift_matched_pre$date>=as.Date("2020-10-12"),1,0)
data_day_matched_pre$After_premid <- ifelse(data_day_matched_pre$date>=as.Date("2020-10-12"),1,0)

test_shift$After_premid <- ifelse(test_shift$date>=as.Date("2020-10-12"),1,0)
test_day$After_premid <- ifelse(test_day$date>=as.Date("2020-10-12"),1,0)



###############################################################################################################################################
##### estimation
###############################################################################################################################################
#shift-level
#avg_waiting
m1 <- felm(avg_waiting ~ After_premid:Treat + avg_dist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_shift_matched_pre)
m2 <- felm(avg_waiting ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
                After_premid:prof_med + After_premid:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched_pre)
m1 <- felm(avg_waiting ~ After_premid:Treat + avg_dist | rider_id + station_date + hourDOW| 0 | rider_id, data=test_shift)
m2 <- felm(avg_waiting ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
             After_premid:prof_med + After_premid:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test_shift)
summary(m1)
summary(m2)
tab_model(m1,m2,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After_premid:prof_med", "After_premid:prof_high", "avg_dist"))

#num_orders, total_duration, avg_duration_orders, idle_btw_shifts
m1 <- felm(avg_duration_orders ~ After_premid:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched_pre)
m2 <- felm(avg_duration_orders ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
             After_premid:prof_med + After_premid:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched_pre)
m1 <- felm(avg_duration_orders ~ After_premid:Treat | rider_id + station_date + hourDOW| 0 | rider_id, data=test_shift)
m2 <- felm(avg_duration_orders ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
             After_premid:prof_med + After_premid:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=test_shift)

summary(m1)
summary(m2)
tab_model(m1,m2,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After_premid:prof_med", "After_premid:prof_high"))




#day-level
#total_orders, total_shift, total_labor, total_fee, orders_per_hour
m1 <- felm(total_fee ~ After_premid:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched_pre)
m2 <- felm(total_fee ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
                After_premid:prof_med + After_premid:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched_pre)
m1 <- felm(orders_per_hour ~ After_premid:Treat | rider_id + station_date | 0 | rider_id, data=test_day)
m2 <- felm(orders_per_hour ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
             After_premid:prof_med + After_premid:prof_high | rider_id + station_date | 0 | rider_id, data=test_day)
summary(m1)
summary(m2)

tab_model(m1,m2,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After_premid:prof_med", "After_premid:prof_high"))







model <- felm(total_labor ~ After_premid:Treat | rider_id + station_date| 0 | rider_id, data=data_day_matched_pre)
summary(model)
model <- felm(total_labor ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
                After_premid:prof_med + After_premid:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched_pre)
summary(model)



model <- felm(share_idled ~ After_premid:Treat | rider_id + station_date| 0 | rider_id, data=data_day_matched_pre)
summary(model)
model <- felm(share_idled ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
                After_premid:prof_med + After_premid:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched_pre)
summary(model)


m1 <- felm(ln(orders_per_hour) ~ After_premid:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched_pre)
m2 <- felm(ln(orders_per_hour) ~ After_premid:Treat:prof_low + After_premid:Treat:prof_med + After_premid:Treat:prof_high + 
                After_premid:prof_med + After_premid:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched_pre)
summary(m1)
summary(m2)
tab_model(m1,m2,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After_premid:prof_med", "After_premid:prof_high"))





