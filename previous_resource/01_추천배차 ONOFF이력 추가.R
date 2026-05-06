################################################################################################################
##### ON/OFF data  #####
################################################################################################################
### Read ON/OFF history data
rec_change <- fread("210330_rider_order_rec_change_logs.csv") #397,026rows

rec_change <- rec_change[,-2:-3]
colnames(rec_change) <- c("rider_id","timestamp","assign_type")
length(unique(rec_change$rider_id)) #15371riders


### assign_type: 1(추천배차;auto)/0(일반배차;manual)
rec_change <- rec_change %>% mutate(type_auto = ifelse(assign_type=="AUTO",1,0))
rec_change <- rec_change[,-3]

### timestamp modification
rec_change <- rec_change %>% mutate(time = ymd_hms(timestamp))
rec_change <- rec_change[,-2]

rec_change <- rec_change %>% mutate(date = as.Date(time))


### 우리가 보려고하는 두달 내 존재하는 라이더 및 추천배차 도입 이후날짜 데이터만 subtract
length(unique(data_2m$rider_id)) #940 riders
rider_2m <- data.frame(rider_id = unique(data_2m$rider_id))

rec_change <- rec_change %>%  filter(rider_id %in% rider_2m$rider_id) %>%
  filter(date>="2020-10-26") #69,078rows
length(unique(rec_change$rider_id)) #893riders



### 추천배차 켜놓은 경우에 대해, 켜놓은 시간 duration 및 끈 시간 컬럼 만들기
rec_change <- rec_change[order(rec_change$time),]
rec_change <- rec_change[order(rec_change$rider_id),]


rec_change <- rec_change %>% group_by(rider_id) %>%
  mutate(auto_duration = ifelse(type_auto==1, as.numeric(diff(time),units="secs")+1, NA),
         auto_finish = time + auto_duration-1)
hist(rec_change$auto_duration, breaks=10000)
hist(rec_change$auto_duration, breaks=10000, xlim=c(0,20000))

# 추천배차 켠 기록만 남기기위해 auto_duration==NA인것 삭제
sum(is.na(rec_change$auto_duration)==1) # 43389rows
rec_change <- na.omit(rec_change) #25689rows

# 데이터 정리
rec_change <- rec_change[,c(1,3,6,5)]
colnames(rec_change)[2]<-"auto_start"


##### 추천배차 사용 기간을 초단위 full-time data로 변환 #####
### empty full-time dataframe
# 추천배차 ON 해둔 초만큼 row 만들기
auto_hist <- data.frame(lapply(rec_change, rep, rec_change$auto_duration)) #121,107,010rows

# 추천배차 ON 기간에서 몇번째 초인지 표시
auto_hist <- auto_hist[order(auto_hist$auto_start),]
auto_hist <- auto_hist[order(auto_hist$rider_id),]

auto_hist$num <- 1:nrow(auto_hist)
auto_hist <- auto_hist %>% group_by(rider_id, auto_start) %>% mutate(time_num = rleid(num))

auto_hist <- auto_hist[,c(-5)]

# 추천배차 ON 기간내 각 초단위시간 표시
auto_hist$time <- auto_hist$auto_start + auto_hist$time_num -1


auto_hist <- auto_hist[,c(1,6)] #121,107,010rows

################################################################################################################################################################################################################
##### data_order와 merge : 1) 추천배차가 켜져있는 시간대에 주문이 배차된 경우 rec_ON==1
#추천배차가 켜져있는시간대에 수행중인 주문을 찾으려면, assignedat, pickupedat, deliveredat을 기준으로 다 고려해야함
auto_hist$rec_assign_ON <- 1

colnames(auto_hist)[2] <- "assignedat" #추천배차가 켜져있는 시간대에 주문이 배차된 경우 rec_ON==1
head(auto_hist)

# data_order_matched를 2020-10-26 전 30일 1개그룹, 후 32일을 5개 그룹으로 자름
nrow(data_2m) #912,838

data_2m_pre <- data_2m %>% filter(date<"2020-10-26") # 450892
data_2m_1 <- data_2m %>% filter(date>="2020-10-26" & date<="2020-10-31"); unique(data_2m_1$date) #6, 81492
data_2m_2 <- data_2m %>% filter(date>="2020-11-01" & date<="2020-11-07"); unique(data_2m_2$date) #7, 100921
data_2m_3 <- data_2m %>% filter(date>="2020-11-08" & date<="2020-11-14"); unique(data_2m_3$date) #7, 99829
data_2m_4 <- data_2m %>% filter(date>="2020-11-15" & date<="2020-11-21"); unique(data_2m_4$date) #7, 104203
data_2m_5 <- data_2m %>% filter(date>="2020-11-22" & date<="2020-11-26"); unique(data_2m_5$date) #5, 75501

