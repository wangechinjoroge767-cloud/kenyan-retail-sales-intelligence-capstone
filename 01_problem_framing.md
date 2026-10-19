# Milestone 1: Problem Framing and Data Acquisition

## 1. Problem Statement

Jirani Mart is a fictional Kenyan retail chain operating 18 stores across 8 counties. Like many growing retail businesses, the company needs to understand its sales performance, customer purchasing behaviour and product demand to support better business decisions.

This project will analyse sales transactions recorded between January and December 2025 to identify the stores and products generating the most revenue, understand customer spending patterns, assess promotional activities and predict future sales.

The main goal is to use data analysis, statistical methods, SQL and predictive modelling to generate useful insights that can help retail management make informed decisions.

## 2. Business Questions

The project aims to answer the following questions:

1. Which stores, counties and product categories contribute the most to total sales revenue?
2. How do sales change across different months, weekdays, weekends and public holidays?
3. How do promotions and discounts relate to sales performance?
4. What are the most commonly used payment methods, and how does customer spending differ between M-Pesa, cash and card payments?
5. Which customers purchase frequently, and which customers show signs of becoming inactive?
6. Can historical sales data be used to forecast sales for the coming weeks?

## 3. Project Objectives

- Analyse sales performance across different stores, counties and product categories.
- Identify customer purchasing patterns using transaction history.
- Examine the relationship between promotional activities and sales.
- Analyse payment preferences, particularly the use of M-Pesa.
- Identify loyal and potentially inactive customers using Recency, Frequency and Monetary (RFM) analysis.
- Develop and evaluate a predictive model for forecasting future sales.
- Present findings through an interactive Power BI dashboard.

## 4. Success Measures

The success of this project will be measured through the following indicators:

**Business Performance**

- Total net sales revenue in Kenyan shillings (KES).
- Total number of transactions and average transaction value.
- Revenue contribution by store, county and product category.
- Sales contribution by payment method.
- Customer purchasing frequency and recency.
- Discounts as a percentage of gross sales.

**Statistical Analysis**

Appropriate hypothesis tests and confidence intervals will be used to investigate differences in sales performance across promotions and payment methods. The assumptions of each test will be checked before interpreting the results.

**Predictive Modelling**

The forecasting model will be evaluated using Mean Absolute Error (MAE) and Mean Absolute Percentage Error (MAPE), where appropriate. Its performance will be compared against a simple seasonal-naive baseline using time-ordered validation.

**Project Delivery**

The project will include reproducible Python notebooks, PostgreSQL queries, documented data sources, an interactive dashboard and a GitHub repository containing the necessary files.

## 5. Data Requirements

The project will use the following datasets:

1. **Retail Sales Data:** Transaction dates, product details, quantities, prices, discounts, promotions, payment methods and customer identifiers.
2. **Store Data:** Store identifiers, locations and counties.
3. **Product Data:** Product identifiers, names, categories and prices.
4. **Customer Data:** Customer identifiers, locations and customer segments.
5. **Public Kenyan Data:** Public holiday dates and selected economic indicators, such as inflation rates from the Kenya National Bureau of Statistics (KNBS), to provide additional context for sales analysis.

## 6. Project Scope and Limitations

The analysis will focus on transactions from 1 January to 31 December 2025.

The retail dataset is synthetic and was generated for educational purposes. It does not contain actual customer transactions or real M-Pesa payment records. Therefore, the findings will demonstrate analytical methods rather than describe the performance of an actual Kenyan retailer.

Since the dataset covers only one year, the analysis can identify patterns within 2025 but cannot establish whether those patterns repeat consistently across multiple years.

Customer inactivity will be assessed using purchasing recency and frequency rather than confirmed customer churn.

Sales forecasting will focus on weekly sales because weekly aggregation provides more observations for model training and evaluation than monthly aggregation.
