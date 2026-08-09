# Step 4 — An edge case that catches a bug

Tests are only as good as the cases you think of. What happens with a discount *over* 100%? Add an
edge-case test using **parametrize** (many cases from one test):

```bash
cat >> test_pricing.py <<'PY'

import pytest

@pytest.mark.parametrize("base,discount,expected", [
    (50, 100, 0.0),   # a full discount → free
    (50, 150, 0.0),   # a >100% discount must NOT make the price negative
])
def test_discount_never_makes_price_negative(base, discount, expected):
    assert final_price(base, discount) == expected
PY
```{{exec}}

Run the suite — the `(50, 150)` case **fails**: the function returns `-25.0`. A real bug, caught by a
test:

```bash
python3 -m pytest -v
```{{exec}}

`50 * (1 - 1.5) = -25.0` — a discount over 100% drives the price negative. Fix the implementation to
**clamp** the discount into a sane range:

```bash
cat > pricing.py <<'PY'
def final_price(base, discount_pct, tax_pct=0):
    discount_pct = min(max(discount_pct, 0), 100)   # clamp to [0, 100]
    discounted = base * (1 - discount_pct / 100)
    return round(discounted * (1 + tax_pct / 100), 2)
PY
```{{exec}}

Run again — all tests **green**. The bug is fixed and the edge case is now covered:

```bash
python3 -m pytest -v
```{{exec}}

Commit the fix and its test together — the test stays as a **regression test** so the bug can never
silently return:

```bash
git commit -q -am "Fix: clamp discount to [0,100] so price can't go negative (+ edge-case test)"
```{{exec}}

Click **Check** to verify the edge-case test exists, the suite is green, and the fix holds.
