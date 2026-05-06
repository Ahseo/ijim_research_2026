#####################################################################################################################
########################## DID + matching ("01_Data check and cleansing.R"에서 이어짐)###############################
#####################################################################################################################

# 1. Data Preparation (order-level, shift-level, day-level)
#####################################################################################################################
##### Order-level data: "datap_order" #####
#####################################################################################################################
### data_2m_preexist를 data_order로 사용
datap_order <- data_2m_preexist # from "01_Data check and cleansing.R"
datap_order <- data.frame(datap_order)
remove(data_2m_preexist)

### data_order 데이터 체크
head(datap_order)
summary(datap_order)
nrow(datap_order); length(unique(datap_order$rider_id)); length(unique(datap_order$management_partner_id)); length(unique(datap_order$date))  
# 데이터기간 2020-09-26~2020-11-30: 66일, 739,491건, 28개 지점, 581명 라이더


### 라이더별 지점 근무 현황
test <- datap_order %>% group_by(rider_id) %>% summarise(num_station = length(unique(management_partner_id)))
# 581명중 13명만 두개지점 근무, 나머지는 한지점 근무



### Treat/Control, After 변수
head(datap_order)

treatp_riders <- datap_order %>% group_by(rider_id) %>%
  summarise(total_orders = n(),
            ai_completed_orders = sum(is_rec_completed),
            adopt_date = min(date[is_rec_completed==1]),
            share_aiorder = ai_completed_orders/total_orders) %>%
  filter(ai_completed_orders>=1) # 처치군: 382명, 통제군: 199명
str(treatp_riders)
hist(treatp_riders$share_aiorder)

datap_order <- datap_order %>% mutate(Treat=ifelse(rider_id %in% treat_riders$rider_id,1,0),
                                    After=ifelse(date>="2020-10-26",1,0))


### rider_date, riderDOW
datap_order$rider_date <- paste(datap_order$rider_id, datap_order$date, sep="_")
datap_order$riderDOW <- paste(datap_order$rider_id, datap_order$DOW, sep="_")

### week dummies
unique(datap_order$date)
str(datap_order$date)

datap_order$date <- as.character(datap_order$date)
datap_order$wb5 <- ifelse(datap_order$date %in% c("2020-09-26", "2020-09-27"),1,0)
datap_order$wb4 <- ifelse(datap_order$date %in% c("2020-09-28", "2020-09-29", "2020-09-30", "2020-10-01", "2020-10-02", "2020-10-03", "2020-10-04"), 1, 0)
datap_order$wb3 <- ifelse(datap_order$date %in% c("2020-10-05", "2020-10-06", "2020-10-07", "2020-10-08", "2020-10-09", "2020-10-10", "2020-10-11"), 1, 0)
datap_order$wb2 <- ifelse(datap_order$date %in% c("2020-10-12", "2020-10-13", "2020-10-14", "2020-10-15", "2020-10-16", "2020-10-17", "2020-10-18"), 1, 0)
datap_order$wb1 <- ifelse(datap_order$date %in% c("2020-10-19", "2020-10-20", "2020-10-21", "2020-10-22", "2020-10-23", "2020-10-24", "2020-10-25"), 1, 0)
datap_order$w1 <- ifelse(datap_order$date %in% c("2020-10-26", "2020-10-27", "2020-10-28", "2020-10-29", "2020-10-30", "2020-10-31", "2020-11-01"), 1, 0)
datap_order$w2 <- ifelse(datap_order$date %in% c("2020-11-02", "2020-11-03", "2020-11-04", "2020-11-05", "2020-11-06", "2020-11-07", "2020-11-08"), 1, 0)
datap_order$w3 <- ifelse(datap_order$date %in% c("2020-11-09", "2020-11-10", "2020-11-11", "2020-11-12", "2020-11-13", "2020-11-14", "2020-11-15"), 1, 0)
datap_order$w4 <- ifelse(datap_order$date %in% c("2020-11-16", "2020-11-17", "2020-11-18", "2020-11-19", "2020-11-20", "2020-11-21", "2020-11-22"), 1, 0)
datap_order$w5 <- ifelse(datap_order$date %in% c("2020-11-23", "2020-11-24", "2020-11-25", "2020-11-26", "2020-11-27", "2020-11-28", "2020-11-28"), 1, 0)
datap_order$w6 <- ifelse(datap_order$date %in% c("2020-11-29", "2020-11-30"), 1, 0)
datap_order$date <- as.Date(datap_order$date)

