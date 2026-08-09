# Step 4 — Write Parquet — compare size and speed vs CSV

**Parquet** is an open **columnar** file format (each column stored contiguously and compressed) — the
on-disk shape that lets a lake or lakehouse behave like a warehouse. Write your table to Parquet, then
compare it against the CSV on **size** and **scan speed**:

```bash
cd ~/bigdata-lab
python3 - <<'PY'
import duckdb, os, time
con = duckdb.connect("warehouse.db")
con.execute("COPY sales TO 'sales.parquet' (FORMAT PARQUET)")   # columnar output
csv_sz = os.path.getsize("sales.csv")
pq_sz  = os.path.getsize("sales.parquet")
print(f"CSV    : {csv_sz:>9,} bytes")
print(f"Parquet: {pq_sz:>9,} bytes  ({csv_sz/pq_sz:.1f}x smaller)")
for src in ["sales.csv","sales.parquet"]:
    if src.endswith("parquet"):
        q = f"SELECT region, sum(amount) FROM read_parquet('{src}') GROUP BY region"
    else:
        q = f"SELECT region, sum(amount) FROM read_csv_auto('{src}') GROUP BY region"
    t = time.time(); con.execute(q).fetchall()
    print(f"{src:14} {time.time()-t:.4f}s")
PY
```{{exec}}

See both files side by side:

```bash
ls -lh sales.csv sales.parquet
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- **Smaller:** Parquet stores each column contiguously, so similar values sit together and compress far
  better than CSV's row-by-row text. That's why a **lakehouse** stores Parquet — cheap storage.
- **Faster:** the aggregate touches only the columns it needs; the columnar layout reads less. Cheap
  *and* fast is the whole lakehouse promise.

Click **Check** to verify `sales.parquet` exists and answers the aggregate correctly (100,000 rows,
totals consistent with the CSV).
