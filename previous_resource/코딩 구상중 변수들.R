##### 코딩 아이디어 구상중인 변수들 #####

####################################### 작업끝, 사용안함 ############################################################################# 
##### proficiency 변수 만들기 #####
# # 라이더별 각 시간대 수행 주문건수
# proficiency <- data_order_pre %>% 
#   mutate(deliver_hour = hour(deliveredat)) %>%
#   group_by(rider_id, date, deliver_hour) %>% 
#   summarise(hourly_orders = n())
# 
# # 각 시간대 수행 주문건수의 분포
# proficiency_dist <- data_order_pre %>% mutate(deliver_hour = hour(deliveredat)) %>%
#   group_by(rider_id, date, deliver_hour) %>% summarise(num_orders = n())
# 
# # 라이더별 각 시간대 수행 주문건수의 percentile
# proficiency$order_perc <- 1
# for (i in 1:nrow(proficiency)){
#   proficiency$order_perc[i] <- ecdf(proficiency_dist$num_orders[proficiency_dist$date==proficiency$date[i] & proficiency_dist$deliver_hour==proficiency$deliver_hour[i]])(proficiency$hourly_orders[i])
# }
# remove(proficiency_dist)
# 
# # 라이더별 daily max percentile
# proficiency <- proficiency %>% group_by(rider_id, date) %>% summarise(max_prof_perc= max(order_perc))
# 
# # 라이더별 daily max percentile의 mean 
# proficiency <- proficiency %>% group_by(rider_id) %>% summarise(avg_prof_perc = mean(max_prof_perc))
# summary(proficiency$avg_prof_perc)
# #Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# #0.1251  0.7306  0.8492  0.7930  0.9146  0.9987
# 
# hist(proficiency$avg_prof_perc, breaks=533, main="Quantile of orders delivered in rider's main working time", xlab="Quantile")
# 
# quantile(proficiency$avg_prof_perc, probs = c(.5, .7, .9))
# #50%       70%       90% 
# #0.8491574 0.9013740 0.9594745
# 
# # proficiency group
# proficiency <- proficiency %>% mutate(prof_group50 = ifelse(avg_prof_perc>0.849,1,0),
#                                       prof_group70 = ifelse(avg_prof_perc>0.901,1,0),
#                                       prof_group90 = ifelse(avg_prof_perc>0.959,1,0))
# 
# # proficiency 변수 merge
# data_order <- left_join(data_order,proficiency)
# pre_var <- left_join(pre_var,proficiency)



####################################### 작업중 ############################################################################# 
# data_agg에 시간대 구간 시작/끝 컬럼 만든후에 (ex; 00:00:00, 10:59:59) shift의 start, finish 컬럼 이용해서 각 구간에 몇시간있었는지 계산

##### proficiency #####
### 시간대 구간으로 나누기
head(data_order)
test <- data_order %>% group_by(date, hour) %>% summarise(demand = n()) %>% 
  group_by(hour) %>% summarise(demand = mean(demand))
# 늦은밤/이른아침 (early_late): 0,1,2,3,4,5,6,7,8,9,10 | 점심(lunch): 11,12,13 | 오후(afternoon): 14,15,16
# 저녁: 17,18,19,20 (dinner) | 밤(night): 21,22,23 

# period identificator 
test <- c("early_late","early_late","dawn","dawn","dawn","dawn","dawn","dawn","dawn","early_late","early_late","lunch","lunch","lunch","afternoon","afternoon","afternoon","dinner","dinner","dinner","dinner","night","night","night")
data_agg <- data_agg %>% mutate(period_start = test[hour(start)+1],
                                period_finish = test[hour(finish)+1])
sum(data_agg$period_start != data_agg$period_finish) # 시작-끝시간대 다른경우 32301건; 10%
test <- data_agg %>% filter(period_start != period_finish)

############################################################################################################################ 

