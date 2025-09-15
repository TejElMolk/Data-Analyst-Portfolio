# NETFLIX PORTFOLIO PROJECT

![image.png](attachment:292b4273-92e3-4f84-9212-9ca2deec66d8:image.png)

<details>
<summary> I. Introduction / Context </summary>

### **Who is Netflix?**

Netflix is a global streaming platform offering movies, TV shows, documentaries, and original content to millions of subscribers worldwide. The company continuously invests in content production to increase engagement, reduce churn, and grow its subscriber base.

### **Project Goal**

The goal of this project is to explore and analyze the Netflix catalogue, understand content distribution across genres and countries, identify trends over time, and uncover insights that can inform strategic decisions for content expansion and audience engagement.

### **Content of each column**

| **Column Name** | **Description** |
| --- | --- |
| **show_id** | Unique identifier for each title |
| **type** | Movie or TV Show |
| **title** | Title of the content |
| **director** | Director of the content |
| **cast** | Main actors |
| **country** | Country of production |
| **date_added** | Date the title was added to Netflix |
| **release_year** | Year the content was released |
| **Content Advisory** | Rating (e.g., PG, R, TV-MA) |
| **duration** | Duration of the content (minutes or seasons) |
| **Movie_Duration** | Duration for movies only (numeric) |
| **Tv_Show_Duration** | Number of seasons for TV shows (numeric) |
| **Genres** | Main genres associated with the title |

### **Tools Used**

- **Power Query:** For data cleaning, transformation, and preparation.
- **Power BI:** For interactive dashboards, filtering, and visual exploration of the dataset.

</details>

<details>
<summary> II. Data Exploration </summary>

The Netflix dataset contains **8,807 rows and 12 columns**, covering the period from 2016 to 2021. The main columns include `show_id`, `type` (Movie or TV Show), `title`, `director`, `cast`, `country`, `date_added`, `release_year`, `Content Advisory`, `duration`, `Genres`, and `description`.

Initial exploration revealed:

- **Missing values** in `director`, `cast`, `country`, and `Genres`.
- `date_added` and `release_year` required type adjustments.
- Some columns contained mixed or inconsistent formats (e.g., `duration` included both minutes and season counts for TV shows).
- Certain country names were outdated or ambiguous (e.g., “Soviet Union”, “West Germany”).

We also observed that some movies and shows were listed under multiple countries and genres, which would require further transformation for proper analysis.

---

After exploring the dataset and identifying missing or inconsistent values, we are ready to clean the data and move on to exploratory analysis to uncover key insights.

</details>

<details>
<summary> III. Data Cleaning </summary>

To prepare the dataset for analysis, the following steps were performed:

<details>
<summary>Data Cleaning Steps</summary>

1. **Column adjustments and renaming**
    - Removed irrelevant columns like `description`.
    - Renamed `listed_in` to `Genres` and `rating` to `Content Advisory` for clarity.
2. **Type conversion**
    - Converted `release_year` to integer, `date_added` to date, and `Movie_Duration`/`TV_Show_Duration` to numeric types.
3. **Handling missing values**
    - `director` and `cast` left blank as not critical for analysis.
    - Missing `country` and `Genres` were replaced with `"Unknown"`.
4. **Standardization and formatting**
    - Removed extraneous characters (e.g., `"min"`, `"s"`, `"Season/Seasons"`) from `duration` columns.
    - Standardized text capitalization for `title` and `country`.
    - Trimmed unnecessary spaces.
5. **Splitting and unpivoting columns**
    - Separated multiple countries into distinct rows for detailed country-level analysis.
    - Similarly, genres were split and normalized.
6. **Feature engineering**
    - Created `Movie_Duration` and `TV_Show_Duration` for better numeric analysis.
    - Added `Season_date_added` to categorize content by seasonal release (Winter, Spring, Summer, Fall).
7. **Country normalization**
    - Replaced outdated or ambiguous country names (e.g., `"Soviet Union"` → `"Unknown"`, `"West Germany"`/`"East Germany"` → `"Germany"`).
8. **Resulting dataset**
    - The dataset grew from 8,807 rows to **10,831 rows** after splitting multiple countries.
    - Cleaned, standardized, and structured data ready for exploratory analysis and visualization in Power BI.

</details>

</details>
