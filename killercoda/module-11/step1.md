# Step 1 — The model: you direct, you verify

Claude Code runs a loop: **think → use a tool → observe the result → repeat**, stopping when the work
*looks* done. "Looks done" is a *plausibility* judgement, not a *correctness* one — which is why the
highest-leverage habit is giving it a **check it can run** (tests, a build, a diff). Then "done" means
*the check passed*, and you become an evidence-reader, not a supervisor.

Everything you configure this week directs that loop. Set up a small project to hold the config — it's
just files, so no key is needed:

```bash
mkdir -p ~/claude-lab && cd ~/claude-lab
```{{exec}}

Make it a real project (config rides your repos, M8):

```bash
git init -q 2>/dev/null; ls -la
```{{exec}}

Confirm you have the tools this lab validates with — a shell and Python for JSON:

```bash
python3 --version
```{{exec}}

**The one thing to hold onto:** you are the **engineer of record** — every line that ships is yours,
however it was drafted. The config you build now is how you keep that true at speed: rules the agent
loads, commands it can run without asking, and workflows it can reuse.

Stay in `~/claude-lab` for every remaining step.
