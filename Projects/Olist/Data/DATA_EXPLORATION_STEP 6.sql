-- ===================================================
-- STEP 6: IDENTIFYING MISSING OR INCONSISTENT VALUES ACROSS COLUMNS
-- ===================================================

-- ===================================================
-- Purpose A: Checking for NULL values in each table and column
-- ===================================================

-- olist_customers: No missing values found
SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(customer_id)) / COUNT(*), 2) AS null_pct_customer_id,
  ROUND(100.0 * (COUNT(*) - COUNT(customer_unique_id)) / COUNT(*), 2) AS null_pct_customer_unique_id,
  ROUND(100.0 * (COUNT(*) - COUNT(customer_zip_code_prefix)) / COUNT(*), 2) AS null_pct_zip_code_prefix,
  ROUND(100.0 * (COUNT(*) - COUNT(customer_city)) / COUNT(*), 2) AS null_pct_customer_city,
  ROUND(100.0 * (COUNT(*) - COUNT(customer_state)) / COUNT(*), 2) AS null_pct_customer_state
FROM olist_customers;

-- olist_geolocation: No missing values found
SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(geolocation_zip_code_prefix)) / COUNT(*), 2) AS null_pct_geolocation_zip_code_prefix,
  ROUND(100.0 * (COUNT(*) - COUNT(geolocation_lat)) / COUNT(*), 2) AS null_pct_geolocation_lat,
  ROUND(100.0 * (COUNT(*) - COUNT(geolocation_lng)) / COUNT(*), 2) AS null_pct_geolocation_lng,
  ROUND(100.0 * (COUNT(*) - COUNT(geolocation_city)) / COUNT(*), 2) AS null_pct_geolocation_city,
  ROUND(100.0 * (COUNT(*) - COUNT(geolocation_state)) / COUNT(*), 2) AS null_pct_geolocation_state
FROM olist_geolocation;

-- olist_order_items: No missing values found
SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(order_id)) / COUNT(*), 2) AS null_pct_order_id,
  ROUND(100.0 * (COUNT(*) - COUNT(order_item_id)) / COUNT(*), 2) AS null_pct_order_item_id,
  ROUND(100.0 * (COUNT(*) - COUNT(product_id)) / COUNT(*), 2) AS null_pct_product_id,
  ROUND(100.0 * (COUNT(*) - COUNT(seller_id)) / COUNT(*), 2) AS null_pct_seller_id,
  ROUND(100.0 * (COUNT(*) - COUNT(shipping_limit_date)) / COUNT(*), 2) AS null_pct_shipping_limit_date,
  ROUND(100.0 * (COUNT(*) - COUNT(price)) / COUNT(*), 2) AS null_pct_price,
  ROUND(100.0 * (COUNT(*) - COUNT(freight_value)) / COUNT(*), 2) AS null_pct_freight_value
FROM olist_order_items;

-- olist_order_payments: No missing values found
SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(order_id)) / COUNT(*), 2) AS null_pct_order_id,
  ROUND(100.0 * (COUNT(*) - COUNT(payment_sequential)) / COUNT(*), 2) AS null_pct_payment_sequential,
  ROUND(100.0 * (COUNT(*) - COUNT(payment_type)) / COUNT(*), 2) AS null_pct_payment_type,
  ROUND(100.0 * (COUNT(*) - COUNT(payment_installments)) / COUNT(*), 2) AS null_pct_payment_installments,
  ROUND(100.0 * (COUNT(*) - COUNT(payment_value)) / COUNT(*), 2) AS null_pct_payment_value
FROM olist_order_payments;

-- olist_order_reviews: High proportion of missing values in comment fields
-- ~84% missing for review_comment_title, ~59% for review_comment_message
SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(review_id)) / COUNT(*), 2) AS null_pct_review_id,
  ROUND(100.0 * (COUNT(*) - COUNT(order_id)) / COUNT(*), 2) AS null_pct_order_id,
  ROUND(100.0 * (COUNT(*) - COUNT(review_score)) / COUNT(*), 2) AS null_pct_review_score,
  ROUND(100.0 * (COUNT(*) - COUNT(review_comment_title)) / COUNT(*), 2) AS null_pct_review_comment_title,
  ROUND(100.0 * (COUNT(*) - COUNT(review_comment_message)) / COUNT(*), 2) AS null_pct_review_comment_message,
  ROUND(100.0 * (COUNT(*) - COUNT(review_creation_date)) / COUNT(*), 2) AS null_pct_review_creation_date,
  ROUND(100.0 * (COUNT(*) - COUNT(review_answer_timestamp)) / COUNT(*), 2) AS null_pct_review_answer_timestamp
FROM olist_order_reviews;

