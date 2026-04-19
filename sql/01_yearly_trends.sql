-- Query 01: Total Funding and Deal Count By Year
-- Business question: How has capital deployment changed year over year?
-- Concepts: WHERE, GROUP BY, ORDER BY, SUM, COUNT, AVG, ROUND, CAST

SELECT 
    CAST(year AS INTEGER)            AS year,
    COUNT(*)                         AS total_deals,
    COUNT(amount_usd)                AS deals_with_amount,
    ROUND(SUM(amount_usd)/1e6, 1)    AS total_funding_mn_usd,
    ROUND(AVG(amount_usd)/1e6, 2)    AS avg_deal_size_mn_usd,
    ROUND(
        (COUNT(amount_usd) * 100.0) 
        / COUNT(*), 1
    )                                AS pct_disclosed
FROM funding_rounds
WHERE year >= 2010
  AND year <= 2020
GROUP BY year
ORDER BY year;
