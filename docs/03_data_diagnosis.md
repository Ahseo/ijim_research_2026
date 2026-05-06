# RData Diagnosis Report

Source: `previous_resource/ISR_submitted ver_data.RData`
Generated: 2026-05-06 11:20:57.363876

**Loaded objects (22):** `data_day_matched_pre`, `rec_change`, `pre_var_nona`, `data_order`, `idletimes`, `rider_preexist`, `data_shift`, `data_shift_matched1`, `data_day_matched1`, `.Random.seed`, `data_shift_matched_pre`, `psmatch1`, `store`, `matched_data1`, `data_day`, `%!in%`, `rider`, `pre_var`, `func_check`, `treat_riders`, `proficiency`, `matched_treat_riders`

## `data_day_matched_pre`

- class: `data.frame`
- dim: 6781 rows x 54 cols
- columns: `rider_id`, `Treat`, `management_partner_id`, `date`, `After`, `station_date`, `rider_date`, `total_shift`, `mean_orders_shift`, `mean_duration_shift`, `share_aggshift`, `share_singleshift`, `orders_stacked`, `orders_one`, `num_singleshift`, `num_stackedshift`, `mean_orders_aggshift`, `mean_duration_aggshift`, `total_fee`, `working_duration`, `idle_duration`, `total_labor`, `total_orders`, `total_aiorders`, `ai_assist_day`, `share_workingd`, `share_idled`, `orders_per_hour`, `avg_waiting`, `sd_waiting`, `var_waiting`, `share_failedorders`, `wb5`, `wb4`, `wb3`, `wb2`, `wb1`, `w1`, `w2`, `w3`, `w4`, `w5`, `wday`, `riderDOW`, `share_aiorders`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `share_aiorder`, `subclass`, `After_premid`

### sample (first 5 rows)

```
  rider_id Treat management_partner_id       date After   station_date
1     7643     0                   258 2020-09-26     0 258_2020-09-26
2     7643     0                   258 2020-09-27     0 258_2020-09-27
3     7643     0                   258 2020-09-28     0 258_2020-09-28
4     7643     0                   258 2020-09-29     0 258_2020-09-29
5     7643     0                   258 2020-09-30     0 258_2020-09-30
       rider_date total_shift mean_orders_shift mean_duration_shift
1 7643_2020-09-26           8          1.625000            14.10000
2 7643_2020-09-27          13          1.384615            11.38077
3 7643_2020-09-28           6          1.666667            13.36944
4 7643_2020-09-29           5          1.000000            10.18333
5 7643_2020-09-30           1          3.000000            22.15000
  share_aggshift share_singleshift orders_stacked orders_one num_singleshift
1      0.2500000         0.7500000              7          6               6
2      0.3076923         0.6923077              9          9               9
3      0.5000000         0.5000000              7          3               3
4      0.0000000         1.0000000              0          5               5
5      1.0000000         0.0000000              3          0               0
  num_stackedshift mean_orders_aggshift mean_duration_aggshift total_fee
1                2             3.500000               27.83333     39000
2                4             2.250000               16.56667     54800
3                3             2.333333               19.00556     30000
4                0                  NaN                    NaN     14900
5                1             3.000000               22.15000     10200
  working_duration idle_duration total_labor total_orders total_aiorders
1        1.8800000     0.4069444   2.2869444           13              0
2        2.4658333     0.8216667   3.2875000           18              0
3        1.3369444     0.3250000   1.6619444           10              0
4        0.8486111     1.1766667   2.0252778            5              0
5        0.3691667     0.0000000   0.3691667            3              0
  ai_assist_day share_workingd share_idled orders_per_hour avg_waiting
1             0      0.8220576   0.1779424        5.684441    15.63846
2             0      0.7500634   0.2499366        5.475285    13.64074
3             0      0.8044459   0.1955541        6.017048    15.45667
4             0      0.4190097   0.5809903        2.468797    14.13000
5             0      1.0000000   0.0000000        8.126411    25.08333
  sd_waiting var_waiting share_failedorders wb5 wb4 wb3 wb2 wb1 w1 w2 w3 w4 w5
1   4.465430   19.940064                  0   1   0   0   0   0  0  0  0  0  0
2   4.458106   19.874713                  0   1   0   0   0   0  0  0  0  0  0
3   4.570519   20.889642                  0   0   1   0   0   0  0  0  0  0  0
4   5.832493   34.017972                  0   0   1   0   0   0  0  0  0  0  0
5   2.622393    6.876944                  0   0   1   0   0   0  0  0  0  0  0
  wday riderDOW share_aiorders     prof prof_low50 prof_high50 prof_low
1    7   7643_7             NA 4.729133          0           1        0
2    1   7643_1             NA 4.729133          0           1        0
3    2   7643_2             NA 4.729133          0           1        0
4    3   7643_3             NA 4.729133          0           1        0
5    4   7643_4             NA 4.729133          0           1        0
  prof_med prof_high share_aiorder subclass After_premid
1        1         0            NA       39            0
2        1         0            NA       39            0
3        1         0            NA       39            0
4        1         0            NA       39            0
5        1         0            NA       39            0
```

### column types

```
rider_id: integer
Treat: numeric
management_partner_id: integer
date: Date
After: numeric
station_date: character
rider_date: character
total_shift: integer
mean_orders_shift: numeric
mean_duration_shift: numeric
share_aggshift: numeric
share_singleshift: numeric
orders_stacked: integer
orders_one: integer
num_singleshift: integer
num_stackedshift: integer
mean_orders_aggshift: numeric
mean_duration_aggshift: numeric
total_fee: numeric
working_duration: numeric
idle_duration: numeric
total_labor: numeric
total_orders: integer
total_aiorders: integer
ai_assist_day: numeric
share_workingd: numeric
share_idled: numeric
orders_per_hour: numeric
avg_waiting: numeric
sd_waiting: numeric
var_waiting: numeric
share_failedorders: numeric
wb5: numeric
wb4: numeric
wb3: numeric
wb2: numeric
wb1: numeric
w1: numeric
w2: numeric
w3: numeric
w4: numeric
w5: numeric
wday: numeric
riderDOW: character
share_aiorders: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
share_aiorder: numeric
subclass: factor
After_premid: numeric
```

### summary

```
    rider_id         Treat       management_partner_id      date           
 Min.   : 7643   Min.   :0.000   Min.   : 258.0        Min.   :2020-09-26  
 1st Qu.:29872   1st Qu.:0.000   1st Qu.: 296.0        1st Qu.:2020-10-03  
 Median :43391   Median :0.000   Median : 452.0        Median :2020-10-11  
 Mean   :39657   Mean   :0.494   Mean   : 537.7        Mean   :2020-10-10  
 3rd Qu.:51228   3rd Qu.:1.000   3rd Qu.: 815.0        3rd Qu.:2020-10-18  
 Max.   :56805   Max.   :1.000   Max.   :1186.0        Max.   :2020-10-25  
                                                                           
     After   station_date        rider_date         total_shift  
 Min.   :0   Length:6781        Length:6781        Min.   : 1.0  
 1st Qu.:0   Class :character   Class :character   1st Qu.: 5.0  
 Median :0   Mode  :character   Mode  :character   Median : 9.0  
 Mean   :0                                         Mean   :10.7  
 3rd Qu.:0                                         3rd Qu.:15.0  
 Max.   :0                                         Max.   :42.0  
                                                                 
 mean_orders_shift mean_duration_shift share_aggshift   share_singleshift
 Min.   : 1.000    Min.   :  3.233     Min.   :0.0000   Min.   :0.0000   
 1st Qu.: 1.500    1st Qu.: 15.870     1st Qu.:0.3636   1st Qu.:0.2500   
 Median : 2.200    Median : 24.268     Median :0.5652   Median :0.4348   
 Mean   : 3.018    Mean   : 30.227     Mean   :0.5544   Mean   :0.4456   
 3rd Qu.: 3.545    3rd Qu.: 36.231     3rd Qu.:0.7500   3rd Qu.:0.6364   
 Max.   :42.000    Max.   :315.867     Max.   :1.0000   Max.   :1.0000   
                                                                         
 orders_stacked     orders_one     num_singleshift  num_stackedshift
 Min.   :  0.00   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
 1st Qu.:  8.00   1st Qu.: 1.000   1st Qu.: 1.000   1st Qu.: 2.000  
 Median : 18.00   Median : 4.000   Median : 4.000   Median : 5.000  
 Mean   : 22.31   Mean   : 5.129   Mean   : 5.129   Mean   : 5.571  
 3rd Qu.: 32.00   3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.: 8.000  
 Max.   :120.00   Max.   :37.000   Max.   :37.000   Max.   :26.000  
                                                                    
 mean_orders_aggshift mean_duration_aggshift   total_fee     
 Min.   : 2.000       Min.   :  9.05         Min.   :  2200  
 1st Qu.: 2.429       1st Qu.: 23.88         1st Qu.: 36700  
 Median : 3.250       Median : 33.93         Median : 72300  
 Mean   : 4.153       Mean   : 40.02         Mean   : 82353  
 3rd Qu.: 4.778       3rd Qu.: 47.58         3rd Qu.:117700  
 Max.   :42.000       Max.   :315.87         Max.   :423400  
 NA's   :495          NA's   :495                            
 working_duration   idle_duration     total_labor        total_orders   
 Min.   : 0.05389   Min.   :0.0000   Min.   : 0.05389   Min.   :  1.00  
 1st Qu.: 2.22361   1st Qu.:0.3728   1st Qu.: 2.90194   1st Qu.: 12.00  
 Median : 4.18333   Median :1.0283   Median : 5.59889   Median : 24.00  
 Mean   : 4.43505   Mean   :1.3045   Mean   : 5.73956   Mean   : 27.44  
 3rd Qu.: 6.38083   3rd Qu.:1.9517   3rd Qu.: 8.39167   3rd Qu.: 39.00  
 Max.   :14.63139   Max.   :7.0317   Max.   :15.73722   Max.   :122.00  
                                                                        
 total_aiorders ai_assist_day share_workingd    share_idled    
 Min.   :0      Min.   :0     Min.   :0.2244   Min.   :0.0000  
 1st Qu.:0      1st Qu.:0     1st Qu.:0.6870   1st Qu.:0.0934  
 Median :0      Median :0     Median :0.8065   Median :0.1935  
 Mean   :0      Mean   :0     Mean   :0.7878   Mean   :0.2122  
 3rd Qu.:0      3rd Qu.:0     3rd Qu.:0.9066   3rd Qu.:0.3130  
 Max.   :0      Max.   :0     Max.   :1.0000   Max.   :0.7756  
                                                               
 orders_per_hour   avg_waiting      sd_waiting        var_waiting       
 Min.   : 1.322   Min.   : 5.35   Min.   : 0.04714   Min.   :  0.00222  
 1st Qu.: 3.703   1st Qu.:13.77   1st Qu.: 4.73938   1st Qu.: 22.46172  
 Median : 4.586   Median :17.13   Median : 6.11705   Median : 37.41824  
 Mean   : 4.711   Mean   :17.99   Mean   : 6.36165   Mean   : 46.02586  
 3rd Qu.: 5.596   3rd Qu.:21.57   3rd Qu.: 7.67570   3rd Qu.: 58.91637  
 Max.   :18.557   Max.   :46.32   Max.   :24.90375   Max.   :620.19676  
                                  NA's   :163        NA's   :163        
 share_failedorders      wb5               wb4              wb3        
 Min.   :0.00000    Min.   :0.00000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.00000    1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.02174    Median :0.00000   Median :0.0000   Median :0.0000  
 Mean   :0.09158    Mean   :0.07256   Mean   :0.2125   Mean   :0.2417  
 3rd Qu.:0.13333    3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:0.0000  
 Max.   :1.00000    Max.   :1.00000   Max.   :1.0000   Max.   :1.0000  
                                                                       
      wb2              wb1               w1          w2          w3   
 Min.   :0.0000   Min.   :0.0000   Min.   :0   Min.   :0   Min.   :0  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0   1st Qu.:0   1st Qu.:0  
 Median :0.0000   Median :0.0000   Median :0   Median :0   Median :0  
 Mean   :0.2376   Mean   :0.2357   Mean   :0   Mean   :0   Mean   :0  
 3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0   3rd Qu.:0   3rd Qu.:0  
 Max.   :1.0000   Max.   :1.0000   Max.   :0   Max.   :0   Max.   :0  
                                                                      
       w4          w5         wday         riderDOW         share_aiorders
 Min.   :0   Min.   :0   Min.   :1.000   Length:6781        Min.   :0     
 1st Qu.:0   1st Qu.:0   1st Qu.:2.000   Class :character   1st Qu.:0     
 Median :0   Median :0   Median :4.000   Mode  :character   Median :0     
 Mean   :0   Mean   :0   Mean   :4.027                      Mean   :0     
 3rd Qu.:0   3rd Qu.:0   3rd Qu.:6.000                      3rd Qu.:0     
 Max.   :0   Max.   :0   Max.   :7.000                      Max.   :0     
                                                            NA's   :3431  
      prof         prof_low50      prof_high50        prof_low     
 Min.   :1.934   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:4.002   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :4.631   Median :0.0000   Median :1.0000   Median :0.0000  
 Mean   :4.711   Mean   :0.4819   Mean   :0.5181   Mean   :0.3207  
 3rd Qu.:5.394   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :7.870   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                   
    prof_med        prof_high      share_aiorder       subclass   
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0003   27     :  58  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0014   97     :  57  
 Median :0.0000   Median :0.0000   Median :0.0073   131    :  57  
 Mean   :0.3386   Mean   :0.3407   Mean   :0.0415   17     :  56  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:0.0294   51     :  56  
 Max.   :1.0000   Max.   :1.0000   Max.   :0.7551   149    :  56  
                                   NA's   :3431     (Other):6441  
  After_premid   
 Min.   :0.0000  
 1st Qu.:0.0000  
 Median :0.0000  
 Mean   :0.4732  
 3rd Qu.:1.0000  
 Max.   :1.0000  
                 
```


## `rec_change`

- class: `grouped_df, tbl_df, tbl, data.frame`
- dim: 43897 rows x 5 cols
- columns: `rider_id`, `type_auto`, `time`, `date`, `auto_duration`

### sample (first 5 rows)

```
  rider_id type_auto                time       date auto_duration
1     7803         0 2020-10-26 00:45:43 2020-10-26            NA
2     7803         1 2020-10-26 09:32:35 2020-10-26      19.56667
3     7803         0 2020-10-26 09:52:09 2020-10-26            NA
4     7803         1 2020-10-26 09:52:10 2020-10-26      14.46667
5     7803         0 2020-10-26 10:06:38 2020-10-26            NA
```

### column types

```
rider_id: integer
type_auto: numeric
time: POSIXct/POSIXt
date: Date
auto_duration: numeric
```

### summary

```
    rider_id       type_auto           time                    
 Min.   : 7803   Min.   :0.0000   Min.   :2020-10-26 00:00:04  
 1st Qu.:33542   1st Qu.:0.0000   1st Qu.:2020-10-31 16:48:29  
 Median :45047   Median :0.0000   Median :2020-11-10 10:35:08  
 Mean   :41020   Mean   :0.3916   Mean   :2020-11-10 22:57:36  
 3rd Qu.:52115   3rd Qu.:1.0000   3rd Qu.:2020-11-20 17:02:36  
 Max.   :56797   Max.   :1.0000   Max.   :2020-11-30 23:56:26  
                                                               
      date            auto_duration      
 Min.   :2020-10-26   Min.   :   0.0000  
 1st Qu.:2020-10-31   1st Qu.:   0.0667  
 Median :2020-11-10   Median :   1.4833  
 Mean   :2020-11-10   Mean   :  38.8566  
 3rd Qu.:2020-11-20   3rd Qu.:  24.6750  
 Max.   :2020-11-30   Max.   :1404.0833  
                      NA's   :26806      
```


## `pre_var_nona`

- class: `data.frame`
- dim: 582 rows x 36 cols
- columns: `rider_id`, `avg_assign`, `avg_pickup`, `avg_deliver`, `avg_waiting`, `avg_ODdist`, `daily_delivered_stores`, `num_working_days`, `tenure`, `avg_order_level`, `avg_assign_shift`, `avg_pickup_shift`, `avg_deliver_shift`, `avg_waiting_shift`, `avg_orders_shift`, `avg_duration_shift`, `avg_idle_shift`, `avg_duration_orders`, `daily_total_shift`, `daily_singleorder`, `daily_share_singleorder`, `daily_working_duration`, `daily_idle_duration`, `daily_total_labor`, `daily_total_order`, `daily_share_idled`, `daily_orders_per_hour`, `daily_profit`, `Treat`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `Treat_rev`

### sample (first 5 rows)

```
  rider_id avg_assign avg_pickup avg_deliver avg_waiting avg_ODdist
1     7643  3.1713306   3.491632    7.625103    14.28807  1.5461803
2     7803  2.0533718   3.822589    8.955346    14.83131  1.4835493
3     8843  0.7706573   4.403286    7.072066    12.24601  1.3327031
4     9524  0.7583893  10.297483    8.951230    20.00710  0.9895915
5     9535  0.6870528   6.251278    8.832226    15.77056  1.1715759
  daily_delivered_stores num_working_days tenure avg_order_level
1               7.538462             6.00   1151        3118.467
2              22.000000             6.25   1145        3039.079
3               2.375000             5.50   1097        3606.109
4               7.480000             6.00   1068        4563.784
5              21.238095             5.25   1067        3667.947
  avg_assign_shift avg_pickup_shift avg_deliver_shift avg_waiting_shift
1        3.2086001         3.377795          7.065637          13.65203
2        1.9233279         3.840485          8.357255          14.12107
3        0.7599917         4.332421          6.883624          11.97604
4        0.9517817         9.097182          7.950314          17.99928
5        0.5843549         5.748628          8.198925          14.53191
  avg_orders_shift avg_duration_shift avg_idle_shift avg_duration_orders
1         1.372881           11.91299      10.899708            9.031731
2         1.803403           16.56418       9.877991            9.858020
3         1.059701           11.62015      19.075000           10.985987
4         3.170213           32.05869       8.643030           10.965673
5         2.835749           29.10942       4.100901           11.027064
  daily_total_shift daily_singleorder daily_share_singleorder
1          6.807692          4.846154               0.5767082
2         19.592593          9.703704               0.2901357
3          2.791667          2.666667               0.9409722
4          3.760000          1.000000               0.1449254
5          9.857143          3.952381               0.2161466
  daily_working_duration daily_idle_duration daily_total_labor
1              1.3516667           0.7965171         2.1481838
2              5.4089198           2.8536420         8.2625617
3              0.5406597           0.3179167         0.8585764
4              2.0090111           0.3169111         2.3259222
5              4.7822619           0.6021164         5.3843783
  daily_total_order daily_share_idled daily_orders_per_hour daily_profit Treat
1          9.346154         0.3040905              4.729133     28453.85     0
2         35.333333         0.3327241              4.402632    108103.70     1
3          2.958333         0.2222164              4.445677      9068.75     0
4         11.920000         0.1269951              5.023493     35048.00     1
5         27.952381         0.1058622              5.099385     80756.19     1
      prof prof_low50 prof_high50 prof_low prof_med prof_high Treat_rev
1 4.729133          0           1        0        1         0         1
2 4.402632          1           0        0        1         0         0
3 4.445677          1           0        0        1         0         1
4 5.023493          0           1        0        0         1         0
5 5.099385          0           1        0        0         1         0
```

### column types

```
rider_id: integer
avg_assign: numeric
avg_pickup: numeric
avg_deliver: numeric
avg_waiting: numeric
avg_ODdist: numeric
daily_delivered_stores: numeric
num_working_days: numeric
tenure: numeric
avg_order_level: numeric
avg_assign_shift: numeric
avg_pickup_shift: numeric
avg_deliver_shift: numeric
avg_waiting_shift: numeric
avg_orders_shift: numeric
avg_duration_shift: numeric
avg_idle_shift: numeric
avg_duration_orders: numeric
daily_total_shift: numeric
daily_singleorder: numeric
daily_share_singleorder: numeric
daily_working_duration: numeric
daily_idle_duration: numeric
daily_total_labor: numeric
daily_total_order: numeric
daily_share_idled: numeric
daily_orders_per_hour: numeric
daily_profit: numeric
Treat: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
Treat_rev: numeric
```

### summary

