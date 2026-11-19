-- Question: Where in the funnel do we lose visitors, and does it differ by device?
-- Approach: Sum the 0/1 step flags per device in a CTE, then compute step-to-step conversion rates (each step divided by the previous one).

WITH funnel AS (
    SELECT cihaz              AS device,
           COUNT(*)           AS sessions,
           SUM(urun_gordu)    AS viewed_product,
           SUM(sepete_ekledi) AS added_to_cart,
           SUM(odeme_yapti)   AS paid
    FROM oturumlar
    GROUP BY cihaz
)
SELECT device, sessions, viewed_product, added_to_cart, paid,
       ROUND(viewed_product * 100.0 / sessions, 1)       AS session_to_view_pct,
       ROUND(added_to_cart  * 100.0 / viewed_product, 1) AS view_to_cart_pct,
       ROUND(paid           * 100.0 / added_to_cart, 1)  AS cart_to_payment_pct
FROM funnel
ORDER BY device;