remove(data_2m)

# auto_hist 쪼개기
nrow(auto_hist) #121,107,010
auto_hist <- auto_hist %>% mutate(date = as.Date(assignedat)) 

auto_hist1 <- auto_hist %>% filter(date>="2020-10-26" & date<="2020-10-31"); unique(auto_hist1$date) #6, 28359147
auto_hist2 <- auto_hist %>% filter(date>="2020-11-01" & date<="2020-11-07"); unique(auto_hist2$date) #7, 20488724
auto_hist3 <- auto_hist %>% filter(date>="2020-11-08" & date<="2020-11-14"); unique(auto_hist3$date) #7, 20944865
auto_hist4 <- auto_hist %>% filter(date>="2020-11-15" & date<="2020-11-21"); unique(auto_hist4$date) #7, 22660510
auto_hist5 <- auto_hist %>% filter(date>="2020-11-22" & date<="2020-11-26"); unique(auto_hist5$date) #5, 16573803

# date col.없애기: data_2m의 date는 주문생성 시점에 대한 date이기때문에 잘못 merge될수가 있음
auto_hist1 <- auto_hist1[,-4];auto_hist2 <- auto_hist2[,-4];auto_hist3 <- auto_hist3[,-4];auto_hist4 <- auto_hist4[,-4];auto_hist5 <- auto_hist5[,-4]

# merge
data_2m_1 <- left_join(data_2m_1, auto_hist1)
data_2m_2 <- left_join(data_2m_2, auto_hist2)
data_2m_3 <- left_join(data_2m_3, auto_hist3)
data_2m_4 <- left_join(data_2m_4, auto_hist4)
data_2m_5 <- left_join(data_2m_5, auto_hist5)

data_2m_5 <- unique(data_2m_5) # 추천배차 기록에서 앞기록 auto_finish와 뒤기록 auto_start가 같으면 auto_hist가 두번 생성되므로 중복이생김


# OFF인 곳은 0으로 채우기
data_2m_pre$rec_assign_ON <- 0
data_2m <- rbind(data_2m_pre, data_2m_1) %>% rbind(data_2m_2) %>% rbind(data_2m_3) %>% rbind(data_2m_4) %>% rbind(data_2m_5)
data_2m$rec_assign_ON <- ifelse(is.na(data_2m$rec_assign_ON)==1,0,data_2m$rec_assign_ON)

################################################################################################################################################################################################################
##### 2) 추천배차가 켜져있는 시간대에 주문이 픽업중인 경우 rec_pickup_ON==1
colnames(auto_hist)[2:3] <- c("pickedupat" , "rec_pickup_ON")
head(auto_hist)

# data_order_matched를 2020-10-26 전 30일 1개그룹, 후 32일을 5개 그룹으로 자름
nrow(data_2m) #912,838

data_2m_pre <- data_2m %>% filter(date<"2020-10-26") # 450892
data_2m_1 <- data_2m %>% filter(date>="2020-10-26" & date<="2020-10-31"); unique(data_2m_1$date) #6, 81492
data_2m_2 <- data_2m %>% filter(date>="2020-11-01" & date<="2020-11-07"); unique(data_2m_2$date) #7, 100921
data_2m_3 <- data_2m %>% filter(date>="2020-11-08" & date<="2020-11-14"); unique(data_2m_3$date) #7, 99829
data_2m_4 <- data_2m %>% filter(date>="2020-11-15" & date<="2020-11-21"); unique(data_2m_4$date) #7, 104203
data_2m_5 <- data_2m %>% filter(date>="2020-11-22" & date<="2020-11-26"); unique(data_2m_5$date) #5, 75501

remove(data_2m)

# auto_hist 쪼개기
nrow(auto_hist) #121,107,010
auto_hist <- auto_hist %>% mutate(date = as.Date(pickedupat)) 

auto_hist1 <- auto_hist %>% filter(date>="2020-10-26" & date<="2020-10-31"); unique(auto_hist1$date) #6
auto_hist2 <- auto_hist %>% filter(date>="2020-11-01" & date<="2020-11-07"); unique(auto_hist2$date) #7
auto_hist3 <- auto_hist %>% filter(date>="2020-11-08" & date<="2020-11-14"); unique(auto_hist3$date) #7
auto_hist4 <- auto_hist %>% filter(date>="2020-11-15" & date<="2020-11-21"); unique(auto_hist4$date) #7
auto_hist5 <- auto_hist %>% filter(date>="2020-11-22" & date<="2020-11-26"); unique(auto_hist5$date) #5

