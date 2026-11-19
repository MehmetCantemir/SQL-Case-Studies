-- Question: How are revenue, delivered orders and active users trending month over month?
-- Approach: CTE 1 aggregates delivered orders per month; CTE 2 brings the previous month's revenue with LAG; the final query computes MoM % change and revenue per user.

WITH monthly AS (
    SELECT strftime('%Y-%m', siparis_tarihi) AS month,
           SUM(tutar)                        AS revenue,
           COUNT(*)                          AS delivered_orders,
           COUNT(DISTINCT kullanici_id)      AS active_users
    FROM y_siparisler
    WHERE durum = 'Teslim'
    GROUP BY month
),
compared AS (
    SELECT *,
           LAG(revenue) OVER (ORDER BY month) AS prev_revenue
    FROM monthly
)
SELECT month, revenue, delivered_orders, active_users,
       ROUND(revenue * 1.0 / active_users, 0)                   AS revenue_per_user,
       ROUND((revenue - prev_revenue) * 100.0 / prev_revenue, 1) AS revenue_mom_pct
FROM compared
ORDER BY month;
