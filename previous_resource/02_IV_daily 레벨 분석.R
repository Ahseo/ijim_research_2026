head(daily_agg)

#[1] "rider_id"               "Treat"                  "management_partner_id"  "date"                   "After"                 
#[6] "total_shift"            "share_aggshift"         "mean_orders_aggshift"   "mean_duration_aggshift" "working_duration"      
#[11] "idle_duration"          "total_labor"            "total_orders"           "total_aiorders"         "ai_assist_day"         
#[16] "share_workingd"         "share_idled"            "orders_per_workingd"    "profit"                 "prof"                  
#[21] "prof_low"               "prof_med"               "prof_high" 

##### IV = AI riders' share in station
test <- daily_agg %>% group_by(management_partner_id, date) %>% summarise(num_riders = length(unique(rider_id)),
                                                                          ai_riders = length(unique(rider_id[total_aiorders>=1])),
                                                                          ai_rider_share_station = ai_riders/num_riders)
daily_agg <- left_join(daily_agg, test[,c(1,2,5)])


##### IV = avg AI riders' share in stations
test <- daily_agg %>% group_by(management_partner_id, date) %>% summarise(num_riders = length(unique(rider_id)),
                                                                          ai_riders = length(unique(rider_id[total_aiorders>=1])),
                                                                          ai_rider_share_station = ai_riders/num_riders)
test1 <- test %>% group_by(date) %>% summarise(sum_ai_rider_share_station = sum(ai_rider_share_station),
                                               num_station = n(),
                                               ai_riders_share_include = sum_ai_rider_share_station/num_station)
daily_agg <- left_join(daily_agg, test1[,c(1,4)])



##### IV = AI order share of other riders in the station
daily_agg$ai_share <- daily_agg$total_aiorders/daily_agg$total_orders

test <- daily_agg %>% group_by(management_partner_id, date) %>% 
  summarise(sum_ai_share = sum(ai_share),
            num_riders = n()) # 일별 지점별 모든 라이더수, 라이더들의 ai 오더 비율 합

daily_agg <- left_join(daily_agg, test)
daily_agg <- daily_agg %>% mutate(sum_ai_share_except = sum_ai_share - ai_share,
                                  num_riders_except = num_riders - 1)

daily_agg <- daily_agg %>% mutate(ai_share_others = sum_ai_share_except/num_riders_except)
summary(daily_agg$ai_share_others) #NA=55


##### IV: difference in average of hourly ds across days
test <- data_order %>% group_by(management_partner_id, date, assign_hour) %>% summarise(num_orders = n(),
                                                                                        num_riders = length(unique(rider_id)),
                                                                                        ds_share = num_orders/num_riders)
test <- test %>% group_by(management_partner_id, date) %>% summarise(daily_mean_ds = mean(ds_share))
daily_agg <- left_join(daily_agg, test)

diff_pre <- function(var){return(c(NA, diff(var)))}

daily_agg$diff_preday_mean_ds <- diff_pre(daily_agg$daily_mean_ds)


###### IV: difference in daily ds across days
test <- daily_agg %>% group_by(management_partner_id, date) %>% summarise(num_orders = sum(total_orders),
                                                                          num_riders = length(unique(rider_id)),
                                                                          ds_share = num_orders/num_riders)
test <- test[order(test$date),]
test <- test[order(test$management_partner_id),]

diff_pre <- function(var){return(c(NA, diff(var)))}

test <- test %>% group_by(management_partner_id) %>% mutate(diff_preday_ds = diff_pre(ds_share),
                                                            diff_preday_order = diff_pre(num_orders))

daily_agg <- left_join(daily_agg, test[,c(1:2,6:7)])




##### List of IVs ############################################################################
daily_agg$station_date <- paste(daily_agg$management_partner_id, daily_agg$date, sep="_")

##### probit 1st stage estimation
### IV = ai_rider_share_station
model <- feglm(ai_assist_day ~ ai_rider_share_station | rider_id + management_partner_id + date | rider_id,
               data=daily_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)
# probit estimation에 사용된 데이터 저장: daily_agg_iv
test <- model$data
test$ai_assist_fit <- predict(model, type="response")
test <- unique(test)

daily_agg$rider_id <- as.factor(daily_agg$rider_id)
daily_agg$management_partner_id <- as.factor(daily_agg$management_partner_id)
daily_agg$date <- as.factor(daily_agg$date)

daily_agg_iv <- left_join(daily_agg, test)



### IV = ai_share_others; + ***
model <- feglm(ai_assist_day ~ ai_share_others | rider_id + management_partner_id + date | rider_id,
               data=daily_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)