# date col.없애기: data_2m의 date는 주문생성 시점에 대한 date이기때문에 잘못 merge될수가 있음
auto_hist1 <- auto_hist1[,-4];auto_hist2 <- auto_hist2[,-4];auto_hist3 <- auto_hist3[,-4];auto_hist4 <- auto_hist4[,-4];auto_hist5 <- auto_hist5[,-4]

# merge
data_2m_1 <- left_join(data_2m_1, auto_hist1)
data_2m_2 <- left_join(data_2m_2, auto_hist2)
data_2m_3 <- left_join(data_2m_3, auto_hist3)
data_2m_4 <- left_join(data_2m_4, auto_hist4)
data_2m_5 <- left_join(data_2m_5, auto_hist5)


# OFF인 곳은 0으로 채우기
data_2m_pre$rec_pickup_ON <- 0
data_2m <- rbind(data_2m_pre, data_2m_1) %>% rbind(data_2m_2) %>% rbind(data_2m_3) %>% rbind(data_2m_4) %>% rbind(data_2m_5)
data_2m$rec_pickup_ON <- ifelse(is.na(data_2m$rec_pickup_ON)==1,0,data_2m$rec_pickup_ON)



################################################################################################################################################################################################################
##### 3) 추천배차가 켜져있는 시간대에 주문이 배달중인 경우 rec_deliver_ON==1
colnames(auto_hist)[2:3] <- c("deliveredat", "rec_deliver_ON")
head(auto_hist)

# data_order_matched를 2020-10-26 전 30일 1개그룹, 후 32일을 5개 그룹으로 자름
nrow(data_2m) #912,838

data_2m_pre <- data_2m %>% filter(date<"2020-10-26") # 450892
data_2m_1 <- data_2m %>% filter(date>="2020-10-26" & date<="2020-10-31"); unique(data_2m_1$date) #6, 81492
data_2m_2 <- data_2m %>% filter(date>="2020-11-01" & date<="2020-11-07"); unique(data_2m_2$date) #7, 100921
data_2m_3 <- data_2m %>% filter(date>="2020-11-08" & date<="2020-11-14"); unique(data_2m_3$date) #7, 99829
data_2m_4 <- data_2m %>% filter(date>="2020-11-15" & date<="2020-11-21"); unique(data_2m_4$date) #7, 104203
data_2m_5 <- data_2m %>% filter(date>="2020-11-22" & date<="2020-11-26"); unique(data_2m_5$date) #5, 75501

remove(data_2m)

# auto_hist 쪼개기
nrow(auto_hist) #121,107,010
auto_hist <- auto_hist %>% mutate(date = as.Date(deliveredat)) 

auto_hist1 <- auto_hist %>% filter(date>="2020-10-26" & date<="2020-10-31"); unique(auto_hist1$date) #6
auto_hist2 <- auto_hist %>% filter(date>="2020-11-01" & date<="2020-11-07"); unique(auto_hist2$date) #7
auto_hist3 <- auto_hist %>% filter(date>="2020-11-08" & date<="2020-11-14"); unique(auto_hist3$date) #7
auto_hist4 <- auto_hist %>% filter(date>="2020-11-15" & date<="2020-11-21"); unique(auto_hist4$date) #7
auto_hist5 <- auto_hist %>% filter(date>="2020-11-22" & date<="2020-11-26"); unique(auto_hist5$date) #5

# date col.없애기: data_2m의 date는 주문생성 시점에 대한 date이기때문에 잘못 merge될수가 있음
auto_hist1 <- auto_hist1[,-4];auto_hist2 <- auto_hist2[,-4];auto_hist3 <- auto_hist3[,-4];auto_hist4 <- auto_hist4[,-4];auto_hist5 <- auto_hist5[,-4]

# merge
data_2m_1 <- left_join(data_2m_1, auto_hist1)
data_2m_1 <- unique(data_2m_1)

data_2m_2 <- left_join(data_2m_2, auto_hist2)
data_2m_2 <- unique(data_2m_2)

data_2m_3 <- left_join(data_2m_3, auto_hist3)
data_2m_3 <- unique(data_2m_3)

data_2m_4 <- left_join(data_2m_4, auto_hist4)
data_2m_4 <- unique(data_2m_4)

data_2m_5 <- left_join(data_2m_5, auto_hist5)
data_2m_5 <- unique(data_2m_5)


