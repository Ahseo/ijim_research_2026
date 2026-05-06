##### 추천배차 최초도입 데이터 #####
### 2019.04~2020.09 period
orders.1 <- orders %>% filter(year==2019|year==2020 & month<10) # 8,067,763건

### 추천배차도입 지점에 해당하지않는 test 데이터 제거: 1889건
test <- orders.1 %>% filter(management_partner_id %!in% c(520,461,773,369,908) & is_rec_assigned==1)
orders.1 <- orders.1 %>% filter(order_id %!in% test$order_id) #8,065,874건

### AI station의 주문 dummy ###
orders.1 <- orders.1 %>% mutate(aistation_order = ifelse(management_partner_id==520 & date>="2019-08-14",1,
                                                         ifelse(management_partner_id==773 & date>="2019-11-27",1,
                                                                ifelse(management_partner_id==461 & date>="2020-02-01",1,
                                                                       ifelse(management_partner_id==908 & date>="2020-02-10",1,
                                                                              ifelse(management_partner_id==369 & date>="2020-02-13",1,0))))))
sum(orders.1$aistation_order==1) # AI station의 AI 도입이후 주문건수: 725,363건 (9%)
sum(orders.1$is_rec_assigned==1) # AI로 배차된 주문건수: 357,468건 (4.4%) / AI station의 주문의 49.3%
sum(orders.1$is_rec_completed==1) # AI로 배달완료 주문건수: 313,108건 (3.9%) / AI 배차 주문의 87.6%