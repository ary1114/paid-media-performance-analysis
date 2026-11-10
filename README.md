# Paid Media Performance Analysis

An end-to-end data analytics portfolio project examining paid
advertising performance across platforms, campaigns, audiences,
creatives, months, weekdays, and campaign objectives.

> **Dataset disclosure:** This project uses a synthetic dataset created
> for portfolio and learning purposes. The results do not represent
> actual client accounts, advertising spend, or business performance.

## Project Overview

The goal of this project is to analyze paid media performance and turn
advertising data into actionable business insights. The analysis focuses
on campaign efficiency, conversion performance, and opportunities to
improve budget allocation.

### Business Questions

-   How efficiently does advertising spend generate revenue?
-   How do Facebook and Instagram compare at the overall platform level?
-   Which campaigns, audiences, and creatives perform best?
-   How does performance change over time?
-   Where do users drop off in the click-to-lead-to-purchase funnel?
-   Do results differ by weekday or campaign objective?

## Tools

-   **Microsoft Power BI** --- data preparation, DAX measures,
    interactive dashboard
-   **SQL (SQLite)** --- data validation, aggregation, segmentation, and
    analysis
-   **Microsoft Excel** --- source dataset review

## Dataset

The workbook contains an `Ad_Data` sheet and a `Data_Dictionary` sheet.

  Attribute    Description
  ------------ -------------------------------------------------------
  Records      4,050
  Date range   1 August 2026 -- 29 October 2026
  Platforms    Facebook, Instagram
  Campaigns    5
  Audiences    Broad, Interest, Lookalike
  Creatives    Carousel C, Static B, Video A
  Measures     Spend, impressions, clicks, leads, purchases, revenue

The dataset contains 12 columns: `Date`, `Platform`, `Campaign`,
`Objective`, `Audience`, `Creative`, `Spend_BDT`, `Impressions`,
`Clicks`, `Leads`, `Purchases`, and `Revenue_BDT`.

## Methodology

1.  Reviewed the source workbook and data dictionary.
2.  Prepared and checked the data in Power Query.
3.  Built an interactive two-page Power BI dashboard.
4.  Validated the table structure and checked for missing values, exact
    duplicate records, negative values, and suspicious count
    relationships using SQLite.
5.  Used SQL aggregation to analyze overall performance and break
    results down by platform, campaign, audience, creative, month,
    conversion funnel, weekday, and objective.
6.  Interpreted the results and developed recommendations, while
    documenting limitations.

## Key Performance Indicators

  -----------------------------------------------------------------------
  KPI                     Calculation             What it measures
  ----------------------- ----------------------- -----------------------
  CTR                     Clicks ÷ Impressions ×  Share of impressions
                          100                     that generated clicks

  CPC                     Ad Spend ÷ Clicks       Average cost per click

  CPM                     Ad Spend ÷ Impressions  Cost per 1,000
                          × 1,000                 impressions

  ROAS                    Revenue ÷ Ad Spend      Revenue generated per
                                                  unit of ad spend

  CPA                     Ad Spend ÷ Purchases    Cost per purchase

  CPL                     Ad Spend ÷ Leads        Cost per lead

  Click-to-Lead Rate      Leads ÷ Clicks × 100    Share of clicks that
                                                  generated leads

  Lead-to-Purchase Rate   Purchases ÷ Leads × 100 Share of leads that
                                                  became purchases

  Click-to-Purchase Rate  Purchases ÷ Clicks ×    Share of clicks that
                          100                     generated purchases
  -----------------------------------------------------------------------

Rates and ratios are calculated from aggregated totals for each segment,
rather than averaging row-level rates.

## Key Findings

### Overall Performance

-   Total advertising spend: **৳2,560,071.07**
-   Total revenue: **৳2,264,190.99**
-   Total impressions: **21,672,629**
-   Total clicks: **396,144**
-   Total leads: **14,881**
-   Total purchases: **533**
-   Overall ROAS: **0.88x**

### Platform

Instagram recorded a higher overall ROAS (**0.98x**) than Facebook
(**0.83x**) and a lower cost per purchase. Facebook generated more
purchases in total. This is a descriptive comparison of the platform
totals in this dataset.

### Campaign

-   **Lead Gen - Home Services** recorded the highest campaign ROAS
    (**1.12x**) and the lowest cost per purchase among the five
    campaigns.
-   **Ecommerce - Retargeting** generated the highest purchase volume
    (**148**).
-   **Brand Awareness - Dhaka** recorded a purchase ROAS of **0.20x**.
    Purchase ROAS alone is not sufficient to assess an awareness
    campaign.

