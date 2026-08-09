# Step 3 — An MCP server and a subagent

Now two capability layers: an **MCP** (Model Context Protocol) server entry that exposes your capstone
service as a tool, and a **subagent** — a specialised agent with its own context and permissions.

## The MCP server — read + answer only

A project-scoped `.mcp.json` lists servers under `"mcpServers"`. A local server is **stdio** (`command` +
`args` + optional `env`). The governing rule for your capstone tool: grant it **only** the authority to
*read the index and call the model to answer* — no shell, no writes. It consumes **untrusted input**
(questions AND retrieved docs, which may be poisoned), so by the blast-radius law a hijacked answerer must
do nothing consequential.

```bash
cd ~/agent-lab
cat > .mcp.json <<'EOF'
{
  "mcpServers": {
    "capstone-rag": {
      "command": "python3",
      "args": ["-m", "capstone.mcp_server"],
      "env": { "RAG_INDEX": "./index", "RAG_READONLY": "1" }
    }
  }
}
EOF
python3 -m json.tool .mcp.json
```{{exec}}

> A **remote** server instead uses `"type": "http"` (or `"sse"`) with a `"url"` — the same protocol, a
> different transport.

## The subagent — a specialised reviewer

A subagent is defined as `.claude/agents/<name>.md`: YAML frontmatter (`name` and `description` are
required; `tools` and `model` are optional) plus a body that is its system prompt.

```bash
mkdir -p .claude/agents
cat > .claude/agents/reviewer.md <<'EOF'
---
name: reviewer
description: Reviews a diff for correctness and scope drift; flags only gaps that affect correctness or stated requirements.
tools: Read, Grep, Bash
model: sonnet
---
You are a code reviewer. Read the diff and the stated requirements only.
Flag ONLY gaps affecting correctness or the stated requirements — a reviewer
asked for findings will always produce findings; do not invent work.
EOF
ls -R .claude .mcp.json
```{{exec}}

The reviewer runs in its **own** context window with **only** `Read, Grep, Bash` — least privilege for a
role. That is the subagent trade in miniature: capability where it's decomposable, bounded so it can't
overreach.

Click **Check** to verify the **hook**, the **MCP entry**, and the **subagent** all exist with the right
shape.
