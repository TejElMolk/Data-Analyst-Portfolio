-- ===================================================
-- STEP 3: DEFINE PRIMARY AND FOREIGN KEYS
-- Objective: Ensure data integrity by explicitly defining table relationships (PKs and FKs)
-- ===================================================

------------------------------------------------
-- 1. Define Primary Keys (PK)
-- Reason: A Primary Key uniquely identifies each record in a table
------------------------------------------------

-- Set customer_id as primary key in olist_customers
ALTER TABLE olist_customers
ADD CONSTRAINT pk_olist_customers PRIMARY KEY (customer_id);

-- Set order_id as primary key in olist_orders
ALTER TABLE olist_orders
ADD CONSTRAINT pk_olist_orders PRIMARY KEY (order_id);

-- Set product_id as primary key in olist_products
ALTER TABLE olist_products
ADD CONSTRAINT pk_olist_products PRIMARY KEY (product_id);

-- Set seller_id as primary key in olist_sellers
ALTER TABLE olist_sellers
ADD CONSTRAINT pk_olist_sellers PRIMARY KEY (seller_id);


------------------------------------------------
-- 2. Define Foreign Keys (FK)
-- Reason: A Foreign Key ensures referential integrity between related tables
------------------------------------------------

-- Link orders to customers via customer_id
ALTER TABLE olist_orders
ADD CONSTRAINT fk_olist_orders_customers FOREIGN KEY (customer_id)
REFERENCES olist_customers(customer_id);

-- Link order_items to orders via order_id
ALTER TABLE olist_order_items
ADD CONSTRAINT fk_olist_order_items_orders FOREIGN KEY (order_id)
REFERENCES olist_orders(order_id);

-- Link order_items to products via product_id
ALTER TABLE olist_order_items
ADD CONSTRAINT fk_olist_order_items_products FOREIGN KEY (product_id)
REFERENCES olist_products(product_id);

-- Link order_items to sellers via seller_id
ALTER TABLE olist_order_items
ADD CONSTRAINT fk_olist_order_items_sellers FOREIGN KEY (seller_id)
REFERENCES olist_sellers(seller_id);

-- Link order_payments to orders via order_id
ALTER TABLE olist_order_payments
ADD CONSTRAINT fk_olist_order_payments_orders FOREIGN KEY (order_id)
REFERENCES olist_orders(order_id);

-- Link order_reviews to orders via order_id
ALTER TABLE olist_order_reviews
ADD CONSTRAINT fk_olist_order_reviews_orders FOREIGN KEY (order_id)
REFERENCES olist_orders(order_id);
