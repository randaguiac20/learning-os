# Machine Learning — hands-on

You have a real Linux machine on the right and Python waiting. In the next few minutes you'll install
scikit-learn, load a dataset that ships **inside** the package (no downloads), and run the core loop of
the whole discipline: **split the data honestly, train a model, measure it on data it never saw, read a
confusion matrix** — then cause **overfitting** on purpose and cure it.

The one law behind everything here: **generalization is the only thing you buy.** A model that scores
100% on its training data has told you nothing — the only honest evidence is performance on rows it
never trained on. Everything you do keeps that evidence honest.

**Everything is CPU-only** — no GPU needed. scikit-learn's toy datasets (digits, breast-cancer) live in
the library, so nothing is fetched from the network.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms.

Click **START** to begin.
