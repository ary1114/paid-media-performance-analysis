/*
PAID MEDIA PERFORMANCE ANALYSIS
Portfolio SQL Script
Database: SQLite
Dataset: Synthetic paid-media performance data
Table: mridha_paid_media_portfolio_dataset_Ad_Data

IMPORTANT:
- This dataset is synthetic and is used for portfolio demonstration only.
- Do not present its results as real client or business performance.
- Rates and ratios are calculated from aggregated totals, not averages of row-level rates.
- CPA_BDT below means cost per purchase (Spend / Purchases).
- CPL_BDT means cost per lead (Spend / Leads).
*/

-- ============================================================
-- 0. TABLE AND SCHEMA CHECKS
-- ============================================================

-- Confirm the imported table exists.
SELECT name
FROM sqlite_master
WHERE type = 'table'
  AND name = 'mridha_paid_media_portfolio_dataset_Ad_Data';

-- Inspect column names and data types.
PRAGMA table_info(mridha_paid_media_portfolio_dataset_Ad_Data);

-- Confirm the number of records.
SELECT COUNT(*) AS total_records
FROM mridha_paid_media_portfolio_dataset_Ad_Data;


-- ============================================================
-- 1. DATA QUALITY CHECKS
-- ============================================================

-- Check missing values in important columns.
SELECT
    SUM(CASE WHEN Date IS NULL OR TRIM(Date) = '' THEN 1 ELSE 0 END) AS missing_date,
    SUM(CASE WHEN Platform IS NULL OR TRIM(Platform) = '' THEN 1 ELSE 0 END) AS missing_platform,
    SUM(CASE WHEN Campaign IS NULL OR TRIM(Campaign) = '' THEN 1 ELSE 0 END) AS missing_campaign,
    SUM(CASE WHEN Objective IS NULL OR TRIM(Objective) = '' THEN 1 ELSE 0 END) AS missing_objective,
    SUM(CASE WHEN Audience IS NULL OR TRIM(Audience) = '' THEN 1 ELSE 0 END) AS missing_audience,
    SUM(CASE WHEN Creative IS NULL OR TRIM(Creative) = '' THEN 1 ELSE 0 END) AS missing_creative,
    SUM(CASE WHEN Spend_BDT IS NULL THEN 1 ELSE 0 END) AS missing_spend,
    SUM(CASE WHEN Impressions IS NULL THEN 1 ELSE 0 END) AS missing_impressions,
    SUM(CASE WHEN Clicks IS NULL THEN 1 ELSE 0 END) AS missing_clicks,
    SUM(CASE WHEN Leads IS NULL THEN 1 ELSE 0 END) AS missing_leads,
    SUM(CASE WHEN Purchases IS NULL THEN 1 ELSE 0 END) AS missing_purchases,
    SUM(CASE WHEN Revenue_BDT IS NULL THEN 1 ELSE 0 END) AS missing_revenue
FROM mridha_paid_media_portfolio_dataset_Ad_Data;

-- Find exact duplicate records.
-- A result of zero rows means no exact duplicate groups were found.
SELECT
    Date, Platform, Campaign, Objective, Audience, Creative,
    Spend_BDT, Impressions, Clicks, Leads, Purchases, Revenue_BDT,
    COUNT(*) AS duplicate_count
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY
    Date, Platform, Campaign, Objective, Audience, Creative,
    Spend_BDT, Impressions, Clicks, Leads, Purchases, Revenue_BDT
HAVING COUNT(*) > 1;

-- Check for negative values and logically suspicious counts.
SELECT *
FROM mridha_paid_media_portfolio_dataset_Ad_Data
WHERE Spend_BDT < 0
   OR Revenue_BDT < 0
   OR Impressions < 0
   OR Clicks < 0
   OR Leads < 0
   OR Purchases < 0
   OR Clicks > Impressions
   OR Purchases > Clicks;

-- Inspect date range and number of distinct dates.
SELECT
    MIN(Date) AS first_date,
    MAX(Date) AS last_date,
    COUNT(DISTINCT Date) AS distinct_dates
FROM mridha_paid_media_portfolio_dataset_Ad_Data;

-- Inspect category values.
SELECT DISTINCT Platform
FROM mridha_paid_media_portfolio_dataset_Ad_Data
ORDER BY Platform;

SELECT DISTINCT Campaign
FROM mridha_paid_media_portfolio_dataset_Ad_Data
ORDER BY Campaign;

SELECT DISTINCT Objective
FROM mridha_paid_media_portfolio_dataset_Ad_Data
ORDER BY Objective;

SELECT DISTINCT Audience
FROM mridha_paid_media_portfolio_dataset_Ad_Data
ORDER BY Audience;

SELECT DISTINCT Creative
FROM mridha_paid_media_portfolio_dataset_Ad_Data
ORDER BY Creative;


-- ============================================================
-- 2. OVERALL PERFORMANCE
-- ============================================================

SELECT
    SUM(Spend_BDT) AS total_ad_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Impressions) AS total_impressions,
    SUM(Clicks) AS total_clicks,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR_Percent,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Clicks), 0), 2) AS CPC_BDT,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT,
    ROUND(SUM(Spend_BDT) * 1000.0 / NULLIF(SUM(Impressions), 0), 2) AS CPM_BDT,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Leads), 0), 2) AS CPL_BDT
FROM mridha_paid_media_portfolio_dataset_Ad_Data;


-- ============================================================
-- 3. PLATFORM PERFORMANCE
-- ============================================================

SELECT
    Platform,
    SUM(Spend_BDT) AS total_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Impressions) AS total_impressions,
    SUM(Clicks) AS total_clicks,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR_Percent,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY Platform
