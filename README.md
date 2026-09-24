# Delhivery Logistics & Delivery Performance Analysis

## Project Overview

This project analyzes logistics delivery performance using OD-leg and
trip-level data. The objective is to identify delivery delay patterns,
compare route types, understand the relationship between distance and
delay, examine cutoff-status performance, and identify source and
destination centers with high average delays.

The project combines **Python, MySQL, and Power BI** to create an
end-to-end data analytics workflow.

## Business Problem

Logistics operations generate large volumes of trip and route data.
Analyzing this data can help identify:

-   Overall delivery delay levels
-   Differences between FTL and Carting routes
-   Distance bands associated with higher delays
-   Locations with high average delays
-   Differences between actual and estimated route distances
-   Relationships between cutoff status and delivery performance

## Project Objectives

1.  Analyze overall delivery performance.
2.  Calculate key delay KPIs.
3.  Compare FTL and Carting route performance.
4.  Analyze delay by distance band.
5.  Compare actual distance with OSRM-estimated distance.
6.  Identify high-delay source and destination centers.
7.  Analyze cutoff-status combinations.
8.  Build an interactive Power BI dashboard.

## Dataset Overview

  Metric                               Value
  ------------------------- ----------------
  Total OD Legs                       26,369
  Total Trips                         14,817
  Average Delay               109.62 minutes
  Minimum Delay                  -64 minutes
  Maximum Delay                3,137 minutes
  Average Actual Distance           92.54 km
  Average OSRM Distance            115.25 km

The final analysis dataset contains **26,369 rows and 25 columns**.

## Tools & Technologies

-   **Python**
-   **Jupyter Notebook**
-   **MySQL**
-   **Power BI**
-   **CSV**

### Python

Used for data inspection, cleaning, transformation, validation, and
preparation.

### MySQL

Used for structured data storage and SQL-based analysis.

### Power BI

Used to build the interactive dashboard, KPI cards, charts, and slicers.

## Data Preparation & Validation

The dataset was checked and prepared before SQL analysis and dashboard
development.

Key validation results:

-   Missing trip UUIDs: **0**
-   Missing source centers: **0**
-   Missing destination centers: **0**
-   Negative actual-time values: **0**
-   Negative OSRM-time values: **0**
-   Negative actual-distance values: **0**
-   Negative OSRM-distance values: **0**

There were **66 missing source_name values** and **81 missing
destination_name values** in the analyzed dataset.

## Key Business Insights

### 1. Overall Delay Performance

The dataset contains **26,369 OD legs across 14,817 trips**.

The average delay is **109.62 minutes**.

Delay distribution:

  Delay Category     OD Legs   Percentage
  ---------------- --------- ------------
  Early                  465        1.76%
  On Time              9,520       36.10%
  Moderate Delay       6,445       24.44%
  High Delay           4,766       18.07%
  Severe Delay         5,173       19.62%

### 2. FTL vs Carting

  Route Type     OD Legs   Average Delay   Severe Delay
  ------------ --------- --------------- --------------
  FTL             13,940      157.49 min         28.90%
  Carting         12,429       55.92 min          9.20%

The observed average delay and severe-delay percentage are substantially
higher for FTL than for Carting in this dataset.

### 3. Distance and Delay

  Distance Band     OD Legs   Average Delay   Severe Delay
  --------------- --------- --------------- --------------
  0--25 km            8,454       37.96 min          4.74%
  25--50 km           9,017       53.03 min          6.19%
  50--100 km          4,640      107.43 min         19.85%
  100--200 km         2,002      168.95 min         53.45%
  200+ km             2,256      556.19 min         98.54%

The analysis shows a strong increase in observed delay levels across the
distance bands, with the **200+ km category recording the highest
average delay and severe-delay percentage**.

### 4. Actual vs Estimated Distance

The dashboard compares actual distance with OSRM-estimated distance for
each distance band.

This provides a route-distance benchmarking view that can be used to
investigate differences between observed and estimated route lengths.

### 5. Hub-Level Variation

The dashboard identifies the Top 10 source centers and Top 10
destination centers by average delay.

These locations provide starting points for further investigation into
possible operational factors such as routing, scheduling, capacity, or
recurring lane-level issues.

The analysis identifies where delays are concentrated; it does not
establish the cause of those delays.

### 6. Cutoff Status

OD legs where both `cutoff_initial_status` and `cutoff_final_status`
were `1` recorded:

-   Average delay: **12.24 minutes**
-   Severe-delay rate: **0.40%**

These results describe the analyzed dataset and should be interpreted in
the context of the available operational variables.

## Power BI Dashboard

The final dashboard contains:

### KPI Cards

1.  Total OD Legs
2.  Total Trips
3.  Average Delay
4.  Severe Delay %
5.  Average Actual Distance

### Charts

1.  Delay Category Distribution
2.  Average Delay by Route Type
3.  Average Delay by Distance Band
4.  Actual vs Estimated Distance by Distance Band
5.  Delay Category Distribution by Route Type
6.  Top 10 Source Centers by Average Delay
7.  Top 10 Destination Centers by Average Delay

### Interactive Slicers

-   Route Type
-   Delay Category
-   Distance Band

## Dashboard Preview

Add the final Power BI dashboard screenshot to the repository and update
the image path below if needed:

``` text
images/dashboard.png
```

Then use:

``` markdown
![Power BI Dashboard](images/dashboard.png)
```

## Project Structure

A recommended GitHub structure is:

``` text
Delhivery-Logistics-Analysis/
│
├── data/
│   └── cleaned_dataset.csv
│
├── notebook/
│   └── data_cleaning_analysis.ipynb
│
├── sql/
│   └── logistics_analysis.sql
│
├── powerbi/
│   └── Delhivery_Logistics_Dashboard.pbix
│
├── report/
│   ├── Delhivery_Logistics_Delivery_Performance_Report.pdf
│   └── Delhivery_Logistics_Delivery_Performance_Report.docx
│
├── images/
│   └── dashboard.png
│
└── README.md
```

## How to Use

### 1. Data Preparation

Open the Jupyter Notebook and run the data preparation and validation
steps.

### 2. MySQL Analysis

Create the required database and table in MySQL, load the cleaned
dataset, and execute the SQL analysis queries.

### 3. Power BI

Open the `.pbix` file and refresh the data source if necessary.

Use the slicers to explore:

-   Route Type
-   Delay Category
-   Distance Band

## Recommendations for Further Analysis

Future analysis could include:

-   Time-based delay trends
-   Lane-level performance monitoring
-   Hub-level root-cause analysis
-   Actual vs estimated travel-time analysis
-   Delay analysis by shipment or operational category
-   Automated KPI monitoring

## Conclusion

This project demonstrates an end-to-end data analytics workflow using
**Python, MySQL, and Power BI**.

The analysis highlights meaningful differences in delivery performance
across route types, distance bands, cutoff-status combinations, and
logistics centers. The Power BI dashboard converts these findings into
an interactive reporting solution that can support further operational
investigation.

## Author

**Aswini Kumar Sahu**

Computer Science & Engineering\
Aspiring Data Analyst
