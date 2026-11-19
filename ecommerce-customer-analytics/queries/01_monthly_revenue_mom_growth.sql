-- Question: How does monthly revenue change compared to the previous month?
-- Approach: Aggregate revenue per month in a CTE, fetch the previous month with LAG, compute % change.

WITH monthly AS (
    SELECT strftime('%Y-%m', siparis_tarihi) AS month,
           SUM(tutar)                        AS revenue,
           COUNT(DISTINCT musteri_id)        AS active_customers
    FROM siparisler
    GROUP BY month
),
compared AS (
    SELECT *, LAG(revenue) OVER (ORDER BY month) AS prev_revenue
    FROM monthly
)
SELECT month, revenue, active_customers, prev_revenue,
       ROUND((revenue - prev_revenue) * 100.0 / prev_revenue, 1) AS mom_change_pct
FROM compared
ORDER BY month;
