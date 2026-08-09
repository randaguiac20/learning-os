# Dotfiles & Toolchains — hands-on

You have a real Linux machine in the terminal on the right. In the next few minutes you'll make your
**environment into code**: install **chezmoi** (a dotfile manager) and **mise** (a toolchain manager),
put a real dotfile under management, drill the **edit → diff → apply** loop until it's reflex, enforce a
`600` mode that Git alone can't store, and pin a project's runtime version.

**Everything happens inside this throwaway machine's home** — you can reset it freely. The core idea:
chezmoi keeps a **source of truth** in a git repo and *reconciles* your real files to it (one direction,
never a two-way sync); mise pins the right tool versions **per directory**.

> Tip: **type every command yourself** — don't copy-paste. Typing is part of how the memory forms, and
> the whole point of the loop is that it becomes a habit.

Click **START** to begin.
