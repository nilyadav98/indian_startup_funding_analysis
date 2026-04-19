-- Query 11: Funding Stage Evolution By Year
-- Business question: Did ecosystem shift from seed-heavy to growth-stage capital?
-- Concepts: GROUP BY multiple columns, window function percentage within year

WITH stage_year AS (
    SELECT
        CAST(year AS INTEGER)  AS year,
        stage_clean,
        COUNT(*)               AS deals,
        ROUND(SUM(amount_usd)/1e6, 1) AS funding_mn_usd
    FROM funding_rounds
    WHERE year >= 2014
      AND year <= 2020
      AND stage_clean IS NOT NULL
      AND stage_clean != 'Other'
    GROUP BY year, stage_clean
)
SELECT
    year,
    stage_clean,
    deals,
    funding_mn_usd,
    ROUND(
        deals * 100.0 /
        SUM(deals) OVER (PARTITION BY year)
    , 1)                       AS pct_of_year_deals
FROM stage_year
ORDER BY year, deals DESC;
