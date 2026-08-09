# Step 5 — Solo challenges (no instructions)

Now prove it to yourself. Try each **before** peeking — struggle is where the learning is.

### Challenge 1 — Count the context switches
How many times has the scheduler switched processes since boot?

<details><summary>Reveal answer</summary>

```bash
grep ctxt /proc/stat
```
`/proc/stat`'s `ctxt` line is the total since boot. The kernel exposes live state as files under `/proc`.
</details>

### Challenge 2 — Reconcile the CPU count
Make `nproc` agree exactly with `lscpu`.

<details><summary>Reveal answer</summary>

`nproc` = `Socket(s) × Core(s) per socket × Thread(s) per core` (from `lscpu`). If threads-per-core is 2,
that's hyper-threading — logical CPUs are double the physical cores.
</details>

### Challenge 3 — Read the error, name the layer
Run `ls /root`. It fails. **Which layer** refused you, and why is that *correct*?

```bash
ls /root
```{{exec}}

<details><summary>Reveal answer</summary>

Filesystem **permissions**, enforced by the kernel: `/root` is mode `700`, owned by root. Your
unprivileged user is denied by the protection model — security working exactly as designed.
</details>

You've inspected a machine, run a process lifecycle, written a script, and reasoned about protection.
That's Module 01, hands-on.