### duration -> min단위로 변환
datap_order$assign_sec <- datap_order$assign_sec/60
datap_order$pickup_sec <- datap_order$pickup_sec/60
datap_order$delivery_sec <- datap_order$delivery_sec/60
datap_order$waiting_sec <- datap_order$waiting_sec/60

colnames(datap_order)[36:39]<-c("assign_min", "pickup_min", "delivery_min", "waiting_min")

#####################################################################################################################
##### shift-level data: data_shift#####
#####################################################################################################################
head(datap_order)

### 오더/추천배차 오더 관련 변수
datap_shift1 <- datap_order %>%
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
datap_shift2 <- datap_order %>%
  group_by(rider_id, Treat, management_partner_id, date, After, shift, rider_date) %>%
  summarise(start = assignedat[which(row_number()==1)], # 한 shift내 첫 주문 배차시각
            finish = max(deliveredat), # 한 shift내 마지막 주문 배달완료시각
            total_duration = as.numeric(as.difftime(finish - start), units="mins")) # 한 shift 전체 길이
summary(datap_shift2$total_duration)
### data merge
datap_shift <- left_join(datap_shift1,datap_shift2)
remove(datap_shift1,datap_shift2)


### idle time
idletimes <- function(c1,c2){return(c(NA, as.numeric(as.difftime(tail(c1,-1)-head(c2,-1)), units="mins")))} # 한 shift를 끝내고 다음 shift를 시작하기까지 걸린시간
datap_shift <- datap_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, rider_date) %>%
  mutate(idle_btw_shifts = idletimes(start,finish))
summary(datap_shift$idle_btw_shifts)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#   0.017   1.667   4.783  16.893  13.383 653.667   25352 

hist(datap_shift$idle_btw_shifts, breaks=10000)
sum(datap_shift$idle_btw_shifts>60, na.rm=T) # 30분이상:약 11.9%, 1시간이상: 약 6.2%, 2시간이상: 약 2.5%

# idle time이 1시간 이상인 경우 NA 처리 (분석에 고려하지않음)
datap_shift$idle_btw_shifts <- ifelse(datap_shift$idle_btw_shifts>60,NA,datap_shift$idle_btw_shifts) #NA=41038
summary(datap_shift$idle_btw_shifts)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#    0.02    1.50    4.20    8.60   10.45   60.00   41038 
   

# avg. duration per order
datap_shift$avg_duration_orders <- datap_shift$total_duration/datap_shift$num_orders

# AI assisted dummies
datap_shift$ai_assist <- ifelse(datap_shift$num_aiorders==0,0,1)

# additional columns: station_date, start_hour, hourDOW, riderDOW
datap_shift$station_date <- paste(datap_shift$management_partner_id, datap_shift$date, sep="_")
datap_shift$start_hour <- hour(datap_shift$start)


# hourDOW
datap_shift <- datap_shift %>% mutate(wday = wday(date),
                                    hourDOW = paste(start_hour, wday, sep="_"))
colnames(datap_shift)

# riderDOW
datap_shift <- datap_shift %>% mutate(riderDOW = paste(rider_id, wday, sep="_"))
length(unique(datap_shift$riderDOW))

# number of stacked orders in previous shift
datap_shift <- datap_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, rider_date) %>% 
  mutate(pre_shift_orders = lag(num_orders))

### week dummies
unique(datap_shift$date)
str(datap_shift$date)

