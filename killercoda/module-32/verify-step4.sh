#!/bin/bash
# Killercoda step verifier: the learner's DP solutions return correct answers on known inputs
# (memoized Fibonacci matches the known sequence; coin_change is optimal, and -1 when impossible).
proj="$HOME/dsa-lab"
[ -f "$proj/dp.py" ] || { echo "dp.py not found — create it in ~/dsa-lab as shown in Step 4."; exit 1; }
cd "$proj" || { echo "Could not enter ~/dsa-lab."; exit 1; }
out=$(python3 - <<'PY' 2>/dev/null
try:
    from dp import fib_memo, coin_change
except Exception as e:
    print("IMPORT_FAIL"); raise SystemExit
# memoized Fibonacci on known values
known = {0: 0, 1: 1, 10: 55, 20: 6765, 30: 832040}
for n, expected in known.items():
    if fib_memo(n) != expected:
        print("FIB_WRONG"); raise SystemExit
# coin_change: fewest coins, and -1 when impossible
cases = {(6,): (2, [1, 3, 4]), (11,): (3, [1, 2, 5]), (3,): (-1, [2])}
for (amount,), (expected, coins) in cases.items():
    if coin_change(coins, amount) != expected:
        print("COIN_WRONG"); raise SystemExit
print("OK")
PY
)
if [ "$out" != "OK" ]; then
  case "$out" in
    IMPORT_FAIL) echo "Could not import fib_memo/coin_change — check dp.py for syntax errors." ;;
    FIB_WRONG)   echo "fib_memo returned a wrong value — check the base case (n<2) and the cached recurrence." ;;
    COIN_WRONG)  echo "coin_change is not optimal (or not -1 when impossible) — re-check the min over coins and the base row." ;;
    *)           echo "dp.py did not pass — expected correct fib_memo and coin_change on known inputs." ;;
  esac
  exit 1
fi
echo "Verified: fib_memo matches the known sequence and coin_change is optimal (with -1 when impossible). Nicely done."
exit 0
