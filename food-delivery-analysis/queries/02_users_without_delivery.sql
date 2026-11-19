-- Question: Are there users who never received a single delivered order?
-- Approach: Build the list of users with at least one delivered order, then LEFT JOIN all users to it and keep the non-matches (anti-join).

WITH delivered_users AS (
    SELECT DISTINCT kullanici_id
    FROM y_siparisler
    WHERE durum = 'Teslim'
)
SELECT k.kullanici_id, k.ad AS name, k.kayit_tarihi AS signup_date
FROM y_kullanicilar k
LEFT JOIN delivered_users d ON k.kullanici_id = d.kullanici_id
WHERE d.kullanici_id IS NULL;
