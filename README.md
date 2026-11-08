# Kenyan Retail Sales Intelligence Capstone

**Customer and Sales Intelligence for a Kenyan Retailer — Jirani Mart**

## 1. Project Overview

This Data Science and Analytics Capstone project analyses the 2025 sales data of Jirani Mart, a simulated Kenyan retail business. The project uses data analytics, SQL, Python, and Power BI to understand sales performance, customer purchasing behaviour, product categories, promotions, and payment methods.

The main goal is to turn retail transaction data into useful business insights that can support management decision-making, sales planning, and business performance monitoring.

## 2. Project Objectives

The project aims to:

- Analyse sales performance across different counties and stores.
- Identify monthly sales trends and changes in revenue.
- Examine product categories and customer purchasing behaviour.
- Evaluate promotions, discounts, and their relationship with sales.
- Analyse payment methods, including M-Pesa.
- Use SQL to perform business-focused data analysis.
- Conduct statistical analysis and hypothesis testing.
- Develop a model for daily sales forecasting.
- Build a Power BI dashboard to communicate findings and recommendations.

## 3. Dataset Description

The project uses a simulated retail dataset representing Jirani Mart's operations in Kenya.

The sales dataset contains **10,035 sales records** covering 1 January to 31 December 2025.

The data includes information such as:

- Transaction dates and transaction IDs
- Store and county information
- Customer IDs and customer segments
- Product names and categories
- Quantities and unit prices
- Gross sales and net sales
- Promotions and discount rates
- Payment methods, including M-Pesa

Additional customer, store, and product information is included to support the analysis.

**Data limitation:** The dataset is simulated and represents one year of business activity. Findings should therefore be interpreted within the context of the dataset and not treated as actual financial results from a real retailer.

## 4. Tools and Technologies

| Tool | Purpose |
|---|---|
| Microsoft Excel | Initial dataset and data inspection |
| Python | Data cleaning, exploration, statistical analysis, and forecasting |
| Pandas and NumPy | Data manipulation and numerical analysis |
| Matplotlib | Data visualisation |
| SciPy | Statistical testing |
| Scikit-learn | Predictive modelling |
| PostgreSQL | Database querying and analysis |
| Power BI | Interactive dashboard and business reporting |
| Jupyter Notebook | Analysis documentation and execution |
| GitHub | Project version control and documentation |

## 5. Repository Structure

The repository is organised as follows:

```text
kenyan-retail-sales-intelligence-capstone/
│
├── Power BI/
│   └── Power BI dashboard files
│
├── data/
│   └── External and processed datasets
│
├── notebooks/
│   ├── 03_exploratory_data_analysis.ipynb
│   ├── 05_hypothesis_testing.ipynb
│   └── 06_predictive_modeling.ipynb
│
├── reports/
│   └── Data quality and analysis reports
│
├── scripts/
│   ├── 01_clean_data.py
│   ├── 02_investigate_outliers.py
│   ├── 03_outlier_analysis.py
│   ├── 04_feature_engineering.py
│   └── 05_prepare_sales_for_sql.py
│
├── sql/
│   └── SQL analytics queries
│
├── 01_problem_framing.md
├── 02_data_cleaning.md
├── Jirani Mart Retail Intelligence Presentation.png
├── Jirani_Mart_Capstone_Milestone_8_Presentation.pptx
├── kenyan_retail_capstone_raw_dataset.xlsx
├── requirements.txt
└── README.md
```

The structure above describes the organisation of the project. The folders contain the supporting files, scripts, notebooks, reports, dashboard, and analysis outputs.

## 6. How to Reproduce the Analysis

The following steps describe the intended execution order.

### Step 1: Clone the repository

```bash
git clone https://github.com/wangechinjoroge767-cloud/kenyan-retail-sales-intelligence-capstone.git
```

Open the downloaded project folder in VS Code.

### Step 2: Create a virtual environment

```bash
python -m venv .venv
```

Activate it on Windows PowerShell:

```powershell
.\.venv\Scripts\Activate.ps1
```

### Step 3: Install the required packages

