##### Matching data 준비 #####
### 2020-11-26 끝까지 탈퇴안한 라이더: 533명 추출 (01_Data Check and Cleansing에서 이어짐)
data_match <- data_2m %>% filter(rider_id %in% rider_existlast$rider_id) %>%
  filter(date<="2020-11-26")
length(unique(data_match$rider_id)); length(unique(data_match$management_partner_id)); length(unique(data_match$date))  
# 820,728건, 62일, 533명 라이더, 27개 지점

### pretreatment 데이터 추출
data_match_pre <- data_match %>% filter(date < "2020-10-26")
unique(data_match_pre$date) # pretreatment period: 30 days (2020-09-26 ~ 2020-10-25)





##### Matching covariates 만들기
### 평균 배차/픽업/배달 소요시간
pre_var <- data_match_pre %>% 
  group_by(rider_id) %>% 
  summarise(avg_assign = mean(assign_sec), avg_pickup = mean(pickup_sec), avg_deliver = mean(delivery_sec), avg_total_deliver=mean(waiting_sec))
hist(pre_var$avg_assign, breaks=533, main = "Avg. assign duration", xlab="avg_assign", xlim=c(0,1400))
hist(pre_var$avg_pickup, breaks=533, main = "Avg. pickup duration", xlab="avg_pickup")
hist(pre_var$avg_deliver, breaks=533, main = "Avg. deliver duration", xlab="avg_deliver", xlim=c(0,1400))
hist(pre_var$avg_total_deliver, breaks=533, main = "Avg. assign to deliver duration", xlab="avg_assign_to_deliver", xlim=c(0,1400))

# avg_assign<6 or >400, avg_pickup<30 or >1200, avg_deliver<10, avg_total_deliver<200 삭제

### 평균 배달 직선거리
test <- data_match_pre %>% 
  group_by(rider_id) %>% 
  summarise(avg_ODdist = mean(distorigintodest))

pre_var <- left_join(pre_var, test)

hist(pre_var$avg_ODdist, breaks=533, main = "Avg. OD distance", xlab="avg_OD_distance", xlim=c(0.5,3))


### 하루 평균 배달 상점수, 배달 상점 프랜차이즈 비율
test <- data_match_pre %>% 
  group_by(rider_id, date) %>%
  summarise(num_delivered_stores = length(unique(store_id)),
            share_franchise_store = length(unique(store_id[franchise_name != ""]))/num_delivered_stores) %>%
  group_by(rider_id) %>%
  summarise(daily_delivered_stores = mean(num_delivered_stores),
            daily_franchise_share = mean(share_franchise_store))

hist(test$daily_delivered_stores, breaks=533, main = "Number of daily delivered stores", xlab="Number of stores")
hist(test$daily_franchise_share, breaks=533, main = "Share of franchise stores among daily delivered stores", xlab="Share of franchise stores")

pre_var <- left_join(pre_var, test)


### 노동 시간대 수, 피크/오프피크 시간대 비율
# 피크/오프피크 정의 (점심: 11-13시, 저녁: 17-20시)
test <- data_match_pre %>% group_by(date,hour) %>% summarise(n=n()) %>% group_by(hour) %>% summarise(n=mean(n))
plot(test$hour,test$n,type='l', main = "Hourly avg. orders", xlab="Hour of day", ylab="Avg. hourly orders")

data_match_pre <- data_match_pre %>% mutate(peak=ifelse(hour %in% c(11,12,13,17,18,19,20),1,0))

# 변수 만들기
test <- data_match_pre %>% 
  group_by(rider_id, date) %>%
  summarise(num_working_period = length(unique(hour)),
            num_peak_working = length(unique(hour[peak==1])),
            share_peak = num_peak_working/num_working_period) %>%
  group_by(rider_id) %>%
  summarise(avg_working_period = mean(num_working_period),
            avg_share_peak = mean(share_peak))

hist(test$avg_working_period, breaks=533, main = "Avg working hours in a day", xlab="Number of working hours")
hist(test$avg_share_peak, breaks=533, main = "Share of peak working hours in a day", xlab="Share of peak working hours")

pre_var <- left_join(pre_var, test)


### 주간 노동 일수
# 주, 요일 정의
data_match_pre <- data_match_pre %>% mutate(week=week(date),
                                            DOW=wday(date),
                                            weekdays=ifelse(DOW %in% c(2:6),1,0))
unique(data_match_pre$week) # 39, 40, 41, 42, 43주
unique(data_match_pre$date[data_match_pre$week==39]) # 2020-09-26~2020-09-29; 4일
unique(data_match_pre$date[data_match_pre$week==40]) # 2020-09-30~2020-10-06; 7일
unique(data_match_pre$date[data_match_pre$week==43]) # 2020-10-21~2020-10-25; 5일

