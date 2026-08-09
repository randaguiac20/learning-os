# Step 5 — Permission modes, injection posture, responsible agency

You've built the agentic layer; now the **operating discipline** that governs it — no key needed, pure
reasoning.

## Permission modes — the trust dial

| Mode | Behaviour | Use when |
|---|---|---|
| **default** | asks before each mutating action | normal work — you gate each step |
| **plan** | read-only; proposes a plan, changes nothing | exploring or reviewing before acting |
| **acceptEdits** | file edits auto-approved; commands still ask | a well-scoped edit you trust |
| **bypassPermissions** | no prompts at all | throwaway sandbox only — never on real or CI work |

Your allowlist plus modes make **default** fast without going blind — approved reads never interrupt;
anything consequential still stops for you.

## The injection posture

**Prompt injection**: untrusted content (a web page, a RAG chunk, a file, a tool result) carries
instructions the agent may follow, because **data and commands share one channel**. No wording fixes it —
the defense is architecture. Write your posture down:

```bash
cd ~/agent-lab
cat > NOTES.md <<'EOF'
# Agentic layer — operating notes

## Injection defenses (the three walls)
1. Boundary   — untrusted RAG text is DATA, delimited; never elevated to instructions.
2. Least privilege — the MCP tool has ZERO action authority (the blast-radius wall).
3. Checkpoint — consequential/irreversible acts need my signature.

## The load-bearing sentence
Damage needs BOTH untrusted input AND permission to act — sever the intersection.

## Automate vs human
- Automate: repetitive / verifiable / reversible (re-index, lint, first-pass review).
- Keep human: consequential / ambiguous / irreversible (deploys, merges, secret rotation).
EOF
cat NOTES.md
```{{exec}}

## The blast-radius question

Answer it for THIS setup, naming concrete assets (not "bad things"):

```bash
echo 'If this agent is wrong or hijacked, what can THIS identity reach?' \
  '=> the ./index (read-only via MCP), the repo files it is allowed to read,' \
  'and the audit log it appends to. NOT secrets/, NOT deploy, NOT merge.'
```{{exec}}

You've now authored **every** input to the agentic layer — a hook, an MCP tool, a subagent, a headless
job, and the posture that bounds them — without spending a single token. Add your key locally and the same
files extend a real agent.

Click **Continue** to wrap up.
