# Done — you debugged by method, not by guessing

In a few minutes you:

- Installed the kit — **`strace`** (the program↔kernel wiretap), **`ltrace`**, and **`gdb`**.
- **Read the error and the exit code** instead of theorising — and caught a contradiction (`ENOENT` on a
  file that `ls` shows exists).
- Used **`strace -e trace=file`** to see the path a program *actually* opened, found the misplaced config,
  fixed the **root cause**, and **verified** by re-running the original failure.
- **`git bisect run`**-ed a regression to a single commit in `O(log n)` tests, fixed the flipped operator,
  and proved the test green.
- Told **root cause from symptom** — and satisfied rule 9: *if you didn't fix it, it ain't fixed.*

**Back on the lesson page:** do the *Self-Check* (the detective frame + the three witnesses), then take the
*Solo Lab* gauntlet **bare-hands** and tick the *Mastery checklist*. When every box is honestly true, you
have the method that routes between every layer you've learned.

> The one-sentence takeaway: **evidence picks the layer, the ladder walks it, the journal remembers it, and
> the post-mortem makes sure it never costs full price twice.**