datap_shift$date <- as.character(datap_shift$date)
datap_shift$wb5 <- ifelse(datap_shift$date %in% c("2020-09-26", "2020-09-27"),1,0)
datap_shift$wb4 <- ifelse(datap_shift$date %in% c("2020-09-28", "2020-09-29", "2020-09-30", "2020-10-01", "2020-10-02", "2020-10-03", "2020-10-04"), 1, 0)
datap_shift$wb3 <- ifelse(datap_shift$date %in% c("2020-10-05", "2020-10-06", "2020-10-07", "2020-10-08", "2020-10-09", "2020-10-10", "2020-10-11"), 1, 0)
datap_shift$wb2 <- ifelse(datap_shift$date %in% c("2020-10-12", "2020-10-13", "2020-10-14", "2020-10-15", "2020-10-16", "2020-10-17", "2020-10-18"), 1, 0)
datap_shift$wb1 <- ifelse(datap_shift$date %in% c("2020-10-19", "2020-10-20", "2020-10-21", "2020-10-22", "2020-10-23", "2020-10-24", "2020-10-25"), 1, 0)
datap_shift$w1 <- ifelse(datap_shift$date %in% c("2020-10-26", "2020-10-27", "2020-10-28", "2020-10-29", "2020-10-30", "2020-10-31", "2020-11-01"), 1, 0)
datap_shift$w2 <- ifelse(datap_shift$date %in% c("2020-11-02", "2020-11-03", "2020-11-04", "2020-11-05", "2020-11-06", "2020-11-07", "2020-11-08"), 1, 0)
datap_shift$w3 <- ifelse(datap_shift$date %in% c("2020-11-09", "2020-11-10", "2020-11-11", "2020-11-12", "2020-11-13", "2020-11-14", "2020-11-15"), 1, 0)
datap_shift$w4 <- ifelse(datap_shift$date %in% c("2020-11-16", "2020-11-17", "2020-11-18", "2020-11-19", "2020-11-20", "2020-11-21", "2020-11-22"), 1, 0)
datap_shift$w5 <- ifelse(datap_shift$date %in% c("2020-11-23", "2020-11-24", "2020-11-25", "2020-11-26", "2020-11-27", "2020-11-28", "2020-11-28"), 1, 0)
datap_shift$w6 <- ifelse(datap_shift$date %in% c("2020-11-29", "2020-11-30"), 1, 0)
datap_shift$date <- as.Date(datap_shift$date)

### data.frame화
datap_shift <- data.frame(datap_shift)



#####################################################################################################################
##### day-level data: data_day #####
#####################################################################################################################
head(datap_shift)

# 하루 shift 개수, 합배송 shift 비율, 합배송인 shift 내 평균 주문개수
datap_day1 <- datap_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>% 
  summarise(total_shift = n(),
            mean_orders_shift = mean(num_orders),
            mean_duration_shift = mean(total_duration),
            share_aggshift = length(which(num_orders>1))/total_shift,
            orders_stacked = sum(num_orders[num_orders>1]),
            orders_one = sum(num_orders[num_orders==1]),
            mean_orders_aggshift = mean(num_orders[num_orders>1]),
            mean_duration_aggshift = mean(total_duration[num_orders>1]),
            total_fee = sum(shift_profit)) #합배송 없는날 NA처리됨=1181


# 실노동시간(hour), 쉬는시간(hour), 실노동시간 비율, 전체 수행 주문개수/노동+쉬는시간 (1시간당 수행주문개수)
datap_day2 <- datap_shift %>% group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>% 
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
datap_day3 <- datap_order %>% group_by(rider_id, Treat, management_partner_id, date, After, station_date, rider_date) %>%
  summarise(avg_waiting = mean(waiting_min),
            sd_waiting = sd(waiting_min),
            var_waiting = var(waiting_min),
            share_failedorders = sum(waiting_min>30)/n())


# data merge
datap_day <- left_join(datap_day1,datap_day2) %>% left_join(datap_day3) %>% as.data.frame()
remove(datap_day1,datap_day2, datap_day3)

### week dummies
unique(datap_day$date)
str(datap_day$date)

datap_day$date <- as.character(datap_day$date)
datap_day$wb5 <- ifelse(datap_day$date %in% c("2020-09-26", "2020-09-27"),1,0)
datap_day$wb4 <- ifelse(datap_day$date %in% c("2020-09-28", "2020-09-29", "2020-09-30", "2020-10-01", "2020-10-02", "2020-10-03", "2020-10-04"), 1, 0)
datap_day$wb3 <- ifelse(datap_day$date %in% c("2020-10-05", "2020-10-06", "2020-10-07", "2020-10-08", "2020-10-09", "2020-10-10", "2020-10-11"), 1, 0)
datap_day$wb2 <- ifelse(datap_day$date %in% c("2020-10-12", "2020-10-13", "2020-10-14", "2020-10-15", "2020-10-16", "2020-10-17", "2020-10-18"), 1, 0)
datap_day$wb1 <- ifelse(datap_day$date %in% c("2020-10-19", "2020-10-20", "2020-10-21", "2020-10-22", "2020-10-23", "2020-10-24", "2020-10-25"), 1, 0)
datap_day$w1 <- ifelse(datap_day$date %in% c("2020-10-26", "2020-10-27", "2020-10-28", "2020-10-29", "2020-10-30", "2020-10-31", "2020-11-01"), 1, 0)
datap_day$w2 <- ifelse(datap_day$date %in% c("2020-11-02", "2020-11-03", "2020-11-04", "2020-11-05", "2020-11-06", "2020-11-07", "2020-11-08"), 1, 0)
datap_day$w3 <- ifelse(datap_day$date %in% c("2020-11-09", "2020-11-10", "2020-11-11", "2020-11-12", "2020-11-13", "2020-11-14", "2020-11-15"), 1, 0)
datap_day$w4 <- ifelse(datap_day$date %in% c("2020-11-16", "2020-11-17", "2020-11-18", "2020-11-19", "2020-11-20", "2020-11-21", "2020-11-22"), 1, 0)
datap_day$w5 <- ifelse(datap_day$date %in% c("2020-11-23", "2020-11-24", "2020-11-25", "2020-11-26", "2020-11-27", "2020-11-28", "2020-11-28"), 1, 0)
datap_day$w6 <- ifelse(datap_day$date %in% c("2020-11-29", "2020-11-30"), 1, 0)
datap_day$date <- as.Date(datap_day$date)

