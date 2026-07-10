-- ==========================================================
-- E-Commerce Customer Analytics Project
-- Analysis
-- ==========================================================

-- ============================================
-- 1. Monthly Revenue Performance
-- Q: How is revenue and order volume trending month over month?
-- ============================================



WITH order_revenue AS (
    SELECT
        order_id,
        SUM(price + freight_value) AS order_revenue
    FROM order_items
    GROUP BY order_id
)
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(orv.order_revenue), 2) AS total_revenue,
    ROUND(AVG(orv.order_revenue), 2) AS average_order_value
FROM orders o
JOIN order_revenue orv
    ON o.order_id = orv.order_id
WHERE o.order_status = 'delivered'
  AND o.order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-08-31'
GROUP BY order_month
ORDER BY order_month;


-- ============================================
-- 2. Top Product Categories by Revenue
-- Q: Which product categories drive the most revenue?
-- ============================================


SELECT
    COALESCE(p.product_category_name, 'Unknown') AS product_category_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS average_product_price
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY COALESCE(p.product_category_name, 'Unknown')
ORDER BY total_revenue DESC
LIMIT 10;



-- ============================================
-- 3. Customer RFM Analysis (Recency, Frequency, Monetary)
-- Q: What are each customer's recency, frequency, and monetary values?
-- Note: RFM scoring and segmentation performed in Python (see notebook).
-- ============================================


WITH customer_rfm AS (
    SELECT
        o.customer_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(SUM(oi.price + oi.freight_value), 2) AS monetary_value
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY o.customer_id
),
snapshot AS (
    SELECT MAX(order_purchase_timestamp) AS snapshot_date
    FROM orders
    WHERE order_status = 'delivered'
)
SELECT
    c.customer_id,
    EXTRACT(DAY FROM (s.snapshot_date - c.last_purchase_date)) AS recency_days,
    c.frequency,
    c.monetary_value
FROM customer_rfm c
CROSS JOIN snapshot s
ORDER BY c.monetary_value DESC;


-- ============================================
-- 4. Delivery Time vs Customer Reviews
-- Q: Does slower delivery correlate with lower review scores?
-- ============================================


WITH delivery_data AS (
    SELECT
        r.review_score,
        CASE
            WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) <= 7 THEN '0-7 Days'
            WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) <= 14 THEN '8-14 Days'
            WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) <= 21 THEN '15-21 Days'
            WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) <= 30 THEN '22-30 Days'
            ELSE '31+ Days'
        END AS delivery_time_bucket,
        EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) AS delivery_days
    FROM orders o
    JOIN reviews r
        ON o.order_id = r.order_id
    WHERE o.order_status = 'delivered'
)
SELECT
    delivery_time_bucket,
    ROUND(AVG(review_score), 2) AS average_review_score,
    ROUND(AVG(delivery_days), 2) AS average_delivery_days
FROM delivery_data
GROUP BY delivery_time_bucket
ORDER BY
    CASE delivery_time_bucket
        WHEN '0-7 Days' THEN 1
        WHEN '8-14 Days' THEN 2
        WHEN '15-21 Days' THEN 3
        WHEN '22-30 Days' THEN 4
        ELSE 5
    END;


-- ============================================
-- 5. Order Funnel Distribution
-- Q: What percentage of orders fall into each status
--    (delivered, canceled, shipped, etc.)?
-- ============================================


SELECT
    order_status,
    ROUND(
        COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER () * 100,
        2
    ) AS order_percentage
FROM orders
GROUP BY order_status
ORDER BY order_percentage DESC;
