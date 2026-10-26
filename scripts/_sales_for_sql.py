
import pandas as pd
from pathlib import Path

project_folder = Path(__file__).resolve().parent.parent

input_file = project_folder / "data" / "processed" / "raw_sales.csv"
output_file = project_folder / "data" / "processed" / "sales_for_sql.csv"

df = pd.read_csv(input_file)

columns = [
    "transaction_id",
    "transaction_datetime",
    "transaction_date",
    "line_number",
    "store_id",
    "customer_id",
    "product_id",
    "quantity",
    "unit_price_kes",
    "gross_sales_kes",
    "promotion",
    "discount_rate",
    "discount_amount_kes",
    "net_sales_kes",
    "payment_method"
]

df[columns].to_csv(output_file, index=False)

print("Sales CSV prepared successfully.")
print("Rows:", len(df))
print("Columns:", len(columns))
print("Saved to:", output_file)
