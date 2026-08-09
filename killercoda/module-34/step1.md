# Step 1 — Install the bench (DuckDB)

Before any data, install the tool. **DuckDB** is a *column-oriented*, in-process analytics database — a
real warehouse engine you run without a server (the "SQLite of analytics"). It reads CSV and Parquet
directly.

Install `pip` (harmless if already present), then DuckDB:

```bash
apt-get update -qq && apt-get install -y python3-pip
```{{exec}}

```bash
pip install duckdb
```{{exec}}

Make a throwaway working directory — everything in this lab lives here:

```bash
mkdir -p ~/bigdata-lab && cd ~/bigdata-lab
```{{exec}}

Confirm it imports and print the version:

```bash
python3 -c "import duckdb; print('duckdb', duckdb.__version__)"
```{{exec}}

**Why an embedded engine?** No cluster, no cloud, no server process — just a library you `import`. It's
the *model* of a warehouse: the same columnar storage and SQL analytics you'd get from Snowflake or
BigQuery, small enough to run on this box. Perfect for feeling the concepts before you ever touch scale.
