# Indian Startup Funding Analysis (2014–2025)

Analyzing a decade of Indian startup funding data — from raw, messy public datasets to cleaned, structured insights.

## Live Dashboard
[View Interactive Tableau Dashboard](https://public.tableau.com/app/profile/swapnil.yadav1181/viz/indian_startup_funding_dashboard/indian_startup_funding_dashboard)

## Project Summary
Built a cleaned dataset of 3,998 Indian startup funding rounds (2014–2020) by reconciling 4 public datasets — handling company name deduplication via fuzzy matching, currency normalization, and stage/sector taxonomy consolidation in Python (pandas, numpy). Wrote 15 analytical SQL queries using window functions and CTEs, and built a live interactive Tableau dashboard testing 5 ecosystem narratives against data.

## Key Findings
- Bengaluru captured 49% of all Indian startup funding — but its share is volatile, not consistently growing
- 34 mega rounds ($200M+) captured 49% of all capital deployed — extreme power law distribution
- Fintech is the only sector that grew during both the 2016 and 2018 downturns
- The 2016 boom funded 767 companies — only 13.3% raised follow-on funding vs 26.1% for the 2015 cohort
- The funding winter was a 12-quarter grind, not a sudden crash

## Tech Stack
- **Python** (pandas, numpy, rapidfuzz, matplotlib, seaborn) — data cleaning and EDA
- **SQL** (SQLite) — 15 analytical queries with window functions and CTEs
- **Tableau Desktop** — interactive dashboard published to Tableau Public

## Project Structure
indian_startup_funding/
├── data/
│   ├── raw/           # Original untouched datasets
│   ├── interim/       # Mid-cleaning snapshots
│   └── processed/     # Final cleaned data + SQLite DB
├── notebooks/         # Jupyter notebooks
│   ├── 01_data_exploration.ipynb
│   ├── 02_cleaning_pipeline.ipynb
│   ├── 03_sql_analysis.ipynb
│   └── 04_eda_and_hypothesis.ipynb
├── sql/               # 15 SQL query files
├── reports/
│   └── figures/       # 14 EDA charts
└── tableau/           # Tableau workbook

## Notebooks
| Notebook | Description |
|---|---|
| 01 Data Exploration | Forensic investigation of 4 raw datasets — detected synthetic data in Dataset 3 |
| 02 Cleaning Pipeline | Full cleaning pipeline — fuzzy matching, currency normalization, stage taxonomy |
| 03 SQL Analysis | 15 analytical queries — window functions, CTEs, cohort analysis |
| 04 EDA and Hypothesis | 14 charts + 5 hypothesis tests with verdicts |

## Hypothesis Verdicts
| Hypothesis | Verdict |
|---|---|
| Fintech is the most resilient sector | Confirmed |
| Bengaluru's dominance is declining | Nuanced |
| 2015-2016 boom was volume-driven | Confirmed |
| Funding winter was a gradual grind | Confirmed |
| 2016 companies never raised follow-on | Confirmed |