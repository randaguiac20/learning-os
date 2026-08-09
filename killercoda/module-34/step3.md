# Step 3 — Load into DuckDB and run an OLAP aggregate

Load the raw CSV into a DuckDB table (a persistent `warehouse.db` file), then run the **OLAP** query — a
big `GROUP BY` that scans all 100,000 rows and collapses them into a handful of aggregates:

```bash
cd ~/bigdata-lab
python3 - <<'PY'
import duckdb
con = duckdb.connect("warehouse.db")            # a persistent DuckDB file
con.execute("CREATE OR REPLACE TABLE sales AS SELECT * FROM read_csv_auto('sales.csv')")
print("rows loaded:", con.execute("SELECT count(*) FROM sales").fetchone()[0])
rows = con.execute("""
    SELECT region, year, round(sum(amount),2) AS total, count(*) AS n
    FROM sales GROUP BY region, year ORDER BY region, year
""").fetchall()
for r in rows: print(r)
PY
```{{exec}}

You get **12 aggregate rows** (4 regions × 3 years) out of 100,000 input rows — one scan, collapsed.

**This is the OLTP-vs-OLAP split made real.** That `GROUP BY region, year` is an **OLAP** workload: one
big sequential scan and aggregation. Run against an **OLTP** (Online Transaction Processing) database —
row-oriented, tuned for tiny point lookups — it would compete with and starve the transactional traffic.
Here it runs on a **columnar** engine built exactly for it: it reads only the columns the query touches.

> `CREATE OR REPLACE` matters: re-running this step *replaces* the table rather than appending — an
> early taste of **idempotency** (re-run = same result, no duplicates), the pipeline property you'll
> lean on in Step 5.

Click **Check** to verify the table loaded (100,000 rows) and the aggregate is correct (12 groups).
