# Step 3 — Write a small typed module

Now write a real module: a `@dataclass`, **type hints**, a **generator**, and **EAFP** parsing (try the
happy path, handle the failure). Create `cards.py` in the project:

```bash
cat > ~/recall/cards.py <<'PY'
"""A tiny Recall module: typed records, a generator, EAFP parsing."""
from dataclasses import dataclass, field
from typing import Iterable


@dataclass
class Card:
    front: str
    back: str
    reviews: list[int] = field(default_factory=list)   # mutable default, done right

    @property
    def accuracy(self) -> float:                        # computed, never stale
        if not self.reviews:
            return 0.0
        return sum(self.reviews) / len(self.reviews)


def parse_cards(lines: Iterable[str]) -> list[Card]:
    """Parse 'front|back' lines into Cards, skipping malformed ones (EAFP)."""
    cards: list[Card] = []
    for line in lines:
        line = line.strip()
        if not line:
            continue
        try:
            front, back = line.split("|", 1)            # ValueError if there is no '|'
        except ValueError:
            continue                                    # skip the malformed line
        cards.append(Card(front.strip(), back.strip()))
    return cards


def due_fronts(cards: Iterable[Card]):
    """Lazily yield each card's front — a generator, one at a time."""
    for card in cards:
        yield card.front
PY
```{{exec}}

Try it — the malformed line (`'nope'`, no `|`) should be skipped, so this prints `2`:

```bash
cd ~/recall && python -c "from cards import parse_cards; print(len(parse_cards(['a|b','nope','c|d'])))"
```{{exec}}

Notice the engineering moves: hints (`Iterable` in, `list[Card]` out), `field(default_factory=list)` for
the mutable default, an `@property` for a computed value, and a `yield` generator.

Click **Check** to verify the venv, the installed package, and the module all work.
