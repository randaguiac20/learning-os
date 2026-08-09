# Step 2 — Names: DNS and the /etc/hosts override

A **name** is not an address — DNS is the phonebook that turns one into the other. Resolve a name the
normal way, then read the full answer:

```bash
dig +short example.com
```{{exec}}

```bash
dig example.com
```{{exec}}

Read every section of the full `dig` output: **question** (what you asked), **answer** (the records),
and the **TTL** — the number beside each record. Run `dig example.com` again and watch the TTL **count
down**: that is a resolver's cache, live. The TTL is a *cache lifetime in seconds*, not a hop count.

What does the **system** resolver return (this follows `/etc/nsswitch.conf`'s lookup order)?

```bash
getent hosts example.com
```{{exec}}

Now the override rig. `/etc/hosts` is consulted **before** DNS, so you can define a name locally. Point
a friendly name at your own loopback — you'll serve a page from it in the next step:

```bash
echo "127.0.0.1 lab.local" | sudo tee -a /etc/hosts
```{{exec}}

```bash
getent hosts lab.local
```{{exec}}

`lab.local` resolves to `127.0.0.1` — and no DNS server was ever asked. Your `/etc/hosts` entry won
because `nsswitch.conf` lists `files` before `dns`. Keep this entry; steps 4 and 5 rely on it.
