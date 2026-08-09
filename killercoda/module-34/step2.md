# Step 2 — Generate a dataset

You need data too big to eyeball but easy for an OLAP query. Generate **100,000 rows** of sales as raw
**CSV** (Comma-Separated Values — a plain-text, *row*-oriented format). The seed is pinned so the data is
reproducible:

```bash
cd ~/bigdata-lab
python3 - <<'PY'
import csv, random
random.seed(34)                      # pinned seed -> reproducible data
regions = ["north","south","east","west"]
with open("sales.csv","w",newline="") as f:
    w = csv.writer(f); w.writerow(["id","region","year","amount"])
    for i in range(100_000):
        w.writerow([i, random.choice(regions),
                    random.choice([2023,2024,2025]),
                    round(random.uniform(10,500),2)])
print("wrote sales.csv")
PY
```{{exec}}

Count the lines (100,000 rows + 1 header) and note the file size:

```bash
wc -l sales.csv
```{{exec}}

```bash
ls -lh sales.csv
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- 100,001 lines — far too many to read by eye. That's the shape an **OLAP** (Online Analytical
  Processing — big scans/aggregations) query is *for*.
- Note the CSV size on disk. You'll compare it against the **Parquet** version in Step 4 and see why
  columnar storage is the lakehouse's on-disk format.
