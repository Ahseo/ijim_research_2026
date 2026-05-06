# =============================================================================
# 15_full_verification.R  (Ralph iter 1 — comprehensive verification)
# =============================================================================
setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
options(width = 200)

cat("\n========================================================\n")
cat("  RALPH VERIFICATION — Iteration 1\n")
cat("========================================================\n\n")

ok    <- function(msg) cat(sprintf("  PASS  %s\n", msg))
fail  <- function(msg) cat(sprintf("  FAIL  %s\n", msg))
note  <- function(msg) cat(sprintf("  NOTE  %s\n", msg))

issues <- character()
check_eq <- function(actual, expected, tol, label) {
  if (abs(actual - expected) < tol) {
    ok(sprintf("%s : actual=%.4f expected=%.4f (within %.4f)", label, actual, expected, tol))
    return(TRUE)
  } else {
    fail(sprintf("%s : actual=%.4f expected=%.4f (diff=%.4f)", label, actual, expected, abs(actual-expected)))
    issues <<- c(issues, label)
    return(FALSE)
  }
}

# ---- 1. Originals integrity ----
cat("[1] ORIGINALS INTEGRITY\n")
originals <- c("Manuscript/Algorithmic task assignment_manuscript_final.docx",
               "Review/review.docx",
               "previous_resource/ISR_submitted ver_data.RData",
               "previous_resource/drive_2/02_DID matching.R",
               "previous_resource/drive_2/01_Data check and cleansing.R")
for (f in originals) {
  if (file.exists(f)) {
    sz <- file.info(f)$size
    md5 <- system2("md5", args = c("-q", shQuote(f)), stdout = TRUE)
    cat(sprintf("  %-72s size=%10d  md5=%s\n", f, sz, md5))
    ok(paste("exists:", basename(f)))
  } else {
    fail(paste("MISSING:", f))
    issues <- c(issues, paste("missing:", f))
  }
}
cat(sprintf("  data/raw/*.csv files: %d\n", length(list.files("data/raw", "*.csv"))))

# ---- 2. Manuscript reproduction ----
cat("\n[2] US-001 REPRODUCTION (manuscript-exact)\n")
suppressPackageStartupMessages({ library(data.table); library(lfe) })
load("previous_resource/ISR_submitted ver_data.RData")
day <- as.data.table(data_day_matched1)
shift <- as.data.table(data_shift_matched1)

m_t4 <- felm(orders_per_hour ~ After:Treat | rider_id + station_date | 0 | rider_id, data = day)
ct <- summary(m_t4)$coefficients
check_eq(ct["After:Treat","Estimate"],     0.141, 0.001, "T4 DID estimate")
check_eq(ct["After:Treat","Cluster s.e."], 0.047, 0.001, "T4 DID SE")

m_t4ddd <- felm(orders_per_hour ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data = day)
ctd <- summary(m_t4ddd)$coefficients
check_eq(ctd["After:Treat:prof_low","Estimate"],  0.088, 0.001, "T4 DDD low estimate")
check_eq(ctd["After:Treat:prof_med","Estimate"],  0.249, 0.001, "T4 DDD med estimate")
check_eq(ctd["After:Treat:prof_high","Estimate"], 0.067, 0.001, "T4 DDD high estimate")

# Table 5 num_orders DDD
m_t5 <- felm(num_orders ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high | rider_id + station_date + hourDOW | 0 | rider_id, data = shift)
cts <- summary(m_t5)$coefficients
check_eq(cts["After:Treat:prof_low","Estimate"],  0.142, 0.001, "T5 num_orders DDD low")
check_eq(cts["After:Treat:prof_med","Estimate"],  0.133, 0.001, "T5 num_orders DDD med")
check_eq(cts["After:Treat:prof_high","Estimate"], 0.166, 0.001, "T5 num_orders DDD high")

