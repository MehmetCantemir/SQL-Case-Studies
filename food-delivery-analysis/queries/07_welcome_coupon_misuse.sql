-- Question: Is the new-customer coupon (HOSGELDIN) actually used on first orders?
-- Approach: Number each user's orders chronologically with ROW_NUMBER, then count coupon uses on first vs. later orders.

WITH numbered AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY kullanici_id
                              ORDER BY siparis_tarihi, siparis_id) AS order_no
    FROM y_siparisler
)
SELECT kupon AS coupon,
       SUM(CASE WHEN order_no = 1 THEN 1 ELSE 0 END) AS used_on_first_order,
       SUM(CASE WHEN order_no > 1 THEN 1 ELSE 0 END) AS used_on_later_orders,
       COUNT(*)                                      AS total_uses
FROM numbered
WHERE kupon IS NOT NULL
GROUP BY kupon;
