
from pathlib import Path
import pandas as pd

# Locate the project folders
PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_FILE = PROJECT_ROOT / "data" / "processed" / "raw_sales.csv"
REPORT_DIR = PROJECT_ROOT / "reports"

REPORT_DIR.mkdir(parents=True, exist_ok=True)

# Read the already-cleaned sales CSV instead of the Excel workbook
sales = pd.read_csv(DATA_FILE)

print("Cleaned sales data loaded successfully.")
print(f"Rows loaded: {len(sales)}")

# Numeric fields to investigate for unusual values
numeric_columns = [
    "quantity",
    "unit_price_kes",
    "gross_sales_kes",
    "discount_rate",
    "discount_amount_kes",
    "net_sales_kes"
]

results = []

for column in numeric_columns:
    q1 = sales[column].quantile(0.25)
    q3 = sales[column].quantile(0.75)
    iqr = q3 - q1

    lower_limit = q1 - 1.5 * iqr
    upper_limit = q3 + 1.5 * iqr

    unusual = (
        (sales[column] < lower_limit) |
        (sales[column] > upper_limit)
    )

    results.append({
        "column": column,
        "q1": q1,
        "q3": q3,
        "iqr": iqr,
        "lower_limit": lower_limit,
        "upper_limit": upper_limit,
        "outlier_count": int(unusual.sum())
    })

    print(f"\n{column}")
    print(f"  Lower limit: {lower_limit:.2f}")
    print(f"  Upper limit: {upper_limit:.2f}")
    print(f"  Values flagged: {int(unusual.sum())}")

# Save the findings
report = pd.DataFrame(results)
output_file = REPORT_DIR / "outlier_analysis.csv"
report.to_csv(output_file, index=False)

print(f"\nReport saved to: {output_file}")
print("No sales records were changed or removed.")