# riderDOW
datap_day$wday <- wday(datap_day$date)
datap_day <- datap_day %>% mutate(riderDOW = paste(rider_id, wday, sep="_"))
length(unique(datap_day$riderDOW))


# share of aiorders
datap_day$share_aiorders = ifelse(datap_day$Treat==1,datap_day$total_aiorders/datap_day$total_orders,NA)



#####################################################################################################################
##### 추천배차 도입 전 데이터에서, 전체 노동+idle 시간당 수행주문건수로 proficiency 변수 만들기 #####
#####################################################################################################################
proficiency_peak <- datap_day %>% filter(date<"2020-10-26") %>%
  group_by(rider_id) %>% summarise(prof = mean(orders_per_hour))
summary(proficiency_peak$prof)
hist(proficiency_peak$prof, breaks=500)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.934   3.976   4.570   4.684   5.375   8.546 

### 50
proficiency_peak <- proficiency_peak %>% mutate(prof_low50 = ifelse(prof<4.570,1,0),
                                      prof_high50 = ifelse(prof>=4.570,1,0))



### 33/33/33
quantile(proficiency_peak$prof, probs = c(.333, .667))
# 33.3%    66.7% 
#   4.156825 4.972134 

proficiency_peak <- proficiency_peak %>% mutate(prof_low = ifelse(prof<4.156825,1,0),
                                      prof_med = ifelse(prof>=4.156825 & prof<4.972134,1,0),
                                      prof_high = ifelse(prof>=4.972134,1,0))


#(15/70/15)
quantile(proficiency_peak$prof, probs = c(.15, .85))
# 15%      85% 
#   3.622097 5.830023
proficiency_peak <- proficiency_peak %>% mutate(prof_low15 = ifelse(prof<3.622097,1,0),
                                      prof_med70 = ifelse(prof>=3.622097 & prof<5.830023,1,0),
                                      prof_high15 = ifelse(prof>=5.830023,1,0))



datap_order <- left_join(datap_order,proficiency_peak)
datap_order_pre <- datap_order %>% filter(After==0)
datap_order_pre <- left_join(datap_order_pre,proficiency_peak)
datap_shift <- left_join(datap_shift,proficiency_peak)
datap_day <- left_join(datap_day, proficiency_peak)



#### Share of aiorders by riders 
# data_order <- left_join(data_order,treat_riders[,c(1,5)])
# data_order_pre <- left_join(data_order_pre,treat_riders[,c(1,5)])
# data_shift <- left_join(data_shift,treat_riders[,c(1,5)])
# data_day <- left_join(data_day,treat_riders[,c(1,5)])
# data_dayhour <- left_join(data_dayhour,treat_riders[,c(1,5)])


#####################################################################################################################
##### Pretreatment period data를 활용한 matching covariates 만들기
#####################################################################################################################

### pretreatment 데이터 추출
length(unique(datap_order_pre$date)) # pretreatment period: 30 days (2020-09-26 ~ 2020-10-25)

### 하루 평균 배달 상점수
pre_var_peak <- datap_order_pre %>% 
  group_by(rider_id, date) %>%
  summarise(num_delivered_stores = length(unique(store_id))) %>%
  group_by(rider_id) %>%
  summarise(daily_delivered_stores = mean(num_delivered_stores))

