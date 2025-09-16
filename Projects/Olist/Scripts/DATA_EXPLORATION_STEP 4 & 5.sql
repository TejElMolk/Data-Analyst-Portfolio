-- ===================================================
-- STEP 4: IDENTIFY RELATIONSHIPS BETWEEN TABLES
-- Purpose: Detect logical relationships and dependencies to support joins in future analysis
-- Method: Based on Foreign Keys, naming conventions, and shared keys
-- ===================================================

-- olist_orders.customer_id → olist_customers.customer_id
-- olist_order_items.order_id → olist_orders.order_id
-- olist_order_items.product_id → olist_products.product_id
-- olist_order_items.seller_id → olist_sellers.seller_id
-- olist_order_reviews.order_id → olist_orders.order_id
-- olist_order_payments.order_id → olist_orders.order_id
-- olist_products.product_category_name → olist_product_category_name_translation.product_category_name

-- Note:
-- These relationships were implemented as foreign key constraints in Step 3.
-- They are essential for writing accurate JOIN queries in future analysis.
-- This relational structure reflects the full order process: 
-- customer ➝ order ➝ ordered items ➝ products and sellers ➝ payments and reviews.

-- ===================================================
-- STEP 5: IDENTIFYING DATASET COLUMNS, THEIR CHARACTERISTICS, AND DATA QUALITY OBSERVATIONS
-- ===================================================

------------------------------------------------
-- 1. Get Schema Metadata
-- Reason: Identify all columns, their types, and whether they accept NULL values
------------------------------------------------

SELECT 
    table_name, 
    column_name, 
    data_type,  
    is_nullable 
FROM information_schema.columns
WHERE table_schema = 'public';

------------------------------------------------
-- 2. Check for Incorrect Data Types (Text instead of Timestamp)
-- Reason: Some columns that store datetime values are typed as TEXT
------------------------------------------------

SELECT 
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE 
    table_name IN (
        'olist_customers',
        'olist_geolocation',
        'olist_order_items',
        'olist_order_payments',
        'olist_order_reviews',
        'olist_orders',
        'olist_products',
        'olist_sellers',
        'olist_product_category_name_translation'
    )
    AND (
        column_name LIKE '%date%'
        OR (table_name = 'olist_order_reviews' AND column_name = 'review_answer_timestamp')
        OR (table_name = 'olist_orders' AND column_name IN ('order_purchase_timestamp', 'order_approved_at'))
        OR (table_name = 'olist_order_reviews' AND column_name = 'review_creation')
    );

-- Observation:
-- Columns above should be stored as TIMESTAMP for time-based filtering, aggregation, and formatting.

------------------------------------------------
-- 3. Check Data Types for Length and Quantity Columns
-- Reason: Some columns use DOUBLE PRECISION unnecessarily; INT would be more efficient
------------------------------------------------

SELECT 
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'olist_products'
  AND column_name IN (
      'product_name_lenght', 
      'product_description_lenght', 
      'product_photos_qty', 
      'product_weight_g'
  );


-- Observation:
-- These columns store counts or discrete values. Converting them from DOUBLE PRECISION to INTEGER can improve storage and performance.

------------------------------------------------
-- 4. Check Data Type of ZIP Code Columns
-- Reason: ZIP codes should not allow numeric operations — store as TEXT
------------------------------------------------

SELECT 
    column_name,
    data_type
FROM information_schema.columns
WHERE column_name LIKE '%zip%';

-- Observation:
-- Current data type is BIGINT — converting to TEXT is better for identifiers like ZIP codes.

------------------------------------------------
-- 5. Detect Spelling Errors in Column Names
-- Reason: Consistency and clarity — fix "lenght" to "length"
------------------------------------------------

SELECT 
    table_name, 
    column_name
FROM information_schema.columns
WHERE table_name IN (
    'olist_customers',
    'olist_geolocation',
    'olist_order_items',
    'olist_order_payments',
    'olist_order_reviews',
    'olist_orders',
    'olist_products',
    'olist_sellers',
    'olist_product_category_name_translation'
) 
AND column_name LIKE '%lenght%';

-- Observation:
-- Typographical error detected: "lenght" should be renamed to "length" for consistency and clarity.