```
    rider_id       avg_assign        avg_pickup      avg_deliver    
 Min.   : 7643   Min.   : 0.0451   Min.   : 2.186   Min.   : 4.093  
 1st Qu.:29910   1st Qu.: 0.7332   1st Qu.: 6.372   1st Qu.: 7.871  
 Median :43402   Median : 1.1537   Median : 9.195   Median : 9.035  
 Mean   :39959   Mean   : 1.5082   Mean   : 8.857   Mean   : 9.173  
 3rd Qu.:51454   3rd Qu.: 1.8846   3rd Qu.:11.414   3rd Qu.:10.345  
 Max.   :56805   Max.   :12.6090   Max.   :19.168   Max.   :15.167  
  avg_waiting       avg_ODdist     daily_delivered_stores num_working_days
 Min.   : 8.397   Min.   :0.7021   Min.   : 1.000         Min.   :1.00    
 1st Qu.:15.883   1st Qu.:0.9897   1st Qu.: 9.589         1st Qu.:4.50    
 Median :19.783   Median :1.1167   Median :13.947         Median :5.50    
 Mean   :19.538   Mean   :1.1373   Mean   :14.925         Mean   :5.15    
 3rd Qu.:23.296   3rd Qu.:1.2450   3rd Qu.:19.675         3rd Qu.:6.25    
 Max.   :32.190   Max.   :2.4617   Max.   :46.846         Max.   :7.00    
     tenure       avg_order_level avg_assign_shift   avg_pickup_shift
 Min.   :  30.0   Min.   :1841    Min.   : 0.04615   Min.   : 2.153  
 1st Qu.: 110.0   1st Qu.:3670    1st Qu.: 0.64708   1st Qu.: 5.905  
 Median : 252.0   Median :4114    Median : 1.02157   Median : 8.533  
 Mean   : 332.6   Mean   :4160    Mean   : 1.41168   Mean   : 8.233  
 3rd Qu.: 511.2   3rd Qu.:4599    3rd Qu.: 1.63788   3rd Qu.:10.536  
 Max.   :1151.0   Max.   :6143    Max.   :12.52608   Max.   :19.318  
 avg_deliver_shift avg_waiting_shift avg_orders_shift avg_duration_shift
 Min.   : 3.975    Min.   : 8.26     Min.   : 1.000   Min.   :  8.44    
 1st Qu.: 7.169    1st Qu.:14.27     1st Qu.: 1.883   1st Qu.: 21.50    
 Median : 8.189    Median :18.02     Median : 2.830   Median : 31.36    
 Mean   : 8.327    Mean   :17.97     Mean   : 3.332   Mean   : 35.00    
 3rd Qu.: 9.363    3rd Qu.:21.33     3rd Qu.: 4.126   3rd Qu.: 43.72    
 Max.   :14.014    Max.   :30.96     Max.   :18.690   Max.   :183.00    
 avg_idle_shift   avg_duration_orders daily_total_shift daily_singleorder
 Min.   : 2.186   Min.   : 7.130      Min.   : 1.250    Min.   : 0.000   
 1st Qu.: 6.642   1st Qu.: 9.847      1st Qu.: 6.194    1st Qu.: 1.918   
 Median : 8.746   Median :11.693      Median : 9.163    Median : 3.221   
 Mean   : 9.283   Mean   :11.832      Mean   :10.188    Mean   : 4.457   
 3rd Qu.:10.905   3rd Qu.:13.360      3rd Qu.:12.818    3rd Qu.: 5.679   
 Max.   :28.275   Max.   :24.744      Max.   :37.000    Max.   :29.000   
 daily_share_singleorder daily_working_duration daily_idle_duration
 Min.   :0.00000         Min.   : 0.3148        Min.   :0.009333   
 1st Qu.:0.07751         1st Qu.: 3.3533        1st Qu.:0.620719   
 Median :0.16095         Median : 5.1382        Median :1.044676   
 Mean   :0.22933         Mean   : 5.1630        Mean   :1.221619   
 3rd Qu.:0.31960         3rd Qu.: 6.8917        3rd Qu.:1.657034   
 Max.   :1.00000         Max.   :11.0819        Max.   :4.409496   
 daily_total_labor daily_total_order daily_share_idled  daily_orders_per_hour
 Min.   : 0.3241   Min.   : 1.60     Min.   :0.007519   Min.   :1.934        
 1st Qu.: 4.3695   1st Qu.:18.32     1st Qu.:0.110046   1st Qu.:3.979        
 Median : 6.4896   Median :28.59     Median :0.166122   Median :4.554        
 Mean   : 6.3846   Mean   :29.96     Mean   :0.184701   Mean   :4.665        
 3rd Qu.: 8.3982   3rd Qu.:39.98     3rd Qu.:0.242530   3rd Qu.:5.290        
 Max.   :13.9611   Max.   :88.04     Max.   :0.519842   Max.   :8.555        
  daily_profit        Treat             prof         prof_low50    
 Min.   :  4910   Min.   :0.0000   Min.   :1.934   Min.   :0.0000  
 1st Qu.: 56034   1st Qu.:0.0000   1st Qu.:3.979   1st Qu.:0.0000  
 Median : 86474   Median :1.0000   Median :4.554   Median :1.0000  
 Mean   : 90217   Mean   :0.6856   Mean   :4.665   Mean   :0.5017  
 3rd Qu.:119218   3rd Qu.:1.0000   3rd Qu.:5.290   3rd Qu.:1.0000  
 Max.   :258213   Max.   :1.0000   Max.   :8.555   Max.   :1.0000  
  prof_high50        prof_low         prof_med        prof_high     
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.4983   Mean   :0.3351   Mean   :0.3333   Mean   :0.3316  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
   Treat_rev     
 Min.   :0.0000  
 1st Qu.:0.0000  
 Median :0.0000  
 Mean   :0.3144  
 3rd Qu.:1.0000  
 Max.   :1.0000  
```


## `data_order`

- class: `data.frame`
- dim: 815191 rows x 72 cols
- columns: `order_id`, `date`, `rider_id`, `management_partner_id`, `management_partner_name`, `created_at`, `first_order`, `last_order`, `store_id`, `store_name`, `enterprise_registration_number`, `monitoring_partner_id`, `franchise_name`, `category`, `si_do`, `si_gun_gu`, `eup_myeon_dong`, `lat`, `lng`, `dest_lat_masked`, `dest_lng_masked`, `distorigintodest`, `submittedat`, `assignedat`, `pickedupat`, `deliveredat`, `is_rec_assigned`, `is_rec_completed`, `is_rec_adjusted`, `store_base_fee`, `rider_fee`, `rider_extra_fee`, `year`, `month`, `day`, `assign_min`, `pickup_min`, `delivery_min`, `waiting_min`, `OD`, `DOW`, `hour`, `hourDOW`, `station_date`, `rider_total_fee`, `order_level`, `deliveredat_max`, `shift`, `Treat`, `After`, `rider_date`, `riderDOW`, `wb5`, `wb4`, `wb3`, `wb2`, `wb1`, `w2`, `w1`, `w3`, `w4`, `w5`, `peak`, `midpeak`, `offpeak`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `share_aiorder`

### sample (first 5 rows)

```
   order_id       date rider_id management_partner_id management_partner_name
1 116342699 2020-09-26     7643                   258            부산정관지점
2 116343691 2020-09-26     7643                   258            부산정관지점
3 116386843 2020-09-26     7643                   258            부산정관지점
4 116388090 2020-09-26     7643                   258            부산정관지점
5 116415555 2020-09-26     7643                   258            부산정관지점
        created_at first_order last_order store_id                   store_name
1 2017-09-01 16:20  2018-12-31 2020-11-30    68472                방곡리 육대장
2 2017-09-01 16:20  2018-12-31 2020-11-30    79029         달산4길 족보잇는국밥
3 2017-09-01 16:20  2018-12-31 2020-11-30    67761 가동 부산면옥 배정후 5분픽업
4 2017-09-01 16:20  2018-12-31 2020-11-30    67550              가동 7번가 피자
5 2017-09-01 16:20  2018-12-31 2020-11-30    31818      매학리60계치킨(3분픽업)
  enterprise_registration_number monitoring_partner_id franchise_name category
1                     8747400120                   258 육대장(육대장)     한식
2                     4663500634                   258                    한식
3                     7070201313                   258                    한식
4                     5510800218                   258                    피자
5                     4142397644                   258                    치킨
       si_do si_gun_gu eup_myeon_dong      lat      lng dest_lat_masked
1 부산광역시    기장군  정관읍 방곡리 35.32307 129.1847          35.329
2 부산광역시    기장군  정관읍 달산리 35.31804 129.1784          35.338
3 부산광역시    기장군  정관읍 용수리 35.32626 129.1808          35.329
4 부산광역시    기장군  정관읍 용수리 35.32692 129.1796          35.338
5 부산광역시    기장군  정관읍 매학리 35.32176 129.1802          35.333
  dest_lng_masked distorigintodest         submittedat          assignedat
1         129.165        1.8673011 2020-09-26 13:11:27 2020-09-26 13:16:01
2         129.163        2.6494222 2020-09-26 13:15:09 2020-09-26 13:16:36
3         129.181        0.3404652 2020-09-26 16:36:34 2020-09-26 16:37:42
4         129.162        1.9979933 2020-09-26 16:43:03 2020-09-26 16:45:17
5         129.168        1.6981084 2020-09-26 18:16:16 2020-09-26 18:18:23
           pickedupat         deliveredat is_rec_assigned is_rec_completed
1 2020-09-26 13:17:37 2020-09-26 13:32:02               0                0
2 2020-09-26 13:20:28 2020-09-26 13:34:25               0                0
3 2020-09-26 16:41:43 2020-09-26 16:45:07               0                0
4 2020-09-26 16:48:43 2020-09-26 16:57:54               0                0
5 2020-09-26 18:20:35 2020-09-26 18:27:38               0                0
  is_rec_adjusted store_base_fee rider_fee rider_extra_fee year month day
1               0           3300      3000               0 2020     9  26
2               0           3300      3000               0 2020     9  26
3               0           3300      3000               0 2020     9  26
4               0           3300      3000               0 2020     9  26
5               0           3300      3000               0 2020     9  26
  assign_min pickup_min delivery_min waiting_min
1   4.566667   1.600000    14.416667    20.58333
2   1.450000   3.866667    13.950000    19.26667
3   1.133333   4.016667     3.400000     8.55000
4   2.233333   3.433333     9.183333    14.85000
5   2.116667   2.200000     7.050000    11.36667
                                       OD DOW hour hourDOW   station_date
1 35.32307146 129.18467412 35.329 129.165   7   13    13_7 258_2020-09-26
2   35.3180378 129.1784199 35.338 129.163   7   13    13_7 258_2020-09-26
3 35.32625629 129.18079117 35.329 129.181   7   16    16_7 258_2020-09-26
4 35.32692118 129.17957417 35.338 129.162   7   16    16_7 258_2020-09-26
5 35.32175669 129.18018123 35.333 129.168   7   18    18_7 258_2020-09-26
  rider_total_fee order_level     deliveredat_max shift Treat After
1            3000    1606.597 2020-09-26 13:32:02     1     0     0
2            3000    1132.322 2020-09-26 13:34:25     1     0     0
3            3000    8811.473 2020-09-26 16:45:07     2     0     0
4            3000    1501.507 2020-09-26 16:57:54     3     0     0
5            3000    1766.672 2020-09-26 18:27:38     4     0     0
       rider_date riderDOW wb5 wb4 wb3 wb2 wb1 w2 w1 w3 w4 w5 peak midpeak
1 7643_2020-09-26   7643_7   1   0   0   0   0  0  0  0  0  0    1       0
2 7643_2020-09-26   7643_7   1   0   0   0   0  0  0  0  0  0    1       0
3 7643_2020-09-26   7643_7   1   0   0   0   0  0  0  0  0  0    0       1
4 7643_2020-09-26   7643_7   1   0   0   0   0  0  0  0  0  0    0       1
5 7643_2020-09-26   7643_7   1   0   0   0   0  0  0  0  0  0    1       0
  offpeak     prof prof_low50 prof_high50 prof_low prof_med prof_high
1       0 4.729133          0           1        0        1         0
2       0 4.729133          0           1        0        1         0
3       0 4.729133          0           1        0        1         0
4       0 4.729133          0           1        0        1         0
5       0 4.729133          0           1        0        1         0
  share_aiorder
1            NA
2            NA
3            NA
4            NA
5            NA
```

### column types

```
order_id: integer
date: Date
rider_id: integer
management_partner_id: integer
management_partner_name: factor
created_at: factor
first_order: Date
last_order: Date
store_id: integer
store_name: character
enterprise_registration_number: character
monitoring_partner_id: integer
franchise_name: character
category: factor
si_do: character
si_gun_gu: character
eup_myeon_dong: character
lat: numeric
lng: numeric
dest_lat_masked: numeric
dest_lng_masked: numeric
distorigintodest: numeric
submittedat: POSIXct/POSIXt
assignedat: POSIXct/POSIXt
pickedupat: POSIXct/POSIXt
deliveredat: POSIXct/POSIXt
is_rec_assigned: numeric
is_rec_completed: numeric
is_rec_adjusted: numeric
store_base_fee: integer
rider_fee: numeric
rider_extra_fee: numeric
year: integer
month: integer
day: integer
assign_min: numeric
pickup_min: numeric
delivery_min: numeric
waiting_min: numeric
OD: character
DOW: numeric
hour: integer
hourDOW: character
station_date: character
rider_total_fee: numeric
order_level: numeric
deliveredat_max: POSIXct/POSIXt
shift: numeric
Treat: numeric
After: numeric
rider_date: character
riderDOW: character
wb5: numeric
wb4: numeric
wb3: numeric
wb2: numeric
wb1: numeric
w2: numeric
w1: numeric
w3: numeric
w4: numeric
w5: numeric
peak: numeric
midpeak: numeric
offpeak: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
share_aiorder: numeric
```

### summary

```
    order_id              date               rider_id     management_partner_id
 Min.   :116289533   Min.   :2020-09-26   Min.   : 7643   Min.   : 258.0       
 1st Qu.:119115858   1st Qu.:2020-10-11   1st Qu.:29774   1st Qu.: 296.0       
 Median :122084317   Median :2020-10-27   Median :42794   Median : 466.0       
 Mean   :122252344   Mean   :2020-10-27   Mean   :39543   Mean   : 578.8       
 3rd Qu.:125321992   3rd Qu.:2020-11-14   3rd Qu.:50681   3rd Qu.: 815.0       
 Max.   :128817771   Max.   :2020-11-30   Max.   :56805   Max.   :1244.0       
                                                                               
 management_partner_name            created_at      first_order        
 부산장전지점:159131     2018-10-31 17:09:  4421   Min.   :2018-12-31  
 부산정관지점: 80991     2020-07-06 1:55 :  4287   1st Qu.:2019-09-12  
 부산중동지점: 68630     2019-09-24 15:45:  4257   Median :2020-04-02  
 부산사직지점: 49344     2018-12-14 15:16:  4240   Mean   :2020-02-02  
 부산대신지점: 38831     2019-08-16 18:08:  4180   3rd Qu.:2020-08-05  
 부산우동지점: 34979     2020-08-13 11:24:  4163   Max.   :2020-11-18  
 (Other)     :383285     (Other)         :789643                       
   last_order            store_id      store_name       
 Min.   :2020-10-26   Min.   :  139   Length:815191     
 1st Qu.:2020-11-29   1st Qu.:26556   Class :character  
 Median :2020-11-30   Median :49875   Mode  :character  
 Mean   :2020-11-27   Mean   :46345                     
 3rd Qu.:2020-11-30   3rd Qu.:67778                     
 Max.   :2020-11-30   Max.   :88109                     
                                                        
 enterprise_registration_number monitoring_partner_id franchise_name    
 Length:815191                  Min.   : 258.0        Length:815191     
 Class :character               1st Qu.: 296.0        Class :character  
 Mode  :character               Median : 466.0        Mode  :character  
                                Mean   : 580.5                          
                                3rd Qu.: 815.0                          
                                Max.   :1244.0                          
                                                                        
                 category         si_do            si_gun_gu        
 버거                :175051   Length:815191      Length:815191     
 한식                :174682   Class :character   Class :character  
 치킨                :121857   Mode  :character   Mode  :character  
 카페/베이커리/디저트:110341                                        
 분식                : 51509                                        
 중식                : 41966                                        
 (Other)             :139785                                        
 eup_myeon_dong          lat             lng        dest_lat_masked
 Length:815191      Min.   :35.06   Min.   :128.9   Min.   :35.05  
 Class :character   1st Qu.:35.16   1st Qu.:129.0   1st Qu.:35.16  
 Mode  :character   Median :35.19   Median :129.1   Median :35.19  
                    Mean   :35.20   Mean   :129.1   Mean   :35.20  
                    3rd Qu.:35.23   3rd Qu.:129.1   3rd Qu.:35.23  
                    Max.   :35.34   Max.   :129.2   Max.   :35.36  
                                                                   
 dest_lng_masked distorigintodest  submittedat                 
 Min.   :128.9   Min.   :0.1000   Min.   :2020-09-26 00:00:12  
 1st Qu.:129.0   1st Qu.:0.5606   1st Qu.:2020-10-11 16:55:18  
 Median :129.1   Median :0.9366   Median :2020-10-27 18:57:31  
 Mean   :129.1   Mean   :1.0999   Mean   :2020-10-28 14:22:21  
 3rd Qu.:129.1   3rd Qu.:1.4546   3rd Qu.:2020-11-14 14:34:34  
 Max.   :129.2   Max.   :7.7943   Max.   :2020-11-30 23:59:48  
                 NA's   :5916                                  
   assignedat                    pickedupat                 
 Min.   :2020-09-26 00:00:16   Min.   :2020-09-26 00:02:31  
 1st Qu.:2020-10-11 16:57:04   1st Qu.:2020-10-11 17:06:02  
 Median :2020-10-27 18:59:10   Median :2020-10-27 19:07:20  
 Mean   :2020-10-28 14:23:42   Mean   :2020-10-28 14:32:28  
 3rd Qu.:2020-11-14 14:35:54   3rd Qu.:2020-11-14 14:43:32  
 Max.   :2020-12-01 00:04:06   Max.   :2020-12-01 00:14:16  
                                                            
  deliveredat                  is_rec_assigned  is_rec_completed 
 Min.   :2020-09-26 00:07:40   Min.   :0.0000   Min.   :0.00000  
 1st Qu.:2020-10-11 17:15:22   1st Qu.:0.0000   1st Qu.:0.00000  
 Median :2020-10-27 19:16:48   Median :0.0000   Median :0.00000  
 Mean   :2020-10-28 14:41:41   Mean   :0.0404   Mean   :0.03357  
 3rd Qu.:2020-11-14 14:52:43   3rd Qu.:0.0000   3rd Qu.:0.00000  
 Max.   :2020-12-01 00:28:34   Max.   :1.0000   Max.   :1.00000  
                                                                 
 is_rec_adjusted    store_base_fee   rider_fee    rider_extra_fee  
 Min.   :0.000000   Min.   :2600   Min.   :2100   Min.   :   0.00  
 1st Qu.:0.000000   1st Qu.:3300   1st Qu.:2700   1st Qu.:   0.00  
 Median :0.000000   Median :3300   Median :2900   Median :   0.00  
 Mean   :0.006825   Mean   :3672   Mean   :2921   Mean   :  69.73  
 3rd Qu.:0.000000   3rd Qu.:4070   3rd Qu.:3000   3rd Qu.:   0.00  
 Max.   :1.000000   Max.   :9680   Max.   :8500   Max.   :5500.00  
                                                                   
      year          month            day          assign_min     
 Min.   :2020   Min.   : 9.00   Min.   : 1.00   Min.   : 0.0000  
 1st Qu.:2020   1st Qu.:10.00   1st Qu.: 9.00   1st Qu.: 0.0500  
 Median :2020   Median :10.00   Median :17.00   Median : 0.1167  
 Mean   :2020   Mean   :10.35   Mean   :16.93   Mean   : 1.3579  
 3rd Qu.:2020   3rd Qu.:11.00   3rd Qu.:26.00   3rd Qu.: 0.7833  
 Max.   :2020   Max.   :11.00   Max.   :31.00   Max.   :59.7333  
                                                                 
   pickup_min     delivery_min     waiting_min          OD           
 Min.   : 0.00   Min.   : 1.000   Min.   :  5.00   Length:815191     
 1st Qu.: 4.65   1st Qu.: 4.917   1st Qu.: 12.77   Class :character  
 Median : 7.85   Median : 7.817   Median : 18.02   Mode  :character  
 Mean   : 8.77   Mean   : 9.203   Mean   : 19.33                     
 3rd Qu.:12.00   3rd Qu.:12.217   3rd Qu.: 24.40                     
 Max.   :59.98   Max.   :59.867   Max.   :112.08                     
                                                                     
      DOW             hour         hourDOW          station_date      
 Min.   :1.000   Min.   : 0.00   Length:815191      Length:815191     
 1st Qu.:2.000   1st Qu.:13.00   Class :character   Class :character  
 Median :4.000   Median :17.00   Mode  :character   Mode  :character  
 Mean   :4.004   Mean   :16.09                                        
 3rd Qu.:6.000   3rd Qu.:19.00                                        
 Max.   :7.000   Max.   :23.00                                        
                                                                      
 rider_total_fee  order_level    deliveredat_max                   shift       
 Min.   : 2100   Min.   :  487   Min.   :2020-09-26 00:07:40   Min.   : 1.000  
 1st Qu.: 2700   1st Qu.: 2058   1st Qu.:2020-10-11 17:16:27   1st Qu.: 3.000  
 Median : 2900   Median : 2992   Median :2020-10-27 19:18:27   Median : 6.000  
 Mean   : 2991   Mean   : 4247   Mean   :2020-10-28 14:43:11   Mean   : 7.012  
 3rd Qu.: 3000   3rd Qu.: 4971   3rd Qu.:2020-11-14 14:53:58   3rd Qu.:10.000  
 Max.   :10900   Max.   :38779   Max.   :2020-12-01 00:28:34   Max.   :44.000  
                 NA's   :5916                                                  
     Treat            After         rider_date          riderDOW        
 Min.   :0.0000   Min.   :0.0000   Length:815191      Length:815191     
 1st Qu.:0.0000   1st Qu.:0.0000   Class :character   Class :character  
 Median :1.0000   Median :1.0000   Mode  :character   Mode  :character  
 Mean   :0.7377   Mean   :0.5209                                        
 3rd Qu.:1.0000   3rd Qu.:1.0000                                        
 Max.   :1.0000   Max.   :1.0000                                        
                                                                        
      wb5               wb4              wb3              wb2        
 Min.   :0.00000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.00000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.03933   Mean   :0.1087   Mean   :0.1119   Mean   :0.1088  
 3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000  
 Max.   :1.00000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                     
      wb1               w2                w1              w3         
 Min.   :0.0000   Min.   :0.00000   Min.   :0.000   Min.   :0.00000  
 1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.000   1st Qu.:0.00000  
 Median :0.0000   Median :0.00000   Median :0.000   Median :0.00000  
 Mean   :0.1104   Mean   :0.09994   Mean   :0.103   Mean   :0.09741  
 3rd Qu.:0.0000   3rd Qu.:0.00000   3rd Qu.:0.000   3rd Qu.:0.00000  
 Max.   :1.0000   Max.   :1.00000   Max.   :1.000   Max.   :1.00000  
                                                                     
       w4               w5            peak           midpeak      
 Min.   :0.0000   Min.   :0.00   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.00   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :0.00   Median :1.0000   Median :0.0000  
 Mean   :0.1005   Mean   :0.12   Mean   :0.6469   Mean   :0.2891  
 3rd Qu.:0.0000   3rd Qu.:0.00   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.00   Max.   :1.0000   Max.   :1.0000  
                                                                  
    offpeak             prof         prof_low50      prof_high50    
 Min.   :0.00000   Min.   :1.934   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.00000   1st Qu.:4.145   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.00000   Median :4.724   Median :0.0000   Median :1.0000  
 Mean   :0.06392   Mean   :4.937   Mean   :0.4203   Mean   :0.5797  
 3rd Qu.:0.00000   3rd Qu.:5.615   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.00000   Max.   :8.555   Max.   :1.0000   Max.   :1.0000  
                                                                    
    prof_low         prof_med        prof_high      share_aiorder   
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.000   
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.002   
 Median :0.0000   Median :0.0000   Median :0.0000   Median :0.008   
 Mean   :0.2608   Mean   :0.3199   Mean   :0.4193   Mean   :0.046   
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:0.020   
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :0.755   
                                                    NA's   :213819  
```