hist(pre_var_peak$daily_delivered_stores, breaks=533, main = "Number of daily delivered stores", xlab="Number of stores")




### 주간 노동 일수
# 주, 요일 정의
unique(data_order_pre$date) #2020-09-26 ~ 2020-10-25
datap_order_pre$date <- as.character(datap_order_pre$date)
datap_order_pre <- datap_order_pre %>% mutate(week = ifelse(date %in% c("2020-09-26"),1,
                                                          ifelse(date %in% c("2020-09-27","2020-09-28","2020-09-29","2020-09-30","2020-10-01","2020-10-02","2020-10-03"),2,
                                                                 ifelse(date %in% c("2020-10-04","2020-10-05","2020-10-06","2020-10-07","2020-10-08","2020-10-09","2020-10-10"),3,
                                                                        ifelse(date %in% c("2020-10-11","2020-10-12","2020-10-13","2020-10-14","2020-10-15","2020-10-16","2020-10-17"),4,
                                                                               ifelse(date %in% c("2020-10-18","2020-10-19","2020-10-20","2020-10-21","2020-10-22","2020-10-23","2020-10-24"),5,
                                                                                      ifelse(date %in% c("2020-10-25"),6,NA)))))))
datap_order_pre$date <- as.Date(datap_order_pre$date)


# 변수 만들기
test <- datap_order_pre %>% filter(week %in% c(2:5)) %>%
  group_by(rider_id, week) %>%
  summarise(num_working_days = length(unique(date))) %>% 
  group_by(rider_id) %>%
  summarise(num_working_days = mean(num_working_days))

pre_var_peak <- left_join(pre_var_peak, test)

hist(pre_var_peak$num_working_days, breaks=533, main = "Avg. working days in a week", xlab="Number of working days")



### 부릉 서비스 경력
datap_order_pre$created_at <- as.Date(datap_order_pre$created_at)
datap_order_pre <- datap_order_pre %>% mutate(tenure = as.numeric(as.Date("2020-10-26")-created_at))
summary(datap_order_pre$tenure)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 30.0   122.0   264.0   336.1   512.0  1151.0 

test <- datap_order_pre %>% group_by(rider_id) %>% summarise(tenure = unique(tenure))

pre_var_peak <- left_join(pre_var_peak, test)

hist(pre_var_peak$tenure, breaks=533, main = "Tenure in Vroong", xlab="Tenure (days)")



### shift내 평균 주문개수, duration, shift간 idle time, 주문1개당 소요시간
test <- datap_shift %>% filter(date<"2020-10-26") %>% 
  group_by(rider_id) %>% summarise(avg_assign_shift = mean(avg_assign),
                                   avg_pickup_shift = mean(avg_pickup),
                                   avg_deliver_shift = mean(avg_deliver),
                                   avg_waiting_shift = mean(avg_waiting),
                                   avg_dist_shift = mean(avg_dist, na.rm=T),
                                   avg_shift_profit = mean(shift_profit),
                                   avg_orders_shift = mean(num_orders),
                                   avg_duration_shift = mean(total_duration),
                                   avg_idle_shift = mean(idle_btw_shifts, na.rm=T),
                                   avg_duration_orders = mean(avg_duration_orders))
pre_var_peak <- left_join(pre_var_peak,test)


### 합배송 shift내 평균 주문개수, duration, idle time, order_level
test <- datap_shift %>% filter(date<"2020-10-26") %>% 
  group_by(rider_id) %>% summarise(avg_orders_aggshift = mean(num_orders[num_orders>1]),
                                   avg_duration_aggshift = mean(total_duration[num_orders>1]),
                                   avg_shift_order_level = mean(avg_order_level, na.rm=T),
                                   shift_sharefailed = mean(share_failed))

pre_var_peak <- left_join(pre_var_peak,test)

### 하루 평균 shift개수, 합배송 shift의 비율, 합배송 shift내 평균 주문개수, 
test <- datap_day %>% filter(date<"2020-10-26") %>% 
  group_by(rider_id) %>% summarise(daily_total_shift = mean(total_shift),
                                   daily_share_aggshift = mean(share_aggshift),
                                   daily_working_duration = mean(working_duration),
                                   daily_idle_duration = mean(idle_duration),
                                   daily_total_labor = mean(total_labor),
                                   daily_total_order = mean(total_orders),
                                   daily_share_workingd = mean(share_workingd),
                                   daily_share_idled = mean(share_idled),
                                   daily_orders_per_hour = mean(orders_per_hour),
                                   daily_profit = mean(total_fee),
                                   daily_sharefailed = mean(share_failedorders))

