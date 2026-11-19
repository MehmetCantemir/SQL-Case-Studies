# SQL Case Studies

Two end-to-end SQL analytics case studies built on realistic **sample datasets** (Turkish-language table and column names). Each project starts from business questions a manager would ask, answers them with SQL, and ends with findings and recommendations.

| Project | Business context | Techniques |
|---|---|---|
| [Food Delivery App Performance Analysis](food-delivery-analysis/) | 3 months of users, restaurants and orders of a food-delivery app | Multi-step CTEs, `RANK` / `LAG` / `ROW_NUMBER`, conditional aggregation, anti-joins, segmentation, executive summary |
| [E-Commerce Customer Analytics](ecommerce-customer-analytics/) | 4 months of e-commerce orders + website sessions | Cohort retention matrix, conversion funnel by device, MoM growth, recency-based churn flags, top-N per group |

## Skills demonstrated

- **SQL:** `JOIN` / `LEFT JOIN`, `GROUP BY` / `HAVING`, subqueries, chained CTEs (`WITH`)
- **Window functions:** `ROW_NUMBER`, `RANK`, `LAG`, running totals, `PARTITION BY`
- **Conditional aggregation:** `SUM(CASE WHEN ...)` for pivots and side-by-side metrics
- **Dates & data quality:** `strftime`, `julianday`, `COALESCE`, `NULL` handling, excluding cancelled orders, reconciling totals
- **Analysis:** month-over-month growth decomposition, cohort retention, funnel conversion, customer segmentation, churn risk
- **Communication:** turning query results into a short, recommendation-driven executive summary

## How to run

The queries are written for **SQLite**. No installation needed:

1. Open [sqliteonline.com](https://sqliteonline.com) (or any SQLite client / DB Browser for SQLite).
2. Paste and run the project's `data/schema_and_data.sql` to create the tables.
3. Run any file in `queries/`. Each file starts with the business question and the approach.

## Repository structure

```
SQL-Case-Studies/
├── food-delivery-analysis/
│   ├── README.md                 # questions, results, findings
│   ├── executive_summary.md      # manager-facing summary (EN + TR)
│   ├── data/schema_and_data.sql
│   └── queries/01_...09_*.sql
└── ecommerce-customer-analytics/
    ├── README.md
    ├── data/schema_and_data.sql
    └── queries/01_...08_*.sql
```

> The datasets are synthetic and were created for practice; they do not belong to a real company.

---
*Author: Mehmet Cantemir · [LinkedIn](https://linkedin.com/in/mehmet-cantemir-64000a190)*
