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



### 우리가 보려고하는 추천배차 도입 라이더(treat_riders) 및 추천배차 도입 이후날짜 데이터만 subtract
length(unique(treat_riders$rider_id)) #400 riders


rec_change <- rec_change %>%  filter(rider_id %in% treat_riders$rider_id) %>%
  filter(date>="2020-10-26") #43,897rows

  

### 추천배차 켜진 duration 
#정렬
rec_change <- rec_change[order(rec_change$time),]
rec_change <- rec_change[order(rec_change$rider_id),]

rec_change <- rec_change %>% group_by(rider_id, date) %>%
  mutate(auto_duration = ifelse(type_auto==1, as.numeric(diff(time),units="mins"), NA))

### 일 추천배차 ON 횟수, 총 duration
rec_change_day <- rec_change %>% group_by(rider_id, date) %>% 
  summarise(num_on = length(which(type_auto==1)),
            num_off = length(which(type_auto==0)),
            diff = num_on-num_off,
            num_change = num_on+num_off-1,
            duration_on = sum(auto_duration, na.rm=T),
            keep_duration = duration_on/num_on)


### 숙련도변수 추가
rec_change_day <- left_join(rec_change_day, proficiency)


### rec_change_day = 전체 날짜, rec_change_dayon = 추천배차 사용한 날짜만
rec_change_dayon <- rec_change_day %>% filter(num_on >0)


################################################################################################################
##### AI도입시 초보자는 합배송 끝내고 idle time이 길어짐
##### -> 합배송 후 추천배차를 끌 것 -> Mean of num_change가 초보자일수록 높을것 #####
### 전체 날짜 데이터
mean(rec_change_day$num_change[rec_change_day$prof_low==1], na.rm=T) #3.460
mean(rec_change_day$num_change[rec_change_day$prof_med==1], na.rm=T) #3.146
mean(rec_change_day$num_change[rec_change_day$prof_high==1], na.rm=T) #2.552

model <- felm(num_change ~ prof_med + prof_high | date, data=rec_change_day)
summary(model)

mean(rec_change_day$num_on[rec_change_day$prof_low==1], na.rm=T) #1.782
mean(rec_change_day$num_on[rec_change_day$prof_med==1], na.rm=T) #1.629
mean(rec_change_day$num_on[rec_change_day$prof_high==1], na.rm=T) #1.343

mean(rec_change_day$duration_on[rec_change_day$prof_low==1], na.rm=T) #64.644
mean(rec_change_day$duration_on[rec_change_day$prof_med==1], na.rm=T) #49.159
mean(rec_change_day$duration_on[rec_change_day$prof_high==1], na.rm=T) #72.999

mean(rec_change_day$keep_duration[rec_change_day$prof_low==1], na.rm=T) #39.910
mean(rec_change_day$keep_duration[rec_change_day$prof_med==1], na.rm=T) #31.747
mean(rec_change_day$keep_duration[rec_change_day$prof_high==1], na.rm=T) #53.529

a<-rec_change_day %>% filter(prof_low==1)
b<-rec_change_day %>% filter(prof_med==1)
c<-rec_change_day %>% filter(prof_high==1)
t.test(b$num_change, c$num_change)
sd(rec_change_day$num_on[rec_change_day$prof_high==1], na.rm=T)

### 추천배차 사용 날짜만 필터링한 데이터
mean(rec_change_dayon$num_change[rec_change_dayon$prof_low==1]) #6.957
mean(rec_change_dayon$num_change[rec_change_dayon$prof_med==1]) #6.349
mean(rec_change_dayon$num_change[rec_change_dayon$prof_high==1]) #5.256
model <- felm(num_change ~ prof_med + prof_high, data=rec_change_dayon)
summary(model)
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   6.3492     0.1501  42.311  < 2e-16 ***
#   prof_low      0.6082     0.2109   2.884  0.00394 ** 
#   prof_high    -1.0934     0.2223  -4.919 8.96e-07 ***

