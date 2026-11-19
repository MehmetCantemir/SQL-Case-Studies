-- Question: In which cities is revenue most dependent on the Electronics category?
-- Approach: Compute total and Electronics revenue side by side with conditional aggregation (cities without Electronics stay in the result with 0), then take the share.

WITH city_revenue AS (
    SELECT m.sehir AS city,
           SUM(s.tutar) AS total_revenue,
           SUM(CASE WHEN s.kategori = 'Elektronik' THEN s.tutar ELSE 0 END) AS electronics_revenue
    FROM siparisler s
    JOIN musteriler m ON m.musteri_id = s.musteri_id
    GROUP BY m.sehir
)
SELECT city, total_revenue, electronics_revenue,
       ROUND(electronics_revenue * 100.0 / total_revenue, 1) AS electronics_share_pct
FROM city_revenue
ORDER BY electronics_share_pct DESC;
