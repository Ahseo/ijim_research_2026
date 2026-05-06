library(sjPlot)
library(sjmisc)
library(sjlabelled)

#####################################################################################################################
########################## DID + matching ("01_Data check and cleansing.R"에서 이어짐)###############################
#####################################################################################################################

# 1. Data Preparation (order-level, shift-level, day-level)
#####################################################################################################################
##### Order-level data: "data_order" #####
#####################################################################################################################
### data_2m_preexist를 data_order로 사용
data_order <- data_2m_preexist # from "01_Data check and cleansing.R"
data_order <- data.frame(data_order)
remove(data_2m_preexist)

### data_order 데이터 체크
head(data_order)
summary(data_order)
nrow(data_order); length(unique(data_order$rider_id)); length(unique(data_order$management_partner_id)); length(unique(data_order$date))  
# 데이터기간 2020-09-26~2020-11-30: 66일, 815,191건, 28개 지점, 584명 라이더


### 라이더별 지점 근무 현황
test <- data_order %>% group_by(rider_id) %>% summarise(num_station = length(unique(management_partner_id)))
# 584명중 13명만 두개지점 근무, 나머지는 한지점 근무

### Treat/Control, After 변수
head(data_order)

treat_riders <- data_order %>% group_by(rider_id) %>%
  summarise(total_orders = n(),
            ai_completed_orders = sum(is_rec_completed),
            adopt_date = min(date[is_rec_completed==1]),
            share_aiorder = ai_completed_orders/total_orders) %>%
  filter(ai_completed_orders>=1) # 처치군: 400명, 통제군: 184명
str(treat_riders)
#hist(treat_riders$share_aiorder)

data_order <- data_order %>% mutate(Treat=ifelse(rider_id %in% treat_riders$rider_id,1,0),
                                    After=ifelse(date>="2020-10-26",1,0))


### rider_date, riderDOW
data_order$rider_date <- paste(data_order$rider_id, data_order$date, sep="_")
data_order$riderDOW <- paste(data_order$rider_id, data_order$DOW, sep="_")

### week dummies
unique(data_order$date)
str(data_order$date)

data_order$date <- as.character(data_order$date)
data_order$wb5 <- ifelse(data_order$date %in% c("2020-09-26" , "2020-09-27"),1,0)
data_order$wb4 <- ifelse(data_order$date %in% c("2020-09-28", "2020-09-29", "2020-09-30", "2020-10-01", "2020-10-02", "2020-10-03", "2020-10-04"), 1, 0)
data_order$wb3 <- ifelse(data_order$date %in% c("2020-10-05", "2020-10-06", "2020-10-07", "2020-10-08", "2020-10-09", "2020-10-10", "2020-10-11"), 1, 0)
data_order$wb2 <- ifelse(data_order$date %in% c("2020-10-12", "2020-10-13", "2020-10-14", "2020-10-15", "2020-10-16", "2020-10-17", "2020-10-18"), 1, 0)
data_order$wb1 <- ifelse(data_order$date %in% c("2020-10-19", "2020-10-20", "2020-10-21", "2020-10-22", "2020-10-23", "2020-10-24", "2020-10-25"), 1, 0)
data_order$w1 <- ifelse(data_order$date %in% c("2020-10-26", "2020-10-27", "2020-10-28", "2020-10-29", "2020-10-30", "2020-10-31", "2020-11-01"), 1, 0)
data_order$w2 <- ifelse(data_order$date %in% c("2020-11-02", "2020-11-03", "2020-11-04", "2020-11-05", "2020-11-06", "2020-11-07", "2020-11-08"), 1, 0)
data_order$w3 <- ifelse(data_order$date %in% c("2020-11-09", "2020-11-10", "2020-11-11", "2020-11-12", "2020-11-13", "2020-11-14", "2020-11-15"), 1, 0)
data_order$w4 <- ifelse(data_order$date %in% c("2020-11-16", "2020-11-17", "2020-11-18", "2020-11-19", "2020-11-20", "2020-11-21", "2020-11-22"), 1, 0)
data_order$w5 <- ifelse(data_order$date %in% c("2020-11-23", "2020-11-24", "2020-11-25", "2020-11-26", "2020-11-27", "2020-11-28", "2020-11-29","2020-11-30"), 1, 0)
data_order$date <- as.Date(data_order$date)

### duration -> min단위로 변환
data_order$assign_sec <- data_order$assign_sec/60
data_order$pickup_sec <- data_order$pickup_sec/60
data_order$delivery_sec <- data_order$delivery_sec/60
data_order$waiting_sec <- data_order$waiting_sec/60

colnames(data_order)[36:39]<-c("assign_min", "pickup_min", "delivery_min", "waiting_min")


### peak/offpeak
data_order$peak <- ifelse(data_order$hour %in% c(11:13, 17:20),1,0)
data_order$midpeak <- ifelse(data_order$hour %in% c(14:16, 21:23),1,0)
data_order$offpeak <- ifelse(data_order$hour %in% c(0:10),1,0)

#####################################################################################################################
##### shift-level data: data_shift#####
#####################################################################################################################
head(data_order)

### 오더/추천배차 오더 관련 변수
data_shift1 <- data_order %>%
  group_by(rider_id, management_partner_id, date, After, shift, rider_date) %>%
  summarise(num_orders = n(), # 한 shift내 수행한 오더개수
            num_aiorders = sum(is_rec_completed==1), # 한 shift내 수행한 AI추천배차 오더개수
            share_aiorders = num_aiorders/num_orders, # 한 shift내 수행한 전체 오더 중 AI추천배차 오더 비율
            avg_assign = mean(assign_min), avg_pickup = mean(pickup_min), avg_deliver = mean(delivery_min), avg_waiting = mean(waiting_min),
            sd_waiting = sd(waiting_min), var_waiting = var(waiting_min),
            share_failed = sum(waiting_min>30)/num_orders,
            avg_dist = mean(distorigintodest),
            shift_profit = sum(rider_total_fee),
            avg_order_level = mean(order_level)) 

### 시간 관련 변수 (shift 시작/종료 시간, 전체 길이)
data_shift2 <- data_order %>%
  group_by(rider_id, Treat, management_partner_id, date, After, shift, rider_date) %>%
  summarise(start = assignedat[which(row_number()==1)], # 한 shift내 첫 주문 배차시각
            finish = max(deliveredat), # 한 shift내 마지막 주문 배달완료시각
            total_duration = as.numeric(as.difftime(finish - start), units="mins")) # 한 shift 전체 길이
summary(data_shift2$total_duration)
### data merge
data_shift <- left_join(data_shift1,data_shift2)
remove(data_shift1,data_shift2)


### idle time
idletimes <- function(c1,c2){return(c(NA, as.numeric(as.difftime(tail(c1,-1)-head(c2,-1)), units="mins")))} # 한 shift를 끝내고 다음 shift를 시작하기까지 걸린시간
data_shift <- data_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, rider_date) %>%
  mutate(idle_btw_shifts = idletimes(start,finish))
summary(data_shift$idle_btw_shifts)
# Min.  1st Qu.   Median     Mean  3rd Qu.     Max.     NA's 
#    0.017    1.750    5.083   27.903   14.450 1385.417    26280  

#hist(data_shift$idle_btw_shifts, breaks=10000)
#hist(data_shift$idle_btw_shifts, breaks=10000, xlim=c(0,3600))
sum(data_shift$idle_btw_shifts>30, na.rm=T) # 20분이상:17.7%, 30분이상:약 12.9%, 1시간이상: 약 7.1%, 2시간이상: 약 3.5%

# idle time이 1시간 이상인 경우 NA 처리 (분석에 고려하지않음)
data_shift$idle_btw_shifts <- ifelse(data_shift$idle_btw_shifts>60,NA,data_shift$idle_btw_shifts) #NA=46452
summary(data_shift$idle_btw_shifts) 

# avg. duration per order
data_shift$avg_duration_orders <- data_shift$total_duration/data_shift$num_orders

# AI assisted dummies
data_shift$ai_assist <- ifelse(data_shift$num_aiorders==0,0,1)

