# Step 4 — Author a permissions allowlist

By default Claude Code **asks before every mutating action**. As evidence accumulates that a command is
provably safe (read-only or idempotent), you encode standing trust for it in `.claude/settings.json` —
in **narrow, named forms**. The cardinal sin is `Bash(*)`: it grants trust to *everything* and destroys
the whole point of the gate.

Write the settings file with a tight allowlist and one explicit deny:

```bash
cat > .claude/settings.json <<'EOF'
{
  "permissions": {
    "allow": [
      "Bash(shellcheck:*)",
      "Bash(bash -n:*)",
      "Bash(git status:*)",
      "Bash(git diff:*)"
    ],
    "deny": [
      "Bash(rm -rf:*)"
    ]
  }
}
EOF
```{{exec}}

Prove it is valid JSON — a broken settings file is silently ignored:

```bash
python3 -m json.tool .claude/settings.json
```{{exec}}

Confirm you did **not** hand out a blanket grant:

```bash
grep -q 'Bash(\*)' .claude/settings.json && echo "TOO BROAD — remove Bash(*)" || echo "OK — allowlist is narrow"
```{{exec}}

Each entry is a command you'd approve repeatedly anyway: `shellcheck`, `bash -n`, `git status`,
`git diff` — read-only or a no-op syntax check. Anything that mutates state outside the repo keeps
asking. That is least privilege (M3), applied to an AI.

Click **Check** to verify `settings.json` is valid JSON, has a non-empty allowlist, and avoids the
`Bash(*)` anti-pattern.
