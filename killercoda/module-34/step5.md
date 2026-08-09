# Step 5 — Partition, then a tiny batch ETL script

**Partitioning** physically splits a dataset by a key — here one folder per `year` — so a query filtered
on that key reads *only* the matching partition (**partition pruning**) and skips the rest. Write a
partitioned copy:

```bash
cd ~/bigdata-lab
python3 - <<'PY'
import duckdb
con = duckdb.connect("warehouse.db")
con.execute("COPY sales TO 'by_year' (FORMAT PARQUET, PARTITION_BY (year))")
PY
```{{exec}}

See the `year=...` subfolders, then read back **one** partition (pruned — less data scanned):

```bash
find by_year -type f
```{{exec}}

```bash
python3 -c "import duckdb; print(duckdb.sql(\"SELECT count(*) FROM read_parquet('by_year/*/*.parquet') WHERE year=2024\").fetchall())"
```{{exec}}

Now the whole loop in one **batch ETL** (Extract → Transform → Load) script — with a **data-quality
gate** and an **idempotent** load:

```bash
cat > etl.py <<'PY'
import duckdb
con = duckdb.connect()
# EXTRACT: read the raw CSV source
con.execute("CREATE TABLE raw AS SELECT * FROM read_csv_auto('sales.csv')")
# TRANSFORM: filter + aggregate (the reshape) -- high-value sales per region/year
con.execute("""CREATE TABLE mart AS
    SELECT region, year, round(sum(amount),2) AS total, count(*) AS n
    FROM raw WHERE amount >= 100 GROUP BY region, year""")
# DATA-QUALITY GATE: no NULL keys, expect 12 groups -- fail loudly otherwise
bad = con.execute("SELECT count(*) FROM mart WHERE region IS NULL OR year IS NULL").fetchone()[0]
assert bad == 0, "quality check failed: NULL keys"
groups = con.execute("SELECT count(*) FROM mart").fetchone()[0]
assert groups == 12, f"quality check failed: expected 12 groups, got {groups}"
# LOAD: idempotent overwrite (re-running produces the same file, no duplicates)
con.execute("COPY mart TO 'mart.parquet' (FORMAT PARQUET)")
print("ETL ok -- rows:", groups)
PY
```{{exec}}

Run it **twice** — idempotent means the second run produces the same result, not duplicates:

```bash
python3 etl.py
```{{exec}}

```bash
python3 etl.py
```{{exec}}

You built the data platform in miniature: a columnar warehouse (DuckDB), an OLAP aggregate, Parquet
(smaller + faster than CSV), a partitioned read, and an **idempotent, quality-checked** batch ETL. Every
one of these is the small, honest version of what a real data engineer builds at scale — chosen by the
workload, never by fashion.
