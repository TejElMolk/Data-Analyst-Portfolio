<p align="center">
  <img src="Images/logo_netflix.png" alt="logo_netflix.png" width="300">
</p>



# NETFLIX PORTFOLIO PROJECT

<img src="Images/Distribution of Movies vs TV Shows (1).png" alt="Distribution of Movies vs TV Shows (1).png" width="600">

## I. Introduction / Context

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

## II. Data Exploration

The Netflix dataset contains **8,807 rows and 12 columns**, covering the period from 2016 to 2021. The main columns include `show_id`, `type` (Movie or TV Show), `title`, `director`, `cast`, `country`, `date_added`, `release_year`, `Content Advisory`, `duration`, `Genres`, and `description`.

Initial exploration revealed:

- **Missing values** in `director`, `cast`, `country`, and `Genres`.
- `date_added` and `release_year` required type adjustments.
- Some columns contained mixed or inconsistent formats (e.g., `duration` included both minutes and season counts for TV shows).
- Certain country names were outdated or ambiguous (e.g., “Soviet Union”, “West Germany”).

We also observed that some movies and shows were listed under multiple countries and genres, which would require further transformation for proper analysis.

---

After exploring the dataset and identifying missing or inconsistent values, we are ready to clean the data and move on to exploratory analysis to uncover key insights.

---

## III. Data Cleaning

---

To prepare the dataset for analysis, the following steps were performed:

---

1. **Column adjustments and renaming**
   <details>
    - Removed irrelevant columns like `description`.
    - Renamed `listed_in` to `Genres` and `rating` to `Content Advisory` for clarity.
    <details>

2. **Type conversion**
   <details>
    - Converted `release_year` to integer, `date_added` to date, and `Movie_Duration`/`TV_Show_Duration` to numeric types.
    <details>

3. **Handling missing values**
   <details>
    - `director` and `cast` left blank as not critical for analysis.
    - Missing `country` and `Genres` were replaced with `"Unknown"`.
   <details>

4. **Standardization and formatting**
   <details>
    - Removed extraneous characters (e.g., `"min"`, `"s"`, `"Season/Seasons"`) from `duration` columns.
    - Standardized text capitalization for `title` and `country`.
    - Trimmed unnecessary spaces.
    <details>

5. **Splitting and unpivoting columns**
    <details>
    - Separated multiple countries into distinct rows for detailed country-level analysis.
    - Similarly, genres were split and normalized.
    <details>

6. **Feature engineering**
    <details>
    - Created `Movie_Duration` and `TV_Show_Duration` for better numeric analysis.
    - Added `Season_date_added` to categorize content by seasonal release (Winter, Spring, Summer, Fall).
    <details>

7. **Country normalization**
   <details>
    - Replaced outdated or ambiguous country names (e.g., `"Soviet Union"` → `"Unknown"`, `"West Germany"`/`"East Germany"` → `"Germany"`).
    <details>

8. **Resulting dataset**
    <details>
    - The dataset grew from 8,807 rows to **10,831 rows** after splitting multiple countries.
    - Cleaned, standardized, and structured data ready for exploratory analysis and visualization in Power BI.
    <details>


## IV. Exploratory Data Analysis (EDA)

---

The cleaned Netflix dataset allowed us to explore key questions about the platform’s catalogue, content distribution, and trends over time. Using Power BI, interactive dashboards were created to visualize the findings.

---

<details>
<summary>Distribution of Movies vs TV Shows</summary>

**Question:** How many movies and TV shows are available on Netflix?

![Capture d’écran 2025-09-12 à 15.35.43.png](attachment:86e18b01-159c-4355-afb9-aa0596f78343:Capture_decran_2025-09-12_a_15.35.43.png)

**Observation:**

- Total titles: 8,801
    - Movies: 6,128 (≈70%)
    - TV Shows: 2,675 (≈30%)

**Insight:**

- Netflix prioritizes movies in its catalogue, likely because films appeal to a broad audience and are easier to produce at scale.
- The significant proportion of TV shows shows a strategic investment in binge-worthy content to maintain subscriber engagement over time.
- This dual focus demonstrates Netflix’s approach to balance reach (through movies) and engagement (through series).

</details>

<details>
<summary>Most Common Genres</summary>

**Question:** Which genres are the most present on the platform?

![Capture d’écran 2025-09-12 à 16.16.15.png](attachment:cde0df35-67c3-4437-a523-57318b07caca:Capture_decran_2025-09-12_a_16.16.15.png)

**Observation:**

- Top genres :
    - Drama: 2 065 titles
    - Comedy: 1 328 titles
    - Documentary: 1 050 titles

**Insight:**

- Drama dominates due to its universal appeal across different audiences and countries.
- Comedy is popular for light, easily consumable content, attracting casual viewers.
- Documentaries reflect a niche strategy, catering to audiences interested in educational or informational content.
- Overall, Netflix balances mass appeal with targeted content to satisfy diverse viewer preferences.

</details>

<details>
<summary>Content by Country</summary>

**Question:** In how many countries is Netflix available and where does content come from?

**Observation:**

- Content originates from 120 countries after cleaning ambiguous values (e.g., “Soviet Union” → “Unknown”, “West/East Germany” → “Germany”).
- Most countries contribute a small number of titles; a few countries dominate production such as USA , India , United Kingdom , Canada and Japan.

**Insight:**

- Netflix sources content globally to appear diverse, but relies heavily on high-production countries like the US and India.
- The imbalance shows potential opportunities to expand into underrepresented regions, both to attract local subscribers and diversify content offerings.

</details>

<details>
<summary>Top Producing Countries</summary>

**Question:** Which countries produce the most Netflix content?

