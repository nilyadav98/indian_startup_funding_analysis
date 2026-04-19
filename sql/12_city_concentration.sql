-- Query 12: City Funding Concentration By Year
-- Business question: Is Bengaluru's dominance growing or declining?
-- Concepts: RANK() with PARTITION BY year, percentage within year window function

WITH city_year AS (
    SELECT
        CAST(year AS INTEGER)         AS year,
        city_clean,
        COUNT(*)                      AS deals,
        ROUND(SUM(amount_usd)/1e6, 1) AS funding_mn_usd
    FROM funding_rounds
    WHERE year >= 2015
      AND year <= 2019
      AND city_clean IS NOT NULL
      AND amount_usd IS NOT NULL
    GROUP BY year, city_clean
),
ranked AS (
    SELECT
        year,
        city_clean,
        deals,
        funding_mn_usd,
        ROUND(
            funding_mn_usd * 100.0 /
            SUM(funding_mn_usd) OVER (PARTITION BY year)
        , 1)                          AS pct_of_year_funding,
        RANK() OVER (
            PARTITION BY year
            ORDER BY funding_mn_usd DESC
        )                             AS city_rank
    FROM city_year
)
SELECT *
FROM ranked
WHERE city_rank <= 5
ORDER BY year, city_rank;
