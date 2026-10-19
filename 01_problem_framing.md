# Milestone 1 — Problem Framing and Data Acquisition

## Problem statement
Jirani Mart (a fictional Kenyan retail chain) has 18 stores across 8 counties. Management wants to know where its sales come from, whether its promotions are worth the discount it gives away, how customers pay, which customers are buying less often, and what sales to plan for in the coming weeks. This project turns one year of transaction data (1 Jan – 31 Dec 2025) into answers a store or regional manager can act on.

## Business questions
| # | Question | Milestone that answers it |
|---|----------|---------------------------|
| Q1 | Which stores, counties and product categories drive the most net sales, and how does that change through the year? | EDA (3), SQL (4) |
| Q2 | Are there seasonal or weekly patterns (weekends, month-end, public holidays)? | EDA (3), Statistics (5) |
| Q3 | Did promotions work? Do discounted lines or baskets sell more than undiscounted ones? | Statistics (5) |
| Q4 | Do M-Pesa customers spend differently from cash and card customers? | Statistics (5) |
| Q5 | Which customers are loyal, which are drifting away (recency, frequency, monetary value)? | SQL (4) |
| Q6 | What weekly sales should the chain expect next? | Model (6), Dashboard (7) |

## Success measures
- **Business:** net sales (KES), average basket value, number of transactions, share of sales by payment method, discount as a % of gross sales, customers inactive for 90+ days.
- **Statistical:** a promotion effect is reported with a confidence interval and p-value, with assumptions checked.
- **Model:** the forecast must beat a seasonal-naive baseline on a time-ordered hold-out set (measured by MAE and MAPE).
- **Delivery:** every milestone is reproducible from the raw file with one command.

## Data I need
1. Transaction lines (date, store, customer, product, quantity, price, promotion, payment method).
2. Store, product and customer master tables.
3. Public context: Kenyan public holidays and monthly KNBS CPI/inflation, joined to sales by date or month.

## Scope and limits
- The data covers one year only, so seasonality is observed once and cannot be confirmed across years. The forecast is therefore weekly, not monthly (monthly would leave only 12 points).
- The data is **synthetic**. Findings describe this simulated dataset and are not real evidence about Kenyan retail. No real M-Pesa records are included; the payment method is a label only.
- "Churn" cannot be measured properly with one year of history, so I use recency as a churn proxy rather than a true churn label.
