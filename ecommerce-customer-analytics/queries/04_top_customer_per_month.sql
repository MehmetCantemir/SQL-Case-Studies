-- Question: Who was the highest-spending customer in each month?
-- Approach: Aggregate spend per month and customer, rank within each month, keep rank 1 (grouped -> ranked -> filtered pattern).

WITH monthly_customer AS (
    SELECT strftime('%Y-%m', siparis_tarihi) AS month,
           musteri_id,
           SUM(tutar) AS spend
    FROM siparisler
    GROUP BY month, musteri_id
),
ranked AS (
    SELECT *, RANK() OVER (PARTITION BY month ORDER BY spend DESC) AS rnk
    FROM monthly_customer
)
SELECT r.month, m.ad AS customer, r.spend
FROM ranked r
JOIN musteriler m ON m.musteri_id = r.musteri_id
WHERE r.rnk = 1
ORDER BY r.month;