# 변수 만들기
test <- data_match_pre %>% filter(week %in% c(40:42)) %>%
  group_by(rider_id, week) %>%
  summarise(num_working_days = length(unique(date)),
            share_weekdays = length(unique(date[weekdays==1]))/num_working_days)
test <- test %>% group_by(rider_id) %>%
  summarise(num_working_days = mean(num_working_days),
            share_weekdays = mean(share_weekdays))

pre_var <- left_join(pre_var, test)

hist(test$num_working_days, breaks=533, main = "Avg. working days in a week", xlab="Number of working days")
hist(test$share_weekdays, breaks=533, main = "Share of working weekdays in a week", xlab="Share of weekdays")


### 시간당 배달건수
test <- data_match_pre %>% 
  mutate(deliver_hour = hour(deliveredat)) %>%
  group_by(rider_id, date, deliver_hour) %>% 
  summarise(hourly_orders = n()) %>%
  group_by(rider_id, deliver_hour) %>%
  summarise(avg_hourly_orders = mean(hourly_orders))
  
test <- test %>% group_by(rider_id) %>%
  summarise(avg_orders_min = min(avg_hourly_orders),
            avg_orders_mean = mean(avg_hourly_orders),
            avg_orders_max = max(avg_hourly_orders))

hist(test$avg_orders_min, breaks=533)
hist(test$avg_orders_mean, breaks=533)
hist(pre_var$avg_orders_max, breaks=533, main = "Avg orders in main working hour", xlab="Number of orders")

pre_var <- left_join(pre_var, test)

# avg_orders_max > 15 제거


### 피크/오프피크 시간당 배달 건수
test <- data_match_pre %>%
  mutate(deliver_hour = hour(deliveredat)) %>%
  group_by(rider_id, date, deliver_hour,peak) %>% 
  summarise(hourly_orders = n()) %>%
  group_by(rider_id, date, peak) %>%
  summarise(avg_peak_orders = mean(hourly_orders))
test_peak <- test %>% filter(peak==1) %>% group_by(rider_id) %>% summarise(avg_peak_orders = mean(avg_peak_orders))
test_offpeak <- test %>% filter(peak==0) %>% group_by(rider_id) %>% summarise(avg_offpeak_orders = mean(avg_peak_orders))

pre_var <- left_join(pre_var, test_peak) %>% left_join(test_offpeak)
pre_var$avg_peak_orders <- ifelse(is.na(pre_var$avg_peak_orders)==1,0,pre_var$avg_peak_orders)
pre_var$avg_offpeak_orders <- ifelse(is.na(pre_var$avg_offpeak_orders)==1,0,pre_var$avg_offpeak_orders)

remove(test_peak, test_offpeak)

hist(pre_var$avg_peak_orders, breaks=533, main="Avg orders in peak hours", xlab="Number of orders")
hist(pre_var$avg_offpeak_orders, breaks=533, main="Avg orders in offpeak hours", xlab="Number of orders")


### 부릉 서비스 경력
data_match_pre$created_at <- as.Date(data_match_pre$created_at)
data_match_pre <- data_match_pre %>% mutate(tenure = as.numeric(as.Date("2020-10-26")-created_at))
summary(data_match_pre$tenure)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.0   110.0   261.0   334.7   515.0  1151.0 

test <- data_match_pre %>% group_by(rider_id) %>% summarise(tenure = unique(tenure))

pre_var <- left_join(pre_var, test)

hist(pre_var$tenure, breaks=533, main = "Tenure in Vroong", xlab="Tenure (days)")


### 주 활동 지점
test <- data_match_pre %>%
  group_by(rider_id, management_partner_id) %>%
  summarise(n=n()) 
test1 <- test %>%
  group_by(rider_id) %>%
  summarise(n = max(n),
            check = 1)

test <- left_join(test,test1) %>% filter(check==1)
remove(test1)

pre_var <- left_join(pre_var, test[,1:2])
pre_var$management_partner_id <- as.factor(pre_var$management_partner_id)

summary(pre_var$management_partner_id)


### 배차~배달 평균시간
test <- data_match_pre %>% mutate(assigndeliver = as.numeric(deliveredat-assignedat))
hist(test$assigndeliver, xlim=c(1000,5000)) 

test <- data_match_pre %>% mutate(assigndeliver = as.numeric(deliveredat-assignedat)) %>%
  group_by(rider_id)



##### Treat/Control 변수 #####
head(data_match)

treat_riders <- data_match %>% group_by(rider_id) %>%
  summarise(total_orders = n(),
            ai_completed_orders = sum(is_rec_completed)) %>%
  filter(ai_completed_orders>=1) # 처치군: 369명, 통제군: 164명

