<p align="center">
  <img src="Images/logo_Olist.png" alt="logo_Olist.png" width="200">
</p>


## I. Introduction

### **Who is Olist?**

Olist is a Brazilian e-commerce platform that connects small and medium-sized sellers to large online marketplaces, enabling them to sell their products across Brazil. It provides tools for order management, logistics, payments, and customer support, helping sellers reach more customers and scale their online business.

### **Project Goal**

The project aims to analyze Olist’s 2016–2018 data to identify key trends and patterns in revenue, orders, customer behavior, product categories, and seller performance. Insights from this analysis were used to provide actionable recommendations for growth, retention, and platform optimization.

### **Dataset**

[*https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download*](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce?resource=download)

### **Content of each dataset**

| **Dataset Name** | **Description** | **Business Context** |
| --- | --- | --- |
| **olist_customers_dataset** | Info about customers and their locations | Managing customer profiles and delivery destinations |
| **olist_geolocation_dataset** | ZIP codes with latitude, longitude, city, and state | Analyzing geographic distribution of orders and sellers |
| **olist_order_items_dataset** | Details of each item in an order | Tracking what products are sold by which sellers |
| **olist_order_payments_dataset** | Payment types, amounts, and installments | Analyzing payment methods and transaction data |
| **olist_order_reviews_dataset** | Customer feedback and ratings on orders | Measuring customer satisfaction and service quality |
| **olist_orders_dataset** | Summary info on each order (status, date) | Tracking order progress and buyer behavior |
| **olist_products_dataset** | Product details and categories | Managing product catalog and category analysis |
| **olist_sellers_dataset** | Seller info and location | Managing seller profiles and marketplace activity |
| **product_category_name_translation** | Translations of product categories from Portuguese to English | Making product categories understandable for analysis |

### **Tools used**

- PostgreSQL for data extraction and manipulation
- Excel pivot tables for detailed analysis
- Looker Studio for dashboards and visualizations


## II. Data Exploration

<details>
<summary>STEP 1 – Identify All Tables in the Dataset</summary><br>

**Objective:** Understand the overall dataset structure and the tables it contains.

- Listed all tables in the database (excluding system tables).  
- Verified table names, types, and schema.

**Key insight:**

The dataset contains the following main tables:

`olist_customers`, `olist_geolocation`, `olist_order_items`, `olist_order_payments`, `olist_order_reviews`, `olist_orders`, `olist_products`, `olist_sellers`, `olist_product_category_name_translation`.

This step ensures a clear overview of the dataset before performing deeper analysis.

**SQL Code:**

  <img src="Images/SQL_code_1.png" alt="SQL" width="800">

</details>

<details>
<summary>STEP 2 – Explore Individual Tables</summary><br>

**Objective:** Explore each table to understand its structure, size, and sample content.

**Actions performed:**

- Previewed the first 10 records of each table to inspect columns and values.  
- Counted total rows to understand table sizes.  
- Counted total columns using `information_schema.columns` to get schema information.

**Observations:**

- The row counts vary significantly between tables (some tables like `olist_orders` and `olist_order_items` are large).  
- Schema is consistent; columns are as expected.  
- No obvious structural issues were found at this stage.  
- Some columns representing dates or timestamps are stored as `TEXT` and may need conversion in later steps.

**Sample SQL Code :**

  <img src="Images/SQL_code_2.png" alt="SQL" width="500">

</details>

<details>
<summary>STEP 3 – Define Primary and Foreign Keys</summary><br>

**Objective:** Ensure data integrity by identifying primary keys (PK) and foreign keys (FK) for the dataset.

**A- Primary Keys Identified:**

| Table | Primary Key | Notes |
| --- | --- | --- |
| `olist_customers` | `customer_id` | Uniquely identifies each customer. |
| `olist_orders` | `order_id` | Uniquely identifies each order. |
| `olist_products` | `product_id` | Uniquely identifies each product. |
| `olist_sellers` | `seller_id` | Uniquely identifies each seller |

**SQL code :**

  <img src="Images/SQL_code_3.png" alt="SQL" width="500">

