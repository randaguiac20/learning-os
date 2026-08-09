# Claude Code Advanced — author the agentic layer

In Module 11 you learned to **direct** Claude Code: an agentic coding tool that reads your codebase,
edits files, runs commands, and works through multi-step tasks in your terminal. This module opens it
up — you move from its **user** to its **extender**, building the **agentic layer**:

- a **hook** — a shell command wired to a lifecycle event, so a rule runs *deterministically*,
- an **MCP server** entry — the Model Context Protocol, the open "USB-C for AI" that connects tools/data,
- a **subagent** — a specialised agent (a reviewer) with its own context and permissions,
- a **headless** automation skeleton — `claude -p`, the agent as a scriptable Unix citizen.

Extending the agent live needs an account, a key, and network — which a free browser VM can't give you.
But the other half of the skill runs perfectly here: **authoring and validating the four config files**,
with **no key at all**. You'll build each, prove its JSON/shape is valid, and reason about **permission
modes**, the **prompt-injection** posture, and the **automate-vs-human** rule.

> The **live** drills — connecting the MCP server, spawning subagents, `claude -p` in anger — are flagged
> "**in your own terminal**" in the lesson. Do the file-shape work here; do the orchestration at home with
> your key. You need both halves.

One law governs everything you build: **an agent is a powerful identity, and least privilege (M24) applies
to it exactly as to any other.**

Click **START** to begin.
