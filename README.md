# Medicare Advantage HEDIS & Stars Rating Analysis

## Business Question
*Which HEDIS measures are underperforming below the CMS threshold and driving Stars rating loss across Medicare Advantage plans?*

This project analyzes 2026 CMS Medicare Advantage Star Ratings data across 769 contracts and 21,273 measure records to identify quality gaps and actionable improvement opportunities.

---

## Key Findings
- *5,166 measure records (24.3%)* fall below the 60% performance threshold
- *2,679 measure records (12.6%)* are at risk (60-75% range)
- *13,428 measure records (63.1%)* are performing well (>75%)
- *D02, C28, C18* are the lowest performing measures across all plans
- *Complaint-related measures* consistently score lowest — signaling member experience gaps

---

## Data Quality Challenges
- Raw CMS file contained multiple metadata header rows requiring custom parsing
- Measure scores stored as percentage strings requiring conversion to numeric
- Wide format (50 columns) reshaped to long format (21,273 rows) for analysis
- Filtered out "Not enough data available" and "Plan not required to report" values

---

## Tools & Technologies
| Layer | Tool |
|---|---|
| Data Extraction & SQL Analysis | Google BigQuery |
| Data Cleaning & Analysis | Python (Google Colab) |
| Interactive Dashboard | Tableau Public |
| Executive Dashboard | Power BI |
| Data Source | CMS 2026 Medicare Advantage Star Ratings (Official) |

---

## SQL Analysis (BigQuery)
- Identified below-threshold contracts using CASE statements and performance categorization
- Ranked contracts by average measure score using window functions
- Calculated reimbursement efficiency and measure-level aggregations using CTEs

---

## Python Analysis Highlights
- Reshaped wide-format CMS data (770 rows × 50 columns) to long format using melt()
- Converted percentage strings to numeric using str.replace() and pd.to_numeric()
- Segmented 21,273 records into performance categories using apply() and lambda functions
- Generated bar charts and pie charts using matplotlib

---

## Dashboard Features
- Bottom 10 HEDIS measures by average score
- Performance category distribution (Below Threshold / At Risk / Performing Well)
- Contract-level drill-down by measure and organization type

**[View Tableau Dashboard](https://public.tableau.com/app/profile/lokesh.reddy2043/viz/MedicareAdvantageHEDISStarsAnalysis2026/MedicareAdvantageHEDISStarsAnalysis-2026)**

*Power BI Dashboard — screenshot available in repo*

---

## Analytical Approach
1. Downloaded raw 2026 CMS Star Ratings ZIP file from official CMS website
2. Loaded into Google BigQuery and wrote SQL queries to explore structure
3. Uploaded CSV to Google Colab for Python cleaning and reshaping
4. Identified 21,273 valid measure records across 769 MA contracts
5. Built performance categories and visualizations
6. Published interactive dashboard to Tableau Public
7. Built executive dashboard in Power BI Desktop

---

## Recommendations
- Prioritize improvement in *complaint-related measures (D02, C28)* — lowest scoring across all plans
- Investigate *Plan All-Cause Readmissions (C18)* — consistently below threshold
- Target *member experience measures* for immediate quality improvement initiatives
- Develop contract-level scorecards for plans with >50% measures below threshold
- Monitor *At Risk measures* quarterly to prevent further Stars rating decline

---

## Domain Context
This analysis applies concepts central to *Medicare Advantage Stars program, **HEDIS measure performance, and **value-based care contracting* — areas where Stars ratings directly impact plan bonus payments, member enrollment, and CMS quality benchmarks.

---

## About
Built by *Lokesh Bayyapu*, PharmD, MS Health Data Science
Healthcare Data Analyst | Medicare Advantage & Population Health
[LinkedIn](https://www.linkedin.com/in/lokeshreddy1) | [Tableau Public](https://public.tableau.com/app/profile/lokesh.reddy2043/vizzes)
