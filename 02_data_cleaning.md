# Milestone 2: Data Cleaning and Preparation

## 1. Project Overview

This milestone involved inspecting, validating, cleaning and preparing the synthetic Kenyan retail sales dataset for further analysis. Python and pandas were used to create a repeatable workflow. The original Excel workbook was preserved, and processed data was saved separately.

## 2. Initial Dataset

The workbook contained six sheets:

| Sheet | Initial rows |
|---|---:|
| Raw_Sales | 10,035 |
| Customers | 1,200 |
| Stores | 18 |
| Products | 24 |
| Read_Me | 13 |
| Data_Dictionary | 18 |

The sales data covers 1 January to 31 December 2025. It contains transaction dates, products, quantities, prices, promotions, discounts, customer and store identifiers, and payment methods.

## 3. Data Quality Checks

The initial inspection checked column data types, missing values, exact duplicate rows, numeric values, date consistency and reference identifiers.

The sales sheet had 5,657 missing promotion labels. No missing values were found in the other sales columns. No exact duplicate rows were found in any sheet.

Further checks found:
- No duplicate transaction ID and line-number combinations.
- No invalid quantities, negative unit prices or negative net sales.
- No discount rates outside the range of 0 to 1.
- No mismatches in gross sales, discount amounts or net sales calculations within the chosen tolerance.
- No sales dates outside 2025 or disagreements between transaction date and transaction datetime.
- No sales references to unknown customers, stores or products.
- No duplicate customer, store or product identifiers.

## 4. Cleaning Decisions

The missing promotion labels were investigated. All 5,657 missing labels occurred on records with a zero discount rate, while none had a non-zero discount rate.

Based on this pattern, the missing labels were replaced with `No Promotion`. This is an assumption based on the synthetic dataset's structure and should be documented as such.

No sales records were deleted because the checks did not identify duplicate records or invalid sales values requiring removal. Existing sales calculations were retained because they passed validation.

## 5. Outlier Analysis

The interquartile range (IQR) method was applied to quantity, unit price, gross sales, discount rate, discount amount and net sales.

The analysis flagged:
- Quantity: 0
- Unit price: 844
- Gross sales: 734
- Discount rate: 297
- Discount amount: 1,331
- Net sales: 736

These counts are statistical flags, not confirmed errors. Investigation of discount rates found that the 297 flagged observations had a rate of 15% and were associated with Seasonal Promotion. They were retained because the pattern was consistent with the dataset's promotion structure.

No values were removed or capped during this outlier investigation.

## 6. Feature Engineering

Eight features were added to support exploratory analysis and forecasting:
- `year`
- `month`
- `month_name`
- `day_of_week`
- `day_of_week_number`
- `week_number`
- `is_weekend`
- `transaction_value_kes`

The transaction value was calculated as the total net sales for each transaction and repeated on its item lines. Analysts must avoid summing this repeated field across all item lines, as that would double-count transaction revenue.

## 7. Validation Results

The feature-engineered dataset retained 10,035 rows and contained 28 columns. All eight new features had zero missing values. The dataset contained the 12 months of 2025, with no invalid month or weekday values.

Transaction-level validation found no mismatched totals and no inconsistent stored transaction totals.

## 8. Output Files

The workflow produced:
- `data/processed/raw_sales.csv`
- `data/processed/customers.csv`
- `data/processed/stores.csv`
- `data/processed/products.csv`
- `data/processed/read_me.csv`
- `data/processed/data_dictionary.csv`
- `data/processed/sales_features.csv`
- `reports/data_quality_report.csv`
- `reports/outlier_analysis.csv`

Python scripts used:
- `scripts/clean_data.py`
- `scripts/outlier_analysis.py`
- `scripts/investigate_outliers.py`
- `scripts/feature_engineering.py`

## 9. Limitations and Next Steps

The dataset is simulated rather than real retailer data. The promotion interpretation is based on observed patterns and is not independently confirmed by a retailer.

The IQR method identifies unusual observations but cannot establish whether they are errors. Additional checks may be needed for product-specific prices, promotion rules and other business constraints.

The next stage is exploratory data analysis, including sales trends, product and store performance, customer segments and weekly patterns.

## 10. Reproducibility

The scripts were run locally using Python 3.14, pandas and openpyxl. The raw workbook remains unchanged. The workflow should be rerun from the project root using the documented scripts, and the generated outputs should be checked before submission.