# OFF인 곳은 0으로 채우기
data_2m_pre$rec_deliver_ON <- 0
data_2m <- rbind(data_2m_pre, data_2m_1) %>% rbind(data_2m_2) %>% rbind(data_2m_3) %>% rbind(data_2m_4) %>% rbind(data_2m_5)
data_2m$rec_deliver_ON <- ifelse(is.na(data_2m$rec_deliver_ON)==1,0,data_2m$rec_deliver_ON)

remove(auto_hist1,auto_hist2,auto_hist3,auto_hist4,auto_hist5)
remove(data_2m_pre,data_2m_1,data_2m_2,data_2m_3,data_2m_4,data_2m_5)


################################################################################################################################################################################################################
##### 주문 수행 중 추천배차가 조금이라도 켜져있으면 1
data_2m <- data_2m %>% mutate(rec_sum = ifelse(rec_assign_ON+rec_pickup_ON+rec_deliver_ON==0,0,1))

### data check
test <- data_2m %>% filter(is_rec_assigned==1 & rec_assign_ON==0) #3130rows: 이중 5건은 


#####################################################################################################################################
##### AI ON/OFF check 
#####################################################################################################################################
head(rec_change) #25689rows

hist(rec_change$auto_duration, breaks=100000, xlim=c(0,1000))
sum(rec_change$auto_duration>86400) #205 (0.8%)

##### 추천배차 ON 기간 비정상적으로 긴 데이터 체크 
# 추천배차 ON 날짜와 OFF날짜가 같은 경우: 0/1/2/3시에 켜서 6시간 켜는경우는 이상치
rec_change <- rec_change %>% mutate(date_start = as.Date(auto_start),
                                    date_finish = as.Date(auto_finish),
                                    hour_start = hour(auto_start),
                                    hour_finish = hour(auto_finish),
                                    hour_diff = hour_finish-hour_start,
                                    day_diff = date_finish-date_start)
rec_change1<- rec_change %>% filter(date_start==date_finish) #24870rows
sum(rec_change1$hour_start==0 & rec_change1$hour_diff>=6) # 97 (10이상)
sum(rec_change1$hour_start==1 & rec_change1$hour_diff>=6) # 24 (8이상)
sum(rec_change1$hour_start==2 & rec_change1$hour_diff>=6) # 26 (7이상)
sum(rec_change1$hour_start==3 & rec_change1$hour_diff>=6) # 5 (12이상)

rec_change1 <- rec_change1 %>% filter(!(hour_start==0 & hour_diff>=6))
rec_change1 <- rec_change1 %>% filter(!(hour_start==1 & hour_diff>=6))
rec_change1 <- rec_change1 %>% filter(!(hour_start==2 & hour_diff>=6))
rec_change1 <- rec_change1 %>% filter(!(hour_start==3 & hour_diff>=6)) #24718rows



### 추천배차 ON 날짜와 OFF날짜가 다른경우 체크
# day_diff 2일이상인 경우 삭제: 74rows
# hour_start가 0/1/2인 경우 삭제: 37rows
# hour_finish>=31 삭제: 375rows
# 다만, 추천배차 ON 시간대가 밤시간대인 경우는 그럴수있음
rec_change2<-rec_change %>% filter(date_start!=date_finish) #819rows
rec_change2$hour_finish <- rec_change2$hour_finish+24
rec_change2$hour_diff <- rec_change2$hour_finish-rec_change2$hour_start
sum(rec_change2$day_diff!=1) # 95

rec_change2<-rec_change2 %>% filter(!(day_diff!=1)) #724
rec_change2<-rec_change2 %>% filter(hour_finish<31) #302
rec_change2<-rec_change2 %>% filter(hour_diff<22) #276



### outlier 제거 최종데이터
rec_change_rev <- rbind(rec_change1,rec_change2) #24994
remove(rec_change1, rec_change2)


####################################################################################################################################################
##### Data Summary
####################################################################################################################################################
##### 현재 분석에서 보고있는 샘플라이더들, treat riders, 기간(한달)만 추출
rec_change_focal <- rec_change_rev %>% filter(rider_id %in% rider_existlast$rider_id) # focal sample: 532명, 17425rows (2020/09/26~2020/11/26)
length(unique(rec_change_focal$rider_id)) #523riders

data_2m_focal <- data_2m %>% filter(rider_id %in% rider_existlast$rider_id)
length(unique(data_2m_focal$rider_id))  #532riders

### Check Treatment gruop
rec_change_focal <- rec_change_focal %>% mutate(Treat = ifelse(rider_id %in% treat_riders$rider_id,"Treat","Control"))
length(unique(rec_change_focal$rider_id)) # 추천배차 켠 기록이 있는 라이더: 523riders 
length(unique(rec_change_focal$rider_id[rec_change_focal$Treat=="Treat"])) # 실제 추천배차로 1회이상 배달완료한 라이더: 369riders

