# E-commerce Customer Behavior Analytics

End-to-end analysis of 95,000+ customers and 99,000+ orders from a Brazilian e-commerce marketplace (Olist), covering revenue trends, customer segmentation, retention, delivery performance, and review impact — using Python, SQL, and Tableau.

🔗 **[View Interactive Dashboard on Tableau Public](https://public.tableau.com/views/E-commerceCustomerAnalyticsDashboard_17818688492380/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

---

## Business Problem

The business wanted to understand:
- Is revenue growth healthy, and is it being driven by the right factors?
- Which customers and product categories drive the most value?
- Is the business retaining customers, or relying entirely on new acquisition?
- Does delivery performance affect customer satisfaction and reviews?

This project answers those questions using a real-world transactional dataset and translates the findings into specific business recommendations.

---

## Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle)

- 99,441 orders | 95,774 unique customers | 32,951 products | 6 relational tables
- Time range used: January 2017 – August 2018 (2016 and Sep–Oct 2018 excluded due to incomplete data)

| Table | Description |
|---|---|
| orders | Order status and timestamps |
| customers | Customer location data |
| order_items | Line-item level pricing |
| products | Product category and attributes |
| payments | Payment method and value |
| reviews | Post-purchase review scores |

---

## Tools & Tech Stack

- **Python** (Pandas, NumPy, Matplotlib, Seaborn) — data cleaning, feature engineering, EDA, RFM & cohort analysis
- **PostgreSQL + DBeaver** — relational database, SQL analysis
- **Tableau Public** — interactive dashboard
- **Jupyter Notebook** — analysis environment

---

## Methodology

1. **Data Cleaning** — handled missing values across 3 tables, validated data types, removed duplicate review records, and identified/excluded incomplete time periods (2016, Sep–Oct 2018) to avoid skewed trend analysis
2. **Feature Engineering** — built delivery time, delivery-vs-estimate, late-delivery flag, and revenue fields
3. **Exploratory Analysis** — monthly revenue/order trends, category-level performance
4. **RFM Segmentation** — scored all 95,774 customers on Recency, Frequency, Monetary value and classified into 8 actionable segments
5. **Cohort Retention Analysis** — built a month-by-month retention matrix and benchmarked against industry standards
6. **Delivery & Review Analysis** — quantified the relationship between delivery speed and review scores
7. **SQL Replication** — rebuilt all core analyses in PostgreSQL to demonstrate equivalent SQL proficiency
8. **Dashboard** — consolidated all findings into a single interactive Tableau dashboard

---

## Key Insights

**1. Revenue growth is not healthy growth**
Order volume increased over the period, but Average Order Value declined — revenue growth is being diluted by a shift toward lower-value purchases rather than genuine demand growth.

**2. Beleza (Beauty) is the highest-value category**
Despite Cama (Bed/Bath) having more total orders, Beleza generates more total revenue due to a significantly higher average price point — indicating beauty products deserve priority in marketing and inventory investment.

**3. 95% of customers are one-time buyers**
The average customer purchases only 1.03 times. This is a structural retention problem, not a marketing campaign problem.

**4. "Need Attention" is the largest customer segment**
32,094 customers (33% of the base) fall into this low-engagement, low-spend segment.

**5. The "At Risk" segment drives the most total revenue**
13,384 high-value customers haven't purchased in an average of 394 days. Re-engaging this segment represents the single highest-ROI retention opportunity.

**6. Retention collapses to 0.5% after month one**
Industry benchmark for e-commerce month-1 retention is 20–30%. This business sits at 0.5% — a 40x gap — confirming that growth is entirely dependent on new customer acquisition.

**7. Logistics is not the cause of churn**
97.09% of orders are delivered successfully, ruling out fulfillment failure as the primary driver of the retention problem.

**8. Reviews drop sharply after 21 days delivery time**
Average review score falls from 4.33 (0–7 day delivery) to 2.15 (31–60 day delivery) — a clear satisfaction cliff at the 3-week mark.

**9. Late deliveries get 40% lower review scores**
On-time orders average 4.21★ vs. 2.55★ for late orders (avg. 31 days vs. 10 days). The 7,658 late orders represent a direct, measurable reputational and retention risk.

---

## Business Recommendations

- Launch a targeted win-back campaign for the 13,384 "At Risk" customers — highest revenue recovery potential per customer reached
- Investigate the root cause of declining Average Order Value (pricing, product mix, promotions)
- Set a 21-day delivery SLA as a satisfaction threshold and prioritize logistics improvements for orders trending past it
- Build an automated re-engagement flow (email/push) triggered after 60–90 days of customer inactivity
- Increase marketing investment in the Beleza category given its superior revenue-per-order economics

---

## Dashboard Preview

The Tableau dashboard includes:
- KPI overview (Total Revenue, Total Customers, Avg Review Score)
- Monthly revenue & order trend
- Customer segment distribution and revenue contribution
- Delivery time vs. review score analysis
- Full retention cohort heatmap

🔗 **[View Live Dashboard](https://public.tableau.com/views/E-commerceCustomerAnalyticsDashboard_17818688492380/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

---

## Repository Structure

```
ecommerce-analytics/
│
├── data/                          # raw + exported CSV files
├── notebooks/
│   └── ecommerce_analytics.ipynb  # full Python analysis
├── sql/
│   └── analysis_queries.sql       # all SQL queries
├── dashboard/                     # Tableau workbook
├── README.md
└── requirements.txt
```

---

## How to Run This Project

```bash
# Clone the repository
git clone https://github.com/yourusername/ecommerce-analytics.git
cd ecommerce-analytics

# Install dependencies
pip install -r requirements.txt

# Launch Jupyter Notebook
jupyter notebook notebooks/ecommerce_analytics.ipynb
```

For the SQL portion, import the dataset into PostgreSQL and run the queries in `sql/analysis_queries.sql`.

---

## Author

**Belle**
📊 Data Analyst | Python, SQL, Tableau
