#!/bin/bash
# Killercoda step verifier: pass when the normalized tables exist, the foreign key is present, and the index was created.
db="$HOME/db-lab/shop.db"
[ -f "$db" ] || { echo "Database not found — run Step 1 first."; exit 1; }

# Both normalized tables exist.
for t in users orders; do
  found=$(sqlite3 "$db" "SELECT name FROM sqlite_master WHERE type='table' AND name='$t';")
  [ "$found" = "$t" ] || { echo "Table '$t' missing — create the schema in Step 1."; exit 1; }
done

# orders carries a foreign key to users (PRAGMA lists it only when the FK is defined).
fk=$(sqlite3 "$db" "PRAGMA foreign_key_list(orders);")
[ -n "$fk" ] || { echo "orders has no FOREIGN KEY — it must REFERENCE users(id) (Step 1 schema)."; exit 1; }

# The index on orders(user_id) exists.
idx=$(sqlite3 "$db" "SELECT name FROM sqlite_master WHERE type='index' AND name='idx_orders_user';")
[ "$idx" = "idx_orders_user" ] || { echo "Index idx_orders_user missing — CREATE INDEX ... ON orders(user_id) in Step 4."; exit 1; }

echo "Verified: users + orders exist, orders has a foreign key to users, and idx_orders_user is in place. Schema + index confirmed."
exit 0
