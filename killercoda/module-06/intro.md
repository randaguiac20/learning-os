# Vim — editing as a language

You have a real Linux machine in the terminal on the right, and **Vim** waiting to be used. Vim is a
**modal** editor: instead of one mode where keys insert characters, it has modes where keys are
**commands** — and those commands form a grammar (verb + motion/object) that turns editing intentions
into a few repeatable keystrokes.

In the next few minutes you'll check your Vim, feel the mode map, wield the verb × motion grammar and
the dot command, change text with **text objects**, and run file-wide **Ex** commands. Two of the steps
give you a starter file to transform and then **Check** the result.

**Everything happens inside a throwaway `~/vim-lab/` sandbox you create** — nothing outside it is
touched.

> Tip: the whole point is to **drive Vim yourself**. When you don't know a command, try `:help` before
> reaching for anything else — the manual is installed on the machine.
>
> If you ever feel stuck in Vim: press **`Esc`** to reach Normal mode, then `:q!` leaves without
> saving, `:wq` saves and leaves.

Click **START** to begin.
