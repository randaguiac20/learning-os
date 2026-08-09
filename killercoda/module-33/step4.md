# Step 4 — A transaction (COMMIT and ROLLBACK), then an index

A **transaction** groups statements into one all-or-nothing unit. A committed one is permanent:

```bash
sqlite3 ~/db-lab/shop.db <<'SQL'
BEGIN;
INSERT INTO orders (user_id, total) VALUES (3, 8.75);
COMMIT;
SQL
sqlite3 ~/db-lab/shop.db "SELECT COUNT(*) AS orders_after_commit FROM orders;"
```{{exec}}

A **rolled-back** transaction leaves no trace — inside it the change is visible, but `ROLLBACK` undoes
everything as if it never happened:

```bash
sqlite3 ~/db-lab/shop.db <<'SQL'
BEGIN;
DELETE FROM orders;
SELECT COUNT(*) AS during_txn FROM orders;
ROLLBACK;
SELECT COUNT(*) AS after_rollback FROM orders;
SQL
```{{exec}}

You see `during_txn = 0` (all orders gone inside the transaction) then `after_rollback = 4` (every one
restored). That is **atomicity** — the A in ACID — and it's why we trust a database with money: debit and
credit either both happen or neither does.

Now add an **index** on the column that joins and filters use, and watch the planner pick it:

```bash
sqlite3 ~/db-lab/shop.db "CREATE INDEX IF NOT EXISTS idx_orders_user ON orders(user_id);"
sqlite3 ~/db-lab/shop.db "EXPLAIN QUERY PLAN SELECT * FROM orders WHERE user_id = 1;"
```{{exec}}

The plan now reads `SEARCH orders USING INDEX idx_orders_user` — a **B-tree** lookup (`O(log n)`), not a
full scan (`O(n)`). That's M32's balanced tree, applied to data at rest. An index isn't free, though: it's
a B-tree the database must maintain on every write, so you index the columns queries filter/join on — not
every column.

Click **Check** to verify the tables, the foreign key, and the index.
