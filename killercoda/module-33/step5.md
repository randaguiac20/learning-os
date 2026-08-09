# Step 5 — A normalization fix: split the redundant column out

The most valuable modeling skill is **normalization** — arranging columns so each fact lives in exactly one
place. See why with a deliberately **bad** wide table that repeats the customer's city on every row:

```bash
sqlite3 ~/db-lab/shop.db <<'SQL'
CREATE TABLE orders_wide (
  id INTEGER PRIMARY KEY, customer_name TEXT, customer_city TEXT, total REAL
);
INSERT INTO orders_wide (customer_name, customer_city, total) VALUES
  ('Ada', 'London', 20.00), ('Ada', 'London', 35.50);
SQL
sqlite3 -header -column ~/db-lab/shop.db "SELECT * FROM orders_wide;"
```{{exec}}

Now Ada moves. Update **one** of her rows and look again:

```bash
sqlite3 ~/db-lab/shop.db "UPDATE orders_wide SET customer_city = 'Cambridge' WHERE id = 1;"
sqlite3 -header -column ~/db-lab/shop.db "SELECT * FROM orders_wide;"
```{{exec}}

Ada's two rows now **disagree** on her city — that's the **update anomaly**, live: redundant data drifts
out of sync the moment you change only some copies of it.

The fix: move the repeated column into `users` so the city lives **once**, referenced by every order
through `user_id`:

```bash
sqlite3 ~/db-lab/shop.db <<'SQL'
ALTER TABLE users ADD COLUMN city TEXT;
UPDATE users SET city = 'London' WHERE name = 'Ada';
DROP TABLE orders_wide;
SQL
sqlite3 -header -column ~/db-lab/shop.db "
SELECT u.name, u.city, COUNT(o.id) AS orders
FROM users u LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id;"
```{{exec}}

The city is stored in exactly one row of `users`; change it there and every order reflects it through the
join — the anomaly is now **structurally impossible**. That is 3NF's promise: each fact in one place.

You modeled a keyed schema, inserted data, joined and aggregated it, made a transaction atomic, indexed a
column, and normalized away a redundancy. That's Module 33, hands-on.
