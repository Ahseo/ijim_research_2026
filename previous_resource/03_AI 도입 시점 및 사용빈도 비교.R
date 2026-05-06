##### 도입 시점 plotting #####
test <- data_order %>% filter(is_rec_completed==1) %>% group_by(rider_id) %>% summarise(date_adopt = min(date))
test <- test %>% group_by(date_adopt) %>% summarise(AI_adoption=n())

date_stamp <- data.frame(date = unique(daily_agg$date))
date_stamp <- date_stamp %>% filter(date>="2020-10-26")

colnames(test)[1]<-"date"
test <- left_join(date_stamp, test); remove(date_stamp)
test$AI_adoption <- ifelse(is.na(test$AI_adoption)==1,0,test$AI_adoption)
test$days <- 1:nrow(test)

barplot(AI_adoption~days, data=test,
        main = "Number of riders who adopt AI by days")

# test <- data_2m %>% filter(is_rec_completed==1) %>% group_by(rider_id) %>% summarise(date_adopt = min(date))
# test <- test %>% group_by(date_adopt) %>% summarise(AI_adoption=n())
# test <- test %>% mutate(days = as.Date(date_adopt) - as.Date("2020-10-26"))
# barplot(AI_adoption~days, data=test, width = 1, ylim=c(0,300),
#         main = "Number of riders who adopt AI by days")


##### 숙련도에 따른 AI주문 개수 및 비율 확인 #####
length(unique(data_order$rider_id[data_order$prof_high==1])) # low 174(처치138/통제36), med 184(133/51), high 174명(98/76)
length(unique(data_order_matched$rider_id[data_order_matched$Treat==0 & data_order_matched$prof_low==1])) # low 65(처치31/통제34), med 114(64/50), high 119명(54/65)

test1 <- data_order_matched %>% filter(prof_low==1 & Treat==1) %>% group_by(rider_id, date) %>% summarise(num_aiorders = sum(is_rec_completed),
                                                                                                  total_orders = n(),
                                                                                                  aishare = num_aiorders/total_orders) %>%
  group_by(date) %>% summarise(avg_aiorders = mean(num_aiorders),
                               avg_aishare = mean(aishare)) %>% 
  mutate(prof_group="1_low")

test2 <- data_order_matched %>% filter(prof_med==1 & Treat==1) %>% group_by(rider_id, date) %>% summarise(num_aiorders = sum(is_rec_completed),
                                                                                                  total_orders = n(),
                                                                                                  aishare = num_aiorders/total_orders) %>%
  group_by(date) %>% summarise(avg_aiorders = mean(num_aiorders),
                               avg_aishare = mean(aishare)) %>% 
  mutate(prof_group="2_med")


test3 <- data_order_matched %>% filter(prof_high==1 & Treat==1) %>% group_by(rider_id, date) %>% summarise(num_aiorders = sum(is_rec_completed),
                                                                                                   total_orders = n(),
                                                                                                   aishare = num_aiorders/total_orders) %>%
  group_by(date) %>% summarise(avg_aiorders = mean(num_aiorders),
                               avg_aishare = mean(aishare)) %>% 
  mutate(prof_group="3_high")

test <- rbind(test1,test2) %>% rbind(test3)
remove(test1,test2,test3)

summary(aov(avg_aiorders~prof_group, data=test))
summary(aov(avg_aishare~prof_group, data=test))

ggplot(test, aes(x=date, y=avg_aiorders, color=prof_group)) + geom_line() + labs(title="Avg. number of AI orders",y="Number of AI orders", color="Group")
ggplot(test, aes(x=date, y=avg_aishare, color=prof_group)) + geom_line() + labs(title="Avg. share of AI orders",y="Share of AI orders", color="Group")



##### 숙련도에 따른 AI 주문 총 개수 분포 #####
test1 <- data_order_matched %>% filter(prof_low==1 & Treat==1) %>% group_by(rider_id) %>% summarise(num_aiorders = sum(is_rec_completed)) %>% mutate(Group="1_low")
test2 <- data_order_matched %>% filter(prof_med==1 & Treat==1) %>% group_by(rider_id) %>% summarise(num_aiorders = sum(is_rec_completed)) %>% mutate(Group="2_med")
test3 <- data_order_matched %>% filter(prof_high==1 & Treat==1) %>% group_by(rider_id) %>% summarise(num_aiorders = sum(is_rec_completed)) %>% mutate(Group="3_high")
test <- rbind(test1,test2) %>% rbind(test3)
remove(test1,test2,test3)

ggplot(test, aes(x=num_aiorders)) + 
  geom_histogram(fill="black",color="black", alpha=0.6, binwidth=1) +
  xlim(c(0,1000)) + ylim(c(0,25)) +
  facet_grid(Group ~ .)


##### shift/day내 AI order 비율
head(data_agg)
hist(data_agg$share_aiorders, breaks=10000)
hist(data_agg$share_aiorders[data_agg$share_aiorders%!in%c(0,1)], breaks=1000, main="Share of AI orders in a shift", xlab="Share")
sum(data_agg$share_aiorders==1) # 11251 shifts
sum(data_agg$share_aiorders==0) # 279339 shifts


