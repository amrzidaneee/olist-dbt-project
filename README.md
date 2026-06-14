
# Olist E-Commerce Data Pipeline (dbt + DuckDB)

A data pipeline built with dbt and DuckDB on the Olist Brazilian E-Commerce dataset, following a Bronze → Silver → Gold layered architecture. The final tables feed a Power BI dashboard for sales, customer, and seller performance analysis.

## Architecture

![Lineage Graph](screenshots/lineage_graph.png)

```
seeds (raw CSVs)
    │
    ▼
staging (1:1 cleaned views, typed columns)
    │
    ▼
intermediate (joins + enrichment, deduplication)
    │
    ▼
marts (star schema: fact + dimensions)
    │
    ▼
Power BI Dashboard
```

## Tech Stack

- **dbt-core** with **DuckDB** adapter
- **Power BI** for visualization
- **dbt snapshots** for tracking changes over time

## Project Structure

```
models/
├── staging/        # 1:1 views over raw sources, light cleaning
├── intermediate/    # joins, deduplication, enrichment
└── marts/           # final star schema (fact + dims)

snapshots/           # SCD tracking for orders, sellers, reviews
seeds/               # raw Olist CSV files
```

## Data Model (Star Schema)

- **fact_order_items** — order line items with pricing, payment, and review info
- **dim_customers** — customer details with geolocation
- **dim_sellers** — seller details with geolocation
- **dim_products** — products with translated category names
- **dim_date** — date dimension for time-based analysis

## Key Decisions

- Used `source()` definitions instead of referencing seeds directly, to keep raw data clearly separated from transformed models.
- Geolocation joins use averaged lat/lng per zip code prefix to avoid row duplication (the raw geolocation table has multiple entries per zip code).
- Reviews are deduplicated to the most recent review per order before joining into the orders model.
- Snapshots track changes to order status, seller location, and review scores over time using the `check` strategy.

## Running the Project

```bash
# activate virtual environment
venv\Scripts\activate

# run all models
dbt run

# run tests
dbt test

# take snapshots
dbt snapshot

# generate documentation
dbt docs generate
dbt docs serve
```

## Tests

28 data tests covering uniqueness, not-null constraints, and referential integrity between the fact table and dimensions.

## Dashboard

The gold layer feeds a Power BI dashboard with sales trends, customer behavior, seller performance, and product category analysis.

![Dashboard](screenshots/dashboard_overview.png)

## Dataset

Built on the Olist Brazilian E-Commerce public dataset.