## `idletimes`

- class: `function`

## `rider_preexist`

- class: `grouped_df, tbl_df, tbl, data.frame`
- dim: 584 rows x 11 cols
- columns: `rider_id`, `created_at`, `first_date`, `last_date`, `total_orders`, `before_orders`, `after_orders`, `AI_assigned_orders`, `AI_completed_orders`, `num_date`, `AI_intro_date`

### sample (first 5 rows)

```
  rider_id       created_at first_date  last_date total_orders before_orders
1     7643 2017-09-01 16:20 2019-04-01 2020-11-30         5407           243
2     7803 2017-09-07 18:02 2019-04-01 2020-11-30        14342           954
3     8843 2017-10-25 23:44 2019-04-03 2020-11-30         4495            71
4     9524 2017-11-23 22:04 2019-04-01 2020-11-30         9045           298
5     9535 2017-11-24 14:47 2019-04-02 2020-11-28        12365           587
  after_orders AI_assigned_orders AI_completed_orders num_date AI_intro_date
1          190                  3                   0      553           Inf
2          871                 15                   6      555    2020-10-28
3          193                  1                   0      543           Inf
4          363                  3                   2      471    2020-10-29
5          356                  1                   1      340    2020-11-09
```

### column types

```
rider_id: integer
created_at: factor
first_date: Date
last_date: Date
total_orders: integer
before_orders: integer
after_orders: integer
AI_assigned_orders: numeric
AI_completed_orders: numeric
num_date: integer
AI_intro_date: Date
```

### summary

```
    rider_id                created_at    first_date        
 Min.   : 7643   2018-12-18 19:24:  2   Min.   :2019-04-01  
 1st Qu.:29984   2020-08-31 12:18:  2   1st Qu.:2019-07-07  
 Median :43461   2017-09-01 16:20:  1   Median :2020-02-25  
 Mean   :39998   2017-09-07 18:02:  1   Mean   :2020-01-15  
 3rd Qu.:51462   2017-10-25 23:44:  1   3rd Qu.:2020-07-15  
 Max.   :56805   2017-11-23 22:04:  1   Max.   :2020-09-26  
                 (Other)         :576                       
   last_date           total_orders   before_orders     after_orders   
 Min.   :2020-10-26   Min.   :   60   Min.   :   4.0   Min.   :   1.0  
 1st Qu.:2020-11-28   1st Qu.: 2222   1st Qu.: 334.5   1st Qu.: 269.0  
 Median :2020-11-30   Median : 5314   Median : 642.0   Median : 653.0  
 Mean   :2020-11-25   Mean   : 7090   Mean   : 668.7   Mean   : 727.1  
 3rd Qu.:2020-11-30   3rd Qu.: 9940   3rd Qu.: 947.0   3rd Qu.:1107.0  
 Max.   :2020-11-30   Max.   :34800   Max.   :2312.0   Max.   :2760.0  
                                                                       
 AI_assigned_orders AI_completed_orders    num_date      AI_intro_date       
 Min.   :   0.00    Min.   :  0.00      Min.   :  8.00   Min.   :2020-10-26  
 1st Qu.:   2.00    1st Qu.:  0.00      1st Qu.: 90.75   1st Qu.:2020-10-26  
 Median :   8.00    Median :  4.00      Median :180.00   Median :2020-10-29  
 Mean   :  56.61    Mean   : 46.86      Mean   :221.18   Mean   :Inf         
 3rd Qu.:  28.00    3rd Qu.: 21.25      3rd Qu.:333.25   3rd Qu.:Inf         
 Max.   :1021.00    Max.   :942.00      Max.   :593.00   Max.   :Inf         
                                                                             
```


## `data_shift`

- class: `data.frame`
- dim: 283895 rows x 49 cols
- columns: `rider_id`, `management_partner_id`, `date`, `After`, `shift`, `rider_date`, `num_orders`, `num_aiorders`, `share_aiorders`, `avg_assign`, `avg_pickup`, `avg_deliver`, `avg_waiting`, `sd_waiting`, `var_waiting`, `share_failed`, `avg_dist`, `shift_profit`, `avg_order_level`, `Treat`, `start`, `finish`, `total_duration`, `idle_btw_shifts`, `avg_duration_orders`, `ai_assist`, `station_date`, `start_hour`, `wday`, `hourDOW`, `riderDOW`, `pre_shift_orders`, `wb5`, `wb4`, `wb3`, `wb2`, `wb1`, `w1`, `w2`, `w3`, `w4`, `w5`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `share_aiorder`

### sample (first 5 rows)

```
  rider_id management_partner_id       date After shift      rider_date
1     7643                   258 2020-09-26     0     1 7643_2020-09-26
2     7643                   258 2020-09-26     0     2 7643_2020-09-26
3     7643                   258 2020-09-26     0     3 7643_2020-09-26
4     7643                   258 2020-09-26     0     4 7643_2020-09-26
5     7643                   258 2020-09-26     0     5 7643_2020-09-26
  num_orders num_aiorders share_aiorders avg_assign avg_pickup avg_deliver
1          2            0              0   3.008333   2.733333   14.183333
2          1            0              0   1.133333   4.016667    3.400000
3          1            0              0   2.233333   3.433333    9.183333
4          5            0              0   3.413333   3.640000    9.340000
5          1            0              0   4.583333   5.816667    8.116667
  avg_waiting sd_waiting var_waiting share_failed  avg_dist shift_profit
1    19.92500  0.9310239   0.8668056            0 2.2583617         6000
2     8.55000         NA          NA            0 0.3404652         3000
3    14.85000         NA          NA            0 1.9979933         3000
4    16.39333  5.0443670  25.4456389            0 1.7437548        15000
5    18.51667         NA          NA            0 2.0137000         3000
  avg_order_level Treat               start              finish total_duration
1        1369.460     0 2020-09-26 13:16:01 2020-09-26 13:34:25      18.400000
2        8811.473     0 2020-09-26 16:37:42 2020-09-26 16:45:07       7.416667
3        1501.507     0 2020-09-26 16:45:17 2020-09-26 16:57:54      12.616667
4        1903.085     0 2020-09-26 18:18:23 2020-09-26 18:55:39      37.266667
5        1489.795     0 2020-09-26 18:58:14 2020-09-26 19:12:10      13.933333
  idle_btw_shifts avg_duration_orders ai_assist   station_date start_hour wday
1              NA            9.200000         0 258_2020-09-26         13    7
2              NA            7.416667         0 258_2020-09-26         16    7
3       0.1666667           12.616667         0 258_2020-09-26         16    7
4              NA            7.453333         0 258_2020-09-26         18    7
5       2.5833333           13.933333         0 258_2020-09-26         18    7
  hourDOW riderDOW pre_shift_orders wb5 wb4 wb3 wb2 wb1 w1 w2 w3 w4 w5     prof
1    13_7   7643_7               NA   1   0   0   0   0  0  0  0  0  0 4.729133
2    16_7   7643_7                2   1   0   0   0   0  0  0  0  0  0 4.729133
3    16_7   7643_7                1   1   0   0   0   0  0  0  0  0  0 4.729133
4    18_7   7643_7                1   1   0   0   0   0  0  0  0  0  0 4.729133
5    18_7   7643_7                5   1   0   0   0   0  0  0  0  0  0 4.729133
  prof_low50 prof_high50 prof_low prof_med prof_high share_aiorder
1          0           1        0        1         0            NA
2          0           1        0        1         0            NA
3          0           1        0        1         0            NA
4          0           1        0        1         0            NA
5          0           1        0        1         0            NA
```

### column types

```
rider_id: integer
management_partner_id: integer
date: Date
After: numeric
shift: numeric
rider_date: character
num_orders: integer
num_aiorders: integer
share_aiorders: numeric
avg_assign: numeric
avg_pickup: numeric
avg_deliver: numeric
avg_waiting: numeric
sd_waiting: numeric
var_waiting: numeric
share_failed: numeric
avg_dist: numeric
shift_profit: numeric
avg_order_level: numeric
Treat: numeric
start: POSIXct/POSIXt
finish: POSIXct/POSIXt
total_duration: numeric
idle_btw_shifts: numeric
avg_duration_orders: numeric
ai_assist: numeric
station_date: character
start_hour: integer
wday: numeric
hourDOW: character
riderDOW: character
pre_shift_orders: integer
wb5: numeric
wb4: numeric
wb3: numeric
wb2: numeric
wb1: numeric
w1: numeric
w2: numeric
w3: numeric
w4: numeric
w5: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
share_aiorder: numeric
```

### summary

```
    rider_id     management_partner_id      date                After       
 Min.   : 7643   Min.   : 258          Min.   :2020-09-26   Min.   :0.0000  
 1st Qu.:31390   1st Qu.: 296          1st Qu.:2020-10-12   1st Qu.:0.0000  
 Median :44074   Median : 466          Median :2020-10-28   Median :1.0000  
 Mean   :40387   Mean   : 558          Mean   :2020-10-27   Mean   :0.5329  
 3rd Qu.:51791   3rd Qu.: 815          3rd Qu.:2020-11-13   3rd Qu.:1.0000  
 Max.   :56805   Max.   :1244          Max.   :2020-11-30   Max.   :1.0000  
                                                                            
     shift         rider_date          num_orders      num_aiorders     
 Min.   : 1.000   Length:283895      Min.   : 1.000   Min.   : 0.00000  
 1st Qu.: 3.000   Class :character   1st Qu.: 1.000   1st Qu.: 0.00000  
 Median : 7.000   Mode  :character   Median : 2.000   Median : 0.00000  
 Mean   : 8.002                      Mean   : 2.871   Mean   : 0.09639  
 3rd Qu.:11.000                      3rd Qu.: 3.000   3rd Qu.: 0.00000  
 Max.   :44.000                      Max.   :96.000   Max.   :28.00000  
                                                                        
 share_aiorders     avg_assign         avg_pickup      avg_deliver    
 Min.   :0.0000   Min.   : 0.00000   Min.   : 0.000   Min.   : 1.000  
 1st Qu.:0.0000   1st Qu.: 0.06667   1st Qu.: 3.983   1st Qu.: 5.300  
 Median :0.0000   Median : 0.16667   Median : 6.617   Median : 7.517  
 Mean   :0.0422   Mean   : 1.19869   Mean   : 7.331   Mean   : 8.030  
 3rd Qu.:0.0000   3rd Qu.: 1.06667   3rd Qu.:10.054   3rd Qu.:10.142  
 Max.   :1.0000   Max.   :59.40000   Max.   :47.800   Max.   :55.800  
                                                                      
  avg_waiting      sd_waiting      var_waiting        share_failed   
 Min.   : 5.00   Min.   : 0.000   Min.   :   0.000   Min.   :0.0000  
 1st Qu.:11.40   1st Qu.: 3.147   1st Qu.:   9.904   1st Qu.:0.0000  
 Median :15.68   Median : 5.138   Median :  26.395   Median :0.0000  
 Mean   :16.56   Mean   : 5.467   Mean   :  40.707   Mean   :0.0634  
 3rd Qu.:20.74   3rd Qu.: 7.261   3rd Qu.:  52.726   3rd Qu.:0.0000  
 Max.   :85.62   Max.   :48.130   Max.   :2316.536   Max.   :1.0000  
                 NA's   :128260   NA's   :128260                     
    avg_dist       shift_profit    avg_order_level     Treat       
 Min.   :0.1000   Min.   :  2100   Min.   :  487   Min.   :0.0000  
 1st Qu.:0.7059   1st Qu.:  3000   1st Qu.: 2242   1st Qu.:0.0000  
 Median :1.0285   Median :  5500   Median : 3290   Median :1.0000  
 Mean   :1.1564   Mean   :  8589   Mean   : 4108   Mean   :0.7133  
 3rd Qu.:1.4592   3rd Qu.:  9000   3rd Qu.: 4949   3rd Qu.:1.0000  
 Max.   :7.7943   Max.   :272900   Max.   :33807   Max.   :1.0000  
 NA's   :5633                      NA's   :5633                    
     start                         finish                    total_duration   
 Min.   :2020-09-26 00:00:16   Min.   :2020-09-26 00:07:40   Min.   :  1.117  
 1st Qu.:2020-10-12 12:46:18   1st Qu.:2020-10-12 13:17:51   1st Qu.: 11.867  
 Median :2020-10-28 11:14:47   Median :2020-10-28 11:37:19   Median : 19.150  
 Mean   :2020-10-28 14:38:37   Mean   :2020-10-28 15:08:13   Mean   : 29.597  
 3rd Qu.:2020-11-13 17:15:32   3rd Qu.:2020-11-13 17:42:49   3rd Qu.: 33.250  
 Max.   :2020-11-30 23:58:51   Max.   :2020-12-01 00:28:34   Max.   :633.350  
                                                                              
 idle_btw_shifts  avg_duration_orders   ai_assist       station_date      
 Min.   : 0.017   Min.   : 1.117      Min.   :0.00000   Length:283895     
 1st Qu.: 1.567   1st Qu.: 8.275      1st Qu.:0.00000   Class :character  
 Median : 4.367   Median :10.450      Median :0.00000   Mode  :character  
 Mean   : 8.796   Mean   :11.374      Mean   :0.05121                     
 3rd Qu.:10.850   3rd Qu.:13.406      3rd Qu.:0.00000                     
 Max.   :60.000   Max.   :64.383      Max.   :1.00000                     
 NA's   :46452                                                            
   start_hour        wday         hourDOW            riderDOW        
 Min.   : 0.0   Min.   :1.000   Length:283895      Length:283895     
 1st Qu.:13.0   1st Qu.:2.000   Class :character   Class :character  
 Median :17.0   Median :4.000   Mode  :character   Mode  :character  
 Mean   :15.8   Mean   :4.007                                        
 3rd Qu.:19.0   3rd Qu.:6.000                                        
 Max.   :23.0   Max.   :7.000                                        
                                                                     
 pre_shift_orders      wb5               wb4               wb3        
 Min.   : 1.00    Min.   :0.00000   Min.   :0.00000   Min.   :0.0000  
 1st Qu.: 1.00    1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.0000  
 Median : 2.00    Median :0.00000   Median :0.00000   Median :0.0000  
 Mean   : 2.81    Mean   :0.03458   Mean   :0.09759   Mean   :0.1147  
 3rd Qu.: 3.00    3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.0000  
 Max.   :96.00    Max.   :1.00000   Max.   :1.00000   Max.   :1.0000  
 NA's   :26280                                                        
      wb2              wb1               w1               w2        
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.1101   Mean   :0.1101   Mean   :0.1139   Mean   :0.1061  
 3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
       w3               w4                w5              prof      
 Min.   :0.0000   Min.   :0.00000   Min.   :0.0000   Min.   :1.934  
 1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:3.924  
 Median :0.0000   Median :0.00000   Median :0.0000   Median :4.541  
 Mean   :0.1043   Mean   :0.09837   Mean   :0.1102   Mean   :4.621  
 3rd Qu.:0.0000   3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:5.223  
 Max.   :1.0000   Max.   :1.00000   Max.   :1.0000   Max.   :8.555  
                                                                    
   prof_low50      prof_high50        prof_low         prof_med     
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :1.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.5178   Mean   :0.4822   Mean   :0.3521   Mean   :0.3372  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
   prof_high      share_aiorder  
 Min.   :0.0000   Min.   :0.000  
 1st Qu.:0.0000   1st Qu.:0.002  
 Median :0.0000   Median :0.007  
 Mean   :0.3107   Mean   :0.042  
 3rd Qu.:1.0000   3rd Qu.:0.021  
 Max.   :1.0000   Max.   :0.755  
                  NA's   :81387  
```


## `data_shift_matched1`

- class: `data.frame`
- dim: 153190 rows x 50 cols
- columns: `rider_id`, `management_partner_id`, `date`, `After`, `shift`, `rider_date`, `num_orders`, `num_aiorders`, `share_aiorders`, `avg_assign`, `avg_pickup`, `avg_deliver`, `avg_waiting`, `sd_waiting`, `var_waiting`, `share_failed`, `avg_dist`, `shift_profit`, `avg_order_level`, `Treat`, `start`, `finish`, `total_duration`, `idle_btw_shifts`, `avg_duration_orders`, `ai_assist`, `station_date`, `start_hour`, `wday`, `hourDOW`, `riderDOW`, `pre_shift_orders`, `wb5`, `wb4`, `wb3`, `wb2`, `wb1`, `w1`, `w2`, `w3`, `w4`, `w5`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `share_aiorder`, `subclass`

### sample (first 5 rows)

