library(data.table); library(dplyr); library(ggplot2); library(cowplot);library(lubridate);library(lfe);library(SciViews)
'%!in%' <- function(x,y)!('%in%'(x,y))

##################################################################################################################################
##### Rawdata read #####
##################################################################################################################################

##### order data #####
### Rider data
rider <- as.data.frame(fread("rider_info.csv", stringsAsFactors = T))
rider$first_order <-as.Date(rider$first_order); rider$last_order <-as.Date(rider$last_order)

### Store data
store <- as.data.frame(fread("store_rider_value_stores_1221.csv"))

### Order data
rawdata <- as.data.frame(fread("recommendation_data_20201221.csv", stringsAsFactors = T))
colnames(rawdata)
#[1] "order_id"              "management_partner_id" "store_id"              "agent_id"             
#[5] "store_base_fee"        "agent_fee"             "agent_extra_fee"       "category"             
#[9] "partner_name"          "date"                  "monitoringpartner_id"  "order_status"         
#[13] "submittedat"           "assignedat"            "pickedupat"            "deliveredat"          
#[17] "is_rec_assigned"       "is_rec_completed"      "is_rec_adjusted"       "total_order"          
#[21] "dest_lat_masked"       "dest_lng_masked"       "distorigintodest"      "year"                 
#[25] "month"                 "day" 
rawdata <- rawdata[,c(-12,-20)]
colnames(rawdata)[c(4,6,7,9,11)] <- c("rider_id","rider_fee","rider_extra_fee","management_partner_name","monitoring_partner_id")

### Merge data
orders <- left_join(rawdata, store, by="store_id")
remove(rawdata)
orders <- orders[,c(-30:-31)] #monitoring_partner_id는 기존 store데이터에 있던것과 다를수있음 -> order 데이터의 monitoring_partner_id를 따르자!

orders <- left_join(orders, rider, by=c("rider_id","management_partner_id")) #management_partner_id는 기존 rider 데이터에 있던것과 다를수있음
#test <- unique(orders[,c(2,9,34)])
orders <- orders[,c(-34)]
orders <- orders[,c(1,10,4,2,9,33,34,35,3,25,32,11,26,8,27,28,29,30,31,19,20,21,12,13,14,15,16,17,18,5,6,7,22,23,24)]
colnames(orders)[c(5,12,14)] <- c("management_partner_name","monitoring_partner_id","category")

orders$date <- as.Date(orders$date)





##################################################################################################################################
##### Data check and cleansing #####
##################################################################################################################################
### 지점별 AI 추천배차 도입 날짜 체크 - "aiorder check.csv"
test <- orders %>% 
  group_by(management_partner_id) %>% 
  summarise(first_order = min(date),
            last_order = max(date),
            first_AI = min(date[is_rec_assigned==1]),
            aiorders = sum(is_rec_assigned==1))
# 총 69개 지점중, 20개는 추천배차 전지점 도입(10월 말) 이전에 지점이 없어지거나 도입이 아직 안된 지점(1163)
write.csv(test,"aiorder check.csv")

### 지점별 2020-10-26 이전 AI추천배차 주문개수
test1 <- orders %>% filter(date<"2020-10-26" & is_rec_assigned==1) %>%
  group_by(management_partner_id) %>% summarise(aiorders = n())



##### 9,179,288건에서 cleansing 시작 ############################################################################################
nrow(orders)
length(unique(orders$rider_id)) #2905명 라이더

### 초기도입 5지점 모두 삭제 
#test <- orders %>% filter(management_partner_id %in% c(520,461,773,369,908)) #1,142,379건 (12%)
orders <- orders %>% filter(management_partner_id %!in% c(520,461,773,369,908))  # 8,036,909건남음

### 2020-10-26 이전 추천배차 도입 라이더 제외
length(unique(orders$rider_id)) #2581명 라이더

test <- orders %>%
  group_by(rider_id) %>%
  summarise(first_date = min(date),
            last_date = max(date),
            total_orders=n(),
            before_orders=sum(date>="2020-09-26" & date<"2020-10-26"),
            after_orders=sum(date>="2020-10-26"),
            AI_assigned_orders = sum(is_rec_assigned),
            AI_completed_orders = sum(is_rec_completed),
            num_date = length(unique(date)),
            AI_intro_date = min(date[is_rec_completed==1]),
            AI_before_orders = sum(is_rec_completed[date<"2020-10-26"]))

sum(test$AI_before_orders>0) #2020-10-26 이전에 추천배차 사용한 라이더 40명

# 2020-09-26이전부터 존재하면서 도입전 한달 주문 내역이 있고 도입후 한달 주문 내역이 있는 라이더: 602명라이더
test1 <- test %>% filter(first_date <="2020-09-26" & before_orders >=1 & after_orders >=1) 
# 그중 2020-10-26 이전에 추천배차 사용한 라이더 16명
sum(test1$AI_before_orders>0)


test <- test %>% filter(AI_before_orders>0) #2020-10-26 이전에 추천배차 사용한 라이더 40명
orders <- orders %>% filter(rider_id %!in% test$rider_id) #7,709,088건 남음
length(unique(orders$rider_id)) #2541명 라이더 남음



