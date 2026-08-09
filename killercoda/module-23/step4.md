# Step 4 — git bisect a planted regression

Now a different shape of bug: a regression hiding somewhere in a project's history. Build a throwaway repo
whose test **used to pass** and now fails — with the culprit buried among innocent commits:

```bash
mkdir -p ~/debug-lab/calc && cd ~/debug-lab/calc && git init -q
git config user.email dev@example.com && git config user.name dev
printf '#!/bin/bash\nadd() { echo $(( $1 + $2 )); }\n' > calc.sh
printf '#!/bin/bash\nsource "$(dirname "$0")/calc.sh"\nadd "$1" "$2"\n' > run.sh
printf '#!/bin/bash\ngot=$(bash "$(dirname "$0")/run.sh" 2 3)\n[ "$got" = "5" ] || { echo "FAIL: 2+3=$got"; exit 1; }\necho "PASS: 2+3=5"\n' > test.sh
echo "calc" > README.md && git add -A && git commit -qm "init calc"
for i in 1 2 3 4 5; do echo "note $i" >> README.md; git commit -aqm "docs: note $i"; done
sed -i 's/\$1 + \$2/\$1 - \$2/' calc.sh && git commit -aqm "refactor: simplify add"
for i in 6 7 8 9; do echo "note $i" >> README.md; git commit -aqm "docs: note $i"; done
```{{exec}}

Confirm the test fails at `HEAD` — the bug is *somewhere* in those commits, but reading them one by one is
the slow way:

```bash
bash test.sh; echo "exit=$?"
```{{exec}}

**Divide and conquer.** Bisection is binary search over history: `good` is the root commit, `bad` is
`HEAD`, and the test is the oracle. Let git run the search for you:

```bash
git bisect start
```{{exec}}

```bash
git bisect bad
```{{exec}}

```bash
git bisect good $(git rev-list --max-parents=0 HEAD)
```{{exec}}

```bash
git bisect run bash test.sh
```{{exec}}

git names the first bad commit — **`refactor: simplify add`** — in `O(log n)` tests, not `O(n)`. End the
bisect session, then fix the **root cause** (the flipped `+` → `-`) and verify:

```bash
git bisect reset
```{{exec}}

```bash
sed -i 's/\$1 - \$2/\$1 + \$2/' calc.sh
```{{exec}}

```bash
bash test.sh; echo "exit=$?"
```{{exec}}

`PASS: 2+3=5` and `exit=0`. Bisection works *because* the commits are atomic and the test is a fast,
reliable oracle — the M8 and M13 disciplines paying their dividend.

Click **Check** to verify the regression is fixed and the test is green.
