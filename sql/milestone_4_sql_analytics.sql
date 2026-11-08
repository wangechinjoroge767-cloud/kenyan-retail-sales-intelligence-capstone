
-- Jirani Mart Database
-- Milestone 4

-- 1. Check existing tables

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;


-- 2. Create stores table

CREATE TABLE stores (
    store_id VARCHAR(10) PRIMARY KEY,
    store_name VARCHAR(100),
    county VARCHAR(50),
    town VARCHAR(100)
);


-- 3. Create products table

CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    product_category VARCHAR(100)
);


-- 4. Create customers table

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY
);


-- 5. Create sales table

CREATE TABLE sales (
    transaction_id VARCHAR(20),
    transaction_datetime TIMESTAMP,
    transaction_date DATE,
    line_number INTEGER,
    store_id VARCHAR(10),
    customer_id VARCHAR(20),
    product_id VARCHAR(10),
    quantity INTEGER,
    unit_price_kes NUMERIC(12,2),
    gross_sales_kes NUMERIC(12,2),
    promotion VARCHAR(100),
    discount_rate NUMERIC(5,2),
    discount_amount_kes NUMERIC(12,2),
    net_sales_kes NUMERIC(12,2),
    payment_method VARCHAR(50),
    PRIMARY KEY (transaction_id, line_number),
    FOREIGN KEY (store_id)
        REFERENCES stores(store_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


-- 6. Inspect the existing table structures

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN (
      'customers',
      'products',
      'sales',
      'stores'
  )
ORDER BY table_name, ordinal_position;

-- Add missing customer details

ALTER TABLE customers
ADD COLUMN customer_county VARCHAR(100),
ADD COLUMN customer_town VARCHAR(100),
ADD COLUMN customer_segment VARCHAR(50),
ADD COLUMN loyalty_member VARCHAR(20);


-- Add missing store details

ALTER TABLE stores
ADD COLUMN store_type VARCHAR(50),
ADD COLUMN opening_date DATE;

-- Check the data types of all four tables
SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('customers', 'products', 'sales', 'stores')
ORDER BY table_name, ordinal_position;

-- Check the number of records in each table
SELECT 'customers' AS table_name, COUNT(*) AS total_records
FROM customers
UNION ALL
SELECT 'products', COUNT(*)
FROM products
UNION ALL
SELECT 'stores', COUNT(*)
FROM stores
UNION ALL
SELECT 'sales', COUNT(*)
FROM sales;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS toal_products
FROM products;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'sales'
ORDER BY ordinal_position;

SELECT store_id, store_name
FROM stores
ORDER BY store_id;

SELECT COUNT(*) AS total_stores
FROM stores;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'products'
ORDER BY ordinal_position;

ALTER TABLE products
RENAME COLUMN product_category TO category;

ALTER TABLE products
ADD COLUMN standard_unit_price_kes NUMERIC(12,2);

--how much toal revenuee did Jirani Mart generate
SELECT
    SUM(net_sales_kes) AS total_net_sales_kes
FROM sales;

--which payment method generates the most revenue
SELECT
    payment_method,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(net_sales_kes) AS total_net_sales_kes
FROM sales
GROUP BY payment_method
ORDER BY total_net_sales_kes DESC;

--which counties generate the most revenue
SELECT
    st.county,
    COUNT(DISTINCT s.transaction_id) AS total_transactions,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN stores AS st
    ON s.store_id = st.store_id
GROUP BY st.county
ORDER BY total_net_sales_kes DESC;

--which product categories generate the most revenue
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'products'
  AND table_schema = 'public'
ORDER BY ordinal_position;

SELECT
    p.product_category,
    SUM(s.quantity) AS units_sold,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_net_sales_kes DESC;

--which stores generate the most revenue
SELECT
    st.store_name,
    st.county,
    COUNT(DISTINCT s.transaction_id) AS total_transactions,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN stores AS st
    ON s.store_id = st.store_id
GROUP BY st.store_id, st.store_name, st.county
ORDER BY total_net_sales_kes DESC;

--which customer segments generates the most revenue
SELECT
    c.customer_segment,
    COUNT(DISTINCT s.transaction_id) AS total_transactions,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN customers AS c
    ON s.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY total_net_sales_kes DESC;

--what are the monthly sales trendy
SELECT
    EXTRACT(MONTH FROM transaction_date) AS month_number,
    TO_CHAR(transaction_date, 'Month') AS month_name,
    SUM(net_sales_kes) AS total_net_sales_kes,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM sales
GROUP BY
    EXTRACT(MONTH FROM transaction_date),
    TO_CHAR(transaction_date, 'Month')
ORDER BY month_number;

--What is the average transaction value for each payment method
SELECT
    payment_method,
    COUNT(*) AS total_transactions,
    ROUND(AVG(transaction_total), 2) AS average_transaction_value_kes
FROM (
    SELECT
        transaction_id,
        payment_method,
        SUM(net_sales_kes) AS transaction_total
    FROM sales
    GROUP BY transaction_id, payment_method
) AS transaction_summary
GROUP BY payment_method
ORDER BY average_transaction_value_kes DESC;

--Which products generate the most revenue
SELECT
    p.product_name,
    SUM(s.quantity) AS total_units_sold,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_net_sales_kes DESC
LIMIT 10;

--Which products have the highest average selling price
SELECT
    p.product_name,
    SUM(s.quantity) AS total_units_sold,
    ROUND(
        SUM(s.net_sales_kes) / NULLIF(SUM(s.quantity), 0),
        2
    ) AS average_net_price_per_unit_kes
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_net_price_per_unit_kes DESC
LIMIT 10;

--Which stores have the highest average transaction value
SELECT
    st.store_name,
    st.county,
    COUNT(*) AS total_transactions,
    ROUND(AVG(t.transaction_total), 2) AS average_transaction_value_kes
FROM (
    SELECT
        transaction_id,
        store_id,
        SUM(net_sales_kes) AS transaction_total
    FROM sales
    GROUP BY transaction_id, store_id
) AS t
JOIN stores AS st
    ON t.store_id = st.store_id
GROUP BY st.store_id, st.store_name, st.county
ORDER BY average_transaction_value_kes DESC
LIMIT 10;

--Which customer segments have the highest average transaction value
SELECT
    c.customer_segment,
    COUNT(*) AS total_transactions,
    ROUND(AVG(t.transaction_total), 2) AS average_transaction_value_kes
FROM (
    SELECT
        transaction_id,
        customer_id,
        SUM(net_sales_kes) AS transaction_total
    FROM sales
    GROUP BY transaction_id, customer_id
) AS t
JOIN customers AS c
    ON t.customer_id = c.customer_id
GROUP BY c.customer_segment
ORDER BY average_transaction_value_kes DESC;

--How much revenue comes from promotional sales
SELECT
    promotion,
    COUNT(DISTINCT transaction_id) AS total_transactions,
    SUM(net_sales_kes) AS total_net_sales_kes
FROM sales
GROUP BY promotion
ORDER BY total_net_sales_kes DESC;

--What is the monthly revenue by payment method?
SELECT
    EXTRACT(MONTH FROM transaction_date)::INTEGER AS month_number,
    TO_CHAR(transaction_date, 'FMMonth') AS month_name,
    payment_method,
    SUM(net_sales_kes) AS total_net_sales_kes,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM sales
GROUP BY
    EXTRACT(MONTH FROM transaction_date),
    TO_CHAR(transaction_date, 'FMMonth'),
    payment_method
ORDER BY month_number, total_net_sales_kes DESC;

--Which counties have the highest average transaction value?
SELECT
    st.county,
    COUNT(*) AS total_transactions,
    ROUND(AVG(t.transaction_total), 2) AS average_transaction_value_kes
FROM (
    SELECT
        transaction_id,
        store_id,
        SUM(net_sales_kes) AS transaction_total
    FROM sales
    GROUP BY transaction_id, store_id
) AS t
JOIN stores AS st
    ON t.store_id = st.store_id
GROUP BY st.county
ORDER BY average_transaction_value_kes DESC;

--Which products sell the most units?
SELECT
    p.product_name,
    SUM(s.quantity) AS total_units_sold,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC
LIMIT 10;

--Which stores have the lowest revenue?
SELECT
    st.store_name,
    st.county,
    COUNT(DISTINCT s.transaction_id) AS total_transactions,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN stores AS st
    ON s.store_id = st.store_id
GROUP BY st.store_id, st.store_name, st.county
ORDER BY total_net_sales_kes ASC
LIMIT 5;

--Which customers generate the highest total revenue?
SELECT
    c.customer_id,
    c.customer_segment,
    c.customer_county,
    COUNT(DISTINCT s.transaction_id) AS total_transactions,
    SUM(s.net_sales_kes) AS total_spent_kes
FROM sales AS s
JOIN customers AS c
    ON s.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.customer_segment,
    c.customer_county
ORDER BY total_spent_kes DESC
LIMIT 10;

--Which counties have the most customers?
SELECT
    customer_county,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE loyalty_member = 'Yes'
    ) AS loyalty_members
FROM customers
GROUP BY customer_county
ORDER BY total_customers DESC;

--What percentage of customers are loyalty members in each county?
SELECT
    customer_county,
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE loyalty_member = 'Yes'
    ) AS loyalty_members,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loyalty_member = 'Yes'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS loyalty_membership_percentage