# additional columns: station_date, start_hour, hourDOW, riderDOW
data_shift$station_date <- paste(data_shift$management_partner_id, data_shift$date, sep="_")
data_shift$start_hour <- hour(data_shift$start)


# hourDOW
data_shift <- data_shift %>% mutate(wday = wday(date),
                                    hourDOW = paste(start_hour, wday, sep="_"))
colnames(data_shift)

# riderDOW
data_shift <- data_shift %>% mutate(riderDOW = paste(rider_id, wday, sep="_"))
length(unique(data_shift$riderDOW))

# number of stacked orders in previous shift
data_shift <- data_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, rider_date) %>% 
  mutate(pre_shift_orders = lag(num_orders))

### week dummies
unique(data_shift$date)
str(data_shift$date)

data_shift$date <- as.character(data_shift$date)
data_shift$wb5 <- ifelse(data_shift$date %in% c("2020-09-26", "2020-09-27"),1,0)
data_shift$wb4 <- ifelse(data_shift$date %in% c("2020-09-28", "2020-09-29", "2020-09-30", "2020-10-01", "2020-10-02", "2020-10-03", "2020-10-04"), 1, 0)
data_shift$wb3 <- ifelse(data_shift$date %in% c("2020-10-05", "2020-10-06", "2020-10-07", "2020-10-08", "2020-10-09", "2020-10-10", "2020-10-11"), 1, 0)
data_shift$wb2 <- ifelse(data_shift$date %in% c("2020-10-12", "2020-10-13", "2020-10-14", "2020-10-15", "2020-10-16", "2020-10-17", "2020-10-18"), 1, 0)
data_shift$wb1 <- ifelse(data_shift$date %in% c("2020-10-19", "2020-10-20", "2020-10-21", "2020-10-22", "2020-10-23", "2020-10-24", "2020-10-25"), 1, 0)
data_shift$w1 <- ifelse(data_shift$date %in% c("2020-10-26", "2020-10-27", "2020-10-28", "2020-10-29", "2020-10-30", "2020-10-31", "2020-11-01"), 1, 0)
data_shift$w2 <- ifelse(data_shift$date %in% c("2020-11-02", "2020-11-03", "2020-11-04", "2020-11-05", "2020-11-06", "2020-11-07", "2020-11-08"), 1, 0)
data_shift$w3 <- ifelse(data_shift$date %in% c("2020-11-09", "2020-11-10", "2020-11-11", "2020-11-12", "2020-11-13", "2020-11-14", "2020-11-15"), 1, 0)
data_shift$w4 <- ifelse(data_shift$date %in% c("2020-11-16", "2020-11-17", "2020-11-18", "2020-11-19", "2020-11-20", "2020-11-21", "2020-11-22"), 1, 0)
data_shift$w5 <- ifelse(data_shift$date %in% c("2020-11-23", "2020-11-24", "2020-11-25", "2020-11-26", "2020-11-27", "2020-11-28", "2020-11-29", "2020-11-30"), 1, 0)
data_shift$date <- as.Date(data_shift$date)

### data.frame화
data_shift <- data.frame(data_shift)


#####################################################################################################################
##### day-level data: data_day #####
#####################################################################################################################
head(data_shift)

# 하루 shift 개수, 합배송 shift 비율, 합배송인 shift 내 평균 주문개수
data_day1 <- data_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>% 
  summarise(total_shift = n(),
            mean_orders_shift = mean(num_orders),
            mean_duration_shift = mean(total_duration),
            share_aggshift = length(which(num_orders>1))/total_shift,
            share_singleshift = length(which(num_orders==1))/total_shift,
            orders_stacked = sum(num_orders[num_orders>1]),
            orders_one = sum(num_orders[num_orders==1]),
            num_singleshift = length(which(num_orders==1)),
            num_stackedshift = length(which(num_orders>1)),
            mean_orders_aggshift = mean(num_orders[num_orders>1]),
            mean_duration_aggshift = mean(total_duration[num_orders>1]),
            total_fee = sum(shift_profit)) #합배송 없는날 NA처리됨=1181


# 실노동시간(hour), 쉬는시간(hour), 실노동시간 비율, 전체 수행 주문개수/노동+쉬는시간 (1시간당 수행주문개수)
data_day2 <- data_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>% 
  summarise(working_duration = sum(total_duration)/60,
            idle_duration = sum(idle_btw_shifts, na.rm=TRUE)/60,
            total_labor = working_duration + idle_duration,
            total_orders = sum(num_orders),
            total_aiorders = sum(num_aiorders),
            ai_assist_day = ifelse(total_aiorders==0,0,1),
            share_workingd = working_duration/total_labor,
            share_idled = idle_duration/total_labor,
            orders_per_hour = total_orders/total_labor)

# 소비자 대기시간 및 대기시간의 sd, variance
data_day3 <- data_order %>% group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>%
  summarise(avg_waiting = mean(waiting_min),
            sd_waiting = sd(waiting_min),
            var_waiting = var(waiting_min),
            share_failedorders = sum(waiting_min>30)/n())


# data merge
data_day <- left_join(data_day1,data_day2) %>% left_join(data_day3) %>% as.data.frame()
remove(data_day1,data_day2, data_day3)

### week dummies
unique(data_day$date)
str(data_day$date)

data_day$date <- as.character(data_day$date)
data_day$wb5 <- ifelse(data_day$date %in% c("2020-09-26", "2020-09-27"),1,0)
data_day$wb4 <- ifelse(data_day$date %in% c("2020-09-28", "2020-09-29", "2020-09-30", "2020-10-01", "2020-10-02", "2020-10-03", "2020-10-04"), 1, 0)
data_day$wb3 <- ifelse(data_day$date %in% c("2020-10-05", "2020-10-06", "2020-10-07", "2020-10-08", "2020-10-09", "2020-10-10", "2020-10-11"), 1, 0)
data_day$wb2 <- ifelse(data_day$date %in% c("2020-10-12", "2020-10-13", "2020-10-14", "2020-10-15", "2020-10-16", "2020-10-17", "2020-10-18"), 1, 0)
data_day$wb1 <- ifelse(data_day$date %in% c("2020-10-19", "2020-10-20", "2020-10-21", "2020-10-22", "2020-10-23", "2020-10-24", "2020-10-25"), 1, 0)
data_day$w1 <- ifelse(data_day$date %in% c("2020-10-26", "2020-10-27", "2020-10-28", "2020-10-29", "2020-10-30", "2020-10-31", "2020-11-01"), 1, 0)
data_day$w2 <- ifelse(data_day$date %in% c("2020-11-02", "2020-11-03", "2020-11-04", "2020-11-05", "2020-11-06", "2020-11-07", "2020-11-08"), 1, 0)
data_day$w3 <- ifelse(data_day$date %in% c("2020-11-09", "2020-11-10", "2020-11-11", "2020-11-12", "2020-11-13", "2020-11-14", "2020-11-15"), 1, 0)
data_day$w4 <- ifelse(data_day$date %in% c("2020-11-16", "2020-11-17", "2020-11-18", "2020-11-19", "2020-11-20", "2020-11-21", "2020-11-22"), 1, 0)
data_day$w5 <- ifelse(data_day$date %in% c("2020-11-23", "2020-11-24", "2020-11-25", "2020-11-26", "2020-11-27", "2020-11-28", "2020-11-29","2020-11-30"), 1, 0)
data_day$date <- as.Date(data_day$date)

# riderDOW
data_day$wday <- wday(data_day$date)
data_day <- data_day %>% mutate(riderDOW = paste(rider_id, wday, sep="_"))
length(unique(data_day$riderDOW))


# share of aiorders
data_day$share_aiorders = ifelse(data_day$Treat==1,data_day$total_aiorders/data_day$total_orders,NA)

