test <- data_day %>% group_by(date, After) %>% summarise(num_orders = sum(total_orders),
                                                         num_riders = length(unique(rider_id)),
                                                         rider_per_order = num_orders/num_riders)
t.test(num_orders~After, data=test) # 9.4% 감소
t.test(num_riders~After, data=test) # 8.1% 감소
t.test(rider_per_order~After, data=test) # 8.1% 감소

plot(num_orders~date, type="l", data=test)
plot(num_riders~date, type="l", data=test)


orders$After <- ifelse(orders$date >= as.Date("2020-10-26"),1,0)
test <- orders %>% group_by(date, After) %>% summarise(num_orders = n(),
                                                       num_riders = length(unique(rider_id)),
                                                       rider_per_order = num_orders/num_riders)
test <- test %>% filter(date>=as.Date("2020-09-26"))
t.test(num_orders~After, data=test) # 변함없음
t.test(num_riders~After, data=test) # 변함없음
t.test(rider_per_order~After, data=test) # 변함없음

plot(num_orders~date, type="l", data=test)
plot(num_riders~date, type="l", data=test)







test <- data_day %>% group_by(date, After) %>% summarise(num_orders = sum(total_orders),
                                                    num_riders = length(unique(rider_id)),
                                                    order_per_rider = num_orders/num_riders)
test$date <- as.character(test$date)
test$wb5 <- ifelse(test$date %in% c("2020-09-26", "2020-09-27"),1,0)
test$wb4 <- ifelse(test$date %in% c("2020-09-28", "2020-09-29", "2020-09-30", "2020-10-01", "2020-10-02", "2020-10-03", "2020-10-04"), 1, 0)
test$wb3 <- ifelse(test$date %in% c("2020-10-05", "2020-10-06", "2020-10-07", "2020-10-08", "2020-10-09", "2020-10-10", "2020-10-11"), 1, 0)
test$wb2 <- ifelse(test$date %in% c("2020-10-12", "2020-10-13", "2020-10-14", "2020-10-15", "2020-10-16", "2020-10-17", "2020-10-18"), 1, 0)
test$wb1 <- ifelse(test$date %in% c("2020-10-19", "2020-10-20", "2020-10-21", "2020-10-22", "2020-10-23", "2020-10-24", "2020-10-25"), 1, 0)
test$w1 <- ifelse(test$date %in% c("2020-10-26", "2020-10-27", "2020-10-28", "2020-10-29", "2020-10-30", "2020-10-31", "2020-11-01"), 1, 0)
test$w2 <- ifelse(test$date %in% c("2020-11-02", "2020-11-03", "2020-11-04", "2020-11-05", "2020-11-06", "2020-11-07", "2020-11-08"), 1, 0)
test$w3 <- ifelse(test$date %in% c("2020-11-09", "2020-11-10", "2020-11-11", "2020-11-12", "2020-11-13", "2020-11-14", "2020-11-15"), 1, 0)
test$w4 <- ifelse(test$date %in% c("2020-11-16", "2020-11-17", "2020-11-18", "2020-11-19", "2020-11-20", "2020-11-21", "2020-11-22"), 1, 0)
test$w5 <- ifelse(test$date %in% c("2020-11-23", "2020-11-24", "2020-11-25", "2020-11-26", "2020-11-27", "2020-11-28", "2020-11-28"), 1, 0)
test$w6 <- ifelse(test$date %in% c("2020-11-29", "2020-11-30"), 1, 0)
test$date <- as.Date(test$date)

t.test(num_orders~After, data=test) # 감소
t.test(num_riders~After, data=test) # 감소
t.test(order_per_rider~After, data=test) # 변함없음

a <- felm(ln(num_orders) ~ After, data=test)
summary(a)
a <- felm(ln(num_riders) ~ After, data=test)
summary(a)
a <- felm(ln(order_per_rider) ~ wb5 + wb4 + wb3 + wb2 + w1 + w2 + w3 + w4+ w5 + w6, data=test)
summary(a)
a <- felm(ln(order_per_rider) ~ After, data=test)
summary(a)

yrange = c(0,16500)
plot(test$date, test$num_orders, type="l", xlab="date", ylab="Daily orders in platform", ylim = yrange)
yrange = c(0,500)
plot(test$date, test$num_riders, col="blue", type="l", ylim=yrange,xlab="date", ylab="Daily riders in platform")

yrange = c(0,50)
plot(test$order_per_rider~test$date, type="l", xlab="date", ylab="Daily demand-supply ratio", col="red", ylim = yrange)
