
# # Data Inventory — Jirani Mart Capstone

## 1. Purpose

This inventory documents the datasets used in the Jirani Mart Customer and Sales Intelligence capstone. It records their sources, acquisition methods, dates obtained, contents, file locations and applicable terms of use.

## 2. Dataset Register

| Dataset | Source | Date Obtained / Prepared | Description |
|---|---|---|---|
| Jirani Mart Retail Sales | Simulated capstone dataset supplied for the project | Original acquisition date to be confirmed | Contains sales transactions, customers, products, stores, prices, discounts and payment methods. |
| Kenya Public Holidays 2025 | Kenya Gazette and official government declarations | 5 November 2026 (prepared for this project; verify actual retrieval date) | Contains public holiday dates, names and classifications for 2025. |
| Kenya CPI 2025 | Kenya National Bureau of Statistics (KNBS), Economic Survey 2026 | 5 November 2026 (prepared for this project; verify actual retrieval date) | Contains monthly national Consumer Price Index figures for 2025. |

## 3. Source Information

### A. Jirani Mart Retail Sales Dataset

- **File:** `kenyan_retail_capstone_raw_dataset.xlsx`
- **Location:** `data/`
- **Type:** Simulated retail dataset.
- **Acquisition method:** Supplied as the original project dataset.
- **Usage:** Used for the main sales analysis, customer analysis, forecasting and dashboard development.
- **Terms:** Use subject to the dataset's original course or project distribution conditions.

### B. Kenya Public Holidays 2025

- **File:** `kenya_public_holidays.csv`
- **Location:** `data/external/`
- **Source:** Kenya Gazette and official government public holiday declarations.
- **Acquisition method:** Public holiday information was compiled into CSV format using official government publications.
- **Supporting documents:**
  - Kenya Gazette, 4 June 2025 — Gazette Notice No. 7317, declaring Eid-ul-Adha on 6 June 2025.
  - Kenya Gazette, 16 October 2025 — Gazette Notice No. 15007, declaring 17 October 2025 a special public holiday.
- **Supporting files:** Original Gazette PDFs are stored in `data/external/sources/public_holiday_records/`.
- **Source links:**
  - [Kenya Gazette — 4 June 2025](https://new.kenyalaw.org/akn/ke/officialGazette/2025-06-04/116/eng@2025-06-04/source)
  - [Kenya Gazette — 16 October 2025](https://new.kenyalaw.org/akn/ke/officialGazette/2025-10-16/214/eng@2025-10-16/source)
- **Usage:** Provides calendar context for examining sales activity around public holidays.
- **Terms:** Public information. Source attribution is retained, and the original publication terms should be respected.

### C. Kenya Consumer Price Index (CPI) 2025

- **File:** `knbs_cpi.csv`
- **Location:** `data/external/`
- **Source:** Kenya National Bureau of Statistics (KNBS), Economic Survey 2026.
- **Supporting document:** `knbs_economic_survey_2026.pdf`
- **Supporting document location:** `data/external/sources/`
- **Reference:** Table 3.22 — Consumer Price Indices and Rates of Inflation.
- **Acquisition method:** Monthly CPI figures for 2025 were transcribed from the KNBS publication into CSV format.
- **Official source:** [Kenya National Bureau of Statistics](https://www.knbs.or.ke/)
- **Usage:** Provides economic context for examining monthly retail sales patterns alongside changes in consumer prices.
- **Terms:** KNBS statistical information. Acknowledge KNBS as the source and follow the publication's reuse conditions.

## 4. Data Limitations

- The Jirani Mart retail dataset is simulated and does not represent verified sales from an actual retailer.
- Public holiday dates may depend on official declarations and religious calendar announcements.
- CPI represents changes in the general price level; it does not measure the prices of Jirani Mart products specifically.
- Monthly CPI comparisons do not establish that inflation caused changes in retailer sales.
- External datasets should be checked against their original publications before final analysis.

## 5. Data Files and Supporting Documents

| File / Folder | Description |
|---|---|
| `kenya_public_holidays.csv` | Kenyan public holidays for 2025 |
| `knbs_cpi.csv` | Monthly national CPI figures for 2025 |
| `data_inventory.md` | Documentation of dataset sources and usage |
| `sources/knbs_economic_survey_2026.pdf` | KNBS publication supporting the CPI figures |
| `sources/public_holiday_records/` | Supporting Kenya Gazette publications for public holiday declarations |

## 6. Data Use in the Analysis

The external datasets provide additional context for interpreting the simulated retail sales data.

- Public holidays can be used to investigate whether sales activity changes around holiday periods.
- CPI can provide background on changes in the national price level during the study period.
- These external indicators support contextual analysis but do not establish direct causal relationships with sales performance.