# Step 2 — Selection: choose a branch

**Selection** picks a branch based on a condition — `if` / `elif` / `else`. Write your first program to a
file with a here-document, then run it:

```bash
cat > ~/learning/py/grade.py <<'EOF'
score = 72
if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "F"
print(f"score {score} -> grade {grade}")
EOF
```{{exec}}

```bash
python3 ~/learning/py/grade.py
```{{exec}}

It prints `score 72 -> grade C`. **Order matters:** the ladder is checked top-to-bottom and stops at the
**first** true branch — that is why the `>= 70` test comes last among the passing grades.

Change the score and watch the branch change:

```bash
sed -i 's/^score = 72/score = 95/' ~/learning/py/grade.py && python3 ~/learning/py/grade.py
```{{exec}}

Now `95` takes the very first branch and prints grade `A`.

> The `f"..."` string is an **f-string**: `{score}` and `{grade}` are replaced by the values of those
> names. Formatting output by *interpolation*, not string-gluing.
