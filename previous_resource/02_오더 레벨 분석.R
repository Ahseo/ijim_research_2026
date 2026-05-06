##### 추천배차 부산 전체 도입 데이터 - 오더레벨 분석 (01_Data Check and Cleansing에서 이어짐) #####
head(data_2m)
data_ols <- data_2m

nrow(data_ols) # 1,011,310건 주문
length(unique(data_ols$date)) # 66일
length(unique(data_ols$rider_id)) # 957명 라이더
length(unique(data_ols$management_partner_id))  # 32지점
length(unique(data_ols$OD)) # 232,198 paris (OD 평균 4.4번 배달)

sum(data_ols$is_rec_assigned==1) # 51,361건 (2달 전체 주문의 5.1%)
sum(data_ols$is_rec_completed==1) # 43,320건 (2달 전체 주문의 4.3%, AI 배차 주문의 84.3%)

test <- data_ols %>% group_by(rider_id) %>% summarise(num_day = length(unique(date))) # 각 라이더 일한 일수
summary(test$num_day)

# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.00   14.00   36.00   34.28   54.00   66.00 





##### Variable 만들기 #####
### Main variable "ai_order": if orders is assigned and completed by AI, then 1, otherwise 0
data_ols <- data_ols %>% mutate(ai_order = ifelse(is_rec_completed==1, 1, 0))
sum(data_ols$ai_order==1)



### Control variable "cum_orders": Cumulative orders up to t
data_ols <- data_ols[order(data_ols$assignedat),]
data_ols <- data_ols[order(data_ols$rider_id),]

data_ols$dum <- 1
data_ols <- data_ols %>% group_by(date, rider_id) %>% mutate(cum_orders = cumsum(dum))
summary(data_ols$cum_orders)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1       9      18      22      31     130 


### Control variable "cum_riderOD": Number of times up to t a rider has driven the OD pair
data_ols <- data_ols[order(data_ols$assignedat),]
data_ols <- data_ols[order(data_ols$rider_id),]

data_ols <- data_ols %>% group_by(rider_id, OD) %>% mutate(cum_riderOD = cumsum(dum))
summary(data_ols$cum_riderOD)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.00    1.00    1.00    2.33    2.00  166.00 


### Control variable "idle_btw_orders": Idle time between prior order and current order 
data_ols <- data_ols[order(data_ols$assignedat),]
data_ols <- data_ols[order(data_ols$rider_id),]

interval_assign <- function(x){return(c(NA, diff(x)))}
#idletimes <- function(c1,c2){return(c(NA, tail(c1,-1)-head(c2,-1)))}
data_ols <- data_ols %>% group_by(date, rider_id) %>% mutate(interval_btw_assign = interval_assign(assignedat))
#                                                             idle_btw_orders = idletimes(assignedat,deliveredat))
data_ols <- as.data.frame(data_ols)
head(data_ols)
summary(data_ols$interval_btw_assign)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#  0     118     537    1035    1098   83727   32802 

summary(data_ols$idle_btw_orders)
hist(data_ols$idle_btw_orders, breaks=100, main=NA) + title("Idle time between orders")
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#  -6066    -806    -112      13     132   82905   32802 

#data_ols$idle_btw_orders <- ifelse(is.na(data_ols$idle_btw_orders)==1,0,data_ols$idle_btw_orders)


### Moderating variable: Rider's proficiency
# hourly avg orders in pretreatment period: 
proficiency <- data_ols
proficiency$date <- as.Date(proficiency$date)
proficiency <- proficiency %>%
  filter(date<"2020-10-26") %>% 
  mutate(deliver_hour = hour(deliveredat)) %>%
  group_by(rider_id, date, deliver_hour) %>% 
  summarise(hourly_orders = n()) %>%
  group_by(rider_id, date) %>%
  summarise(max_hourly_order = max(hourly_orders),
            max_hour = deliver_hour[which(hourly_orders==max_hourly_order)])

proficiency_dist <- data_ols %>% filter(date<"2020-10-26")  %>% mutate(deliver_hour = hour(deliveredat)) %>%
  group_by(rider_id, date, deliver_hour) %>% summarise(num_orders = n())

proficiency <- proficiency %>% mutate(percentile = ecdf(proficiency_dist$num_orders[proficiency_dist$date==date & proficiency_dist$deliver_hour==max_hour])(max_hourly_order))

proficiency <- proficiency %>% group_by(rider_id) %>% summarise(prof_perc= mean(percentile))
hist(proficiency$prof_perc, breaks=799, main="Quantile of orders delivered in rider's main working time", xlab="Quantile")

                                
# Extract rider data who both works before and after the AI introduction
data_ols_tenure <- data_ols %>% filter(rider_id %in% rider_ba$rider_id)
length(unique(data_ols_tenure$rider_id)) # 675 riders

# Attach tenure variable
data_ols_tenure <- left_join(data_ols_tenure, proficiency)
head(data_ols_tenure)
summary(data_ols_tenure$prof_perc)


# "tenure": enrollment period with Vroong until 2020-11-30
data_ols_tenure$created_at <- as.Date(data_ols_tenure$created_at)
data_ols_tenure <- data_ols_tenure %>% mutate(tenure = as.numeric(as.Date("2020-10-26") - created_at))
summary(data_ols_tenure$tenure)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#1.0    92.0   252.0   320.3   496.0  1151.0 




##### Col type check #####
data_ols <- as.data.frame(data_ols)
str(data_ols)
data_ols[,c(2,3,4,40,43)] <- lapply(data_ols[,c(2,3,4,40,43)],function(x) as.factor(x))
str(data_ols)

data_ols_tenure <- as.data.frame(data_ols_tenure)
str(data_ols_tenure)
data_ols_tenure[,c(2,3,4,42)] <- lapply(data_ols_tenure[,c(2,3,4,42)],function(x) as.factor(x))
str(data_ols_tenure)





##### Model estimation #####
model1 <- felm(ln(assign_sec+1) ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW + OD | 0 | rider_id, data=data_ols)
model1 <- felm(ln(assign_sec+1) ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)
model1_t <- felm(ln(assign_sec+1) ~ ai_order*ln(rel_quantile) + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)
summary(model1_t)
#10min
model2 <- felm(ln(pickup_sec+1) ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols)
model2 <- felm(ln(pickup_sec+1) ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)
model2_t <- felm(ln(pickup_sec+1) ~ ai_order*ln(rel_quantile) + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)
summary(model2_t)

model3 <- felm(ln(delivery_sec+1) ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols)
model3 <- felm(ln(delivery_sec+1) ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)
model3_t <- felm(ln(delivery_sec+1) ~ ai_order*ln(rel_quantile) + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)
summary(model3_t)

model4 <- felm(ln(distorigintodest+1) ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols)
model4 <- felm(ln(distorigintodest+1) ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)
model4_t <- felm(ln(distorigintodest+1) ~ ai_order*ln(rel_quantile) + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)
summary(model4_t)

model8 <- felm(idle_btw_orders ~ ai_order + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols)
model8_t <- felm(idle_btw_orders ~ ai_order*ln(tenure) + cum_orders + cum_riderOD + idle_btw_orders | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols_tenure)


model5 <- felm(ln(idle_btw_orders+1) ~ ai_order | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols)
summary(model5)
model6 <- felm(ln(cum_orders) ~ ai_order | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols)
summary(model6)
model7 <- felm(ln(cum_riderOD) ~ ai_order | rider_id + management_partner_id + date + hourDOW | 0 | rider_id, data=data_ols)
summary(model7)

