-- Question: How is revenue distributed across cuisine types?
-- Approach: Join orders to restaurants, aggregate delivered orders per cuisine, then divide each cuisine's revenue by the total (taken with a subquery on the CTE).

WITH cuisine AS (
    SELECT r.mutfak            AS cuisine,
           COUNT(*)            AS delivered_orders,
           SUM(s.tutar)        AS revenue,
           ROUND(AVG(s.tutar)) AS avg_basket
    FROM y_siparisler s
    JOIN y_restoranlar r ON r.restoran_id = s.restoran_id
    WHERE s.durum = 'Teslim'
    GROUP BY r.mutfak
)
SELECT cuisine, delivered_orders, revenue, avg_basket,
       ROUND(revenue * 100.0 / (SELECT SUM(revenue) FROM cuisine), 1) AS revenue_share_pct
FROM cuisine
ORDER BY revenue DESC;
