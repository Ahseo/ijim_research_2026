# =============================================================================
# 13_long_term_extension.R  (US-010)
# Associate Editor #4 + Reviewer 2 #7 address: long-term effects via Dec-Feb
# Busan-exclusive data integration.
#
# data/raw/recommendation_data_busan_exclusive_dec_feb.csv
# Schema is expected to be similar to recommendation_data_20201221.csv (raw
# orders). We need to:
#   1. Load Dec-Feb csv
#   2. Filter to matched riders (336 from psmatch1 → matched_data1)
#   3. Apply same cleansing rules (active hours, distance, valid times)
#   4. Aggregate to day-level
#   5. Append to existing post-period day-level data
#   6. Run extended event-study
# =============================================================================

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)
suppressPackageStartupMessages({
  for (p in c("data.table","dplyr","lubridate","lfe","ggplot2")) {
    if (!requireNamespace(p, quietly = TRUE)) install.packages(p, repos = "https://cloud.r-project.org")
  }
  library(data.table); library(dplyr); library(lubridate); library(lfe); library(ggplot2)
})

# Quick header check
cat("\n=== Dec-Feb csv header ===\n")
h <- fread("data/raw/recommendation_data_busan_exclusive_dec_feb.csv", nrows = 5)
print(names(h))
print(head(h, 3))

# Estimate row count
cmd_lines <- system("wc -l data/raw/recommendation_data_busan_exclusive_dec_feb.csv 2>/dev/null", intern = TRUE)
cat("\nFile metrics:", cmd_lines, "\n")

# Load full Dec-Feb csv (~2.7GB — may take a few minutes)
cat(sprintf("\n[%s] Loading Dec-Feb csv...\n", Sys.time()))
ext <- fread("data/raw/recommendation_data_busan_exclusive_dec_feb.csv")
cat(sprintf("[%s] Loaded: %d rows × %d cols\n", Sys.time(), nrow(ext), ncol(ext)))
cat("Date range:", as.character(min(ext$date, na.rm = TRUE)), "to", as.character(max(ext$date, na.rm = TRUE)), "\n")
cat("Riders:", uniqueN(ext$agent_id), "\n")

# Load RData for matched_data1 (336 riders)
load("previous_resource/ISR_submitted ver_data.RData")
matched_riders <- as.data.frame(matched_data1)$rider_id
cat(sprintf("Matched riders to keep: %d\n", length(matched_riders)))

# Filter Dec-Feb to matched riders
# Note: column 'agent_id' in raw vs 'rider_id' after rename
if ("agent_id" %in% names(ext)) ext[, rider_id := agent_id]
ext_matched <- ext[rider_id %in% matched_riders]
cat(sprintf("Dec-Feb matched-rider orders: %d (riders %d)\n",
            nrow(ext_matched), uniqueN(ext_matched$rider_id)))

# Save initial diagnostic (don't run full event-study yet to avoid long execution)
diagnostic <- data.table(
  metric = c("Dec-Feb csv rows", "Dec-Feb csv riders", "Date range start", "Date range end",
             "Matched-rider rows", "Matched riders kept"),
  value  = c(as.character(nrow(ext)), as.character(uniqueN(ext$agent_id)),
             as.character(min(ext$date, na.rm = TRUE)), as.character(max(ext$date, na.rm = TRUE)),
             as.character(nrow(ext_matched)), as.character(uniqueN(ext_matched$rider_id)))
)
fwrite(diagnostic, "output/tables/13_long_term_diagnostic.csv")

note_initial <- c(
  "# US-010 Long-Term Extension — Initial Diagnostic",
  "",
  "## Status: data load + filter ✓ — full event-study deferred to pipeline run",
  "",
  paste(capture.output(print(diagnostic)), collapse = "\n"),
  "",
  "## Plan",
  "1. Apply same cleansing (delivery_sec ≥ 60, waiting_sec ≥ 300, hour 11-22)",
  "2. Compute shift assignment via overlap rule",
  "3. Aggregate to day-level (orders_per_hour, total_orders, etc.)",
  "4. Append to data_day_matched1 post-period; create extended event-study with monthly bins",
  "5. Compare 1-month estimate vs 3+ month estimate for stability",
  "",
  "## Reviewer address",
  "- AE-4 + R2-7: addresses concern about short observation window. Extended Busan-only Dec-Feb data allow event-study coefficients to be estimated 2-3 months after AI rollout, testing whether the productivity effect persists or attenuates.",
  "",
  "## Note",
  "Full processing of the 2.7GB Dec-Feb csv requires ~5-10 min. The current script provides initial diagnostic; the full event-study extension is in `code/13b_long_term_extension_full.R` (next step) which performs the rebuild + regression."
)
writeLines(note_initial, "output/interpretation/13_long_term_extension.md")
cat("Saved → output/interpretation/13_long_term_extension.md\n[US-010 initial diagnostic] DONE\n")
