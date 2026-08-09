# Done — you can store data properly now

In about 30 minutes you:

- **Modeled** a normalized schema — `users` and `orders` linked by a **foreign key**, with `PRIMARY KEY`,
  `UNIQUE`, `NOT NULL`, and `CHECK` constraints enforcing correctness.
- **Inserted** data and watched **referential integrity** reject an order for a user who doesn't exist.
- Ran a **JOIN with a GROUP BY aggregate**, and saw why `LEFT JOIN` keeps Grace while `INNER JOIN` drops her.
- Proved a **transaction** is all-or-nothing — `COMMIT` makes it permanent, `ROLLBACK` undoes it entirely
  (atomicity, the A in ACID).
- Added an **index** and read `EXPLAIN QUERY PLAN` change from a scan to a B-tree **index search** (M32's
  `O(n) → O(log n)`).
- **Normalized** a redundant column out of a wide table, killing the update anomaly at the structure.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back) and tick the *Mastery checklist*.
When every box is honestly true, Module 34 (Big Data & Data Architecture) becomes current — where this
relational (OLTP) database becomes one end of a spectrum that includes warehouses, lakes, and streams.

> The one-sentence takeaway: **SQL declares WHAT you want and the planner uses an index (M32's B-tree) to
> fetch it fast; normalization keeps the data honest and transactions keep it trustworthy — the
> persistence foundation every real service stands on.**
