####################### 추천배차 사용이력 기반 분석: Simple OLS w/o IV #############################################
#########################################################################################################
model <- felm(ln(avg_assign+1) ~ ai_assist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(avg_assign+1) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)

model <- felm(ln(avg_pickup+1) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(avg_pickup+1) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)


model <- felm(ln(avg_deliver) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(avg_deliver) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)


model <- felm(ln(avg_waiting) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(avg_waiting) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)


model <- felm(ln(avg_dist+1) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(avg_dist+1) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)


model <- felm(ln(num_orders) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(num_orders) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)

test <- data_agg_iv %>% filter(num_orders>=2)
model <- felm(ln(num_orders) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=test)
summary(model)
model <- felm(ln(num_orders) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=test)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)

model <- felm(ln(total_duration) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(total_duration) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)

test <- data_agg_iv %>% filter(num_orders>=2)
model <- felm(ln(total_duration) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=test)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)

#test<-data_agg_matched %>% group_by(rider_id,date) %>% mutate(lag_numorders = lag(num_orders))
test<-na.omit(data_agg)
model <- felm(ln(idle_btw_shifts) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)


data_agg$prod_shift <- data_agg$num_orders/(data_agg$total_duration/3600)
model <- felm(ln(prod_shift) ~ ai_assist | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(ln(prod_shift) ~ ai_assist + ai_assist:prof_med + ai_assist:prof_high | rider_id + station_date + hourDOW| 0 | rider_id, data=data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist + ai_assist:prof_high = 0")); summary(model_check)



####################### 추천배차 사용이력 기반 분석: w IV #############################################
#########################################################################################################

##### TEST Plot #####
##### TEST #####
### 지점별 시간대별 전체 활동 라이더수, 추천배차 사용 라이더수, 추천배차 사용 라이더 비율: station_hour_riders

#station_hour_riders$ai_riders_share_oth <- ifelse(is.na(station_hour_riders$ai_riders_share_oth)==1,0,station_hour_riders$ai_riders_share_oth)

### 시간대별 ai_assist
test <- data_agg %>% group_by(date, management_partner_id, start_hour) %>% summarise(total_shift = n(),
                                                                               ai_shift = sum(ai_assist),
                                                                               mean_aiassist = mean(ai_assist))
test1 <- test %>% group_by(start_hour) %>% summarise(mean_totalshift = mean(total_shift),
                                                     mean_aishift = mean(ai_shift),
                                                     mean_aiassist = mean(mean_aiassist))
plot(mean_totalshift~start_hour, type="l", data=test1)
lines(mean_aishift~start_hour, type="l", data=test1, col="blue")
plot(mean_aishift~start_hour, type="l", data=test1, col="blue")
plot(mean_aiassist~start_hour, type="l", data=test1, col="red")

##### IV #1: hourly AI usage ratio of orders #####
### date-hour에 주문 배차 이력이 있는 라이더수,  AI 주문 배차 이력이 있는 라이더수, AI 주문 배차 라이더 비율
test <- data_order %>% group_by(date, hour) %>% summarise(total_rider = length(unique(rider_id)),
                                                          ai_rider = length(unique(rider_id[is_rec_completed==1])),
                                                          ai_rider_share = ai_rider/total_rider)
test1 <- test %>% group_by(hour) %>% summarise(mean_totalrider = mean(total_rider),
                                               mean_airider = mean(ai_rider),
                                               mean_aishare=mean(ai_rider_share_station))
test2 <- test %>% group_by(management_partner_id) %>% summarise(mean_totalrider = mean(total_rider),
                                                                mean_airider = mean(ai_rider),
                                                                mean_aishare=mean(ai_rider_share_station))

plot(mean_totalrider~hour, type="l", data=test1)
lines(mean_airider~hour, data=test1, col="blue")
plot(mean_airider~hour, type="l",data=test1, col="blue")
plot(mean_aishare~hour, type="l",data=test1, col="red")

colnames(test)[2] <- "start_hour"

### data_agg에 merge
head(data_agg)
  
data_agg<-left_join(data_agg, test[,c(1,2,5)])

ggplot(data=data_agg, aes(x=ai_rider_share, y=ai_assist)) +
  geom_point() # 눈으로는 확인이 좀 어려움


##### IV #2: hourly AI usage ratio of riders by stations #####
test <- data_order %>% group_by(date, management_partner_id, hour) %>% summarise(total_rider = length(unique(rider_id)),
                                                                                 ai_rider = length(unique(rider_id[is_rec_completed==1])),
                                                                                 ai_rider_share_station = ai_rider/total_rider)
test1 <- test %>% group_by(hour) %>% summarise(mean_totalrider = mean(total_rider),
                                               mean_airider = mean(ai_rider),
                                               mean_aishare=mean(ai_rider_share_station))
test2 <- test %>% group_by(management_partner_id) %>% summarise(mean_totalrider = mean(total_rider),
                                                               mean_airider = mean(ai_rider),
                                                               mean_aishare=mean(ai_rider_share_station))

plot(mean_totalrider~hour, type="l", data=test1)
lines(mean_airider~hour, data=test1, col="blue")
plot(mean_airider~hour, type="l",data=test1, col="blue")
plot(mean_aishare~hour, type="l",data=test1, col="red")

colnames(test)[3] <- "start_hour"

data_agg<-left_join(data_agg, test[,c(1,2,3,6)])


##### IV #3: hourly AI orders ratio by stations #####
test <- data_order %>% group_by(date, management_partner_id, hour) %>% summarise(total_orders = n(),
                                                                                 ai_orders = sum(is_rec_completed),
                                                                                 aiorders_ratio = sum(is_rec_completed)/n())
test1 <- test %>% group_by(hour) %>% summarise(mean_totalorders = mean(total_orders),
                                               mean_aiorders = mean(ai_orders),
                                               mean_airatio = mean(aiorders_ratio))

plot(mean_totalorders~hour, type="l", data=test1)
lines(mean_aiorders~hour, data=test1, col="blue")
plot(mean_aiorders~hour, type="l",data=test1, col="blue")
plot(mean_airatio~hour, type="l",data=test1, col="red")

colnames(test)[3] <- "start_hour"

data_agg <- left_join(data_agg, test)  


##### IV #4,5: avg hourly AI usage share by whole/otehr stations
data_order$assign_hour <- hour(data_order$assignedat)

station_hour_riders <- data_order %>% group_by(management_partner_id, date, assign_hour) %>%
  summarise(total_riders = length(unique(rider_id)),
            ai_riders = length(unique(rider_id[is_rec_completed==1])),
            ai_riders_share = ai_riders/total_riders)
station_hour_riders$date_assignhour <- paste(station_hour_riders$date, station_hour_riders$assign_hour, sep="_")

test <- station_hour_riders %>% group_by(date_assignhour) %>% summarise(sum_ai_riders_share = sum(ai_riders_share),
                                                                        num_stations = n(),
                                                                        num_ai_stations = length(unique(management_partner_id[ai_riders_share>0])))
station_hour_riders <- left_join(station_hour_riders, test)

station_hour_riders <- station_hour_riders %>% mutate(sum_ai_riders_share_except = sum_ai_riders_share - ai_riders_share,
                                                      num_stations_except = num_stations - 1,
                                                      num_ai_stations_except = num_ai_stations - 1*ifelse(ai_riders>=1,1,0))

station_hour_riders <- station_hour_riders %>% mutate(ai_riders_share_include = sum_ai_riders_share/num_stations,
                                                      ai_riders_share_oth = sum_ai_riders_share_except/num_stations_except,
                                                      ai_riders_share_oth2 = sum_ai_riders_share_except/num_ai_stations_except)

colnames(station_hour_riders)[3] <- "start_hour"
data_agg<-left_join(data_agg, station_hour_riders[,c(1:3,14:16)])

##### IV #6: avg hourly AI usage share by other riders in same station
rider_station_hour_share <- data_order %>% group_by(rider_id, management_partner_id, date, assign_hour) %>%
  summarise(total_orders = n(),
            ai_orders = sum(is_rec_completed),
            ai_share = ai_orders/total_orders)

test <- rider_station_hour_share %>% group_by(management_partner_id, date, assign_hour) %>% 
  summarise(sum_ai_share = sum(ai_share),
            num_riders = n())
rider_station_hour_share <- left_join(rider_station_hour_share, test)
rider_station_hour_share <- rider_station_hour_share %>% mutate(sum_ai_share_except = sum_ai_share - ai_share,
                                                                num_riders_except = num_riders - 1)

rider_station_hour_share <- rider_station_hour_share %>% mutate(ai_share_others = sum_ai_share_except/num_riders_except)
colnames(rider_station_hour_share)[4] <- "start_hour"

data_agg <- left_join(data_agg, rider_station_hour_share[,c(1:4,12)])
summary(data_agg$ai_share_others) #NA=5081


##### IV #7: avg hourly AI usage share by other riders in difference stations
rider_station_hour_share2 <- data_order %>% group_by(rider_id, management_partner_id, date, assign_hour) %>%
  summarise(total_orders = n(),
            ai_orders = sum(is_rec_completed),
            ai_share = ai_orders/total_orders)

test <- rider_station_hour_share2 %>% group_by(management_partner_id, date, assign_hour) %>% summarize(station_date_hour_totalshare = sum(ai_share),
                                                                                                       station_date_hour_totalriders = n())
test1 <- rider_station_hour_share2 %>% group_by(date, assign_hour) %>% summarise(date_hour_totalshare = sum(ai_share),
                                                                                 date_hour_totalriders = n())

rider_station_hour_share2 <- left_join(rider_station_hour_share2, test) %>% left_join(test1)
remove(test,test1)

rider_station_hour_share2 <- rider_station_hour_share2 %>% mutate(date_hour_share_exc = date_hour_totalshare - station_date_hour_totalshare,
                                                                  date_hour_riders_exc = date_hour_totalriders - station_date_hour_totalriders,
                                                                  avg_date_hour_share_exc = date_hour_share_exc/date_hour_riders_exc)

colnames(rider_station_hour_share2)[4]<-"start_hour"
data_agg <- left_join(data_agg, rider_station_hour_share2[,c(1:4, 14)])


##### IV #8: hourly ds difference across days
test <- data_order %>% group_by(management_partner_id, date, assign_hour) %>% summarise(num_orders = n(),
                                                                                        num_riders = length(unique(rider_id)),
                                                                                        ds_share = num_orders/num_riders)
test <- test[order(test$assign_hour),]
diff_pre <- function(var){return(c(NA, diff(var)))}
test <- test %>% group_by(management_partner_id, assign_hour) %>% mutate(diff_preday_ds = diff_pre(ds_share),
                                                                         diff_preday_order = diff_pre(num_orders))

colnames(test)[3] <- "start_hour"

data_agg <- left_join(data_agg, test[,c(1:3,7:8)])




##### IV #9: hourly ds difference across hours
test <- data_order %>% group_by(management_partner_id, date, assign_hour) %>% summarise(num_orders = n(),
                                                                                        num_riders = length(unique(rider_id)),
                                                                                        ds_share = num_orders/num_riders)
test <- test[order(test$assign_hour),]
test <- test[order(test$date),]
test <- test[order(test$management_partner_id),]

test <- test %>% group_by(management_partner_id, date) %>% mutate(diff_prehour_order = diff_pre(num_orders),
                                                                  diff_prehour_ds = diff_pre(ds_share))

colnames(test)[3] <- "start_hour"

data_agg <- left_join(data_agg, test[,c(1:3,7:8)])



##### 2-step estimation by wooldridge: Probit - 1st stage , OLS - 2nd stage ############################################################################
library(alpaca) #https://github.com/amrei-stammann/alpaca/tree/master/vignettes
library(car)
library(sandwich)
library(boot)


##### probit 1st stage estimation
### IV = ai_rider_share
model <- feglm(ai_assist ~ ai_rider_share | rider_id + station_date + hourDOW | rider_id,
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)

linearHypothesis(model, 
                 "ai_rider_share = 0", type = "HC1")

# probit estimation에 사용된 데이터 저장: ai_assist_fit
test <- model$data
test$ai_assist_fit <- predict(model, type="response")
test <- unique(test)

data_agg_iv <- data_agg %>% filter(rider_id%in%test$rider_id, station_date%in%test$station_date, hourDOW%in%test$hourDOW)
data_agg_iv$rider_id <- as.factor(data_agg_iv$rider_id)

data_agg_iv <- left_join(data_agg_iv, test)


### IV = ai_rider_share_station
model <- feglm(ai_assist ~ ai_rider_share_station | rider_id + station_date + hourDOW | rider_id,
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)

linearHypothesis(model, 
                 "ai_rider_share_station = 0", type = "HC1")

# probit estimation에 사용된 데이터 저장: ai_assist_fit2
test <- model$data
test$ai_assist_fit2 <- predict(model, type="response")
test <- unique(test)

data_agg_iv <- left_join(data_agg_iv, test)


### IV = aiorders_ratio
model <- feglm(ai_assist ~ aiorders_ratio | rider_id + station_date + hourDOW | rider_id,
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)

linearHypothesis(model, 
                 "ds_share_station = 0", type = "HC1")

# probit estimation에 사용된 데이터 저장: data_agg_iv
test <- model$data
test$ai_assist_fit3 <- predict(model, type="response")
test <- unique(test)

data_agg_iv <- left_join(data_agg_iv, test)




### IV = ai_riders_share_include
model <- feglm(ai_assist ~ ai_riders_share_include | rider_id + station_date + hourDOW | rider_id,
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)

# probit estimation에 사용된 데이터 저장: data_agg_iv
test <- model$data
test$ai_assist_fit4 <- predict(model, type="response")
test <- unique(test)

data_agg_iv <- left_join(data_agg_iv, test)



### IV = ai_riders_share_oth
model <- feglm(ai_assist ~ ai_riders_share_oth | rider_id + station_date + hourDOW | rider_id,
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)

# probit estimation에 사용된 데이터 저장: data_agg_iv
test <- model$data
test$ai_assist_fit5 <- predict(model, type="response")
test <- unique(test)

data_agg_iv <- left_join(data_agg_iv, test)



### IV = ai_share_others
model <- feglm(ai_assist ~ ai_share_others | rider_id + station_date + hourDOW | rider_id,
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)

# probit estimation에 사용된 데이터 저장: data_agg_iv
test <- model$data
test$ai_assist_fit6 <- predict(model, type="response")
test <- unique(test)

data_agg_iv <- left_join(data_agg_iv, test)


### IV = avg_date_hour_share_exc
model <- feglm(ai_assist ~ avg_date_hour_share_exc | rider_id + station_date + hourDOW | rider_id,
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)


### IV = diff_~~ (hourly ds difference acorss days)
model <- feglm(ai_assist ~ diff_preday_order | rider_id + station_date + hourDOW | rider_id, # (-)+
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)


model <- feglm(ai_assist ~ diff_preday_ds | rider_id + station_date + hourDOW | rider_id, # (-)***
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)
# probit estimation에 사용된 데이터 저장: data_agg_iv
test <- model$data
test$ai_assist_fit7 <- predict(model, type="response")
test <- unique(test)
data_agg_iv <- left_join(data_agg_iv, test)


model <- feglm(ai_assist ~ diff_prehour_order | rider_id + station_date + hourDOW | rider_id, # (-)**
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)


model <- feglm(ai_assist ~ diff_prehour_ds | rider_id + station_date + hourDOW | rider_id, # (+) **
               data=data_agg, binomial("probit"))
summary(model, type="clustered", cluster = ~ rider_id)







##### 2nd-stage estimation #####
### Interaction term in one column
data_agg_iv$ai_assist_med <- data_agg_iv$ai_assist*data_agg_iv$prof_med
data_agg_iv$ai_assist_high <- data_agg_iv$ai_assist*data_agg_iv$prof_high

### ai_assist_fit * proficiency
data_agg_iv$ai_assist_fit_med <- data_agg_iv$ai_assist_fit * data_agg_iv$prof_med
data_agg_iv$ai_assist_fit_high <- data_agg_iv$ai_assist_fit * data_agg_iv$prof_high
data_agg_iv$ai_assist_fit2_med <- data_agg_iv$ai_assist_fit2 * data_agg_iv$prof_med
data_agg_iv$ai_assist_fit2_high <- data_agg_iv$ai_assist_fit2 * data_agg_iv$prof_high
data_agg_iv$ai_assist_fit3_med <- data_agg_iv$ai_assist_fit3 * data_agg_iv$prof_med
data_agg_iv$ai_assist_fit3_high <- data_agg_iv$ai_assist_fit3 * data_agg_iv$prof_high
data_agg_iv$ai_assist_fit4_med <- data_agg_iv$ai_assist_fit4 * data_agg_iv$prof_med
data_agg_iv$ai_assist_fit4_high <- data_agg_iv$ai_assist_fit4 * data_agg_iv$prof_high
data_agg_iv$ai_assist_fit5_med <- data_agg_iv$ai_assist_fit5 * data_agg_iv$prof_med
data_agg_iv$ai_assist_fit5_high <- data_agg_iv$ai_assist_fit5 * data_agg_iv$prof_high
data_agg_iv$ai_assist_fit6_med <- data_agg_iv$ai_assist_fit6 * data_agg_iv$prof_med
data_agg_iv$ai_assist_fit6_high <- data_agg_iv$ai_assist_fit6 * data_agg_iv$prof_high
data_agg_iv$ai_assist_fit7_med <- data_agg_iv$ai_assist_fit7 * data_agg_iv$prof_med
data_agg_iv$ai_assist_fit7_high <- data_agg_iv$ai_assist_fit7 * data_agg_iv$prof_high


#1
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
summary(model$stage1)
condfstat(model,quantiles = c(0.05, 0.95)) #F-stat=217.672

model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
summary(model$stage1)
condfstat(model,quantiles = c(0.05, 0.95))

model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
summary(model$stage1)
condfstat(model,quantiles = c(0.05, 0.95)) #F-stat=4297.396

model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)
summary(model$stage1)
condfstat(model,quantiles = c(0.05, 0.95)) #F-stat=255.693

model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = data_agg_iv)
summary(model)
summary(model$stage1)
condfstat(model,quantiles = c(0.05, 0.95)) #F-stat=222.839

