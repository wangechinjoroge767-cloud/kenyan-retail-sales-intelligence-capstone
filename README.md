# Kenyan Retail Sales Intelligence Capstone

Data Science and Analytics Capstone analyzing Kenyan retail sales, customer behavior, and sales forecasting using Excel, Python, and Power BI.

## Project Overview

This project analyses Jirani Mart's retail sales data for 2025 to understand sales performance, customer purchasing behaviour, product categories, promotions, and payment methods. The aim is to provide useful business insights and support better decision-making through data analysis and visualisation.

## Project Objectives

- Analyse retail sales performance across counties.
- Identify monthly sales trends and popular product categories.
- Examine promotion performance and payment methods, including M-Pesa.
- Analyse sales data using SQL.
- Develop a daily sales forecasting model.
- Create an interactive Power BI dashboard with business insights and recommendations.

## Tools Used

- Microsoft Excel for the original dataset.
- Python for data cleaning, exploration, hypothesis testing, and forecasting.
- SQL and PostgreSQL for querying and analysing sales data.
- Power BI for the interactive dashboard.
- Jupyter Notebook for documenting the analysis.

## Dataset

The dataset contains 10,035 sales records covering January to December 2025. It includes information about sales, products, customers, stores, prices, discounts, promotions, and payment methods.

## Project Structure

- `data/` — Original and processed datasets.
- `notebooks/` — Notebooks for exploratory data analysis, hypothesis testing, and forecasting.
- `scripts/` — Python scripts used for data preparation.
- `sql/` — SQL queries for sales analysis.
- `reports/` — Data quality and analysis reports.
- `Power BI/` — Power BI dashboard file.
- `README.md` — Project documentation.

## How to Reproduce the Analysis

1. Clone or download this repository.
2. Install Python and the required packages listed in `requirements.txt`.
3. Open the notebooks in the `notebooks/` folder and run them in the documented order.
4. Follow the PostgreSQL setup instructions and run the SQL queries in the `sql/` folder.
5. Open `Power BI/BI.pbix` in Power BI Desktop to explore the dashboard.

## Key Findings

The analysis recorded approximately KES 6.73 million in net sales across 5,000 transactions, with an average transaction value of approximately KES 1,350. Nairobi recorded the highest sales among the counties, and M-Pesa was the leading payment method by sales value. The dashboard allows users to explore monthly sales trends, product categories, promotions, payment methods, and county-level performance.

## Sales Forecasting

A Random Forest model was developed to forecast daily sales. It achieved a mean absolute error (MAE) of KES 6,097.06, improving on the baseline model by 18.59% on MAE. The model's results are documented in the forecasting notebook.

## Dashboard

The Power BI dashboard presents key performance indicators, monthly sales trends, county performance, product category comparisons, promotion analysis, and payment method analysis.

## Limitations

The dataset covers one year of sales and may not represent all future business conditions. The findings should be interpreted within the scope of the available data.

## Conclusion

This project demonstrates how retail sales data can be used to understand business performance, identify trends, and support inventory planning, promotion evaluation, and sales forecasting.

## Author: Wangechi Njoroge

Data Science and Analytics Capstone Project.