```
  rider_id management_partner_id       date After shift      rider_date
1     7643                   258 2020-09-26     0     1 7643_2020-09-26
2     7643                   258 2020-09-26     0     2 7643_2020-09-26
3     7643                   258 2020-09-26     0     3 7643_2020-09-26
4     7643                   258 2020-09-26     0     4 7643_2020-09-26
5     7643                   258 2020-09-26     0     5 7643_2020-09-26
  num_orders num_aiorders share_aiorders avg_assign avg_pickup avg_deliver
1          2            0              0   3.008333   2.733333   14.183333
2          1            0              0   1.133333   4.016667    3.400000
3          1            0              0   2.233333   3.433333    9.183333
4          5            0              0   3.413333   3.640000    9.340000
5          1            0              0   4.583333   5.816667    8.116667
  avg_waiting sd_waiting var_waiting share_failed  avg_dist shift_profit
1    19.92500  0.9310239   0.8668056            0 2.2583617         6000
2     8.55000         NA          NA            0 0.3404652         3000
3    14.85000         NA          NA            0 1.9979933         3000
4    16.39333  5.0443670  25.4456389            0 1.7437548        15000
5    18.51667         NA          NA            0 2.0137000         3000
  avg_order_level Treat               start              finish total_duration
1        1369.460     0 2020-09-26 13:16:01 2020-09-26 13:34:25      18.400000
2        8811.473     0 2020-09-26 16:37:42 2020-09-26 16:45:07       7.416667
3        1501.507     0 2020-09-26 16:45:17 2020-09-26 16:57:54      12.616667
4        1903.085     0 2020-09-26 18:18:23 2020-09-26 18:55:39      37.266667
5        1489.795     0 2020-09-26 18:58:14 2020-09-26 19:12:10      13.933333
  idle_btw_shifts avg_duration_orders ai_assist   station_date start_hour wday
1              NA            9.200000         0 258_2020-09-26         13    7
2              NA            7.416667         0 258_2020-09-26         16    7
3       0.1666667           12.616667         0 258_2020-09-26         16    7
4              NA            7.453333         0 258_2020-09-26         18    7
5       2.5833333           13.933333         0 258_2020-09-26         18    7
  hourDOW riderDOW pre_shift_orders wb5 wb4 wb3 wb2 wb1 w1 w2 w3 w4 w5     prof
1    13_7   7643_7               NA   1   0   0   0   0  0  0  0  0  0 4.729133
2    16_7   7643_7                2   1   0   0   0   0  0  0  0  0  0 4.729133
3    16_7   7643_7                1   1   0   0   0   0  0  0  0  0  0 4.729133
4    18_7   7643_7                1   1   0   0   0   0  0  0  0  0  0 4.729133
5    18_7   7643_7                5   1   0   0   0   0  0  0  0  0  0 4.729133
  prof_low50 prof_high50 prof_low prof_med prof_high share_aiorder subclass
1          0           1        0        1         0            NA       39
2          0           1        0        1         0            NA       39
3          0           1        0        1         0            NA       39
4          0           1        0        1         0            NA       39
5          0           1        0        1         0            NA       39
```

### column types

```
rider_id: integer
management_partner_id: integer
date: Date
After: numeric
shift: numeric
rider_date: character
num_orders: integer
num_aiorders: integer
share_aiorders: numeric
avg_assign: numeric
avg_pickup: numeric
avg_deliver: numeric
avg_waiting: numeric
sd_waiting: numeric
var_waiting: numeric
share_failed: numeric
avg_dist: numeric
shift_profit: numeric
avg_order_level: numeric
Treat: numeric
start: POSIXct/POSIXt
finish: POSIXct/POSIXt
total_duration: numeric
idle_btw_shifts: numeric
avg_duration_orders: numeric
ai_assist: numeric
station_date: character
start_hour: integer
wday: numeric
hourDOW: character
riderDOW: character
pre_shift_orders: integer
wb5: numeric
wb4: numeric
wb3: numeric
wb2: numeric
wb1: numeric
w1: numeric
w2: numeric
w3: numeric
w4: numeric
w5: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
share_aiorder: numeric
subclass: factor
```

### summary

```
    rider_id     management_partner_id      date                After       
 Min.   : 7643   Min.   : 258.0        Min.   :2020-09-26   Min.   :0.0000  
 1st Qu.:30734   1st Qu.: 258.0        1st Qu.:2020-10-11   1st Qu.:0.0000  
 Median :43391   Median : 296.0        Median :2020-10-27   Median :1.0000  
 Mean   :39658   Mean   : 465.1        Mean   :2020-10-27   Mean   :0.5263  
 3rd Qu.:50384   3rd Qu.: 571.0        3rd Qu.:2020-11-13   3rd Qu.:1.0000  
 Max.   :56805   Max.   :1244.0        Max.   :2020-11-30   Max.   :1.0000  
                                                                            
     shift         rider_date          num_orders      num_aiorders    
 Min.   : 1.000   Length:153190      Min.   : 1.000   Min.   : 0.0000  
 1st Qu.: 3.000   Class :character   1st Qu.: 1.000   1st Qu.: 0.0000  
 Median : 7.000   Mode  :character   Median : 2.000   Median : 0.0000  
 Mean   : 8.374                      Mean   : 2.538   Mean   : 0.0453  
 3rd Qu.:12.000                      3rd Qu.: 3.000   3rd Qu.: 0.0000  
 Max.   :44.000                      Max.   :69.000   Max.   :26.0000  
                                                                       
 share_aiorders      avg_assign         avg_pickup      avg_deliver    
 Min.   :0.00000   Min.   : 0.00000   Min.   : 0.000   Min.   : 1.000  
 1st Qu.:0.00000   1st Qu.: 0.06667   1st Qu.: 3.267   1st Qu.: 5.117  
 Median :0.00000   Median : 0.15000   Median : 5.295   Median : 7.233  
 Mean   :0.01948   Mean   : 1.13349   Mean   : 6.189   Mean   : 7.743  
 3rd Qu.:0.00000   3rd Qu.: 0.98333   3rd Qu.: 8.201   3rd Qu.: 9.750  
 Max.   :1.00000   Max.   :58.28333   Max.   :42.939   Max.   :53.550  
                                                                       
  avg_waiting      sd_waiting      var_waiting       share_failed    
 Min.   : 5.00   Min.   : 0.000   Min.   :   0.00   Min.   :0.00000  
 1st Qu.:10.25   1st Qu.: 2.897   1st Qu.:   8.39   1st Qu.:0.00000  
 Median :13.96   Median : 4.770   Median :  22.75   Median :0.00000  
 Mean   :15.07   Mean   : 5.119   Mean   :  36.18   Mean   :0.04476  
 3rd Qu.:18.65   3rd Qu.: 6.824   3rd Qu.:  46.56   3rd Qu.:0.00000  
 Max.   :74.48   Max.   :48.130   Max.   :2316.54   Max.   :1.00000  
                 NA's   :74863    NA's   :74863                      
    avg_dist       shift_profit    avg_order_level     Treat      
 Min.   :0.1000   Min.   :  2100   Min.   :  487   Min.   :0.000  
 1st Qu.:0.6968   1st Qu.:  3000   1st Qu.: 2188   1st Qu.:0.000  
 Median :1.0331   Median :  5300   Median : 3238   Median :0.000  
 Mean   :1.1579   Mean   :  7564   Mean   : 4101   Mean   :0.498  
 3rd Qu.:1.4786   3rd Qu.:  8400   3rd Qu.: 4963   3rd Qu.:1.000  
 Max.   :6.8995   Max.   :214600   Max.   :30870   Max.   :1.000  
 NA's   :2499                      NA's   :2499                   
     start                         finish                    total_duration   
 Min.   :2020-09-26 00:02:06   Min.   :2020-09-26 00:07:40   Min.   :  1.117  
 1st Qu.:2020-10-11 22:42:16   1st Qu.:2020-10-11 23:00:45   1st Qu.: 10.433  
 Median :2020-10-27 21:21:43   Median :2020-10-27 21:42:38   Median : 16.400  
 Mean   :2020-10-28 13:01:19   Mean   :2020-10-28 13:25:49   Mean   : 24.491  
 3rd Qu.:2020-11-13 18:20:44   3rd Qu.:2020-11-13 18:52:26   3rd Qu.: 27.767  
 Max.   :2020-11-30 23:58:15   Max.   :2020-12-01 00:21:39   Max.   :527.917  
                                                                              
 idle_btw_shifts   avg_duration_orders   ai_assist       station_date      
 Min.   : 0.0167   Min.   : 1.117      Min.   :0.00000   Length:153190     
 1st Qu.: 1.6000   1st Qu.: 7.700      1st Qu.:0.00000   Class :character  
 Median : 4.4167   Median : 9.617      Median :0.00000   Mode  :character  
 Mean   : 8.8987   Mean   :10.536      Mean   :0.02398                     
 3rd Qu.:10.9833   3rd Qu.:12.350      3rd Qu.:0.00000                     
 Max.   :60.0000   Max.   :64.383      Max.   :1.00000                     
 NA's   :25235                                                             
   start_hour         wday         hourDOW            riderDOW        
 Min.   : 0.00   Min.   :1.000   Length:153190      Length:153190     
 1st Qu.:13.00   1st Qu.:2.000   Class :character   Class :character  
 Median :17.00   Median :4.000   Mode  :character   Mode  :character  
 Mean   :16.02   Mean   :4.027                                        
 3rd Qu.:19.00   3rd Qu.:6.000                                        
 Max.   :23.00   Max.   :7.000                                        
                                                                      
 pre_shift_orders      wb5               wb4               wb3        
 Min.   : 1.0     Min.   :0.00000   Min.   :0.00000   Min.   :0.0000  
 1st Qu.: 1.0     1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.0000  
 Median : 2.0     Median :0.00000   Median :0.00000   Median :0.0000  
 Mean   : 2.5     Mean   :0.03678   Mean   :0.09907   Mean   :0.1149  
 3rd Qu.: 3.0     3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.0000  
 Max.   :69.0     Max.   :1.00000   Max.   :1.00000   Max.   :1.0000  
 NA's   :14102                                                        
      wb2              wb1               w1               w2        
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.1108   Mean   :0.1122   Mean   :0.1085   Mean   :0.1056  
 3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
       w3               w4               w5              prof      
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :1.934  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:4.032  
 Median :0.0000   Median :0.0000   Median :0.0000   Median :4.675  
 Mean   :0.1025   Mean   :0.0979   Mean   :0.1118   Mean   :4.736  
 3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:5.355  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :7.870  
                                                                   
   prof_low50      prof_high50        prof_low         prof_med     
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :1.0000   Median :0.0000   Median :0.0000  
 Mean   :0.4548   Mean   :0.5452   Mean   :0.3004   Mean   :0.3582  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
   prof_high      share_aiorder      subclass     
 Min.   :0.0000   Min.   :0.000   21     :  2912  
 1st Qu.:0.0000   1st Qu.:0.001   8      :  2593  
 Median :0.0000   Median :0.004   40     :  2351  
 Mean   :0.3414   Mean   :0.029   34     :  2202  
 3rd Qu.:1.0000   3rd Qu.:0.017   89     :  2194  
 Max.   :1.0000   Max.   :0.755   42     :  2084  
                  NA's   :76906   (Other):138854  
```


## `data_day_matched1`

- class: `data.frame`
- dim: 14102 rows x 53 cols
- columns: `rider_id`, `Treat`, `management_partner_id`, `date`, `After`, `station_date`, `rider_date`, `total_shift`, `mean_orders_shift`, `mean_duration_shift`, `share_aggshift`, `share_singleshift`, `orders_stacked`, `orders_one`, `num_singleshift`, `num_stackedshift`, `mean_orders_aggshift`, `mean_duration_aggshift`, `total_fee`, `working_duration`, `idle_duration`, `total_labor`, `total_orders`, `total_aiorders`, `ai_assist_day`, `share_workingd`, `share_idled`, `orders_per_hour`, `avg_waiting`, `sd_waiting`, `var_waiting`, `share_failedorders`, `wb5`, `wb4`, `wb3`, `wb2`, `wb1`, `w1`, `w2`, `w3`, `w4`, `w5`, `wday`, `riderDOW`, `share_aiorders`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `share_aiorder`, `subclass`

### sample (first 5 rows)

```
  rider_id Treat management_partner_id       date After   station_date
1     7643     0                   258 2020-09-26     0 258_2020-09-26
2     7643     0                   258 2020-09-27     0 258_2020-09-27
3     7643     0                   258 2020-09-28     0 258_2020-09-28
4     7643     0                   258 2020-09-29     0 258_2020-09-29
5     7643     0                   258 2020-09-30     0 258_2020-09-30
       rider_date total_shift mean_orders_shift mean_duration_shift
1 7643_2020-09-26           8          1.625000            14.10000
2 7643_2020-09-27          13          1.384615            11.38077
3 7643_2020-09-28           6          1.666667            13.36944
4 7643_2020-09-29           5          1.000000            10.18333
5 7643_2020-09-30           1          3.000000            22.15000
  share_aggshift share_singleshift orders_stacked orders_one num_singleshift
1      0.2500000         0.7500000              7          6               6
2      0.3076923         0.6923077              9          9               9
3      0.5000000         0.5000000              7          3               3
4      0.0000000         1.0000000              0          5               5
5      1.0000000         0.0000000              3          0               0
  num_stackedshift mean_orders_aggshift mean_duration_aggshift total_fee
1                2             3.500000               27.83333     39000
2                4             2.250000               16.56667     54800
3                3             2.333333               19.00556     30000
4                0                  NaN                    NaN     14900
5                1             3.000000               22.15000     10200
  working_duration idle_duration total_labor total_orders total_aiorders
1        1.8800000     0.4069444   2.2869444           13              0
2        2.4658333     0.8216667   3.2875000           18              0
3        1.3369444     0.3250000   1.6619444           10              0
4        0.8486111     1.1766667   2.0252778            5              0
5        0.3691667     0.0000000   0.3691667            3              0
  ai_assist_day share_workingd share_idled orders_per_hour avg_waiting
1             0      0.8220576   0.1779424        5.684441    15.63846
2             0      0.7500634   0.2499366        5.475285    13.64074
3             0      0.8044459   0.1955541        6.017048    15.45667
4             0      0.4190097   0.5809903        2.468797    14.13000
5             0      1.0000000   0.0000000        8.126411    25.08333
  sd_waiting var_waiting share_failedorders wb5 wb4 wb3 wb2 wb1 w1 w2 w3 w4 w5
1   4.465430   19.940064                  0   1   0   0   0   0  0  0  0  0  0
2   4.458106   19.874713                  0   1   0   0   0   0  0  0  0  0  0
3   4.570519   20.889642                  0   0   1   0   0   0  0  0  0  0  0
4   5.832493   34.017972                  0   0   1   0   0   0  0  0  0  0  0
5   2.622393    6.876944                  0   0   1   0   0   0  0  0  0  0  0
  wday riderDOW share_aiorders     prof prof_low50 prof_high50 prof_low
1    7   7643_7             NA 4.729133          0           1        0
2    1   7643_1             NA 4.729133          0           1        0
3    2   7643_2             NA 4.729133          0           1        0
4    3   7643_3             NA 4.729133          0           1        0
5    4   7643_4             NA 4.729133          0           1        0
  prof_med prof_high share_aiorder subclass
1        1         0            NA       39
2        1         0            NA       39
3        1         0            NA       39
4        1         0            NA       39
5        1         0            NA       39
```

### column types

```
rider_id: integer
Treat: numeric
management_partner_id: integer
date: Date
After: numeric
station_date: character
rider_date: character
total_shift: integer
mean_orders_shift: numeric
mean_duration_shift: numeric
share_aggshift: numeric
share_singleshift: numeric
orders_stacked: integer
orders_one: integer
num_singleshift: integer
num_stackedshift: integer
mean_orders_aggshift: numeric
mean_duration_aggshift: numeric
total_fee: numeric
working_duration: numeric
idle_duration: numeric
total_labor: numeric
total_orders: integer
total_aiorders: integer
ai_assist_day: numeric
share_workingd: numeric
share_idled: numeric
orders_per_hour: numeric
avg_waiting: numeric
sd_waiting: numeric
var_waiting: numeric
share_failedorders: numeric
wb5: numeric
wb4: numeric
wb3: numeric
wb2: numeric
wb1: numeric
w1: numeric
w2: numeric
w3: numeric
w4: numeric
w5: numeric
wday: numeric
riderDOW: character
share_aiorders: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
share_aiorder: numeric
subclass: factor
```

### summary

```
    rider_id         Treat       management_partner_id      date           
 Min.   : 7643   Min.   :0.000   Min.   : 258.0        Min.   :2020-09-26  
 1st Qu.:29585   1st Qu.:0.000   1st Qu.: 296.0        1st Qu.:2020-10-11  
 Median :43382   Median :1.000   Median : 414.0        Median :2020-10-27  
 Mean   :39537   Mean   :0.507   Mean   : 534.5        Mean   :2020-10-27  
 3rd Qu.:50443   3rd Qu.:1.000   3rd Qu.: 815.0        3rd Qu.:2020-11-13  
 Max.   :56805   Max.   :1.000   Max.   :1244.0        Max.   :2020-11-30  
                                                                           
     After        station_date        rider_date         total_shift   
 Min.   :0.0000   Length:14102       Length:14102       Min.   : 1.00  
 1st Qu.:0.0000   Class :character   Class :character   1st Qu.: 5.00  
 Median :1.0000   Mode  :character   Mode  :character   Median : 9.00  
 Mean   :0.5191                                         Mean   :10.86  
 3rd Qu.:1.0000                                         3rd Qu.:15.00  
 Max.   :1.0000                                         Max.   :44.00  
                                                                       
 mean_orders_shift mean_duration_shift share_aggshift   share_singleshift
 Min.   : 1.000    Min.   :  3.233     Min.   :0.0000   Min.   :0.0000   
 1st Qu.: 1.500    1st Qu.: 15.571     1st Qu.:0.3333   1st Qu.:0.2500   
 Median : 2.143    Median : 23.587     Median :0.5500   Median :0.4500   
 Mean   : 2.964    Mean   : 29.383     Mean   :0.5444   Mean   :0.4556   
 3rd Qu.: 3.429    3rd Qu.: 35.213     3rd Qu.:0.7500   3rd Qu.:0.6667   
 Max.   :63.000    Max.   :410.300     Max.   :1.0000   Max.   :1.0000   
                                                                         
 orders_stacked     orders_one     num_singleshift  num_stackedshift
 Min.   :  0.00   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
 1st Qu.:  8.00   1st Qu.: 2.000   1st Qu.: 2.000   1st Qu.: 2.000  
 Median : 17.00   Median : 4.000   Median : 4.000   Median : 5.000  
 Mean   : 22.26   Mean   : 5.309   Mean   : 5.309   Mean   : 5.554  
 3rd Qu.: 32.00   3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.: 8.000  
 Max.   :123.00   Max.   :37.000   Max.   :37.000   Max.   :26.000  
                                                                    
 mean_orders_aggshift mean_duration_aggshift   total_fee     
 Min.   : 2.000       Min.   :  8.833        Min.   :  2100  
 1st Qu.: 2.400       1st Qu.: 23.465        1st Qu.: 36500  
 Median : 3.176       Median : 33.089        Median : 71715  
 Mean   : 4.093       Mean   : 39.090        Mean   : 82165  
 3rd Qu.: 4.667       3rd Qu.: 46.362        3rd Qu.:117138  
 Max.   :63.000       Max.   :410.300        Max.   :423400  
 NA's   :945          NA's   :945                            
 working_duration   idle_duration     total_labor        total_orders   
 Min.   : 0.05389   Min.   :0.0000   Min.   : 0.05389   Min.   :  1.00  
 1st Qu.: 2.23333   1st Qu.:0.4031   1st Qu.: 2.98528   1st Qu.: 12.00  
 Median : 4.11167   Median :1.0778   Median : 5.60528   Median : 24.00  
 Mean   : 4.43406   Mean   :1.3457   Mean   : 5.77976   Mean   : 27.57  
 3rd Qu.: 6.37549   3rd Qu.:1.9994   3rd Qu.: 8.43694   3rd Qu.: 39.00  
 Max.   :14.63139   Max.   :7.0431   Max.   :16.09611   Max.   :124.00  
                                                                        
 total_aiorders    ai_assist_day     share_workingd    share_idled     
 Min.   : 0.0000   Min.   :0.00000   Min.   :0.2244   Min.   :0.00000  
 1st Qu.: 0.0000   1st Qu.:0.00000   1st Qu.:0.6749   1st Qu.:0.09865  
 Median : 0.0000   Median :0.00000   Median :0.8003   Median :0.19968  
 Mean   : 0.4921   Mean   :0.05396   Mean   :0.7805   Mean   :0.21946  
 3rd Qu.: 0.0000   3rd Qu.:0.00000   3rd Qu.:0.9014   3rd Qu.:0.32515  
 Max.   :54.0000   Max.   :1.00000   Max.   :1.0000   Max.   :0.77564  
                                                                       
 orders_per_hour   avg_waiting      sd_waiting        var_waiting       
 Min.   : 1.205   Min.   : 5.05   Min.   : 0.04714   Min.   :  0.00222  
 1st Qu.: 3.667   1st Qu.:13.63   1st Qu.: 4.67411   1st Qu.: 21.84727  
 Median : 4.542   Median :16.99   Median : 6.06985   Median : 36.84314  
 Mean   : 4.691   Mean   :17.75   Mean   : 6.31633   Mean   : 45.47352  
 3rd Qu.: 5.569   3rd Qu.:21.28   3rd Qu.: 7.61566   3rd Qu.: 57.99822  
 Max.   :18.557   Max.   :53.73   Max.   :27.18826   Max.   :739.20125  
                                  NA's   :320        NA's   :320        
 share_failedorders      wb5               wb4              wb3        
 Min.   :0.00000    Min.   :0.00000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.00000    1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.01818    Median :0.00000   Median :0.0000   Median :0.0000  
 Mean   :0.08555    Mean   :0.03489   Mean   :0.1022   Mean   :0.1162  
 3rd Qu.:0.12500    3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:0.0000  
 Max.   :1.00000    Max.   :1.00000   Max.   :1.0000   Max.   :1.0000  
                                                                       
      wb2              wb1               w1               w2        
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.1142   Mean   :0.1133   Mean   :0.1069   Mean   :0.1039  
 3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
       w3               w4                w5              wday      
 Min.   :0.0000   Min.   :0.00000   Min.   :0.0000   Min.   :1.000  
 1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:2.000  
 Median :0.0000   Median :0.00000   Median :0.0000   Median :4.000  
 Mean   :0.1007   Mean   :0.09736   Mean   :0.1103   Mean   :4.006  
 3rd Qu.:0.0000   3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:6.000  
 Max.   :1.0000   Max.   :1.00000   Max.   :1.0000   Max.   :7.000  
                                                                    
   riderDOW         share_aiorders        prof         prof_low50    
 Length:14102       Min.   :0.0000   Min.   :1.934   Min.   :0.0000  
 Class :character   1st Qu.:0.0000   1st Qu.:4.002   1st Qu.:0.0000  
 Mode  :character   Median :0.0000   Median :4.640   Median :0.0000  
                    Mean   :0.0428   Mean   :4.707   Mean   :0.4783  
                    3rd Qu.:0.0000   3rd Qu.:5.355   3rd Qu.:1.0000  
                    Max.   :1.0000   Max.   :7.870   Max.   :1.0000  
                    NA's   :6952                                     
  prof_high50        prof_low         prof_med        prof_high     
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :1.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.5217   Mean   :0.3156   Mean   :0.3459   Mean   :0.3385  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
 share_aiorder       subclass    
 Min.   :0.0003   27     :  125  
 1st Qu.:0.0014   97     :  125  
 Median :0.0073   131    :  124  
 Mean   :0.0434   67     :  120  
 3rd Qu.:0.0279   51     :  119  
 Max.   :0.7551   89     :  119  
 NA's   :6952     (Other):13370  
```


