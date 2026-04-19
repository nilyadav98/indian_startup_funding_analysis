-- Query 03: Top 10 Cities by Total Funding
-- Business question: Which cities dominate Indian startup funding?
-- Concepts: GROUP BY, HAVING, LIMIT, window function for grand total percentage

SELECT
    city_clean                        AS city,
    COUNT(*)                          AS total_deals,
    ROUND(SUM(amount_usd)/1e6, 1)     AS total_funding_mn_usd,
    ROUND(AVG(amount_usd)/1e6, 2)     AS avg_deal_size_mn_usd,
    ROUND(
        SUM(amount_usd) * 100.0 /
        SUM(SUM(amount_usd)) OVER ()
    , 1)                              AS pct_of_total_funding
FROM funding_rounds
WHERE city_clean IS NOT NULL
  AND amount_usd IS NOT NULL
GROUP BY city_clean
HAVING COUNT(*) >= 10
ORDER BY total_funding_mn_usd DESC
LIMIT 10;