### Audience

The **Broad** audience led the three audience segments in ROAS
(**0.94x**), purchase volume (**188**) and cost-per-purchase efficiency
(lowest CPA, **৳4,537.60**) in this dataset.

### Creative

-   **Carousel C** recorded the highest ROAS (**1.00x**), most purchases
    (**200**) and lowest CPA (**৳4,255.71**).
-   **Video A** recorded the highest CTR (**1.95%**), but did not lead
    in ROAS.
-   **Static B** recorded the lowest ROAS (**0.76x**) and highest CPA
    (**৳5,614.24**).

This illustrates that a higher CTR does not necessarily mean stronger
revenue efficiency.

### Monthly Performance

October recorded the highest ROAS and lowest CPA, while August generated
the most purchases. ROAS declined in September and recovered in October.
October's data ends on 29 October, so the reporting period is shorter
than the other two months.

### Conversion Funnel

-   Lead Gen - Home Services recorded the highest click-to-lead rate.
-   Ecommerce - Prospecting recorded the highest lead-to-purchase rate.
-   Lead Gen - Home Services and Lead Gen - Education tied for the
    highest click-to-purchase rate.

### Day of Week

Thursday led in ROAS, purchase volume, and CPA efficiency in the
aggregated results. Sunday was identified as a weaker-performing day.
These are descriptive findings and should be checked against spend and
the number of dates represented before making scheduling decisions.

### Campaign Objective

-   **Leads** had the highest ROAS (**1.07x**) and lead volume
    (**10,927**).
-   **Sales** generated the most purchases (**263**).
-   **Awareness** had a purchase ROAS of **0.20x**; purchase ROAS should
    not be used as the sole measure of awareness effectiveness.

## Recommendations

Based on the patterns in this synthetic dataset:

1.  Investigate the Broad audience and Carousel C combination further,
    while validating results with controlled tests before reallocating
    budget.
2.  Review the Home Services lead-generation campaign's targeting,
    offer, and conversion journey to understand its stronger observed
    efficiency.
3.  Investigate why Video A attracts clicks but does not achieve the
    strongest ROAS. Review post-click experience and lead or purchase
    quality.
4.  Evaluate lead-generation campaigns using CPL and lead quality, not
    purchase CPA alone.
5.  Evaluate awareness activity using objective-appropriate measures
    such as reach, frequency, and brand lift where available.
6.  Review weekday performance with daily spend and date coverage before
    changing campaign schedules.
7.  Use controlled experiments and real campaign data before applying
    these findings to live budget decisions.

## Limitations

-   The dataset is synthetic and cannot establish real-world campaign
    outcomes.
-   Each campaign appears on only one platform in the dataset.
    Therefore, the platform-and-campaign breakdown cannot establish how
    the same campaign would perform on Facebook versus Instagram.
-   October covers 1--29 October, while August and September cover full
    calendar months.
-   Weekday and monthly comparisons are descriptive. Differences may
    reflect budget, campaign mix, or date coverage rather than the day
    or month itself.
-   Awareness campaigns should not be judged by purchase ROAS alone.
-   Observational segment comparisons do not establish causation.

## Project Files

Suggested GitHub repository structure:

``` text
paid-media-performance-analysis/
├── README.md
├── data/
│   └── mridha_paid_media_portfolio_dataset(2).xlsx
├── sql/
│   └── paid_media_performance_analysis.sql
├── power-bi/
│   └── dashboard-screenshots/
│       ├── campaign-overview.png
│       └── audience-creative-insights.png
└── reports/
    └── paid-media-performance-analysis-report.pdf
```

Add the Power BI screenshots and final report to the repository before
publishing. If you do not want to publish the full source workbook,
provide a sample or explain how reviewers can access the data.

## Dashboard Preview



### Campaign Overview

![Campaign Overview
Dashboard](campaign-overview.png)

### Audience & Creative Insights

![Audience and Creative Insights
Dashboard](audience-creative-insights.png)

## How to Reproduce the SQL Analysis

1.  Open a SQLite-compatible SQL environment.
2.  Import the `Ad_Data` sheet from the Excel workbook as a table.
3.  Use the table name `mridha_paid_media_portfolio_dataset_Ad_Data`, or
    update the table references in the SQL script if you choose a
    different name.
4.  Open `sql/paid_media_performance_analysis.sql`.
5.  Run the queries section by section.

## Conclusion

This project demonstrates an end-to-end analytics workflow: data
preparation, quality validation, SQL analysis, dashboard development,
KPI interpretation, and business recommendations. It emphasizes both
analytical findings and the limitations that should be considered before
making business decisions.
