# =============================================================================
# 00_diagnose_rdata.R
# Purpose: 원본 ISR_submitted ver_data.RData 의 구조를 처음부터 진단.
#   - 어떤 객체들이 들어 있는지
#   - 각 객체의 dim, columns, types
#   - 핵심 객체 (data_day_matched1, data_shift_matched1) 의 sample 행
#   - manuscript 의 reported spec 과 어떻게 매칭되는지
# 결과는 docs/03_data_diagnosis.md 로 자동 생성.
# =============================================================================

suppressPackageStartupMessages({
  if (!requireNamespace("data.table", quietly = TRUE)) install.packages("data.table", repos = "https://cloud.r-project.org")
  library(data.table)
})

setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")

rdata_path <- "previous_resource/ISR_submitted ver_data.RData"
stopifnot(file.exists(rdata_path))

cat("[diagnose] Loading RData...\n")
loaded_objs <- load(rdata_path)
cat(sprintf("[diagnose] Loaded %d objects:\n", length(loaded_objs)))
print(loaded_objs)

out_lines <- c(
  "# RData Diagnosis Report",
  "",
  paste0("Source: `", rdata_path, "`"),
  paste0("Generated: ", Sys.time()),
  "",
  paste0("**Loaded objects (", length(loaded_objs), "):** `",
         paste(loaded_objs, collapse = "`, `"), "`"),
  ""
)

for (obj_name in loaded_objs) {
  obj <- get(obj_name)
  out_lines <- c(out_lines, paste0("## `", obj_name, "`"), "")
  out_lines <- c(out_lines, paste0("- class: `", paste(class(obj), collapse = ", "), "`"))

  if (is.data.frame(obj) || is.matrix(obj)) {
    out_lines <- c(out_lines,
      paste0("- dim: ", nrow(obj), " rows x ", ncol(obj), " cols"))
    out_lines <- c(out_lines,
      paste0("- columns: `", paste(names(obj), collapse = "`, `"), "`"))
    out_lines <- c(out_lines, "", "### sample (first 5 rows)", "", "```")
    out_lines <- c(out_lines, capture.output(head(as.data.frame(obj), 5)))
    out_lines <- c(out_lines, "```", "")
    out_lines <- c(out_lines, "### column types", "", "```")
    types <- sapply(as.data.frame(obj), function(x) paste(class(x), collapse = "/"))
    out_lines <- c(out_lines, paste0(names(types), ": ", types))
    out_lines <- c(out_lines, "```", "")
    out_lines <- c(out_lines, "### summary", "", "```")
    out_lines <- c(out_lines, capture.output(summary(as.data.frame(obj))))
    out_lines <- c(out_lines, "```", "")
  } else if (is.list(obj)) {
    out_lines <- c(out_lines, paste0("- length: ", length(obj)))
    out_lines <- c(out_lines, paste0("- names: `", paste(names(obj), collapse = "`, `"), "`"))
  } else if (is.vector(obj)) {
    out_lines <- c(out_lines, paste0("- length: ", length(obj)))
    out_lines <- c(out_lines, paste0("- head: ", paste(head(obj, 10), collapse = ", ")))
  }
  out_lines <- c(out_lines, "")
}

# 핵심 객체 자세히
for (key in c("data_day_matched1", "data_shift_matched1")) {
  if (exists(key)) {
    obj <- get(key)
    out_lines <- c(out_lines, paste0("## DEEP DIVE — `", key, "`"), "")
    df <- as.data.frame(obj)

    out_lines <- c(out_lines, "### unique values per id-like column", "", "```")
    for (cn in names(df)) {
      n_unique <- length(unique(df[[cn]]))
      if (n_unique < 50 || grepl("id|rider|branch|group|skill|date|time|treat|post|adopt|ai|hour|day|week",
                                  cn, ignore.case = TRUE)) {
        head_vals <- paste(head(unique(df[[cn]]), 8), collapse = ", ")
        out_lines <- c(out_lines, sprintf("%-30s n_unique=%-6d head=%s", cn, n_unique, head_vals))
      }
    }
    out_lines <- c(out_lines, "```", "")

    # rider count + observation window
    rider_col <- intersect(c("rider_id", "rider", "id_rider", "user_id", "RIDER_ID", "rider_no"), names(df))
    if (length(rider_col) > 0) {
      out_lines <- c(out_lines, sprintf("- distinct riders (`%s`): %d", rider_col[1], length(unique(df[[rider_col[1]]]))))
    }
    date_col <- intersect(c("date", "ymd", "day", "rider_date", "DATE"), names(df))
    if (length(date_col) > 0) {
      d <- df[[date_col[1]]]
      out_lines <- c(out_lines, sprintf("- date range (`%s`): %s ~ %s",
                                          date_col[1], min(d, na.rm = TRUE), max(d, na.rm = TRUE)))
    }
  }
}

dir.create("docs", showWarnings = FALSE)
out_path <- "docs/03_data_diagnosis.md"
writeLines(out_lines, out_path)
cat(sprintf("\n[diagnose] Wrote: %s\n", out_path))
cat(sprintf("[diagnose] Lines: %d\n", length(out_lines)))
