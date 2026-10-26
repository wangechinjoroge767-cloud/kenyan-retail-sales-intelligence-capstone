
from pathlib import Path
import pandas as pd

# Locate the project and raw Excel workbook
PROJECT_ROOT = Path(__file__).resolve().parent.parent
RAW_FILE = PROJECT_ROOT / "data" / "kenyan_retail_capstone_raw_dataset.xlsx"

if not RAW_FILE.exists():
    raise FileNotFoundError(f"Excel file not found: {RAW_FILE}")

# Load every sheet for inspection
sheets = pd.read_excel(RAW_FILE, sheet_name=None)

print("=" * 60)
print("MILESTONE 2: INITIAL DATA QUALITY INSPECTION")
print("=" * 60)

for sheet_name, df in sheets.items():
    print(f"\nSHEET: {sheet_name}")
    print("-" * 40)

    # Number of rows and columns
    print(f"Rows: {df.shape[0]}")
    print(f"Columns: {df.shape[1]}")

    # Column names and data types
    print("\nColumn names and data types:")
    print(df.dtypes.to_string())

    # Missing values
    print("\nMissing values per column:")
    print(df.isna().sum().to_string())

    # Exact duplicate rows
    print(f"\nExact duplicate rows: {df.duplicated().sum()}")

    # Preview five records
    print("\nFirst five records:")
    print(df.head().to_string(index=False))

print("\nInspection complete. No data has been modified.")


# --------------------------------------------------
# SECOND INSPECTION: VALIDATION AND DATA QUALITY
# --------------------------------------------------

sales = sheets["Raw_Sales"].copy()
customers = sheets["Customers"]
stores = sheets["Stores"]
products = sheets["Products"]

print("\n" + "=" * 60)
print("DETAILED DATA QUALITY CHECKS")
print("=" * 60)

# 1. Check missing promotion labels against discount rates
missing_promotion = sales["promotion"].isna()
zero_discount = sales["discount_rate"].eq(0)

print("\n1. Promotion checks")
print("Missing promotion labels:", missing_promotion.sum())
print("Missing labels with zero discount:",
      (missing_promotion & zero_discount).sum())
print("Missing labels with a non-zero discount:",
      (missing_promotion & ~zero_discount).sum())

# 2. Check sales calculations
expected_gross = sales["quantity"] * sales["unit_price_kes"]
expected_discount = expected_gross * sales["discount_rate"]
expected_net = expected_gross - sales["discount_amount_kes"]

print("\n2. Sales calculation checks")
print("Gross sales mismatches:",
      ((sales["gross_sales_kes"] - expected_gross).abs() > 0.02).sum())
print("Discount amount mismatches:",
      ((sales["discount_amount_kes"] - expected_discount).abs() > 0.02).sum())
print("Net sales mismatches:",
      ((sales["net_sales_kes"] - expected_net).abs() > 0.02).sum())

# 3. Check invalid quantities and prices
print("\n3. Invalid numeric values")
print("Zero or negative quantities:", (sales["quantity"] <= 0).sum())
print("Negative unit prices:", (sales["unit_price_kes"] < 0).sum())
print("Negative net sales:", (sales["net_sales_kes"] < 0).sum())
print("Discount rates outside 0 to 1:",
      ((sales["discount_rate"] < 0) |
       (sales["discount_rate"] > 1)).sum())

# 4. Check transaction line identifiers
print("\n4. Transaction identifier checks")
print("Duplicate transaction ID + line number:",
      sales.duplicated(["transaction_id", "line_number"]).sum())

# 5. Check transaction dates
print("\n5. Date checks")
print("Transaction dates outside 2025:",
      ((sales["transaction_date"] < "2025-01-01") |
       (sales["transaction_date"] >= "2026-01-01")).sum())

date_mismatch = (
    sales["transaction_datetime"].dt.date !=
    sales["transaction_date"].dt.date
)
print("Date and datetime disagreements:", date_mismatch.sum())

# 6. Check references to customers, stores and products
print("\n6. Reference checks")
print("Sales with unknown customers:",
      (~sales["customer_id"].isin(customers["customer_id"])).sum())
print("Sales with unknown stores:",
      (~sales["store_id"].isin(stores["store_id"])).sum())
print("Sales with unknown products:",
      (~sales["product_id"].isin(products["product_id"])).sum())

# 7. Check unique identifiers in reference tables
print("\n7. Reference table identifier checks")
print("Duplicate customer IDs:", customers["customer_id"].duplicated().sum())
print("Duplicate store IDs:", stores["store_id"].duplicated().sum())
print("Duplicate product IDs:", products["product_id"].duplicated().sum())

print("\nDetailed inspection complete. No data has been modified.")



# --------------------------------------------------
# MILESTONE 2: DATA CLEANING PIPELINE
# --------------------------------------------------

print("\n" + "=" * 60)
print("DATA CLEANING PIPELINE")
print("=" * 60)

# Create output folders
OUTPUT_DIR = PROJECT_ROOT / "data" / "processed"
REPORT_DIR = PROJECT_ROOT / "reports"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
REPORT_DIR.mkdir(parents=True, exist_ok=True)

# Work on copies so the raw data remains unchanged
cleaned_sheets = {
    name: df.copy()
    for name, df in sheets.items()
}

cleaned_sales = cleaned_sheets["Raw_Sales"]

# Record data quality before cleaning
quality_records = []

for sheet_name, df in cleaned_sheets.items():
    quality_records.append({
        "sheet": sheet_name,
        "stage": "before",
        "rows": len(df),
        "columns": len(df.columns),
        "missing_cells": int(df.isna().sum().sum()),
        "exact_duplicate_rows": int(df.duplicated().sum())
    })

# Cleaning decision 1:
# Missing promotion labels occur only where discount_rate is zero.
# Treat these as sales without a promotion.
missing_before = int(cleaned_sales["promotion"].isna().sum())

cleaned_sales["promotion"] = (
    cleaned_sales["promotion"]
    .fillna("No Promotion")
)

print("Missing promotion labels replaced:", missing_before)
print(
    "Promotion labels remaining missing:",
    int(cleaned_sales["promotion"].isna().sum())
)

# Record data quality after cleaning
for sheet_name, df in cleaned_sheets.items():
    quality_records.append({
        "sheet": sheet_name,
        "stage": "after",
        "rows": len(df),
        "columns": len(df.columns),
        "missing_cells": int(df.isna().sum().sum()),
        "exact_duplicate_rows": int(df.duplicated().sum())
    })

# Save cleaned sheets as CSV files
for sheet_name, df in cleaned_sheets.items():
    output_file = OUTPUT_DIR / f"{sheet_name.lower()}.csv"
    df.to_csv(output_file, index=False)
    print(f"Saved: {output_file.name}")

# Save before-and-after quality report
quality_report = pd.DataFrame(quality_records)

report_file = REPORT_DIR / "data_quality_report.csv"
quality_report.to_csv(report_file, index=False)

print(f"\nQuality report saved: {report_file}")
print("\nCleaning summary:")
print(
    quality_report[
        ["sheet", "stage", "rows", "missing_cells",
         "exact_duplicate_rows"]
    ].to_string(index=False)
)

print("\nCleaning pipeline completed.")
print("The original Excel workbook has not been modified.")



