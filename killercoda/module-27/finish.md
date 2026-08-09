# Done — you ran the discipline

In about 25 minutes you:

- **Split honestly first** — sealed a test set away with `train_test_split` before touching the data, and
  proved (0 overlap) that no row leaked from train into test.
- **Trained and measured** a logistic regression, read a **confusion matrix**, and wrote the result to
  `metrics.json` — the honest number, on rows the model never saw.
- **Met the dragon** — an unbounded tree memorized the training set (train ~1.0, big gap), and **capping
  its depth** (regularization) shrank the gap: the bias-variance U-curve, felt.
- **Beat a baseline** — your ~0.96 model is worth the *difference* from the ~0.10 majority-class floor —
  and used **cross-validation** for a stable estimate without ever replacing the test set.

**Back on the lesson page:** do the *Self-Check* (the drug-trial teach-back) and tick the *Mastery
checklist*. Then take the *Solo Lab* further — the accuracy trap, planting and catching a leak, climbing
the classical ladder, and the "don't ship" verdict.

> The one-sentence takeaway: **generalization is the only thing you buy — a model will flatter you with
> memorized answers unless the split contract, the baseline law, and the card stand between your
> enthusiasm and your claims.**
