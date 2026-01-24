--For each region and month, calculate YoY revenue growth (%).

WITH monthly_revenue AS (
    SELECT
        region,
        DATE_TRUNC('month', sale_date) AS month,
        SUM(revenue) AS revenue
    FROM table_ddl.sales
    GROUP BY region, DATE_TRUNC('month', sale_date)
),
yoy_calc AS (
    SELECT
        region,
        month,
        revenue,
        LAG(revenue, 12) OVER (
            PARTITION BY region
            ORDER BY month
        ) AS last_year_revenue
    FROM monthly_revenue
)
SELECT
    region,
    month,
    revenue,
    ROUND(
        (revenue - last_year_revenue) * 100.0 / last_year_revenue,
        2
    ) AS yoy_growth_pct
FROM yoy_calc
WHERE last_year_revenue IS NOT NULL;
