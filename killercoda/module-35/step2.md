# Step 2 — RED — write the failing test first

TDD inverts the usual order: you describe the **behaviour** you want as tests *before* writing any
implementation. Our function is a price calculator — `final_price(base, discount_pct, tax_pct=0)`.

Make sure you're in the project dir, then write the tests **first**:

```bash
cd ~/tdd-lab
```{{exec}}

```bash
cat > test_pricing.py <<'PY'
from pricing import final_price

def test_applies_discount():
    assert final_price(100, 10) == 90.0          # 10% off 100

def test_adds_tax():
    assert final_price(100, 0, tax_pct=10) == 110.0   # +10% tax
PY
```{{exec}}

Now a **stub** that deliberately isn't implemented, so the tests fail for the *right* reason (the
behaviour is missing — not an import error):

```bash
cat > pricing.py <<'PY'
def final_price(base, discount_pct, tax_pct=0):
    raise NotImplementedError   # RED: no logic yet
PY
```{{exec}}

Run the suite and **watch it fail** — this is **RED**:

```bash
python3 -m pytest -v
```{{exec}}

Seeing a test fail *first* proves it can actually catch a problem. A test that has never been red is a
test you don't trust.