## `.Random.seed`

- class: `integer`
- length: 626
- head: 10403, 507, 1870575996, -891098689, -64256363, -1479304020, -344521086, 2047004253, 215445847, 2087230526

## `data_shift_matched_pre`

- class: `data.frame`
- dim: 72560 rows x 51 cols
- columns: `rider_id`, `management_partner_id`, `date`, `After`, `shift`, `rider_date`, `num_orders`, `num_aiorders`, `share_aiorders`, `avg_assign`, `avg_pickup`, `avg_deliver`, `avg_waiting`, `sd_waiting`, `var_waiting`, `share_failed`, `avg_dist`, `shift_profit`, `avg_order_level`, `Treat`, `start`, `finish`, `total_duration`, `idle_btw_shifts`, `avg_duration_orders`, `ai_assist`, `station_date`, `start_hour`, `wday`, `hourDOW`, `riderDOW`, `pre_shift_orders`, `wb5`, `wb4`, `wb3`, `wb2`, `wb1`, `w1`, `w2`, `w3`, `w4`, `w5`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `share_aiorder`, `subclass`, `After_premid`

### sample (first 5 rows)

```
  rider_id management_partner_id       date After shift      rider_date
1     7643                   258 2020-09-26     0     1 7643_2020-09-26
2     7643                   258 2020-09-26     0     2 7643_2020-09-26
3     7643                   258 2020-09-26     0     3 7643_2020-09-26
4     7643                   258 2020-09-26     0     4 7643_2020-09-26
5     7643                   258 2020-09-26     0     5 7643_2020-09-26
  num_orders num_aiorders share_aiorders avg_assign avg_pickup avg_deliver
1          2            0              0   3.008333   2.733333   14.183333
2          1            0              0   1.133333   4.016667    3.400000
3          1            0              0   2.233333   3.433333    9.183333
4          5            0              0   3.413333   3.640000    9.340000
5          1            0              0   4.583333   5.816667    8.116667
  avg_waiting sd_waiting var_waiting share_failed  avg_dist shift_profit
1    19.92500  0.9310239   0.8668056            0 2.2583617         6000
2     8.55000         NA          NA            0 0.3404652         3000
3    14.85000         NA          NA            0 1.9979933         3000
4    16.39333  5.0443670  25.4456389            0 1.7437548        15000
5    18.51667         NA          NA            0 2.0137000         3000
  avg_order_level Treat               start              finish total_duration
1        1369.460     0 2020-09-26 13:16:01 2020-09-26 13:34:25      18.400000
2        8811.473     0 2020-09-26 16:37:42 2020-09-26 16:45:07       7.416667
3        1501.507     0 2020-09-26 16:45:17 2020-09-26 16:57:54      12.616667
4        1903.085     0 2020-09-26 18:18:23 2020-09-26 18:55:39      37.266667
5        1489.795     0 2020-09-26 18:58:14 2020-09-26 19:12:10      13.933333
  idle_btw_shifts avg_duration_orders ai_assist   station_date start_hour wday
1              NA            9.200000         0 258_2020-09-26         13    7
2              NA            7.416667         0 258_2020-09-26         16    7
3       0.1666667           12.616667         0 258_2020-09-26         16    7
4              NA            7.453333         0 258_2020-09-26         18    7
5       2.5833333           13.933333         0 258_2020-09-26         18    7
  hourDOW riderDOW pre_shift_orders wb5 wb4 wb3 wb2 wb1 w1 w2 w3 w4 w5     prof
1    13_7   7643_7               NA   1   0   0   0   0  0  0  0  0  0 4.729133
2    16_7   7643_7                2   1   0   0   0   0  0  0  0  0  0 4.729133
3    16_7   7643_7                1   1   0   0   0   0  0  0  0  0  0 4.729133
4    18_7   7643_7                1   1   0   0   0   0  0  0  0  0  0 4.729133
5    18_7   7643_7                5   1   0   0   0   0  0  0  0  0  0 4.729133
  prof_low50 prof_high50 prof_low prof_med prof_high share_aiorder subclass
1          0           1        0        1         0            NA       39
2          0           1        0        1         0            NA       39
3          0           1        0        1         0            NA       39
4          0           1        0        1         0            NA       39
5          0           1        0        1         0            NA       39
  After_premid
1            0
2            0
3            0
4            0
5            0
```

### column types

```
rider_id: integer
management_partner_id: integer
date: Date
After: numeric
shift: numeric
rider_date: character
num_orders: integer
num_aiorders: integer
share_aiorders: numeric
avg_assign: numeric
avg_pickup: numeric
avg_deliver: numeric
avg_waiting: numeric
sd_waiting: numeric
var_waiting: numeric
share_failed: numeric
avg_dist: numeric
shift_profit: numeric
avg_order_level: numeric
Treat: numeric
start: POSIXct/POSIXt
finish: POSIXct/POSIXt
total_duration: numeric
idle_btw_shifts: numeric
avg_duration_orders: numeric
ai_assist: numeric
station_date: character
start_hour: integer
wday: numeric
hourDOW: character
riderDOW: character
pre_shift_orders: integer
wb5: numeric
wb4: numeric
wb3: numeric
wb2: numeric
wb1: numeric
w1: numeric
w2: numeric
w3: numeric
w4: numeric
w5: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
share_aiorder: numeric
subclass: factor
After_premid: numeric
```

### summary

```
    rider_id     management_partner_id      date                After  
 Min.   : 7643   Min.   : 258.0        Min.   :2020-09-26   Min.   :0  
 1st Qu.:30734   1st Qu.: 258.0        1st Qu.:2020-10-03   1st Qu.:0  
 Median :43391   Median : 296.0        Median :2020-10-11   Median :0  
 Mean   :39811   Mean   : 462.6        Mean   :2020-10-10   Mean   :0  
 3rd Qu.:50443   3rd Qu.: 571.0        3rd Qu.:2020-10-18   3rd Qu.:0  
 Max.   :56805   Max.   :1186.0        Max.   :2020-10-25   Max.   :0  
                                                                       
     shift         rider_date          num_orders      num_aiorders
 Min.   : 1.000   Length:72560       Min.   : 1.000   Min.   :0    
 1st Qu.: 3.000   Class :character   1st Qu.: 1.000   1st Qu.:0    
 Median : 7.000   Mode  :character   Median : 2.000   Median :0    
 Mean   : 8.392                      Mean   : 2.565   Mean   :0    
 3rd Qu.:12.000                      3rd Qu.: 3.000   3rd Qu.:0    
 Max.   :42.000                      Max.   :63.000   Max.   :0    
                                                                   
 share_aiorders   avg_assign         avg_pickup      avg_deliver    
 Min.   :0      Min.   : 0.00000   Min.   : 0.000   Min.   : 1.000  
 1st Qu.:0      1st Qu.: 0.06667   1st Qu.: 3.283   1st Qu.: 5.158  
 Median :0      Median : 0.15833   Median : 5.339   Median : 7.267  
 Mean   :0      Mean   : 1.18188   Mean   : 6.266   Mean   : 7.770  
 3rd Qu.:0      3rd Qu.: 1.09444   3rd Qu.: 8.333   3rd Qu.: 9.783  
 Max.   :0      Max.   :48.41667   Max.   :41.733   Max.   :50.267  
                                                                    
  avg_waiting      sd_waiting      var_waiting        share_failed    
 Min.   : 5.00   Min.   : 0.000   Min.   :   0.000   Min.   :0.00000  
 1st Qu.:10.38   1st Qu.: 2.923   1st Qu.:   8.542   1st Qu.:0.00000  
 Median :14.08   Median : 4.808   Median :  23.120   Median :0.00000  
 Mean   :15.22   Mean   : 5.140   Mean   :  36.329   Mean   :0.04748  
 3rd Qu.:18.83   3rd Qu.: 6.850   3rd Qu.:  46.918   3rd Qu.:0.00000  
 Max.   :68.47   Max.   :34.943   Max.   :1221.003   Max.   :1.00000  
                 NA's   :34782    NA's   :34782                       
    avg_dist       shift_profit    avg_order_level     Treat       
 Min.   :0.1001   Min.   :  2100   Min.   :  487   Min.   :0.0000  
 1st Qu.:0.6981   1st Qu.:  3000   1st Qu.: 2207   1st Qu.:0.0000  
 Median :1.0313   Median :  5400   Median : 3271   Median :0.0000  
 Mean   :1.1565   Mean   :  7696   Mean   : 4122   Mean   :0.4867  
 3rd Qu.:1.4720   3rd Qu.:  8500   3rd Qu.: 5011   3rd Qu.:1.0000  
 Max.   :6.8136   Max.   :214600   Max.   :30571   Max.   :1.0000  
 NA's   :1170                      NA's   :1170                    
     start                         finish                    total_duration   
 Min.   :2020-09-26 00:02:06   Min.   :2020-09-26 00:07:40   Min.   :  1.117  
 1st Qu.:2020-10-03 23:39:59   1st Qu.:2020-10-04 00:07:58   1st Qu.: 10.533  
 Median :2020-10-11 12:56:25   Median :2020-10-11 13:27:48   Median : 16.650  
 Mean   :2020-10-11 10:24:27   Mean   :2020-10-11 10:49:20   Mean   : 24.868  
 3rd Qu.:2020-10-18 18:30:48   3rd Qu.:2020-10-18 19:04:17   3rd Qu.: 28.233  
 Max.   :2020-10-26 00:19:51   Max.   :2020-10-26 00:30:47   Max.   :527.917  
                                                                              
 idle_btw_shifts   avg_duration_orders   ai_assist station_date      
 Min.   : 0.0167   Min.   : 1.117      Min.   :0   Length:72560      
 1st Qu.: 1.5667   1st Qu.: 7.708      1st Qu.:0   Class :character  
 Median : 4.3167   Median : 9.608      Median :0   Mode  :character  
 Mean   : 8.7736   Mean   :10.555      Mean   :0                     
 3rd Qu.:10.7000   3rd Qu.:12.357      3rd Qu.:0                     
 Max.   :59.9667   Max.   :61.433      Max.   :0                     
 NA's   :12066                                                       
   start_hour         wday         hourDOW            riderDOW        
 Min.   : 0.00   Min.   :1.000   Length:72560       Length:72560      
 1st Qu.:13.00   1st Qu.:2.000   Class :character   Class :character  
 Median :17.00   Median :4.000   Mode  :character   Mode  :character  
 Mean   :16.01   Mean   :4.041                                        
 3rd Qu.:19.00   3rd Qu.:6.000                                        
 Max.   :23.00   Max.   :7.000                                        
                                                                      
 pre_shift_orders      wb5               wb4              wb3        
 Min.   : 1.000   Min.   :0.00000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.: 1.000   1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median : 2.000   Median :0.00000   Median :0.0000   Median :0.0000  
 Mean   : 2.523   Mean   :0.07765   Mean   :0.2092   Mean   :0.2425  
 3rd Qu.: 3.000   3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:0.0000  
 Max.   :63.000   Max.   :1.00000   Max.   :1.0000   Max.   :1.0000  
 NA's   :6781                                                        
      wb2              wb1               w1          w2          w3   
 Min.   :0.0000   Min.   :0.0000   Min.   :0   Min.   :0   Min.   :0  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0   1st Qu.:0   1st Qu.:0  
 Median :0.0000   Median :0.0000   Median :0   Median :0   Median :0  
 Mean   :0.2339   Mean   :0.2368   Mean   :0   Mean   :0   Mean   :0  
 3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0   3rd Qu.:0   3rd Qu.:0  
 Max.   :1.0000   Max.   :1.0000   Max.   :0   Max.   :0   Max.   :0  
                                                                      
       w4          w5         prof         prof_low50     prof_high50   
 Min.   :0   Min.   :0   Min.   :1.934   Min.   :0.000   Min.   :0.000  
 1st Qu.:0   1st Qu.:0   1st Qu.:4.032   1st Qu.:0.000   1st Qu.:0.000  
 Median :0   Median :0   Median :4.664   Median :0.000   Median :1.000  
 Mean   :0   Mean   :0   Mean   :4.745   Mean   :0.459   Mean   :0.541  
 3rd Qu.:0   3rd Qu.:0   3rd Qu.:5.394   3rd Qu.:1.000   3rd Qu.:1.000  
 Max.   :0   Max.   :0   Max.   :7.870   Max.   :1.000   Max.   :1.000  
                                                                        
    prof_low         prof_med        prof_high      share_aiorder  
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.001  
 Median :0.0000   Median :0.0000   Median :0.0000   Median :0.003  
 Mean   :0.3024   Mean   :0.3525   Mean   :0.3451   Mean   :0.026  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:0.016  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :0.755  
                                                    NA's   :37245  
    subclass      After_premid   
 21     : 1375   Min.   :0.0000  
 8      : 1241   1st Qu.:0.0000  
 34     : 1031   Median :0.0000  
 40     : 1024   Mean   :0.4707  
 89     : 1020   3rd Qu.:1.0000  
 3      :  999   Max.   :1.0000  
 (Other):65870                   
```


## `psmatch1`

- class: `matchit`
- length: 14
- names: `match.matrix`, `subclass`, `weights`, `model`, `X`, `call`, `info`, `estimand`, `formula`, `treat`, `distance`, `discarded`, `caliper`, `nn`

## `store`

- class: `data.frame`
- dim: 78878 rows x 11 cols
- columns: `store_id`, `store_name`, `franchise_name`, `si_do`, `si_gun_gu`, `eup_myeon_dong`, `category`, `monitoring_partner_id`, `lat`, `lng`, `enterprise_registration_number`

### sample (first 5 rows)

```
  store_id              store_name franchise_name      si_do si_gun_gu
1        1     버거킹 선릉역점(구)    버거킹(BKR) 서울특별시    강남구
2        2     버거킹 당산역점(구)    버거킹(BKR) 서울특별시  영등포구
3        3 미스터피자 창동점(삭제) 미스터피자(MP) 서울특별시    도봉구
4        4     미스터피자 강남역점 미스터피자(MP) 서울특별시    서초구
5        6 미스터피자 압구정점(구) 미스터피자(MP) 서울특별시    강남구
  eup_myeon_dong category monitoring_partner_id      lat      lng
1         역삼동     버거                   312 37.50317 127.0493
2      당산동6가     버거                   269 37.53475 126.9006
3           창동     피자                    42 37.65181 127.0400
4         서초동     피자                   241 37.49827 127.0252
5         신사동     피자                    54 37.52482 127.0248
  enterprise_registration_number
1                     1018676277
2                     1018676277
3                               
4                               
5                               
```

### column types

```
store_id: integer
store_name: character
franchise_name: character
si_do: character
si_gun_gu: character
eup_myeon_dong: character
category: character
monitoring_partner_id: integer
lat: numeric
lng: numeric
enterprise_registration_number: character
```

### summary

```
    store_id      store_name        franchise_name        si_do          
 Min.   :    1   Length:78878       Length:78878       Length:78878      
 1st Qu.:30331   Class :character   Class :character   Class :character  
 Median :50050   Mode  :character   Mode  :character   Mode  :character  
 Mean   :49368                                                           
 3rd Qu.:69770                                                           
 Max.   :90162                                                           
                                                                         
  si_gun_gu         eup_myeon_dong       category         monitoring_partner_id
 Length:78878       Length:78878       Length:78878       Min.   :   1.0       
 Class :character   Class :character   Class :character   1st Qu.: 410.0       
 Mode  :character   Mode  :character   Mode  :character   Median : 660.0       
                                                          Mean   : 663.6       
                                                          3rd Qu.: 945.0       
                                                          Max.   :1298.0       
                                                          NA's   :193          
      lat             lng        enterprise_registration_number
 Min.   : 0.00   Min.   :  0.0   Length:78878                  
 1st Qu.:35.83   1st Qu.:126.9   Class :character              
 Median :37.33   Median :127.1   Mode  :character              
 Mean   :36.71   Mean   :127.5                                 
 3rd Qu.:37.53   3rd Qu.:128.4                                 
 Max.   :38.28   Max.   :131.9                                 
 NA's   :230     NA's   :230                                   
```


## `matched_data1`

- class: `data.frame`
- dim: 336 rows x 38 cols
- columns: `rider_id`, `avg_assign`, `avg_pickup`, `avg_deliver`, `avg_waiting`, `avg_ODdist`, `daily_delivered_stores`, `num_working_days`, `tenure`, `avg_order_level`, `avg_assign_shift`, `avg_pickup_shift`, `avg_deliver_shift`, `avg_waiting_shift`, `avg_orders_shift`, `avg_duration_shift`, `avg_idle_shift`, `avg_duration_orders`, `daily_total_shift`, `daily_singleorder`, `daily_share_singleorder`, `daily_working_duration`, `daily_idle_duration`, `daily_total_labor`, `daily_total_order`, `daily_share_idled`, `daily_orders_per_hour`, `daily_profit`, `Treat`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `distance`, `weights`, `subclass`

### sample (first 5 rows)

