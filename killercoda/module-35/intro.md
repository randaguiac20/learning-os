# Software Engineering Practice — a real TDD cycle

You have a real Linux machine on the right. In the next few minutes you'll live the loop that most
separates professionals from amateurs: **write the test before the code.**

On a small price-calculator function you'll:

- write a **failing** pytest test first (**RED**), then the simplest code to pass (**GREEN**),
- catch a **real bug** with an edge-case test and fix it under the test's protection,
- commit **atomically** with git and **review your own diff** with a lightweight checklist.

Everything happens inside a throwaway `~/tdd-lab/` directory — nothing outside it is touched.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms, and
> watching a test go red *before* it goes green is the whole point.

Click **START** to begin.