**Tables without natural PKs:**

- `olist_geolocation`: No single column uniquely identifies a row; multiple rows can share the same zip code, city, state, latitude, or longitude. A composite key or generated ID could enforce uniqueness.  
- `olist_order_items`: Neither `order_id` nor `order_item_id` alone is unique, but their combination is unique. A composite PK could be created if necessary.  
- `olist_order_payments`: No unique identifier exists; a PK isn’t strictly required for analysis.  
- `olist_order_reviews`: Neither `review_id` nor `order_id` alone is unique, but the combination is unique. A composite PK could be used if needed.

**B- Foreign Keys Identified:**

| Table | Foreign Key | References | Description |
| --- | --- | --- | --- |
| `olist_orders` | `customer_id` | `olist_customers.customer_id` | Links each order to the customer who placed it. |
| `olist_order_items` | `order_id` | `olist_orders.order_id` | Associates items with their corresponding orders. |
| `olist_order_items` | `product_id` | `olist_products.product_id` | Identifies the product being sold in each order item. |
| `olist_order_items` | `seller_id` | `olist_sellers.seller_id` | Identifies the seller responsible for each order item. |
| `olist_order_payments` | `order_id` | `olist_orders.order_id` | Links payments to the corresponding order. |
| `olist_order_reviews` | `order_id` | `olist_orders.order_id` | Associates each review with the order it references. |

**SQL code:**

  <img src="Images/SQL_code_4.png" alt="SQL" width="500">

</details>

<details>
<summary>STEP 4 – Identify Relationships Between Tables</summary><br>

**Objective:** Detect logical relationships and dependencies to support future JOIN operations.

**Relationships observed:**

- Customers → Orders → Order Items → Products/Sellers → Payments & Reviews

  <img src="Images/SQL_code_5.png" alt="SQL" width="500">

  <img src="Images/Tab_1.png.png" alt="Tab" width="500">

  <img src="Images/Tab_2.png.png" alt="Tab" width="500">

**Note:**

- These relationships were implemented as foreign keys in STEP 3.  
- Understanding these connections is critical for accurate analytics and relational queries.

</details>

<details>
<summary>STEP 5 – Identify Columns, Their Characteristics, and Data Quality Observations</summary><br>

**Objective:** Examine columns for data types, lengths, and potential issues.

**Key checks and observations:**

1. **Data types**: Some columns storing dates are `TEXT` instead of `TIMESTAMP`.  
2. **Numeric columns**: Lengths, quantities, or counts are sometimes stored as `DOUBLE PRECISION`; converting to `INT` is recommended.  
3. **ZIP codes**: Stored as `BIGINT`, better as `TEXT` to preserve formatting and leading zeros.  
4. **Column names**: Typographical errors found (e.g., `lenght` should be `length`).

These observations will guide data cleaning and type conversion in later steps.

  <img src="Images/SQL_code_6.png" alt="SQL" width="500">

  <img src="Images/SQL_code_7.png" alt="SQL" width="500">

  <img src="Images/SQL_code_8.png" alt="SQL" width="500">

  <img src="Images/SQL_code_9.png" alt="SQL" width="500">

</details>

<details>
<summary>STEP 6 – Identify Missing or Inconsistent Values</summary><br>

**Objective:** Ensure data quality by detecting missing values, duplicates, outliers, and timestamp inconsistencies across all tables.

<details>
<summary>A. Missing Values Analysis</summary><br>

We systematically checked each table for NULL or missing values:

- **olist_customers:** No missing values found.  
- **olist_geolocation:** No missing values found.  
- **olist_order_items:** All columns complete; no missing values.  
- **olist_order_payments:** All columns complete; no missing values.  
- **olist_order_reviews:**  
    - `review_comment_title`: 84% missing  
    - `review_comment_message`: 59% missing  
    - `review_score`, `review_creation_date`, and `review_answer_timestamp` mostly populated.  

> These missing comment fields are retained because the review scores are still valid for analysis.

- **olist_orders:**  
    - `order_approved_at`: 0.16% missing, corresponding to cancelled orders.

