#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the hook, the MCP server entry, and the subagent
# all exist with the right shape (valid JSON; a hooks entry; an mcpServers entry; frontmatter).
proj="$HOME/agent-lab"

# --- The hook (.claude/settings.json) ---
s="$proj/.claude/settings.json"
[ -f "$s" ] || { echo "$s not found — author the hook in Step 2."; exit 1; }
python3 -m json.tool "$s" >/dev/null 2>&1 || { echo "$s is not valid JSON — fix it (Step 2)."; exit 1; }
python3 -c 'import json,sys; d=json.load(open(sys.argv[1])); h=d.get("hooks",{}); assert isinstance(h,dict) and len(h)>=1, "no hooks"; ev=next(iter(h.values())); assert isinstance(ev,list) and ev and ev[0].get("hooks"), "hook entry malformed"' "$s" 2>/dev/null \
  || { echo "settings.json needs a top-level \"hooks\" object with at least one event → hooks entry (Step 2)."; exit 1; }

# --- The MCP server (.mcp.json) ---
m="$proj/.mcp.json"
[ -f "$m" ] || { echo "$m not found — author the MCP server entry in Step 3."; exit 1; }
python3 -m json.tool "$m" >/dev/null 2>&1 || { echo "$m is not valid JSON — fix it (Step 3)."; exit 1; }
python3 -c 'import json,sys; d=json.load(open(sys.argv[1])); ms=d.get("mcpServers",{}); assert isinstance(ms,dict) and len(ms)>=1, "no servers"; srv=next(iter(ms.values())); assert srv.get("command") or srv.get("url"), "server needs command or url"' "$m" 2>/dev/null \
  || { echo ".mcp.json needs a \"mcpServers\" object with at least one server (command+args, or type+url) (Step 3)."; exit 1; }

# --- The subagent (.claude/agents/reviewer.md) ---
a="$proj/.claude/agents/reviewer.md"
[ -f "$a" ] || { echo "Subagent $a not found — create it at .claude/agents/reviewer.md (Step 3)."; exit 1; }
grep -qE '^[[:space:]]*name:' "$a" || { echo "$a needs YAML frontmatter with a name: line (Step 3)."; exit 1; }
grep -qE '^[[:space:]]*description:' "$a" || { echo "$a needs YAML frontmatter with a description: line (Step 3)."; exit 1; }

echo "Verified: the hook (valid JSON + hooks entry), the MCP server (mcpServers entry), and the subagent (name+description) all exist with the right shape."
exit 0
