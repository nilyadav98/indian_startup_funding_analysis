-- Query 04: Year-over-Year Funding Growth Rate
-- Business question: How did funding grow or shrink each year vs previous year?
-- Concepts: CTE (WITH clause), LAG() window function, growth rate calculation

WITH yearly_totals AS (
    SELECT
        CAST(year AS INTEGER)         AS year,
        COUNT(*)                      AS total_deals,
        ROUND(SUM(amount_usd)/1e6, 1) AS total_funding_mn_usd
    FROM funding_rounds
    WHERE year >= 2012
      AND year <= 2020
      AND amount_usd IS NOT NULL
    GROUP BY year
)
SELECT
    year,
    total_deals,
    total_funding_mn_usd,
    LAG(total_funding_mn_usd, 1) OVER (ORDER BY year)
                                      AS prev_year_funding,
    ROUND(
        (total_funding_mn_usd - LAG(total_funding_mn_usd, 1)
            OVER (ORDER BY year)) * 100.0 /
        LAG(total_funding_mn_usd, 1) OVER (ORDER BY year)
    , 1)                              AS yoy_growth_pct
FROM yearly_totals
ORDER BY year;