> Rows are retained to preserve complete order lifecycle information.

- **olist_products:**  
    - ~1.85% of rows have missing values in some columns (`product_category_name`, dimensions, weight).

> These rows are kept because they are referenced by orders in olist_order_items; removing them would break relational integrity.

- **olist_product_category_name_translation:** No missing values found.  
- **olist_sellers:** No missing values found.

</details>

<details>
<summary>B. Duplicate Detection</summary><br>

We checked for logical duplicates across tables:

- **olist_customers:** Multiple `customer_id` may share the same `customer_unique_id`.

> customer_unique_id represents the actual unique client; for analysis, this is the reference.

- **olist_geolocation:** Identical `(lat, lng, city, state, zip_code_prefix)` rows exist.

> Keep a single row per zip_code_prefix to reduce redundancy.

- **olist_order_items:** No duplicates found for `(order_id, order_item_id)`.  
- **olist_order_payments:** No duplicates found for repeated payments.  
- **olist_order_reviews:**  
    - Some `order_id` have multiple reviews.  
    - Suggested handling:  
        1. 1 `review_id` = 1 `order_id`: keep as-is.  
        2. 1 `review_id` linked to multiple `order_id`: generate new IDs for each pair (e.g., `review_id-1`, `review_id-2`).  
        3. Multiple `review_id` for 1 `order_id`: keep the earliest review, discard others.

- **olist_orders:** No duplicate orders found.  
- **olist_products:** Products with identical characteristics but different `product_id`.

> Only deletable if they are not linked to any order.

- **olist_product_category_name_translation:** No duplicates found.  
- **olist_sellers:** No duplicates found.

</details>

<details>
<summary>C. Outlier and Inconsistency Checks</summary><br>

- **Numeric columns:** Checked for negative values and unreasonable ranges.  
    - `price`, `freight_value`, `payment_value`: all ≥ 0  
    - `product_weight_g`, `product_length_cm`, `product_height_cm`, `product_width_cm`: all ≥ 0  
    - `product_name_length`, `product_description_length`, `product_photos_qty`: reasonable ranges  
    - `payment_installments` and `payment_sequential`: ≥ 0

</details>

<details>
<summary>D. Timestamp and Chronological Consistency</summary><br>

- **Orders:** Ensured logical date sequence:  
    - `order_approved_at` ≥ `order_purchase_timestamp`  
    - `order_delivered_carrier_date` ≥ `order_approved_at`  
    - `order_delivered_customer_date` ≥ `order_delivered_carrier_date`  
    - `order_estimated_delivery_date` ≥ `order_purchase_timestamp`

- **Order items:** `shipping_limit_date` ≥ `order_purchase_timestamp`.  
- **Reviews:**  
    - `review_creation_date` ≥ `order_purchase_timestamp`  
    - `review_answer_timestamp` ≥ `review_creation_date` (if present)

> All anomalies are flagged; rows with inconsistencies can be corrected or excluded if needed.

</details>

<details>
<summary>E. Column Type and Naming Considerations</summary><br>

- Date columns stored as TEXT should be converted to TIMESTAMP for efficient temporal operations.  
- Numeric columns representing counts (e.g., dimensions, weights) should use INT instead of DOUBLE to optimize performance.  
- ZIP codes stored as BIGINT may lose leading zeros; convert to TEXT.  
- Correct typos in column names (e.g., `product_name_lenght` → `product_name_length`).

</details>

**Outcome**

Step 6 confirmed:

- Certain missing values are acceptable due to relational dependencies.  
- Duplicate and inconsistent entries were identified, and strategies were proposed for review IDs and products.  
- No critical outliers found in numeric or timestamp fields.  
- Data types and column naming issues noted for further preprocessing.

> This step ensures that the dataset is clean, consistent, and ready for analysis while maintaining relational integrity.

  <img src="Images/SQL_code_10.png" alt="SQL" width="500">

</details>

---

**With the dataset explored, key relationships mapped, and missing or inconsistent values identified, we are ready to proceed with data cleaning, followed by exploratory data analysis to uncover insights.**

