# Step 2 — Quoting and the expansion gauntlet

The #1 bug class in bash is unquoted expansion. Build a **minefield** of hostile filenames and feel it:

```bash
mkdir -p /tmp/mine && cd /tmp/mine
```{{exec}}

```bash
touch "two words.txt" "a*b.txt" normal.txt
```{{exec}}

Put a spacey name in a variable, then use it **bare** vs **quoted**:

```bash
f="two words.txt"
```{{exec}}

```bash
ls -l $f
```{{exec}}

```bash
ls -l "$f"
```{{exec}}

The bare `$f` **split** into two arguments (`two` and `words.txt`) — `ls` looked for two files and
failed. `"$f"` stayed one argument. Now watch a glob character expand, and single quotes stop it:

```bash
echo *
```{{exec}}

```bash
echo "*"
```{{exec}}

```bash
echo '*'
```{{exec}}

Finally, the classic loop bug vs the fix — a glob loop never splits or double-expands:

```bash
for f in $(ls *.txt); do echo "WRONG saw: $f"; done
```{{exec}}

```bash
for f in *.txt; do echo "right saw: $f"; done
```{{exec}}

**The rule:** `"$var"` suppresses word splitting and globbing (expansion still happens); bare `$var`
splits on IFS then globs; `'$var'` is pure literal. Quote every expansion — `"$var"`, `"$(cmd)"`,
`"${arr[@]}"` — until proven otherwise.
