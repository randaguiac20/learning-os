# Step 2 — Verbs, motions, and the dot command

The grammar is `[count] verb motion/object`. Verbs and motions are independent vocabularies Vim
composes at runtime — learn 6 motions + 3 verbs, not 18 commands.

Create a practice file and open it:

```bash
printf 'the quick brown fox jumps\nover the lazy dog today\n' > grammar.txt
```{{exec}}

```bash
vim grammar.txt
```{{exec}}

**Inside Vim, in Normal mode**, feel the multiplication (ban the arrow keys — use motions):

- **Motions alone (just move):** `w` next word · `b` back · `e` end of word · `0` line start · `$` line end · `gg`/`G` top/bottom
- **Add a verb:** `dw` delete to next word · `d$` delete to end of line · `c2w` change two words · `yy` yank a line
- **Whole line = double the verb:** `dd` `yy` `>>`
- **Char-find:** `f o` jumps to the next `o`; `;` repeats the find, `,` reverses it

Now the payoff — the **dot command `.`** repeats your last change. Try it:

1. Put the cursor on `quick`, press `ciw` and type `slow`, then `Esc`.
2. Move to another word (`w`) and press `.` — the same "change inner word" replays.

Two keystrokes to move, one to act — that's ideal Vim. Leave without saving when you've felt it:

```
:q!
```

> No **Check** on this step — it's pure practice. The next step gives you a file to transform *and*
> verify.
