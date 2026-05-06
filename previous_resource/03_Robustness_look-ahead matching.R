################################################################################################
##### CEM (coarsened exact matching) #####
################################################################################################
library(tidyverse)

cem1 <- matchit(Treat ~  daily_delivered_stores + num_working_days +
                  avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                  daily_total_labor + daily_idle_duration,
                data=pre_var_nona, method="cem", etimand = "ATE")

summary(cem1, un=FALSE)

# Extract matched data -------------------------
matched_cem1_df <- match.data(cem1) %>% arrange(subclass, Treat)

# Perform CEM with custom coarsening --------------------
# daily_delivered_stores + num_working_days +
# avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
#  daily_total_labor + daily_idle_duration
summary(pre_var_nona$daily_delivered_stores); quantile(pre_var_nona$daily_delivered_stores, prob=c(0.33, 0.66))
summary(pre_var_nona$num_working_days); quantile(pre_var_nona$num_working_days, prob=c(0.33, 0.66))
summary(pre_var_nona$avg_waiting_shift); quantile(pre_var_nona$avg_waiting_shift, prob=c(0.33, 0.66))
summary(pre_var_nona$avg_orders_shift); quantile(pre_var_nona$avg_orders_shift, prob=c(0.33, 0.66))
summary(pre_var_nona$avg_duration_shift); quantile(pre_var_nona$avg_duration_shift, prob=c(0.33, 0.66))
summary(pre_var_nona$avg_idle_shift); quantile(pre_var_nona$avg_idle_shift, prob=c(0.33, 0.66))
summary(pre_var_nona$daily_total_labor); quantile(pre_var_nona$daily_total_labor, prob=c(0.33, 0.66))
summary(pre_var_nona$daily_idle_duration); quantile(pre_var_nona$daily_idle_duration, prob=c(0.33, 0.66))
cutpoints <- list(daily_delivered_stores = c(10.94, 17.47),
                  num_working_days = c(5, 6),
                  avg_waiting_shift = c(14.35, 20.21),
                  avg_orders_shift = c(2.15, 3.58),
                  avg_duration_shift = c(24.17, 38.44),
                  avg_idle_shift = c(7.28, 10.03),
                  daily_total_labor = c(5.06, 7.86),
                  daily_idle_duration = c(0.77, 1.40))
cem2 <- matchit(Treat ~  daily_delivered_stores + num_working_days +
                  avg_waiting_shift + avg_orders_shift + avg_duration_shift + avg_idle_shift +
                  daily_total_labor + daily_idle_duration,
                data = pre_var_nona, method = 'cem', estimand = 'ATE', cutpoints=cutpoints)
summary(cem2, un=FALSE)

# Extract matched data -------------------------
matched_cem2_df <- match.data(cem2) %>% arrange(subclass, Treat)

