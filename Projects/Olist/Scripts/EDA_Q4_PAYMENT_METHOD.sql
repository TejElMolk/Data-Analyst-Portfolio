/*
================================================================================
Question 4: Payment Methods Usage & Customer Behavior (2016 – 2018)
================================================================================

Objective / Business KPI:
- Identify the **most commonly used payment methods** on Olist.
- Calculate each method's **usage share (%)** over the period.
- Compare payment method usage between 2017 and 2018.
- Analyze customer behavior per method:
    • Average Order Value (AOV)
    • Average number of installments
    • Average sequential payments

Limitations:
- Only delivered orders are considered.
- 2018 data is limited to August (partial year).

Business Questions:
1. Which **payment methods** are most frequently used on Olist between 2016 and 2018?
2. What is the **share of each method** in the total number of transactions?
3. How do payment methods differ in terms of:
    • Average spending (AOV)
    • Installment frequency
    • Sequential payment usage
4. How does the **distribution of payment methods evolve** between 2017 and 2018?
*/


SELECT
  payment_type,
  COUNT(*) AS nbr_time_payment_method_used,
  100.0 * COUNT(*) / SUM(COUNT(*)) OVER () AS usage_share_percent,
  AVG(payment_value) AS avg_spending,
  AVG(payment_installments) AS avg_installments,
  AVG(payment_sequential) AS avg_sequential
FROM olist_order_payments
GROUP BY payment_type
ORDER BY usage_share_percent DESC;

--usage_share_percent_2017
SELECT
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS order_year,
  op.payment_type,
  COUNT(*) AS nbr_time_payment_method_used,
  100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp)) AS usage_share_percent
FROM olist_order_payments op
JOIN olist_orders o ON o.order_id = op.order_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2017
GROUP BY order_year, op.payment_type
ORDER BY order_year, usage_share_percent DESC;

--usage_share_percent_2018

SELECT
  EXTRACT(YEAR FROM o.order_purchase_timestamp) AS order_year,
  op.payment_type,
  COUNT(*) AS nbr_time_payment_method_used,
  100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp)) AS usage_share_percent
FROM olist_order_payments op
JOIN olist_orders o ON o.order_id = op.order_id
WHERE EXTRACT(YEAR FROM o.order_purchase_timestamp) = 2018
GROUP BY order_year, op.payment_type
ORDER BY order_year, usage_share_percent DESC;



