# Step 3 — A JOIN with a GROUP BY aggregate

The heart of SQL: **combine** tables on their keys, then **aggregate**. Answer "how many orders and how
much has each user spent?"

**Predict first**, then run: Ada has 2 orders (55.50), Linus 1 (12.00), Grace 0.

```bash
sqlite3 -header -column ~/db-lab/shop.db "
SELECT u.name, COUNT(o.id) AS orders, IFNULL(SUM(o.total), 0) AS spent
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name
ORDER BY orders DESC;"
```{{exec}}

**Read it:**

- **`LEFT JOIN`** keeps every user even when there's no matching order — that's why **Grace appears with 0**.
  An `INNER JOIN` would silently drop her. Prove it to yourself:

```bash
sqlite3 -header -column ~/db-lab/shop.db "
SELECT u.name, COUNT(o.id) AS orders
FROM users u
INNER JOIN orders o ON o.user_id = u.id
GROUP BY u.id, u.name;"
```{{exec}}

Grace is gone from the second result — the classic "my query dropped rows" bug, live. `INNER` returns only
matched pairs; `LEFT` keeps all left-table rows.

- **`GROUP BY`** collapses the rows into one group per user; `COUNT` and `SUM` aggregate **within** each
  group. Logical order: `FROM → JOIN → GROUP BY → SELECT → ORDER BY`.

Click **Check** to verify the aggregate is correct.