##### 시간대별 demand #####
head(data_order)
test <- data_order %>% group_by(date, hour) %>% summarise(demand = n())
test <- test %>% group_by(hour) %>% summarise(demand = mean(demand))
plot(x=test$hour, y=test$demand, type="l", main="Demand by day of hours", xlab="hour")



##### 라이더별 추천배차 사용빈도 #####
test <- data_order %>% filter(rider_id %in% treat_riders$rider_id) %>% filter(date>="2020-10-26") %>% 
  group_by(rider_id) %>% summarise(total_orders = n(),
                                   ai_orders = sum(is_rec_completed),
                                   non_ai_orders = total_orders-ai_orders,
                                   share_aiorders = ai_orders/n())
hist(test$ai_orders,breaks=369, main="Total AI orders", xlab="Riders")
summary(test$ai_orders)

test<-test[order(test$total_orders, decreasing=FALSE),]
test$id <- 1:nrow(test)

colnames(test)[3:4] <- c("ai_orders","non_ai_orders")
test <- melt(test, id.vars="id", measure.vars=c("non_ai_orders","ai_orders"))

ggplot() + geom_bar(data = test, aes(x = id, y = value, fill = variable), stat="identity") +
  scale_fill_manual(values= c("#5F9EA0", "#E1B378"))

hist(test$share_aiorders, breaks=369, main="Share of AI orders", xlab="Riders")


##### 날짜별 추천배차 사용현황 #####
test <- data_order %>% group_by(rider_id, date) %>% summarise(total_orders = n(),
                                                              ai_orders = sum(is_rec_completed),
                                                              non_aiorders = total_orders-ai_orders)
test <- test %>% group_by(date) %>% summarise(ai_rider = length(unique(rider_id[ai_orders>0])),
                                              non_ai_rider = length(unique(rider_id))-ai_rider,
                                              total_rider = length(unique(rider_id)),
                                              share_ai_rider = ai_rider/total_rider,
                                              total_orders = sum(total_orders),
                                              ai_orders = sum(ai_orders),
                                              non_ai_orders = total_orders - ai_orders,
                                              share_ai_order = sum(ai_orders)/total_orders)
test <- test %>% filter(date>="2020-10-26")
plot(x=test$date, y=test$share_ai_rider, type="l", main = "Share of riders using AI", xlab="Date")
plot(x=test$date, y=test$share_ai_order, type="l", main = "Share of AI orders", xlab="Date")


test$days = 1:nrow(test)
test <- melt(test, id.vars="days", measure.var=c("non_ai_rider","ai_rider"))
ggplot() + geom_bar(data = test, aes(x = days, y = value, fill = variable), stat="identity") +
  scale_fill_manual(values= c("#5F9EA0", "#E1B378"))

test$days = 1:nrow(test)
test <- melt(test, id.vars="days", measure.var=c("non_ai_orders","ai_orders"))
ggplot() + geom_bar(data = test, aes(x = days, y = value, fill = variable), stat="identity") +
  scale_fill_manual(values= c("#5F9EA0", "#E1B378"))



##### 날짜별 시간대별 AI 추천배차 사용 지점 비율 #####
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

test <- station_hour_riders %>% group_by(date, assign_hour, date_assignhour) %>% summarise(num_stations = n(),
                                                                                           noai_stations = length(unique(management_partner_id[ai_riders==0])))
test <- test[order(test$assign_hour),]
test <- test[order(test$date),]
test$num_hour <- 1:nrow(test)
test$ai_stations <- test$num_stations - test$noai_stations
test <- melt(test, id.vars="num_hour", measure.vars=c("noai_stations","ai_stations"))
ggplot() + geom_bar(data = test, aes(x = num_hour, y = value, fill = variable), stat="identity") +
  scale_fill_manual(values= c("#5F9EA0", "#E1B378"))


##### 날짜별 시간대별 추천배차 사용 라이더 비율 -지점별 #####
station_list <- unique(data_order$management_partner_id)
date_list <- unique(data_order[,c(2,58)])

station_list[27]
station <- station_hour_riders[,1:7] %>% 
  filter(management_partner_id == station_list[27])
station$noai_riders <- station$total_riders-station$ai_riders
station<-left_join(date_list, station)
station <- station[order(station$assign_hour),]
station <- station[order(station$date),]
station$num_hour <- 1:nrow(station)
test <- melt(station, id.vars="num_hour", measure.vars=c("noai_riders","ai_riders"))
ggplot() + geom_bar(data = test, aes(x = num_hour, y = value, fill = variable), stat="identity") +
  scale_fill_manual(values= c("#5F9EA0", "#E1B378")) + xlim(0,1439) + geom_vline(xintercept = 679, color="red")


##### 시간대별 수요 대비 공급
test <- data_order %>% group_by(management_partner_id, date, assign_hour) %>% summarise(num_orders = n(),
                                                                 num_riders = length(unique(rider_id)),
                                                                 ds = num_orders/num_riders)
test <- test %>% group_by(assign_hour) %>% summarise(avg_ds = mean(ds))
plot(avg_ds~assign_hour, type="l", data=test)
