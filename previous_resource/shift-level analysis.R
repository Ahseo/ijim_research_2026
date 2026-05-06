head(data_agg)
summary(data_agg$share_aiorders)

# shift내 주문개수, AI주문개수, 비율 plot
hist(data_agg$num_orders, breaks=100, main = "Number of orders in a shift", xlab="Number of orders"); summary(data_agg$num_orders)
hist(data_agg$num_aiorders, breaks=100, main = "Number of AI orders in a shift", xlab="Number of AI orders"); summary(data_agg$num_aiorders)
hist(data_agg$num_aiorders[data_agg$num_aiorders!=0], breaks=100, main = "Number of AI orders in a shift", xlab="Number of AI orders"); summary(data_agg$num_aiorders)
hist(data_agg$share_aiorders, breaks=100, main = "Share of AI orders in a shift", xlab="Share of AI orders"); summary(data_agg$share_aiorders)
hist(data_agg$share_aiorders[data_agg$share_aiorders!=0], breaks=100, main = "Share of AI orders in a shift", xlab="Share of AI orders"); summary(data_agg$share_aiorders)
hist(data_agg$total_duration/3600, breaks=100, main = "Total duration of a shift (hour)", xlab="Hours"); summary(data_agg$total_duration/3600)

test<-data_agg#%>%filter(share_aiorders!=0)
hist(test$share_aiorders[test$prof_low==1], breaks=100, main = "Share of AI orders in a shift (Novice)", xlab="Share of AI orders", xlim=c(0,1),ylim=c(0,5000)); summary(test$share_aiorders[test$prof_low==1])
hist(test$share_aiorders[test$prof_med==1], breaks=100, main = "Share of AI orders in a shift (Intermediate)", xlab="Share of AI orders", xlim=c(0,1),ylim=c(0,5000)); summary(test$share_aiorders[test$prof_med==1])
hist(test$share_aiorders[test$prof_high==1], breaks=100, main = "Share of AI orders in a shift (Advanced)", xlab="Share of AI orders", xlim=c(0,1),ylim=c(0,5000)); summary(test$share_aiorders[test$prof_high==1])


 # AI주문 비중
sum(data_agg$share_aiorders==0) #279340
sum(data_agg$share_aiorders==1) #11251
sum(data_agg$share_aiorders<1 & data_agg$share_aiorders>0)


# AI사용비율에 따른 변수 분포
boxplot(num_orders~ai_assist, data=data_agg)
boxplot(total_duration~ai_assist, data=data_agg)
boxplot(idle_btw_shifts~ai_assist, data=data_agg)

data1 <- data_agg %>% filter(prof_low==1)
data2 <- data_agg %>% filter(prof_med==1)
data3 <- data_agg %>% filter(prof_high==1)
boxplot(num_orders~ai_assist, data=data1, ylim=c(0,50))
boxplot(num_orders~ai_assist, data=data2, ylim=c(0,50))
boxplot(num_orders~ai_assist, data=data3, ylim=c(0,50))

boxplot(total_duration~ai_assist, data=data1)
boxplot(total_duration~ai_assist, data=data2)
boxplot(total_duration~ai_assist, data=data3)

plot(x=data_agg$share_aiorders, y=data_agg$total_duration)
plot(x=data_agg$share_aiorders, y=data_agg$idle_btw_shifts)

plot(x=data_agg$share_aiorders, y=data_agg$avg_assign)
plot(x=data_agg$share_aiorders, y=data_agg$avg_pickup)
plot(x=data_agg$share_aiorders, y=data_agg$avg_deliver)
plot(x=data_agg$share_aiorders, y=data_agg$avg_waiting)


# shift 시작된 시간대
data_agg$start_hour <- hour(data_agg$start)

test <- data_agg %>% group_by(start_hour, date) %>% summarise(total_shift = n(),
                                                              ai_shift = sum(ai_assist),
                                                              share_ai_shift = ai_shift/total_shift) %>%
  group_by(start_hour) %>% summarise(avg_total_shift = mean(total_shift),
                                     avg_aishift = mean(ai_shift),
                                     avg_share_aishift = mean(share_ai_shift))
plot(x=test$start_hour, y=test$avg_total_shift, type="l", xlab="Start hour of shift", ylab="Number of total shifts")
lines(x=test$start_hour, y=test$avg_aishift, col="blue")
plot(x=test$start_hour, y=test$avg_share_aishift, type="l", xlab="Start hour of shift", ylab="Share of AI-assisted shifts")