```
   rider_id avg_assign avg_pickup avg_deliver avg_waiting avg_ODdist
1      7643  3.1713306   3.491632    7.625103    14.28807   1.546180
3      8843  0.7706573   4.403286    7.072066    12.24601   1.332703
6      9684  2.2951389   5.839062    9.284201    17.41840   1.660222
7      9782  0.6416667   5.536553    7.982955    14.16117   1.246699
10    11332  0.8970615   2.670592    7.134963    10.70262   1.211917
   daily_delivered_stores num_working_days tenure avg_order_level
1                7.538462              6.0   1151        3118.467
3                2.375000              5.5   1097        3606.109
6                7.238095              5.0   1061        2797.723
7               10.142857              3.0   1058        4134.229
10              19.125000              5.5    991        3767.689
   avg_assign_shift avg_pickup_shift avg_deliver_shift avg_waiting_shift
1         3.2086001         3.377795          7.065637          13.65203
3         0.7599917         4.332421          6.883624          11.97604
6         2.5121543         5.671445          9.036445          17.22004
7         0.7649621         5.017241          7.351458          13.13366
10        0.8244578         2.613707          6.660142          10.09831
   avg_orders_shift avg_duration_shift avg_idle_shift avg_duration_orders
1          1.372881           11.91299      10.899708            9.031731
3          1.059701           11.62015      19.075000           10.985987
6          2.042553           22.21613      10.289766           12.011297
7          2.000000           18.39470       8.737037            9.587134
10         1.396154           10.98096      10.114993            8.074463
   daily_total_shift daily_singleorder daily_share_singleorder
1           6.807692          4.846154               0.5767082
3           2.791667          2.666667               0.9409722
6           4.476190          2.095238               0.2972222
7           6.285714          3.142857               0.4661882
10         21.666667         14.625000               0.5017981
   daily_working_duration daily_idle_duration daily_total_labor
1               1.3516667           0.7965171         2.1481838
3               0.5406597           0.3179167         0.8585764
6               1.6573942           0.4654894         2.1228836
7               1.9270635           0.7488889         2.6759524
10              3.9653472           3.2873727         7.2527199
   daily_total_order daily_share_idled daily_orders_per_hour daily_profit Treat
1           9.346154         0.3040905              4.729133     28453.85     0
3           2.958333         0.2222164              4.445677      9068.75     0
6           9.142857         0.1959328              4.463127     30476.19     1
7          12.571429         0.1794448              5.343910     37485.71     0
10         30.250000         0.4493972              4.194815     91687.50     1
       prof prof_low50 prof_high50 prof_low prof_med prof_high  distance
1  4.729133          0           1        0        1         0 0.4400470
3  4.445677          1           0        0        1         0 0.5395633
6  4.463127          1           0        0        1         0 0.5031850
7  5.343910          0           1        0        0         1 0.3807657
10 4.194815          1           0        1        0         0 0.4334585
   weights subclass
1        1       39
3        1      133
6        1      161
7        1      152
10       1        1
```

### column types

```
rider_id: integer
avg_assign: numeric
avg_pickup: numeric
avg_deliver: numeric
avg_waiting: numeric
avg_ODdist: numeric
daily_delivered_stores: numeric
num_working_days: numeric
tenure: numeric
avg_order_level: numeric
avg_assign_shift: numeric
avg_pickup_shift: numeric
avg_deliver_shift: numeric
avg_waiting_shift: numeric
avg_orders_shift: numeric
avg_duration_shift: numeric
avg_idle_shift: numeric
avg_duration_orders: numeric
daily_total_shift: numeric
daily_singleorder: numeric
daily_share_singleorder: numeric
daily_working_duration: numeric
daily_idle_duration: numeric
daily_total_labor: numeric
daily_total_order: numeric
daily_share_idled: numeric
daily_orders_per_hour: numeric
daily_profit: numeric
Treat: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
distance: numeric
weights: numeric
subclass: factor
```

### summary

```
    rider_id       avg_assign       avg_pickup      avg_deliver    
 Min.   : 7643   Min.   : 0.111   Min.   : 2.397   Min.   : 4.093  
 1st Qu.:30330   1st Qu.: 0.669   1st Qu.: 5.644   1st Qu.: 7.740  
 Median :43574   Median : 1.075   Median : 7.481   Median : 8.700  
 Mean   :39912   Mean   : 1.508   Mean   : 7.963   Mean   : 8.894  
 3rd Qu.:51437   3rd Qu.: 1.793   3rd Qu.:10.499   3rd Qu.:10.058  
 Max.   :56805   Max.   :12.609   Max.   :19.168   Max.   :14.177  
                                                                   
  avg_waiting       avg_ODdist     daily_delivered_stores num_working_days
 Min.   : 8.397   Min.   :0.7195   Min.   : 1.000         Min.   :1.000   
 1st Qu.:14.484   1st Qu.:1.0026   1st Qu.: 7.663         1st Qu.:4.000   
 Median :17.803   Median :1.1329   Median :12.619         Median :5.250   
 Mean   :18.366   Mean   :1.1629   Mean   :14.107         Mean   :4.882   
 3rd Qu.:21.953   3rd Qu.:1.2823   3rd Qu.:19.525         3rd Qu.:6.000   
 Max.   :31.903   Max.   :2.4617   Max.   :38.440         Max.   :7.000   
                                                                          
     tenure       avg_order_level avg_assign_shift   avg_pickup_shift
 Min.   :  30.0   Min.   :1841    Min.   : 0.09664   Min.   : 2.363  
 1st Qu.: 109.8   1st Qu.:3612    1st Qu.: 0.58096   1st Qu.: 5.218  
 Median : 250.0   Median :4085    Median : 0.97234   Median : 6.876  
 Mean   : 333.7   Mean   :4119    Mean   : 1.44014   Mean   : 7.430  
 3rd Qu.: 503.8   3rd Qu.:4573    3rd Qu.: 1.68251   3rd Qu.: 9.858  
 Max.   :1151.0   Max.   :6017    Max.   :12.52608   Max.   :19.318  
                                                                     
 avg_deliver_shift avg_waiting_shift avg_orders_shift avg_duration_shift
 Min.   : 3.975    Min.   : 8.26     Min.   : 1.000   Min.   :  8.44    
 1st Qu.: 7.075    1st Qu.:13.06     1st Qu.: 1.730   1st Qu.: 17.89    
 Median : 7.853    Median :16.19     Median : 2.400   Median : 25.86    
 Mean   : 8.075    Mean   :16.95     Mean   : 2.833   Mean   : 28.97    
 3rd Qu.: 8.982    3rd Qu.:20.33     3rd Qu.: 3.529   3rd Qu.: 35.33    
 Max.   :13.182    Max.   :30.96     Max.   :14.124   Max.   :109.34    
                                                                        
 avg_idle_shift   avg_duration_orders daily_total_shift daily_singleorder
 Min.   : 2.186   Min.   : 7.226      Min.   : 1.250    Min.   : 0.250   
 1st Qu.: 6.588   1st Qu.: 9.266      1st Qu.: 5.771    1st Qu.: 2.042   
 Median : 8.754   Median :11.172      Median : 8.552    Median : 3.453   
 Mean   : 9.625   Mean   :11.416      Mean   :10.238    Mean   : 4.862   
 3rd Qu.:11.312   3rd Qu.:12.862      3rd Qu.:13.128    3rd Qu.: 6.216   
 Max.   :28.275   Max.   :24.744      Max.   :37.000    Max.   :29.000   
                                                                         
 daily_share_singleorder daily_working_duration daily_idle_duration
 Min.   :0.00824         Min.   : 0.3148        Min.   :0.009333   
 1st Qu.:0.10004         1st Qu.: 2.7332        1st Qu.:0.596309   
 Median :0.21567         Median : 4.0094        Median :1.011937   
 Mean   :0.28027         Mean   : 4.3150        Mean   :1.223048   
 3rd Qu.:0.38796         3rd Qu.: 5.8616        3rd Qu.:1.670208   
 Max.   :1.00000         Max.   :10.5574        Max.   :4.409496   
                                                                   
 daily_total_labor daily_total_order daily_share_idled daily_orders_per_hour
 Min.   : 0.3241   Min.   : 1.60     Min.   :0.01456   Min.   :1.934        
 1st Qu.: 3.4699   1st Qu.:14.56     1st Qu.:0.12864   1st Qu.:3.995        
 Median : 5.5024   Median :23.45     Median :0.18241   Median :4.623        
 Mean   : 5.5380   Mean   :26.36     Mean   :0.20316   Mean   :4.686        
 3rd Qu.: 7.6613   3rd Qu.:36.87     3rd Qu.:0.26733   3rd Qu.:5.363        
 Max.   :11.6518   Max.   :88.04     Max.   :0.51984   Max.   :7.870        
                                                                            
  daily_profit        Treat          prof         prof_low50    
 Min.   :  4910   Min.   :0.0   Min.   :1.934   Min.   :0.0000  
 1st Qu.: 44376   1st Qu.:0.0   1st Qu.:3.995   1st Qu.:0.0000  
 Median : 71905   Median :0.5   Median :4.623   Median :0.0000  
 Mean   : 79220   Mean   :0.5   Mean   :4.686   Mean   :0.4821  
 3rd Qu.:110706   3rd Qu.:1.0   3rd Qu.:5.363   3rd Qu.:1.0000  
 Max.   :258213   Max.   :1.0   Max.   :7.870   Max.   :1.0000  
                                                                
  prof_high50        prof_low         prof_med        prof_high     
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :1.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.5179   Mean   :0.3274   Mean   :0.3363   Mean   :0.3363  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
    distance         weights     subclass  
 Min.   :0.2966   Min.   :1   1      :  2  
 1st Qu.:0.5019   1st Qu.:1   2      :  2  
 Median :0.5962   Median :1   3      :  2  
 Mean   :0.6159   Mean   :1   4      :  2  
 3rd Qu.:0.7120   3rd Qu.:1   5      :  2  
 Max.   :0.9376   Max.   :1   6      :  2  
                              (Other):324  
```


## `data_day`

- class: `data.frame`
- dim: 26280 rows x 52 cols
- columns: `rider_id`, `Treat`, `management_partner_id`, `date`, `After`, `station_date`, `rider_date`, `total_shift`, `mean_orders_shift`, `mean_duration_shift`, `share_aggshift`, `share_singleshift`, `orders_stacked`, `orders_one`, `num_singleshift`, `num_stackedshift`, `mean_orders_aggshift`, `mean_duration_aggshift`, `total_fee`, `working_duration`, `idle_duration`, `total_labor`, `total_orders`, `total_aiorders`, `ai_assist_day`, `share_workingd`, `share_idled`, `orders_per_hour`, `avg_waiting`, `sd_waiting`, `var_waiting`, `share_failedorders`, `wb5`, `wb4`, `wb3`, `wb2`, `wb1`, `w1`, `w2`, `w3`, `w4`, `w5`, `wday`, `riderDOW`, `share_aiorders`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `share_aiorder`

### sample (first 5 rows)

```
  rider_id Treat management_partner_id       date After   station_date
1     7643     0                   258 2020-09-26     0 258_2020-09-26
2     7643     0                   258 2020-09-27     0 258_2020-09-27
3     7643     0                   258 2020-09-28     0 258_2020-09-28
4     7643     0                   258 2020-09-29     0 258_2020-09-29
5     7643     0                   258 2020-09-30     0 258_2020-09-30
       rider_date total_shift mean_orders_shift mean_duration_shift
1 7643_2020-09-26           8          1.625000            14.10000
2 7643_2020-09-27          13          1.384615            11.38077
3 7643_2020-09-28           6          1.666667            13.36944
4 7643_2020-09-29           5          1.000000            10.18333
5 7643_2020-09-30           1          3.000000            22.15000
  share_aggshift share_singleshift orders_stacked orders_one num_singleshift
1      0.2500000         0.7500000              7          6               6
2      0.3076923         0.6923077              9          9               9
3      0.5000000         0.5000000              7          3               3
4      0.0000000         1.0000000              0          5               5
5      1.0000000         0.0000000              3          0               0
  num_stackedshift mean_orders_aggshift mean_duration_aggshift total_fee
1                2             3.500000               27.83333     39000
2                4             2.250000               16.56667     54800
3                3             2.333333               19.00556     30000
4                0                  NaN                    NaN     14900
5                1             3.000000               22.15000     10200
  working_duration idle_duration total_labor total_orders total_aiorders
1        1.8800000     0.4069444   2.2869444           13              0
2        2.4658333     0.8216667   3.2875000           18              0
3        1.3369444     0.3250000   1.6619444           10              0
4        0.8486111     1.1766667   2.0252778            5              0
5        0.3691667     0.0000000   0.3691667            3              0
  ai_assist_day share_workingd share_idled orders_per_hour avg_waiting
1             0      0.8220576   0.1779424        5.684441    15.63846
2             0      0.7500634   0.2499366        5.475285    13.64074
3             0      0.8044459   0.1955541        6.017048    15.45667
4             0      0.4190097   0.5809903        2.468797    14.13000
5             0      1.0000000   0.0000000        8.126411    25.08333
  sd_waiting var_waiting share_failedorders wb5 wb4 wb3 wb2 wb1 w1 w2 w3 w4 w5
1   4.465430   19.940064                  0   1   0   0   0   0  0  0  0  0  0
2   4.458106   19.874713                  0   1   0   0   0   0  0  0  0  0  0
3   4.570519   20.889642                  0   0   1   0   0   0  0  0  0  0  0
4   5.832493   34.017972                  0   0   1   0   0   0  0  0  0  0  0
5   2.622393    6.876944                  0   0   1   0   0   0  0  0  0  0  0
  wday riderDOW share_aiorders     prof prof_low50 prof_high50 prof_low
1    7   7643_7             NA 4.729133          0           1        0
2    1   7643_1             NA 4.729133          0           1        0
3    2   7643_2             NA 4.729133          0           1        0
4    3   7643_3             NA 4.729133          0           1        0
5    4   7643_4             NA 4.729133          0           1        0
  prof_med prof_high share_aiorder
1        1         0            NA
2        1         0            NA
3        1         0            NA
4        1         0            NA
5        1         0            NA
```

### column types

```
rider_id: integer
Treat: numeric
management_partner_id: integer
date: Date
After: numeric
station_date: character
rider_date: character
total_shift: integer
mean_orders_shift: numeric
mean_duration_shift: numeric
share_aggshift: numeric
share_singleshift: numeric
orders_stacked: integer
orders_one: integer
num_singleshift: integer
num_stackedshift: integer
mean_orders_aggshift: numeric
mean_duration_aggshift: numeric
total_fee: numeric
working_duration: numeric
idle_duration: numeric
total_labor: numeric
total_orders: integer
total_aiorders: integer
ai_assist_day: numeric
share_workingd: numeric
share_idled: numeric
orders_per_hour: numeric
avg_waiting: numeric
sd_waiting: numeric
var_waiting: numeric
share_failedorders: numeric
wb5: numeric
wb4: numeric
wb3: numeric
wb2: numeric
wb1: numeric
w1: numeric
w2: numeric
w3: numeric
w4: numeric
w5: numeric
wday: numeric
riderDOW: character
share_aiorders: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
share_aiorder: numeric
```

### summary

```
    rider_id         Treat        management_partner_id      date           
 Min.   : 7643   Min.   :0.0000   Min.   : 258.0        Min.   :2020-09-26  
 1st Qu.:30022   1st Qu.:0.0000   1st Qu.: 296.0        1st Qu.:2020-10-11  
 Median :43381   Median :1.0000   Median : 466.0        Median :2020-10-27  
 Mean   :39944   Mean   :0.7175   Mean   : 600.4        Mean   :2020-10-27  
 3rd Qu.:51455   3rd Qu.:1.0000   3rd Qu.: 885.0        3rd Qu.:2020-11-13  
 Max.   :56805   Max.   :1.0000   Max.   :1244.0        Max.   :2020-11-30  
                                                                            
     After        station_date        rider_date         total_shift  
 Min.   :0.0000   Length:26280       Length:26280       Min.   : 1.0  
 1st Qu.:0.0000   Class :character   Class :character   1st Qu.: 6.0  
 Median :1.0000   Mode  :character   Mode  :character   Median :10.0  
 Mean   :0.5243                                         Mean   :10.8  
 3rd Qu.:1.0000                                         3rd Qu.:15.0  
 Max.   :1.0000                                         Max.   :44.0  
                                                                      
 mean_orders_shift mean_duration_shift share_aggshift   share_singleshift
 Min.   : 1.000    Min.   :  3.233     Min.   :0.0000   Min.   :0.0000   
 1st Qu.: 1.667    1st Qu.: 18.734     1st Qu.:0.4060   1st Qu.:0.2143   
 Median : 2.533    Median : 28.974     Median :0.6000   Median :0.4000   
 Mean   : 3.497    Mean   : 36.311     Mean   :0.5899   Mean   :0.4101   
 3rd Qu.: 4.083    3rd Qu.: 43.632     3rd Qu.:0.7857   3rd Qu.:0.5940   
 Max.   :82.000    Max.   :633.350     Max.   :1.0000   Max.   :1.0000   
                                                                         
 orders_stacked     orders_one     num_singleshift  num_stackedshift
 Min.   :  0.00   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
 1st Qu.: 11.00   1st Qu.: 1.000   1st Qu.: 1.000   1st Qu.: 3.000  
 Median : 22.00   Median : 3.000   Median : 3.000   Median : 6.000  
 Mean   : 26.14   Mean   : 4.881   Mean   : 4.881   Mean   : 5.922  
 3rd Qu.: 38.00   3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.: 8.000  
 Max.   :125.00   Max.   :37.000   Max.   :37.000   Max.   :26.000  
                                                                    
 mean_orders_aggshift mean_duration_aggshift   total_fee     
 Min.   : 2.000       Min.   :  8.833        Min.   :  2100  
 1st Qu.: 2.632       1st Qu.: 27.760        1st Qu.: 47900  
 Median : 3.667       Median : 39.495        Median : 87300  
 Mean   : 4.668       Mean   : 47.148        Mean   : 92781  
 3rd Qu.: 5.385       3rd Qu.: 56.189        3rd Qu.:128250  
 Max.   :82.000       Max.   :633.350        Max.   :440400  
 NA's   :1163         NA's   :1163                           
 working_duration   idle_duration     total_labor        total_orders   
 Min.   : 0.05389   Min.   :0.0000   Min.   : 0.05389   Min.   :  1.00  
 1st Qu.: 2.95042   1st Qu.:0.4494   1st Qu.: 3.86167   1st Qu.: 16.00  
 Median : 5.23083   Median :1.0725   Median : 6.93139   Median : 29.00  
 Mean   : 5.32876   Mean   :1.3246   Mean   : 6.65337   Mean   : 31.02  
 3rd Qu.: 7.59563   3rd Qu.:1.9439   3rd Qu.: 9.39174   3rd Qu.: 43.00  
 Max.   :15.10500   Max.   :7.0431   Max.   :17.78806   Max.   :126.00  
                                                                        
 total_aiorders   ai_assist_day     share_workingd    share_idled     
 Min.   : 0.000   Min.   :0.00000   Min.   :0.2244   Min.   :0.00000  
 1st Qu.: 0.000   1st Qu.:0.00000   1st Qu.:0.7169   1st Qu.:0.08635  
 Median : 0.000   Median :0.00000   Median :0.8278   Median :0.17219  
 Mean   : 1.041   Mean   :0.08729   Mean   :0.8047   Mean   :0.19534  
 3rd Qu.: 0.000   3rd Qu.:0.00000   3rd Qu.:0.9136   3rd Qu.:0.28313  
 Max.   :58.000   Max.   :1.00000   Max.   :1.0000   Max.   :0.77564  
                                                                      
 orders_per_hour   avg_waiting      sd_waiting        var_waiting       
 Min.   : 1.205   Min.   : 5.05   Min.   : 0.04714   Min.   :  0.00222  
 1st Qu.: 3.657   1st Qu.:15.21   1st Qu.: 5.22038   1st Qu.: 27.25239  
 Median : 4.471   Median :19.06   Median : 6.59853   Median : 43.54065  
 Mean   : 4.623   Mean   :19.18   Mean   : 6.75203   Mean   : 50.91647  
 3rd Qu.: 5.411   3rd Qu.:22.85   3rd Qu.: 8.04277   3rd Qu.: 64.68621  
 Max.   :18.557   Max.   :56.14   Max.   :30.57911   Max.   :935.08219  
                                  NA's   :396        NA's   :396        
 share_failedorders      wb5               wb4             wb3        
 Min.   :0.0000     Min.   :0.00000   Min.   :0.000   Min.   :0.0000  
 1st Qu.:0.0000     1st Qu.:0.00000   1st Qu.:0.000   1st Qu.:0.0000  
 Median :0.0600     Median :0.00000   Median :0.000   Median :0.0000  
 Mean   :0.1123     Mean   :0.03368   Mean   :0.101   Mean   :0.1158  
 3rd Qu.:0.1774     3rd Qu.:0.00000   3rd Qu.:0.000   3rd Qu.:0.0000  
 Max.   :1.0000     Max.   :1.00000   Max.   :1.000   Max.   :1.0000  
                                                                      
      wb2              wb1               w1              w2        
 Min.   :0.0000   Min.   :0.0000   Min.   :0.000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.000   1st Qu.:0.0000  
 Median :0.0000   Median :0.0000   Median :0.000   Median :0.0000  
 Mean   :0.1131   Mean   :0.1121   Mean   :0.109   Mean   :0.1052  
 3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.000   3rd Qu.:0.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.000   Max.   :1.0000  
                                                                   
       w3               w4                w5              wday      
 Min.   :0.0000   Min.   :0.00000   Min.   :0.0000   Min.   :1.000  
 1st Qu.:0.0000   1st Qu.:0.00000   1st Qu.:0.0000   1st Qu.:2.000  
 Median :0.0000   Median :0.00000   Median :0.0000   Median :4.000  
 Mean   :0.1026   Mean   :0.09787   Mean   :0.1096   Mean   :3.991  
 3rd Qu.:0.0000   3rd Qu.:0.00000   3rd Qu.:0.0000   3rd Qu.:6.000  
 Max.   :1.0000   Max.   :1.00000   Max.   :1.0000   Max.   :7.000  
                                                                    
   riderDOW         share_aiorders        prof         prof_low50    
 Length:26280       Min.   :0.0000   Min.   :1.934   Min.   :0.0000  
 Class :character   1st Qu.:0.0000   1st Qu.:3.957   1st Qu.:0.0000  
 Mode  :character   Median :0.0000   Median :4.541   Median :1.0000  
                    Mean   :0.0502   Mean   :4.647   Mean   :0.5147  
                    3rd Qu.:0.0000   3rd Qu.:5.225   3rd Qu.:1.0000  
                    Max.   :1.0000   Max.   :8.555   Max.   :1.0000  
                    NA's   :7423                                     
  prof_high50        prof_low         prof_med        prof_high     
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.4853   Mean   :0.3387   Mean   :0.3399   Mean   :0.3215  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
 share_aiorder   
 Min.   :0.0003  
 1st Qu.:0.0029  
 Median :0.0085  
 Mean   :0.0483  
 3rd Qu.:0.0268  
 Max.   :0.7551  
 NA's   :7423    
```


