# Indian Startup Funding Analysis (2014–2025)

Analyzing a decade of Indian startup funding data — from raw, messy public datasets to cleaned, structured insights.

## Project Status
In progress. Setting up foundation.

## Tech Stack
- **Python** (pandas, numpy) — data cleaning and transformation
- **SQL** (SQLite) — analytical querying
- **Tableau** — interactive dashboard

## Project Structure
indian_startup_funding/
├── data/
│   ├── raw/           # Original untouched datasets
│   ├── interim/       # Mid-cleaning snapshots
│   └── processed/     # Final cleaned data + SQLite DB
├── notebooks/         # Jupyter notebooks — cleaning + analysis
├── sql/               # SQL query files
├── reports/           # Insight report + methodology log
└── docs/              # Data dictionary and documentation

## About
This project takes messy, overlapping public datasets of Indian startup funding rounds and transforms them into a single analysis-ready dataset — then explores structural trends, tests ecosystem narratives, and surfaces non-obvious insights across the 2014–2025 decade.