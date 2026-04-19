-- Query 05: Sector Ranking Per Year Using RANK()
-- Business question: Which sector ranked #1 each year by deals and funding?
-- Concepts: Multiple CTEs, RANK() with PARTITION BY, filtering on window function alias

WITH sector_year AS (
    SELECT
        CAST(year AS INTEGER)         AS year,
        sector,
        COUNT(*)                      AS deals,
        ROUND(SUM(amount_usd)/1e6, 1) AS funding_mn_usd
    FROM funding_rounds
    WHERE year >= 2014
      AND year <= 2020
      AND sector IS NOT NULL
    GROUP BY year, sector
),
ranked AS (
    SELECT
        year,
        sector,
        deals,
        funding_mn_usd,
        RANK() OVER (
            PARTITION BY year
            ORDER BY deals DESC
        )                             AS rank_by_deals,
        RANK() OVER (
            PARTITION BY year
            ORDER BY funding_mn_usd DESC
        )                             AS rank_by_funding
    FROM sector_year
)
SELECT *
FROM ranked
WHERE rank_by_deals <= 5
ORDER BY year, rank_by_deals;
