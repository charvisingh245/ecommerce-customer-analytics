
-- Check which schemas have these tables
SELECT table_schema, table_name 
FROM information_schema.tables 
WHERE table_name IN ('orders', 'customers', 'order_items', 
                     'products', 'payments', 'reviews');


-- Drop existing tables
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS reviews;

-- Drop with schema specified
DROP TABLE IF EXISTS public.reviews;
DROP TABLE IF EXISTS public.orders;

-- Create all tables
CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE customers (
    customer_unique_id VARCHAR(50),
    customer_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

CREATE TABLE products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g DECIMAL(10,2),
    product_length_cm DECIMAL(10,2),
    product_height_cm DECIMAL(10,2),
    product_width_cm DECIMAL(10,2)
);

CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);

CREATE TABLE reviews (
    review_id VARCHAR(100),
    order_id VARCHAR(100),
    review_score INT,
    review_comment_title VARCHAR(1000),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
    review_id VARCHAR(100),
    order_id VARCHAR(100),
    review_score INT,
    review_comment_title VARCHAR(1000),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

COPY reviews (
    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
)
FROM '/Users/apple/Downloads/archive/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER
QUOTE '"'
ESCAPE '"';

SELECT COUNT(*) FROM reviews;
SELECT * FROM reviews LIMIT 5;


SELECT COUNT(*) FROM reviews;

-- Check duplicates
SELECT review_id, COUNT(*) 
FROM reviews 
GROUP BY review_id 
HAVING COUNT(*) > 1
LIMIT 10;

-- Remove duplicates keeping only one row per review_id
DELETE FROM reviews
WHERE ctid NOT IN (
    SELECT MIN(ctid)
    FROM reviews
    GROUP BY review_id
);

-- Verify count after cleanup
SELECT COUNT(*) FROM reviews;


SELECT 
    'orders'      AS table_name, COUNT(*) AS row_count FROM orders
UNION ALL SELECT 'customers',    COUNT(*) FROM customers
UNION ALL SELECT 'order_items',  COUNT(*) FROM order_items
UNION ALL SELECT 'products',     COUNT(*) FROM products
UNION ALL SELECT 'payments',     COUNT(*) FROM payments
UNION ALL SELECT 'reviews',      COUNT(*) FROM reviews;




select order_id,order_purchase_timestamp 
from orders
limit 5;

--query 1 MONTHLY REVENUE TREND

select 
date_trunc('month', o.order_purchase_timestamp ) as order_month,
count(distinct o.order_id) as total_orders,
sum(price + freight_value) as total_revenue,
AVG(p.payment_value) as avg_order_value
from orders o
join order_items oi on o.order_id = oi.order_id
join payments p     on o.order_id = p.order_id
where o.order_status ='delivered'
and o.order_purchase_timestamp BETWEEN '2017-01-01' AND '2018-08-31'
group by order_month 
order by order_month ;



 
--query 2 CATEGORY ANALYSIS

select  p.product_category_name,
count(oi.order_item_id ) as total_orders,
sum(price + freight_value) as total_revenue,
AVG(oi.price) as avg_price
from orders o 
join order_items oi on oi.order_id = o.order_id
join products p   on p.product_id = oi.product_id
where o.order_status ='delivered'
group by p.product_category_name 
order by total_revenue desc
limit 10;



--query 3 RFM SEGMENTATION

select MAX(MAX(o.order_purchase_timestamp))over()-MAX(o.order_purchase_timestamp) as recency,
count(distinct oi.order_item_id) as frequency,
SUM(price + freight_value) as monetary
from orders o
join order_items oi on oi.order_id = o.order_id
where o.order_status ='delivered'
group by o.customer_id
order by monetary desc;


--query 4 DELIVERY VS REVIEWS

select AVG(r.review_score) as avg_review_score,
AVG(o.order_delivered_customer_date - o.order_purchase_timestamp) as avg_delivery_day,
CASE
  WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) <= 7  THEN '0-7 days'
  WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) <= 14 THEN '8-14 days'
  WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) <= 21 THEN '15-21 days'
  WHEN EXTRACT(DAY FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) <= 30 THEN '22-30 days'
  ELSE '31+ days'
end as delivery_bucket
from orders o
join order_items oi on oi.order_id = o.order_id
join reviews r on  r.order_id = o.order_id
where o.order_status ='delivered'
group by delivery_bucket 
order by delivery_bucket ;


--query 5 FUNNEL ANALYSIS	

select  order_status,
round(count(*):: numeric/ sum(count(*)) over () * 100,2) as total_orders
from orders
group by order_status
order by round(count(*):: numeric/ sum(count(*)) over () * 100,2) desc;



































