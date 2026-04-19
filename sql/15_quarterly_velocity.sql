-- Query 15: Quarterly Funding Velocity
-- Business question: Which quarters saw sharpest acceleration or deceleration?
-- Concepts: Quarter-level CTE, LAG() for QoQ change, string concatenation for labels

WITH quarterly AS (
    SELECT
        CAST(year AS INTEGER)             AS year,
        CAST(quarter AS INTEGER)          AS quarter,
        year || '-Q' || CAST(quarter AS INTEGER) AS year_quarter,
        COUNT(*)                          AS deals,
        ROUND(SUM(amount_usd)/1e6, 1)     AS funding_mn_usd
    FROM funding_rounds
    WHERE year >= 2015
      AND year <= 2019
      AND quarter IS NOT NULL
      AND amount_usd IS NOT NULL
    GROUP BY year, quarter
)
SELECT
    year_quarter,
    deals,
    funding_mn_usd,
    LAG(deals, 1) OVER (
        ORDER BY year, quarter
    )                                     AS prev_quarter_deals,
    deals - LAG(deals, 1) OVER (
        ORDER BY year, quarter
    )                                     AS deal_change,
    ROUND(
        (deals - LAG(deals, 1) OVER (
            ORDER BY year, quarter
        )) * 100.0 /
        LAG(deals, 1) OVER (
            ORDER BY year, quarter
        )
    , 1)                                  AS qoq_growth_pct
FROM quarterly
ORDER BY year, quarter;
