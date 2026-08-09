# Step 1 — Your machine's network identity

First, install the toolkit this lab uses (one command):

```bash
sudo apt-get update -qq && sudo apt-get install -y iproute2 dnsutils tcpdump curl netcat-openbsd
```{{exec}}

Now read your machine's stack from the link layer up. Interfaces and their IP addresses:

```bash
ip addr
```{{exec}}

Link state and MAC addresses (the link layer's own addresses):

```bash
ip link
```{{exec}}

The route table — which line begins with `default`? That is your **default gateway**: everything the
machine doesn't recognise goes there.

```bash
ip route
```{{exec}}

The ARP cache — the link layer's phonebook, mapping IP → MAC on the local wire:

```bash
ip neigh
```{{exec}}

**Look at the output and answer (in your head or a journal):**

- Which address is on `lo` (loopback)? It should be `127.0.0.1` — reachable only from this machine.
- Which of your addresses is **RFC 1918 private** (`10.`, `172.16`–`172.31.`, or `192.168.`)?
- `ip addr` shows the address (Internet layer); `ip link` shows the MAC (Link layer) — two different
  address types, two different layers, one interface.
