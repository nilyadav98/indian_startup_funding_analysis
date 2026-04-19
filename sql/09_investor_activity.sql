-- Query 09: Top Investors By Deal Count
-- Business question: Which investors were most active across cycles?
-- Concepts: GROUP BY, HAVING, LOWER() for case-insensitive filtering, NOT LIKE

SELECT
    investors,
    COUNT(*)                          AS total_deals,
    COUNT(DISTINCT startup_name)      AS unique_companies,
    ROUND(SUM(amount_usd)/1e6, 1)     AS total_invested_mn_usd,
    CAST(MIN(year) AS INTEGER)        AS first_deal_year,
    CAST(MAX(year) AS INTEGER)        AS last_deal_year,
    CAST(MAX(year) - MIN(year) AS INTEGER) AS years_active
FROM funding_rounds
WHERE investors IS NOT NULL
  AND investors != 'nan'
  AND amount_usd IS NOT NULL
  AND year >= 2014
  AND year <= 2020
  AND LOWER(investors) NOT LIKE '%undisclosed%'
  AND LOWER(investors) NOT LIKE '%angel investor%'
  AND LOWER(investors) NOT LIKE '%group of%'
GROUP BY investors
HAVING COUNT(*) >= 3
ORDER BY total_deals DESC
LIMIT 20;
