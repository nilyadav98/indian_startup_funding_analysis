-- Query 06: Top Funded Company Per Sector
-- Business question: Which company raised the most in each sector?
-- Concepts: ROW_NUMBER() vs RANK(), PARTITION BY sector

WITH company_sector_total AS (
    SELECT
        startup_name,
        sector,
        COUNT(*)                       AS total_rounds,
        ROUND(SUM(amount_usd)/1e6, 1)  AS total_raised_mn_usd
    FROM funding_rounds
    WHERE sector IS NOT NULL
      AND amount_usd IS NOT NULL
    GROUP BY startup_name, sector
),
ranked AS (
    SELECT
        startup_name,
        sector,
        total_rounds,
        total_raised_mn_usd,
        ROW_NUMBER() OVER (
            PARTITION BY sector
            ORDER BY total_raised_mn_usd DESC
        )                              AS rn
    FROM company_sector_total
)
SELECT
    sector,
    startup_name,
    total_rounds,
    total_raised_mn_usd
FROM ranked
WHERE rn = 1
ORDER BY total_raised_mn_usd DESC;
