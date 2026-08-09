# Step 2 — CPU, memory, storage

These three are the top of the **memory hierarchy** made concrete. Inspect each.

## CPU

```bash
lscpu | head -12
```{{exec}}

Find: **cores vs threads**, and the L1/L2/L3 **cache** sizes. Cache is the tiny, ultra-fast memory
that sits between the CPU and RAM.

## Memory

```bash
free -h
```{{exec}}

The trap: **"used" looks high, but that's mostly cache.** Read the **`available`** column — that's
what's really free. High cache use is the OS being *smart*, not short of memory.

## Storage

```bash
lsblk
```{{exec}}

```bash
df -h
```{{exec}}

Map the chain in your head: **physical device → partition → mount point → your files.**

> Memory (RAM) is the fast workbench that clears when the power goes off. Storage (disk) is the
> pantry that keeps things. Confusing the two is the most common beginner mistake — now you won't.
