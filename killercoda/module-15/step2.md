# Step 2 — Idempotence clinic: naive vs check-then-act

**Idempotent** means running twice equals running once: *f(f(x)) = f(x)*. Only re-runnable jobs may be
scheduled — everything else is a loaded gun on a timer. The standard proof is the **run-twice diff**.

First, watch a **naive** job damage itself. Make sure you're in the sandbox, then append-blindly and diff:

```bash
cd ~/automation-lab
```{{exec}}

```bash
echo 'role = worker' > config.txt
printf 'setup ran\n' >> config.txt
cp config.txt /tmp/after-run-1.txt
printf 'setup ran\n' >> config.txt
diff /tmp/after-run-1.txt config.txt
```{{exec}}

The `diff` is **not empty** — the second run doubled the line. That job is unsafe to schedule.

Now the **idempotent** rewrite: *check the state, then act*. Run it twice and prove the diff is clean:

```bash
echo 'role = worker' > config.txt
grep -qxF 'setup ran' config.txt || echo 'setup ran' >> config.txt
cp config.txt /tmp/after-run-1.txt
grep -qxF 'setup ran' config.txt || echo 'setup ran' >> config.txt
diff /tmp/after-run-1.txt config.txt && echo "IDEMPOTENT: second run changed nothing"
```{{exec}}

The empty diff (and the printed message) is the **run-twice proof** — the license to schedule. `grep -qxF`
checks whether the exact line already exists before appending; `mkdir -p` and `ln -sf` win the same way —
they check before they act. Keep this proof in mind: you'll use it on every job from here.
