setwd("/Users/gujaeseo/Documents/projects/yeonseo/ijim_research_2026")
suppressPackageStartupMessages({ library(MatchIt) })
load("previous_resource/ISR_submitted ver_data.RData")

# psmatch1 — saved matchit object
md1 <- match.data(psmatch1)
cat(sprintf("match.data(psmatch1): %d riders\n", nrow(md1)))
cat(sprintf("psmatch1 covariates: %s\n", paste(colnames(psmatch1$X), collapse=", ")))
cat(sprintf("psmatch1 caliper: %s\n", as.character(psmatch1$caliper)))

# Compare to matched_data1
cat(sprintf("\nmatched_data1: %d riders\n", nrow(matched_data1)))
overlap <- length(intersect(md1$rider_id, matched_data1$rider_id))
cat(sprintf("rider overlap (md1 ∩ matched_data1): %d\n", overlap))
cat(sprintf("only in md1: %d, only in matched_data1: %d\n",
            length(setdiff(md1$rider_id, matched_data1$rider_id)),
            length(setdiff(matched_data1$rider_id, md1$rider_id))))
