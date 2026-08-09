# Step 3 — Install the key, log in password-free

For your key to open the door, its **public** half must be listed in the target user's
`~/.ssh/authorized_keys`. Make sure the directory is right, then authorize your key:

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
```{{exec}}

```bash
cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
```{{exec}}

```bash
chmod 600 ~/.ssh/authorized_keys
```{{exec}}

Now log in **with no password** — `BatchMode=yes` means "keys only, never prompt", so a success proves
the key did the work:

```bash
ssh -o BatchMode=yes localhost 'whoami; hostname'
```{{exec}}

Watch **authentication #2** happen — the client *offers* your key, signs the server's challenge, and the
server *accepts* it:

```bash
ssh -v localhost true 2>&1 | grep -iE 'offering|accepted|authenticated'
```{{exec}}

The server challenged, your key **signed**, and the signature matched a line in `authorized_keys` —
nothing replayable ever crossed the wire. In real life `ssh-copy-id user@host` appends that line for you;
here you did it by hand to see exactly what it writes.

Click **Check** to verify your key pair exists and is authorized.
