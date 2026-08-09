# Done — scripts became systems

In ~30 minutes you crossed the line from scripts to unattended systems:

- **Proved idempotence by hand** — the run-twice diff, naive vs check-then-act (`grep -qxF || echo`).
- **Scheduled a tested job** with cron, absolute paths, and a manual test *before* arming — evidence
  growing on its own in the log.
- **Converged with Ansible** — a play that declares desired state and reports `changed=0` on its second
  run, idempotence proven by the tool; `--check` as the dry-run habit.
- Saw the whole thing through the **seven organs**, and named the three you didn't wire (guard, failure
  path, silence alarm).

**Back on the lesson page:** do the *Self-Check* (recall + "the 3 a.m. test" teach-back), take the *Solo
Lab* (a crash-honest marker, a dead-man's switch by hand), and tick the *Mastery checklist*. When every
box is honestly true, M15 is done and **Module 16 — Docker** becomes current — its image builds ride
exactly these rails.

> The one-sentence takeaway: **M15 turns scripts into systems — idempotent, evidenced,
> alarmed-on-silence — the rails every later module's work runs on, from image builds to ML pipelines.**
