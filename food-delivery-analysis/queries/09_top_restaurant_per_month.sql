-- Question: Which restaurant generated the most revenue each month? (Ties must all be shown.)
-- Approach: Aggregate revenue per month and restaurant, rank within each month with RANK (keeps ties), keep rank 1.

WITH monthly_restaurant AS (
    SELECT strftime('%Y-%m', s.siparis_tarihi) AS month,
           r.restoran_adi                      AS restaurant,
           COUNT(*)                            AS delivered_orders,
           SUM(s.tutar)                        AS revenue
    FROM y_siparisler s
    JOIN y_restoranlar r ON s.restoran_id = r.restoran_id
    WHERE s.durum = 'Teslim'
    GROUP BY month, r.restoran_adi
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY revenue DESC) AS rnk
    FROM monthly_restaurant
)
SELECT month, restaurant, delivered_orders, revenue
FROM ranked
WHERE rnk = 1
ORDER BY month;
