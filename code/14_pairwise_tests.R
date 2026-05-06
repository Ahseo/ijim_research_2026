# =============================================================================
# 14_pairwise_tests.R
# Compute pairwise Wald tests on DDD coefficients (manuscript-exact spec):
#   H0_1: After:Treat:prof_med == After:Treat:prof_low
#   H0_2: After:Treat:prof_med == After:Treat:prof_high
#   H0_3: After:Treat:prof_low == After:Treat:prof_high
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({ library(data.table); library(lfe) })
load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)

m <- felm(orders_per_hour ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high
            + After:prof_med + After:prof_high
          | rider_id + station_date | 0 | rider_id, data = day)
print(summary(m)$coefficients)

# pairwise tests via linearHypothesis with cluster-robust V
V <- m$clustervcv
b <- coef(m)
nm <- names(b)
cat("Coefficient names: ", paste(nm, collapse = ", "), "\n")
i_low  <- which(nm == "After:Treat:prof_low")
i_med  <- which(nm == "After:Treat:prof_med")
i_high <- which(nm == "After:Treat:prof_high")

run_test <- function(label, ia, ib) {
  diff <- b[ia] - b[ib]
  se   <- sqrt(V[ia, ia] + V[ib, ib] - 2 * V[ia, ib])
  z    <- diff / se
  p    <- 2 * (1 - pnorm(abs(z)))
  cat(sprintf("%-30s diff=%+.4f  SE=%.4f  z=%.3f  p=%.4f\n", label, diff, se, z, p))
  data.table(test = label, diff = diff, se = se, z = z, p_value = p)
}

results <- rbind(
  run_test("med vs low",  i_med,  i_low),
  run_test("med vs high", i_med,  i_high),
  run_test("low vs high", i_low,  i_high)
)
fwrite(results, "output/tables/14_pairwise_tests.csv")
cat("\nSaved → output/tables/14_pairwise_tests.csv\n")