#####################################################################################################################
##### day-peak/offpeak-level data: data_dayhour #####
#####################################################################################################################
# head(data_order)
# test <- data_order %>% group_by(hour) %>% summarise(orders = n(),
#                                                     riders = length(unique(rider_id)),
#                                                     share_ds = orders/riders)
# plot(orders~hour,data=test, type="l")
# plot(riders~hour,data=test, type="l")
# plot(share_ds~hour,data=test, type="l" )
# 
# #peak=11~13,17~20 | midpeak=14~16,21~23 | offpeak=0~10
# data_order$peak <- ifelse(data_order$hour %in% c(11:13, 17:20),1,0)
# data_order$midpeak <- ifelse(data_order$hour %in% c(14:16, 21:23),1,0)
# data_order$offpeak <- ifelse(data_order$hour %in% c(0:10),1,0)
# data_dayhour <- data_order %>% group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date, peak, midpeak, offpeak) %>% 
#   summarise(avg_waiting = mean(waiting_min),
#             sd_waiting = sd(waiting_min),
#             var_waiting = var(waiting_min),
#             share_failed = sum(waiting_min>30)/n())
# 
# 
# # riderDOW
# data_dayhour$wday <- wday(data_dayhour$date)
# data_dayhour <- data_dayhour %>% mutate(riderDOW = paste(rider_id, wday, sep="_"))
# length(unique(data_day$riderDOW))



#####################################################################################################################
##### 추천배차 도입 전 데이터에서, 전체 노동+idle 시간당 수행주문건수로 proficiency 변수 만들기 #####
#####################################################################################################################
proficiency <- data_day %>% filter(date<"2020-10-26") %>%
  group_by(rider_id) %>% summarise(prof = mean(orders_per_hour))
summary(proficiency$prof)
#hist(proficiency$prof, breaks=500)
#proficiency
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.934   3.981   4.556   4.669   5.296   8.555

### 50
proficiency <- proficiency %>% mutate(prof_low50 = ifelse(prof<4.556,1,0),
                                      prof_high50 = ifelse(prof>=4.556,1,0))



### 33/33/33
quantile(proficiency$prof, probs = c(.333, .667))
# 33.3%    66.7% 
#   4.195891 4.967451 
test<-proficiency %>% filter(prof<4.196) #195 riders
test<-proficiency %>% filter(prof>=4.196 & prof<4.967) # 194riders
test<-proficiency %>% filter(prof>=4.967) # 195riders
proficiency <- proficiency %>% mutate(prof_low = ifelse(prof<4.196,1,0),
                                      prof_med = ifelse(prof>=4.196 & prof<4.967,1,0),
                                      prof_high = ifelse(prof>=4.967,1,0))


# #(15/70/15)
# quantile(proficiency$prof, probs = c(.15, .85))
# # 15%      85% 
# #   3.595149 5.752944 
# test<-proficiency %>% filter(prof<3.595) #88 riders
# test<-proficiency %>% filter(prof>=3.595 & prof<5.753) # 408riders
# test<-proficiency %>% filter(prof>=5.753) # 88riders
# proficiency <- proficiency %>% mutate(prof_low15 = ifelse(prof<3.595,1,0),
#                                       prof_med70 = ifelse(prof>=3.595 & prof<5.753,1,0),
#                                       prof_high15 = ifelse(prof>=5.753,1,0))



data_order <- left_join(data_order,proficiency)
data_order_pre <- data_order %>% filter(After==0)
data_order_pre <- left_join(data_order_pre,proficiency)

data_shift <- left_join(data_shift,proficiency)

data_day <- left_join(data_day, proficiency)
# data_dayhour <- left_join(data_dayhour, proficiency)



#### Share of aiorders by riders 
data_order <- left_join(data_order,treat_riders[,c(1,5)])
data_order_pre <- left_join(data_order_pre,treat_riders[,c(1,5)])
data_shift <- left_join(data_shift,treat_riders[,c(1,5)])
data_day <- left_join(data_day,treat_riders[,c(1,5)])
# data_dayhour <- left_join(data_dayhour,treat_riders[,c(1,5)])


#####################################################################################################################
##### Pretreatment period data를 활용한 matching covariates 만들기
#####################################################################################################################

### pretreatment 데이터 추출
length(unique(data_order_pre$date)) # pretreatment period: 30 days (2020-09-26 ~ 2020-10-25)

##### 평균 배차/픽업/배달 소요시간 #####
pre_var <- data_order_pre %>% 
  group_by(rider_id) %>% 
  summarise(avg_assign = mean(assign_min), avg_pickup = mean(pickup_min), avg_deliver = mean(delivery_min), avg_waiting = mean(waiting_min))
#hist(pre_var$avg_assign, breaks=532, main = "Avg. assign duration", xlab="avg_assign")
#hist(pre_var$avg_pickup, breaks=532, main = "Avg. pickup duration", xlab="avg_pickup")
#hist(pre_var$avg_deliver, breaks=532, main = "Avg. deliver duration", xlab="avg_deliver")
#hist(pre_var$avg_waiting, breaks=532, main = "Avg. assign to deliver duration", xlab="avg_assign_to_deliver")


#### 평균 배달 직선거리
test <- data_order_pre %>%
  group_by(rider_id) %>%
  summarise(avg_ODdist = mean(distorigintodest, na.rm=T))
pre_var <- left_join(pre_var, test)

#hist(pre_var$avg_ODdist, breaks=533, main = "Avg. OD distance", xlab="avg_OD_distance", xlim=c(0.5,3))


### 하루 평균 배달 상점수
test <- data_order_pre %>% 
  group_by(rider_id, date) %>%
  summarise(num_delivered_stores = length(unique(store_id))) %>%
  group_by(rider_id) %>%
  summarise(daily_delivered_stores = mean(num_delivered_stores))

#hist(test$daily_delivered_stores, breaks=533, main = "Number of daily delivered stores", xlab="Number of stores")

pre_var <- left_join(pre_var, test)



### 주간 노동 일수
# 주, 요일 정의
unique(data_order_pre$date) #2020-09-26 ~ 2020-10-25
data_order_pre$date <- as.character(data_order_pre$date)
data_order_pre <- data_order_pre %>% mutate(week = ifelse(date %in% c("2020-09-26"),1,
                                                          ifelse(date %in% c("2020-09-27","2020-09-28","2020-09-29","2020-09-30","2020-10-01","2020-10-02","2020-10-03"),2,
                                                                 ifelse(date %in% c("2020-10-04","2020-10-05","2020-10-06","2020-10-07","2020-10-08","2020-10-09","2020-10-10"),3,
                                                                        ifelse(date %in% c("2020-10-11","2020-10-12","2020-10-13","2020-10-14","2020-10-15","2020-10-16","2020-10-17"),4,
                                                                               ifelse(date %in% c("2020-10-18","2020-10-19","2020-10-20","2020-10-21","2020-10-22","2020-10-23","2020-10-24"),5,
                                                                                      ifelse(date %in% c("2020-10-25"),6,NA)))))))
data_order_pre$date <- as.Date(data_order_pre$date)


# 변수 만들기
test <- data_order_pre %>% filter(week %in% c(2:5)) %>%
  group_by(rider_id, week) %>%
  summarise(num_working_days = length(unique(date))) %>% 
  group_by(rider_id) %>%
  summarise(num_working_days = mean(num_working_days))

pre_var <- left_join(pre_var, test)

#hist(pre_var$num_working_days, breaks=533, main = "Avg. working days in a week", xlab="Number of working days")
#hist(pre_var$share_weekdays, breaks=533, main = "Share of working weekdays in a week", xlab="Share of weekdays")



### 부릉 서비스 경력
data_order_pre$created_at <- as.Date(data_order_pre$created_at)
data_order_pre <- data_order_pre %>% mutate(tenure = as.numeric(as.Date("2020-10-26")-created_at))
summary(data_order_pre$tenure)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 30     121     264     337     512    1151 

test <- data_order_pre %>% group_by(rider_id) %>% summarise(tenure = unique(tenure))

pre_var <- left_join(pre_var, test)

#hist(pre_var$tenure, breaks=533, main = "Tenure in Vroong", xlab="Tenure (days)")



### 꿀콜 레벨
test <- data_order_pre %>% group_by(rider_id) %>% summarise(avg_order_level = mean(order_level, na.rm=TRUE))
pre_var <- left_join(pre_var,test)

#hist(test$avg_order_level, breaks =300)


