/*
================================================================================
Question 5: Customer Loyalty & Repeat Purchase Behavior
================================================================================

Objective / Business KPI:
- Measure **customer loyalty** by analyzing repeat purchase behavior.
- Calculate the **average number of orders per unique customer**.
- Segment customers based on order frequency:
    • New customers (1 order)
    • Occasional customers (2–3 orders)
    • Loyal customers (4–5 orders)
    • Very loyal customers (>5 orders)
- Evaluate the **revenue contribution** of each customer segment.

Limitations:
- Only delivered orders are considered.
- Partial data for 2016 and 2018 may slightly bias loyalty metrics.

Business Questions:
1. What percentage of customers make repeat purchases?
2. What is the **average number of orders per customer**?
3. How are customers distributed across segments (New, Occasional, Loyal, Very Loyal)?
4. What is the **revenue contribution** of each segment?
*/

--AVG_order_per_unique_customer

SELECT AVG(sub.nbr_orders_per_customer) AS avg_orders_per_unique_customer
FROM (
	SELECT 
	  c.customer_unique_id,
	  COUNT(o.order_id) AS nbr_orders_per_customer
	FROM olist_orders o
	JOIN olist_customers c
	  ON o.customer_id = c.customer_id
	GROUP BY c.customer_unique_id
	ORDER BY  COUNT(o.order_id) DESC
) AS sub;

-- Revenu généré par clients unique et la categorie de chaque client

CREATE VIEW customer_segmentation_view AS

SELECT
  c.customer_unique_id,
  COUNT(DISTINCT o.order_id) AS nbr_orders_per_customer,
  SUM(oi.order_item_id * oi.price) AS value_of_all_orders,
  CASE 
    WHEN COUNT(DISTINCT o.order_id) = 1 THEN 'New_customer'
    WHEN COUNT(DISTINCT o.order_id) BETWEEN 2 AND 3 THEN 'Occasional_customer'
    WHEN COUNT(DISTINCT o.order_id) BETWEEN 4 AND 5 THEN 'Loyal_customer'
    WHEN COUNT(DISTINCT o.order_id) > 5 THEN 'Very_Loyal_customer'
    ELSE 'no_orders'
  END AS customer_segmentation
FROM olist_customers c
JOIN olist_orders o ON o.customer_id = c.customer_id
JOIN olist_order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_unique_id;

-- share in percent of each customer_cat_and_revnue_generated_by_each__customer_cat
SELECT
  COUNT(*) FILTER (WHERE customer_segmentation = 'New_customer') * 100.0 / COUNT(*) AS percent_new_customer,
  SUM(value_of_all_orders) FILTER (WHERE customer_segmentation = 'New_customer') AS revenue_new_customer,
  
  COUNT(*) FILTER (WHERE customer_segmentation = 'Occasional_customer') * 100.0 / COUNT(*) AS percent_occasional_customer,
  SUM(value_of_all_orders) FILTER (WHERE customer_segmentation = 'Occasional_customer') AS revenue_occasional_customer,
  
  COUNT(*) FILTER (WHERE customer_segmentation = 'Loyal_customer') * 100.0 / COUNT(*) AS percent_loyal_customer,
  SUM(value_of_all_orders) FILTER (WHERE customer_segmentation = 'Loyal_customer') AS revenue_loyal_customer,
  
  COUNT(*) FILTER (WHERE customer_segmentation = 'Very_Loyal_customer') * 100.0 / COUNT(*) AS percent_very_loyal_customer,
  SUM(value_of_all_orders) FILTER (WHERE customer_segmentation = 'Very_Loyal_customer') AS revenue_very_loyal_customer
  
FROM customer_segmentation_view

