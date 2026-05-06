####################################### 더욱 정교한 proficiency measure  #################################################### 
# weight*(각 구간에서 배달한 전체 물량/각 구간 실제 노동시간)으로 계산
# weight는 하루 전체 노동시간 중 해당 구간 노동시간이 차지하는 비율
# data_agg에 시간대 구간 시작/끝 컬럼 만든후에 (ex; 00:00:00, 10:59:59) shift의 start, finish 컬럼 이용해서 각 구간에 몇시간있었는지 계산

# 각 구간에서 배달한 전체 물량

##### proficiency #####
### 시간대 구간으로 나누기
head(data_order)
test <- data_order %>% group_by(date, hour) %>% summarise(demand = n()) %>% 
  group_by(hour) %>% summarise(demand = mean(demand))
# 늦은밤/이른아침 (early_late): 0,1,2,3,4,5,6,7,8,9,10 | 점심(lunch): 11,12,13 | 오후(afternoon): 14,15,16
# 저녁: 17,18,19,20 (dinner) | 밤(night): 21,22,23 

# period identificator for order-level
test <- c("early_late","early_late","early_late","early_late","early_late","early_late","early_late","early_late","early_late","early_late","early_late","lunch","lunch","lunch","afternoon","afternoon","afternoon","dinner","dinner","dinner","dinner","night","night","night")
data_order <- data_order %>% mutate(hour_assign = hour(assignedat),
                                    period = test[hour_assign+1])
test_order <- data_order %>% group_by(rider_id, date, period) %>% summarise(num_orders = n())

# period identificator for shift-level
data_agg <- data_agg %>% mutate(period_start = test[hour(start)+1],
                                period_finish = test[hour(finish)+1])
sum(data_agg$period_start != data_agg$period_finish) # 시작-끝시간대 다른경우 30937
test <- data_agg %>% filter(period_start != period_finish) %>% group_by(period_start,period_finish) %>% summarise(n=n())
# 1	afternoon	dinner	7699
# 2	afternoon	night	25
# 3	dinner	early_late	4
# 4	dinner	night	8925
# 5	early_late	afternoon	23
# 6	early_late	lunch	3800
# 7	lunch	afternoon	7598
# 8	lunch	dinner	5
# 9	night	early_late	2858


# when period_start==period_finish
test <- data_agg %>% filter(period_start==period_finish) %>% mutate(period = period_start,
                                                                         period_dur = as.difftime(finish - start, units="secs")) #265073rows

# afternoon dinner
test1 <- data_agg %>% filter(period_start=="afternoon" & period_finish=="dinner") %>% mutate(period = period_start,
                                                                                             period_dur = as.difftime(ymd_hms(paste(date,"17:00:00")) - start, units="secs")) #7699
test<-rbind(test,test1) #272772

test1 <- data_agg %>% filter(period_start=="afternoon" & period_finish=="dinner") %>% mutate(period = period_finish,
                                                                                             period_dur = as.difftime(finish - ymd_hms(paste(date,"17:00:00")), units="secs")) #7699
test<-rbind(test,test1) #280471

# afternoon night
test1 <- data_agg %>% filter(period_start=="afternoon" & period_finish=="night") %>% mutate(period = period_start,
                                                                                             period_dur = as.difftime(ymd_hms(paste(date,"17:00:00")) - start, units="secs")) #25
test<-rbind(test,test1) #280496

test1 <- data_agg %>% filter(period_start=="afternoon" & period_finish=="night") %>% mutate(period = "dinner",
                                                                                             period_dur = as.difftime(hms("21:00:00") - hms("17:00:00"), units="secs")) #25
test<-rbind(test,test1) #280521

test1 <- data_agg %>% filter(period_start=="afternoon" & period_finish=="night") %>% mutate(period = period_finish,
                                                                                            period_dur = as.difftime(finish - ymd_hms(paste(date,"21:00:00")), units="secs")) #25
