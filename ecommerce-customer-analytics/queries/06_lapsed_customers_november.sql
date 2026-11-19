-- Question: Which customers bought before November but not in November? (Target list for a win-back campaign.)
-- Approach: Two customer lists in CTEs; anti-join with LEFT JOIN ... IS NULL.

WITH before_nov AS (
    SELECT DISTINCT musteri_id
    FROM siparisler
    WHERE siparis_tarihi < '2025-11-01'
),
in_nov AS (
    SELECT DISTINCT musteri_id
    FROM siparisler
    WHERE siparis_tarihi >= '2025-11-01' AND siparis_tarihi < '2025-12-01'
)
SELECT m.musteri_id, m.ad AS customer, m.sehir AS city
FROM before_nov b
LEFT JOIN in_nov n   ON b.musteri_id = n.musteri_id
JOIN musteriler m    ON m.musteri_id = b.musteri_id
WHERE n.musteri_id IS NULL
ORDER BY m.musteri_id;
