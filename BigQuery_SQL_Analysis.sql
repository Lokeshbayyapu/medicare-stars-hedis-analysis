-- ============================================
-- Medicare Advantage HEDIS & Stars Rating Analysis
-- Author: Lokesh Bayyapu
-- Data: CMS 2026 Medicare Advantage Star Ratings
-- Tool: Google BigQuery
-- ============================================

-- Step 1: Create clean view from raw CMS data
CREATE OR REPLACE VIEW medicare-stars-2026.stars_data.measure_scores_clean AS
SELECT
  string_field_0 AS Contract_ID,
  string_field_1 AS Organization_Type,
  string_field_2 AS Contract_Name,
  string_field_3 AS Measure_Code,
  string_field_4 AS Measure_Name,
  string_field_5 AS Star_Rating,
  string_field_6 AS Measure_Score
FROM medicare-stars-2026.stars_data.measure_scores
WHERE string_field_0 NOT LIKE '2026%'
AND string_field_0 != 'Contract ID'
AND string_field_0 IS NOT NULL
AND string_field_1 != 'Organization Type';

-- ============================================
-- Step 2: Performance Category Analysis
-- Identifies below threshold, at risk, and performing well contracts
SELECT 
  Contract_ID,
  Contract_Name,
  Organization_Type,
  Measure_Name,
  Star_Rating,
  Measure_Score,
  CASE 
    WHEN SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64) < 60 
      THEN 'Below Threshold'
    WHEN SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64) BETWEEN 60 AND 75 
      THEN 'At Risk'
    WHEN SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64) > 75 
      THEN 'Performing Well'
    ELSE 'Unknown'
  END AS Performance_Category
FROM medicare-stars-2026.stars_data.measure_scores_clean
ORDER BY SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64) ASC;

-- ============================================
-- Step 3: Contract-level measure performance summary
-- Counts measures by performance category per contract
SELECT 
  Contract_Name,
  COUNT(Measure_Name) AS Total_Measures,
  COUNTIF(SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64) < 60) 
    AS Below_Threshold,
  COUNTIF(SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64) BETWEEN 60 AND 75) 
    AS At_Risk,
  COUNTIF(SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64) > 75) 
    AS Performing_Well,
  ROUND(AVG(SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64)), 2) 
    AS Avg_Star_Rating
FROM medicare-stars-2026.stars_data.measure_scores_clean
GROUP BY Contract_Name
ORDER BY Avg_Star_Rating ASC;

-- ============================================
-- Step 4: Measure-level analysis
-- Identifies worst performing HEDIS measures across all plans
SELECT 
  Measure_Name,
  COUNT(Contract_ID) AS Total_Plans,
  ROUND(AVG(SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64)), 2) 
    AS Avg_Score,
  ROUND(MIN(SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64)), 2) 
    AS Min_Score,
  ROUND(MAX(SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64)), 2) 
    AS Max_Score,
  COUNTIF(SAFE_CAST(REPLACE(Star_Rating, '%', '') AS FLOAT64) < 60) 
    AS Plans_Below_Threshold
FROM medicare-stars-2026.stars_data.measure_scores_clean
GROUP BY Measure_Name
ORDER BY Avg_Score ASC;
