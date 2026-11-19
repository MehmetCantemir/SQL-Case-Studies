-- Question: How many users fall into each value segment and how much revenue does each segment bring?
-- Approach: CTE labels each user by total delivered spend (CASE WHEN on SUM); the outer query counts users and sums revenue per segment.

WITH user_spend AS (
    SELECT kullanici_id,
           SUM(tutar) AS total_spend,
           CASE
             WHEN SUM(tutar) >= 1500 THEN 'Loyal (>= 1500)'
             WHEN SUM(tutar) >= 500  THEN 'Regular (500-1499)'
             ELSE 'Occasional (< 500)'
           END AS segment
    FROM y_siparisler
    WHERE durum = 'Teslim'
    GROUP BY kullanici_id
)
SELECT segment,
       COUNT(*)         AS users,
       SUM(total_spend) AS revenue,
       ROUND(SUM(total_spend) * 100.0 / (SELECT SUM(total_spend) FROM user_spend), 1) AS revenue_share_pct
FROM user_spend
GROUP BY segment
ORDER BY revenue DESC;
