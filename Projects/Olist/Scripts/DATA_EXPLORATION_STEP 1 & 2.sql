-- ===================================================
-- PHASE 1: DATA EXPLORATION AND VALIDATION
-- ===================================================
-- STEP 1: Identify All Tables in the Dataset
-- ===================================================

-- Objective: Understand table structure, size, and sample content

-- List all tables excluding system tables to get an overview

SELECT table_catalog, table_schema, table_name, table_type
FROM information_schema.tables
WHERE table_schema NOT IN ('information_schema', 'pg_catalog');  -- Exclude system tables

-- ===================================================
-- STEP 2: Explore Individual Tables
-- For each table: preview first records, count rows, and count columns
-- ===================================================

-- === Table: olist_customers ===

-- Preview first 10 records
SELECT * FROM olist_customers LIMIT 10;

-- Count total rows
SELECT COUNT(*) AS total_rows FROM olist_customers;

-- Count total columns
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_customers';

-- === Table: olist_geolocation ===
SELECT * FROM olist_geolocation LIMIT 10;
SELECT COUNT(*) AS total_rows FROM olist_geolocation;
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_geolocation';

-- === Table: olist_order_items ===
SELECT * FROM olist_order_items LIMIT 10;
SELECT COUNT(*) AS total_rows FROM olist_order_items;
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_order_items';

-- === Table: olist_order_payments ===
SELECT * FROM olist_order_payments LIMIT 10;
SELECT COUNT(*) AS total_rows FROM olist_order_payments;
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_order_payments';

-- === Table: olist_order_reviews ===
SELECT * FROM olist_order_reviews LIMIT 10;
SELECT COUNT(*) AS total_rows FROM olist_order_reviews;
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_order_reviews';

-- === Table: olist_orders ===
SELECT * FROM olist_orders LIMIT 10;
SELECT COUNT(*) AS total_rows FROM olist_orders;
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_orders';

-- === Table: olist_products ===
SELECT * FROM olist_products LIMIT 10;
SELECT COUNT(*) AS total_rows FROM olist_products;
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_products';

-- === Table: olist_sellers ===
SELECT * FROM olist_sellers LIMIT 10;
SELECT COUNT(*) AS total_rows FROM olist_sellers;
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_sellers';

-- === Table: olist_product_category_name_translation ===
SELECT * FROM olist_product_category_name_translation LIMIT 10;
SELECT COUNT(*) AS total_rows FROM olist_product_category_name_translation;
SELECT COUNT(*) AS total_columns
FROM information_schema.columns
WHERE table_name = 'olist_product_category_name_translation';