FROM customers
GROUP BY customer_county
ORDER BY loyalty_membership_percentage DESC;

--What is the average discount rate by promotion type?
SELECT
    promotion,
    COUNT(*) AS total_sales_lines,
    ROUND(AVG(discount_rate), 2) AS average_discount_rate,
    SUM(discount_amount_kes) AS total_discount_kes,
    SUM(net_sales_kes) AS total_net_sales_kes
FROM sales
GROUP BY promotion
ORDER BY total_discount_kes DESC;

--Which day of the week generates the most revenue?
SELECT
    TO_CHAR(transaction_date, 'FMDay') AS day_of_week,
    EXTRACT(ISODOW FROM transaction_date) AS day_number,
    SUM(net_sales_kes) AS total_net_sales_kes,
    COUNT(DISTINCT transaction_id) AS total_transactions
FROM sales
GROUP BY
    TO_CHAR(transaction_date, 'FMDay'),
    EXTRACT(ISODOW FROM transaction_date)
ORDER BY day_number;

--Which stores offer the highest average discount?
SELECT
    st.store_name,
    st.county,
    ROUND(AVG(s.discount_rate) * 100, 2) AS average_discount_percentage,
    SUM(s.discount_amount_kes) AS total_discount_kes,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN stores AS st
    ON s.store_id = st.store_id
