# Done — the bench can see itself

In about 30 minutes you:

- Obtained the **real Prometheus** — one static binary — and confirmed it runs.
- Ran a target that exposes a `/metrics` endpoint and read what an **exporter actually says**.
- Wrote a `prometheus.yml` **scrape config** — the pull model's inventory of everything it watches.
- Started Prometheus and queried **`up`** over the HTTP API — the cheapest, most important series you own.
- Wrote a **golden-signal** query with `rate()` (traffic per second) and saw why counters are never read raw.
- Met the **absent-metric trap**: a vanished target returns *no data*, so you alert on **`up == 0`** — absence needs its own alert.

**Back on the lesson page:** do the *Solo Lab* (the cardinality bomb, the counter-reset check, one lawful
alert and one deletion), then the *Self-Check* and the *Mastery checklist*. When every box is honestly
true, you've closed **Stage 9** — Fortress & Watchtower together — and Module 26 (AI Foundations) becomes
current.

> The one-sentence takeaway: **the stack is an afternoon; the discipline — which questions, which alerts,
> which severities — is the module. Alert on symptoms, graph the rest, and delete the bells until every
> ring means run.**
