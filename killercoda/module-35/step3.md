# Step 3 — GREEN — implement to pass

Now write the **simplest** code that makes the failing tests pass — no more than that:

```bash
cat > pricing.py <<'PY'
def final_price(base, discount_pct, tax_pct=0):
    discounted = base * (1 - discount_pct / 100)
    return round(discounted * (1 + tax_pct / 100), 2)
PY
```{{exec}}

Run the suite — both tests should now pass. This is **GREEN**:

```bash
python3 -m pytest -v
```{{exec}}

Now that it's green, make an **atomic commit** — one logical change, with a message that says *why*:

```bash
git add pricing.py test_pricing.py
```{{exec}}

```bash
git commit -q -m "Add final_price: discount + tax (TDD, tests green)" && git log --oneline
```{{exec}}

**RED → GREEN** complete: you defined "correct" as tests *before* writing the code, and the commit
captures a working, tested unit of work.

Click **Check** to verify the suite is green with at least two tests.
