##### Table2. Descriptive Statistics for rider group in pretreatment period #####
mean(pre_var_nona$avg_orders_shift[pre_var_nona$prof_low==1]); mean(pre_var_nona$avg_orders_shift[pre_var_nona$prof_med==1]); mean(pre_var_nona$avg_orders_shift[pre_var_nona$prof_high==1])
sd(pre_var_nona$avg_orders_shift[pre_var_nona$prof_low==1]); sd(pre_var_nona$avg_orders_shift[pre_var_nona$prof_med==1]); sd(pre_var_nona$avg_orders_shift[pre_var_nona$prof_high==1])

mean(pre_var_nona$avg_duration_shift[pre_var_nona$prof_low==1]); mean(pre_var_nona$avg_duration_shift[pre_var_nona$prof_med==1]); mean(pre_var_nona$avg_duration_shift[pre_var_nona$prof_high==1])
sd(pre_var_nona$avg_duration_shift[pre_var_nona$prof_low==1]); sd(pre_var_nona$avg_duration_shift[pre_var_nona$prof_med==1]); sd(pre_var_nona$avg_duration_shift[pre_var_nona$prof_high==1])

mean(pre_var_nona$avg_duration_orders[pre_var_nona$prof_low==1]); mean(pre_var_nona$avg_duration_orders[pre_var_nona$prof_med==1]); mean(pre_var_nona$avg_duration_orders[pre_var_nona$prof_high==1])
sd(pre_var_nona$avg_duration_orders[pre_var_nona$prof_low==1]); sd(pre_var_nona$avg_duration_orders[pre_var_nona$prof_med==1]); sd(pre_var_nona$avg_duration_orders[pre_var_nona$prof_high==1])

mean(pre_var_nona$avg_idle_shift[pre_var_nona$prof_low==1]); mean(pre_var_nona$avg_idle_shift[pre_var_nona$prof_med==1]); mean(pre_var_nona$avg_idle_shift[pre_var_nona$prof_high==1])
sd(pre_var_nona$avg_idle_shift[pre_var_nona$prof_low==1]); sd(pre_var_nona$avg_idle_shift[pre_var_nona$prof_med==1]); sd(pre_var_nona$avg_idle_shift[pre_var_nona$prof_high==1])

mean(pre_var_nona$avg_waiting_shift[pre_var_nona$prof_low==1]); mean(pre_var_nona$avg_waiting_shift[pre_var_nona$prof_med==1]); mean(pre_var_nona$avg_waiting_shift[pre_var_nona$prof_high==1])
sd(pre_var_nona$avg_waiting_shift[pre_var_nona$prof_low==1]); sd(pre_var_nona$avg_waiting_shift[pre_var_nona$prof_med==1]); sd(pre_var_nona$avg_waiting_shift[pre_var_nona$prof_high==1])

mean(pre_var_nona$daily_total_shift[pre_var_nona$prof_low==1]); mean(pre_var_nona$daily_total_shift[pre_var_nona$prof_med==1]); mean(pre_var_nona$daily_total_shift[pre_var_nona$prof_high==1])
sd(pre_var_nona$daily_total_shift[pre_var_nona$prof_low==1]); sd(pre_var_nona$daily_total_shift[pre_var_nona$prof_med==1]); sd(pre_var_nona$daily_total_shift[pre_var_nona$prof_high==1])

mean(pre_var_nona$daily_total_order[pre_var_nona$prof_low==1]); mean(pre_var_nona$daily_total_order[pre_var_nona$prof_med==1]); mean(pre_var_nona$daily_total_order[pre_var_nona$prof_high==1])
sd(pre_var_nona$daily_total_order[pre_var_nona$prof_low==1]); sd(pre_var_nona$daily_total_order[pre_var_nona$prof_med==1]); sd(pre_var_nona$daily_total_order[pre_var_nona$prof_high==1])

mean(pre_var_nona$daily_profit[pre_var_nona$prof_low==1]); mean(pre_var_nona$daily_profit[pre_var_nona$prof_med==1]); mean(pre_var_nona$daily_profit[pre_var_nona$prof_high==1])
sd(pre_var_nona$daily_profit[pre_var_nona$prof_low==1]); sd(pre_var_nona$daily_profit[pre_var_nona$prof_med==1]); sd(pre_var_nona$daily_profit[pre_var_nona$prof_high==1])

mean(pre_var_nona$daily_total_labor[pre_var_nona$prof_low==1]); mean(pre_var_nona$daily_total_labor[pre_var_nona$prof_med==1]); mean(pre_var_nona$daily_total_labor[pre_var_nona$prof_high==1])
sd(pre_var_nona$daily_total_labor[pre_var_nona$prof_low==1]); sd(pre_var_nona$daily_total_labor[pre_var_nona$prof_med==1]); sd(pre_var_nona$daily_total_labor[pre_var_nona$prof_high==1])

mean(pre_var_nona$prof[pre_var_nona$prof_low==1]); mean(pre_var_nona$prof[pre_var_nona$prof_med==1]); mean(pre_var_nona$prof[pre_var_nona$prof_high==1])
# [1] 3.576104
# [1] 4.568162
# [1] 5.863659
sd(pre_var_nona$prof[pre_var_nona$prof_low==1]); sd(pre_var_nona$prof[pre_var_nona$prof_med==1]); sd(pre_var_nona$prof[pre_var_nona$prof_high==1])



##### Number of riders in control/treat group #####
sum(pre_var_nona$Treat) #매칭전 control 183, treat 399명
sum(pre_var_nona$Treat[pre_var_nona$prof_low==1]) #142
sum(pre_var_nona$Treat[pre_var_nona$prof_med==1]) #137
sum(pre_var_nona$Treat[pre_var_nona$prof_high==1]) #137
sum(pre_var_nona$prof_low==1) #195
sum(pre_var_nona$prof_med==1) #194
sum(pre_var_nona$prof_high==1) #193

sum(matched_data1$Treat) #매칭후 control 168, treat 168
sum(matched_data1$Treat[matched_data1$prof_low==1]) #57
sum(matched_data1$Treat[matched_data1$prof_med==1]) #58
sum(matched_data1$Treat[matched_data1$prof_high==1]) #53
sum(matched_data1$prof_low==1) #195
sum(matched_data1$prof_med==1) #194
sum(matched_data1$prof_high==1) #193
