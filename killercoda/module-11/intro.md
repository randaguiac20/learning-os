# Claude Code — scaffold the environment that directs the agent

Claude Code is an **agentic** coding tool: an AI that reads your codebase, edits files, runs commands,
and works through multi-step tasks *in your terminal* — while **you** scope the work, review the diffs,
and decide what ships.

Running the agent live needs an account, an API key, and network — which a free browser VM can't give
you. But the other half of the skill runs perfectly here: **authoring and validating the configuration
that directs it.** In the next few minutes you'll build, with no key at all:

- a **pruned `CLAUDE.md`** — the always-loaded project rules,
- a `.claude/` structure with a **custom slash command** and a **skill**,
- a **`settings.json` permissions allowlist** — trust encoded narrowly,

and reason about **permission modes** and the **explore→plan→code→verify→review→commit** workflow.

> The **live** agent drills — `claude` sessions, plan mode, directing a real feature — are flagged
> "**in your own terminal**" in the lesson. Do the file-shape work here; do the direction at home with
> your key. You need both halves.

Click **START** to begin.
