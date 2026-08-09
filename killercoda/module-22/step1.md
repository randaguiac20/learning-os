# Step 1 — Two philosophies + your bench

Hardware honesty first: make a sandbox and check what silicon this box actually carries.

```bash
mkdir -p ~/gpu-lab && cd ~/gpu-lab
```{{exec}}

```bash
lspci 2>/dev/null | grep -i 'vga\|3d\|display' || echo "no discrete GPU enumerated (expected here)"
```{{exec}}

```bash
command -v nvidia-smi >/dev/null && nvidia-smi || echo "no nvidia-smi here — that's fine; we compute the numbers instead"
```{{exec}}

```bash
python3 --version
```{{exec}}

There is **no GPU** on this VM — and that is the design of this lab. The two philosophies:

- **CPU — latency AVOIDANCE:** a few fast cores with big caches and branch prediction keep one thread
  from waiting.
- **GPU — latency HIDING:** thousands of simple cores oversubscribed so a stalled warp (32 threads in
  lockstep) is instantly swapped for a ready one — stalls cost nothing while work remains.

Everything a GPU wins at reduces to arithmetic you can do right here. Journal the one question this whole
module hangs on: **is my workload wide and regular?** If yes, keep going; if no, the CPU is the answer and
you've saved yourself a transfer tax.
