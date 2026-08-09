# Step 5 — Errors as information

Errors are not noise — they're **information**. Cause one on purpose and read what it says:

```bash
python3 -c 'print(int("abc"))'
```{{exec}}

You get a **traceback** ending in `ValueError: invalid literal for int() with base 10: 'abc'`. **Read a
traceback bottom-up:** the last line is the error itself (type + message); the lines above are the route
the calls took to reach it.

Now handle it properly. Catch the **specific** error, report to **stderr**, and exit **non-zero** — the M5
CLI contract, kept in your second language:

```bash
cat > ~/learning/py/safe_int.py <<'EOF'
import sys

raw = "abc"
try:
    n = int(raw)
except ValueError:
    print(f"not a number: {raw!r}", file=sys.stderr)
    sys.exit(1)
print(n)
EOF
```{{exec}}

```bash
python3 ~/learning/py/safe_int.py; echo "exit: $?"
```{{exec}}

It prints the error to stderr and reports `exit: 1` — a failure a script or `systemd` can *see*. Prove the
happy path too:

```bash
sed -i 's/raw = "abc"/raw = "42"/' ~/learning/py/safe_int.py && python3 ~/learning/py/safe_int.py; echo "exit: $?"
```{{exec}}

Now it prints `42` and `exit: 0`.

> The rule: catch a **specific** exception at the level where you can **act**. A bare `except:` that
> swallows everything is the `|| true` of Python — it hides bugs (even typos) silently. Never do it.