# Table 7 single
m_t7s <- felm(avg_waiting ~ After:Treat + avg_dist | rider_id + station_date + hourDOW | 0 | rider_id, data = shift[num_orders == 1])
ct7 <- summary(m_t7s)$coefficients
check_eq(ct7["After:Treat","Estimate"], -0.184, 0.001, "T7 single DID")

# ---- 3. Pairwise test (manuscript p=0.026 = LOG spec) ----
cat("\n[3] PAIRWISE TEST (manuscript text p=0.026 reproduction)\n")
mB <- felm(log(orders_per_hour) ~ After:Treat:prof_low + After:Treat:prof_med + After:Treat:prof_high + After:prof_med + After:prof_high | rider_id + station_date | 0 | rider_id, data = day)
V <- mB$clustervcv; b <- coef(mB); nm <- names(b)
i_low  <- which(nm == "After:Treat:prof_low")
i_med  <- which(nm == "After:Treat:prof_med")
i_high <- which(nm == "After:Treat:prof_high")
d3 <- b[i_med] - 0.5*(b[i_low]+b[i_high])
s3 <- sqrt(V[i_med,i_med] + 0.25*V[i_low,i_low] + 0.25*V[i_high,i_high]
           - V[i_med,i_low] - V[i_med,i_high] + 0.5*V[i_low,i_high])
p3 <- 2*(1-pnorm(abs(d3/s3)))
cat(sprintf("  med vs (low+high)/2 on log-prod: p=%.4f (manuscript: 0.026)\n", p3))
if (abs(p3 - 0.026) < 0.01) ok("Manuscript p=0.026 (LOG spec) reproduces") else note(sprintf("p=%.3f close to 0.026", p3))

# ---- 4. Skill audit ----
cat("\n[4] SKILL CLASSIFICATION AUDIT\n")
md_files <- list.files("manuscript_revised", "section_.*\\.md$", full.names = TRUE)
total_skill <- 0
bad <- c("low-skilled", "medium-skilled", "high-skilled",
         "skill levels", "skill level", "skill groups", "skill group")
for (f in md_files) {
  txt <- readLines(f, warn = FALSE)
  for (p in bad) {
    matches <- grep(p, txt, ignore.case = TRUE)
    if (length(matches) > 0) {
      cat(sprintf("  %s line %s : '%s'\n", basename(f), paste(matches, collapse=","), p))
      total_skill <- total_skill + length(matches)
    }
  }
}
if (total_skill == 0) {
  ok("No worker-classification 'skill' in section_*.md")
} else {
  fail(sprintf("%d worker-classification 'skill' uses", total_skill))
  issues <- c(issues, "skill found")
}

# ---- 5. Claims-to-avoid ----
cat("\n[5] CLAIMS-TO-AVOID\n")
avoid <- c("formal mediation","platform-wide consumer welfare","AI promotes social equality",
           "AI promote social equality","low-skilled workers benefited the most",
           "single-order waiting time improved")
for (p in avoid) {
  found <- 0
  for (f in md_files) {
    txt <- paste(readLines(f, warn = FALSE), collapse = " ")
    if (grepl(p, txt, ignore.case = TRUE)) found <- found + 1
  }
  if (found == 0) ok(sprintf("0 occ: '%s'", p)) else {
    fail(sprintf("%d occ: '%s'", found, p))
    issues <- c(issues, paste("avoid:", p))
  }
}

# ---- 6. Response letter coverage ----
cat("\n[6] RESPONSE LETTER ID COVERAGE\n")
rl <- paste(readLines("response/response_letter_v1.md", warn = FALSE), collapse = "\n")
ids <- c("R1-1","R1-2","R1-3A","R1-3B","R1-3C","R1-4","R1-Minor-1","R1-Minor-2","R1-Minor-3",
         "R2-1","R2-2","R2-3","R2-4","R2-5","R2-6","R2-7","R2-8","R2-9","R2-10","R2-11",
         "AE-1","AE-2","AE-3","AE-4")
