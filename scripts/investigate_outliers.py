
from pathlib import Path
import pandas as pd

PROJECT_ROOT = Path(__file__).resolve().parent.parent
DATA_FILE = PROJECT_ROOT / "data" / "processed" / "raw_sales.csv"

sales = pd.read_csv(DATA_FILE)

print("DISCOUNT RATE SUMMARY")
print(sales["discount_rate"].describe().to_string())

print("\nDISCOUNT RATE FREQUENCIES")
print(
    sales["discount_rate"]
    .value_counts(dropna=False)
    .sort_index()
    .to_string()
)

print("\nPROMOTION AND DISCOUNT RATE COMPARISON")
print(
    sales.groupby("promotion", dropna=False)["discount_rate"]
    .agg(["count", "min", "mean", "max"])
    .round(3)
    .to_string()
)

print("\nHIGHEST DISCOUNT RATE RECORDS")
print(
    sales.nlargest(10, "discount_rate")[
        [
            "transaction_id",
            "product_name",
            "promotion",
            "quantity",
            "unit_price_kes",
            "discount_rate",
            "discount_amount_kes",
            "net_sales_kes"
        ]
    ].to_string(index=False)
)
           