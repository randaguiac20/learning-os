#!/bin/bash
# Killercoda step verifier: pass (exit 0) when eig_check.py wrote eig_result.json AND the
# eigenvalue identity A·v = λ·v was verified within tolerance for every eigenpair.
lab="$HOME/math-lab"
rf="$lab/eig_result.json"
[ -f "$rf" ] || { echo "eig_result.json not found in ~/math-lab — run: python3 eig_check.py"; exit 1; }

python3 - "$rf" <<'PY'
import json, sys
try:
    r = json.load(open(sys.argv[1]))
except Exception as e:
    print("Could not parse eig_result.json:", e); sys.exit(1)

verified = r.get("all_verified")
err = r.get("max_error")
lams = r.get("lambdas")

if verified is None or err is None:
    print("eig_result.json is missing 'all_verified' or 'max_error' — re-run the shipped eig_check.py."); sys.exit(1)

if not verified or err >= 1e-6:
    print(f"A·v = λ·v did NOT hold within tolerance (max_error={err}). Re-run eig_check.py."); sys.exit(1)

# The shipped matrix [[2,1],[1,2]] has eigenvalues 1 and 3.
if sorted(round(float(x)) for x in lams) != [1, 3]:
    print(f"Unexpected eigenvalues {lams} — did you change the matrix? Restore the shipped eig_check.py."); sys.exit(1)

print(f"Verified: A·v = λ·v to within {err:.1e} for eigenvalues {lams}. The eigenvectors are the directions only stretched.")
PY