### 프렌즈 데이터: 72건 삭제 (0.001%)
#test <- orders %>% filter(grepl("프렌즈",management_partner_name)) 
orders <- orders %>% filter(!grepl("프렌즈",management_partner_name)) #7,709,016건남음


### 부산/부산인근에 위치한 상점 주문 데이터가 아닌 경우: 201건 삭제 (0.003%)
#test <- orders %>% filter(si_do %!in% c("부산광역시","경상남도"))
orders <- orders %>% filter(si_do %in% c("부산광역시","경상남도")) #7,708,815건남음
length(unique(orders$rider_id)) #2529명 라이더 남음

### 테스트/오류/4륜 주문건: 18건 삭제 (0.0003%)
#test <- orders %>% filter(grepl("Test|test|TEST|QA|테스트|임시|오등록|vroong|사륜|4륜|잘못입력|ddd|상점정보등록",store_name))
orders <- orders %>% filter(!grepl("Test|test|TEST|QA|테스트|임시|오등록|vroong|사륜|4륜|잘못입력|ddd|상점정보등록",store_name)) #7,708,797건남음
length(unique(orders$rider_id)) #2529명 라이더 남음


### process 소요시간 음수/1시간 이상 제거: 
orders[,23:26] <- lapply(orders[,23:26],function(x) ymd_hms(x))

orders <- orders %>% mutate(assign_sec = as.numeric(assignedat - submittedat),
                            pickup_sec = as.numeric(pickedupat - assignedat),
                            delivery_sec = as.numeric(deliveredat - pickedupat),
                            waiting_sec = as.numeric(deliveredat - submittedat))
#summary(orders[,36:39]) # pickup_sec, delivery_sec NA 13건
#test <- orders %>% filter(pickup_sec<0|delivery_sec<0) # 픽업/배달 소요시간이 음수인 주문건 10672건

#test <- orders %>% filter(assign_sec>=1800) # 배차소요시간이 1시간 이상인 주문건 1393건(0.02%)(카테고리 다양), 30분이상 24806건 (0.3%)
#test <- orders %>% filter(pickup_sec>=3600) # 픽업소요시간이 1시간 이상인 주문건 966건(0.01%)(카테고리 다양), 30분 이상 31267건 (0.4%)
#test <- orders %>% filter(delivery_sec>=3600) # 배달소요시간이 1시간 이상인 주문건 2816건(0.04%)(카테고리 다양), 30분 이상 45588 (0.6%)

orders <- orders %>% filter(pickup_sec>=0 & delivery_sec>=0) #10685건 제거, 7698112건 남음
orders <- orders %>% filter(assign_sec<3600 & pickup_sec<3600 & delivery_sec<3600) # NA, 음수, 이상치 제거; 4287건(0.06%), 7693525건남음
#summary(orders[,36:39])


##### 7,693,525건  ############################################################################################
length(unique(orders$rider_id)) #2529명남음

### process 소요시간 말도안되게 짧은거 제거: 

# assign_sec: 주문뜨자마자 배차받을수 있으니 엄청 짧은것도 가능
str(orders$assign_sec)
hist(orders$assign_sec, breaks=100000)
hist(orders$assign_sec, breaks=100000, xlim=c(0,200)) # 


# pickup_sec: 가게에서 여러주문 동시에 배차받고 픽업할수 있으니 엄청 짧은것도 가능
str(orders$pickup_sec)
hist(orders$pickup_sec, breaks=100000)
hist(orders$pickup_sec, breaks=100000, xlim=c(0,200))
hist(orders$pickup_sec, breaks=100000, xlim=c(0,20)) 


# delivery_sec: 1분 미만 삭제
str(orders$delivery_sec)
summary(orders$delivery_sec)
hist(orders$delivery_sec, breaks=100000)
hist(orders$delivery_sec, breaks=1000, xlim=c(0,100)) # delivery_sec<60 -> 144847건(1.9%) 은 비정상적임.. 삭제!
sum(orders$delivery_sec<60) 

orders <- orders %>% filter(delivery_sec>=60) # 7,548,678건 남음


# waiting_sec: 5분 미만 삭제
summary(orders$waiting_sec)
hist(orders$waiting_sec, breaks=100000)
hist(orders$waiting_sec, breaks=100000, xlim=c(0,300)) # waiting_sec<300sec -> 39510건(0.5%)은 비정상적임...
sum(orders$waiting_sec<300)

orders <- orders %>% filter(waiting_sec>=300) # 7,509,168건 남음 



### 배달 거리 체크: 거리가 0인게 꽤 있음
# distorigintodest
summary(orders$distorigintodest); str(orders$distorigintodest)
hist(orders$distorigintodest, breaks=100000)
sum(orders$distorigintodest<0.1, na.rm=T) #배달거리 100m 미만 = 59491 obs(0.8%))
orders$distorigintodest <- ifelse(orders$distorigintodest<0.1, NA, orders$distorigintodest); summary(orders$distorigintodest) #10m이하 NA처리
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#    0.10    0.57    0.96    1.11    1.47    9.14   59491  

