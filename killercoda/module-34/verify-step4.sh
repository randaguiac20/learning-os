#!/bin/bash
# Killercoda step verifier: pass when sales.parquet exists and the aggregate over it matches the source.
lab="$HOME/bigdata-lab"
[ -f "$lab/sales.parquet" ] || { echo "sales.parquet not found — write it with COPY ... (FORMAT PARQUET) as in Step 4."; exit 1; }
[ -f "$lab/sales.csv" ] || { echo "sales.csv not found — re-generate the dataset in Step 2."; exit 1; }
python3 - "$lab" <<'PY'
import sys, os, duckdb
lab = sys.argv[1]
con = duckdb.connect()
n = con.execute(f"SELECT count(*) FROM read_parquet('{lab}/sales.parquet')").fetchone()[0]
if n != 100000:
    print(f"Expected 100000 rows in sales.parquet, found {n} — re-write it from the full table (Step 4)."); sys.exit(1)
# totals per region must match between the Parquet and the CSV source (consistency)
pq  = dict(con.execute(f"SELECT region, round(sum(amount),2) FROM read_parquet('{lab}/sales.parquet') GROUP BY region").fetchall())
csv = dict(con.execute(f"SELECT region, round(sum(amount),2) FROM read_csv_auto('{lab}/sales.csv') GROUP BY region").fetchall())
if pq != csv:
    print("Aggregate over sales.parquet does not match the CSV source — re-write the Parquet from 'sales'."); sys.exit(1)
if len(pq) != 4:
    print(f"Expected 4 regions, found {len(pq)} — check the dataset."); sys.exit(1)
# Parquet should be smaller than the CSV (columnar compression)
if os.path.getsize(f"{lab}/sales.parquet") >= os.path.getsize(f"{lab}/sales.csv"):
    print("sales.parquet is not smaller than sales.csv — did the COPY use FORMAT PARQUET?"); sys.exit(1)
print("Verified: sales.parquet has 100000 rows, aggregates match the CSV, and it is smaller (columnar). Well done.")
sys.exit(0)
PY
