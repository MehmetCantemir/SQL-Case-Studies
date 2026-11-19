# Food Delivery App Performance Analysis (SQL)

**Scenario (simulated):** "YemekYolda" is a food-delivery app. Playing the role of a newly hired data analyst, I was asked by the product manager for a review of the last three months (Sep–Nov 2025): *Are we growing? Which restaurants perform well? Where are the problems?*

**Data:** 3 tables — `y_kullanicilar` (users), `y_restoranlar` (restaurants), `y_siparisler` (orders with `durum` = delivered / cancelled and an optional `kupon`).
**Rule applied throughout:** revenue counts only delivered orders (`durum = 'Teslim'`).

📄 **[Executive summary for the manager →](executive_summary.md)**

---

## 1. Data overview — [query](queries/01_order_status_overview.sql)
| status | orders | order_value | pct_of_orders |
|---|---|---|---|
| Teslim | 50 | 16,075 | 84.7 |
| İptal | 9 | 2,165 | 15.3 |

➡️ **15% of orders are cancelled** (2,165 TL of lost order value).

## 2. Users who never received an order — [query](queries/02_users_without_delivery.sql)
| kullanici_id | name | signup_date |
|---|---|---|
| 15 | Okan | 2025-11-20 |

➡️ One new user's only experience with the app was a cancelled order — a high churn risk. Technique: anti-join (`LEFT JOIN ... IS NULL`).

## 3. Monthly KPIs and growth — [query](queries/03_monthly_kpis_mom_growth.sql)
| month | revenue | delivered_orders | active_users | revenue_per_user | revenue_mom_pct |
|---|---|---|---|---|---|
| 2025-09 | 2,900 | 12 | 6 | 483 | — |
| 2025-10 | 5,145 | 15 | 9 | 572 | 77.4 |
| 2025-11 | 8,030 | 23 | 14 | 574 | 56.1 |

➡️ Revenue nearly **tripled in two months**. Splitting growth into *users × revenue per user* shows that Nov growth came almost entirely from **new users**; spend per user stayed flat at ~570 TL.

## 4. Revenue by cuisine — [query](queries/04_revenue_by_cuisine.sql)
| cuisine | delivered_orders | revenue | avg_basket | revenue_share_pct |
|---|---|---|---|---|
| Uzak Doğu | 11 | 6,030 | 548 | 37.5 |
| Pizza | 18 | 5,580 | 310 | 34.7 |
| Fast Food | 12 | 2,375 | 198 | 14.8 |
| Ev Yemeği | 5 | 1,220 | 244 | 7.6 |
| Salata | 4 | 870 | 218 | 5.4 |

➡️ Two cuisines bring **72% of revenue**. Pizza has the most orders, while Asian (Uzak Doğu) earns more with fewer orders thanks to a basket almost **2× larger**.

## 5. Cancellation rate by restaurant — [query](queries/05_cancellation_rate_by_restaurant.sql)
| restaurant | total_orders | cancelled | cancellation_rate_pct | share_of_all_cancellations_pct |
|---|---|---|---|---|
| Anadolu Sofrası | 8 | 3 | 37.5 | 33.3 |
| Dürümcü Usta | 8 | 3 | 37.5 | 33.3 |
| Yeşil Tabak | 5 | 1 | 20 | 11.1 |
| Burger Durağı | 8 | 1 | 12.5 | 11.1 |
| Sushi Ada | 12 | 1 | 8.3 | 11.1 |
| Napoli Pizza | 18 | 0 | 0 | 0 |

➡️ The problem is **concentrated**: two restaurants account for **two-thirds of all cancellations**, while the busiest restaurant has none. (Yeşil Tabak's 20% is based on only 5 orders — too small a sample to conclude.)

## 6. Coupons and basket size — [query](queries/06_coupon_basket_analysis.sql)
| coupon | delivered_orders | avg_basket |
|---|---|---|
| No coupon | 29 | 346.6 |
| HOSGELDIN | 11 | 299.5 |
| INDIRIM20 | 10 | 273 |


## 7. Is the welcome coupon reaching new customers? — [query](queries/07_welcome_coupon_misuse.sql)
| coupon | used_on_first_order | used_on_later_orders | total_uses |
|---|---|---|---|
| HOSGELDIN | 4 | 9 | 13 |
| INDIRIM20 | 1 | 10 | 11 |

➡️ Lower coupon baskets are expected. The real finding: the **new-customer coupon was used 9 out of 13 times by existing customers** (counted over all orders) — the campaign is missing its target.

## 8. User value segments — [query](queries/08_user_segmentation.sql)
| segment | users | revenue | revenue_share_pct |
|---|---|---|---|
| Regular (500-1499) | 10 | 11,535 | 71.8 |
| Loyal (>= 1500) | 2 | 3,740 | 23.3 |
| Occasional (< 500) | 2 | 800 | 5 |

➡️ Revenue is **not dependent on a few users** (72% comes from 10 regular users), which lowers risk — but only 2 users are truly loyal.

## 9. Top restaurant per month — [query](queries/09_top_restaurant_per_month.sql)
| month | restaurant | delivered_orders | revenue |
|---|---|---|---|
| 2025-09 | Napoli Pizza | 3 | 875 |
| 2025-10 | Napoli Pizza | 8 | 2,545 |
| 2025-11 | Sushi Ada | 7 | 3,770 |

➡️ Leadership moved to Sushi Ada in November: **same number of orders as Napoli (7), almost twice the revenue**. `RANK` is used so that ties would all be shown.

---

## Data quality checks applied
- Cancelled orders excluded from every revenue metric; totals reconciled (cancellations by restaurant sum to 9 = overall count).
- Text filters verified against actual values (`SELECT DISTINCT durum`) — `'İptal'` ≠ `'iptal'`.
- `NULL` coupons labelled with `COALESCE`, not dropped.
- Integer division avoided in rates (`* 100.0`).
