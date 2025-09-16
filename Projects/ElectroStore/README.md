<p align="center">
  <img src="Images/ElectroStore Logo.png" alt="ElectroStore Logo.png" width="200">
</p>


## I. Introduction / Context

### **About the Dataset**
This dataset contains purchase events from **January 2020 to November 2020** from a **large electronics and home appliances e-commerce store** in an unknown Middle Eastern country.  
Each row represents a user-product interaction. Prices are shown in USD for convenience.  

Data was collected by [**Open CDP**](https://rees46.com/en/open-cdp) and can be used freely with proper attribution.

---

### **Project Goal**
The project aims to analyze January–November 2020 data from a large online electronics store to identify key trends and patterns in:
- Customer purchase behavior  
- Top-selling products, categories, and brands  
- Purchase frequency  

Insights from this analysis can be used to provide **actionable recommendations** for improving:
- Sales performance  
- Customer retention  
- Overall online store optimization  

---

### **Content of Dataset**

| **Column Name** | **Description** | **Business Context** |
|-----------------|-----------------|----------------------|
| **event_time**  | Timestamp of when the event occurred. | Tracks shopping trends and peak activity times. |
| **order_id**    | Unique identifier for each order. | Groups items per purchase, used for AOV calculation. |
| **product_id**  | Unique identifier for each product. | Enables product-level sales and inventory analysis. |
| **category_id** | Unique identifier for the product category. | Helps measure performance at category level. |
| **category_code** | Readable category and sub-category name (if available). | Useful for category/sub-category insights (e.g., smartphones vs. laptops). |
| **brand**       | Brand name (in lowercase, if available). | Used for brand sales tracking and comparison. |
| **price**       | Product price at purchase time. | Key for revenue and pricing analysis. |
| **user_id**     | Unique identifier for the user. | Enables customer segmentation and retention analysis. |

---

### **Tools Used**
- **Data Preparation:** Excel Power Query → cleaning, transforming, structuring  
- **Analysis:** Pivot Tables (linked to Power Query) → aggregations & summaries  
- **Visualization:** Pivot Charts & Excel Data Model → trends & relationships  
- **Dashboard:** Fully interactive Excel dashboard presenting key metrics & findings  

---

