# Step 1 — A normalized schema (users + orders, with a foreign key)

The model comes before the data. Two tables: `users` (people) and `orders` (what each person bought),
linked by a **foreign key**. Make sure `sqlite3` is present and create a working directory:

```bash
command -v sqlite3 >/dev/null || { apt-get update -qq && apt-get install -y sqlite3; }
mkdir -p ~/db-lab
```{{exec}}

Write the schema to a file — versioning your schema is the first habit of a real project:

```bash
cat > ~/db-lab/schema.sql <<'SQL'
PRAGMA foreign_keys = ON;
CREATE TABLE users (
  id    INTEGER PRIMARY KEY,
  name  TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE
);
CREATE TABLE orders (
  id         INTEGER PRIMARY KEY,
  user_id    INTEGER NOT NULL REFERENCES users(id),
  total      REAL    NOT NULL CHECK (total >= 0),
  created_at TEXT    NOT NULL DEFAULT (date('now'))
);
SQL
```{{exec}}

Build the database from it and list the tables:

```bash
rm -f ~/db-lab/shop.db
sqlite3 ~/db-lab/shop.db < ~/db-lab/schema.sql
sqlite3 ~/db-lab/shop.db ".tables"
```{{exec}}

**Read the schema:**

- `users.id` is the **primary key** — the unique identity of each row.
- `orders.user_id INTEGER NOT NULL REFERENCES users(id)` is the **foreign key** — every order points at
  exactly one user (a one-to-many relationship).
- `UNIQUE`, `NOT NULL`, and `CHECK (total >= 0)` are **constraints** — the schema enforcing correctness so
  bad data can never get in.

`PRAGMA foreign_keys = ON;` matters: sqlite enforces foreign keys only when that pragma is on for the
connection — you'll set it again whenever it must be enforced.
