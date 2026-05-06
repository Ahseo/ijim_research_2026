##### Executing matching algorithm: one-to-one matching w/o replacement with a caplier size 0.2 times the s.d. of the propensity 
### 1회만 사용 라이더 제외
length(unique(matched_data$rider_id %in% ))
test_pre_var_nona <- pre_var_nona %>% filter(rider_id %!in% test_onlyoneai$rider_id)
test<-pre_var_nona %>% mutate(Treat_rev = ifelse(Treat==1,0,1))
psmatch <- matchit(Treat_rev ~ avg_assign + avg_pickup + avg_deliver + avg_ODdist +
                     num_working_days + tenure + 
                     median_idle_shift +
                     avg_total_shift + avg_share_aggshift + avg_orders_aggshift + avg_duration_aggshift +
                     avg_working_duration + avg_idle_duration +
                     daily_total_order + avg_orders_per_workingd,
                   method="nearest", data=test, caliper=0.2, std.caliper=TRUE, discard = "both", ratio=2)

summary(psmatch)
plot(psmatch)

# matching 결과 확인
kable(psmatch$nn, digits = 2, align = 'c', 
      caption = 'Table 2: Sample sizes')

# matching 결과 저장
matched_data <- match.data(psmatch)
write.csv(matched_data, "psm_result1(caliper0.2, no replace).csv")

### Machted data
final_cov <- colnames(pre_var_nona[,c(2:6,9:11,14:16,21:31)])
test <- matched_data %>% group_by(Treat) %>% dplyr::select(one_of(final_cov)) %>%
  summarise_all(funs(mean(., na.rm=T)))

test <- data.frame(tvalue=rep(1,length(final_cov)), pvalue=rep(1,length(final_cov)))
for (i in 1:length(final_cov)){
  a<-t.test(matched_data[, final_cov[i]] ~ matched_data[, 'Treat'])
  test$tvalue[i] <- a$statistic
  test$pvalue[i] <- a$p.value  
}



# 오더레벨 데이터
data_order_matched <- data_order %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,35)])


# 합배송 데이터, 합배송 일별 데이터
data_agg_matched <- data_agg %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,35)])
daily_agg_matched <- daily_agg %>% filter(rider_id %in% matched_data$rider_id) %>% left_join(matched_data[,c(1,35)])




##### Model estimation after matching #####
#오더레벨 데이터
data_order_matched$station_date <- paste(data_order_matched$management_partner_id, data_order_matched$date)
model <- felm(ln(assign_sec+1) ~ After:Treat | rider_id + station_date + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(assign_sec+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(pickup_sec+1) ~ After:Treat | rider_id + station_date + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(pickup_sec+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(delivery_sec) ~ After:Treat | rider_id + station_date + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(delivery_sec) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)

model <- felm(ln(waiting_sec) ~ After:Treat | rider_id + station_date + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model <- felm(ln(waiting_sec) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date + OD | 0 | rider_id, data=data_order_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)

####################################################################################################################################
#합배송 데이터
head(data_agg_matched)
data_agg_matched$station_date <- paste(data_agg_matched$management_partner_id, data_agg_matched$date)

model <- felm(ln(num_orders) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_agg_matched)
summary(model)
model <- felm(ln(num_orders) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_agg_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(total_duration) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_agg_matched)
summary(model)
model <- felm(ln(total_duration) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_agg_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)

#test<-data_agg_matched %>% group_by(rider_id,date) %>% mutate(lag_numorders = lag(num_orders))
test<-na.omit(data_agg_matched)
model <- felm(ln(idle_btw_shifts) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=data_agg_matched)
summary(model)
model <- felm(ln(idle_btw_shifts) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=data_agg_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)

########################################################################################################################
##### Daily 분석 #####
########################################################################################################################
head(daily_agg_matched)

model <- felm(ln(total_orders) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model <- felm(ln(total_orders) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(total_shift) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model <- felm(ln(total_shift) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(working_duration) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model <- felm(ln(working_duration) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)


model <- felm(ln(idle_duration+1) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model <- felm(ln(idle_duration+1) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id +station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)



model <- felm(ln(orders_per_workingd) ~ After:Treat | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model <- felm(ln(orders_per_workingd) ~ After:Treat+
                After:Treat:prof_med + After:Treat:prof_high | rider_id + station_date | 0 | rider_id, data=daily_agg_matched)
summary(model)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_med = 0")); summary(model_check)
model_check <- glht(model, linfct = c("After:Treat + After:Treat:prof_high = 0")); summary(model_check)