### shift내 평균 주문개수, duration, shift간 idle time, 주문1개당 소요시간
test <- data_shift %>% filter(date<"2020-10-26") %>% 
  group_by(rider_id) %>% summarise(avg_assign_shift = mean(avg_assign),
                                   avg_pickup_shift = mean(avg_pickup),
                                   avg_deliver_shift = mean(avg_deliver),
                                   avg_waiting_shift = mean(avg_waiting),
                                   avg_orders_shift = mean(num_orders),
                                   avg_duration_shift = mean(total_duration),
                                   avg_idle_shift = mean(idle_btw_shifts, na.rm=T),
                                   avg_duration_orders = mean(avg_duration_orders))
pre_var <- left_join(pre_var,test)


### 하루 평균 shift개수, 합배송 shift의 비율, 합배송 shift내 평균 주문개수, 
test <- data_day %>% filter(date<"2020-10-26") %>% 
  group_by(rider_id) %>% summarise(daily_total_shift = mean(total_shift),
                                   daily_singleorder = mean(orders_one),
                                   daily_share_singleorder = mean(orders_one/total_orders),
                                   daily_working_duration = mean(working_duration),
                                   daily_idle_duration = mean(idle_duration),
                                   daily_total_labor = mean(total_labor),
                                   daily_total_order = mean(total_orders),
                                   daily_share_idled = mean(share_idled),
                                   daily_orders_per_hour = mean(orders_per_hour),
                                   daily_profit = mean(total_fee))

pre_var <- left_join(pre_var, test)



### Treat
pre_var$Treat <- ifelse(pre_var$rider_id %in% treat_riders$rider_id, 1, 0)

### Proficiency
pre_var <- left_join(pre_var, proficiency)





########################################################################################################################################################
##### Matching Preparation #####
########################################################################################################################################################
library(MatchIt); library(knitr)
head(pre_var) # 앞에서 만든 라이더 특성변수 34개
summary(pre_var) #584riders, 1 NA in num_working_days(도입전 기간은 10/25하루만 근무), 1 NA in avg_idle_shift

##### Covarites #####
colnames(pre_var)
# [1] "rider_id"                "avg_assign"              "avg_pickup"              "avg_deliver"            
# [5] "avg_waiting"             "avg_ODdist"              "daily_delivered_stores"  "num_working_days"       
# [9] "tenure"                  "avg_order_level"         "avg_assign_shift"        "avg_pickup_shift"       
# [13] "avg_deliver_shift"       "avg_waiting_shift"       "avg_orders_shift"        "avg_duration_shift"     
# [17] "avg_idle_shift"          "avg_duration_orders"     "daily_total_shift"       "daily_singleorder"      
# [21] "daily_share_singleorder" "daily_working_duration"  "daily_idle_duration"     "daily_total_labor"      
# [25] "daily_total_order"       "daily_share_idled"       "daily_orders_per_hour"   "daily_profit"           
# [29] "Treat"                   "prof"                    "prof_low50"              "prof_high50"            
# [33] "prof_low"                "prof_med"                "prof_high"      
pretreat_cov <- colnames(pre_var[,c(2:28,30:35)])

pre_var_nona <- na.omit(pre_var) #582riders
pre_var_nona <- as.data.frame(pre_var_nona)




