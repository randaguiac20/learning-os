#!/bin/bash
# Killercoda step verifier: the venv exists, pytest is importable inside it, and cards.py behaves.
proj="$HOME/recall"
py="$proj/.venv/bin/python"
[ -x "$py" ] || { echo "No venv at ~/recall/.venv — create it with: python3 -m venv .venv  (in ~/recall)"; exit 1; }
"$py" -c "import pytest" 2>/dev/null || { echo "pytest not importable in the venv — activate it and run: pip install pytest"; exit 1; }
[ -f "$proj/cards.py" ] || { echo "cards.py not found — create the module in ~/recall as shown in Step 3."; exit 1; }
cd "$proj" || { echo "Could not enter ~/recall."; exit 1; }
out=$("$py" -c "from cards import parse_cards; print(len(parse_cards(['a|b','nope','c|d'])))" 2>/dev/null)
if [ "$out" != "2" ]; then
  echo "cards.py's parse_cards did not skip the malformed line (expected 2 cards, got '$out') — check the EAFP try/except."
  exit 1
fi
echo "Verified: venv live, pytest installed inside it, and cards.py parses correctly (malformed line skipped). Nicely done."
exit 0