-- olist_orders: Minor missing values for order_approved_at (0.16%) due to cancelled orders — these rows are retained
-- Keeping cancelled orders as they are essential for analysis

SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(order_id)) / COUNT(*), 2) AS null_pct_order_id,
  ROUND(100.0 * (COUNT(*) - COUNT(customer_id)) / COUNT(*), 2) AS null_pct_customer_id,
  ROUND(100.0 * (COUNT(*) - COUNT(order_status)) / COUNT(*), 2) AS null_pct_order_status,
  ROUND(100.0 * (COUNT(*) - COUNT(order_purchase_timestamp)) / COUNT(*), 2) AS null_pct_order_purchase_timestamp,
  ROUND(100.0 * (COUNT(*) - COUNT(order_approved_at)) / COUNT(*), 2) AS null_pct_order_approved_at,
  ROUND(100.0 * (COUNT(*) - COUNT(order_delivered_carrier_date)) / COUNT(*), 2) AS null_pct_order_delivered_carrier_date,
  ROUND(100.0 * (COUNT(*) - COUNT(order_delivered_customer_date)) / COUNT(*), 2) AS null_pct_order_delivered_customer_date,
  ROUND(100.0 * (COUNT(*) - COUNT(order_estimated_delivery_date)) / COUNT(*), 2) AS null_pct_order_estimated_delivery_date
FROM olist_orders;

-- Quick preview of orders with missing approval dates
SELECT order_id, customer_id , order_status , order_purchase_timestamp, order_approved_at 
FROM olist_orders
WHERE order_approved_at IS NULL;

-- olist_product_category_name_translation: No missing values found
SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(product_category_name)) / COUNT(*), 2) AS null_pct_product_category_name,
  ROUND(100.0 * (COUNT(*) - COUNT(product_category_name_english)) / COUNT(*), 2) AS null_pct_product_category_name_english
FROM olist_product_category_name_translation;

-- olist_products: About 1.85% of rows have missing values but are referenced in olist_order_items
-- These rows are retained to preserve referential integrity and avoid breaking relationships
SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(product_id)) / COUNT(*), 2) AS null_pct_product_id,
  ROUND(100.0 * (COUNT(*) - COUNT(product_category_name)) / COUNT(*), 2) AS null_pct_product_category_name,
  ROUND(100.0 * (COUNT(*) - COUNT(product_name_length)) / COUNT(*), 2) AS null_pct_product_name_length,
  ROUND(100.0 * (COUNT(*) - COUNT(product_description_length)) / COUNT(*), 2) AS null_pct_product_description_length,
  ROUND(100.0 * (COUNT(*) - COUNT(product_photos_qty)) / COUNT(*), 2) AS null_pct_product_photos_qty,
  ROUND(100.0 * (COUNT(*) - COUNT(product_weight_g)) / COUNT(*), 2) AS null_pct_product_weight_g,
  ROUND(100.0 * (COUNT(*) - COUNT(product_length_cm)) / COUNT(*), 2) AS null_pct_product_length_cm,
  ROUND(100.0 * (COUNT(*) - COUNT(product_height_cm)) / COUNT(*), 2) AS null_pct_product_height_cm,
  ROUND(100.0 * (COUNT(*) - COUNT(product_width_cm)) / COUNT(*), 2) AS null_pct_product_width_cm
FROM olist_products;

-- Total number of rows in olist_products
SELECT COUNT(*)
FROM olist_products;

-- Count of rows with at least one NULL value in olist_products
SELECT COUNT(*)
FROM olist_products
WHERE product_id IS NULL
	   OR product_category_name IS NULL
	   OR product_name_length IS NULL
	   OR product_description_length IS NULL
	   OR product_photos_qty IS NULL
	   OR product_weight_g IS NULL
	   OR product_length_cm IS NULL
	   OR product_height_cm IS NULL
	   OR product_width_cm IS NULL;

-- olist_sellers: No missing values found
SELECT
  COUNT(*) AS total_rows,
  ROUND(100.0 * (COUNT(*) - COUNT(seller_id)) / COUNT(*), 2) AS null_pct_seller_id,
  ROUND(100.0 * (COUNT(*) - COUNT(seller_zip_code_prefix)) / COUNT(*), 2) AS null_pct_seller_zip_code_prefix,
  ROUND(100.0 * (COUNT(*) - COUNT(seller_city)) / COUNT(*), 2) AS null_pct_seller_city,
  ROUND(100.0 * (COUNT(*) - COUNT(seller_state)) / COUNT(*), 2) AS null_pct_seller_state
FROM olist_sellers;

-- ===================================================
-- Purpose B: Identify potential duplicates
-- ===================================================

-- Examples: customers, geolocation, order_items, etc.
-- Queries and observations are retained as in original script

