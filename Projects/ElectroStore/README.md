<p align="center">
  <img src="Images/ElectroStore Logo.png" alt="ElectroStore Logo.png" width="400">
</p>

## I. Introduction / Context

### **About the Dataset**

This dataset contains purchase events from **January 2020 to November 2020** from a **large electronics and home appliances e-commerce store** in an unknown Middle Eastern country. Each row represents a user-product interaction. Prices are shown in USD for convenience. Data was collected by [**Open CDP**](https://rees46.com/en/open-cdp) and can be used freely with proper attribution.

### **Project goal**

The project aims to analyze January–November 2020 data from a large online electronics store to identify key trends and patterns in customer purchase behavior, top-selling products, categories, brands, and purchase frequency. Insights from this analysis can be used to provide actionable recommendations for improving sales performance, customer retention, and overall online store optimization. ### **Content of dataset**

| **Column Name** | **Description** | **Business Context** |
| --- | --- | --- |
| **event_time** | Timestamp of when the event occurred. | Tracks shopping trends and peak activity times. |
| **order_id** | Unique identifier for each order. | Groups items per purchase, used for AOV calculation. |
| **product_id** | Unique identifier for each product. | Enables product-level sales and inventory analysis. |
| **category_id** | Unique identifier for the product category. | Helps measure performance at category level. |
| **category_code** | Readable category and sub-category name (if available). | Useful for category/sub-category insights (e.g., smartphones vs. laptops). |
| **brand** | Brand name (in lowercase, if available). | Used for brand sales tracking and comparison. |
| **price** | Product price at purchase time. | Key for revenue and pricing analysis. |
| **user_id** | Unique identifier for the user. | Enables customer segmentation and retention analysis. |


### **Tools used**

- **Data Preparation:** Used **Excel Power Query** to clean, transform, and structure the dataset.
- **Analysis:** Built **Pivot Tables** connected to Power Query for aggregations, summaries, and initial insights.
- **Visualization:** Created graphs and reports using **Pivot Charts** and the **Excel Data Model** to analyze relationships between variables.
- **Dashboard:** Developed a fully interactive **Excel dashboard** to present key findings and metrics in a clear, user-friendly format.

## II. Data Exploration (Power Query)

- Imported the dataset into **Excel Power Query** and reviewed all **key columns**: `event_time`, `order_id`, `product_model_id`, `category_code`, `price`, `brand`, `user_id`.
- Noticed that **`category_code` combined multiple pieces of information** (main category, sub-category, product name) into a single column, which needed to be split for meaningful analysis.
- Identified **data inconsistencies and anomalies**:
    - `price` stored as text with inconsistent separators (dots/commas).
    - Some rows had **invalid dates** (`event_time = 01/01/1970`) and missing or blank values in key columns (`order_id`, `product_model_id`, `price`).
    - Non-critical missing values were present in columns like `category_name`, `sub_category_name`, `product_name`, `brand_name`, and `user_id`.
    - Inconsistent text formatting in product and brand names (extra spaces, capitalization differences, typos).
- Explored **patterns and distributions** across products, categories, brands, purchase frequency, and purchase time (day of week, hour of day), helping to understand business trends and the structure of the dataset.
- Carefully **documented all observations**, flagging issues that could affect analysis. This step helped plan the **cleaning and transformation process**, including splitting columns, fixing data types, standardizing text, removing corrupted rows, and creating derived columns.
- These insights ensured that, after cleaning, the dataset would be **structured, consistent, and ready for reliable analysis**, supporting Pivot Tables, Data Models, and Excel dashboards for deeper business insights.

## III. Data Cleaning

<details>
<summary>STEP 1 - Date and Time Cleaning</summary><br>

- Removed the `UTC` suffix from the `event_time` column.  
- Converted `event_time` from text to **datetime type**.  
- Filtered out invalid dates (`01/01/1970 00:33:40`) that could not be used in time-based analysis.  
- Created a **date-only column** (`event_time_date`) and derived:  
  - Day of the week  
  - Day number (Monday = 0)  
  - Hour rounded to the nearest hour  

</details>

<details>
<summary>STEP 2 - Price Cleaning</summary><br>

- Standardized price formatting by replacing dots with commas where necessary.  
- Converted `price` to **currency type** for accurate analysis.  

</details>

<details>
<summary>STEP 3 - Category and Product Transformation</summary><br>

- Split `category_code` into three columns:  
  - `category_name` (main category)  
  - `sub_category_name` (subcategory)  
  - `product_name`  
- Renamed `product_id` → `product_model_id` and `brand` → `brand_name`.  

</details>

<details>
<summary>STEP 4 - Handling Missing and Non-Standard Values</summary><br>

- Added `Flag_data` to classify rows:  
  - **Critical Missing Data** → missing essential columns (`event_time`, `order_id`, `product_model_id`, `category_id`, `price`) → **excluded**  
  - **Non-Critical Missing Data** → missing less essential columns (`category_name`, `sub_category_name`, `product_name`, `brand_name`, `user_id`) → **retained for partial analysis**  
  - **Fully Complete** → all columns present and valid  
- Replaced `null` or `"none"` values in text columns with `"Unknown"`.  
- Trimmed whitespace and converted text columns to lowercase for consistent grouping.  

</details>

<details>
<summary>STEP 5 - Filtering and Joining</summary><br>

- Removed rows with **critical missing data** to maintain accuracy.  
- Ensured `user_id` type consistency across tables for reliable joins.  
- Joined with a **user-level analysis table** to enrich the dataset with aggregated metrics:  
  - `Avg_days_between_orders`  
  - `Customer_Category`  
  - `Order_Frequency_Bin`  
  - `BasketSegment`  
  - `favorite_category`  

</details>

<details>
<summary>STEP 6 - Resulting Dataset</summary><br>

- Fully structured, consistent, and ready for analysis.  
- Supports **Pivot Tables**, **Data Models**, and **Excel dashboards** to analyze:  
  - Customer behavior  
  - Product performance  
  - Purchase trends over time  

<img src="Images/Tab Raw & cleaned Data.png" alt="Tab Raw & cleaned Data.png" width="600">


| New Column ElectroStore cleaned | Description |  |
| --- | --- | --- |
| event_time_date | Extracted date from timestamp for easier date-based analysis |  |
| product_model_id | Standardized product identifier for joining and analysis |  |
| category_name / sub_category_name | Readable category info instead of numeric codes |  |
| product_name / brand_name | Human-readable product details for reporting |  |
| price | Converted to numeric/currency for calculations |  |
| Flag_data | Marks missing or special-case data |  |
| Day_Name / Hour_Rounded / Day_Number | Extracted from event_time for time-based analysis |  |
| Avg_days_between_orders | Shows average time between orders per user |  |
| Customer_Category | Categorized users into **Occasional (1 order)**, **Recurrent (2 orders)**, and **Loyal (3+ orders)** based on number of purchases, enabling behavior-based analysis. |  |
| Order_Frequency_Bin | Bucketed users by order frequency |  |
| BasketSegment | Groups users by basket composition/type of purchase |  |
| favorite_category | Most purchased category per user for personalization insights |  |

</details>


## IV. Exploratory Data Analysis (EDA)

### **1. Product & Category analysis**

<details>
<summary><b>Question: Which products or categories generated the most revenue?</b></summary><br>

<table>
  <tr>
    <td>
      <img src="Images/Product_Category_Analysis (1).png" alt="Product_Category_Analysis" width="300">
      <p align="center"><i>Product_Category_Analysis</i></p>
    </td>
    <td>
      <img src="Images/Product_Category_Analysis (2).png" alt="Product_Category_Analysis" width="500">
      <p align="center"><i>Product_Category_Analysis</i></p>
    </td>
  </tr>
</table>

**Key insight:**  
Electronics, appliances, computers, and products labeled as “Unknown” account for 97.32% of total revenue, while the remaining categories contribute only 2.68%, indicating minimal impact. The store’s revenue is heavily reliant on these four categories.

<table>
  <tr>
    <td>
      <img src="Images/Product_Category_Analysis (3).png" alt="Product_Category_Analysis" width="300">
      <p align="center"><i>Product_Category_Analysis</i></p>
    </td>
    <td>
      <img src="Images/Product_Category_Analysis (4).png" alt="Product_Category_Analysis" width="500">
      <p align="center"><i>Product_Category_Analysis</i></p>
    </td>
  </tr>
</table>

</details>  

---

<details>
<summary><b>Question: Which categories were purchased most frequently?</b></summary><br>

<table>
  <tr>
    <td>
      <img src="Images/Product_Category_Analysis (5).png" alt="Product_Category_Analysis" width="500">
      <p align="center"><i>Product_Category_Analysis</i></p>
    </td>
    <td>
      <img src="Images/Product_Category_Analysis (6).png" alt="Product_Category_Analysis" width="500">
      <p align="center"><i>Product_Category_Analysis</i></p>
    </td>
  </tr>
</table>

**Key insight:**  
- Appliances 482290 orders and electronics 464913 orders are the most popular categories and core revenue drivers  
- Unknown 607138 units sold has the highest quantity but may include misclassified products  
- Computers 175293 orders 221383 units and furniture 92845 orders 120468 units show moderate engagement with fewer but larger orders  
- Average units per order: computers ~1.26, furniture ~1.3, indicating customers buy multiple items per order  
- Small categories sport 1806 orders 1891 units, medicine 3349 orders 3363 units, and country_yard 312 orders 315 units have very low customer activity  

</details>  

---

<details>
<summary><b>Question: What is the average value of a customer’s order?</b></summary><br>

  <img src="Images/Product_Category_Analysis (7).png" alt="Product_Category_Analysis" width="300">


**Key insight:**  
- This chart complements the previous analysis of order counts and units sold by adding the dimension of value per order.  
- Electronics 270.45$ and apparel 251.98$ have the highest average baskets, showing they are not only popular but also very profitable per order.  
- Computers 188.32$ and furniture 33.33$ indicate that some less frequent categories have higher or lower average baskets, revealing specific buying behaviors (rare but sometimes costly purchases for computers).  
- Appliances 170.22$ remain popular with moderate baskets, consistent with frequent purchases but lower amounts per order.  
- Small categories like stationery 5.95$ or accessories 19.43$ confirm low average baskets, aligning with low customer activity.  

</details>  

---

<details>
<summary><b>Question: How have sales for products and categories changed over time?</b></summary><br>

<img src="Images/Product_Category_Analysis (8).png" alt="Product_Category_Analysis" width="800">
<br>
<img src="Images/Product_Category_Analysis (9).png" alt="Product_Category_Analysis" width="800">


*Monthly sales are aggregated at the category level to reduce granularity and highlight clear trends, making the analysis easier to interpret.*  

**Key insight:**  
- **Feb–Mar (Early Year):** Sales are mixed; some categories grow while others decline.  
- **April (Spring):** Almost all categories experience a **strong decline**—the lowest point of the year.  
- **May–August (Summer):** Most categories show **moderate to strong growth**, making these the strongest months overall.  
- **July, October–November:** Several categories experience **moderate or strong declines**, suggesting a seasonal slowdown.  
- **September–November:** Overall, sales show a mixed decline, with some categories dropping more than others.  

These patterns suggest that **seasonality plays a role in sales**—customers may buy differently at different times of the year. Overall, **Sport (+73%)** and **Kids (+67%)** are the strongest categories, showing high growth despite volatility, while **Apparel (-1%)** consistently underperforms.  

</details>  

---

### **Product & Category – Recommendations**

- Focus on **top revenue categories**: Electronics, appliances, computers, and Unknown products drive 97% of revenue.  
- **Promote high-value products**: Smartphones (~37% of revenue), refrigerators, notebooks, and TVs.  
- **Leverage mid-range categories**: Computers and furniture have higher units per order (~1.26–1.3); consider cross-selling to increase basket size.  
- **Address low-activity categories**: Sport, medicine, stationery, accessories, country_yard have low orders and small baskets.  
- **Encourage repeat high-value purchases**: Electronics and apparel have the highest average baskets (~$270 and ~$252).  
- **Improve data quality**: Investigate Unknown products for correct classification to enhance insights.  
- **Investigate declining or stagnant categories:** Focus on months where growth % is low or negative (e.g., Apparel, Medicine).  
- **Act on growth trends:** Use the heatmap to identify months and categories with strong growth %, and run promotions during these periods.  
- For categories showing strong growth %, ensure sufficient stock to meet potential increased demand.  


### **2. Frequency of Purchase Analysis**

***Customer Segmentation Overview***

*To better understand purchase behavior, customers were classified into three segments based on their **number of orders**:*

- ***Occasional Customers** – made **only 1 order**.*  
- ***Recurrent Customers** – made **exactly 2 orders**.*  
- ***Loyal Customers** – made **3 or more orders**.*  

*This segmentation allows us to compare purchasing frequency, repeat patterns, and retention rates across different customer types*

<details>
<summary><b>Question: How frequently do loyal and recurrent customers make purchases?</b></summary><br>

<img src="Images/Frequency of Purchase Analysis(1).png" alt="Frequency of Purchase Analysis" width="800">

**Key insight:**  
- **Loyal customers purchase 17% faster** than recurrent customers (25 vs 30 days)  
- Per year Loyal customers buy every 25 days (365 days / 25 days) then they order 14.6 orders VS 12.2 orders (365 days / 30 days) per year for recurrent customers who buy every 30 days  
- **Loyal customers make 2.4 (14.6 - 12.2) more purchases annually so in fine they buy 19.7% more often than recurrent customer**

</details>

---

<details>
<summary><b>Question: When do repeat customers typically make their second purchase?</b></summary><br>

<table>
  <tr>
    <td>
      <img src="Images/Frequency of Purchase Analysis (2).png" alt="Frequency of Purchase Analysis" width="800">
      <p align="center"><i>Frequency of Purchase Analysis</i></p>
    </td>
    <td>
      <img src="Images/Frequency of Purchase Analysis (3).png" alt="Frequency of Purchase Analysis" width="800">
      <p align="center"><i>Frequency of Purchase Analysis</i></p>
    </td>
  </tr>
</table>

**Key insight:**  
- **71–72% of repeat customers** make their second purchase within the **first month**, indicating strong early engagement.  
- However, we observe a sharp drop in repeat purchases, from 72% in month 1 to around 11–20% in month 2. For the electronic store, the second month acts as a critical decision point: if customers do not return during this period, there is a high likelihood that they will never come back, effectively turning into churn.  
- After **10 months or more**, repeat purchases become extremely rare, with only **0.15–0.28% of customers** buying again.

</details>

---

<details>
<summary><b>Question: How does the store perform on customer retention compared to the industry?</b></summary><br>

<img src="Images/Frequency of Purchase Analysis (4).png" alt="Frequency of Purchase Analysis" width="800">

**Key insight:**  
- In general The average e-commerce customer retention rate generally falls between 28% and 30%. The electronic store achieves a 31.8% customer retention rate, meaning nearly 1 in 3 customers return for additional purchases.  
- However, the 68.2% one-time buyer rate represents a significant opportunity for improvement.

</details>

---

### **Frequency of Purchase – Recommendations**

- **Boost early repeat purchases:** Focus on converting first-time buyers in their first month with targeted offers or reminders.  
- **Encourage loyalty:** Implement loyalty programs or incentives to increase purchase frequency and turn recurrent buyers into loyal customers.  
- **Reduce churn after month 2:** Target customers who don’t return in the second month with special promotions or personalized campaigns.  
- **Leverage purchase insights:**  
    - Analyze how often different types of customers buy (e.g., loyal customers every 25 days, recurrent customers every 30 days).  
    - Send promotions, reminders, or personalized offers around the time a customer is likely to make their next purchase to increase conversion.  
    - Stock popular products based on predicted buying cycles to avoid shortages and ensuring availability when customers are most likely to buy.


### **3. Time Analysis**

<details>
<summary><b>Question: How do revenue and order count evolve month by month?</b></summary><br>

  <table>
  <tr>
    <td>
      <img src="Images/Time Analysis(1).png" alt="Time Analysis" width="800">
      <p align="center"><i>Time Analysis</i></p>
    </td>
    <td>
      <img src="Images/Time Analysis (2).png" alt="Frequency of Time Analysis" width="800">
      <p align="center"><i>Time Analysis</i></p>
    </td>
  </tr>
</table>

**Key insight:**  
- **Volume-Driven Business:** When we see order volume drops of -35% to -78% while revenue drops by nearly identical percentages (-39% to -79%), it proves that **customer volume** (how many people buy) controls **revenue performance,** not **customer value** (how much each person spends).  
- **Order Volume & Revenue Correlation:** The two metrics move together almost perfectly - when orders crash, revenue crashes by almost the same percentage. This tight correlation shows the business depends on getting **more customers** rather than getting each customer to **spend more**.  
- **Atypical V-Shaped Recovery:** Two sharp V-shaped recoveries occurred in 2020 - first from March→April crash followed by recovery to June peak, then June→July drop followed by another recovery to August peak - demonstrating unusual market volatility with extreme swings replacing normal seasonal patterns throughout the year *(likely influenced by the COVID-19 period).*  
- **Performant Business Model:** Despite facing significant market fluctuations, the business showed a strong ability to recover quickly after downturns — highlighting both its sensitivity to external shocks and its resilience within the electronics retail sector.

</details>

---

<details>
<summary><b>Question: Which periods show peaks or lows in activity, and which events influence sales?</b></summary><br>

<img src="Images/Time Analysis (3).png" alt="Time Analysis" width="700">

**Key insight:**  
- **Jan–Mar (Q1 – Early Year):** Orders and revenue start strong, with March revenue spiking despite stable orders. Normal early-year consumer behavior; customers purchasing electronics after holidays.  
- **Apr (Q2 – Spring Dip):** Orders plummet and revenue drops to the lowest of the year. COVID-19 lockdowns caused a sharp decline; physical stores were closed and consumer uncertainty was high.  
- **May–Jun (Q2 – Recovery):** Orders and revenue recover quickly (May ~186k orders / €28M, Jun ~326k orders / €45M). **Pent-up demand** as restrictions ease; consumers return to online shopping, often buying high-value electronics for home or work use.  
- **Jul (Q3 – Summer Slowdown):** Orders dip (~151k), reflecting a seasonal summer slowdown compounded by pandemic uncertainty.  
- **Aug–Sep (Q3 – Summer Peak):** Strong growth (Aug ~268k / €52.8M, Sep ~311k / €49.3M). Back-to-school purchases and higher-value electronics drive revenue spikes despite fluctuating order counts.  
- **Oct–Nov (Q4 – Fall Weakness):** Orders decline sharply (Oct ~104k, Nov ~67k). Pandemic waves, supply chain issues, and cautious spending slow pre-holiday purchases.

</details>

---

<details>
<summary><b>Question: On which days and at what hours do customers place the most orders?</b></summary><br>

<img src="Images/Time Analysis (4).png" alt="Time Analysis" width="1000">

**Key insight:**  

**Peak Days:**  
- Saturday generates the highest order volume across all days.  
- Weekend shopping dominates with Friday, Saturday, and Sunday leading, with Tuesday also showing high activity.  
- Thursday consistently shows the lowest customer activity.  

**Peak Hours:**  
- The lunch period from 11 AM to 1 PM represents peak ordering time.  
- Evening hours between 5 PM and 7 PM create a secondary demand surge.  
- Overnight hours from 11 PM to 6 AM show minimal customer engagement.  

**Customer Behavior:**  
- Customers prefer shopping during lunch breaks and after work hours.  
- Two distinct daily peaks indicate office workers and evening shoppers.  
- Weekend ordering patterns suggest leisure time for researching expensive electronics purchases.  

**Shopping Patterns:**  
- Business hours drive the majority of purchase activity.  
- Night-time shows minimal engagement as electronics require careful consideration rather than impulse buying.  
- Consistent patterns suggest customers need daylight hours to research high-value purchases and compare products.

</details>

---

### **Time Analysis – Recommendations**

- Schedule maximum customer service and technical support staff during 10 AM-2 PM lunch rush to handle increased inquiry volume and reduce response times during peak ordering periods.  
- Ensure adequate inventory levels for Friday-Sunday peak periods when customers have extended time to research high-value electronics and require detailed product support.  
- Schedule promotional campaigns and email marketing during 10 AM-2 PM peak hours to maximize engagement when customer activity and conversion potential are highest, while enhancing customer experience through built-in price and model comparison tools for similar electronic products.  
- Implement targeted promotions and special offers on Thursday to boost the consistently low order volume and drive traffic during the week's slowest performance day.  
- Make checkout faster and simpler during lunch hours (10 AM-2 PM) through methods like one-click payment options and guest checkout without account creation, so busy customers can complete purchases quickly without abandoning their carts, which helps maintain high order volumes that drive revenue growth.


### **4. Basket Analysis**

<details>
<summary><b>Question: How do different basket sizes (small, average, large) contribute to overall revenue and order volume?</b></summary><br>

  <img src="Images/Basket_Analysis_1.png" alt="Basket Analysis" width="500">

**Key insight:**  
- Small baskets dominate order flow (62%), but their low AOV ($58 vs. $239 overall) means they contribute very little to overall revenue. This indicates that many customers use the store for quick, low-value purchases such as accessories or small gadgets.  
- Large baskets (26% of orders) generate twice the revenue of average baskets. Although only 1 in 4 customers fall into this segment, they contribute disproportionately to total revenue. This creates a dependency risk: if even a small fraction of these high-value customers churn, the business could face a significant revenue decline.  
- Average baskets (12% of orders) contribute little to both volume and value. This group looks like a ‘middle ground’: small-basket buyers who add one more item, or large-basket buyers who drop one. Tracking this segment helps to see if upselling is working (small baskets moving up) or if high-value customers are buying less (large baskets moving down)  
- Customers buy an average of 1.55 items per order, which is low for an electronics store where purchases are usually bundled (e.g., laptop + case + mouse, or phone + charger + earphones). This shows the store is missing chances to get customers to add more products like higher-value electronics or complementary items.

</details>

---

<details>
<summary><b>Question: How do basket values vary by time of day and day of week, and when are customers most likely to spend more?</b></summary><br>

  <img src="Images/Basket_Analysis_2.png" alt="Basket Analysis" width="500">

**Key insight:**  
- **Daily spending averages cluster tightly between $229-252**, with only a **$23 range across the entire week** - indicating remarkably stable customer behavior regardless of which day they choose to shop.  
- **Weekend spending difference is minimal at $15-25 higher** than weekdays, suggesting customers don't fundamentally change their spending patterns on weekends - they maintain similar basket values whether shopping on Tuesday or Saturday.  
- **Time of day has more impact on basket values than day of week** - early morning hours (3-8) consistently underperform across all days while evening hours show strength, with customer availability driving shopping windows.  
- **Weekdays and weekends both peak around 15h (3PM) and later** but **weekends show higher average values starting from 9AM** - customers shop when their schedules allow rather than waiting for specific days to make larger purchases.  
- **Friday bridges weekday and weekend patterns** with elevated baskets starting at 11h instead of 14h - suggesting customers begin weekend shopping behavior before the actual weekend arrives.  
- **Business operates with predictable time-based patterns rather than day-based volatility** - revenue forecasting should focus on hourly customer availability cycles rather than expecting dramatic weekend vs weekday differences.

</details>

---

<details>
<summary><b>Question: On which days and at what hours do customers place the most orders, and what patterns emerge from their daily shopping behavior?</b></summary><br>

![Basket Analysis](Images/Basket_Analysis_3.png)

**Key insight:**  

**Peak Days:**  
- Saturday generates the highest order volume across all days.  
- Weekend shopping dominates with Friday, Saturday, and Sunday leading, with Tuesday also showing high activity.  
- Thursday consistently shows the lowest customer activity.  

**Peak Hours:**  
- The lunch period from 11 AM to 1 PM represents peak ordering time.  
- Evening hours between 5 PM and 7 PM create a secondary demand surge.  
- Overnight hours from 11 PM to 6 AM show minimal customer engagement.  

**Customer Behavior:**  
- Customers prefer shopping during lunch breaks and after work hours.  
- Two distinct daily peaks indicate office workers and evening shoppers.  
- Weekend ordering patterns suggest leisure time for researching expensive electronics purchases.  

**Shopping Patterns:**  
- Business hours drive the majority of purchase activity.  
- Night-time shows minimal engagement as electronics require careful consideration rather than impulse buying.  
- Consistent patterns suggest customers need daylight hours to research high-value purchases and compare products.

</details>

---

### **Basket Analysis – Recommendations**

- **Shift marketing focus from day-specific to hour-specific campaigns** - since time-of-day impact exceeds day-of-week differences, concentrate promotional spend during consistent peak windows (15h+ daily) rather than weekend-focused advertising. For example : **Launch "Friday Early Bird" promotions starting at 11h** - capitalize on customers beginning weekend shopping behavior a day early to extend high-value shopping windows  
- **Redesign product recommendation systems** - since even peak shopping hours fail to drive basket sizes above 1.67 items, focus on systematic product page improvements with prominent complementary items rather than timing-based strategies  
- **Develop customer retention programs for large basket segment (26% of orders)** - since this small group generates disproportionate revenue, implement VIP programs and personalized experiences to prevent churn that could cause significant revenue decline  
- **Create tiered promotional strategies** - develop different approaches for each basket segment rather than one-size-fits-all campaigns, focusing on moving small baskets up and protecting large basket loyalty to balance revenue sources
