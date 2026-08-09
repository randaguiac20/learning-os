# Step 5 — Make it a command (argparse)

A function becomes a **tool** when it has a command-line interface. Wrap the module in a small `argparse`
CLI — the same shape an installed entry point would call:

```bash
cat > ~/recall/recall_cli.py <<'PY'
"""A minimal argparse CLI over the cards module — the entry-point idea, in miniature."""
import argparse
from cards import parse_cards, due_fronts

SAMPLE = ["capital of France|Paris", "2+2|4", "malformed line"]


def main() -> int:
    parser = argparse.ArgumentParser(prog="recall", description="Tiny Recall demo")
    parser.add_argument("--count", action="store_true", help="print how many cards parsed")
    args = parser.parse_args()
    cards = parse_cards(SAMPLE)
    if args.count:
        print(len(cards))
    else:
        for front in due_fronts(cards):
            print(front)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
PY
```{{exec}}

Run it three ways — default output, the `--count` flag, and the help you got for free:

```bash
cd ~/recall && python recall_cli.py
```{{exec}}

```bash
cd ~/recall && python recall_cli.py --count
```{{exec}}

```bash
cd ~/recall && python recall_cli.py --help
```{{exec}}

`argparse` gave you `--help`, flag parsing, and usage errors with no extra work. In a real package,
`pyproject.toml`'s `[project.scripts] recall = "recall.cli:main"` plus `pip install -e .` would put a
`recall` command on your `PATH` — this file is that idea in one hand.

You built an isolated environment, installed a package into it, wrote a typed module with a generator,
tested it green, and turned it into a command. That's Module 13, hands-on.