model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = data_agg_iv)
summary(model)
summary(model$stage1)
condfstat(model,quantiles = c(0.05, 0.95)) #F-stat=631.308

model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = data_agg_iv)
summary(model)
summary(model$stage1)
condfstat(model,quantiles = c(0.05, 0.95)) #F-stat=631.308




model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
condfstat(model,quantiles = c(0.05, 0.95))

model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)


# Hausman specification test
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
head(model$stage1$residuals) 

data_agg_iv$first_res <- model$stage1$residuals # Take first-stage residuals

model <- felm(log(avg_assign+1) ~ ai_assist + first_res | rider_id + station_date + hourDOW | 0 | rider_id, data=data_agg_iv)
summary(model)
model <- felm(res_int ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_agg_iv)
summary(model)

linearHypothesis(model, "ai_assist_fit = 0", test = "Chisq")

#F-stat
condfstat(model)



#1
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_high = 0")); summary(model_check)

#1
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_high = 0")); summary(model_check)

#1
model <- felm(log(avg_waiting) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_high = 0")); summary(model_check)

#1
model <- felm(log(avg_dist+1) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_high = 0")); summary(model_check)

#1
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_high = 0")); summary(model_check)

test<-data_agg_iv %>% filter(num_orders>=2)
test<-data_agg_iv_peak %>% filter(num_orders>=2)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = test)
summary(model)

model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = test)
summary(model)

