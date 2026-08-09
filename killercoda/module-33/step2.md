# Step 2 — Insert data, and watch the foreign key reject a bad row

Insert three users and three orders in one batch. Grace gets **no** orders on purpose — she'll matter in
Step 3:

```bash
sqlite3 ~/db-lab/shop.db <<'SQL'
PRAGMA foreign_keys = ON;
INSERT INTO users (id, name, email) VALUES
  (1, 'Ada',   'ada@example.com'),
  (2, 'Linus', 'linus@example.com'),
  (3, 'Grace', 'grace@example.com');
INSERT INTO orders (user_id, total) VALUES
  (1, 20.00), (1, 35.50), (2, 12.00);
SQL
```{{exec}}

Look at what you stored:

```bash
sqlite3 -header -column ~/db-lab/shop.db "SELECT * FROM users;"
```{{exec}}

```bash
sqlite3 -header -column ~/db-lab/shop.db "SELECT * FROM orders;"
```{{exec}}

Now the constraint, **demonstrated**. Try to insert an order for user `999`, who does not exist —
referential integrity should refuse it:

```bash
sqlite3 ~/db-lab/shop.db "PRAGMA foreign_keys = ON; INSERT INTO orders (user_id, total) VALUES (999, 5.00);"
```{{exec}}

You should see **`FOREIGN KEY constraint failed`**. The database is refusing to store a reference to
nothing — that rejection is the schema doing its job, and it's exactly what a flat file (or a spreadsheet)
can never give you.

> The `email` column is `UNIQUE` too — try inserting a second user with `ada@example.com` and watch that
> constraint reject it the same way.
