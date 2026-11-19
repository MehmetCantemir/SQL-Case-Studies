-- Question: Do coupon orders differ from non-coupon orders in basket size?
-- Approach: Group delivered orders by coupon code, labelling NULL as 'No coupon' with COALESCE.

SELECT COALESCE(kupon, 'No coupon') AS coupon,
       COUNT(*)                     AS delivered_orders,
       ROUND(AVG(tutar), 1)         AS avg_basket
FROM y_siparisler
WHERE durum = 'Teslim'
GROUP BY kupon
ORDER BY delivered_orders DESC;
