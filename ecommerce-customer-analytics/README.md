# E-Commerce Customer Analytics (SQL)

**Scenario (simulated):** "ModaSepet", an online fashion & electronics retailer. The marketing manager wants to understand revenue trends, customer retention, where the purchase funnel leaks and which customers to target.

**Data:** `musteriler` (customers), `siparisler` (orders, Sep–Dec 2025) and `oturumlar` (website sessions with funnel step flags).

---

## 1. Month-over-month revenue — [query](queries/01_monthly_revenue_mom_growth.sql)
| month | revenue | active_customers | prev_revenue | mom_change_pct |
|---|---|---|---|---|
| 2025-09 | 9,390 | 7 | — | — |
| 2025-10 | 10,460 | 10 | 9,390 | 11.4 |
| 2025-11 | 6,390 | 8 | 10,460 | -38.9 |
| 2025-12 | 5,920 | 6 | 6,390 | -7.4 |

➡️ November dropped ~39%. Earlier analysis showed that a few large Electronics orders swing monthly totals — see section 5.

## 2. Cohort retention matrix — [query](queries/02_cohort_retention_matrix.sql)
| cohort_month | cohort_size | month_1_pct | month_2_pct | month_3_pct |
|---|---|---|---|---|
| 2025-09 | 7 | 100 | 57.1 | 28.6 |
| 2025-10 | 3 | 66.7 | 33.3 | 0 |
| 2025-11 | 2 | 50 | 0 | 0 |
| 2025-12 | 2 | 0 | 0 | 0 |

➡️ Read row by row: of the 7 customers acquired in September, 57% were still buying two months later. *Note:* later cohorts have zeros partly because their following months are not in the data yet (no January data) — these are unobserved, not necessarily lost customers.

## 3. Conversion funnel by device — [query](queries/03_conversion_funnel_by_device.sql)
| device | sessions | viewed_product | added_to_cart | paid | session_to_view_pct | view_to_cart_pct | cart_to_payment_pct |
|---|---|---|---|---|---|---|---|
| Masaüstü | 10 | 7 | 4 | 3 | 70 | 57.1 | 75 |
| Mobil | 10 | 8 | 5 | 1 | 80 | 62.5 | 20 |

➡️ Mobile users engage **more** in the first two steps, but only **20% of mobile carts are paid vs. 75% on desktop**. Cart abandonment is a **mobile checkout** problem, not a general one.

## 4. Top customer per month — [query](queries/04_top_customer_per_month.sql)
| month | customer | spend |
|---|---|---|
| 2025-09 | Can | 3,500 |
| 2025-10 | Emre | 4,200 |
| 2025-11 | Emre | 2,600 |
| 2025-12 | Mehmet | 3,100 |


## 5. Electronics dependency by city — [query](queries/05_electronics_share_by_city.sql)
| city | total_revenue | electronics_revenue | electronics_share_pct |
|---|---|---|---|
| Antalya | 6,800 | 6,800 | 100 |
| Ankara | 11,030 | 5,900 | 53.5 |
| İstanbul | 11,130 | 3,500 | 31.4 |
| Bursa | 450 | 0 | 0 |
| Eskişehir | 1,010 | 0 | 0 |
| İzmir | 1,740 | 0 | 0 |

➡️ Combined with section 4: every monthly leader bought Electronics, and the high Electronics share in Antalya and Ankara comes from just two customers. The risk is customer-level concentration, not city-level.

## 6. Win-back list: bought before November, not in November — [query](queries/06_lapsed_customers_november.sql)
| musteri_id | customer | city |
|---|---|---|
| 3 | Zeynep | İzmir |
| 5 | Elif | Bursa |
| 6 | Burak | Ankara |
| 9 | Deniz | İzmir |


## 7. Average days between purchases — [query](queries/07_purchase_interval_per_customer.sql)
| musteri_id | customer | repeat_orders | avg_days_between_orders |
|---|---|---|---|
| 1 | Ayşe | 5 | 18.4 |
| 11 | Kerem | 1 | 21 |
| 2 | Mehmet | 4 | 23.8 |
| 3 | Zeynep | 1 | 26 |
| 7 | Selin | 2 | 27.5 |
| 4 | Can | 2 | 30 |
| 10 | Ahmet | 2 | 30.5 |
| 6 | Burak | 1 | 34 |
| 5 | Elif | 1 | 36 |
| 8 | Emre | 1 | 47 |

➡️ Purchase rhythm differs per customer, so a single churn threshold is crude: 25 days of silence is alarming for Ayşe (~18-day cycle) but normal for Elif (~36 days).

## 8. Recency-based churn flag — [query](queries/08_recency_churn_flag.sql)
| status | customers |
|---|---|
| Active | 8 |
| At risk | 6 |

*(Reference date: 2025-12-31, threshold: 45 days without an order.)*