GROUP BY st.store_id, st.store_name, st.county
ORDER BY average_discount_percentage DESC
LIMIT 10;

--Which products receive the largest total discounts?
SELECT
    p.product_name,
    SUM(s.quantity) AS total_units_sold,
    SUM(s.discount_amount_kes) AS total_discount_kes,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_discount_kes DESC
LIMIT 10;

--Which stores have the highest number of loyalty customers making purchases?
SELECT
    st.store_name,
    st.county,
    COUNT(DISTINCT s.customer_id) AS unique_customers,
    COUNT(DISTINCT s.customer_id) FILTER (
        WHERE c.loyalty_member = 'Yes'
    ) AS loyalty_customers,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN stores AS st
    ON s.store_id = st.store_id
JOIN customers AS c
    ON s.customer_id = c.customer_id
GROUP BY st.store_id, st.store_name, st.county
ORDER BY loyalty_customers DESC
LIMIT 10;

--What percentage of each store's customers are loyalty members?
SELECT
    st.store_name,
    st.county,
    COUNT(DISTINCT s.customer_id) AS unique_customers,
    COUNT(DISTINCT s.customer_id) FILTER (
        WHERE c.loyalty_member = 'Yes'
    ) AS loyalty_customers,
    ROUND(
        100.0 * COUNT(DISTINCT s.customer_id) FILTER (
            WHERE c.loyalty_member = 'Yes'
        ) / NULLIF(COUNT(DISTINCT s.customer_id), 0),
        2
    ) AS loyalty_customer_percentage