test<-rbind(test,test1) #280546

# dinner early_late
test1 <- data_agg %>% filter(period_start=="dinner" & period_finish=="early_late") %>% mutate(period = period_start,
                                                                                            period_dur = as.difftime(ymd_hms(paste(date,"21:00:00")) - start, units="secs")) #4
test<-rbind(test,test1) #280550

test1 <- data_agg %>% filter(period_start=="dinner" & period_finish=="early_late") %>% mutate(period = "night",
                                                                                            period_dur = as.difftime(hms("24:00:00") - hms("21:00:00"), units="secs")) #4
test<-rbind(test,test1) #280554

test1 <- data_agg %>% filter(period_start=="dinner" & period_finish=="early_late") %>% mutate(period = period_finish,
                                                                                            period_dur = as.difftime(finish - ymd_hms(paste(date,"24:00:00")), units="secs")) #4
test1$date <- test1$date+1
test<-rbind(test,test1) #280558

# dinner night
test1 <- data_agg %>% filter(period_start=="dinner" & period_finish=="night") %>% mutate(period = period_start,
                                                                                             period_dur = as.difftime(ymd_hms(paste(date,"21:00:00")) - start, units="secs")) #8925
test<-rbind(test,test1) #289483

test1 <- data_agg %>% filter(period_start=="dinner" & period_finish=="night") %>% mutate(period = period_finish,
                                                                                             period_dur = as.difftime(finish - ymd_hms(paste(date,"21:00:00")), units="secs")) #8925
test<-rbind(test,test1) #298408

# early_late afternoon 
test1 <- data_agg %>% filter(period_start=="early_late" & period_finish=="afternoon") %>% mutate(period = period_start,
                                                                                              period_dur = as.difftime(ymd_hms(paste(date,"11:00:00")) - start, units="secs")) #23
test<-rbind(test,test1) #298431

test1 <- data_agg %>% filter(period_start=="early_late" & period_finish=="afternoon") %>% mutate(period = "lunch",
                                                                                              period_dur = as.difftime(hms("14:00:00") - hms("11:00:00"), units="secs")) #23
test<-rbind(test,test1) #298454

test1 <- data_agg %>% filter(period_start=="early_late" & period_finish=="afternoon") %>% mutate(period = period_finish,
                                                                                              period_dur = as.difftime(finish - ymd_hms(paste(date,"14:00:00")), units="secs")) #23
test<-rbind(test,test1) #298477

#early_late lunch
test1 <- data_agg %>% filter(period_start=="early_late" & period_finish=="lunch") %>% mutate(period = period_start,
                                                                                         period_dur = as.difftime(ymd_hms(paste(date,"11:00:00")) - start, units="secs")) #3800
test<-rbind(test,test1) #302277

test1 <- data_agg %>% filter(period_start=="early_late" & period_finish=="lunch") %>% mutate(period = period_finish,
                                                                                         period_dur = as.difftime(finish - ymd_hms(paste(date,"11:00:00")), units="secs")) #3800
test<-rbind(test,test1) #306077

#lunch afternoon
test1 <- data_agg %>% filter(period_start=="lunch" & period_finish=="afternoon") %>% mutate(period = period_start,
                                                                                             period_dur = as.difftime(ymd_hms(paste(date,"14:00:00")) - start, units="secs")) #7598
test<-rbind(test,test1) #313675

test1 <- data_agg %>% filter(period_start=="lunch" & period_finish=="afternoon") %>% mutate(period = period_finish,
                                                                                             period_dur = as.difftime(finish - ymd_hms(paste(date,"14:00:00")), units="secs")) #7598
test<-rbind(test,test1) #321273


#lunch dinner
test1 <- data_agg %>% filter(period_start=="lunch" & period_finish=="dinner") %>% mutate(period = period_start,
                                                                                                 period_dur = as.difftime(ymd_hms(paste(date,"14:00:00")) - start, units="secs")) #5