-- ===================================================
-- Purpose C: Detecting outliers or inconsistencies
-- ===================================================

-- Examples: negative values, timestamp inconsistencies, order lifecycle checks
-- Queries and observations are retained as in original script

SELECT 
    customer_id, 
    customer_unique_id, 
    customer_zip_code_prefix, 
    customer_city, 
    customer_state
FROM 
    olist_customers
WHERE 
    customer_unique_id IN (
        SELECT customer_unique_id
        FROM olist_customers
        GROUP BY customer_unique_id
        HAVING COUNT(*) > 1
    )
ORDER BY 
    customer_unique_id, customer_id;


-- olist_geolocation: identical coordinates (lat, lng), city, state, and zip_code_prefix
-- The presence of identical rows adds unnecessary redundancy without informational value.
-- Keeping only one unique entry per zip_code_prefix helps optimize geographical data and simplifies its usage.

SELECT 
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state,
    COUNT(*) AS row_count
FROM 
    olist_geolocation
GROUP BY 
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state
HAVING 
    COUNT(*) > 1;


-- olist_order_items: checking for duplicates based on (order_id, order_item_id)
-- No duplicates found — everything looks fine.
SELECT 
    order_id, 
    order_item_id, 
    COUNT(*) AS count
FROM 
    olist_order_items
GROUP BY 
    order_id, order_item_id
HAVING 
    COUNT(*) > 1;


-- olist_order_payments: duplicated payments for the same order_id
-- No duplicates found — everything looks fine.
SELECT 
    order_id, 
    payment_sequential, 
    payment_type, 
    payment_installments, 
    payment_value, 
    COUNT(*) AS count
FROM 
    olist_order_payments
GROUP BY 
    order_id, payment_sequential, payment_type, payment_installments, payment_value
HAVING 
    COUNT(*) > 1;


-- olist_order_reviews: multiple reviews for the same order_id, or identical review texts/dates
-- Some order_ids have more than one review — this needs special handling.
-- Suggested treatment:
-- Case 1: 1 review_id = 1 order_id → keep the same review_id or format as review_id-1
-- Case 2: 1 review_id linked to multiple order_ids → generate a new review_id for each pair (e.g. review_id-1, -2, -3)
-- Case 3: Multiple review_ids for the same order_id → keep only one (e.g. the earliest review) and discard the rest
SELECT 
    order_id, 
    COUNT(*) AS review_count
FROM 
    olist_order_reviews
GROUP BY 
    order_id
HAVING 
    COUNT(*) > 1;


-- olist_orders: duplicated orders (same dates, customers, statuses)
-- No duplicate orders found — everything looks fine.
SELECT 
    customer_id, 
    order_status, 
    order_purchase_timestamp, 
    COUNT(*) AS count
FROM 
    olist_orders
GROUP BY 
    customer_id, order_status, order_purchase_timestamp
HAVING 
    COUNT(*) > 1;


-- olist_products: products with the same characteristics (dimensions, weight, description) but different IDs
-- While some product_id entries are logically duplicates, we cannot remove them from olist_products 
-- unless we verify that they are not referenced in olist_order_items.
-- If not used in any order, they can be safely removed.
SELECT 
    product_id, 
    product_category_name, 
    product_name_lenght, 
    product_description_lenght, 
    product_photos_qty, 
    product_weight_g, 
    product_length_cm, 
    product_height_cm, 
    product_width_cm, 
    COUNT(*) AS count
FROM 
    olist_products
GROUP BY 
    product_category_name, 
    product_name_lenght, 
    product_description_lenght, 
    product_photos_qty, 
    product_weight_g, 
    product_length_cm, 
    product_height_cm, 
    product_width_cm
HAVING 
    COUNT(*) > 1;


-- olist_product_category_name_translation: duplicate or repeated translations for the same category
-- No duplicates found — everything looks fine.
SELECT 
    product_category_name, 
    COUNT(*) AS count
FROM 
    product_category_name_translation
GROUP BY 
    product_category_name
HAVING 
    COUNT(*) > 1;


-- olist_sellers: same seller_id appearing with different cities or zip codes
-- No duplicates found — everything looks fine.
SELECT 
    seller_id, 
    COUNT(DISTINCT seller_zip_code_prefix) AS zip_count, 
    COUNT(DISTINCT seller_city) AS city_count
FROM 
    olist_sellers
GROUP BY 
    seller_id
HAVING 
    zip_count > 1 OR city_count > 1;



-- ===================================================
-- Purpose C: Detecting outliers or inconsistencies
-- ===================================================

-- Identify numerical columns (useful for exploring outliers)
SELECT table_name, column_name, data_type  
FROM information_schema.columns
WHERE table_schema = 'public'
  AND data_type IN ('double precision', 'bigint', 'integer')