FROM sales AS s
JOIN stores AS st
    ON s.store_id = st.store_id
JOIN customers AS c
    ON s.customer_id = c.customer_id
GROUP BY st.store_id, st.store_name, st.county
ORDER BY loyalty_customer_percentage DESC;

--Which products have the highest average discount rate?
SELECT
    p.product_name,
    ROUND(AVG(s.discount_rate) * 100, 2) AS average_discount_percentage,
    SUM(s.discount_amount_kes) AS total_discount_kes,
    SUM(s.net_sales_kes) AS total_net_sales_kes
FROM sales AS s
JOIN products AS p
    ON s.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_discount_percentage DESC
LIMIT 10;

--What is the overall loyalty membership rate?
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE loyalty_member = 'Yes'
    ) AS loyalty_members,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE loyalty_member = 'Yes'
        ) / NULLIF(COUNT(*), 0),
        2
    ) AS loyalty_membership_percentage
FROM customers;


-- TASK 1A: MONTHLY REVENUE AND MONTH-ON-MONTH GROWTH
-- Purpose: Use LAG() to compare monthly revenue.


WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', transaction_date)::date AS sales_month,
        SUM(net_sales_kes) AS monthly_revenue
    FROM sales
    GROUP BY DATE_TRUNC('month', transaction_date)
),
sales_growth AS (
    SELECT
        sales_month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    sales_month,
    monthly_revenue,
    previous_month_revenue,
    ROUND(
        100.0 * (monthly_revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_percentage
FROM sales_growth
ORDER BY sales_month;



-- TASK 1B: RANK STORES WITHIN EACH COUNTY
- Identify the highest-performing stores.

WITH store_sales AS (
    SELECT
        st.store_id,
        st.county,
        SUM(s.net_sales_kes) AS total_revenue
    FROM sales s
    JOIN stores st
        ON s.store_id = st.store_id
    GROUP BY
        st.store_id,
        st.county
)
SELECT
    store_id,
    county,
    total_revenue,
    RANK() OVER (
        PARTITION BY county
        ORDER BY total_revenue DESC
    ) AS store_rank
FROM store_sales
ORDER BY
    county,
    store_rank;

-- TASK 1C: RUNNING TOTAL OF SALES REVENUE
-- Calculate cumulative daily revenue.

SELECT
    transaction_date,
    SUM(net_sales_kes) AS daily_revenue,
    SUM(SUM(net_sales_kes)) OVER (
        ORDER BY transaction_date
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_total_revenue
FROM sales
GROUP BY transaction_date
ORDER BY transaction_date;

-- TASK 2: CUSTOMER COHORT ANALYSIS
-- Group customers by their first purchase month
-- and track their return activity in later months.

WITH first_purchase AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(transaction_date))::date
            AS cohort_month
    FROM sales
    GROUP BY customer_id
),
monthly_activity AS (
    SELECT DISTINCT
        customer_id,
        DATE_TRUNC('month', transaction_date)::date
            AS activity_month
    FROM sales
),
cohort_data AS (
    SELECT
        fp.cohort_month,
        ma.activity_month,
        (
            EXTRACT(YEAR FROM ma.activity_month) -
            EXTRACT(YEAR FROM fp.cohort_month)
        ) * 12 +
        (
            EXTRACT(MONTH FROM ma.activity_month) -
            EXTRACT(MONTH FROM fp.cohort_month)
        ) AS months_since_first_purchase,
        COUNT(DISTINCT ma.customer_id) AS active_customers
    FROM first_purchase fp
    JOIN monthly_activity ma
        ON fp.customer_id = ma.customer_id
    GROUP BY
        fp.cohort_month,
        ma.activity_month
),
cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(*) AS cohort_customers
    FROM first_purchase
    GROUP BY cohort_month
)
SELECT
    cd.cohort_month,
    cd.activity_month,
    cd.months_since_first_purchase,
    cs.cohort_customers,
    cd.active_customers,
    ROUND(
        100.0 * cd.active_customers /
        NULLIF(cs.cohort_customers, 0),
        2
    ) AS retention_percentage
FROM cohort_data cd
JOIN cohort_sizes cs
    ON cd.cohort_month = cs.cohort_month
ORDER BY
    cd.cohort_month,
    cd.activity_month;


-- TASK 3: RFM CUSTOMER SEGMENTATION
--  Segment customers using:
-- Recency, Frequency and Monetary value.
-- NTILE() assigns scores from 1 to 5.

WITH customer_rfm AS (
    SELECT
        customer_id,
        MAX(transaction_date) AS last_purchase_date,
        (
            SELECT MAX(transaction_date)
            FROM sales
        ) - MAX(transaction_date) AS recency_days,
        COUNT(DISTINCT transaction_id) AS frequency,
        SUM(net_sales_kes) AS monetary_value
    FROM sales
    GROUP BY customer_id
),
rfm_scores AS (
    SELECT
        customer_id,
        last_purchase_date,
        recency_days,
        frequency,
        monetary_value,

        NTILE(5) OVER (
            ORDER BY recency_days DESC
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary_value ASC
        ) AS monetary_score

    FROM customer_rfm
)
SELECT
    customer_id,
    last_purchase_date,
    recency_days,
    frequency,
    ROUND(monetary_value, 2) AS monetary_value_kes,
    recency_score,
    frequency_score,
    monetary_score,
    (
        recency_score +
        frequency_score +
        monetary_score
    ) AS rfm_total_score,

    CASE
        WHEN recency_score >= 4
             AND frequency_score >= 4
             AND monetary_score >= 4
            THEN 'High Value Customers'

        WHEN recency_score >= 4
             AND frequency_score >= 3
            THEN 'Loyal Customers'

        WHEN recency_score >= 4
             AND frequency_score <= 2
            THEN 'New or Promising Customers'

        WHEN recency_score <= 2
             AND frequency_score >= 3
             AND monetary_score >= 3
            THEN 'At Risk Customers'

        WHEN recency_score <= 2
             AND frequency_score <= 2
            THEN 'Lost or Inactive Customers'

        ELSE 'Regular Customers'
    END AS customer_segment

FROM rfm_scores
ORDER BY rfm_total_score DESC;


-- TASK 4: CORRELATION ANALYSIS
-- Examine relationships between sales variables.
-- CORR() returns a value between -1 and +1.

SELECT
    'Quantity and Net Sales' AS variable_relationship,
    ROUND(
        CORR(quantity::numeric, net_sales_kes),
        4
    ) AS correlation_coefficient
FROM sales

UNION ALL

SELECT
    'Unit Price and Net Sales',
    ROUND(
        CORR(unit_price_kes, net_sales_kes),
        4
    )
FROM sales

UNION ALL

SELECT
    'Discount Rate and Net Sales',
    ROUND(
        CORR(discount_rate, net_sales_kes),
        4
    )
FROM sales

UNION ALL

SELECT
    'Gross Sales and Net Sales',
    ROUND(
        CORR(gross_sales_kes, net_sales_kes),
        4
    )
FROM sales;

-- TASK 5: COVARIANCE ANALYSIS
-- Examine how sales variables change together.
-- Positive covariance means variables tend to move together.
-- Negative covariance means they tend to move in opposite directions.

SELECT
    'Quantity and Net Sales' AS variable_relationship,
    ROUND(
        COVAR_SAMP(quantity::numeric, net_sales_kes),
        4
    ) AS covariance_value
FROM sales

UNION ALL

SELECT
    'Unit Price and Net Sales',
    ROUND(
        COVAR_SAMP(unit_price_kes, net_sales_kes),
        4
    )
FROM sales

UNION ALL

SELECT
    'Discount Rate and Net Sales',
    ROUND(
        COVAR_SAMP(discount_rate, net_sales_kes),
        4
    )
FROM sales

UNION ALL

SELECT
    'Gross Sales and Net Sales',
    ROUND(
        COVAR_SAMP(gross_sales_kes, net_sales_kes),
        4
    )
<<<<<<< HEAD
FROM sales;
=======
FROM sales;
>>>>>>> b1a00a14265a391c0753e91424dd73af6db70d9d
