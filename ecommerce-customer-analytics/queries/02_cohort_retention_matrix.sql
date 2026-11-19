-- Question: Of the customers who made their first purchase in a given month, what share came back in later months?
-- Approach: CTE 1 finds each customer's cohort (first purchase month); CTE 2 lists the distinct months each customer was active; CTE 3 computes months since cohort; the final query pivots into a retention matrix with conditional aggregation.

WITH cohorts AS (
    SELECT musteri_id,
           MIN(strftime('%Y-%m', siparis_tarihi)) AS cohort_month
    FROM siparisler
    GROUP BY musteri_id
),
activity AS (
    SELECT DISTINCT musteri_id,
           strftime('%Y-%m', siparis_tarihi) AS order_month
    FROM siparisler
),
joined AS (
    SELECT c.cohort_month, a.musteri_id,
           (CAST(substr(a.order_month, 1, 4) AS INTEGER) * 12 + CAST(substr(a.order_month, 6, 2) AS INTEGER))
         - (CAST(substr(c.cohort_month, 1, 4) AS INTEGER) * 12 + CAST(substr(c.cohort_month, 6, 2) AS INTEGER)) AS month_offset
    FROM cohorts c
    JOIN activity a ON c.musteri_id = a.musteri_id
),
counts AS (
    SELECT cohort_month,
           SUM(CASE WHEN month_offset = 0 THEN 1 ELSE 0 END) AS m0,
           SUM(CASE WHEN month_offset = 1 THEN 1 ELSE 0 END) AS m1,
           SUM(CASE WHEN month_offset = 2 THEN 1 ELSE 0 END) AS m2,
           SUM(CASE WHEN month_offset = 3 THEN 1 ELSE 0 END) AS m3
    FROM joined
    GROUP BY cohort_month
)
SELECT cohort_month,
       m0 AS cohort_size,
       ROUND(m1 * 100.0 / m0, 1) AS month_1_pct,
       ROUND(m2 * 100.0 / m0, 1) AS month_2_pct,
       ROUND(m3 * 100.0 / m0, 1) AS month_3_pct
FROM counts
ORDER BY cohort_month;
