# =============================================================================
# 09_inequality.R  (US-006)
# Reviewer 1 Minor #2 address: direct inequality metrics
# (Gini, Theil, P90/P10) on productivity distribution, pre vs post.
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({
  for (p in c("data.table","ggplot2","ineq")) {
    if (!requireNamespace(p, quietly = TRUE)) install.packages(p, repos = "https://cloud.r-project.org")
  }
  library(data.table); library(ggplot2); library(ineq)
})

load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)

# Compute rider-level mean productivity per period
rider_period <- day[, .(mean_prod = mean(orders_per_hour, na.rm = TRUE)),
                    by = .(rider_id, Treat, After)]

# Treated only (we measure within-treated inequality before vs after)
metrics <- function(x) {
  x <- x[!is.na(x) & x > 0]
  list(
    n      = length(x),
    mean   = mean(x),
    sd     = sd(x),
    gini   = ineq(x, type = "Gini"),
    theil  = ineq(x, type = "Theil"),
    p90p10 = quantile(x, 0.9) / quantile(x, 0.1),
    p75p25 = quantile(x, 0.75) / quantile(x, 0.25)
  )
}

# All matched riders (treated + control), pre vs post
groups <- list(
  list(label = "All matched, PRE",  data = rider_period[After == 0, mean_prod]),
  list(label = "All matched, POST", data = rider_period[After == 1, mean_prod]),
  list(label = "Treated, PRE",      data = rider_period[After == 0 & Treat == 1, mean_prod]),
  list(label = "Treated, POST",     data = rider_period[After == 1 & Treat == 1, mean_prod]),
  list(label = "Control, PRE",      data = rider_period[After == 0 & Treat == 0, mean_prod]),
  list(label = "Control, POST",     data = rider_period[After == 1 & Treat == 0, mean_prod])
)

out <- rbindlist(lapply(groups, function(g) {
  m <- metrics(g$data)
  data.table(group = g$label, n = m$n, mean = m$mean, sd = m$sd,
             gini = m$gini, theil = m$theil,
             p90p10 = m$p90p10, p75p25 = m$p75p25)
}))
print(out)
fwrite(out, "output/tables/09_inequality.csv")

# DiD-on-inequality: change in Gini/Theil for treated minus change for control
delta <- function(metric_col) {
  t_pre  <- out[group == "Treated, PRE",  get(metric_col)]
  t_post <- out[group == "Treated, POST", get(metric_col)]
  c_pre  <- out[group == "Control, PRE",  get(metric_col)]
  c_post <- out[group == "Control, POST", get(metric_col)]
  did <- (t_post - t_pre) - (c_post - c_pre)
  data.table(metric = metric_col,
             treated_change = t_post - t_pre,
             control_change = c_post - c_pre,
             did = did)
}
did_ineq <- rbindlist(lapply(c("gini","theil","p90p10","p75p25"), delta))
print(did_ineq)
fwrite(did_ineq, "output/tables/09_inequality_did.csv")

# Density plot: pre vs post productivity (all matched)
p <- ggplot(rider_period, aes(x = mean_prod, fill = factor(After, labels = c("Pre","Post")))) +
  geom_density(alpha = 0.5) +
  scale_fill_manual(name = "Period", values = c("steelblue","tomato")) +
  labs(x = "Rider mean productivity (orders/hour)",
       y = "Density",
       title = "Productivity distribution: Pre vs Post AI rollout",
       subtitle = "Matched 336 riders; rider-level mean within each period") +
  theme_bw(base_size = 12)
ggsave("output/figures/09_inequality_density.png", p, width = 8, height = 5, dpi = 200)
cat("Saved → output/figures/09_inequality_density.png\n")

# DDD-style regression on daily productivity dispersion proxy: SD within
day[, .(rider_count = uniqueN(rider_id)), by = .(After)]

note <- c(
  "# US-006 Inequality Metrics",
  "",
  "## Approach",
  "Compute rider-level mean productivity (orders/hour) within each period, then summarize the cross-rider distribution with Gini, Theil, P90/P10, P75/P25.",
  "",
  "## Period × group metrics",
  paste(capture.output(print(out)), collapse = "\n"),
  "",
  "## DiD on inequality (treated change − control change)",
  paste(capture.output(print(did_ineq)), collapse = "\n"),
  "",
  "## Reviewer address",
  "- R1-Minor-2: direct inequality metrics now reported (in addition to subgroup DDD coefficients). The Gini and Theil indices, plus P90/P10 ratio, document the cross-rider productivity distribution change. The DiD on inequality formalises the compression claim relative to control riders.",
  "",
  "## Interpretation",
  "If treated_change for Gini/Theil is more negative than control_change → inequality compresses MORE among treated. The DDD coefficient on After:Treat:prof_med (medium-skilled) being the only significant interaction is consistent with the bulk of compression happening in the middle of the distribution."
)
writeLines(note, "output/interpretation/09_inequality.md")
cat("Saved → output/interpretation/09_inequality.md\n[US-006] DONE\n")
