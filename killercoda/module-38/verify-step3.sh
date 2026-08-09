#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the tokenizer produced a valid vocab.json.
cd "$HOME/nlp-lab" 2>/dev/null || { echo "~/nlp-lab not found — start from Step 1."; exit 1; }
[ -f vocab.json ] || { echo "vocab.json not found — run: python3 tokenizer.py"; exit 1; }
python3 - <<'PY' || exit 1
import json, sys
v = json.load(open("vocab.json"))
size = v.get("vocab_size")
m = v.get("token_to_id", {})
if size != len(m):
    print(f"vocab_size ({size}) does not match the number of tokens ({len(m)})"); sys.exit(1)
if not (35 <= size <= 60):
    print(f"vocab_size {size} is outside the expected range 35-60 — check normalization/splitting"); sys.exit(1)
if sorted(m.values()) != list(range(size)):
    print("token ids are not a contiguous 0..N-1 range"); sys.exit(1)
by_id = [t for t, _ in sorted(m.items(), key=lambda kv: kv[1])]
if by_id != sorted(m):
    print("token_to_id is not in sorted (alphabetical) order — id should equal the sorted position"); sys.exit(1)
if "movie" not in m:
    print("expected token 'movie' is missing from the vocabulary"); sys.exit(1)
print(f"Verified: vocab.json holds {size} sorted tokens with contiguous ids, and 'movie' -> {m['movie']}.")
PY
exit 0