##### T-test before matching by Treat/control#####
test <- pre_var_nona %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
for (i in 1:length(pretreat_cov)){
  a<-t.test(pre_var_nona[, pretreat_cov[i]] ~ pre_var_nona[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}


### T-test before matching by beginner/experienced
# test1 <- pre_var_nona %>% group_by(prof_high50) %>% dplyr::select(one_of(pretreat_cov)) %>%
#   summarise_all(funs(mean(., na.rm=T)))
# 
# test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
# for (i in 1:length(pretreat_cov)){
#   a<-t.test(pre_var_nona[, pretreat_cov[i]] ~ pre_var_nona[, 'prof_50h'])
#   test$tvalue[i] <- a$statistic
#   test$pvalue[i] <- a$p.value
# }
# 


##### Propensity score estimation #####
pscore <- glm(Treat ~ daily_delivered_stores + num_working_days +
                avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                daily_total_labor + daily_idle_duration, family = binomial(), data=pre_var_nona)
summary(pscore)

pscore <- glm(Treat ~ daily_delivered_stores + num_working_days +
                avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift + avg_duration_orders+
                daily_working_duration + daily_idle_duration + daily_total_labor + daily_share_idled +
                daily_total_order + daily_total_shift + daily_share_singleorder + daily_profit, 
              family = binomial(), data=pre_var_nona)
summary(pscore)


### 유의한 변수들 찾기
test <- step(pscore, direction ="backward")
summary(test)
# pre_var_nona's remained variables: 
# avg_shift_order_level + daily_delivered_stores + num_working_days + avg_duration_shift + avg_shift_profit + daily_total_order + daily_profit

# pre_var_nona_no1's remained variables:
# avg_shift_order_level + daily_delivered_stores + num_working_days + avg_orders_shift + avg_duration_shift + avg_shift_profit + daily_total_order + daily_profit

pscore1 <- glm(Treat ~ daily_delivered_stores + num_working_days + 
                 avg_assign_shift + avg_pickup_shift + avg_deliver_shift + avg_order_level +
                 daily_orders_per_hour + daily_total_shift + daily_idle_duration, 
               family = binomial(), data=pre_var_nona)
summary(pscore1)

pscore1 <- glm(Treat ~ daily_delivered_stores + num_working_days + 
                 avg_waiting_shift + avg_orders_shift + avg_duration_shift+
                 daily_total_labor + daily_idle_duration, 
               family = binomial(), data=pre_var_nona)
summary(pscore1)

pscore1 <- glm(Treat ~ daily_delivered_stores + num_working_days +
                 avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                 daily_total_labor + daily_idle_duration, 
               family = binomial(link = "logit"), data=pre_var_nona)
summary(pscore1)



### Save predicted propensity scrore
pscore_df <- data.frame(rider_id = pre_var_nona$rider_id,
                        pscore = predict(pscore1, type="response"),
                        Treat = pscore1$model$Treat)
head(pscore_df)


### Examining the region of common support
labs <- paste("Rider:", c("who adopt AI", "never adopt AI"))
pscore_df %>%
  mutate(Treat = ifelse(Treat==1, labs[1],labs[2])) %>%
  ggplot(aes(x=pscore)) +
  geom_histogram(color = "white", binwidth = 0.01) +
  facet_wrap(~Treat) +
  xlab("Probability of AI adoption") +
  theme_bw()

### Distribution of predicted propensity scrore
plot(density(pscore_df$pscore[pscore_df$Treat==1]), main = "Before matching", xlab = "Estimated propensity score")
lines(density(pscore_df$pscor[pre_var_nona$Treat==0]), lty=2)

#bal.plot(psmatch1, var.name = "distance", which = "both")





################################################################################################################################################
##### #1 Matching: PSM 1:1 matching with a caplier size 0.2 (or 0.05) times the s.d. of the propensity #####
################################################################################################################################################

#psmatch1 - 1:1 nearest matching with caliper 0.05 w/o replacement
#psmatch2 - 1:1 nearest matching with caliper 0.01 w/o replacement

### matching algorithm
psmatch1 <- matchit(Treat ~  daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.05, std.caliper=TRUE, discard = "both")
summary(psmatch1)

psmatch2 <- matchit(Treat ~  daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.01, std.caliper=TRUE, discard = "both")
summary(psmatch2)

#plot(psmatch1)

# psmatch2 <- matchit(Treat ~  daily_delivered_stores + num_working_days + 
#                       avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
#                       daily_total_labor + daily_idle_duration + ,
#                     method="nearest", data=pre_var_nona, caliper=0.2, std.caliper=TRUE, discard = "both")
# summary(psmatch2)


### matched data
matched_data1 <- match.data(psmatch1)
matched_data2 <- match.data(psmatch2)

### Distribution of predicted propensity scrore
pscore_df_matched <- pscore_df %>% filter(rider_id %in% matched_data1$rider_id)

plot(density(pscore_df_matched$pscore[pscore_df_matched$Treat==0]), lty=2, main = "After matching", xlab = "Estimated propensity score")
lines(density(pscore_df_matched$pscore[pscore_df_matched$Treat==1]))
legend("topright",legend=c("Control","Treat"),lty=c(2,1))

#### Machted data에 대한 T-test #####
test <- matched_data1 %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
for (i in 1:length(pretreat_cov)){
  a<-t.test(matched_data1[, pretreat_cov[i]] ~ matched_data1[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}

##### 데이터 추출 #####
data_order_matched1 <- data_order %>% filter(rider_id %in% matched_data1$rider_id) %>% left_join(matched_data1[,c(1,38)])
data_shift_matched1 <- data_shift %>% filter(rider_id %in% matched_data1$rider_id) %>% left_join(matched_data1[,c(1,38)])
data_day_matched1 <- data_day %>% filter(rider_id %in% matched_data1$rider_id) %>% left_join(matched_data1[,c(1,38)])

data_shift_matched2<- data_shift %>% filter(rider_id %in% matched_data2$rider_id) %>% left_join(matched_data2[,c(1,38)])
data_day_matched2 <- data_day %>% filter(rider_id %in% matched_data2$rider_id) %>% left_join(matched_data2[,c(1,38)])

################################################################################################################################################
#### #2 PSM w/o replacement with a caplier size 0.2(0.05) of s.d. of ps score, 추천배차 단 1회 사용 라이더 제외후 매칭&분석 #####
################################################################################################################################################

#psmatch3 - caliper 0.2, 추천배차 단 1회 사용 라이더 제외
#psmatch4 - caliper 0.05, 추천배차 단 1회 사용 라이더 제외

test <- data_order %>% group_by(rider_id, prof_low, prof_med, prof_high) %>% summarise(ai_order = sum(is_rec_completed)) %>% filter(ai_order==1) 
#1회 사용라이더 61명 - prof_low 15, prof_med 23, prof_high 23명 (처치군의 15.2%)

pre_var_nona_no1 <- pre_var_nona %>% filter(rider_id %!in% test$rider_id) #521riders

### Executing matching algorithm: one-to-one matching w/o replacement with a caplier size 0.2 times the s.d. of the propensity 
psmatch3 <- matchit(Treat ~ daily_delivered_stores + num_working_days + 
                      avg_assign_shift + avg_pickup_shift + avg_deliver_shift + avg_order_level +
                      daily_orders_per_hour + daily_total_shift + daily_idle_duration,
                    method="nearest", data=pre_var_nona_no1, caliper=0.2, std.caliper=TRUE, discard = "both")

summary(psmatch4)

### matched data
matched_data <- match.data(psmatch3)

### Distribution of predicted propensity scrore
pscore_df_matched <- pscore_df %>% filter(rider_id %in% matched_data$rider_id)

plot(density(pscore_df_matched$pscore[pscore_df_matched$Treat==0]), lty=2, main = "After matching", xlab = "Estimated propensity score")
lines(density(pscore_df_matched$pscore[pscore_df_matched$Treat==1]))
legend("topright",legend=c("Control","Treat"),lty=c(2,1))

##### Machted data에 대한 T-test #####
test <- matched_data %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
for (i in 1:length(pretreat_cov)){
  a<-t.test(matched_data[, pretreat_cov[i]] ~ matched_data[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}

##### 데이터 추출 #####
data_shift_matched <- data_shift %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])
data_day_matched <- data_day %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])


################################################################################################################################################
##### #3 PSM with replacement under a caplier size 0.2 (or 0.05) times the s.d. of the propensity #####
##### (whether treated can be used as matches for more than one control individual)
################################################################################################################################################

# psmatch3: PSM with 1:1 replacement under a caplier size 0.05
# psmatch4: PSM with 1:1 replacement under a caplier size 0.01


### Treat_rev: control-treat 1:1 매칭을 위해 control==1, treat==0 배정
pre_var_nona <- pre_var_nona %>% mutate(Treat_rev = ifelse(Treat==1,0,1))

### matching algorithm
psmatch3 <- matchit(Treat_rev ~  daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.05, std.caliper=TRUE, replace = TRUE, discard = "both")
summary(psmatch3)

psmatch4 <- matchit(Treat_rev ~  daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.01, std.caliper=TRUE, replace = TRUE, discard = "both")
summary(psmatch4)


### matched data
matched_data3 <- match.data(psmatch3)
matched_data4 <- match.data(psmatch4)

### Distribution of predicted propensity scrore
pscore_df_matched <- pscore_df %>% filter(rider_id %in% matched_data$rider_id)

plot(density(pscore_df_matched$pscore[pscore_df_matched$Treat==0]), lty=2, main = "After matching", xlab = "Estimated propensity score")
lines(density(pscore_df_matched$pscore[pscore_df_matched$Treat==1]))
legend("topright",legend=c("Control","Treat"),lty=c(2,1))

#### Machted data에 대한 T-test #####
test <- matched_data %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
for (i in 1:length(pretreat_cov)){
  a<-t.test(matched_data[, pretreat_cov[i]] ~ matched_data[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}

##### 데이터 추출 #####
data_shift_matched3 <- data_shift %>% filter(rider_id %in% matched_data3$rider_id)
data_day_matched3 <- data_day %>% filter(rider_id %in% matched_data3$rider_id)

data_shift_matched4 <- data_shift %>% filter(rider_id %in% matched_data4$rider_id)
data_day_matched4 <- data_day %>% filter(rider_id %in% matched_data4$rider_id)

################################################################################################################################################
##### #4 PSM 1:n matching #####
################################################################################################################################################

#psmatch5: PSM 1:2 matching w/ replacement, caliper 0.05
#psmatch6: PSM 1:2 matching w/ replacement, caliper 0.01

### matching algorithm
psmatch5 <- matchit(Treat_rev ~  daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.05, std.caliper=TRUE, discard = "both", ratio = 2, replace = TRUE)
summary(psmatch5)

psmatch6 <- matchit(Treat_rev ~  daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.01, std.caliper=TRUE, discard = "both", ratio = 2, replace = TRUE)
summary(psmatch6)


### matched data
matched_data5 <- match.data(psmatch5)
matched_data6 <- match.data(psmatch6)

### Distribution of predicted propensity scrore
pscore_df_matched <- pscore_df %>% filter(rider_id %in% matched_data$rider_id)

plot(density(pscore_df_matched$pscore[pscore_df_matched$Treat==0]), lty=2, main = "After matching", xlab = "Estimated propensity score")
lines(density(pscore_df_matched$pscore[pscore_df_matched$Treat==1]))

#### Machted data에 대한 T-test #####
test <- matched_data %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
for (i in 1:length(pretreat_cov)){
  a<-t.test(matched_data[, pretreat_cov[i]] ~ matched_data[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}
##### 데이터 추출 #####
data_order_matched5 <- data_order %>% filter(rider_id %in% matched_data5$rider_id) %>% left_join(matched_data1[,c(1,42)])
data_shift_matched5 <- data_shift %>% filter(rider_id %in% matched_data5$rider_id) %>% left_join(matched_data5[,c(1,41)])
data_day_matched5 <- data_day %>% filter(rider_id %in% matched_data5$rider_id) %>% left_join(matched_data5[,c(1,41)])

data_shift_matched6 <- data_shift %>% filter(rider_id %in% matched_data6$rider_id) %>% left_join(matched_data6[,c(1,41)])
data_day_matched6 <- data_day %>% filter(rider_id %in% matched_data6$rider_id) %>% left_join(matched_data6[,c(1,41)])

################################################################################################################################################
##### # Mahalanobis matching #####
################################################################################################################################################

#psmatch8

### matching algorithm
psmatch7 <- matchit(Treat ~  daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.05, std.caliper=TRUE, discard = "both",
                    mahvars = ~ daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration)
summary(psmatch7)

psmatch8 <- matchit(Treat ~  daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.01, std.caliper=TRUE, discard = "both",
                    mahvars = ~ daily_delivered_stores + num_working_days +
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                      daily_total_labor + daily_idle_duration)
summary(psmatch8)


### matched data
matched_data7 <- match.data(psmatch7)
matched_data8 <- match.data(psmatch8)

### Distribution of predicted propensity scrore
pscore_df_matched <- pscore_df %>% filter(rider_id %in% matched_data$rider_id)

plot(density(pscore_df_matched$pscore[pscore_df_matched$Treat==0]), lty=2, main = "After matching", xlab = "Estimated propensity score")
lines(density(pscore_df_matched$pscore[pscore_df_matched$Treat==1]))

#### Machted data에 대한 T-test #####
test <- matched_data %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
for (i in 1:length(pretreat_cov)){
  a<-t.test(matched_data[, pretreat_cov[i]] ~ matched_data[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}

##### 데이터 추출 #####
data_shift_matched7 <- data_shift %>% filter(rider_id %in% matched_data7$rider_id) %>% left_join(matched_data7[,c(1,39)])
data_day_matched7 <- data_day %>% filter(rider_id %in% matched_data7$rider_id) %>% left_join(matched_data7[,c(1,39)])

data_shift_matched8 <- data_shift %>% filter(rider_id %in% matched_data8$rider_id) %>% left_join(matched_data8[,c(1,39)])
data_day_matched8 <- data_day %>% filter(rider_id %in% matched_data8$rider_id) %>% left_join(matched_data8[,c(1,39)])



################################################################################################################################################
##### 1-1) psmatch에서 초반 일주일 데이터 제외후 분석
################################################################################################################################################

### 일별 추천배차 사용라이더비율 및 오더비율 확인
test <- data_order %>% group_by(date) %>% summarise(share_airiders = length(unique(rider_id[is_rec_completed==1]))/length(unique(rider_id)),
                                                    share_aiorders = length(which(is_rec_completed==1))/n())

### matching algorithm: psmatch; 1:1 nearest matching with caliper 0.2
summary(psmatch1)


### 초반 일주일 데이터 제외 (아래 작업 후 바로 model estimation으로 넘어가기)
matched_data <- match.data(psmatch1)

data_order_matched <- data_order %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,35)])
data_shift_matched <- data_shift %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,35)])
data_day_matched <- data_day %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,35)])


