-- Query 08: Running Cumulative Funding By Year
-- Business question: How did total capital deployed grow across the decade?
-- Concepts: SUM() OVER (ORDER BY) cumulative window function

WITH yearly AS (
    SELECT
        CAST(year AS INTEGER)         AS year,
        COUNT(*)                      AS deals,
        ROUND(SUM(amount_usd)/1e6, 1) AS funding_mn_usd
    FROM funding_rounds
    WHERE year >= 2012
      AND year <= 2020
      AND amount_usd IS NOT NULL
    GROUP BY year
)
SELECT
    year,
    deals,
    funding_mn_usd,
    SUM(deals) OVER (
        ORDER BY year
    )                                 AS cumulative_deals,
    ROUND(SUM(funding_mn_usd) OVER (
        ORDER BY year
    ), 1)                             AS cumulative_funding_mn_usd
FROM yearly
ORDER BY year;
