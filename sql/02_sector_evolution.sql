-- Query 02: Sector Share Evolution Over Time
-- Business question: Which sectors grew, shrank, or emerged across the decade?
-- Concepts: GROUP BY multiple columns, window function for percentage calculation

SELECT
    CAST(year AS INTEGER)          AS year,
    sector,
    COUNT(*)                       AS deals,
    ROUND(SUM(amount_usd)/1e6, 1)  AS funding_mn_usd,
    ROUND(
        COUNT(*) * 100.0 / 
        SUM(COUNT(*)) OVER (PARTITION BY year)
    , 1)                           AS pct_of_year_deals
FROM funding_rounds
WHERE year >= 2014
  AND year <= 2020
  AND sector IS NOT NULL
GROUP BY year, sector
ORDER BY year, deals DESC;
