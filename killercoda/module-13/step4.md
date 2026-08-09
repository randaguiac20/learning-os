# Step 4 — Write a test and run the gate

Untested Python is unfinished Python. Write a pytest suite for `cards.py` — including a **parametrized**
test that sweeps several cases through one function:

```bash
cat > ~/recall/test_cards.py <<'PY'
import pytest
from cards import Card, parse_cards, due_fronts


def test_accuracy_empty():
    assert Card("q", "a").accuracy == 0.0


@pytest.mark.parametrize("reviews, expected", [
    ([1, 1, 1], 1.0),
    ([1, 0], 0.5),
    ([0, 0], 0.0),
])
def test_accuracy(reviews, expected):
    assert Card("q", "a", reviews).accuracy == expected


def test_parse_skips_malformed():
    cards = parse_cards(["hi|hello", "garbage-no-pipe", "", "chat|talk"])
    assert len(cards) == 2
    assert cards[0].front == "hi"


def test_due_fronts_is_lazy():
    gen = due_fronts([Card("a", "b"), Card("c", "d")])
    assert next(gen) == "a"   # one item pulled — the rest never computed
PY
```{{exec}}

Run the suite (from the project so `import cards` resolves):

```bash
cd ~/recall && python -m pytest -q
```{{exec}}

Green pytest is the treaty signed — the dynamic-typing safety net, in place. The `parametrize` decorator
turned one test into four cases without copy-paste.

Click **Check** to confirm the suite passes inside the venv.