ORDER BY ROAS DESC;


-- ============================================================
-- 4. CAMPAIGN PERFORMANCE
-- ============================================================

SELECT
    Campaign,
    Objective,
    SUM(Spend_BDT) AS total_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Leads), 0), 2) AS CPL_BDT
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY Campaign, Objective
ORDER BY ROAS DESC;


-- ============================================================
-- 5. AUDIENCE PERFORMANCE
-- ============================================================

SELECT
    Audience,
    SUM(Spend_BDT) AS total_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Impressions) AS total_impressions,
    SUM(Clicks) AS total_clicks,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR_Percent
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY Audience
ORDER BY ROAS DESC;


-- ============================================================
-- 6. CREATIVE PERFORMANCE
-- ============================================================

SELECT
    Creative,
    SUM(Spend_BDT) AS total_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Impressions) AS total_impressions,
    SUM(Clicks) AS total_clicks,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR_Percent
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY Creative
ORDER BY ROAS DESC;


-- ============================================================
-- 7. MONTHLY PERFORMANCE
-- Date is stored as ISO-formatted text: YYYY-MM-DD.
-- October 2026 ends on October 29 in this dataset.
-- ============================================================

SELECT
    SUBSTR(Date, 1, 7) AS month,
    SUM(Spend_BDT) AS total_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Impressions) AS total_impressions,
    SUM(Clicks) AS total_clicks,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR_Percent
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY SUBSTR(Date, 1, 7)
ORDER BY month;


-- ============================================================
-- 8. CONVERSION FUNNEL BY CAMPAIGN
-- ============================================================

SELECT
    Campaign,
    SUM(Clicks) AS total_clicks,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Leads) * 100.0 / NULLIF(SUM(Clicks), 0), 2) AS Click_To_Lead_Percent,
    ROUND(SUM(Purchases) * 100.0 / NULLIF(SUM(Leads), 0), 2) AS Lead_To_Purchase_Percent,
    ROUND(SUM(Purchases) * 100.0 / NULLIF(SUM(Clicks), 0), 2) AS Click_To_Purchase_Percent
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY Campaign
ORDER BY Click_To_Purchase_Percent DESC;


-- ============================================================
-- 9. PLATFORM AND CAMPAIGN BREAKDOWN
-- IMPORTANT DATA LIMITATION:
-- In this dataset, each campaign appears on only one platform.
-- This query describes the available combinations; it cannot
-- establish a same-campaign Facebook-vs-Instagram comparison.
-- ============================================================

SELECT
    Platform,
    Campaign,
    SUM(Spend_BDT) AS total_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Clicks) AS total_clicks,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT,
    ROUND(SUM(Purchases) * 100.0 / NULLIF(SUM(Clicks), 0), 2) AS Click_To_Purchase_Percent
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY Platform, Campaign
ORDER BY Campaign, ROAS DESC;


-- ============================================================
-- 10. DAY-OF-WEEK PERFORMANCE
-- SQLite strftime('%w'): Sunday = 0, Monday = 1, ..., Saturday = 6.
-- ============================================================

SELECT
    CASE CAST(strftime('%w', Date) AS INTEGER)
        WHEN 0 THEN 'Sunday'
        WHEN 1 THEN 'Monday'
        WHEN 2 THEN 'Tuesday'
        WHEN 3 THEN 'Wednesday'
        WHEN 4 THEN 'Thursday'
        WHEN 5 THEN 'Friday'
        WHEN 6 THEN 'Saturday'
    END AS day_of_week,
    COUNT(*) AS total_records,
    COUNT(DISTINCT Date) AS number_of_dates,
    SUM(Spend_BDT) AS total_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Clicks) AS total_clicks,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT,
    ROUND(SUM(Clicks) * 100.0 / NULLIF(SUM(Impressions), 0), 2) AS CTR_Percent
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY strftime('%w', Date)
ORDER BY CAST(strftime('%w', Date) AS INTEGER);


-- ============================================================
-- 11. OBJECTIVE-LEVEL PERFORMANCE
-- CPA_BDT is cost per purchase, not cost per lead.
-- CPL_BDT is included separately to evaluate lead generation.
-- ============================================================

SELECT
    Objective,
    SUM(Spend_BDT) AS total_spend,
    SUM(Revenue_BDT) AS total_revenue,
    SUM(Impressions) AS total_impressions,
    SUM(Clicks) AS total_clicks,
    SUM(Leads) AS total_leads,
    SUM(Purchases) AS total_purchases,
    ROUND(SUM(Revenue_BDT) / NULLIF(SUM(Spend_BDT), 0), 2) AS ROAS,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Purchases), 0), 2) AS CPA_BDT,
    ROUND(SUM(Spend_BDT) / NULLIF(SUM(Leads), 0), 2) AS CPL_BDT,
    ROUND(SUM(Leads) * 100.0 / NULLIF(SUM(Clicks), 0), 2) AS Click_To_Lead_Percent
FROM mridha_paid_media_portfolio_dataset_Ad_Data
GROUP BY Objective
ORDER BY ROAS DESC;


/*
END OF ANALYSIS

Suggested portfolio interpretation:
1. State that the dataset is synthetic.
2. Explain that ROAS is revenue divided by ad spend.
3. Explain that CPA_BDT is cost per purchase and CPL_BDT is cost per lead.
4. Treat campaign/platform comparisons cautiously because campaign coverage
   is not balanced across platforms.
5. Treat monthly and weekday comparisons as descriptive, not causal.
6. Awareness campaigns should not be judged by purchase ROAS alone.
*/
