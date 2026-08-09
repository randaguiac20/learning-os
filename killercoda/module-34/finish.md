# Done — you built a warehouse and a pipeline

In under 30 minutes you:

- Stood up **DuckDB**, an embedded **columnar** analytics database — a warehouse without a server.
- Generated a 100,000-row **CSV** dataset and loaded it into the store.
- Ran an **OLAP** aggregate (a big `GROUP BY`) — one scan, collapsed to 12 rows — the workload that
  would melt an OLTP database.
- Wrote **Parquet** and measured it **smaller and faster** than CSV — why the lakehouse stores columnar.
- **Partitioned** by year and did a partition-pruned read.
- Built an **idempotent, quality-checked batch ETL** (Extract → Transform → Load) and re-ran it safely.

**Back on the lesson page:** do the *Solo Lab* (MapReduce by hand, a non-idempotent load and its fix, a
data-quality gate, an architecture defense), the *Self-Check*, and tick the *Mastery checklist*. When
every box is honestly true, Module 35 (Software Engineering Practice) becomes current.

> The one-sentence takeaway: **M33 taught one database; M34 taught how to store, move, and process data
> at a scale one database can't hold — always chosen by the workload, never by fashion.**