# probit estimation에 사용된 데이터 저장: daily_agg_iv
test <- model$data
test$ai_assist_fit2 <- predict(model, type="response")
test <- unique(test)
daily_agg_iv <- left_join(daily_agg_iv, test)


### IV = diff_preday_mean_ds; + *
model <- feglm(ai_assist_day ~ diff_preday_mean_ds | rider_id + management_partner_id + date | rider_id,
               data=daily_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)


### IV = diff_preday_ds; rider_id, station_date FE; + ***
model <- feglm(ai_assist_day ~ diff_preday_ds | rider_id + management_partner_id + date | rider_id,
               data=daily_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)
# probit estimation에 사용된 데이터 저장: daily_agg_iv
test <- model$data
test$ai_assist_fit2 <- predict(model, type="response")
test <- unique(test)
daily_agg$rider_id <- as.factor(daily_agg$rider_id)
daily_agg_iv <- daily_agg %>% filter(rider_id %in% test$rider_id, station_date %in% test$station_date)
daily_agg_iv <- left_join(daily_agg_iv, test)






##### 2-step estimation by wooldridge: Probit - 1st stage , OLS - 2nd stage ############################################################################
colnames(daily_agg_iv)
# [1] "rider_id"               "Treat"                  "management_partner_id"  "date"                   "After"                 
# [6] "total_shift"            "share_aggshift"         "mean_orders_aggshift"   "mean_duration_aggshift" "working_duration"      
# [11] "idle_duration"          "total_labor"            "total_orders"           "total_aiorders"         "ai_assist_day"         
# [16] "share_workingd"         "share_idled"            "orders_per_workingd"    "profit"                 "prof"                  
# [21] "prof_low"               "prof_med"               "prof_high"              "ai_share"               "sum_ai_share"          
# [26] "num_riders"             "sum_ai_share_except"    "num_riders_except"      "ai_share_others"        "station_date"          
# [31] "diff_preday_ds"         "diff_preday_order"      "ai_assist_fit"  

daily_agg_iv$ai_assist_med <- daily_agg_iv$ai_assist_day * daily_agg_iv$prof_med
daily_agg_iv$ai_assist_high <- daily_agg_iv$ai_assist_day * daily_agg_iv$prof_high

daily_agg_iv$ai_assist_fit_med <- daily_agg_iv$ai_assist_fit * daily_agg_iv$prof_med
daily_agg_iv$ai_assist_fit_high <- daily_agg_iv$ai_assist_fit * daily_agg_iv$prof_high
daily_agg_iv$ai_assist_fit2_med <- daily_agg_iv$ai_assist_fit2 * daily_agg_iv$prof_med
daily_agg_iv$ai_assist_fit2_high <- daily_agg_iv$ai_assist_fit2 * daily_agg_iv$prof_high


### Model Estimation
model <- felm(log(total_shift) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
condfstat(model,quantiles = c(0.05, 0.95))
model <- felm(log(total_shift) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
condfstat(model,quantiles = c(0.05, 0.95))

model <- felm(log(total_shift) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(total_shift) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)



model <- felm(share_aggshift ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(share_aggshift ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)

model <- felm(share_aggshift ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(share_aggshift ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)


model <- felm(log(mean_orders_aggshift) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(mean_orders_aggshift) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(mean_orders_aggshift) ~  1 | rider_id + management_partner_id + date  | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(mean_orders_aggshift) ~  1 | rider_id + management_partner_id + date  | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)


model <- felm(log(mean_duration_aggshift) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(mean_duration_aggshift) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(mean_duration_aggshift) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(mean_duration_aggshift) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)


model <- felm(log(working_duration) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(working_duration) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(working_duration) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(working_duration) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)


model <- felm(log(idle_duration+1) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(idle_duration+1) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(idle_duration+1) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(idle_duration+1) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)


model <- felm(log(total_labor) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(total_labor) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(total_labor) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(total_labor) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)



model <- felm(log(total_orders) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(total_orders) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(total_orders) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(total_orders) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)

model <- felm(log(orders_per_workingd) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(orders_per_workingd) ~ 1 | rider_id + management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(orders_per_workingd) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(orders_per_workingd) ~  1 | rider_id + management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)

model <- felm(log(profit) ~ 1 | rider_id +  management_partner_id + date | (ai_assist_day ~ ai_assist_fit) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(profit) ~ 1 | rider_id +  management_partner_id + date | (ai_assist_day ~ ai_assist_fit2) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(profit) ~  1 | rider_id +  management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = daily_agg_iv)
summary(model)
model <- felm(log(profit) ~  1 | rider_id +  management_partner_id + date | (ai_assist_day | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = daily_agg_iv)
summary(model)

