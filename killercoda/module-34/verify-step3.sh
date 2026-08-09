#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the sales table loaded and the OLAP aggregate is correct.
lab="$HOME/bigdata-lab"
[ -f "$lab/warehouse.db" ] || { echo "warehouse.db not found — load the CSV into DuckDB as shown in Step 3."; exit 1; }
python3 - "$lab" <<'PY'
import sys, duckdb
lab = sys.argv[1]
con = duckdb.connect(f"{lab}/warehouse.db")
try:
    n = con.execute("SELECT count(*) FROM sales").fetchone()[0]
except Exception:
    print("Table 'sales' not found — run the CREATE TABLE step in Step 3."); sys.exit(1)
if n != 100000:
    print(f"Expected 100000 rows in 'sales', found {n} — re-generate (Step 2) and re-load (Step 3)."); sys.exit(1)
rows = con.execute("""SELECT region, year, count(*) AS c FROM sales GROUP BY region, year""").fetchall()
if len(rows) != 12:
    print(f"Expected 12 aggregate groups (4 regions x 3 years), got {len(rows)} — check the GROUP BY in Step 3."); sys.exit(1)
if sum(r[2] for r in rows) != 100000:
    print("Group counts do not sum to 100000 — the aggregate grain is wrong."); sys.exit(1)
print("Verified: 'sales' holds 100000 rows and the OLAP GROUP BY returns 12 correct groups. Nicely done.")
sys.exit(0)
PY
