head(daily_agg)

### 전체 평균
t.test(total_shift~After_ind, data=daily_agg) # 증가, 유의x
t.test(share_aggshift~After_ind, data=daily_agg) # 감소, 유의x
t.test(mean_orders_aggshift~After_ind, data=daily_agg) # 감소, 유의x
t.test(mean_duration_aggshift~After_ind, data=daily_agg) # 감소, 유의x
t.test(working_duration~After_ind, data=daily_agg) # 감소, 유의(5%)
t.test(idle_duration~After_ind, data=daily_agg) # 증가, 유의x
t.test(total_labor~After_ind, data=daily_agg) # 증가, 유의(5%)
t.test(total_orders~After_ind, data=daily_agg) # 감소, 유의x
t.test(share_workingd~After_ind, data=daily_agg) # 감소, 유의x
t.test(share_idled~After_ind, data=daily_agg) # 증가, 유의x
t.test(orders_per_workingd~After_ind, data=daily_agg) # 감소, 유의
t.test(profit~After_ind, data=daily_agg) # 감소, 유의


### 초보자
daily_low <- daily_agg %>% filter(prof_low==1)
t.test(total_shift~After_ind, data=daily_low) # 감소, 유의x
t.test(share_aggshift~After_ind, data=daily_low) # 증가, 유의
t.test(mean_orders_aggshift~After_ind, data=daily_low) # 증가, 유의
t.test(mean_duration_aggshift~After_ind, data=daily_low) # 증가, 유의(5%)
t.test(working_duration~After_ind, data=daily_low) # 증가, 유의(1%)
t.test(idle_duration~After_ind, data=daily_low) # 감소, 유의x
t.test(total_labor~After_ind, data=daily_low) # 감소, 유의x
t.test(total_orders~After_ind, data=daily_low) # 증가, 유의(5%)
t.test(share_workingd~After_ind, data=daily_low) # 증가, 유의(1%)
t.test(share_idled~After_ind, data=daily_low) # 감소, 유의(1%)
t.test(orders_per_workingd~After_ind, data=daily_low) # 증가, 유의
t.test(profit~After_ind, data=daily_low) # 증가, 유의

remove(daily_low)

### 중급자
daily_med <- daily_agg %>% filter(prof_med==1)
t.test(total_shift~After_ind, data=daily_med) # 감소, 유의x
t.test(share_aggshift~After_ind, data=daily_med) # 감소, 유의x
t.test(mean_orders_aggshift~After_ind, data=daily_med) # 감소, 유의(5%)
t.test(mean_duration_aggshift~After_ind, data=daily_med) # 감소, 유의(5%)
t.test(working_duration~After_ind, data=daily_med) # 감소, 유의x
t.test(idle_duration~After_ind, data=daily_med) # 증가, 유의(5%)
t.test(total_labor~After_ind, data=daily_med) # 감소, 유의x
t.test(total_orders~After_ind, data=daily_med) # 감소, 유의x
t.test(share_workingd~After_ind, data=daily_med) # 증가, 유의(5%)
t.test(share_idled~After_ind, data=daily_med) # 감소, 유의(5%)
t.test(orders_per_workingd~After_ind, data=daily_med) # 감소, 유의
t.test(profit~After_ind, data=daily_med) # 감소, 유의

remove(daily_med)

### 상급자
daily_high<- daily_agg %>% filter(prof_high==1)
t.test(total_shift~After_ind, data=daily_high) # 증가, 유의(5%)
t.test(share_aggshift~After_ind, data=daily_high) # 감소, 유의
t.test(mean_orders_aggshift~After_ind, data=daily_high) # 감소, 유의(1%)
t.test(mean_duration_aggshift~After_ind, data=daily_high) # 감소, 유의(5%)
t.test(working_duration~After_ind, data=daily_high) # 증가, 유의x
t.test(idle_duration~After_ind, data=daily_high) # 증가, 유의
t.test(total_labor~After_ind, data=daily_high) # 감소, 유의x
t.test(total_orders~After_ind, data=daily_high) # 감소, 유의(10%)
t.test(share_workingd~After_ind, data=daily_high) # 감소, 유의
t.test(share_idled~After_ind, data=daily_high) # 증가, 유의
t.test(orders_per_workingd~After_ind, data=daily_high) # 감소, 유의
t.test(profit~After_ind, data=daily_high) # 감소, 유의(10%)