### 추천배차 주문건수 체크
sum(orders$is_rec_assigned==1) # 49,082건
sum(orders$is_rec_completed==1) # 40,799건



##################################################################################################################################
##### Create variables #####
##################################################################################################################################

### OD pair
orders <- orders %>% mutate(OD = paste(lat,lng,dest_lat_masked,dest_lng_masked))
length(unique(orders$OD)) # 757,857 pairs (OD 평균 약 10번 배달)


### hourDOW
orders <- orders %>% mutate(DOW = wday(date),
                            hour = hour(assignedat))
orders <- orders %>% mutate(hourDOW = paste(hour, DOW, sep="_"))

### only active working hours (11AM ~ 10PM: 12hours)
orders <- orders %>% filter(hour %in% c(11:22)) #6,860,151orders

### station-date
orders$station_date <- paste(orders$management_partner_id, orders$date, sep="_")


### 수수료, 꿀콜 레벨(수수료/직선거리)
orders <- orders %>% mutate(rider_total_fee = rider_fee + rider_extra_fee) # 라이더 총 수수료
orders <- orders %>% mutate(order_level = rider_total_fee/distorigintodest)
summary(orders$order_level)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#   348.7  2062.2  2957.6  4186.2  4871.6 39245.4   55097 


### 추천배차 관련 변수 수정
orders$is_rec_assigned <- ifelse(orders$is_rec_assigned==1,1,0)
orders$is_rec_completed <- ifelse(orders$is_rec_completed==1,1,0)
orders$is_rec_adjusted <- ifelse(orders$is_rec_adjusted==1,1,0)


### 합배송 관련
# 라이더가 주문을 배차받은 순서로 데이터 재정렬
orders <- orders[order(orders$assignedat),]
orders <- orders[order(orders$rider_id),]


# shift(주문묶음) 번호 컬럼 만들기
orders$deliveredat_num <- as.numeric(orders$deliveredat)
orders <- orders %>% group_by(date, rider_id) %>% mutate(deliveredat_maxnum = cummax(deliveredat_num))
orders$deliveredat_max <- as.POSIXct(orders$deliveredat_maxnum, origin="1970-01-01", tz="UTC")
orders<-orders[,-47:-48]

func_check <- function(c1,c2){return(c(1, ifelse(tail(c1,-1)<=head(c2,-1),1,0)))}
orders <- orders %>% group_by(date, rider_id) %>%
  mutate(check = func_check(assignedat,deliveredat_max),
         shift = cumsum(check==0)+1)

orders <- orders[,-48]




### 2020.09.26 이후 데이터 중, 추천배차 도입 전후 / 전체기간에 대한 라이더 샘플수 
length(unique(orders$rider_id)) # 총 2526명 라이더

test <- orders %>% group_by(rider_id, created_at) %>% summarise(first_date = min(date),
                                                                last_date = max(date),
                                                                total_orders=n(),
                                                                before_orders=length(which(date>="2020-09-26" & date<"2020-10-26")),
                                                                after_orders=length(which(date>="2020-10-26")),
                                                                AI_assigned_orders = sum(is_rec_assigned),
                                                                AI_completed_orders = sum(is_rec_completed),
                                                                num_date = length(unique(date)),
                                                                AI_intro_date = min(date[is_rec_completed==1]))

rider_ba <- test %>% filter(before_orders >=1 & after_orders >= 1)
length(unique(rider_ba$rider_id)); sum(rider_ba$AI_completed_orders>=1)
# [rider_ba]
# 2020-09-26이후 2020-10-26전으로 오더 1건이라도 수행한 라이더: 655명
# 그중, AI 추천배차로 1회 이상 배달완료한 라이더 432명 (65.95%)

rider_preexist <- test %>% filter(first_date <="2020-09-26" & before_orders >=1 & after_orders >=1)
length(unique(rider_preexist$rider_id)); sum(rider_preexist$AI_completed_orders>=1)
# [rider_preexist]
# 2020-09-26 이전에 부릉에 들어와서 추천배차 도입 전후로 오더 1건이라도 수행한 라이더: 581명
# 그중, AI 추천배차로 1회 이상 배달완료한 라이더 382명 (65.75%)

rider_fullexist <- test %>% filter(first_date <="2020-09-26" & before_orders >=1 & after_orders >=1 & last_date>="2020-11-26")
length(unique(rider_fullexist$rider_id)); sum(rider_fullexist$AI_completed_orders>=1)
# [rider_fullexist]
# 2020-09-26 이전에 부릉에 들어와서 2020-11-26 끝까지 탈퇴안한 라이더: 458명
# 그중, AI 추천배차로 1회 이상 배달완료한 라이더 310명 (67.7%)






##################################################################################################################################
##### 2개월, 기준 충족 라이더 데이터 추출 #####
##################################################################################################################################

### data_2m_preexist
data_2m_preexist <- orders %>% filter(date>="2020-09-26") %>% 
  filter(rider_id %in% rider_preexist$rider_id)
nrow(data_2m_preexist); length(unique(data_2m_preexist$rider_id)) #739,491건, 581명 라이더
length(unique(data_2m_preexist$date)) #66일 데이터