mean(rec_change_dayon$num_on[rec_change_dayon$prof_low==1]) #3.583
mean(rec_change_dayon$num_on[rec_change_dayon$prof_med==1]) #3.288
mean(rec_change_dayon$num_on[rec_change_dayon$prof_high==1]) #2.764
model <- felm(num_on ~ prof_low + prof_high, data=rec_change_day)
summary(model)

mean(rec_change_dayon$duration_on[rec_change_dayon$prof_low==1]) #129.968
mean(rec_change_dayon$duration_on[rec_change_dayon$prof_med==1]) #99.220
mean(rec_change_dayon$duration_on[rec_change_dayon$prof_high==1]) #150.326
model <- felm(duration_on ~ prof_low + prof_high, data=rec_change_day)
summary(model)

mean(rec_change_dayon$keep_duration[rec_change_dayon$prof_low==1], na.rm=T) #38.910
mean(rec_change_dayon$keep_duration[rec_change_dayon$prof_med==1], na.rm=T) #31.747
mean(rec_change_dayon$keep_duration[rec_change_dayon$prof_high==1], na.rm=T) #53.529
model <- felm(keep_duration ~ prof_low + prof_high, data=rec_change_day)
summary(model)

a<-rec_change_dayon %>% filter(prof_low==1)
b<-rec_change_dayon %>% filter(prof_med==1)
c<-rec_change_dayon %>% filter(prof_high==1)
t.test(b$keep_duration, c$keep_duration)
sd(b$keep_duration)


### 매칭 데이터
rec_change_day_mat <- rec_change_day %>% filter(rider_id %in% matched_data1$rider_id) %>% filter(num_on >0)
mean(rec_change_day_mat$num_change[rec_change_day_mat$prof_low==1], na.rm=T) #6.305
sd(rec_change_day_mat$num_change[rec_change_day_mat$prof_low==1], na.rm=T) #5.977
mean(rec_change_day_mat$num_change[rec_change_day_mat$prof_med==1], na.rm=T) #5.832
sd(rec_change_day_mat$num_change[rec_change_day_mat$prof_med==1], na.rm=T) #6.069
mean(rec_change_day_mat$num_change[rec_change_day_mat$prof_high==1], na.rm=T) #4.397
sd(rec_change_day_mat$num_change[rec_change_day_mat$prof_high==1], na.rm=T) #3.873

mean(rec_change_day_mat$keep_duration[rec_change_day_mat$prof_low==1], na.rm=T) #21.447
mean(rec_change_day_mat$keep_duration[rec_change_day_mat$prof_med==1], na.rm=T) #30.006
mean(rec_change_day_mat$keep_duration[rec_change_day_mat$prof_high==1], na.rm=T) #37.777

a<-rec_change_day_mat %>% filter(prof_low==1)
b<-rec_change_day_mat %>% filter(prof_med==1)
c<-rec_change_day_mat %>% filter(prof_high==1)
t.test(b$num_change, c$num_change)

################################################################################################################
##### 초보자일수록 긴 합배송 끝내고 idle time이 김
##### -> 초보자일수록 긴합배송 이후 idle time 길것 #####
head(data_shift)

test <- data_shift %>% mutate(pre_orders1 = ifelse(pre_shift_orders==1,1,0),
                              pre_orders2 = ifelse(pre_shift_orders==2,1,0),
                              pre_orders3 = ifelse(pre_shift_orders==3,1,0),
                              pre_orders4 = ifelse(pre_shift_orders==4,1,0),
                              pre_orders5 = ifelse(pre_shift_orders==5,1,0),
                              pre_orders6 = ifelse(pre_shift_orders==6,1,0),
                              pre_orders7 = ifelse(pre_shift_orders==7,1,0),
                              pre_orders8 = ifelse(pre_shift_orders==8,1,0),
                              pre_orders9 = ifelse(pre_shift_orders==9,1,0),
                              pre_orders10 = ifelse(pre_shift_orders>=10,1,0))
