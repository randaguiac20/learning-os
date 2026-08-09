# Step 3 — Iteration: repeat with a loop

**Iteration** repeats work. A `for` loop walks a collection; `range(1, 16)` is a **half-open** sequence of
`1..15` (the end, 16, is excluded — lengths are just `end - start`). Combine iteration with the selection
you just learned in the classic **FizzBuzz**:

```bash
cat > ~/learning/py/fizzbuzz.py <<'EOF'
for n in range(1, 16):
    if n % 15 == 0:
        print("FizzBuzz")
    elif n % 3 == 0:
        print("Fizz")
    elif n % 5 == 0:
        print("Buzz")
    else:
        print(n)
EOF
```{{exec}}

```bash
python3 ~/learning/py/fizzbuzz.py
```{{exec}}

Read the output against the rules: multiples of 3 become `Fizz`, of 5 become `Buzz`, of both (15) become
`FizzBuzz`, everything else prints the number. The `%` operator is the **remainder** — `n % 3 == 0` means
"3 divides n exactly."

**Why check `% 15` first?** Same reason the grade ladder was ordered: 15 is divisible by both 3 and 5, so
its branch must be tested *before* the `% 3` and `% 5` branches — otherwise it would match `Fizz` and stop.

Click **Check** to verify your loop produces correct FizzBuzz for 1..15.
