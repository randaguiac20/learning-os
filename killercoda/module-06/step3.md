# Step 3 — Text objects: change inside the quotes

**Text objects** are the killer feature: they select a region *around* the cursor by structure —
`i"` *inside* quotes, `a(` *around* parens — so `ci"` works from **anywhere** inside the string, which
is what makes edits repeatable.

Create the starter file (safe to run — it won't overwrite your edits once you've saved):

```bash
cd ~/vim-lab && [ -f greeting.sh ] || printf 'greeting="hello"\nname="stranger"\nrun(alpha, beta, gamma)\n' > greeting.sh; cat greeting.sh
```{{exec}}

Open it in Vim:

```bash
vim greeting.sh
```{{exec}}

**Your task — do all three with text objects, then save:**

1. Put the cursor **anywhere** inside `"hello"` and press `ci"`, type `welcome`, then `Esc`.
2. Put the cursor **anywhere** inside `"stranger"` and press `ci"`, type `friend`, then `Esc`.
3. Put the cursor **anywhere** inside the parentheses on line 3 and press `di(` to delete the argument
   list (leaving `run()`).

The file should end up as:

```text
greeting="welcome"
name="friend"
run()
```

Save and quit:

```
:wq
```

If you slip, reopen with `vim greeting.sh` and fix it — `u` undoes, and `ci"` / `di(` work from
anywhere inside the target. Then click **Check**.
