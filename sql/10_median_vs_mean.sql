-- Query 10: Median vs Mean Deal Size By Sector
-- Business question: Which sectors have most skewed deal sizes?
-- Concepts: Median calculation using ROW_NUMBER(), JOIN between CTEs, ratio analysis

WITH sector_stats AS (
    SELECT
        sector,
        amount_usd,
        ROW_NUMBER() OVER (
            PARTITION BY sector
            ORDER BY amount_usd
        )                                            AS rn,
        COUNT(*) OVER (PARTITION BY sector)          AS cnt
    FROM funding_rounds
    WHERE sector IS NOT NULL
      AND amount_usd IS NOT NULL
      AND year >= 2014
      AND year <= 2020
),
medians AS (
    SELECT
        sector,
        AVG(amount_usd)                              AS median_usd
    FROM sector_stats
    WHERE rn IN (
        (cnt + 1) / 2,
        (cnt + 2) / 2
    )
    GROUP BY sector
),
means AS (
    SELECT
        sector,
        COUNT(*)                                     AS deals,
        ROUND(AVG(amount_usd)/1e6, 2)                AS mean_mn_usd,
        ROUND(SUM(amount_usd)/1e6, 1)                AS total_mn_usd
    FROM funding_rounds
    WHERE sector IS NOT NULL
      AND amount_usd IS NOT NULL
      AND year >= 2014
      AND year <= 2020
    GROUP BY sector
)
SELECT
    m.sector,
    m.deals,
    ROUND(md.median_usd/1e6, 2)                      AS median_mn_usd,
    m.mean_mn_usd,
    ROUND(m.mean_mn_usd / (md.median_usd/1e6), 1)    AS mean_to_median_ratio,
    m.total_mn_usd
FROM means m
JOIN medians md ON m.sector = md.sector
ORDER BY mean_to_median_ratio DESC;
