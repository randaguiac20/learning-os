#!/bin/bash
# Killercoda step verifier: the learner's binary_search returns the right indices on a fixed
# sorted test set (and -1 when absent), and merge_sort agrees with Python's sorted().
proj="$HOME/dsa-lab"
[ -f "$proj/search_sort.py" ] || { echo "search_sort.py not found — create it in ~/dsa-lab as shown in Step 3."; exit 1; }
cd "$proj" || { echo "Could not enter ~/dsa-lab."; exit 1; }
out=$(python3 - <<'PY' 2>/dev/null
try:
    from search_sort import binary_search, merge_sort
except Exception as e:
    print("IMPORT_FAIL"); raise SystemExit
arr = [1, 3, 4, 7, 9, 11, 15, 20, 42, 99]      # sorted test set
# every present value must return its true index
for i, v in enumerate(arr):
    if binary_search(arr, v) != i:
        print("BAD_INDEX"); raise SystemExit
# an absent value must return -1
if binary_search(arr, 8) != -1:
    print("MISSING_NOT_-1"); raise SystemExit
# merge_sort must agree with sorted() on a scrambled list
data = [42, 1, 99, 7, 3, 20, 4, 15, 11, 9]
if merge_sort(data) != sorted(data):
    print("SORT_MISMATCH"); raise SystemExit
print("OK")
PY
)
if [ "$out" != "OK" ]; then
  case "$out" in
    IMPORT_FAIL)     echo "Could not import binary_search/merge_sort — check search_sort.py for syntax errors." ;;
    BAD_INDEX)       echo "binary_search returned a wrong index for a present value — re-check the lo/hi/mid updates." ;;
    MISSING_NOT_-1)  echo "binary_search should return -1 for a value that isn't present (tested with 8)." ;;
    SORT_MISMATCH)   echo "merge_sort disagrees with Python's sorted() — check the merge step." ;;
    *)               echo "search_sort.py did not pass — expected correct indices and a sort matching sorted()." ;;
  esac
  exit 1
fi
echo "Verified: binary_search returns the right indices (and -1 when absent), and merge_sort matches sorted(). Nicely done."
exit 0