#1
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_high = 0")); summary(model_check)

test<-data_agg_iv %>% filter(num_orders>=2)
test<-data_agg_iv_peak %>% filter(num_orders>=2)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = test)
summary(model)

model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = test)
summary(model)


#1
model <- felm(log(idle_btw_shifts) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit5) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit6) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~ 1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit7) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit5 + ai_assist_fit5_med + ai_assist_fit5_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit6 + ai_assist_fit6_med + ai_assist_fit6_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit7 + ai_assist_fit7_med + ai_assist_fit7_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_high = 0")); summary(model_check)

data_agg_iv$prod_shift <- data_agg_iv$num_orders/(data_agg_iv$total_duration/3600)
model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit2) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit3) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_assist_fit4) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit + ai_assist_fit_med + ai_assist_fit_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit2 + ai_assist_fit2_med + ai_assist_fit2_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit3 + ai_assist_fit3_med + ai_assist_fit3_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_assist_fit4 + ai_assist_fit4_med + ai_assist_fit4_high) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(prod_shift) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_rider_share + ai_rider_share:prof_med + ai_rider_share:prof_high) | rider_id, data = data_agg_iv)
summary(model)
model_check <- glht(model, linfct = c("ai_assist(fit) + ai_assist_med(fit) = 0")); summary(model_check)
model_check <- glht(model, linfct = c("ai_assist_fit + ai_assist_fit:prof_high = 0")); summary(model_check)