data_match <- data_match %>% mutate(Treat=ifelse(rider_id %in% treat_riders$rider_id,1,0))
data_match_pre <- data_match_pre %>% mutate(Treat=ifelse(rider_id %in% treat_riders$rider_id,1,0))
pre_var <- pre_var %>% mutate(Treat=ifelse(rider_id %in% treat_riders$rider_id,1,0))
pre_var <- data.frame(pre_var)

length(unique(data_match$rider_id[data_match$Treat==1]))



##### 매칭 전 Outlier 제거 #####
# avg_assign<6 or >600, avg_pickup<30 or >1200, avg_deliver<10, avg_total_deliver<200 제거
# avg_orders_max > 15제거

pre_var <- pre_var %>% filter(avg_assign>6 & avg_assign<600) %>%
  filter(avg_pickup>30 & avg_pickup<1200) %>%
  filter(avg_deliver>10) %>%
  filter(avg_total_deliver>200) %>% 
  filter(avg_orders_max<15) # 533명 라이더중, 7명 제거: 526명


##### PSM #####
library(MatchIt); library(knitr)
head(data_match)
head(pre_var)





##### CEM #####
library(cem)
#pre_var <- data.frame(na.omit(pre_var))

### w/o NA var
pre_var_nona <- na.omit(pre_var) # 514명

### Calculate imbalance 
tr <- which(pre_var$Treat==1); ct <- which(pre_var$Treat==0)
ntr <- length(tr); nct <- length(ct)

var <- colnames(pre_var[,c(2,3,4,7,13)])
imbalance(group=pre_var$Treat, data=pre_var[var])

### Calculate tval
t.test(data=pre_var_nona, avg_assign~Treat) #pval=0.223
t.test(data=pre_var_nona, avg_pickup~Treat) #pval=0.000
t.test(data=pre_var_nona, avg_deliver~Treat) #pval=0.010
t.test(data=pre_var_nona, avg_total_deliver~Treat) #pval=0.000
t.test(data=pre_var_nona, avg_ODdist~Treat) #pval=0.100
#t.test(data=pre_var_nona, daily_delivered_stores~Treat) #pval=0.490
#t.test(data=pre_var_nona, daily_franchise_share~Treat) #pval=0.180
t.test(data=pre_var_nona, avg_working_period~Treat) #pval=0.000
t.test(data=pre_var_nona, avg_share_peak~Treat) #pval=0.222
t.test(data=pre_var_nona, num_working_days~Treat) #pval=0.001
#t.test(data=pre_var_nona, share_weekdays~Treat) #pval=0.310
#t.test(data=pre_var_nona, avg_orders_min~Treat) #pval=0.342
#t.test(data=pre_var_nona, avg_orders_mean~Treat) #pval=0.184
t.test(data=pre_var_nona, avg_orders_max~Treat) #pval=0.17
t.test(data=pre_var_nona, avg_peak_orders~Treat) #pval=0.141
#t.test(data=pre_var_nona, avg_offpeak_orders~Treat) #pval=0.261
t.test(data=pre_var_nona, tenure~Treat) #pval=0.016

#lapply(pretreat_cov, function(v) {
#  t.test(pretreat[, v] ~ pretreat[, 'AIintro'])
#})


### correlation btw variables
corr_tab <- correlation(pre_var_nona[,c(2,3,4,7,13)])


### matching covariates
mat_cov <- pre_var_nona
mat_cov <- mat_cov[,c(2,3,4,7,13,18)] # 변수 많이 포함시키면 matching이 안됨


### Automated coarsening
mat <- cem(treatment = "Treat", data=mat_cov, keep.all=TRUE)
mat


### Coarsening by myself
#avg_assign 쪼개기
mat$breaks$avg_assign
summary(pre_var_nona$avg_assign)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#9.017  42.926  66.270  85.087 108.811 551.529
hist(pre_var_nona$avg_assign, breaks = 516, main = "Avg. assign duration", xlab="Assign duration")
assign_cut <- c(0,42.926,66.270,85.087,108.811,552)

#avg_pickup 쪼개기
mat$breaks$avg_pickup
summary(pre_var_nona$avg_pickup)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#129.1   376.1   552.4   527.6   683.5   944.4 
hist(pre_var_nona$avg_pickup, breaks = 516, main = "Avg. pickup duration", xlab="Pickup duration")
pickup_cut <- c(0,129.1, 376.1, 527.6,683.5,945)

hist(pre_var_nona$avg_deliver, breaks = 516, main = "Avg. deliver duration", xlab="Deliver duration")
# tenure도 tier를 나눌수있음
#sum(mat_cov$tenure<=30);sum(mat_cov$tenure>30 & mat_cov$tenure<=60);sum(mat_cov$tenure>60 & mat_cov$tenure<=90);
#sum(mat_cov$tenure>90 & mat_cov$tenure<=120);sum(mat_cov$tenure>120 & mat_cov$tenure<=150);sum(mat_cov$tenure>150 & mat_cov$tenure<=180)
#sum(mat_cov$tenure>180 & mat_cov$tenure<=210);sum(mat_cov$tenure>210 & mat_cov$tenure<=240);sum(mat_cov$tenure>240 & mat_cov$tenure<=270)
#tenure_cut <- c(0,30,180,1152)