test<-rbind(test,test1) #321278

test1 <- data_agg %>% filter(period_start=="lunch" & period_finish=="dinner") %>% mutate(period = "afternoon",
                                                                                                 period_dur = as.difftime(hms("17:00:00") - hms("14:00:00"), units="secs")) #5
test<-rbind(test,test1) #321283

test1 <- data_agg %>% filter(period_start=="lunch" & period_finish=="dinner") %>% mutate(period = period_finish,
                                                                                                 period_dur = as.difftime(finish - ymd_hms(paste(date,"17:00:00")), units="secs")) #5
test<-rbind(test,test1) #321288


#night early_late
test1 <- data_agg %>% filter(period_start=="night" & period_finish=="early_late") %>% mutate(period = period_start,
                                                                                            period_dur = as.difftime(ymd_hms(paste(date,"24:00:00")) - start, units="secs")) #2858
test<-rbind(test,test1) #324146

test1 <- data_agg %>% filter(period_start=="night" & period_finish=="early_late") %>% mutate(period = period_finish,
                                                                                            period_dur = as.difftime(finish - ymd_hms(paste(date,"24:00:00")), units="secs")) #2858
test1$date <- test1$date+1
test<-rbind(test,test1) #327004


##### summarise by rier_id, date, period
proficiency_new <- test %>% group_by(rider_id,date,period) %>% summarise(duration = sum(period_dur))
test1 <- proficiency_new %>% group_by(rider_id, date) %>% summarise(total_dur = sum(duration))
proficiency_new <- left_join(proficiency_new,test1)

proficiency_new$duration <- as.numeric(proficiency_new$duration)
proficiency_new$total_dur <- as.numeric(proficiency_new$total_dur)
proficiency_new <- proficiency_new %>% mutate(period_share = duration/total_dur)

proficiency_new <- left_join(proficiency_new,test_order)
proficiency_new$num_orders <- ifelse(is.na(proficiency_new$num_orders)==1,0,proficiency_new$num_orders)

proficiency_new <- proficiency_new %>% mutate(order_per_dur = num_orders/(duration/3600))
proficiency_new <- proficiency_new %>% mutate(weighted_order_per_dur =  period_share*order_per_dur)
proficiency_new <- proficiency_new %>% group_by(rider_id,date) %>% summarise(w_prof = sum(weighted_order_per_dur))
proficiency_new <- proficiency_new %>% filter(w_prof>0)
proficiency_new <- proficiency_new %>% filter(date<"2020-10-26") %>% group_by(rider_id) %>% summarise(avg_w_prof = mean(w_prof))
#9782는 outlier

##### prof_group #####
hist(proficiency_new$avg_w_prof, breaks=532)
hist(proficiency_new$avg_w_prof, breaks=532, xlim = c(2,11))
quantile(proficiency_new$avg_w_prof, probs = c(.33, .67))
#33%      67% 
#5.353572 6.472380
summary(proficiency_new$avg_w_prof)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#2.642   5.138   5.839   6.052   6.891  21.820 


test<-proficiency_new %>% filter(avg_w_prof<5.35) #174riders
test<-proficiency_new %>% filter(avg_w_prof>=5.35 & avg_w_prof<6.47) # 180riders
test<-proficiency_new %>% filter(avg_w_prof>=6.47) # 178riders
proficiency_new <- proficiency_new %>% mutate(w_prof_low = ifelse(avg_w_prof<5.35,1,0),
                                      w_prof_med = ifelse(avg_w_prof>=5.35 & avg_w_prof<6.47,1,0),
                                      w_prof_high = ifelse(avg_w_prof>=6.47,1,0))



##### merge with data sets
data_order <- left_join(data_order,proficiency_new)
daily_agg <- left_join(daily_agg,proficiency_new)
data_agg <- left_join(data_agg,proficiency_new)
pre_var <- left_join(pre_var, proficiency_new)


