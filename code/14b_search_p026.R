# Hunt for the test that gives manuscript's reported p=0.026 for
# "medium vs others" pairwise test on productivity DDD.
setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({ library(data.table); library(lfe) })
load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)

# A) LINEAR spec (manuscript-exact)
mA <- felm(orders_per_hour ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high
            + After:prof_med + After:prof_high
          | rider_id + station_date | 0 | rider_id, data = day)
# B) LOG spec (02_DID matching.R style)
mB <- felm(log(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high
            + After:prof_med + After:prof_high
          | rider_id + station_date | 0 | rider_id, data = day)
# C) LOG spec, riderDOW cluster (original 02 script)
mC <- felm(log(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high
            + After:prof_med + After:prof_high
          | rider_id + station_date | 0 | riderDOW, data = day)

run_all_tests <- function(m, label) {
  V <- m$clustervcv; b <- coef(m); nm <- names(b)
  i_low  <- which(nm == "After:Treat:prof_low")
  i_med  <- which(nm == "After:Treat:prof_med")
  i_high <- which(nm == "After:Treat:prof_high")
  cat(sprintf("\n=== %s ===\n", label))
  cat(sprintf("β_low=%.4f  β_med=%.4f  β_high=%.4f\n", b[i_low], b[i_med], b[i_high]))

  # T1: med - low
  d1 <- b[i_med] - b[i_low];   s1 <- sqrt(V[i_med,i_med]+V[i_low,i_low]-2*V[i_med,i_low]);   p1 <- 2*(1-pnorm(abs(d1/s1)))
  # T2: med - high
  d2 <- b[i_med] - b[i_high];  s2 <- sqrt(V[i_med,i_med]+V[i_high,i_high]-2*V[i_med,i_high]); p2 <- 2*(1-pnorm(abs(d2/s2)))
  # T3: med - mean(low, high)
  d3 <- b[i_med] - 0.5*(b[i_low]+b[i_high])
  s3 <- sqrt(V[i_med,i_med] + 0.25*V[i_low,i_low] + 0.25*V[i_high,i_high]
             - V[i_med,i_low] - V[i_med,i_high] + 0.5*V[i_low,i_high])
  p3 <- 2*(1-pnorm(abs(d3/s3)))
  # T4: joint Wald F-test β_med = β_low AND β_med = β_high  (2 restrictions)
  R <- matrix(0, 2, length(b))
  R[1, i_med] <-  1; R[1, i_low]  <- -1
  R[2, i_med] <-  1; R[2, i_high] <- -1
  Rb <- R %*% b
  RVR <- R %*% V %*% t(R)
  W <- t(Rb) %*% solve(RVR) %*% Rb
  pW <- 1 - pchisq(as.numeric(W), df = 2)

  cat(sprintf("med - low      diff=%+.4f SE=%.4f p=%.4f\n", d1, s1, p1))
  cat(sprintf("med - high     diff=%+.4f SE=%.4f p=%.4f\n", d2, s2, p2))
  cat(sprintf("med - mean(low,high) diff=%+.4f SE=%.4f p=%.4f\n", d3, s3, p3))
  cat(sprintf("joint Wald(2 df)  W=%.4f p=%.4f\n", as.numeric(W), pW))
}

run_all_tests(mA, "A) LINEAR + rider_id cluster (manuscript-exact)")
run_all_tests(mB, "B) LOG + rider_id cluster")
run_all_tests(mC, "C) LOG + riderDOW cluster (02_DID matching.R style)")