model <- felm(idle_btw_shifts ~ prof_low:pre_shift_orders + prof_med:pre_shift_orders + prof_high:pre_shift_orders | rider_id + station_date + hourDOW, data=data_shift)
summary(model)
model <- felm(idle_btw_shifts ~ prof_low:pre_orders2 + prof_low:pre_orders3+ prof_low:pre_orders4 +prof_low:pre_orders5 + prof_low:pre_orders6 + prof_low:pre_orders7 + prof_low:pre_orders8 + prof_low:pre_orders9 + prof_low:pre_orders10 +
                prof_med:pre_orders2 + prof_med:pre_orders3+ prof_med:pre_orders4 +prof_med:pre_orders5 + prof_med:pre_orders6 + prof_med:pre_orders7 + prof_med:pre_orders8 + prof_med:pre_orders9 + prof_med:pre_orders10 +
                prof_high:pre_orders2 + prof_high:pre_orders3+ prof_high:pre_orders4 +prof_high:pre_orders5 + prof_high:pre_orders6 + prof_high:pre_orders7 + prof_high:pre_orders8 + prof_high:pre_orders9 + prof_high:pre_orders10 
              | rider_id + station_date + hourDOW, data=test)
summary(model)
model <- felm(idle_btw_shifts ~ pre_orders2 + pre_orders3 + pre_orders4 + pre_orders5 + pre_orders6 + pre_orders7 +
                pre_orders8 + pre_orders9 + pre_orders10 | rider_id + station_date + hourDOW, data=test)
summary(model)



##### Plotting
data_shift_pre <- data_shift %>% filter(After==0)

summary(unique(data_shift_pre$num_orders[data_shift_pre$prof_low==1])); hist(data_shift_pre$num_orders[data_shift_pre$prof_low==1], ylim=c(0,50))
summary(unique(data_shift_pre$num_orders[data_shift_pre$prof_med==1])); hist(data_shift_pre$num_orders[data_shift_pre$prof_med==1])
summary(unique(data_shift_pre$num_orders[data_shift_pre$prof_high==1])); hist(data_shift_pre$num_orders[data_shift_pre$prof_high==1]) 

# pre_shift_orders==14까지 50개이상임
test <- data.frame(x=rep(1:20,3), prof=rep(c("low","med","high"),each=20), idletime=rep(0,(20*3)), sd=rep(0,(20*3)))
for (i in 1:20){
  test$idletime[i] <- mean(data_shift_pre$idle_btw_shifts[data_shift_pre$pre_shift_orders==i & data_shift_pre$prof_low==1], na.rm=T)
  test$idletime[20+i] <- mean(data_shift_pre$idle_btw_shifts[data_shift_pre$pre_shift_orders==i & data_shift_pre$prof_med==1], na.rm=T)
  test$idletime[20*2+i] <- mean(data_shift_pre$idle_btw_shifts[data_shift_pre$pre_shift_orders==i & data_shift_pre$prof_high==1], na.rm=T)
}
for (i in 1:20){
  test$sd[i] <- sd(data_shift_pre$idle_btw_shifts[data_shift_pre$pre_shift_orders==i & data_shift_pre$prof_low==1], na.rm=T)
  test$sd[20+i] <- sd(data_shift_pre$idle_btw_shifts[data_shift_pre$pre_shift_orders==i & data_shift_pre$prof_med==1], na.rm=T)
  test$sd[20*2+i] <- sd(data_shift_pre$idle_btw_shifts[data_shift_pre$pre_shift_orders==i & data_shift_pre$prof_high==1], na.rm=T)
}

name <- "Mean Idle Time Before Stacked Orders"
dev.off()
xrange = c(1,20)
yrange = c(0,20)
ylabel = "Idle time (mins)"
plot(idletime~x, data=test, main=name, xlab="Order count in shift",
     ylab=ylabel, xaxt="n", ylim=yrange, pch=16, cex=1, col=prof)
axis(side = 1, at = 1:20, labels = F)
text(1:20, -2, labels = 1:20, pos = 1, xpd = TRUE)

