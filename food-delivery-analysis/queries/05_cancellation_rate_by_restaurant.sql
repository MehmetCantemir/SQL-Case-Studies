-- Question: Is the cancellation problem spread across all restaurants or concentrated in a few?
-- Approach: Conditional aggregation (SUM of CASE WHEN) counts cancellations next to total orders in one pass, so restaurants with zero cancellations are not lost.

WITH restaurant_orders AS (
    SELECT r.restoran_id,
           r.restoran_adi AS restaurant,
           COUNT(*) AS total_orders,
           SUM(CASE WHEN s.durum = 'İptal' THEN 1 ELSE 0 END) AS cancelled
    FROM y_restoranlar r
    JOIN y_siparisler s ON s.restoran_id = r.restoran_id
    GROUP BY r.restoran_id, r.restoran_adi
)
SELECT restaurant, total_orders, cancelled,
       ROUND(cancelled * 100.0 / total_orders, 1) AS cancellation_rate_pct,
       ROUND(cancelled * 100.0 / (SELECT SUM(cancelled) FROM restaurant_orders), 1) AS share_of_all_cancellations_pct
FROM restaurant_orders
ORDER BY cancellation_rate_pct DESC;
