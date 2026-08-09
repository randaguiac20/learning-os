# Done — your environment is code now

You turned setup into version-controlled infrastructure:

- Installed **chezmoi** (owns your *config*) and **mise** (owns your *tools*).
- Put a real dotfile under management and drilled the **edit source → diff → apply** loop.
- Enforced a **600** mode with the `private_` attribute — secrets never land world-readable.
- Pinned a project's runtime with **`mise.toml`**, and saw mise read asdf's `.tool-versions` natively.

**Back on the lesson page:** do the *Self-Check* and *Solo Lab* (template a dotfile by hostname, write a
one-command bootstrap, layer a venv on mise's interpreter), then tick the *Mastery checklist*. When
every box is honestly true, Module 11 (Claude Code) — whose own `CLAUDE.md` and settings ride this same
managed repo — becomes current.

> The one-sentence takeaway: **M10 makes "my setup" versioned, tested infrastructure that every
> remaining module — and every new machine — inherits for free.**
