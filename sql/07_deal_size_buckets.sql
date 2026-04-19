-- Query 07: Deal Size Distribution Using CASE
-- Business question: How are deals distributed across size buckets?
-- Concepts: CASE statement for bucketing, window function for percentages

WITH bucketed AS (
    SELECT
        startup_name,
        sector,
        amount_usd,
        CAST(year AS INTEGER) AS year,
        CASE
            WHEN amount_usd < 500000        THEN '1. Micro (<$500K)'
            WHEN amount_usd < 2000000       THEN '2. Small ($500K-$2M)'
            WHEN amount_usd < 10000000      THEN '3. Mid ($2M-$10M)'
            WHEN amount_usd < 50000000      THEN '4. Large ($10M-$50M)'
            WHEN amount_usd < 200000000     THEN '5. Growth ($50M-$200M)'
            ELSE                                 '6. Mega ($200M+)'
        END                                AS deal_size_bucket
    FROM funding_rounds
    WHERE amount_usd IS NOT NULL
      AND year >= 2014
      AND year <= 2020
)
SELECT
    deal_size_bucket,
    COUNT(*)                          AS deal_count,
    ROUND(COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (), 1)     AS pct_of_deals,
    ROUND(SUM(amount_usd)/1e6, 1)     AS total_funding_mn_usd,
    ROUND(SUM(amount_usd) * 100.0 /
        SUM(SUM(amount_usd)) OVER (), 1) AS pct_of_funding
FROM bucketed
GROUP BY deal_size_bucket
ORDER BY deal_size_bucket;
