# Done — you can extend an AI engineer

Without an API key, you built the whole **agentic layer** that extends Claude Code:

- A **hook** (`.claude/settings.json`) — a PostToolUse lint + a Stop **audit**, deterministic guardrails.
- An **MCP server** (`.mcp.json`) — your capstone tool, **read + answer only**, zero action authority.
- A **subagent** (`.claude/agents/reviewer.md`) — a specialised role in its own context, least-privileged.
- A **headless** skeleton (`claude -p` with `--allowedTools`) — the agent as an M15 fleet member.
- The **posture** — permission modes, the three injection walls, and the automate-vs-human rule.

Every piece obeyed one law: **an agent is an identity, and least privilege applies to it exactly as to any
other** — the injection's ceiling is the authority you grant, so a hijacked answerer can do nothing its
grant can't.

**Back on the lesson page:** do the *Self-Check* and *Solo Lab* (place each rule in its layer, defend the
MCP tool's authority, run the injection drill), then tick the *Mastery checklist*. Passing M29 **closes
Stage 10 — and the curriculum**. The **FINAL GATE** asks the question every module prepared you for: can
you teach every layer, from the silicon (M22) to the agent loop, to someone else?

> The one-sentence takeaway: **you can now build, secure, observe, debug, serve, and safely automate a
> full-stack AI service you understand from the silicon up — and the final proof is that you can teach all
> of it to someone else.**
