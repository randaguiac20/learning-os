# Databases & SQL — hands-on

You have a real Linux machine on the right and `sqlite3` — a full SQL database in a single file, zero
setup. In the next few minutes you'll **model** a small domain into two related tables with a **foreign
key**, **insert** data (and watch the foreign key reject a bad row), run a **JOIN** with a **GROUP BY**
aggregate, prove a **transaction** is all-or-nothing (`COMMIT` vs `ROLLBACK`), add an **index** and see the
planner use it, and fix a **redundant column** the way normalization prescribes.

All work lives inside a throwaway `~/db-lab/` directory — nothing outside it is touched.

The one law of this module: **write the SQL by hand and predict each result before you run it.** You only
own joins and aggregates once you've debugged your own.

Click **START** to begin.