pre_var_peak <- left_join(pre_var_peak, test)



### Treat
pre_var_peak$Treat <- ifelse(pre_var_peak$rider_id %in% treatp_riders$rider_id, 1, 0)

### Proficiency
pre_var_peak <- left_join(pre_var_peak, proficiency_peak)





########################################################################################################################################################
##### Matching Preparation #####
########################################################################################################################################################
library(MatchIt); library(knitr)
head(pre_var_peak) # 앞에서 만든 라이더 특성변수 34개
summary(pre_var_peak) #584riders, 1 NA in num_working_days(도입전 기간은 10/25하루만 근무), 1 NA in avg_idle_shift/avg_orders_aggshift/avg_duration_aggshift(도입전 기간 합배송 없었던 경우)

##### Covarites #####
colnames(pre_var_peak)
# [1] "rider_id"               "daily_delivered_stores" "num_working_days"       "tenure"                 "avg_assign_shift"      
# [6] "avg_pickup_shift"       "avg_deliver_shift"      "avg_waiting_shift"      "avg_dist_shift"         "avg_shift_profit"      
# [11] "avg_orders_shift"       "avg_duration_shift"     "avg_idle_shift"         "avg_duration_orders"    "avg_orders_aggshift"   
# [16] "avg_duration_aggshift"  "avg_shift_order_level"  "shift_sharefailed"      "daily_total_shift"      "daily_share_aggshift"  
# [21] "daily_working_duration" "daily_idle_duration"    "daily_total_labor"      "daily_total_order"      "daily_share_workingd"  
# [26] "daily_share_idled"      "daily_orders_per_hour"  "daily_profit"           "daily_sharefailed"      "Treat"                 
# [31] "prof"                   "prof_low50"             "prof_high50"            "prof_low"               "prof_med"              
# [36] "prof_high"              "prof_low15"             "prof_med70"             "prof_high15" 
pretreat_cov_peak <- colnames(pre_var_peak[,c(2:4,8,11:16,19:28)])

pre_var_peak_nona <- na.omit(pre_var_peak) #576riders
pre_var_peak_nona <- as.data.frame(pre_var_peak_nona)




##### T-test before matching by Treat/control#####
test <- pre_var_peak_nona %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov_peak)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov_peak)), pvalue=rep(1,length(pretreat_cov_peak)))
for (i in 1:length(pretreat_cov_peak)){
  a<-t.test(pre_var_peak_nona[, pretreat_cov_peak[i]] ~ pre_var_peak_nona[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}




##### Propensity score estimation #####
pscore <- glm(Treat ~ daily_delivered_stores + num_working_days +
                avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_duration_orders +
                daily_total_shift + daily_total_order +
                daily_total_labor + daily_idle_duration, family = binomial(), data=pre_var_peak_nona)
summary(pscore)


### 유의한 변수들 찾기
test <- step(pscore, direction ="backward")
summary(test)

pscore1 <- glm(Treat ~ daily_delivered_stores + num_working_days + 
                 avg_assign_shift + avg_pickup_shift + avg_deliver_shift + avg_order_level +
                 daily_orders_per_hour + daily_total_shift + daily_idle_duration, 
               family = binomial(), data=pre_var_peak_nona)
summary(pscore1)

pscore1 <- glm(Treat ~ daily_delivered_stores + num_working_days + 
                 avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
                 daily_total_labor + daily_idle_duration, 
               family = binomial(), data=pre_var_peak_nona)
summary(pscore1)



### Save predicted propensity scrore
pscore_df <- data.frame(rider_id = pre_var_peak_nona$rider_id,
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
lines(density(pscore_df$pscore[pre_var_peak_nona$Treat==0]), lty=2)

#bal.plot(psmatch1, var.name = "distance", which = "both")





################################################################################################################################################
##### #1 Matching: PSM 1:1 matching with a caplier size 0.2 (or 0.05) times the s.d. of the propensity #####
################################################################################################################################################

#psmatch1 - 1:1 nearest matching with caliper 0.2 w/o replacement
#psmatch2 - 1:1 nearest matching with caliper 0.05 w/o replacement

### matching algorithm
psmatch1_peak <- matchit(Treat ~  daily_delivered_stores + num_working_days + 
                           avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
                           daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_peak_nona, caliper=0.2, std.caliper=TRUE, discard = "both")
summary(psmatch1_peak)

psmatch2_peak <- matchit(Treat ~  daily_delivered_stores + num_working_days + 
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_peak_nona, caliper=0.05, std.caliper=TRUE, discard = "both")
summary(psmatch2_peak)
#plot(psmatch1)

### matched data
matched_data <- match.data(psmatch2_peak)

### Distribution of predicted propensity scrore
pscore_df_matched <- pscore_df %>% filter(rider_id %in% matched_data$rider_id)

plot(density(pscore_df_matched$pscore[pscore_df_matched$Treat==0]), lty=2, main = "After matching", xlab = "Estimated propensity score")
lines(density(pscore_df_matched$pscore[pscore_df_matched$Treat==1]))
legend("topright",legend=c("Control","Treat"),lty=c(2,1))

#### Machted data에 대한 T-test #####
test <- matched_data %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov_peak)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov_peak)), pvalue=rep(1,length(pretreat_cov_peak)))
for (i in 1:length(pretreat_cov_peak)){
  a<-t.test(matched_data[, pretreat_cov_peak[i]] ~ matched_data[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}

##### 데이터 추출 #####
datap_order_matched <- datap_order %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,42)])
datap_shift_matched <- datap_shift %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,42)])
datap_day_matched <- datap_day %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,42)])

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
data_order_matched <- data_order %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])
data_shift_matched <- data_shift %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])
data_day_matched <- data_day %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])


