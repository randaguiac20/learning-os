# Step 5 — Refactor + review your own diff

With a green suite guarding you, refactoring is **safe** — any regression turns a test red immediately.
First, read your work as a reviewer would. `git diff` and the log show exactly what a teammate would see
in a **pull request** (M8):

```bash
git log --oneline
```{{exec}}

```bash
git show --stat HEAD
```{{exec}}

Run the **whole** suite in one fast command — the payoff of keeping tests at the base of the pyramid:

```bash
python3 -m pytest -q
```{{exec}}

Now apply this lightweight **code-review checklist** to your own code (comment on the **code, not the
coder**):

- **Correctness** — do the tests trace to the requirement? Is every branch covered?
- **Edge cases** — empty / boundary / error handled *and tested*? (the >100% discount was one.)
- **Readability** — do the names say what they mean? Would a stranger follow it?
- **Design** — one responsibility per function? Anything over-engineered (**YAGNI** — You Aren't Gonna
  Need It)?
- **Tests** — do they **assert real behaviour**, or just run lines without checking anything?

In real work this diff goes on a **branch** into a **pull request**, where **CI** runs `pytest` +
`ruff` (lint) + `mypy` (type-check) and a teammate reviews it before it merges — the automated *and*
human quality gate. A change is only **done** when tests pass, CI is green, it's reviewed, and it's
documented — not when "it works on my machine."

> The habit to install: **write the test first, keep PRs small, and let the suite make change fearless.**