![Capture d’écran 2025-09-12 à 16.08.57.png](attachment:4a5df733-2db5-41ab-bff5-979d74d1c46d:Capture_decran_2025-09-12_a_16.08.57.png)

**Observation:**

- Top 5 producing countries:
    1. United States – 3,686 titles
    2. India – 1,045 titles
    3. United Kingdom – 804 titles
    4. Canada – 445 titles
    5. France – 391 titles

**Insight:**

- The US dominates due to its large production industry and global influence.
- India and the UK reflect Netflix’s strategy to cater to large, English-speaking audiences and high-demand markets.
- The top five countries account for approximately 70% of all titles available on Netflix
- Countries with fewer titles may represent untapped opportunities for regional content development.

</details>

<details>
<summary>Dominant Genre per Country</summary>

**Question:** What is the dominant genre in each country?

![Capture d’écran 2025-09-12 à 16.07.26.png](attachment:b709a05a-c8a5-4a17-b183-43de40ecb44e:Capture_decran_2025-09-12_a_16.07.26.png)

**Observation:**

- Drama is the dominant genre in most countries, including India, France, and Germany.
- Other genres show regional variation: International TV Shows are particularly significant in the UK, Children and Family content is more prevalent in Canada, and Anime has a strong presence in Japan.

**Insight:**

- Netflix tailors its content to local preferences, demonstrating an understanding of cultural tastes and regional demand.
- Recognizing these patterns allows Netflix to strategically prioritize genres when entering new markets or producing localized content, ensuring higher engagement and subscriber satisfaction.

</details>

<details>
<summary>Seasonal Trends in Content Release</summary>

**Question:** Are there seasonal trends in the release of Netflix content?

![Capture d’écran 2025-09-12 à 16.22.15.png](attachment:5aae8e64-60ca-4d4f-bc14-eefb4dcd8989:Capture_decran_2025-09-12_a_16.22.15.png)

**Observation:**

- Content categorized by season shows:
    - Winter (Dec–Feb), especially December, has the highest additions.
    - Spring, Summer, and Fall see moderate additions.

**Insight:**

- Netflix strategically releases most content during the 4th quarter to capture peak holiday viewership.
- Seasonal trends suggest a planned release strategy, which could be further optimized using viewership data to maximize engagement.

</details>

<details>
<summary>Content Advisory and Growth</summary>

**Question:** What can we learn from content advisory ratings and catalogue growth?

![Capture d’écran 2025-09-12 à 16.24.01.png](attachment:4b1fb288-db7a-4116-bb68-78ad48b08131:Capture_decran_2025-09-12_a_16.24.01.png)

**Observation:**

- Adult content dominates (2,860 movies, 1,146 TV shows).
- Teen/young adult content is substantial (~2,650 titles).
- Children’s content is limited (~640 titles).
- Catalogue grew steadily from 2016–2020, peaking in 2019–2020, then slightly decreased in 2021.

**Insight:**

- Netflix primarily targets adult viewers, but maintains offerings for teens and young adults.
- The lower proportion of children’s content may represent an opportunity for growth in family-oriented programming.
- Growth trends reflect strategic expansion and content acquisition efforts, while the 2021 decline suggests external factors (e.g., production delays or strategy shifts) impact catalogue additions.

</details>

## V. Recommendations


- **Expand Children’s and Family Content:** Increase the number of titles targeting younger audiences to attract family subscriptions, particularly in regions like Canada and the US.
- **Diversify Content Sources:** Invest in producing or acquiring content from underrepresented countries to broaden Netflix’s global catalogue and appeal.
- **Optimize Content Release Timing:** Spread content releases more evenly throughout the year, rather than concentrating them in the 4th quarter, to maintain consistent subscriber engagement.
- **Localize Genre Strategy:** Tailor content by region based on local preferences (e.g., Anime in Japan, International TV Shows in the UK) to improve engagement and retention.
- **Strengthen Niche Genres:** Expand offerings in high-potential but smaller genres (Documentary, International films) to cater to niche audiences and differentiate Netflix from competitors.


## VI. Limitations


While the analysis provides useful insights, there are several limitations to consider:

1. **Dataset Scope**
    - The dataset only includes titles up to 2021 and may not reflect the most recent trends or new content releases.
2. **Missing Data**
    - Some fields (director, cast) are missing or incomplete, which limits the ability to analyze the influence of talent on content popularity.
3. **Geographic Representation**
    - Some country data is labeled “Unknown,” and small contributors may not accurately represent regional content production.
4. **Viewership Data Not Included**
    - This dataset focuses on catalogue availability but does not include viewership metrics, ratings, or user engagement, limiting conclusions about popularity or performance.
5. **Simplified Seasonal Analysis**
    - Seasonal trends are based on date added, not actual release or viewership peaks, so conclusions about engagement timing are inferred rather than confirmed.



## VII. Conclusion


In summary, the analysis of the Netflix catalogue highlights several key trends:

- Netflix primarily focuses on movies (≈70%) but maintains a significant portion of TV shows to satisfy binge-watching audiences.
- Drama, Comedy, and Documentary are the most prevalent genres, reflecting broad appeal while maintaining niche offerings.
- Content production is heavily concentrated in a few countries (US, India, UK), though Netflix maintains a global presence in 120 countries.
- Regional preferences, such as Anime in Japan or Children’s content in Canada, demonstrate Netflix’s localized strategy.
- Seasonal trends show a focus on 4th-quarter content additions, likely aligned with holiday viewership peaks.
- Growth patterns from 2016–2020 show a consistent expansion of the catalogue, with a slight slowdown in 2021.

Overall, this analysis shows that Netflix balances **mass appeal with targeted content**, and provides opportunities to **expand children’s content, diversify country representation, and optimize seasonal releases**.


## VIII. Dashboard


