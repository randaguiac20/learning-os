# Step 2 — Write a pruned CLAUDE.md

`CLAUDE.md` is the file Claude Code loads **every session**. It should hold only **universal,
non-inferable facts** — a bloated file gets ignored (rules drown), and the docs say so plainly. Apply
the **prune test** to every line: *would removing it cause a mistake?* If not, cut it.

Make sure you're in the project, then write it with a heredoc:

```bash
cd ~/claude-lab
```{{exec}}

```bash
cat > CLAUDE.md <<'EOF'
# Project: Caretaker

## Commands
- Test: `./run-tests.sh`
- Lint: `shellcheck *.sh` — must pass before commit

## Conventions
- Every tool exits 0 on success, non-zero on failure (the exit-code contract).
- New scripts follow `backup-lite.sh`'s getopts pattern.

## Gotchas
- `lib.sh` must be sourced before any function call.
EOF
```{{exec}}

Read it back and count the lines — short is the point:

```bash
cat CLAUDE.md
```{{exec}}

```bash
wc -l CLAUDE.md
```{{exec}}

Notice what is **not** here: no restated prose, no style essays, nothing the code already says. Each
line is a fact the agent can't infer and would get wrong without — the test command, the exit-code
contract, one real gotcha.

> Three scopes exist: **user** (`~/.claude/CLAUDE.md`, your standing rules), **project** (`./CLAUDE.md`,
> checked in — this one), and **local** (`./CLAUDE.local.md`, gitignored). The user scope is where the
> **Learner's Law** lives: *"explain, don't solve, for my exercise files."*
