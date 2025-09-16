/*
================================================================================
Question 2: Monthly Orders Analysis (Aug 2016 – Aug 2018)
================================================================================

Objective / Business KPI:
- Calculate the total number of orders placed each month.
- Analyze **monthly growth** in orders.
- Identify **seasonality trends** using a seasonal index.

Limitations:
- All order statuses are included because the focus is on **orders placed**, not only fulfilled ones.
- Late 2016 and post-August 2018 data are excluded due to incomplete records that would bias monthly analysis and seasonality trends.

Business Questions:
1. How many orders are placed each month between August 2016 and August 2018?
2. What is the **month-over-month growth rate** in the number of orders?
3. What are the **seasonality patterns** in orders using the seasonal index (ratio of monthly orders to yearly average)?
*/


WITH base_orders AS (
    -- Calculate the number of orders placed per year and month, excluding 2016 and Sept/Oct 2018
    SELECT 
        EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
        EXTRACT(MONTH FROM order_purchase_timestamp) AS month, 
        COUNT(order_id) AS nbr_orders_placed
    FROM olist_orders 
    WHERE 
        EXTRACT(YEAR FROM order_purchase_timestamp) != 2016
        AND NOT (
            EXTRACT(YEAR FROM order_purchase_timestamp) = 2018 
            AND EXTRACT(MONTH FROM order_purchase_timestamp) IN (9, 10)
        )
    GROUP BY year, month
),

order_growth_rate AS (
    -- Calculate the monthly growth rate of orders compared to the previous month
    SELECT 
        *,
        LAG(nbr_orders_placed) OVER (ORDER BY year, month) AS previous_month_orders,
        ((nbr_orders_placed - LAG(nbr_orders_placed) OVER (ORDER BY year, month)) * 100.0) / 
        NULLIF(LAG(nbr_orders_placed) OVER (ORDER BY year, month), 0) AS monthly_growth_rate
    FROM base_orders
),

average_per_year AS (
    -- Calculate the average monthly orders for each year
    SELECT 
        year,
        AVG(nbr_orders_placed) AS avg_monthly_orders_per_year
    FROM base_orders
    GROUP BY year
    ORDER BY year
), 

seasonal_index AS (
    -- Calculate the seasonal index by dividing the orders for each month by the yearly average
    SELECT 
        bo.year, 
        bo.month, 
        bo.nbr_orders_placed,  
        av.avg_monthly_orders_per_year,
        (bo.nbr_orders_placed / NULLIF(av.avg_monthly_orders_per_year, 0)) AS seasonal_index
    FROM average_per_year av
    JOIN base_orders bo
      ON bo.year = av.year
)

-- Final select to show year, month, orders, monthly growth rate, and seasonal index
SELECT 
    si.year, 
    si.month, 
    si.nbr_orders_placed,  
    ogr.monthly_growth_rate,
	av.avg_monthly_orders_per_year,
    si.seasonal_index
FROM seasonal_index si 
JOIN order_growth_rate ogr  
  ON si.year = ogr.year AND si.month = ogr.month
JOIN average_per_year av
  ON si.year = av.year
ORDER BY si.year, si.month;


