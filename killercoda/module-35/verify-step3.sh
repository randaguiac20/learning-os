#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the pricing suite is green with >=2 tests.
lab="$HOME/tdd-lab"
cd "$lab" 2>/dev/null || { echo "Project dir ~/tdd-lab not found — start from Step 1."; exit 1; }
[ -f pricing.py ] || { echo "pricing.py not found — implement final_price (Step 3)."; exit 1; }
[ -f test_pricing.py ] || { echo "test_pricing.py not found — write the failing tests first (Step 2)."; exit 1; }
out=$(python3 -m pytest -q 2>&1) || { echo "Tests are not green yet — implement final_price so both pass:"; echo "$out" | tail -6; exit 1; }
n=$(python3 -m pytest --collect-only -q 2>/dev/null | grep -c '::')
if [ "$n" -lt 2 ]; then
  echo "Only $n test(s) collected — you need at least 2 (Step 2 wrote test_applies_discount and test_adds_tax)."
  exit 1
fi
echo "Verified: $n tests collected and the suite is green. RED -> GREEN complete."
exit 0
