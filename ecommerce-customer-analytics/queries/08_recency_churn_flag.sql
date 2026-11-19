-- Question: Which customers are at risk of churning based on days since their last order?
-- Approach: Per customer, take the last order date (MAX) and the days to a reference date with julianday; label with CASE WHEN; count per label.

WITH customer_status AS (
    SELECT musteri_id,
           julianday('2025-12-31') - julianday(MAX(siparis_tarihi)) AS days_since_last_order,
           CASE
             WHEN julianday('2025-12-31') - julianday(MAX(siparis_tarihi)) > 45 THEN 'At risk'
             ELSE 'Active'
           END AS status
    FROM siparisler
    GROUP BY musteri_id
)
SELECT status, COUNT(*) AS customers
FROM customer_status
GROUP BY status;
