# Natural Language Processing — hands-on

You have a real Linux machine on the right. In the next few minutes you'll walk the **NLP pipeline**
end to end on CPU — no model downloads, no GPU:

- **tokenize** text by hand (normalize, split, build a vocabulary and token → id map),
- build a **TF-IDF** (Term Frequency–Inverse Document Frequency) vectorizer over a small **inline
  labeled corpus** defined right here in the lab,
- train a classifier and **evaluate it on held-out sentences** it never saw,
- and read **cosine similarity** between two documents plus the model's **most informative words**.

The law of this module: **do the mechanics by hand first, choose the task-appropriate metric, and treat
"fluent" as NOT "correct."** Everything lives in a throwaway `~/nlp-lab/` directory.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms.

Click **START** to begin.
