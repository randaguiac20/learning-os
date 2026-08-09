# Step 1 — Read the prompt, get your bearings

Before any command, three questions: *where am I, what's here, who am I?*

Where am I?

```bash
pwd
```{{exec}}

What's here — plain, long form, and including hidden dotfiles?

```bash
ls
```{{exec}}

```bash
ls -l
```{{exec}}

```bash
ls -la ~
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- In your **prompt**, find the four parts: user, host, current directory, and the `$`.
- What did `-a` reveal that `ls` alone hid? (Dotfiles like `.bashrc` — unlisted, not secret.)
- The first character of each `ls -l` line tells you file vs directory: `d` = directory, `-` = file.

A `$` prompt means a normal user — you own your home, mistakes here are cheap. A `#` would mean
**root**: full-system power. This whole scenario stays as a normal user and never needs `sudo`.
