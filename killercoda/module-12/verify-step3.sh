#!/bin/bash
# Killercoda step verifier: pass (exit 0) when fizzbuzz.py exists and prints correct FizzBuzz for 1..15.
f="$HOME/learning/py/fizzbuzz.py"
[ -f "$f" ] || { echo "fizzbuzz.py not found — create it in ~/learning/py as shown in Step 3."; exit 1; }
out="$(python3 "$f" 2>/dev/null)" || { echo "fizzbuzz.py failed to run — see the traceback with: python3 $f"; exit 1; }
mapfile -t lines <<< "$out"
[ "${#lines[@]}" -ge 15 ] || { echo "Expected 15 lines of output (range(1, 16)) — got ${#lines[@]}."; exit 1; }
[ "${lines[0]}" = "1" ]         || { echo "Line 1 should be '1' — got '${lines[0]}'."; exit 1; }
[ "${lines[2]}" = "Fizz" ]      || { echo "Line 3 should be 'Fizz' (3 is divisible by 3) — got '${lines[2]}'."; exit 1; }
[ "${lines[4]}" = "Buzz" ]      || { echo "Line 5 should be 'Buzz' (5 is divisible by 5) — got '${lines[4]}'."; exit 1; }
[ "${lines[14]}" = "FizzBuzz" ] || { echo "Line 15 should be 'FizzBuzz' (15 is divisible by 3 and 5) — got '${lines[14]}'."; exit 1; }
echo "Verified: fizzbuzz.py prints correct FizzBuzz for 1..15 — iteration + selection working."
exit 0