### 매칭된 라이더끼리 After 변수 만들어주기 
# After_ind: 각 라이더의 AI 추천배차 도입시점 (매칭된 처치군-통제군 같은 기준으로 맞춤)

# order-level data; 도입시점이랑 subclass 정보 merge
test <- data_order %>% filter(is_rec_completed==1) %>% group_by(rider_id) %>% summarise(date_adopt = min(assignedat))
test <- left_join(test, matched_data[,c(1,36)])

data_order_matched <- left_join(data_order_matched,test[,-1]) 
data_shift_matched <- left_join(data_shift_matched,test[,-1])

data_order_matched <- data_order_matched %>% mutate(After_ind = ifelse(assignedat >= date_adopt,1,0))
data_shift_matched <- data_shift_matched %>% mutate(After_ind = ifelse(start >= date_adopt,1,0))

# daily-level data
test <- data_order %>% filter(is_rec_completed==1) %>% group_by(rider_id) %>% summarise(date_adopt = min(date))
test <- left_join(test, matched_data[,c(1,36)])

#daily_order_matched <- left_join(daily_order_matched,test[,-1])
data_day_matched <- left_join(data_day_matched,test[,-1])

#daily_order_matched <- daily_order_matched %>% mutate(After_ind = ifelse(date >= date_adopt,1,0))
data_day_matched <- data_day_matched %>% mutate(After_ind = ifelse(date >= date_adopt,1,0))


data_order_matched$date <- as.character(data_order_matched$date); data_shift_matched$date <- as.character(data_shift_matched$date); data_day_matched$date <- as.character(data_day_matched$date)
data_order_matched <- data_order_matched %>% filter(date %!in% c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30", "2020-10-31"))
data_shift_matched <- data_shift_matched %>% filter(date %!in% c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30", "2020-10-31"))
data_day_matched <- data_day_matched %>% filter(date %!in% c("2020-10-26","2020-10-27","2020-10-28","2020-10-29","2020-10-30", "2020-10-31"))





################################################################################################################################################
##### DID, DDD model estimation #####
################################################################################################################################################
####################################################################################################################################
head(data_shift_matched)

m1 <- felm(num_orders ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched1)
#m2 <- felm(orders_per_hour ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched2)
m3 <- felm(num_orders ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched3)
m4 <- felm(avg_duration_orders ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_shift_matched4)
m5 <- felm(num_orders ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched5)
m6 <- felm(avg_duration_orders ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_shift_matched6)
m7 <- felm(num_orders ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched7)
#m8 <- felm(orders_per_hour ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched8)
m9 <- felm(num_orders ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)

tab_model(m1,m3,m5,m7,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3)
tab_model(m4,m6,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3)


m1 <- felm(num_orders ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched1)
m1 <- felm( ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_date, data=data_shift_matched1)
#m2 <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
#             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched2)
m3 <- felm(ln(avg_dist) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched3)
m4 <- felm(ln(avg_dist) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched4)
m5 <- felm(ln(avg_dist) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched5)
m6 <- felm(ln(avg_dist) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched6)
m7 <- felm(ln(avg_dist) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched7)
#m8 <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
#             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched8)
m9 <- felm(ln(avg_dist) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift)

tab_model(m1,m3,m5,m7,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))
tab_model(m4,m6,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))
tab_model(m1,m3,m5,m7,m4,m6,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))




test1_1 <- data_shift_matched1 %>% filter(num_orders == 1);test2_1 <- data_shift_matched1 %>% filter(num_orders >= 2)
test1_3 <- data_shift_matched3 %>% filter(num_orders == 1);test2_3 <- data_shift_matched3 %>% filter(num_orders >= 2)
test1_4 <- data_shift_matched4 %>% filter(num_orders == 1);test2_4 <- data_shift_matched4 %>% filter(num_orders >= 2)
test1_5 <- data_shift_matched5 %>% filter(num_orders == 1);test2_5 <- data_shift_matched5 %>% filter(num_orders >= 2)
test1_6 <- data_shift_matched6 %>% filter(num_orders == 1);test2_6 <- data_shift_matched6 %>% filter(num_orders >= 2)
test1_7 <- data_shift_matched7 %>% filter(num_orders == 1);test2_7 <- data_shift_matched7 %>% filter(num_orders >= 2)
test1_9 <- data_shift %>% filter(num_orders == 1);test2_9 <- data_shift %>% filter(num_orders >= 2)

m1 <- felm(avg_waiting ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched1)

m1 <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched1)
#m2 <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
#             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test1_2)
m3 <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test1_3)
m4 <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test1_4)
m5 <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test1_5)
m6 <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test1_6)
m7 <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test1_7)
#m8 <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
#             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test1_8)
m9 <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test1_9)

tab_model(m1,m3,m5,m7,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))
tab_model(m4,m6,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))
tab_model(m1,m3,m4,m5,m6,m7,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))


m1 <- felm(ln(orders_per_hour) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched7)
m1 <- felm(orders_per_hour ~ After:Treat | rider_id + station_date | 0 | v, data=data_day_matched1)
#m2 <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched2)
m3 <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched3)
m4 <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched4)
m5 <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched5)
m6 <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched6)
m7 <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched7)
#m8 <- felm(avg_waiting ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched8)
m9 <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day)

tab_model(m1,m3,m5,m7,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3)
tab_model(m4,m6,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3)
tab_model(m1,m3,m4,m5,m6,m7,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3)

m1 <- felm(ln(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_date, data=data_day_matched1)
#m2 <- felm(orders_per_hour ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
#             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched2)
m3 <- felm(orders_per_hour ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched3)
m4 <- felm(orders_per_hour ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched4)
m5 <- felm(orders_per_hour ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched5)
m6 <- felm(orders_per_hour ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched6)
m7 <- felm(orders_per_hour ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched7)
#m8 <- felm(orders_per_hour ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
#             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched8)
m9 <- felm(orders_per_hour ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high + 
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day)

tab_model(m1,m3,m5,m7,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))
tab_model(m4,m6,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))
tab_model(m1,m3,m5,m7,m4,m6,m9,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))