## `%!in%`

- class: `function`

## `rider`

- class: `data.frame`
- dim: 3779 rows x 6 cols
- columns: `rider_id`, `created_at`, `management_partner_id`, `management_partner_name`, `first_order`, `last_order`

### sample (first 5 rows)

```
  rider_id       created_at management_partner_id       management_partner_name
1    11827  2018-03-08 0:13                   296                  부산장전지점
2    18632 2018-10-12 11:44                   362 해지_부산남구대연지점(김현욱)
3    21618 2018-12-19 14:37                   534     해지_부산좌동지점(박우실)
4    12891  2018-04-24 9:44                   258                  부산정관지점
5    20401 2018-11-20 10:31                   295         해지_부산진구서면지점
  first_order last_order
1  2018-12-31 2019-02-10
2  2018-12-31 2019-02-11
3  2018-12-31 2019-01-15
4  2018-12-31 2020-11-30
5  2018-12-31 2019-02-21
```

### column types

```
rider_id: integer
created_at: factor
management_partner_id: integer
management_partner_name: factor
first_order: Date
last_order: Date
```

### summary

```
    rider_id                created_at   management_partner_id
 Min.   : 4080   2018-04-24 18:16:   5   Min.   : 258.0       
 1st Qu.:25992   2019-07-12 15:37:   5   1st Qu.: 362.0       
 Median :36094   2017-12-29 16:48:   4   Median : 466.0       
 Mean   :36675   2018-10-17 3:11 :   4   Mean   : 565.5       
 3rd Qu.:47274   2018-11-27 18:05:   4   3rd Qu.: 791.0       
 Max.   :60420   2018-12-06 17:39:   4   Max.   :1248.0       
                 (Other)         :3753                        
              management_partner_name  first_order           last_order        
 부산장전지점             : 268       Min.   :2018-12-31   Min.   :2018-12-31  
 부산다대지점             : 155       1st Qu.:2019-05-17   1st Qu.:2019-10-12  
 (운영중지)_부산하단지점  : 147       Median :2019-12-02   Median :2020-04-29  
 부산대연지점             : 131       Mean   :2019-11-23   Mean   :2020-03-29  
 해지_부산광안지점(박근우): 126       3rd Qu.:2020-05-28   3rd Qu.:2020-11-01  
 부산정관지점             : 125       Max.   :2020-11-30   Max.   :2020-11-30  
 (Other)                  :2827                                                
```


## `pre_var`

- class: `tbl_df, tbl, data.frame`
- dim: 584 rows x 35 cols
- columns: `rider_id`, `avg_assign`, `avg_pickup`, `avg_deliver`, `avg_waiting`, `avg_ODdist`, `daily_delivered_stores`, `num_working_days`, `tenure`, `avg_order_level`, `avg_assign_shift`, `avg_pickup_shift`, `avg_deliver_shift`, `avg_waiting_shift`, `avg_orders_shift`, `avg_duration_shift`, `avg_idle_shift`, `avg_duration_orders`, `daily_total_shift`, `daily_singleorder`, `daily_share_singleorder`, `daily_working_duration`, `daily_idle_duration`, `daily_total_labor`, `daily_total_order`, `daily_share_idled`, `daily_orders_per_hour`, `daily_profit`, `Treat`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`

### sample (first 5 rows)

```
  rider_id avg_assign avg_pickup avg_deliver avg_waiting avg_ODdist
1     7643  3.1713306   3.491632    7.625103    14.28807  1.5461803
2     7803  2.0533718   3.822589    8.955346    14.83131  1.4835493
3     8843  0.7706573   4.403286    7.072066    12.24601  1.3327031
4     9524  0.7583893  10.297483    8.951230    20.00710  0.9895915
5     9535  0.6870528   6.251278    8.832226    15.77056  1.1715759
  daily_delivered_stores num_working_days tenure avg_order_level
1               7.538462             6.00   1151        3118.467
2              22.000000             6.25   1145        3039.079
3               2.375000             5.50   1097        3606.109
4               7.480000             6.00   1068        4563.784
5              21.238095             5.25   1067        3667.947
  avg_assign_shift avg_pickup_shift avg_deliver_shift avg_waiting_shift
1        3.2086001         3.377795          7.065637          13.65203
2        1.9233279         3.840485          8.357255          14.12107
3        0.7599917         4.332421          6.883624          11.97604
4        0.9517817         9.097182          7.950314          17.99928
5        0.5843549         5.748628          8.198925          14.53191
  avg_orders_shift avg_duration_shift avg_idle_shift avg_duration_orders
1         1.372881           11.91299      10.899708            9.031731
2         1.803403           16.56418       9.877991            9.858020
3         1.059701           11.62015      19.075000           10.985987
4         3.170213           32.05869       8.643030           10.965673
5         2.835749           29.10942       4.100901           11.027064
  daily_total_shift daily_singleorder daily_share_singleorder
1          6.807692          4.846154               0.5767082
2         19.592593          9.703704               0.2901357
3          2.791667          2.666667               0.9409722
4          3.760000          1.000000               0.1449254
5          9.857143          3.952381               0.2161466
  daily_working_duration daily_idle_duration daily_total_labor
1              1.3516667           0.7965171         2.1481838
2              5.4089198           2.8536420         8.2625617
3              0.5406597           0.3179167         0.8585764
4              2.0090111           0.3169111         2.3259222
5              4.7822619           0.6021164         5.3843783
  daily_total_order daily_share_idled daily_orders_per_hour daily_profit Treat
1          9.346154         0.3040905              4.729133     28453.85     0
2         35.333333         0.3327241              4.402632    108103.70     1
3          2.958333         0.2222164              4.445677      9068.75     0
4         11.920000         0.1269951              5.023493     35048.00     1
5         27.952381         0.1058622              5.099385     80756.19     1
      prof prof_low50 prof_high50 prof_low prof_med prof_high
1 4.729133          0           1        0        1         0
2 4.402632          1           0        0        1         0
3 4.445677          1           0        0        1         0
4 5.023493          0           1        0        0         1
5 5.099385          0           1        0        0         1
```

### column types

```
rider_id: integer
avg_assign: numeric
avg_pickup: numeric
avg_deliver: numeric
avg_waiting: numeric
avg_ODdist: numeric
daily_delivered_stores: numeric
num_working_days: numeric
tenure: numeric
avg_order_level: numeric
avg_assign_shift: numeric
avg_pickup_shift: numeric
avg_deliver_shift: numeric
avg_waiting_shift: numeric
avg_orders_shift: numeric
avg_duration_shift: numeric
avg_idle_shift: numeric
avg_duration_orders: numeric
daily_total_shift: numeric
daily_singleorder: numeric
daily_share_singleorder: numeric
daily_working_duration: numeric
daily_idle_duration: numeric
daily_total_labor: numeric
daily_total_order: numeric
daily_share_idled: numeric
daily_orders_per_hour: numeric
daily_profit: numeric
Treat: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
```

### summary

```
    rider_id       avg_assign        avg_pickup      avg_deliver    
 Min.   : 7643   Min.   : 0.0451   Min.   : 2.186   Min.   : 4.093  
 1st Qu.:29984   1st Qu.: 0.7304   1st Qu.: 6.383   1st Qu.: 7.881  
 Median :43461   Median : 1.1537   Median : 9.195   Median : 9.030  
 Mean   :39998   Mean   : 1.5064   Mean   : 8.859   Mean   : 9.170  
 3rd Qu.:51462   3rd Qu.: 1.8813   3rd Qu.:11.409   3rd Qu.:10.340  
 Max.   :56805   Max.   :12.6090   Max.   :19.168   Max.   :15.167  
                                                                    
  avg_waiting       avg_ODdist     daily_delivered_stores num_working_days
 Min.   : 8.397   Min.   :0.7021   Min.   : 1.000         Min.   :1.000   
 1st Qu.:15.893   1st Qu.:0.9896   1st Qu.: 9.586         1st Qu.:4.500   
 Median :19.783   Median :1.1167   Median :13.939         Median :5.500   
 Mean   :19.535   Mean   :1.1370   Mean   :14.894         Mean   :5.143   
 3rd Qu.:23.294   3rd Qu.:1.2449   3rd Qu.:19.661         3rd Qu.:6.250   
 Max.   :32.190   Max.   :2.4617   Max.   :46.846         Max.   :7.000   
                                                          NA's   :1       
     tenure       avg_order_level avg_assign_shift   avg_pickup_shift
 Min.   :  30.0   Min.   :1841    Min.   : 0.04615   Min.   : 2.153  
 1st Qu.: 109.8   1st Qu.:3666    1st Qu.: 0.64553   1st Qu.: 5.906  
 Median : 251.5   Median :4108    Median : 1.02157   Median : 8.533  
 Mean   : 331.9   Mean   :4158    Mean   : 1.41009   Mean   : 8.236  
 3rd Qu.: 509.8   3rd Qu.:4598    3rd Qu.: 1.64097   3rd Qu.:10.545  
 Max.   :1151.0   Max.   :6143    Max.   :12.52608   Max.   :19.318  
                                                                     
 avg_deliver_shift avg_waiting_shift avg_orders_shift avg_duration_shift
 Min.   : 3.975    Min.   : 8.26     Min.   : 1.000   Min.   :  8.44    
 1st Qu.: 7.168    1st Qu.:14.28     1st Qu.: 1.883   1st Qu.: 21.63    
 Median : 8.178    Median :18.02     Median : 2.839   Median : 31.40    
 Mean   : 8.323    Mean   :17.97     Mean   : 3.335   Mean   : 35.01    
 3rd Qu.: 9.361    3rd Qu.:21.32     3rd Qu.: 4.128   3rd Qu.: 43.70    
 Max.   :14.014    Max.   :30.96     Max.   :18.690   Max.   :183.00    
                                                                        
 avg_idle_shift   avg_duration_orders daily_total_shift daily_singleorder
 Min.   : 2.186   Min.   : 7.130      Min.   : 1.000    Min.   : 0.000   
 1st Qu.: 6.654   1st Qu.: 9.853      1st Qu.: 6.136    1st Qu.: 1.913   
 Median : 8.747   Median :11.677      Median : 9.151    Median : 3.214   
 Mean   : 9.307   Mean   :11.826      Mean   :10.162    Mean   : 4.445   
 3rd Qu.:10.914   3rd Qu.:13.359      3rd Qu.:12.801    3rd Qu.: 5.679   
 Max.   :28.275   Max.   :24.744      Max.   :37.000    Max.   :29.000   
 NA's   :1                                                               
 daily_share_singleorder daily_working_duration daily_idle_duration
 Min.   :0.00000         Min.   : 0.3148        Min.   :0.0000     
 1st Qu.:0.07737         1st Qu.: 3.3352        1st Qu.:0.6198     
 Median :0.16042         Median : 5.1166        Median :1.0417     
 Mean   :0.22874         Mean   : 5.1505        Mean   :1.2188     
 3rd Qu.:0.31728         3rd Qu.: 6.8816        3rd Qu.:1.6558     
 Max.   :1.00000         Max.   :11.0819        Max.   :4.4095     
                                                                   
 daily_total_labor daily_total_order daily_share_idled daily_orders_per_hour
 Min.   : 0.3241   Min.   : 1.60     Min.   :0.0000    Min.   :1.934        
 1st Qu.: 4.3549   1st Qu.:18.13     1st Qu.:0.1095    1st Qu.:3.981        
 Median : 6.4894   Median :28.45     Median :0.1661    Median :4.556        
 Mean   : 6.3693   Mean   :29.89     Mean   :0.1845    Mean   :4.669        
 3rd Qu.: 8.3957   3rd Qu.:39.94     3rd Qu.:0.2427    3rd Qu.:5.296        
 Max.   :13.9611   Max.   :88.04     Max.   :0.5198    Max.   :8.555        
                                                                            
  daily_profit        Treat             prof         prof_low50   prof_high50 
 Min.   :  4910   Min.   :0.0000   Min.   :1.934   Min.   :0.0   Min.   :0.0  
 1st Qu.: 55833   1st Qu.:0.0000   1st Qu.:3.981   1st Qu.:0.0   1st Qu.:0.0  
 Median : 85933   Median :1.0000   Median :4.556   Median :0.5   Median :0.5  
 Mean   : 90018   Mean   :0.6849   Mean   :4.669   Mean   :0.5   Mean   :0.5  
 3rd Qu.:119084   3rd Qu.:1.0000   3rd Qu.:5.296   3rd Qu.:1.0   3rd Qu.:1.0  
 Max.   :258213   Max.   :1.0000   Max.   :8.555   Max.   :1.0   Max.   :1.0  
                                                                              
    prof_low         prof_med        prof_high     
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.3339   Mean   :0.3322   Mean   :0.3339  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                   
```


## `func_check`

- class: `function`

## `treat_riders`

- class: `tbl_df, tbl, data.frame`
- dim: 400 rows x 5 cols
- columns: `rider_id`, `total_orders`, `ai_completed_orders`, `adopt_date`, `share_aiorder`

### sample (first 5 rows)

```
  rider_id total_orders ai_completed_orders adopt_date share_aiorder
1     7803         1825                   6 2020-10-28  0.0032876712
2     9524          661                   2 2020-10-29  0.0030257186
3     9535          943                   1 2020-11-09  0.0010604454
4     9684          718                   1 2020-10-29  0.0013927577
5    10359         2762                   1 2020-11-01  0.0003620565
```

### column types

```
rider_id: integer
total_orders: integer
ai_completed_orders: numeric
adopt_date: Date
share_aiorder: numeric
```

### summary

```
    rider_id      total_orders    ai_completed_orders   adopt_date        
 Min.   : 7803   Min.   :  34.0   Min.   :  1.00      Min.   :2020-10-26  
 1st Qu.:33028   1st Qu.: 801.5   1st Qu.:  3.00      1st Qu.:2020-10-26  
 Median :44040   Median :1448.5   Median : 13.00      Median :2020-10-27  
 Mean   :40636   Mean   :1503.4   Mean   : 68.42      Mean   :2020-10-30  
 3rd Qu.:51451   3rd Qu.:2101.8   3rd Qu.: 30.00      3rd Qu.:2020-10-30  
 Max.   :56797   Max.   :4287.0   Max.   :942.00      Max.   :2020-11-30  
 share_aiorder      
 Min.   :0.0002849  
 1st Qu.:0.0030783  
 Median :0.0092236  
 Mean   :0.0551402  
 3rd Qu.:0.0348130  
 Max.   :0.7551020  
```


## `proficiency`

- class: `tbl_df, tbl, data.frame`
- dim: 584 rows x 7 cols
- columns: `rider_id`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`

### sample (first 5 rows)

```
  rider_id     prof prof_low50 prof_high50 prof_low prof_med prof_high
1     7643 4.729133          0           1        0        1         0
2     7803 4.402632          1           0        0        1         0
3     8843 4.445677          1           0        0        1         0
4     9524 5.023493          0           1        0        0         1
5     9535 5.099385          0           1        0        0         1
```

### column types

```
rider_id: integer
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
```

### summary

```
    rider_id          prof         prof_low50   prof_high50     prof_low     
 Min.   : 7643   Min.   :1.934   Min.   :0.0   Min.   :0.0   Min.   :0.0000  
 1st Qu.:29984   1st Qu.:3.981   1st Qu.:0.0   1st Qu.:0.0   1st Qu.:0.0000  
 Median :43461   Median :4.556   Median :0.5   Median :0.5   Median :0.0000  
 Mean   :39998   Mean   :4.669   Mean   :0.5   Mean   :0.5   Mean   :0.3339  
 3rd Qu.:51462   3rd Qu.:5.296   3rd Qu.:1.0   3rd Qu.:1.0   3rd Qu.:1.0000  
 Max.   :56805   Max.   :8.555   Max.   :1.0   Max.   :1.0   Max.   :1.0000  
    prof_med        prof_high     
 Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000  
 Median :0.0000   Median :0.0000  
 Mean   :0.3322   Mean   :0.3339  
 3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000  
```


## `matched_treat_riders`

- class: `data.frame`
- dim: 7150 rows x 53 cols
- columns: `rider_id`, `Treat`, `management_partner_id`, `date`, `After`, `station_date`, `rider_date`, `total_shift`, `mean_orders_shift`, `mean_duration_shift`, `share_aggshift`, `share_singleshift`, `orders_stacked`, `orders_one`, `num_singleshift`, `num_stackedshift`, `mean_orders_aggshift`, `mean_duration_aggshift`, `total_fee`, `working_duration`, `idle_duration`, `total_labor`, `total_orders`, `total_aiorders`, `ai_assist_day`, `share_workingd`, `share_idled`, `orders_per_hour`, `avg_waiting`, `sd_waiting`, `var_waiting`, `share_failedorders`, `wb5`, `wb4`, `wb3`, `wb2`, `wb1`, `w1`, `w2`, `w3`, `w4`, `w5`, `wday`, `riderDOW`, `share_aiorders`, `prof`, `prof_low50`, `prof_high50`, `prof_low`, `prof_med`, `prof_high`, `share_aiorder`, `subclass`

### sample (first 5 rows)

