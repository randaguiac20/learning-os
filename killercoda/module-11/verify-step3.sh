#!/bin/bash
# Killercoda step verifier: pass (exit 0) when CLAUDE.md + the slash command + the skill exist with shape.
proj="$HOME/claude-lab"
cm="$proj/CLAUDE.md"
[ -f "$cm" ] || { echo "$cm not found — write it in Step 2."; exit 1; }
for h in '## Commands' '## Conventions' '## Gotchas'; do
  grep -qF "$h" "$cm" || { echo "CLAUDE.md is missing a '$h' section (Step 2)."; exit 1; }
done
cmd="$proj/.claude/commands/new-tool.md"
[ -f "$cmd" ] || { echo "Slash command $cmd not found — create it (Step 3)."; exit 1; }
grep -qE '^[[:space:]]*description:' "$cmd" || { echo "$cmd needs YAML frontmatter with a description: line (Step 3)."; exit 1; }
skill="$proj/.claude/skills/failure-matrix/SKILL.md"
[ -f "$skill" ] || { echo "Skill $skill not found — create it at .claude/skills/failure-matrix/SKILL.md (Step 3)."; exit 1; }
grep -qE '^[[:space:]]*name:' "$skill" || { echo "$skill needs YAML frontmatter with a name: line (Step 3)."; exit 1; }
echo "Verified: CLAUDE.md has its three sections, and the slash command + skill exist with valid frontmatter."
exit 0
