# IJIM Research 2026 — OMC Ralph Workspace

## Goal

JJIM-D-25-02826 (*Does AI Benefit All Platform Stakeholders?*) major revision package by **2026-05-30**.

## Read first

1. `docs/01_reviewer_comments_mapped.md` — 25 numbered reviewer comments + address strategy
2. `docs/02_revision_roadmap.md` — Phase 0–5 plan
3. `.omc/prd.json` — 21 user stories for Ralph
4. `.omc/progress.txt` — current state log

## Originals (DO NOT MODIFY)

- `Manuscript/Algorithmic task assignment_manuscript_final.docx`
- `Review/review.docx`
- `previous_resource/**` (R scripts + ISR_submitted ver_data.RData)
- `data/raw/**` (csv files)

## Working folders (write here)

- `code/` — new R analysis scripts (`01_reproduce_results.R`, `02_event_study.R`, ...)
- `output/tables/`, `output/figures/`, `output/interpretation/` — analysis outputs
- `manuscript_revised/` — revised manuscript drafts (markdown then docx)
- `response/` — response letter
- `docs/` — planning + audit notes
- `.omc/` — Ralph state (prd.json, progress.txt)

## Reproduction starting point

Every new analysis starts from:

```r
load("previous_resource/ISR_submitted ver_data.RData")
# Use: data_day_matched1, data_shift_matched1
```

Long-term extension uses `data/raw/recommendation_data_busan_exclusive_dec_feb.csv`.

## OMC Ralph usage

```
/oh-my-claudecode:ralph "address all reviewer comments per .omc/prd.json"
```

Or short form: `/ralph "..."`.

Ralph reads `.omc/prd.json` and iterates story-by-story until all `passes: true`.

## Claims to AVOID (final pass)

- "formal mediation"
- "platform-wide consumer welfare"
- "AI promotes social equality"
- "low-skilled workers benefited the most" (as a blanket claim)
- "single-order waiting time improved" (as a headline result)

## Skill terminology (AE-1)

- "skill" → "proficiency" or "pre-AI performance" everywhere except an explicit definition footnote.
