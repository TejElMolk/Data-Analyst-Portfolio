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
<summary>STEP 1 - Date and Time Cleaning</summary>

- Removed the `UTC` suffix from the `event_time` column.  
- Converted `event_time` from text to **datetime type**.  
- Filtered out invalid dates (`01/01/1970 00:33:40`) that could not be used in time-based analysis.  
- Created a **date-only column** (`event_time_date`) and derived:  
  - Day of the week  
  - Day number (Monday = 0)  
  - Hour rounded to the nearest hour  

</details>

<details>
<summary>STEP 2 - Price Cleaning</summary>

- Standardized price formatting by replacing dots with commas where necessary.  
- Converted `price` to **currency type** for accurate analysis.  

</details>

<details>
<summary>STEP 3 - Category and Product Transformation</summary>

- Split `category_code` into three columns:  
  - `category_name` (main category)  
  - `sub_category_name` (subcategory)  
  - `product_name`  
- Renamed `product_id` → `product_model_id` and `brand` → `brand_name`.  

</details>

<details>
<summary>STEP 4 - Handling Missing and Non-Standard Values</summary>

- Added `Flag_data` to classify rows:  
  - **Critical Missing Data** → missing essential columns (`event_time`, `order_id`, `product_model_id`, `category_id`, `price`) → **excluded**  
  - **Non-Critical Missing Data** → missing less essential columns (`category_name`, `sub_category_name`, `product_name`, `brand_name`, `user_id`) → **retained for partial analysis**  
  - **Fully Complete** → all columns present and valid  
- Replaced `null` or `"none"` values in text columns with `"Unknown"`.  
- Trimmed whitespace and converted text columns to lowercase for consistent grouping.  

</details>

<details>
<summary>STEP 5 - Filtering and Joining</summary>

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
<summary>STEP 6 - Resulting Dataset</summary>

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

        
        
       