### order-level consumer waiting time ###
#single order
test<-data_shift_matched1 %>% filter(num_orders==1)
model <- felm(avg_waiting ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(avg_waiting ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
#stacked order
test$rider_date_shift <- paste(paste(test$rider_id, test$date, sep="_"), test$shift, sep="_")
data_order_matched1$rider_date_shift <- paste(paste(data_order_matched1$rider_id, data_order_matched1$date, sep="_"), data_order_matched1$shift, sep="_")
test1 <- data_order_matched1 %>% filter(rider_date_shift %!in% test$rider_date_shift)
model <- felm(waiting_min ~ After:Treat + distorigintodest | rider_id + station_date + hourDOW | 0 | rider_id, data=test1)
summary(model)
model <- felm(waiting_min ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + distorigintodest | rider_id + station_date + hourDOW | 0 | rider_id, data=test1)
summary(model)

model <- felm(ln(avg_waiting) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(avg_waiting ~ After:Treat:prof_low15 + After:Treat:prof_med70 + After:Treat:prof_high15 + 
                After:prof_med70 + After:prof_high15 | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:offpeak + After:Treat:peak + 
                After:peak | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)



test<-data_shift_matched1 %>% filter(num_orders == 1)
model <- felm(avg_waiting ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)



test<-data_shift_matched1 %>% filter(num_orders >= 2)
model <- felm(avg_waiting ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(avg_waiting ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)





model <- felm(avg_assign ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(distorigintodest ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)



model <- felm(avg_pickup ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(avg_pickup ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)



model <- felm(avg_deliver ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(avg_deliver ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)



model <- felm(num_orders ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | riderDOW + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(num_orders ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(num_orders ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)



model <- felm(total_duration ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(total_duration ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)



model <- felm(avg_duration_orders ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat:prof_low30 + After:Treat:prof_high70 + After:prof_high70 | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(avg_duration_orders ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)



test<-data_shift_matched1 %>% filter(num_orders == 1)
model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(total_duration ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-data_shift_matched %>% filter(num_orders >=2)
model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(num_orders ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-data_shift_matched %>% filter(num_orders >=2)
model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-data_shift_matched %>% filter(num_orders >=2)
model <- felm(ln(avg_duration_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)



model <- felm(idle_btw_shifts ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(idle_btw_shifts ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high| rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)


test<-data_shift_matched %>% filter(pre_shift_orders == 1)
model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(idle_btw_shifts ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)


test<-data_shift_matched %>% filter(pre_shift_orders >= 2)
model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(idle_btw_shifts ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + num_orders | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)



model <- felm(ln(avg_order_level) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_order_level) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_order_level) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(avg_order_level ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)


model <- felm(avg_dist ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_order_level) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_order_level) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(avg_order_level ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)




########################################################################################################################
head(data_day_matched)

model1 <- felm(total_orders ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model1)
model <- felm(ln(total_orders) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model2 <- felm(total_orders ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                 After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)




model <- felm(total_shift ~ After:Treat | rider_id + date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_shift) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(total_shift ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)



model <- felm(orders_one ~ After:Treat | rider_id + management_partner_id + date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(orders_one ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=data_day_matched)
summary(model)



model <- felm(orders_stacked ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(orders_stacked ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)



model <- felm(working_duration ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(ln(working_duration) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(working_duration ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)


model <- felm(idle_duration ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(ln(idle_duration+1) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(idle_duration ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)


model <- felm(total_labor ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(ln(total_labor) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(total_labor ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)




model <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(share_idled ~ After:Treat+ After:Treat:prof + After:prof | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_idled ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_idled ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)




model <- felm(orders_per_hour ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched1)
summary(model)
model <- felm(ln(orders_per_hour) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(orders_per_hour ~ After:Treat:prof_low15 + After:Treat:prof_med70 + After:Treat:prof_high15 + 
                After:prof_med70 + After:prof_high15 | rider_id + station_date | 0 | rider_id, data=data_day_matched1)
summary(model)



model <- felm(total_fee ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(ln(total_fee) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_date, data=data_day_matched)
summary(model)
model <- felm(total_fee ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
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


####################################################################################################################################
head(data_dayhour)

model <- felm(ln(avg_waiting) ~ After:Treat:offpeak + After:Treat:midpeak + After:Treat:peak + 
                After:midpeak + After:peak | rider_id + station_date | 0 | rider_id, data=data_dayhour_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:midpeak + After:Treat:peak +
                After:Treat:midpeak:prof_low + After:Treat:midpeak:prof_med + After:Treat:midpeak:prof_high +
                After:Treat:peak:prof_low + After:Treat:peak:prof_med + After:Treat:peak:prof_high | rider_id + station_date | 0 | riderDOW, data=data_dayhour_matched)
summary(model)


model <- felm(ln(var_waiting+1) ~ After:Treat:offpeak + After:Treat:midpeak + After:Treat:peak + 
                After:midpeak + After:peak | rider_id + station_date | 0 | rider_id, data=data_dayhour_matched)
summary(model)

model <- felm(share_failed ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_dayhour_matched)
summary(model)
model <- felm(share_failed ~ After:Treat:offpeak + After:Treat:midpeak + After:Treat:peak + 
                After:midpeak + After:peak | rider_id + station_date | 0 | rider_id, data=data_dayhour_matched)
summary(model)



####################################################################################################################################
#오더레벨 데이터
model <- felm(ln(assign_min+1) ~ After:Treat + distorigintodest | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(assign_min+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(assign_sec+1) ~ After:Treat+
                After:Treat:prof_50h | rider_id + station_date + hourDOW + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)


model <- felm(ln(pickup_min+1) ~ After:Treat + distorigintodest| rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(pickup_min+1) ~  After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high + distorigintodest | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(pickup_sec+1) ~ After:Treat+
                After:Treat:prof_50h | rider_id + station_date + hourDOW + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_50h = 0")); summary(model_check)



model <- felm(ln(delivery_min+1) ~ After:Treat + distorigintodest | rider_id + station_date + hourDOW  | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(delivery_min+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high + distorigintodest | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)


model <- felm(ln(waiting_sec+1) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(waiting_sec+1) ~ After:Treat:offpeak + After:Treat:midpeak + After:Treat:peak +
                After:midpeak + After:peak | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(waiting_sec+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high + distorigintodest | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)



model <- felm(ln(distorigintodest+1) ~ After:Treat | rider_id + station_date + hourDOW| 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(distorigintodest+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)



model <- felm(ln(order_level) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(order_level) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_order_matched)
summary(model)




################################################################################################################################################
##### DID, DDD model estimation - Weekly #####
################################################################################################################################################
####################################################################################################################################
head(data_day_matched)

model <- felm(orders_per_hour ~ Treat:wb5 + Treat:wb4 + Treat:wb3 + Treat:wb2 +
                Treat:w1 + Treat:w2 + Treat:w3 + Treat:w4 + Treat:w5 + Treat:w6 | rider_id + station_date  | 0 | rider_id, data=data_day_matched1)
summary(model)
model <- felm(total_labor~ Treat:wb5:prof_low + Treat:wb4:prof_low + Treat:wb3:prof_low + Treat:wb2:prof_low + 
                Treat:w1:prof_low + Treat:w2:prof_low + Treat:w3:prof_low + Treat:w4:prof_low + Treat:w5:prof_low + 
                Treat:wb5:prof_med + Treat:wb4:prof_med + Treat:wb3:prof_med + Treat:wb2:prof_med + 
                Treat:w1:prof_med + Treat:w2:prof_med  + Treat:w3:prof_med  + Treat:w4:prof_med  + Treat:w5:prof_med  + 
                Treat:wb5:prof_high + Treat:wb4:prof_high + Treat:wb3:prof_high + Treat:wb2:prof_high + 
                Treat:w1:prof_high + Treat:w2:prof_high  + Treat:w3:prof_high  + Treat:w4:prof_high  + Treat:w5:prof_high  +
                wb5:prof_med + wb4:prof_med + wb3:prof_med + wb2:prof_med + 
                w1:prof_med + w2:prof_med + w3:prof_med + w4:prof_med + w5:prof_med + 
                wb5:prof_high + wb4:prof_high + wb3:prof_high + wb2:prof_high + 
                w1:prof_high + w2:prof_high + w3:prof_high + w4:prof_high + w5:prof_high | rider_id + station_date  | 0 | rider_id, data=data_day_matched1)
summary(model)



#total_shift, total_orders, total_fee, total_labor, orders_per_hour
model <- felm(total_shift ~ Treat:wb5:prof_low + Treat:wb4:prof_low + Treat:wb3:prof_low + Treat:wb2:prof_low + 
                Treat:w1:prof_low + Treat:w2:prof_low + Treat:w3:prof_low + Treat:w4:prof_low + Treat:w5:prof_low + Treat:w6:prof_low +
                Treat:wb5:prof_med + Treat:wb4:prof_med + Treat:wb3:prof_med + Treat:wb2:prof_med + 
                Treat:w1:prof_med + Treat:w2:prof_med  + Treat:w3:prof_med  + Treat:w4:prof_med  + Treat:w5:prof_med  + Treat:w6:prof_med  +
                Treat:wb5:prof_high + Treat:wb4:prof_high + Treat:wb3:prof_high + Treat:wb2:prof_high + 
                Treat:w1:prof_high + Treat:w2:prof_high  + Treat:w3:prof_high  + Treat:w4:prof_high  + Treat:w5:prof_high  + Treat:w6:prof_high +
                wb5:prof_med + wb4:prof_med + wb3:prof_med + wb2:prof_med + 
                w1:prof_med + w2:prof_med + w3:prof_med + w4:prof_med + w5:prof_med + w6:prof_med +
                wb5:prof_high + wb4:prof_high + wb3:prof_high + wb2:prof_high + 
                w1:prof_high + w2:prof_high + w3:prof_high + w4:prof_high + w5:prof_high + w6:prof_high | rider_id + station_date  | 0 | rider_id, data=data_day_matched1)
summary(model)








################################################################################################################################################
##### DID, DDD model estimation - by share of ai orders #####
################################################################################################################################################
hist(treat_riders$share_aiorder, breaks=400, 
     main="AI impact on labor productivity by share of AI orders", xlab="Share of AI orders")
data_day_matched$share_aiorder <- ifelse(is.na(data_day_matched$share_aiorder)==1, 0, data_day_matched$share_aiorder) 

quantile(treat_riders$share_aiorder, probs = c(.333, .667))
#33.3%       66.7% 
#  0.004904982 0.019840902 
summary(treat_riders$share_aiorder)
# Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
# 0.0002849 0.0030783 0.0092236 0.0551402 0.0348130 0.7551020 

quantile(treat_riders$share_aiorder, probs = c(.5, .9))


data_day_matched <- data_day_matched %>% mutate(shareai_low = ifelse(share_aiorder>=0.0002 & share_aiorder<0.2,1,0),
                                                shareai_med = ifelse(share_aiorder>=0.01 & share_aiorder<0.5,1,0),
                                                shareai_high = ifelse(share_aiorder>=0.5,1,0))
model <- felm(ln(orders_per_hour) ~ After:Treat + After:Treat:shareai_med + After:Treat:shareai_high | rider_id + station_date  | 0 | rider_id, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:shareai_high = 0")); summary(model_check)

model <- felm(ln(orders_per_hour) ~ After:Treat + After:Treat:ln(share_aiorder+1) | rider_id + station_date  | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(orders_per_hour) ~ After:shareai_low + After:shareai_med + After:shareai_high | rider_id + station_date  | 0 | rider_id, data=data_day_matched)
summary(model)


#####################################################################################################################
test <- data_day %>% group_by(rider_id, Treat) %>% summarise(avg_share_aiorders = mean(share_aiorders))
summary(test$avg_share_aiorders)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# 0.00026 0.00365 0.01459 0.06618 0.05178 0.78244     184 
hist(test$avg_share_aiorders, breaks=500)
quantile(test$avg_share_aiorders, probs = c(.333, .667), na.rm=T)
# 33.3%       66.7% 
#   0.006193316 0.026822930 
quantile(test$avg_share_aiorders, probs = c(.5, .75), na.rm=T)
# 50%        75% 
#   0.01459363 0.05178034 
test$avg_share_aiorders <- ifelse(is.na(test$avg_share_aiorders)==1,0,test$avg_share_aiorders)

test <- test %>% mutate(shareai_1 = ifelse(avg_share_aiorders>=0.0002 & avg_share_aiorders<0.006,1,0),
                        shareai_2 = ifelse(avg_share_aiorders>=0.006 & avg_share_aiorders<0.0268,1,0),
                        shareai_3 = ifelse(avg_share_aiorders>=0.0268,1,0))

data_day_matched <- left_join(data_day_matched, test)
plot(orders_per_hour~avg_share_aiorders, data=data_day_matched)

model <- felm(ln(orders_per_hour) ~ After:Treat + After:Treat:shareai_2 + After:Treat:shareai_3| rider_id + station_date  | 0 | rider_id, data=data_day_matched)
summary(model)
data_day_matched$avg_share_aiorders <- data_day_matched$avg_share_aiorders *100
model <- felm(ln(orders_per_hour) ~ After:Treat + After:Treat:prof_med + After:Treat:prof_high +
                After:Treat:avg_share_aiorders + After:Treat:prof_med:avg_share_aiorders + After:Treat:prof_high:avg_share_aiorders | rider_id + station_date  | 0 | rider_id, data=data_day_matched)
summary(model)

#####################################################################################################################
test <- data_day %>% group_by(rider_id) %>% summarise(total_aiorders2m= sum(total_aiorders))
data_day_matched <- left_join(data_day_matched, test)


#####################################################################################################################
### 합배송 주문개수가 많아질수록 고객 대기시간이 길어지는가? -> 그렇다
model <- felm(ln(avg_waiting) ~ After:Treat + After:Treat:num_orders| rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)

hist(data_shift_matched$num_orders)
summary(data_shift_matched$num_orders)

data_shift_matched$shift_order1 <- ifelse(data_shift_matched$num_orders==1, 1, 0)
data_shift_matched$shift_order2 <- ifelse(data_shift_matched$num_orders==2, 1, 0)
data_shift_matched$shift_order3 <- ifelse(data_shift_matched$num_orders==3, 1, 0)
data_shift_matched$shift_order4 <- ifelse(data_shift_matched$num_orders==4, 1, 0)
data_shift_matched$shift_order5 <- ifelse(data_shift_matched$num_orders==5, 1, 0)
data_shift_matched$shift_order6 <- ifelse(data_shift_matched$num_orders==6, 1, 0)
data_shift_matched$shift_order7 <- ifelse(data_shift_matched$num_orders==7, 1, 0)
data_shift_matched$shift_order8 <- ifelse(data_shift_matched$num_orders==8, 1, 0)
data_shift_matched$shift_order9 <- ifelse(data_shift_matched$num_orders==9, 1, 0)
data_shift_matched$shift_order10more <- ifelse(data_shift_matched$num_orders>=10, 1, 0)

mean(data_shift_matched$avg_waiting[data_shift_matched$After==1 & data_shift_matched$Treat==0])/60 #14.54573분

model <- felm(ln(avg_waiting) ~ After:Treat + 
                After:Treat:shift_order2 + After:Treat:shift_order3 + After:Treat:shift_order4 + After:Treat:shift_order5 +
                After:Treat:shift_order6 + After:Treat:shift_order7 + After:Treat:shift_order8 + After:Treat:shift_order9 + 
                After:Treat:shift_order10more | rider_id + station_date + hourDOW + num_orders | 0 | rider_id, data=data_shift_matched)
summary(model) #AI도입시 단건배송의 경우 고객대기시간 2분감소, 2건 합배송 0.

model_check <- glht(model, linfct = c("After:Treat + After:Treat:shift_order2 = 0")); summary(model_check)