##### LPM 2SLS ############################################################################
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = data_agg_iv)
summary(model)
summary(model$stage1)
condfstat(model,quantiles = c(0.05, 0.95))
model <- felm(log(avg_assign+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_pickup+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_deliver) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_waiting) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(avg_dist+1) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = data_agg_iv)
summary(model)

model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = data_agg_iv)
summary(model)

test<-data_agg_iv %>% filter(num_orders>=2)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = test)
summary(model)
model <- felm(log(num_orders) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = test)
summary(model)

model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = data_agg_iv)
summary(model)

test<-data_agg_iv %>% filter(num_orders>=2)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = test)
summary(model)
model <- felm(log(total_duration) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = test)
summary(model)

model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist ~ ai_share_others) | rider_id, data = data_agg_iv)
summary(model)
model <- felm(log(idle_btw_shifts) ~  1 | rider_id + station_date + hourDOW | (ai_assist | ai_assist_med | ai_assist_high ~ ai_share_others + ai_share_others:prof_med + ai_share_others:prof_high) | rider_id, data = data_agg_iv)
summary(model)


##### Peak , offpeak 개별 분석 #####
test <- data_order %>% group_by(date, hour) %>% summarise(num_orders = n()) %>% group_by(hour) %>% summarise(num_orders = mean(num_orders))
#peak: 11~22, offpeak:23~10