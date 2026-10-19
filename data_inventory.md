# Data inventory

| # | Source | What it contains | How obtained | Licence / terms | Status |
|---|--------|------------------|--------------|-----------------|--------|
| 1 | `kenyan_retail_capstone_raw_dataset.xlsx` (sheets Raw_Sales, Customers, Stores, Products, Read_Me, Data_Dictionary) | 10,035 sales lines, 5,000 transactions, 1,200 customers (1,176 with purchases), 18 stores, 24 products, 1 Jan – 31 Dec 2025 | Provided with the capstone as an author-generated practice file | Synthetic data generated for this capstone; its Read_Me says not to present it as real Kenyan retail evidence and to check institutional rules before submission | In repo: `data/raw/` |
| 2 | Kenyan public holidays 2025 | Date and name of each public holiday | Python package `holidays` (`holidays.KE`) | MIT licence (package). Holiday dates are public facts; two dates (Idd-ul-Fitr, Mar 30–31) are estimated by the package, so check them against the official Kenya Gazette notice | Joined in Milestone 2 |
| 3 | KNBS Consumer Price Index and inflation, monthly 2025 | CPI index and year-on-year inflation by month | **To do:** download from the Kenya National Bureau of Statistics (knbs.or.ke, CPI and inflation reports) and type the 12 monthly values into `data/external/kenya_cpi_2025.csv` | KNBS publishes these statistics publicly; read and cite the terms of use on the KNBS website and record the access date here | Template created, values blank |

## Not used (and why)
County population (KNBS census) is a good extra for per-capita comparisons but is not needed for the six questions above.

## Key variables and data dictionary
See the `Data_Dictionary` sheet in the raw file. The main fields I engineer in Milestone 2 are in `notebooks/02_data_cleaning.ipynb`.
