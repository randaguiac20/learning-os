#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the calc regression is fixed — add 2 3 = 5
# and the test is green — and the learner is no longer mid-bisect.
repo="$HOME/debug-lab/calc"
[ -d "$repo" ] || { echo "calc repo missing — start from Step 4."; exit 1; }
cd "$repo" || { echo "cannot enter $repo"; exit 1; }
if [ -f .git/BISECT_LOG ] || [ -f .git/BISECT_START ]; then
  echo "Still mid-bisect — finish the session first with: git bisect reset"
  exit 1
fi
out=$(bash test.sh 2>&1); code=$?
if [ "$code" -ne 0 ]; then
  echo "Test still failing — the flipped-operator regression isn't fixed yet:"
  echo "$out"
  echo "Fix calc.sh so add() uses '+', then re-run: bash test.sh"
  exit 1
fi
echo "Verified: $out — the regression is fixed at its root cause (add adds again) and the test is green."
exit 0