ggplot(test) +
  geom_dotplot(aes(x=x, y=idletime), fill=test$prof) +
  geom_errorbar( aes(x=name, ymin=value-sd, ymax=value+sd), width=0.4, colour="orange", alpha=0.9, size=1.3)




###########################################
test<-data_shift_matched %>% filter(prof_low==1)
model <- felm(ln(idle_btw_shifts) ~  pre_shift_orders + After:Treat + After:pre_shift_orders + Treat:pre_shift_orders +
                After:Treat:pre_shift_orders | rider_id + station_date + hourDOW | 0 | riderDOW, data=test)
summary(model)



###########################################
library(tidyverse)
library(ggpubr)
library(rstatix)
library(broom)
data_order_pre <- data_order %>% filter(After==0)
data_shift_pre <- data_shift %>% filter(After==0)

data_shift_pre <- data_shift_pre %>% mutate(prof_group = ifelse(prof_low==1,"low",
                                                                ifelse(prof_med==1,"med","high")))
data_shift_pre$prof_group <- as.factor(data_shift_pre$prof_group)
data_order_pre <- data_order_pre %>% mutate(prof_group = ifelse(prof_low==1,"low",
                                                                ifelse(prof_med==1,"med","high")))
data_order_pre$prof_group <- as.factor(data_order_pre$prof_group)

data_shift_pre_1 <- data_shift_pre %>% filter(num_orders==1) # for single order delivery
data_shift_pre_2 <- data_shift_pre %>% filter(num_orders>=2) # for stacked order delivery

data_shift_pre_2$check <- paste(data_shift_pre_2$rider_id, data_shift_pre_2$date, data_shift_pre_2$shift, sep="_")
data_order_pre$check <- paste(data_order_pre$rider_id, data_order_pre$date, data_order_pre$shift, sep="_")
data_order_pre_stacked <- left_join(data_order_pre_)
data_order_pre_one <- data_order_pre %>% filter(check %!in% data_shift_pre_2$check)

boxplot(avg_deliver ~ prof_group,
        data = data_shift_pre,
        main = "Avg. pickup to drop-off time",
        xlab = "Group",ylab = "Time",
        border = "black", ylim=c(0,20))


#delivery time in shift
test <- data_order_pre %>% group_by(prof_group) %>% summarise(mean_delivery = mean(delivery_min))
test <- data_order_pre_one %>% group_by(prof_group) %>% summarise(mean_delivery = mean(delivery_min))
test <- data_order_pre_stack %>% group_by(prof_group) %>% summarise(mean_delivery = mean(delivery_min))
test <- data_shift_pre_2 %>% group_by(prof_group) %>% summarise(mean_orders = mean(num_orders))


sd(data_shift_pre_2$num_orders[data_shift_pre_2$prof_high==1]) #sd
t.test(data_shift_pre_2$num_orders[data_shift_pre_2$prof_med==1], data_shift_pre_2$num_orders[data_shift_pre_2$prof_high==1]) #mean
sum(data_shift_pre_2$prof_high==1) #obs

ancova_model<-aov(avg_deliver ~ avg_dist + prof_group, data=data_shift_pre_1)
Anova(ancova_model, type="III")
postHocs <- glht(ancova_model, linfct = mcp(prof_group = c("low - med = 0",
                                                           "low - high = 0",
                                                           "med - high = 0")))
summary(postHocs)

ancova_model<-aov(avg_deliver ~ avg_dist + num_orders + prof_group, data=data_shift_pre_2)
Anova(ancova_model, type="III")
postHocs <- glht(ancova_model, linfct = mcp(prof_group = c("low - med = 0",
                                                           "low - high = 0",
                                                           "med - high = 0")))
summary(postHocs)

ancova_model<-aov(num_orders ~ prof_group, data=data_shift_pre_2)
Anova(ancova_model, type="III")
postHocs <- glht(ancova_model, linfct = mcp(prof_group = c("low - med = 0",
                                                           "low - high = 0",
                                                           "med - high = 0")))
summary(postHocs)