data_2m_focal <- data_2m_focal %>% mutate(Treat = ifelse(rider_id %in% treat_riders$rider_id,"Treat","Control"))

### Proficiency
head(proficiency)
rec_change_focal <- left_join(rec_change_focal, proficiency[,c(1,2,7:9)])
head(rec_change_focal)

data_2m_focal <- left_join(data_2m_focal, proficiency[,c(1,2,7:9)])

### period
rec_change_focal <- rec_change_focal %>% filter(date_start<="2020-11-26") #18030
length(unique(rec_change_focal$rider_id)) #518riders

data_2m_focal <- data_2m_focal %>% filter(date>="2020-10-26") #383132
length(unique(data_2m_focal$rider_id)) #529riders


##### 도입 이후 한달동안 추천배차 기능 켠 횟수
test <- rec_change_focal %>% group_by(rider_id, Treat) %>% summarise(n=n())
ggplot(test, aes(n, fill = Treat)) + geom_density(alpha=0.3) 


##### 오더 데이터로 부터: 배차받을때 추천배차가 켜져있었던 오더의 비율
head(data_2m_focal)
test <- data_2m_focal %>% group_by(rider_id, Treat) %>% summarise(AI_ON_share = length(which(rec_assign_ON==1))/n())
ggplot(test, aes(AI_ON_share, fill = Treat)) + geom_density(alpha=0.3) 
summary(test$AI_ON_share[test$Treat=="Treat"])
summary(test$AI_ON_share[test$Treat=="Control"])

test <- test %>% filter(Treat=="Treat")
ggplot(test, aes(AI_ON_share)) + geom_density(alpha=0.3) 

##### 오더 데이터로 부터: 픽업/배달완료시 추천배차가 켜져있었던 오더의 비율
head(data_2m_focal)
test <- data_2m_focal %>% group_by(rider_id, Treat) %>% summarise(AI_ON_share = length(which(rec_pickup_ON==1|rec_deliver_ON==1))/n())
ggplot(test, aes(AI_ON_share, fill = Treat)) + geom_density(alpha=0.3) 
summary(test$AI_ON_share[test$Treat=="Treat"])
summary(test$AI_ON_share[test$Treat=="Control"])

test <- test %>% filter(Treat=="Treat")
ggplot(test, aes(AI_ON_share)) + geom_density(alpha=0.3) 


##### 추천배차 이용시간 (한번 켜면 얼마나 켜두는지)
### 라이더별 추천배차 이용시간
test <- rec_change_focal %>% group_by(rider_id, Treat) %>% summarise(avg_duration = mean(auto_duration))
summary(test$avg_duration)
ggplot(test, aes(avg_duration, fill = Treat)) + geom_density(alpha=0.3)
ggplot(test, aes(avg_duration, fill = Treat)) + geom_density(alpha=0.3) + ylim(c(0,0.005)) + xlim(c(0,5000))

##### 추천배차 이용 시간대
ggplot(rec_change_focal, aes(hour_start)) + geom_density(alpha=0.3)











####################################################################################################################################################
##### 추천배차 OFF시간 재산정
#-> 대부분 다음날, 다다음날,... 주문데이터가 없어서 한참 후 그다음 주문이 생겻을때 추천배차가 멈추는걸로 되어있어서 추천배차 사용시간이 엄청 길게 측정됨
# 추천배차를 켠 날짜에 최초 주문생성/최후 배달완료 시각
test <- data_2m %>% group_by(rider_id, date) %>% summarise(start_min = min(submittedat),
                                                           start_max = max(deliveredat))
rec_change1 <- rec_change %>% mutate(start_date = as.Date(auto_start))
test <- test %>% mutate(start_date = as.Date(start_min))
test<-test[,c(-2)]
rec_change1 <- left_join(rec_change1, test)

# 추천배차를 끈 날짜에 최초 주문생성/최후 배달완료 시각
test <- data_2m %>% group_by(rider_id, date) %>% summarise(finish_min = min(submittedat),
                                                           finish_max = max(deliveredat))
rec_change1 <- rec_change1 %>% mutate(finish_date = as.Date(auto_finish))
test <- test %>% mutate(finish_date = as.Date(finish_max))
test<-test[,c(-2)]
rec_change1 <- left_join(rec_change1, test)

# auto_start<start_max이면, 일이 모두 끝난 후에 추천배차를 ON한경우라서, 언제 일을 중단했는지 알수가없음 -> 삭제
test1 <- rec_change1 %>% filter(auto_start >= start_max)

####################################################################################################################################################