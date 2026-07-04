# E-Commerce Customer Behavior Analytics

End-to-end customer analytics project analyzing 95,000+ customers and 99,000+ orders from a Brazilian e-commerce marketplace (Olist). This project explores revenue performance, customer retention, product category contribution, delivery efficiency, and customer satisfaction using Python, SQL, and Tableau.

🔗 **[View Interactive Dashboard](https://public.tableau.com/views/E-commerceCustomerAnalyticsDashboard_17818688492380/Dashboard1)**

---

## Business Objective

This analysis was conducted to answer key business questions:

- Is revenue growth sustainable over time?
- Which product categories contribute the most revenue?
- How effectively is the business retaining customers?
- Which customer segments create the highest long-term value?
- How does delivery performance impact customer satisfaction?

The goal was to transform raw transactional data into actionable business insights and identify high-impact growth opportunities.

---

## Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle)

| Metric | Value |
|--------|-------|
| Total Orders | 99,441 |
| Unique Customers | 95,774 |
| Unique Products | 32,951 |
| Relational Tables | 6 |
| Analysis Period | January 2017 – August 2018 |

> Incomplete periods (2016 and Sep–Oct 2018) were excluded to maintain consistency in trend analysis.

| Table | Description |
|-------|-------------|
| orders | Order lifecycle and timestamps |
| customers | Customer identifiers and location |
| order_items | Product-level order transactions |
| products | Product metadata and categories |
| payments | Payment values and methods |
| reviews | Customer review scores |

---

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python (Pandas, NumPy) | Data cleaning and feature engineering |
| Matplotlib, Seaborn | Exploratory visualizations |
| PostgreSQL + DBeaver | Relational schema design and analytical querying |
| Tableau Public | Interactive dashboard development |
| Jupyter Notebook | Analysis workflow and documentation |
| Git + GitHub | Version control |

---

## Project Workflow

**1. Data Cleaning & Preparation**
- Handled missing values across 3 tables
- Removed duplicate review records
- Validated and converted date/time columns
- Identified and excluded incomplete time periods

**2. Feature Engineering**
- Delivery time (days from purchase to delivery)
- Delivery delay (actual vs. estimated delivery date)
- Late delivery flag
- Item-level revenue (price + freight)

**3. Exploratory Data Analysis**
- Monthly revenue, order volume, and Average Order Value trends
- Product category performance by orders and revenue

**4. RFM Customer Segmentation**
- Scored all 95,774 customers on Recency, Frequency, and Monetary value
- Classified into 8 actionable segments: Champion, Loyal Customer, New Customer, Potential Loyalist, Need Attention, At Risk, Cannot Lose Them, Lost

**5. Cohort Retention Analysis**
- Built month-by-month retention matrix across 20 cohorts
- Benchmarked retention rates against e-commerce industry standards

**6. Delivery Performance Analysis**
- Measured delivery time distribution across 6 time buckets
- Quantified the relationship between delivery speed and review scores
- Compared on-time vs. late delivery impact on customer satisfaction

**7. SQL Business Analysis**
- Implemented the relational schema in PostgreSQL
- Translated all core analytical logic into SQL to validate and replicate Python findings

**8. Dashboard Development**
- Built an interactive Tableau dashboard for stakeholder-level reporting covering all key analyses

---

## Key Insights

**1. Revenue quality is declining**
Order volume grew steadily, but Average Order Value declined over time — indicating growth was increasingly driven by lower-value purchases rather than genuine demand expansion.

**2. Beauty is the highest-value category**
Despite Bed/Bath (Cama) having more total orders, the Beauty (Beleza) category generated higher total revenue due to a significantly stronger average price point.

**3. 95% of customers purchase only once**
The average customer transacts 1.03 times, reflecting significantly low repeat purchase behavior.

**4. "Need Attention" is the largest customer segment**
Over 32,000 customers — 33% of the base — fall into this low-engagement, low-spend segment, representing significant untapped retention potential.

**5. The "At Risk" segment drives the most total revenue**
13,384 high-value customers haven't purchased in an average of 394 days. Re-engaging this segment represents one of the highest-value retention opportunities in the business.

**6. Month-one retention is 40x below industry benchmark**
Retention dropped from 100% to 0.5% after the first purchase, compared to an industry benchmark of 20–30%, suggesting the business appears heavily dependent on new customer acquisition for revenue continuity.

**7. Logistics alone does not fully explain customer churn**
A 97.09% successful delivery rate suggests fulfillment failure is not the sole driver of poor retention.

**8. Delivery time directly impacts customer satisfaction**
Review scores declined from 4.33 (0–7 day delivery) to 2.15 (31–60 days), with a clear satisfaction drop after the 21-day mark.

**9. Late deliveries receive 40% lower review scores**
On-time deliveries averaged 4.21★ vs. 2.55★ for late deliveries (avg. 31 days vs. 10 days), affecting 7,658 customers — a measurable reputational and retention risk.

---

## Business Recommendations

- Launch targeted win-back campaigns for the 13,384 At Risk customers — highest revenue recovery potential per customer reached
- Investigate the root drivers of declining Average Order Value (product mix, pricing, promotions)
- Set a 21-day delivery SLA as the customer satisfaction threshold and prioritize logistics improvements for orders trending past it
- Implement automated re-engagement workflows triggered after 60–90 days of customer inactivity
- Increase strategic investment in the Beauty category given its superior revenue-per-order economics

---

## Dashboard

The interactive dashboard presents:
- Revenue and order KPIs (Total Revenue, Total Customers, Avg Review Score)
- Monthly revenue and order trends (2017–2018)
- Product category performance by orders and revenue
- RFM customer segmentation analysis
- Customer retention cohort heatmap
- Delivery time vs. review score analysis

🔗 **[View Live Dashboard](https://public.tableau.com/views/E-commerceCustomerAnalyticsDashboard_17818688492380/Dashboard1)**

---

## Repository Structure

```
ecommerce-customer-analytics/
│
├── notebooks/
│   └── ecommerce_analytics.ipynb    # Full Python analysis
│
├── sql/
│   ├── 01_schema.sql                # Table creation and schema
│   └── 02_analysis.sql              # Business analysis queries
│
├── README.md
└── .gitignore
```

---

## How to Reproduce

**Python Analysis**

```bash
git clone https://github.com/charvisingh245/ecommerce-customer-analytics.git
cd ecommerce-customer-analytics
jupyter notebook notebooks/ecommerce_analytics.ipynb
```

Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) and place the CSV files in a local `data/` folder before running.

**SQL Analysis**

1. Create the schema using `sql/01_schema.sql`
2. Import the Olist CSV files into PostgreSQL
3. Run business queries from `sql/02_analysis.sql`

---

## Author

**Charvi Singh**
Data Analytics | Python | SQL | Tableau

- GitHub: [github.com/charvisingh245](https://github.com/charvisingh245)
- Tableau: [public.tableau.com](https://public.tableau.com/app/profile/charvi.s7329)
