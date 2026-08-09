# Big Data & Data Architecture — hands-on

You have a real Linux machine on the right. In the next few minutes you'll stand up a real **analytics
warehouse** — **DuckDB**, an embedded column-oriented database (the "SQLite of analytics": one
`pip install`, no server) — and feel the core of the module:

- generate a **100,000-row dataset** as raw **CSV** (a row-oriented text format),
- load it into a **columnar** store and run an **OLAP** aggregate (a big `GROUP BY`),
- write **Parquet** (a columnar file format) and measure it **smaller and faster** than CSV,
- do a **partitioned** read, and
- build a tiny, **idempotent**, quality-checked **batch ETL** script (Extract → Transform → Load).

Everything lives in a throwaway `~/bigdata-lab/` directory — nothing outside it is touched.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms.

Click **START** to begin.
