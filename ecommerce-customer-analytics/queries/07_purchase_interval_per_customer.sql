-- Question: How often do repeat customers come back on average?
-- Approach: LAG gives each order's previous order date per customer; average the gaps, excluding first orders (NULL gap).

WITH gaps AS (
    SELECT musteri_id,
           julianday(siparis_tarihi)
             - julianday(LAG(siparis_tarihi) OVER (PARTITION BY musteri_id ORDER BY siparis_tarihi)) AS days_since_prev
    FROM siparisler
)
SELECT g.musteri_id, m.ad AS customer,
       COUNT(*)                         AS repeat_orders,
       ROUND(AVG(g.days_since_prev), 1) AS avg_days_between_orders
FROM gaps g
JOIN musteriler m ON m.musteri_id = g.musteri_id
WHERE g.days_since_prev IS NOT NULL
GROUP BY g.musteri_id, m.ad
ORDER BY avg_days_between_orders;