# T-test -------------------------
test <- matched_cem2_df %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
for (i in 1:length(pretreat_cov)){
  a<-t.test(matched_cem2_df[, pretreat_cov[i]] ~ matched_cem2_df[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}

# Extract order, shift, day data ------------------------
cem_shift_matched <- data_shift %>% filter(rider_id %in% matched_cem2_df$rider_id) %>% left_join(matched_cem2_df[,c(1,38)])
cem_day_matched <- data_day %>% filter(rider_id %in% matched_cem2_df$rider_id) %>% left_join(matched_cem2_df[,c(1,38)])


# Run model -----------------------------
# shift-level -----
m1 <- felm(num_orders ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=cem_shift_matched)
m2 <- felm(total_duration ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=cem_shift_matched)
m3 <- felm(avg_duration_orders ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=cem_shift_matched)
m4 <- felm(idle_btw_shifts ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=cem_shift_matched)
tab_model(m1,m2,m3,m4,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))

# day-level -----
m1 <- felm(orders_per_hour ~ After:Treat | rider_id + station_date | 0 | rider_id, data=cem_day_matched)
summary(m1)
m1 <- felm(orders_per_hour ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=cem_day_matched)
summary(m1)

m1 <- felm(total_shift ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=cem_day_matched)
m2 <- felm(total_orders ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=cem_day_matched)
m3 <- felm(total_fee ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=cem_day_matched)
m4 <- felm(working_duration ~ After:Treat:prof_low + After:Treat:prof_med  + After:Treat:prof_high +
             After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=cem_day_matched)
tab_model(m1,m2,m3,m4,
          df.method = "wald",
          show.ci = F, show.se = T, collapse.se = T, show.ngroups = F, show.r2 = T,
          p.threshold = c(0.1, 0.05, 0.01), p.style = "stars",
          digits=3,
          rm.terms = c("After:prof_med", "After:prof_high"))


################################################################################################
##### Look-ahead matching #####
################################################################################################
head(treat_riders)

sum(treat_riders$adopt_date==as.Date("2020-10-26")) # 195
sum(treat_riders$adopt_date==as.Date("2020-10-27")) # 62
sum(treat_riders$adopt_date==as.Date("2020-10-28")) # 14
sum(treat_riders$adopt_date==as.Date("2020-10-29")) # 21
sum(treat_riders$adopt_date==as.Date("2020-10-30")) # 10
sum(treat_riders$adopt_date==as.Date("2020-10-31")) # 17
sum(treat_riders$adopt_date==as.Date("2020-11-01")) # 6


# 데이터 기간 마지막 2주(2020-11-09 ~ 2020-11-30) 내 도입한 라이더 
sum(treat_riders$adopt_date>as.Date("2020-11-08")) #44명
# 데이터 기간 마지막 1주(2020-11-09 ~ 2020-11-30) 내 도입한 라이더 
sum(treat_riders$adopt_date>as.Date("2020-11-01")) #75명
# AI 도입 첫 이틀 이후(2020-10-28 ~ 2020-11-30) 이후 도입한 라이더 
sum(treat_riders$adopt_date>=as.Date("2020-10-28")) # 143명
lateadopter <- treat_riders %>% filter(adopt_date>=as.Date("2020-11-09"))

### matching covariate, data ###
lookahead_prevar <- pre_var_nona %>% filter(Treat==1)
colnames(lookahead_prevar)
lookahead_prevar <- lookahead_prevar[,-36]
lookahead_prevar$Treat <- ifelse(lookahead_prevar$rider_id %in% lateadopter$rider_id,0,1)

lookahead_shift <- data_shift %>% filter(rider_id %in% treat_riders$rider_id)
colnames(lookahead_shift); length(unique(lookahead_shift$rider_id))
lookahead_shift <- lookahead_shift[,-20]
lookahead_shift$Treat <- ifelse(lookahead_shift$rider_id %in% lateadopter$rider_id,0,1)

lookahead_day <- data_day %>% filter(rider_id %in% treat_riders$rider_id)
colnames(lookahead_day); length(unique(lookahead_day$rider_id))
lookahead_day <- lookahead_day[,-2]
lookahead_day$Treat <- ifelse(lookahead_day$rider_id %in% lateadopter$rider_id,0,1)


### matching algorithm ###
lookahead_ps1 <- matchit(Treat ~  daily_delivered_stores + num_working_days + 
                           avg_waiting_shift + avg_orders_shift + avg_duration_shift + 
                           daily_total_labor + daily_idle_duration,
                         method="nearest", data=lookahead_prevar, caliper=0.01, std.caliper=TRUE, discard = "both")
summary(lookahead_ps1)

### matched data
matched_data <- match.data(lookahead_ps1)


#### Machted data에 대한 T-test #####
test <- matched_data %>% group_by(Treat) %>% dplyr::select(one_of(pretreat_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(pretreat_cov)), pvalue=rep(1,length(pretreat_cov)))
for (i in 1:length(pretreat_cov)){
  a<-t.test(matched_data[, pretreat_cov[i]] ~ matched_data[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}


##### 데이터 추출 #####
lookahead_shift_matched <- lookahead_shift %>% filter(rider_id %in% matched_data$rider_id) %>% filter(date < as.Date("2020-11-09"))
lookahead_day_matched <- lookahead_day %>% filter(rider_id %in% matched_data$rider_id) %>% filter(date < as.Date("2020-11-09"))
length(unique(lookahead_shift_matched$rider_id))
length(unique(lookahead_day_matched$rider_id))


################################################################################################################################################
##### DID, DDD model estimation #####
################################################################################################################################################
####################################################################################################################################
head(data_shift_matched)

model <- felm(ln(avg_waiting) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low15 + After:Treat:prof_med70 + After:Treat:prof_high15 + 
                After:prof_med70 + After:prof_high15 | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)



model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=lookahead_shift_matched)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=lookahead_shift_matched)
summary(model)


test<-data_shift_matched %>% filter(num_orders >=2)
model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)



model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)



test<-data_shift_matched %>% filter(num_orders == 1)
model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)



test<-data_shift_matched %>% filter(num_orders >=2)
model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=test)
summary(model)




model <- felm(ln(avg_duration_orders) ~ After:Treat | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat:prof_low50 + After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_duration_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)




model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat + After:Treat:prof + After:prof | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)



model <- felm(ln(avg_dist) ~ After:Treat | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_dist) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date + hourDOW | 0 | riderDOW, data=data_shift_matched)
summary(model)
model <- felm(ln(avg_dist) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data=data_shift_matched)
summary(model)





########################################################################################################################
head(data_day_matched)

model <- felm(ln(total_orders) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_orders) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_orders) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)




model <- felm(ln(total_shift) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_shift) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_shift) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)



model <- felm(share_aggshift ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_aggshift ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_aggshift ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)



model <- felm(ln(working_duration) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(working_duration) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(working_duration) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)



model <- felm(ln(idle_duration+1) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(idle_duration+1) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(idle_duration+1) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)



model <- felm(ln(total_labor) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_labor) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_labor) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)




model <- felm(share_idled ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_idled ~ After:Treat+ After:Treat:prof + After:prof | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_idled ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_idled ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + 
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)



model <- felm(ln(orders_per_hour) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=lookahead_day_matched)
summary(model)
model <- felm(ln(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=lookahead_day_matched)
summary(model)
model <- felm(ln(orders_per_hour) ~ After:Treat:prof_low15 + After:Treat:prof_med70 + After:Treat:prof_high15 +
                After:prof_med70 + After:prof_high15 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)



model <- felm(ln(total_fee) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(total_fee) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_date, data=data_day_matched)
summary(model)
model <- felm(ln(total_fee) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high +
                After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(total_fee) ~ After:Treat+
                After:Treat:prof_med70 + After:Treat:prof_high15 | rider_id + station_date | 0 | rider_date, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med70 = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high15 = 0")); summary(model_check)



model <- felm(ln(avg_waiting) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(avg_waiting) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(ln(avg_waiting) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)



model <- felm(ln(var_waiting) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(ln(var_waiting) ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(ln(var_waiting) ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(ln(var_waiting) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)



model <- felm(share_failedorders ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model <- felm(share_failedorders ~ After:Treat:prof_low50+ After:Treat:prof_high50 + After:prof_high50 | rider_id + station_date | 0 | rider_id, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
model <- felm(share_failedorders ~ After:Treat | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model <- felm(share_failedorders ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | riderDOW, data=data_day_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)
