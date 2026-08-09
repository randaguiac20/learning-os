#!/bin/bash
# Killercoda step verifier: pass when the cosine-similarity script found the expected nearest word.
proj="$HOME/ai-foundations"
[ -f "$proj/words.py" ]  || { echo "words.py not found — create it in ~/ai-foundations as shown in Step 2."; exit 1; }
[ -f "$proj/cosine.py" ] || { echo "cosine.py not found — create it in ~/ai-foundations as shown in Step 3."; exit 1; }
[ -f "$proj/nearest.txt" ] || { echo "nearest.txt not found — run: cd ~/ai-foundations && python3 cosine.py"; exit 1; }
best=$(tr -d '[:space:]' < "$proj/nearest.txt")
if [ "$best" != "queen" ]; then
  echo "nearest.txt says '$best', expected 'queen' — the nearest word to 'king' by cosine similarity should be 'queen'. Re-run: python3 cosine.py"
  exit 1
fi
echo "Verified: cosine.py computed similarities by hand and found 'queen' as the nearest word to 'king'. RAG's whole trick, naked."
exit 0