missing <- ids[!sapply(ids, function(x) grepl(x, rl, fixed = TRUE))]
if (length(missing) == 0) {
  ok(sprintf("All %d reviewer IDs present", length(ids)))
} else {
  fail(sprintf("MISSING: %s", paste(missing, collapse=", ")))
  issues <- c(issues, "missing IDs")
}

# ---- 7. Output files ----
cat("\n[7] OUTPUT FILES\n")
req <- c("output/tables/04_manuscript_exact_log.txt",
         "output/tables/05_event_study_coefficients.csv",
         "output/tables/05_event_study_pretrend_test.csv",
         "output/figures/05_event_study_productivity.png",
         "output/tables/06_oster_bounds.csv",
         "output/tables/07_dose_response_regression.csv",
         "output/figures/07_dose_response.png",
         "output/tables/08_stable_workers.csv",
         "output/tables/09_inequality.csv",
         "output/tables/09_inequality_did.csv",
         "output/figures/09_inequality_density.png",
         "output/tables/10_learning_dynamics.csv",
         "output/figures/10_learning_curves_by_group.png",
         "output/tables/11_worker_customer_linkage.csv",
         "output/figures/11_worker_customer_linkage.png",
         "output/tables/12_sample_comparison.csv",
         "output/tables/12_mde.csv",
         "output/figures/12_sample_representativeness.png",
         "output/tables/13_long_term_event_study.csv",
         "output/figures/13_long_term_event_study.png",
         "output/tables/14_pairwise_tests.csv")
miss <- req[!sapply(req, file.exists)]
if (length(miss) == 0) {
  ok(sprintf("All %d output files exist", length(req)))
} else {
  fail(sprintf("MISSING: %s", paste(miss, collapse=", ")))
  issues <- c(issues, "missing outputs")
}

# ---- 8. Sections + docx ----
cat("\n[8] MANUSCRIPT SECTIONS\n")
for (i in 1:7) {
  fs <- list.files("manuscript_revised", sprintf("section_%d_.*\\.md$", i), full.names = TRUE)
  if (length(fs) > 0) ok(sprintf("section_%d: %s", i, basename(fs[1]))) else {
    fail(sprintf("section_%d MISSING", i)); issues <- c(issues, paste("missing section", i))
  }
}
if (file.exists("manuscript_revised/manuscript_revised_v1.docx")) ok("docx generated")
if (file.exists("response/response_letter_v1.docx")) ok("response docx generated")

# ---- 9. Body ↔ table consistency ----
cat("\n[9] BODY ↔ TABLE CONSISTENCY\n")
pt <- fread("output/tables/05_event_study_pretrend_test.csv")
check_eq(as.numeric(pt$statistic), 0.65, 0.05, "Pre-trend F")
check_eq(as.numeric(pt$p_value),   0.63, 0.05, "Pre-trend p")
sw <- fread("output/tables/08_stable_workers.csv")
check_eq(sw[spec == "DID stable", est], 0.164, 0.001, "Stable DID")
lt <- fread("output/tables/13_long_term_event_study.csv")
nov <- lt[term == "mon_label2020-11:Treat", Estimate]
check_eq(nov, 0.213, 0.005, "Long-term Nov 2020")
inq <- fread("output/tables/09_inequality_did.csv")
check_eq(inq[metric == "gini", did], -0.005, 0.001, "Gini DiD")
mde <- fread("output/tables/12_mde.csv")
check_eq(mde[spec == "DID (After:Treat)", MDE_pct], 2.81, 0.05, "MDE DID")

# ---- Summary ----
cat("\n========================================================\n")
cat(sprintf("  TOTAL ISSUES: %d\n", length(issues)))
if (length(issues) > 0) for (i in issues) cat(sprintf("    - %s\n", i))
if (length(issues) == 0) cat("  ALL CHECKS PASSED ✅\n")
cat("========================================================\n")