# avg_total_deliver tier
mat$breaks$avg_total_deliver
summary(pre_var_nona$avg_total_deliver)
hist(pre_var_nona$avg_total_deliver, breaks = 516)
totaldeliver_cut <- c(0,700,900,1100,1300,1500,1752)

# avg_working_period tier
mat$breaks$avg_working_period
summary(pre_var_nona$avg_working_period)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1.000   5.605   7.809   7.588   9.687  14.357 
hist(pre_var_nona$avg_working_period, breaks = 516, main="Avg working hour in a day", xlab="Number of hours")
workperiod_cut <- c(1,5.605,7.588,9.687,15)

# avg_orders_max tier
mat$breaks$avg_orders_max
summary(pre_var_nona$avg_orders_max)
hist(pre_var_nona$avg_orders_max, breaks = 516, main="Max performed orders in an hour", xlab="Number of orders")
ordersmax_cut <- c(1,4.375,5.300,6.190,11)

# matching
mat <- cem(treatment = "Treat", data=mat_cov, cutpoints = list(avg_assign=assign_cut,
                                                               avg_pickup=pickup_cut,
                                                               avg_working_period=workperiod_cut,
                                                               avg_orders_max=ordersmax_cut))
mat

### Progressive coarsening
tab <- relax.cem(mat, pre_var_rev, depth=1, perc = 0.3)



### Matching covariate data after matching
mat_result <- pre_var_nona %>% 
  mutate(mstrata = mat$mstrata,
         matched = mat$matched) %>%
  filter(matched==1)


### T-test after matching #####
t.test(data=mat_result, avg_assign~Treat) #pval=0.223 -> 0.125
t.test(data=mat_result, avg_pickup~Treat) #pval=0.000 -> 0.006
t.test(data=mat_result, avg_deliver~Treat) #pval=0.010 -> 0.310
t.test(data=mat_result, avg_total_deliver~Treat) #pval=0.000 -> 0.012
t.test(data=mat_result, avg_ODdist~Treat) #pval=0.100 -> 0.601
t.test(data=mat_result, daily_delivered_stores~Treat) #pval=0.490 -> 0.596
t.test(data=mat_result, daily_franchise_share~Treat) #pval=0.180 -> 0.658
t.test(data=mat_result, avg_working_period~Treat) #pval=0.000 -> 0.00
t.test(data=mat_result, avg_share_peak~Treat) #pval=0.222 -> 0.005
t.test(data=mat_result, num_working_days~Treat) #pval=0.001 -> 0.025
t.test(data=mat_result, share_weekdays~Treat) #pval=0.310 -> 0.126
t.test(data=mat_result, avg_orders_min~Treat) #pval=0.342 -> 0.256
t.test(data=mat_result, avg_orders_mean~Treat) #pval=0.184 -> 0.570
t.test(data=mat_result, avg_orders_max~Treat) #pval=0.17 -> 0.489
t.test(data=mat_result, avg_peak_orders~Treat) #pval=0.141 -> 0.254
t.test(data=mat_result, avg_offpeak_orders~Treat) #pval=0.261 -> 0.784
t.test(data=mat_result, tenure~Treat) #pval=0.016 -> 0.016





##### Model estimation after matching 1 #####
### 매칭된 라이더 데이터만 추출
data_matching_aft <- data_match %>% filter(rider_id %in% mat_result$rider_id)
### proficiency 변수 추가
test<-unique(data_ols_tenure[,c(3,50,51)]) # max_hourly_orders, tenure
data_matching_aft <- left_join(data_matching_aft, test)
head(data_matching_aft)

length(unique(data_matching_aft$rider_id[data_matching_aft$Treat==1]))

### After variable
data_matching_aft$after <- ifelse(data_matching_aft$date >="2020-10-26",1,0)


### DID model
data_matching_aft[,c(2,3,42)] <- lapply(data_matching_aft[,c(2,3,42)],function(x) as.factor(x))
model <- felm(ln(assign_sec+1) ~ after:Treat | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_matching_aft)
summary(model)
model <- felm(ln(pickup_sec+1) ~ after:Treat | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_matching_aft)
summary(model)
model <- felm(ln(delivery_sec+1) ~ after:Treat | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_matching_aft)
summary(model)
model <- felm(ln(distorigintodest+1) ~ after:Treat | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_matching_aft)
summary(model)

model <- felm(ln(assign_sec+1) ~ after*Treat*max_hourly_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_matching_aft)
summary(model)