```bash
python -m pip install -r requirements.txt
```

### Step 4: Run the data preparation scripts

From the project root directory, run:

```bash
python scripts/01_clean_data.py
python scripts/02_investigate_outliers.py
python scripts/03_outlier_analysis.py
python scripts/04_feature_engineering.py
python scripts/05_prepare_sales_for_sql.py
```

The cleaning script prepares the sales data and supporting datasets. The remaining scripts investigate discounts and outliers, create analysis outputs, engineer features, and prepare sales data for SQL analysis.

### Step 5: Run the Jupyter notebooks

Open the `notebooks` folder in VS Code or start Jupyter from that folder:

```bash
cd notebooks
jupyter notebook
```

Run the notebooks in this order:

1. `03_exploratory_data_analysis.ipynb`
2. `05_hypothesis_testing.ipynb`
3. `06_predictive_modeling.ipynb`

The notebooks cover exploratory analysis, hypothesis testing, and predictive modelling.

### Step 6: Run the SQL analysis

Open PostgreSQL using pgAdmin or another PostgreSQL client.

Load the prepared sales and supporting datasets into the database, then open and execute the SQL analytics file in the `sql/` folder.

The SQL analysis includes correlation, covariance, customer cohort analysis, daily running totals, monthly revenue growth, RFM customer segmentation, and store rankings by county.

### Step 7: Open the Power BI dashboard

Open the Power BI project file in the `Power BI/` folder using Power BI Desktop. If prompted, connect or refresh the data sources using the project datasets.

## 7. Key Business Findings

The analysis identified the following results:

- Total net sales were approximately **KES 6.73 million**.
- The dataset contained approximately **5,000 transactions**.
- Average transaction value was approximately **KES 1,350**.
- Nairobi recorded the highest sales among the counties.
- M-Pesa was the leading payment method by sales value.

These findings provide a basis for examining sales performance, customer behaviour, payment preferences, and opportunities for improving retail operations.

## 8. Sales Forecasting

A Random Forest regression model was developed to forecast daily sales.

The model achieved:

- **Mean Absolute Error (MAE):** KES 6,097.06
- **Improvement over the baseline model:** 18.59% in MAE

The forecasting analysis is documented in the predictive modelling notebook. The results demonstrate how machine learning can support sales planning, although model performance is limited by the available one-year dataset.

## 9. Power BI Dashboard

The Power BI dashboard presents key business indicators and visualisations, including:

- Overall sales performance
- Monthly sales trends
- County and store performance
- Product category performance
- Promotion and discount analysis
- Payment method analysis

The dashboard is intended to help users explore the results and identify patterns that can support business decisions.

## 10. Business Recommendations

Based on the analysis, the following actions are recommended:

1. **Improve county-level sales planning:** Use county and store performance to identify locations that may need additional attention or resources.
2. **Strengthen inventory planning:** Use product category performance and sales trends to support stock decisions.
3. **Evaluate promotions:** Monitor discount performance to understand whether promotions contribute to improved sales.
4. **Support digital payments:** Consider customer payment preferences when planning payment services and customer experience improvements.
5. **Use forecasting for planning:** Apply sales forecasts as one input into inventory and operational planning, while monitoring model accuracy over time.

## 11. Project Limitations

- The dataset is simulated rather than actual company transaction data.
- The data covers only January to December 2025.
- One year of observations may not capture longer-term seasonal patterns or changes in customer behaviour.
- Forecasting performance may change when additional data becomes available.
- The findings are specific to the dataset and assumptions used in this project.

## 12. Conclusion

The Jirani Mart Retail Intelligence Capstone demonstrates how data analytics can be applied to retail business challenges. Through data cleaning, exploratory analysis, SQL analytics, statistical testing, predictive modelling, and Power BI visualisation, the project provides insights into sales performance, customer behaviour, promotions, and payment methods.

The project also demonstrates the value of combining different data tools to support evidence-based business decisions.

---

**Author:** Wangechi Njoroge  
**Project:** Data Science and Analytics Capstone  
**Focus:** Customer and Sales Intelligence for a Kenyan Retailer