################################################################################################################################################
##### #3 PSM with replacement under a caplier size 0.2 (or 0.05) times the s.d. of the propensity #####
##### (whether treated can be used as matches for more than one control individual)
################################################################################################################################################

# psmatch5: PSM with 1:1 replacement under a caplier size 0.01

### Treat_rev: control-treat 1:1 매칭을 위해 control==1, treat==0 배정
pre_var_nona <- pre_var_nona %>% mutate(Treat_rev = ifelse(Treat==1,0,1))

### matching algorithm
psmatch5 <- matchit(Treat_rev ~  daily_delivered_stores + num_working_days + 
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.01, std.caliper=TRUE, replace = TRUE, discard = "both")
summary(psmatch5)


### matched data
matched_data <- match.data(psmatch5)

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
data_order_matched <- data_order %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,48)])
data_shift_matched <- data_shift %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,48)])
data_day_matched <- data_day %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,48)])
data_dayhour_matched <- data_dayhour %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,48)])

################################################################################################################################################
##### #4 PSM 1:n matching #####
################################################################################################################################################

#psmatch6: PSM 1:2 matching w/ replacement, caliper 0.01
### matching algorithm
psmatch6 <- matchit(Treat_rev ~  daily_delivered_stores + num_working_days + 
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.01, std.caliper=TRUE, discard = "both", ratio = 2, replace = TRUE)
summary(psmatch6)


### matched data
matched_data <- match.data(psmatch6)

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
data_order_matched <- data_order %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,48)])
data_shift_matched <- data_shift %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,48)])
data_day_matched <- data_day %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,48)])
data_dayhour_matched <- data_dayhour %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,48)])


################################################################################################################################################
##### # Mahalanobis matching #####
################################################################################################################################################

#psmatch8

### matching algorithm
psmatch7 <- matchit(Treat ~  daily_delivered_stores + num_working_days + 
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
                      daily_total_labor + daily_idle_duration,
                    method="nearest", data=pre_var_nona, caliper=0.01, std.caliper=TRUE, discard = "both",
                    mahvars = ~ daily_delivered_stores + num_working_days + 
                      avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
                      daily_total_labor + daily_idle_duration)
summary(psmatch7)


### matched data
matched_data <- match.data(psmatch7)

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
data_order_matched <- data_order %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])
data_shift_matched <- data_shift %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])
data_day_matched <- data_day %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])
data_dayhour_matched <- data_dayhour %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,49)])


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

model <- felm(ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)



test<-datap_shift_matched %>% filter(num_orders == 1)
model <- felm(ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)



test<-datap_shift_matched %>% filter(num_orders >= 2)
model <- felm(ln(avg_waiting) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)





