# Observability — a real Prometheus, hands-on

You have a real Linux machine in the terminal on the right. In the next few minutes you'll stand up the
**actual Prometheus** — obtain its static binary, run a small app that exposes a `/metrics` endpoint,
write a scrape config, start Prometheus, and query it over its HTTP API — the same tool the industry
runs.

The point isn't installing the stack (that's an afternoon). It's the **discipline**: `up` is the
cheapest, most important series you own; counters are queried with `rate()`, never raw; and an alert
must answer *"must a human act NOW?"* You'll meet the **absent-metric trap** and reason about one lawful
alert.

**Everything lives inside a throwaway `~/obs-lab/` sandbox you create** — nothing outside it is touched.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms.

Click **START** to begin.