```
  rider_id Treat management_partner_id       date After   station_date
1     9684     1                   296 2020-09-26     0 296_2020-09-26
2     9684     1                   296 2020-09-27     0 296_2020-09-27
3     9684     1                   296 2020-09-30     0 296_2020-09-30
4     9684     1                   296 2020-10-01     0 296_2020-10-01
5     9684     1                   296 2020-10-02     0 296_2020-10-02
       rider_date total_shift mean_orders_shift mean_duration_shift
1 9684_2020-09-26           3          1.333333            11.92778
2 9684_2020-09-27           3          2.666667            26.45556
3 9684_2020-09-30           2          3.000000            29.10000
4 9684_2020-10-01           6          3.833333            35.02778
5 9684_2020-10-02          13          2.461538            24.57821
  share_aggshift share_singleshift orders_stacked orders_one num_singleshift
1      0.3333333         0.6666667              2          2               2
2      0.6666667         0.3333333              7          1               1
3      1.0000000         0.0000000              6          0               0
4      1.0000000         0.0000000             23          0               0
5      0.5384615         0.4615385             26          6               6
  num_stackedshift mean_orders_aggshift mean_duration_aggshift total_fee
1                1             2.000000               12.88333     11300
2                2             3.500000               34.62500     25300
3                2             3.000000               29.10000     23200
4                6             3.833333               35.02778     83600
5                7             3.714286               33.00952    124100
  working_duration idle_duration total_labor total_orders total_aiorders
1        0.5963889     0.1836111    0.780000            4              0
2        1.3227778     0.1513889    1.474167            8              0
3        0.9700000     0.2388889    1.208889            6              0
4        3.5027778     0.2855556    3.788333           23              0
5        5.3252778     2.0261111    7.351389           32              0
  ai_assist_day share_workingd share_idled orders_per_hour avg_waiting
1             0      0.7646011  0.23539886        5.128205    14.69167
2             0      0.8973054  0.10269455        5.426795    25.32292
3             0      0.8023897  0.19761029        4.963235    17.73611
4             0      0.9246224  0.07537762        6.071271    16.87029
5             0      0.7243907  0.27560930        4.352919    16.17760
  sd_waiting var_waiting share_failedorders wb5 wb4 wb3 wb2 wb1 w1 w2 w3 w4 w5
1   7.441482    55.37565         0.00000000   1   0   0   0   0  0  0  0  0  0
2  10.408158   108.32976         0.12500000   1   0   0   0   0  0  0  0  0  0
3   5.996410    35.95694         0.00000000   0   1   0   0   0  0  0  0  0  0
4   6.493468    42.16513         0.04347826   0   1   0   0   0  0  0  0  0  0
5   6.213287    38.60494         0.03125000   0   1   0   0   0  0  0  0  0  0
  wday riderDOW share_aiorders     prof prof_low50 prof_high50 prof_low
1    7   9684_7              0 4.463127          1           0        0
2    1   9684_1              0 4.463127          1           0        0
3    4   9684_4              0 4.463127          1           0        0
4    5   9684_5              0 4.463127          1           0        0
5    6   9684_6              0 4.463127          1           0        0
  prof_med prof_high share_aiorder subclass
1        1         0   0.001392758      161
2        1         0   0.001392758      161
3        1         0   0.001392758      161
4        1         0   0.001392758      161
5        1         0   0.001392758      161
```

### column types

```
rider_id: integer
Treat: numeric
management_partner_id: integer
date: Date
After: numeric
station_date: character
rider_date: character
total_shift: integer
mean_orders_shift: numeric
mean_duration_shift: numeric
share_aggshift: numeric
share_singleshift: numeric
orders_stacked: integer
orders_one: integer
num_singleshift: integer
num_stackedshift: integer
mean_orders_aggshift: numeric
mean_duration_aggshift: numeric
total_fee: numeric
working_duration: numeric
idle_duration: numeric
total_labor: numeric
total_orders: integer
total_aiorders: integer
ai_assist_day: numeric
share_workingd: numeric
share_idled: numeric
orders_per_hour: numeric
avg_waiting: numeric
sd_waiting: numeric
var_waiting: numeric
share_failedorders: numeric
wb5: numeric
wb4: numeric
wb3: numeric
wb2: numeric
wb1: numeric
w1: numeric
w2: numeric
w3: numeric
w4: numeric
w5: numeric
wday: numeric
riderDOW: character
share_aiorders: numeric
prof: numeric
prof_low50: numeric
prof_high50: numeric
prof_low: numeric
prof_med: numeric
prof_high: numeric
share_aiorder: numeric
subclass: factor
```

### summary

```
    rider_id         Treat   management_partner_id      date           
 Min.   : 9684   Min.   :1   Min.   : 258.0        Min.   :2020-09-26  
 1st Qu.:33519   1st Qu.:1   1st Qu.: 296.0        1st Qu.:2020-10-12  
 Median :43391   Median :1   Median : 466.0        Median :2020-10-28  
 Mean   :40202   Mean   :1   Mean   : 598.5        Mean   :2020-10-27  
 3rd Qu.:49502   3rd Qu.:1   3rd Qu.: 915.0        3rd Qu.:2020-11-13  
 Max.   :56636   Max.   :1   Max.   :1244.0        Max.   :2020-11-30  
                                                                       
     After        station_date        rider_date         total_shift   
 Min.   :0.0000   Length:7150        Length:7150        Min.   : 1.00  
 1st Qu.:0.0000   Class :character   Class :character   1st Qu.: 5.00  
 Median :1.0000   Mode  :character   Mode  :character   Median : 9.00  
 Mean   :0.5315                                         Mean   :10.67  
 3rd Qu.:1.0000                                         3rd Qu.:15.00  
 Max.   :1.0000                                         Max.   :44.00  
                                                                       
 mean_orders_shift mean_duration_shift share_aggshift   share_singleshift
 Min.   : 1.000    Min.   :  3.233     Min.   :0.0000   Min.   :0.0000   
 1st Qu.: 1.500    1st Qu.: 15.545     1st Qu.:0.3333   1st Qu.:0.2500   
 Median : 2.143    Median : 24.654     Median :0.5556   Median :0.4444   
 Mean   : 3.034    Mean   : 30.513     Mean   :0.5472   Mean   :0.4528   
 3rd Qu.: 3.500    3rd Qu.: 36.925     3rd Qu.:0.7500   3rd Qu.:0.6667   
 Max.   :63.000    Max.   :410.300     Max.   :1.0000   Max.   :1.0000   
                                                                         
 orders_stacked     orders_one     num_singleshift  num_stackedshift
 Min.   :  0.00   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
 1st Qu.:  7.00   1st Qu.: 1.000   1st Qu.: 1.000   1st Qu.: 2.000  
 Median : 17.00   Median : 3.000   Median : 3.000   Median : 5.000  
 Mean   : 22.02   Mean   : 5.246   Mean   : 5.246   Mean   : 5.423  
 3rd Qu.: 32.00   3rd Qu.: 7.000   3rd Qu.: 7.000   3rd Qu.: 8.000  
 Max.   :123.00   Max.   :37.000   Max.   :37.000   Max.   :26.000  
                                                                    
 mean_orders_aggshift mean_duration_aggshift   total_fee     
 Min.   : 2.000       Min.   :  9.05         Min.   :  2100  
 1st Qu.: 2.400       1st Qu.: 23.58         1st Qu.: 36300  
 Median : 3.182       Median : 34.70         Median : 71200  
 Mean   : 4.191       Mean   : 40.61         Mean   : 81789  
 3rd Qu.: 4.750       3rd Qu.: 48.42         3rd Qu.:117200  
 Max.   :63.000       Max.   :410.30         Max.   :423400  
 NA's   :528          NA's   :528                            
 working_duration   idle_duration     total_labor        total_orders   
 Min.   : 0.05389   Min.   :0.0000   Min.   : 0.05389   Min.   :  1.00  
 1st Qu.: 2.24625   1st Qu.:0.3677   1st Qu.: 2.93917   1st Qu.: 12.00  
 Median : 4.14153   Median :1.0072   Median : 5.54833   Median : 24.00  
 Mean   : 4.45186   Mean   :1.3134   Mean   : 5.76530   Mean   : 27.27  
 3rd Qu.: 6.37667   3rd Qu.:1.9742   3rd Qu.: 8.41347   3rd Qu.: 39.00  
 Max.   :14.63139   Max.   :7.0431   Max.   :16.09611   Max.   :124.00  
                                                                        
 total_aiorders    ai_assist_day    share_workingd    share_idled     
 Min.   : 0.0000   Min.   :0.0000   Min.   :0.2856   Min.   :0.00000  
 1st Qu.: 0.0000   1st Qu.:0.0000   1st Qu.:0.6830   1st Qu.:0.08966  
 Median : 0.0000   Median :0.0000   Median :0.8095   Median :0.19054  
 Mean   : 0.9706   Mean   :0.1064   Mean   :0.7883   Mean   :0.21173  
 3rd Qu.: 0.0000   3rd Qu.:0.0000   3rd Qu.:0.9103   3rd Qu.:0.31705  
 Max.   :54.0000   Max.   :1.0000   Max.   :1.0000   Max.   :0.71441  
                                                                      
 orders_per_hour   avg_waiting      sd_waiting        var_waiting       
 Min.   : 1.219   Min.   : 5.05   Min.   : 0.04714   Min.   :  0.00222  
 1st Qu.: 3.651   1st Qu.:13.83   1st Qu.: 4.76598   1st Qu.: 22.71456  
 Median : 4.493   Median :18.01   Median : 6.27980   Median : 39.43583  
 Mean   : 4.646   Mean   :18.30   Mean   : 6.51971   Mean   : 48.60534  
 3rd Qu.: 5.485   3rd Qu.:22.13   3rd Qu.: 7.92299   3rd Qu.: 62.77379  
 Max.   :18.557   Max.   :53.73   Max.   :27.18826   Max.   :739.20125  
                                  NA's   :192        NA's   :192        
 share_failedorders      wb5               wb4               wb3        
 Min.   :0.00000    Min.   :0.00000   Min.   :0.00000   Min.   :0.0000  
 1st Qu.:0.00000    1st Qu.:0.00000   1st Qu.:0.00000   1st Qu.:0.0000  
 Median :0.03125    Median :0.00000   Median :0.00000   Median :0.0000  
 Mean   :0.09895    Mean   :0.03343   Mean   :0.09986   Mean   :0.1137  
 3rd Qu.:0.15385    3rd Qu.:0.00000   3rd Qu.:0.00000   3rd Qu.:0.0000  
 Max.   :1.00000    Max.   :1.00000   Max.   :1.00000   Max.   :1.0000  
                                                                        
      wb2             wb1               w1              w2        
 Min.   :0.000   Min.   :0.0000   Min.   :0.000   Min.   :0.0000  
 1st Qu.:0.000   1st Qu.:0.0000   1st Qu.:0.000   1st Qu.:0.0000  
 Median :0.000   Median :0.0000   Median :0.000   Median :0.0000  
 Mean   :0.111   Mean   :0.1105   Mean   :0.109   Mean   :0.1048  
 3rd Qu.:0.000   3rd Qu.:0.0000   3rd Qu.:0.000   3rd Qu.:0.0000  
 Max.   :1.000   Max.   :1.0000   Max.   :1.000   Max.   :1.0000  
                                                                  
       w3               w4               w5              wday      
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :1.000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:2.000  
 Median :0.0000   Median :0.0000   Median :0.0000   Median :4.000  
 Mean   :0.1031   Mean   :0.1008   Mean   :0.1138   Mean   :4.021  
 3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:0.0000   3rd Qu.:6.000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :7.000  
                                                                   
   riderDOW         share_aiorders        prof         prof_low50    
 Length:7150        Min.   :0.0000   Min.   :2.108   Min.   :0.0000  
 Class :character   1st Qu.:0.0000   1st Qu.:3.987   1st Qu.:0.0000  
 Mode  :character   Median :0.0000   Median :4.582   Median :0.0000  
                    Mean   :0.0428   Mean   :4.666   Mean   :0.4888  
                    3rd Qu.:0.0000   3rd Qu.:5.166   3rd Qu.:1.0000  
                    Max.   :1.0000   Max.   :7.525   Max.   :1.0000  
                                                                     
  prof_high50        prof_low         prof_med        prof_high     
 Min.   :0.0000   Min.   :0.0000   Min.   :0.0000   Min.   :0.0000  
 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:0.0000  
 Median :1.0000   Median :0.0000   Median :0.0000   Median :0.0000  
 Mean   :0.5112   Mean   :0.3228   Mean   :0.3537   Mean   :0.3235  
 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:1.0000  
 Max.   :1.0000   Max.   :1.0000   Max.   :1.0000   Max.   :1.0000  
                                                                    
 share_aiorder          subclass   
 Min.   :0.0002849   31     :  66  
 1st Qu.:0.0013928   97     :  66  
 Median :0.0072727   99     :  66  
 Mean   :0.0433513   131    :  66  
 3rd Qu.:0.0278884   67     :  65  
 Max.   :0.7551020   117    :  65  
                     (Other):6756  
```


## DEEP DIVE — `data_day_matched1`

### unique values per id-like column

```
rider_id                       n_unique=336    head=7643, 8843, 9684, 9782, 11332, 11544, 11703, 11845
Treat                          n_unique=2      head=0, 1
management_partner_id          n_unique=27     head=258, 277, 296, 306, 791, 452, 758, 466
date                           n_unique=66     head=2020-09-26, 2020-09-27, 2020-09-28, 2020-09-29, 2020-09-30, 2020-10-02, 2020-10-03, 2020-10-04
After                          n_unique=2      head=0, 1
station_date                   n_unique=1666   head=258_2020-09-26, 258_2020-09-27, 258_2020-09-28, 258_2020-09-29, 258_2020-09-30, 258_2020-10-02, 258_2020-10-03, 258_2020-10-04
rider_date                     n_unique=14102  head=7643_2020-09-26, 7643_2020-09-27, 7643_2020-09-28, 7643_2020-09-29, 7643_2020-09-30, 7643_2020-10-02, 7643_2020-10-03, 7643_2020-10-04
total_shift                    n_unique=43     head=8, 13, 6, 5, 1, 15, 3, 9
orders_one                     n_unique=35     head=6, 9, 3, 5, 0, 2, 4, 7
num_singleshift                n_unique=35     head=6, 9, 3, 5, 0, 2, 4, 7
num_stackedshift               n_unique=26     head=2, 4, 3, 0, 1, 6, 8, 10
idle_duration                  n_unique=8778   head=0.406944444444444, 0.821666666666667, 0.325, 1.17666666666667, 0, 1.70833333333333, 0.351111111111111, 0.432222222222222
total_aiorders                 n_unique=47     head=0, 1, 4, 3, 18, 10, 6, 5
ai_assist_day                  n_unique=2      head=0, 1
share_idled                    n_unique=13215  head=0.1779424268189, 0.249936628643853, 0.195554069864616, 0.580990261966808, 0, 0.36045012308053, 0.34189883689478, 0.340332458442695
orders_per_hour                n_unique=13457  head=5.68444066561399, 5.47528517110266, 6.01704830352666, 2.46879714716774, 8.12641083521445, 4.43089907396554, 3.89505004057344, 4.7244094488189
avg_waiting                    n_unique=13282  head=15.6384615384615, 13.6407407407407, 15.4566666666667, 14.13, 25.0833333333333, 13.3261904761905, 16.1041666666667, 12.2472222222222
sd_waiting                     n_unique=13756  head=4.46542989000657, 4.45810645280225, 4.57051878623299, 5.83249279658554, 2.62239288521847, 5.11136416730345, 6.40564529666346, 3.94860617696178
var_waiting                    n_unique=13756  head=19.9400641025641, 19.8747131445171, 20.8896419753086, 34.0179722222222, 6.87694444444444, 26.1260436507936, 41.0322916666667, 15.5914907407407
share_failedorders             n_unique=753    head=0, 0.0833333333333333, 0.0769230769230769, 0.0666666666666667, 0.125, 0.0434782608695652, 0.03125, 0.166666666666667
wb5                            n_unique=2      head=1, 0
wb4                            n_unique=2      head=0, 1
wb3                            n_unique=2      head=0, 1
wb2                            n_unique=2      head=0, 1
wb1                            n_unique=2      head=0, 1
w1                             n_unique=2      head=0, 1
w2                             n_unique=2      head=0, 1
w3                             n_unique=2      head=0, 1
w4                             n_unique=2      head=0, 1
w5                             n_unique=2      head=0, 1
wday                           n_unique=7      head=7, 1, 2, 3, 4, 6, 5
riderDOW                       n_unique=2225   head=7643_7, 7643_1, 7643_2, 7643_3, 7643_4, 7643_6, 7643_5, 8843_7
share_aiorders                 n_unique=319    head=NA, 0, 0.0714285714285714, 0.0526315789473684, 0.032258064516129, 0.027027027027027, 0.0238095238095238, 0.0196078431372549
prof_low50                     n_unique=2      head=0, 1
prof_high50                    n_unique=2      head=1, 0
prof_low                       n_unique=2      head=0, 1
prof_med                       n_unique=2      head=1, 0
prof_high                      n_unique=2      head=0, 1
share_aiorder                  n_unique=165    head=NA, 0.00139275766016713, 0.00138600138600139, 0.0018348623853211, 0.000521648408972353, 0.000898472596585804, 0.0116414435389988, 0.0105263157894737
```

- distinct riders (`rider_id`): 336
- date range (`date`): 2020-09-26 ~ 2020-11-30
## DEEP DIVE — `data_shift_matched1`

### unique values per id-like column

```
rider_id                       n_unique=336    head=7643, 8843, 9684, 9782, 11332, 11544, 11703, 11845
management_partner_id          n_unique=27     head=258, 277, 296, 306, 791, 452, 758, 466
date                           n_unique=66     head=2020-09-26, 2020-09-27, 2020-09-28, 2020-09-29, 2020-09-30, 2020-10-02, 2020-10-03, 2020-10-04
After                          n_unique=2      head=0, 1
shift                          n_unique=44     head=1, 2, 3, 4, 5, 6, 7, 8
rider_date                     n_unique=14102  head=7643_2020-09-26, 7643_2020-09-27, 7643_2020-09-28, 7643_2020-09-29, 7643_2020-09-30, 7643_2020-10-02, 7643_2020-10-03, 7643_2020-10-04
num_aiorders                   n_unique=25     head=0, 1, 2, 3, 4, 6, 5, 16
share_aiorders                 n_unique=109    head=0, 1, 0.5, 0.333333333333333, 0.25, 0.2, 0.666666666666667, 0.222222222222222
avg_waiting                    n_unique=22789  head=19.925, 8.55, 14.85, 16.3933333333333, 18.5166666666667, 10.2, 12.8833333333333, 16.4833333333333
sd_waiting                     n_unique=46323  head=0.931023928562287, NA, 5.04436704541699, 1.75598183994659, 2.54558441227157, 1.79133717900592, 5.96930419668763, 3.65391722827859
var_waiting                    n_unique=47099  head=0.866805555555555, NA, 25.4456388888889, 3.08347222222222, 6.48, 3.20888888888889, 35.6325925925926, 13.3511111111111
share_failed                   n_unique=272    head=0, 0.5, 0.25, 1, 0.1, 0.333333333333333, 0.384615384615385, 0.666666666666667
Treat                          n_unique=2      head=0, 1
idle_btw_shifts                n_unique=3843   head=NA, 0.166666666666667, 2.58333333333333, 14.55, 7.11666666666667, 2.01666666666667, 2.08333333333333, 2.66666666666667
ai_assist                      n_unique=2      head=0, 1
station_date                   n_unique=1666   head=258_2020-09-26, 258_2020-09-27, 258_2020-09-28, 258_2020-09-29, 258_2020-09-30, 258_2020-10-02, 258_2020-10-03, 258_2020-10-04
start_hour                     n_unique=24     head=13, 16, 18, 19, 22, 12, 14, 15
wday                           n_unique=7      head=7, 1, 2, 3, 4, 6, 5
hourDOW                        n_unique=162    head=13_7, 16_7, 18_7, 19_7, 22_7, 12_1, 13_1, 14_1
riderDOW                       n_unique=2225   head=7643_7, 7643_1, 7643_2, 7643_3, 7643_4, 7643_6, 7643_5, 8843_7
wb5                            n_unique=2      head=1, 0
wb4                            n_unique=2      head=0, 1
wb3                            n_unique=2      head=0, 1
wb2                            n_unique=2      head=0, 1
wb1                            n_unique=2      head=0, 1
w1                             n_unique=2      head=0, 1
w2                             n_unique=2      head=0, 1
w3                             n_unique=2      head=0, 1
w4                             n_unique=2      head=0, 1
w5                             n_unique=2      head=0, 1
prof_low50                     n_unique=2      head=0, 1
prof_high50                    n_unique=2      head=1, 0
prof_low                       n_unique=2      head=0, 1
prof_med                       n_unique=2      head=1, 0
prof_high                      n_unique=2      head=0, 1
share_aiorder                  n_unique=165    head=NA, 0.00139275766016713, 0.00138600138600139, 0.0018348623853211, 0.000521648408972353, 0.000898472596585804, 0.0116414435389988, 0.0105263157894737
```

- distinct riders (`rider_id`): 336
- date range (`date`): 2020-09-26 ~ 2020-11-30
