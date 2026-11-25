
# E-commerce Analytics Pipeline

An end-to-end analytics pipeline on Google BigQuery, built with dbt and
scheduled daily with GitHub Actions, feeding a Looker Studio dashboard.

**Live dashboard:** [link]

## Architecture
BigQuery public dataset (thelook_ecommerce)
  -> dbt staging views (cleaning, renaming, PII removed)
  -> dbt mart tables (fct_daily_sales, dim_customers)
  -> dbt tests on every run (unique, not_null, accepted_values, relationships)
  -> Looker Studio dashboard
Orchestration: GitHub Actions runs `dbt build` daily at 06:00 UTC.

## Data governance
Customer names, emails, street addresses, postcodes and coordinates are
dropped in the staging layer (GDPR data minimisation). Authentication is
keyless: gcloud login locally, Workload Identity Federation in GitHub Actions.

## Tech stack
BigQuery, dbt Core, SQL, GitHub Actions, Looker Studio, Python

## Run it yourself
1. Create a BigQuery sandbox project and a service account key.
2. pip install dbt-core dbt-bigquery
3. Set GCP_PROJECT_ID and DBT_KEYFILE, then run: dbt build

## Next steps
- Incremental models once billing is enabled
- A RAG assistant that answers questions about the data catalogue
