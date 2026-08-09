#!/bin/bash
# Killercoda step verifier: pass when the edge-case test exists, the suite is green,
# and final_price clamps a >100% discount to 0.0 (the bug is actually fixed).
lab="$HOME/tdd-lab"
cd "$lab" 2>/dev/null || { echo "Project dir ~/tdd-lab not found — start from Step 1."; exit 1; }
[ -f pricing.py ] || { echo "pricing.py not found — see Step 3."; exit 1; }
[ -f test_pricing.py ] || { echo "test_pricing.py not found — see Step 2."; exit 1; }
grep -q 'test_discount_never_makes_price_negative' test_pricing.py \
  || { echo "Edge-case test 'test_discount_never_makes_price_negative' not found — add it (Step 4)."; exit 1; }
out=$(python3 -m pytest -q 2>&1) || { echo "Suite is not green — the >100% discount case likely still fails (that IS the bug to fix by clamping):"; echo "$out" | tail -8; exit 1; }
python3 -c "from pricing import final_price; assert final_price(50, 150) == 0.0, final_price(50, 150)" 2>/dev/null \
  || { echo "final_price(50, 150) does not return 0.0 — a >100% discount must not make the price negative. Clamp the discount to [0,100]."; exit 1; }
echo "Verified: the edge-case test exists and passes, and final_price clamps a >100% discount to 0.0. Bug caught by a test, then fixed."
exit 0
