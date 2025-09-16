/*
================================================================================
Question 3: Top-Performing Product Categories (2016 – 2018)
================================================================================

Objective / Business KPI:
- Identify the **top-performing product categories** in terms of total revenue.
- Measure each category's **contribution to overall revenue**.
- Track **quantity sold** and **number of distinct products** per category.
- Compare the **top 10 categories** between 2017 and 2018.
- Measure the **growth in revenue share** per category year-over-year.

Limitations:
- All years (2016–2018) are included, but 2016 and 2018 are partial datasets 
  (2018 stops in August, which may under-represent some categories).
- Only delivered orders are considered.

Business Questions:
1. What are the **top product categories** based on total revenue from 2016 to 2018?
2. How much does each category contribute to the total revenue?
3. How many products are in each category and how much quantity is sold per month?
4. How do the **top 10 categories** evolve between 2017 and 2018?
5. Which categories show the **highest growth in revenue share** year-over-year?
*/



--Quantity_sold_by_category
SELECT 	
        EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
        EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month,
         op.product_category_name_english AS product_category, 
		 SUM(oi.order_item_id) AS quantity_sold
	FROM olist_order_items oi
	JOIN olist_products op ON op.product_id = oi.product_id
	JOIN olist_orders o  ON o.order_id = oi.order_id
	GROUP BY  op.product_category_name_english , 
	          EXTRACT(YEAR FROM o.order_purchase_timestamp),
              EXTRACT(MONTH FROM o.order_purchase_timestamp)
	ORDER BY year, month, quantity_sold DESC

--  Number of Distinct Products per Category

SELECT 
    product_category_name,
    COUNT(DISTINCT product_id) AS nb_produits_distincts
FROM olist_products
GROUP BY product_category_name
ORDER BY nb_produits_distincts DESC;


--Best-selling Categories (2016-2018)_Through_all_years_(from 2016 to 2018)

	SELECT 
		  op.product_category_name_english AS product_category, 
		  SUM(oi.price) AS revenue_per_product
	FROM olist_order_items oi
	JOIN olist_products op
	ON op.product_id = oi.product_id
	GROUP BY  op.product_category_name_english
	ORDER BY revenue_per_product DESC
	LIMIT 10


--For 2017_Revenu_percentage_per_category
WITH revenu_percentage_2017 AS (
	SELECT cat_2017, (revenue_2017 / total_revenue_2017_global ) * 100 as share_of_revenue_per_cat_in_percent_2017
	FROM (
			SELECT 
			    op.product_category_name_english AS cat_2017,
			    SUM(oi.price) AS revenue_2017,
				SUM(SUM(oi.price)) OVER () AS total_revenue_2017_global
			FROM olist_order_items oi
			JOIN olist_products op ON op.product_id = oi.product_id
			JOIN olist_orders o ON o.order_id = oi.order_id
			WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
			GROUP BY op.product_category_name_english
			) as year_2017
	ORDER BY revenue_2017 DESC ),

--For 2018_Revenu_percentage_per_category
revenu_percentage_2018 AS (
	SELECT cat_2018, (revenue_2018 / total_revenue_2018_global ) * 100 as share_of_revenue_per_cat_in_percent_2018
	FROM (
			SELECT 
			    op.product_category_name_english AS cat_2018,
			    SUM(oi.price) AS revenue_2018,
				SUM(SUM(oi.price)) OVER () AS total_revenue_2018_global
			FROM olist_order_items oi
			JOIN olist_products op ON op.product_id = oi.product_id
			JOIN olist_orders o ON o.order_id = oi.order_id
			WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
			GROUP BY op.product_category_name_english
			) as year_2018
	ORDER BY revenue_2018 DESC
	),

--Revenue_Growth_per_Category_(2017 vs 2018) 

Revenue_Growth_per_Category AS (
  SELECT 
    rp17.cat_2017 as category,
    rp17.share_of_revenue_per_cat_in_percent_2017,
    rp18.share_of_revenue_per_cat_in_percent_2018,
    ((rp18.share_of_revenue_per_cat_in_percent_2018 - rp17.share_of_revenue_per_cat_in_percent_2017) / rp17.share_of_revenue_per_cat_in_percent_2017) * 100 AS growth_percentage
  FROM revenu_percentage_2017 rp17
  JOIN revenu_percentage_2018 rp18 ON rp17.cat_2017 = rp18.cat_2018
)

SELECT * 
FROM Revenue_Growth_per_Category
ORDER BY growth_percentage DESC;


--TOP_10_selling_categories_comparison_between_the_year_2017_and_2018_

WITH top_2017 AS (
  SELECT 
    op.product_category_name_english AS cat_2017,
    SUM(oi.price) AS revenue_2017,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price) DESC) AS rn
  FROM olist_order_items oi
  JOIN olist_products op ON op.product_id = oi.product_id
  JOIN olist_orders o ON o.order_id = oi.order_id
  WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
  GROUP BY op.product_category_name_english
  ORDER BY revenue_2017 DESC
  LIMIT 10
),
top_2018 AS (
  SELECT 
    op.product_category_name_english AS cat_2018,
    SUM(oi.price) AS revenue_2018,
    ROW_NUMBER() OVER (ORDER BY SUM(oi.price) DESC) AS rn
  FROM olist_order_items oi
  JOIN olist_products op ON op.product_id = oi.product_id
  JOIN olist_orders o ON o.order_id = oi.order_id
  WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
  GROUP BY op.product_category_name_english
  ORDER BY revenue_2018 DESC
  LIMIT 10
)


SELECT 
  t17.cat_2017, 
  t17.revenue_2017,
  t18.cat_2018,
  t18.revenue_2018
FROM top_2017 t17
FULL OUTER JOIN top_2018 t18 ON t17.rn = t18.rn
ORDER BY COALESCE(t17.rn, t18.rn);



