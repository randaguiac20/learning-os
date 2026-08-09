#!/bin/bash
# Killercoda step verifier: the pytest suite is present and green inside the venv.
proj="$HOME/recall"
py="$proj/.venv/bin/python"
[ -x "$py" ] || { echo "No venv at ~/recall/.venv — start from Step 1."; exit 1; }
[ -f "$proj/test_cards.py" ] || { echo "test_cards.py not found — write the test in ~/recall as shown in Step 4."; exit 1; }
cd "$proj" || { echo "Could not enter ~/recall."; exit 1; }
if "$py" -m pytest -q >/tmp/m13-pytest.log 2>&1; then
  echo "Verified: pytest ran green in the venv. The treaty is signed — untested Python is unfinished Python."
  exit 0
else
  echo "pytest did not pass. Its output:"
  cat /tmp/m13-pytest.log
  exit 1
fi
