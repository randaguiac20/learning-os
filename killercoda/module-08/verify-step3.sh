#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the conflict was resolved into a real merge commit.
repo="$HOME/git-lab"
[ -d "$repo/.git" ] || { echo "Repo ~/git-lab not found — start from Step 1."; exit 1; }
# A merge left in progress means the commit hasn't been finished.
if [ -f "$repo/.git/MERGE_HEAD" ]; then
  echo "Merge still in progress — resolve app.sh, then: git add app.sh && git commit -m \"Merge feature into main\""
  exit 1
fi
# HEAD must be a merge commit: two or more parents.
parents=$(git -C "$repo" rev-list --parents -n 1 HEAD | wc -w)
if [ "$parents" -lt 3 ]; then   # one hash + >=2 parents = >=3 words
  echo "The tip of main is not a merge commit — finish the merge of 'feature' as shown in Step 3."
  exit 1
fi
# No conflict markers may remain in the resolved file.
if git -C "$repo" grep -qE '^(<<<<<<<|=======|>>>>>>>)' HEAD -- app.sh 2>/dev/null; then
  echo "Conflict markers still present in app.sh — remove every <<<<<<< ======= >>>>>>> line, then re-commit."
  exit 1
fi
echo "Verified: feature merged into main via a two-parent merge commit, conflict cleanly resolved. Well done."
exit 0
