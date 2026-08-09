#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the JOIN+GROUP BY aggregate returns the expected state.
db="$HOME/db-lab/shop.db"
[ -f "$db" ] || { echo "Database not found — run Step 1 to create ~/db-lab/shop.db"; exit 1; }

# Ada (user 1) must have exactly 2 orders — the stable aggregate the GROUP BY reports.
ada=$(sqlite3 "$db" "SELECT COUNT(*) FROM orders WHERE user_id = 1;")
if [ "$ada" != "2" ]; then
  echo "Expected Ada (user 1) to have 2 orders, found '$ada' — INSERT the seed rows in Step 2."
  exit 1
fi

# There must be at least the 3 seeded orders (Grace still has 0 — she only appears via a LEFT JOIN).
total=$(sqlite3 "$db" "SELECT COUNT(*) FROM orders;")
if [ "$total" -lt 3 ] 2>/dev/null; then
  echo "Expected at least 3 orders, found '$total' — check the INSERTs in Step 2."
  exit 1
fi

# Grace (user 3) must exist as a user even with zero orders — the reason LEFT JOIN matters.
grace=$(sqlite3 "$db" "SELECT COUNT(*) FROM users WHERE name = 'Grace';")
if [ "$grace" != "1" ]; then
  echo "User 'Grace' not found — insert all three users in Step 2 (she has 0 orders on purpose)."
  exit 1
fi

echo "Verified: Ada has 2 orders, $total orders total, and Grace exists with none. JOIN + GROUP BY aggregate is right."
exit 0
