# devcontainers — author a bench from a blank file

A **dev container** is a development environment defined as code: a `devcontainer.json` (an open spec —
containers.dev) that says which image, tools, ports, and setup a repo needs, so *"set up to hack on
this"* becomes one command. A client — VS Code, GitHub Codespaces, DevPod, or the devcontainer CLI —
reads the file and **materializes** the bench.

In this scenario you play the client **by hand**. You'll write a `Dockerfile` and a valid
`devcontainer.json` for a tiny repo, and — because this VM has **Docker** — actually *build* the image
the spec references and run its setup, proving the environment assembles. No editor required: this is the
machinery the Codespaces button hides.

Everything lives in a throwaway `~/hello-bench/` repo you create — nothing else is touched.

> Tip: **type every command yourself.** Devcontainers are learned in the writing; a template you paste
> teaches nothing.

Click **START** to begin.
