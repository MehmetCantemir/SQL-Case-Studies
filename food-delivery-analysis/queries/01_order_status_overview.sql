-- Question: How many orders were placed, and how many were delivered vs. cancelled?
-- Approach: Group all orders by status; count orders and sum their value.

SELECT durum              AS status,
       COUNT(*)           AS orders,
       SUM(tutar)         AS order_value,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM y_siparisler), 1) AS pct_of_orders
FROM y_siparisler
GROUP BY durum;