model <- felm(ln(avg_assign+1) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)
model <- felm(ln(avg_assign+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)



model <- felm(ln(avg_pickup+1) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)
model <- felm(ln(avg_pickup+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)



model <- felm(ln(avg_deliver+1) ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)
model <- felm(ln(avg_deliver+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high + avg_dist | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)



model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)



model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)




model <- felm(ln(avg_duration_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)



test<-datap_shift_matched %>% filter(num_orders == 1)
model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-datap_shift_matched %>% filter(num_orders >=2)
model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-datap_shift_matched %>% filter(num_orders >=2)
model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)




test<-datap_shift_matched %>% filter(num_orders >=2)
model <- felm(ln(avg_duration_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)



model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high| rider_id + station_date + hourDOW | 0 | riderDOW, data=datap_shift_matched)
summary(model)



test<-datap_shift_matched %>% filter(pre_shift_orders == 1)
model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high| rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)


test<-datap_shift_matched %>% filter(pre_shift_orders >= 2)
model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high| rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)





########################################################################################################################
head(data_day_matched)

model <- felm(ln(total_orders) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(ln(total_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)




model <- felm(ln(total_shift) ~ After:Treat | rider_id + date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(ln(total_shift) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)



model <- felm(share_aggshift ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(share_aggshift ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)



model <- felm(ln(orders_stacked+1) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(ln(orders_stacked+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)




model <- felm(ln(orders_one+1) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(ln(orders_one+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)




model <- felm(ln(working_duration) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(ln(working_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=datap_day_matched)
summary(model)


model <- felm(ln(idle_duration+1) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(ln(idle_duration+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=datap_day_matched)
summary(model)


model <- felm(ln(total_labor) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(ln(total_labor) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + management_partner_id + date | 0 | riderDOW, data=datap_day_matched)
summary(model)




model <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(share_idled ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)




model <- felm(ln(orders_per_hour) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)
model <- felm(ln(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)



model <- felm(ln(total_fee) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=datap_day_matched)
summary(model)
model <- felm(ln(total_fee) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=datap_day_matched)
summary(model)



model <- felm(ln(avg_waiting) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=datap_day_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)



model <- felm(ln(var_waiting) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=datap_day_matched)
summary(model)
model <- felm(ln(var_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | riderDOW, data=datap_day_matched)
summary(model)


model <- felm(share_failedorders ~ After:Treat | rider_id + station_date | 0 | rider_id, data=datap_day_matched)
summary(model)
model <- felm(share_failedorders ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=datap_day_matched)
summary(model)





################################################################################################################################################
##### DID, DDD model estimation - Weekly #####
################################################################################################################################################
####################################################################################################################################
head(data_shift_matched)

model <- felm(ln(orders_per_hour) ~ Treat:wb5 + Treat:wb4 + Treat:wb3 + Treat:wb2 +
                Treat:w1 + Treat:w2 + Treat:w3 + Treat:w4 + Treat:w5 + Treat:w6 | rider_id + station_date  | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(orders_per_hour) ~ Treat:wb4:prof_low + Treat:wb3:prof_low + Treat:wb2:prof_low + Treat:wb1:prof_low +
                Treat:w1:prof_low + Treat:w2:prof_low + Treat:w3:prof_low + Treat:w4:prof_low + Treat:w5:prof_low + Treat:w6:prof_low +
                Treat:wb4:prof_med + Treat:wb3:prof_med + Treat:wb2:prof_med + Treat:wb1:prof_med +
                Treat:w1:prof_med + Treat:w2:prof_med  + Treat:w3:prof_med  + Treat:w4:prof_med  + Treat:w5:prof_med  + Treat:w6:prof_med  +
                Treat:wb4:prof_high + Treat:wb3:prof_high + Treat:wb2:prof_high + Treat:wb1:prof_high +
                Treat:w1:prof_high + Treat:w2:prof_high  + Treat:w3:prof_high  + Treat:w4:prof_high  + Treat:w5:prof_high  + Treat:w6:prof_high +
                wb4:prof_med + wb3:prof_med + wb2:prof_med + wb1:prof_med +
                w1:prof_med + w2:prof_med + w3:prof_med + w4:prof_med + w5:prof_med + w6:prof_med +
                wb4:prof_high + wb3:prof_high + wb2:prof_high + wb1:prof_high +
                w1:prof_high + w2:prof_high + w3:prof_high + w4:prof_high + w5:prof_high + w6:prof_high| rider_id + station_date  | 0 | rider_id, data=datap_day_matched)
summary(model)





