-- Query 14: Cohort Analysis — Follow-on Funding Rate
-- Business question: Of companies that first raised in boom years, how many raised again?
-- Concepts: MIN() for cohort definition, LEFT JOIN for activity tracking, cohort retention rate

WITH first_funding AS (
    SELECT
        startup_name_clean,
        CAST(MIN(year) AS INTEGER)    AS cohort_year
    FROM funding_rounds
    WHERE year >= 2013
      AND year <= 2019
      AND startup_name_clean IS NOT NULL
    GROUP BY startup_name_clean
),
cohort_activity AS (
    SELECT
        f.cohort_year,
        COUNT(DISTINCT f.startup_name_clean)  AS cohort_size,
        COUNT(DISTINCT CASE
            WHEN CAST(r.year AS INTEGER) > f.cohort_year
            THEN f.startup_name_clean
        END)                                  AS raised_followon
    FROM first_funding f
    LEFT JOIN funding_rounds r
        ON f.startup_name_clean = r.startup_name_clean
    GROUP BY f.cohort_year
)
SELECT
    cohort_year,
    cohort_size,
    raised_followon,
    ROUND(
        raised_followon * 100.0 / cohort_size
    , 1)                                      AS followon_rate_pct
FROM cohort_activity
ORDER BY cohort_year;
