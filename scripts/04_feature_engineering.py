
from pathlib import Path
import pandas as pd

PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_FILE = PROJECT_ROOT / "data" / "processed" / "raw_sales.csv"
OUTPUT_DIR = PROJECT_ROOT / "data" / "processed"

sales = pd.read_csv(DATA_FILE, parse_dates=["transaction_datetime", "transaction_date"])

# Create useful calendar features
sales["year"] = sales["transaction_date"].dt.year
sales["month"] = sales["transaction_date"].dt.month
sales["month_name"] = sales["transaction_date"].dt.month_name()
sales["day_of_week"] = sales["transaction_date"].dt.day_name()
sales["day_of_week_number"] = sales["transaction_date"].dt.dayofweek
sales["week_number"] = sales["transaction_date"].dt.isocalendar().week.astype(int)
sales["is_weekend"] = sales["day_of_week_number"] >= 5

# Create transaction-level value
sales["transaction_value_kes"] = (
    sales.groupby("transaction_id")["net_sales_kes"].transform("sum")
)

# Save the feature-engineered data separately
output_file = OUTPUT_DIR / "sales_features.csv"
sales.to_csv(output_file, index=False)

print("Feature engineering completed.")
print(f"Rows: {len(sales)}")
print("New features:")
print("year, month, month_name, day_of_week,")
print("day_of_week_number, week_number, is_weekend,")
print("transaction_value_kes")
print(f"Saved to: {output_file}")

print("\nFeature preview:")
print(
    sales[
        [
            "transaction_date",
            "month_name",
            "day_of_week",
            "is_weekend",
            "net_sales_kes",
            "transaction_value_kes"
        ]
    ].head().to_string(index=False)
)

# --------------------------------------------------
# STEP 22: FEATURE VALIDATION
# --------------------------------------------------

print("\n" + "=" * 50)
print("FEATURE VALIDATION")
print("=" * 50)

# Check for missing values in the new features
new_features = [
    "year",
    "month",
    "month_name",
    "day_of_week",
    "day_of_week_number",
    "week_number",
    "is_weekend",
    "transaction_value_kes"
]

print("\nMissing values in new features:")
print(sales[new_features].isna().sum().to_string())

# Check calendar values
print("\nCalendar validation:")
print("Years found:", sorted(sales["year"].unique()))
print("Months found:", sorted(sales["month"].unique()))
print(
    "Invalid month values:",
    (~sales["month"].between(1, 12)).sum()
)
print(
    "Invalid weekday numbers:",
    (~sales["day_of_week_number"].between(0, 6)).sum()
)

# Check that transaction totals agree across item lines
transaction_totals = sales.groupby("transaction_id").agg(
    calculated_total=("net_sales_kes", "sum"),
    stored_total=("transaction_value_kes", "first"),
    total_versions=("transaction_value_kes", "nunique")
)

print("\nTransaction total validation:")
print(
    "Transactions with mismatched totals:",
    (
        (transaction_totals["calculated_total"] -
         transaction_totals["stored_total"]).abs() > 0.02
    ).sum()
)
print(
    "Transactions with inconsistent stored totals:",
    (transaction_totals["total_versions"] > 1).sum()
)

# Confirm the output file exists and has the expected row count
saved_sales = pd.read_csv(OUTPUT_DIR / "sales_features.csv")

print("\nSaved dataset validation:")
print("Saved rows:", len(saved_sales))
print("Saved columns:", len(saved_sales.columns))
print("Feature validation complete.")
