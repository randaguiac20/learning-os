#!/bin/bash
# Killercoda step verifier: pass when the hard-reset commit was recovered onto a 'rescue' branch.
repo="$HOME/git-lab"
[ -d "$repo/.git" ] || { echo "Repo ~/git-lab not found — start from Step 1."; exit 1; }
# The rescue branch must exist.
if ! git -C "$repo" show-ref --verify --quiet refs/heads/rescue; then
  echo "Branch 'rescue' not found — recover the lost commit with: git branch rescue HEAD@{1}"
  exit 1
fi
# It must contain the recovered commit (matched by its message).
if ! git -C "$repo" log --format='%s' rescue | grep -q 'Add rescue-me notes'; then
  echo "The 'rescue' branch doesn't contain the lost commit — check 'git reflog' for the right hash and rescue it."
  exit 1
fi
echo "Verified: 'rescue' branch holds the recovered 'Add rescue-me notes' commit. Panic retired."
exit 0
