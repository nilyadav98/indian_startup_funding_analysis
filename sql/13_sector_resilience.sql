-- Query 13: Sector Resilience Across Market Phases
-- Business question: Which sectors held up during the 2016 and 2018 downturns?
-- Concepts: CASE for phase labeling, pivot using MAX(CASE WHEN...) pattern

WITH sector_era AS (
    SELECT
        sector,
        CASE
            WHEN CAST(year AS INTEGER) = 2015 THEN 'Boom'
            WHEN CAST(year AS INTEGER) = 2016 THEN 'Downturn 1'
            WHEN CAST(year AS INTEGER) = 2017 THEN 'Recovery'
            WHEN CAST(year AS INTEGER) = 2018 THEN 'Downturn 2'
            WHEN CAST(year AS INTEGER) = 2019 THEN 'Late Cycle'
        END                            AS market_phase,
        amount_usd
    FROM funding_rounds
    WHERE year BETWEEN 2015 AND 2019
      AND sector IS NOT NULL
      AND amount_usd IS NOT NULL
),
phase_totals AS (
    SELECT
        sector,
        market_phase,
        COUNT(*)                       AS deals,
        ROUND(SUM(amount_usd)/1e6, 1)  AS funding_mn_usd
    FROM sector_era
    WHERE market_phase IS NOT NULL
    GROUP BY sector, market_phase
)
SELECT
    sector,
    MAX(CASE WHEN market_phase = 'Boom'       THEN funding_mn_usd END) AS boom_2015,
    MAX(CASE WHEN market_phase = 'Downturn 1' THEN funding_mn_usd END) AS downturn1_2016,
    MAX(CASE WHEN market_phase = 'Recovery'   THEN funding_mn_usd END) AS recovery_2017,
    MAX(CASE WHEN market_phase = 'Downturn 2' THEN funding_mn_usd END) AS downturn2_2018,
    MAX(CASE WHEN market_phase = 'Late Cycle' THEN funding_mn_usd END) AS late_2019
FROM phase_totals
WHERE sector IN (
    'Fintech', 'Edtech', 'Healthtech',
    'E-commerce', 'Foodtech', 'SaaS/B2B',
    'Mobility', 'Logistics'
)
GROUP BY sector
ORDER BY late_2019 DESC;