ORDER BY table_name, column_name;

-- Negative prices or monetary values --
-- No anomalies found in prices, payments, or freight values (i.e., no negative amounts).
SELECT price 
FROM olist_order_items
WHERE price < 0;

SELECT payment_value 
FROM olist_order_payments
WHERE payment_value < 0;

SELECT freight_value 
FROM olist_order_items
WHERE freight_value < 0;

-- Product weight --
-- Check for negative weights, which are not possible and indicate errors.
SELECT product_weight_g
FROM olist_products
WHERE product_weight_g < 0;

-- Product dimensions --
-- Ensure that no dimensions (length, height, width, weight) are negative, which would be invalid.
SELECT *
FROM olist_products
WHERE product_length_cm < 0
   OR product_height_cm < 0
   OR product_width_cm < 0
   OR product_weight_g < 0;

-- Incoherent quantities --

-- Negative product description length is logically impossible.
SELECT product_description_length
FROM olist_products
WHERE product_description_length < 0;

-- Product name length should be within a reasonable range (e.g., between 5 and 100 characters).
-- This query checks for outliers that are too long or mistakenly large.
SELECT product_name_length
FROM olist_products
WHERE product_name_length > 5 AND product_name_length > 100;

-- Negative number of photos is invalid.
SELECT product_photos_qty
FROM olist_products
WHERE product_photos_qty < 0;

-- Negative order item IDs are invalid and should be checked.
SELECT order_item_id
FROM olist_order_items
WHERE order_item_id < 0;

-- Inconsistent payment information --

-- Payment installments must be 0 or positive.
SELECT payment_installments
FROM olist_order_payments
WHERE payment_installments < 0;

-- Sequential payment number should never be negative.
SELECT payment_sequential
FROM olist_order_payments
WHERE payment_sequential < 0;

-- Identify all timestamp columns in the database --
-- Useful for reviewing time-based logic and ensuring chronological consistency.
SELECT table_name, column_name, data_type  
FROM information_schema.columns
WHERE table_schema = 'public'
AND data_type IN ('timestamp without time zone')
ORDER BY table_name, column_name; 

-- Identify inconsistent date sequences in the order lifecycle --
-- Example anomalies:
-- - Approval date before purchase date
-- - Carrier delivery before approval
-- - Customer delivery before carrier delivery
-- - Estimated delivery before purchase
SELECT 
  order_id,
  order_purchase_timestamp,
  order_approved_at,
  order_delivered_carrier_date,
  order_delivered_customer_date,
  order_estimated_delivery_date,
  CASE 
    WHEN order_approved_at < order_purchase_timestamp THEN 'Approval before purchase (inconsistency)'
    WHEN order_delivered_carrier_date < order_approved_at THEN 'Delivery to carrier before approval (inconsistency)'
    WHEN order_delivered_customer_date < order_delivered_carrier_date THEN 'Customer delivery before carrier delivery (inconsistency)'
    WHEN order_estimated_delivery_date < order_purchase_timestamp THEN 'Estimated delivery date before purchase (inconsistency)'
    ELSE 'OK'
  END AS incoherent_data
FROM olist_orders
WHERE order_approved_at < order_purchase_timestamp
   OR order_delivered_carrier_date < order_approved_at
   OR order_delivered_customer_date < order_delivered_carrier_date
   OR order_estimated_delivery_date < order_purchase_timestamp;

-- For olist_order_items: check that shipping_limit_date is not earlier than order purchase date --
SELECT oi.order_id, oi.shipping_limit_date, o.order_purchase_timestamp
FROM olist_order_items oi
JOIN olist_orders o ON oi.order_id = o.order_id
WHERE oi.shipping_limit_date < o.order_purchase_timestamp;

-- For olist_order_reviews: check that review creation happens after order purchase, 
-- and that the review answer (if present) comes after the review was created --
SELECT
  r.review_id,
  r.order_id,
  r.review_creation_date,
  r.review_answer_timestamp,
  o.order_purchase_timestamp,
  CASE
    WHEN r.review_creation_date < o.order_purchase_timestamp THEN
      'Inconsistency: review creation date is before order purchase date'
    WHEN r.review_answer_timestamp IS NOT NULL AND r.review_answer_timestamp < r.review_creation_date THEN
      'Inconsistency: review answer date is before review creation date'
    ELSE 'Dates are consistent'
  END AS inconsistency_comment
FROM olist_order_reviews r
JOIN olist_orders o ON r.order_id = o.order_id
WHERE
  r.review_creation_date < o.order_purchase_timestamp
  OR (r.review_answer_timestamp IS NOT NULL AND r.review_answer_timestamp < r.review_creation_date);



































