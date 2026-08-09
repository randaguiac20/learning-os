# Step 5 — Watch the packets, then run the ladder

Everything so far has been inferred. Now **see** it: capture your own loopback traffic while a request
happens. Start a short capture in the background, generate traffic, and let it print:

```bash
sudo tcpdump -i lo -n -c 10 port 8080 &
```{{exec}}

```bash
sleep 1 && curl -s http://lab.local:8080/ >/dev/null && sleep 1
```{{exec}}

In the tcpdump output, find the shape of a TCP connection:

- **`[S]`** — the SYN (client says "let's talk").
- **`[S.]`** — the SYN-ACK (server agrees).
- **`[.]`** — the ACK (client confirms) — the three-way handshake is complete.
- then the HTTP request and response, and **`[F.]`** — the FIN teardown.

That is encapsulation made visible: the HTTP text lives inside a TCP segment inside an IP packet.

### The debugging ladder — the reflex to keep

Five commands, one minute, each testing one layer. Run them top to bottom; the first that fails names
the broken layer:

```bash
ip addr | grep "inet "
```{{exec}}

```bash
ip route | grep default
```{{exec}}

```bash
dig +short example.com
```{{exec}}

```bash
curl -sI http://lab.local:8080/
```{{exec}}

`ip addr` (do I have an address?) → `ip route` (a way out?) → `dig` (do names resolve?) → `curl` (does
the app answer?). This ladder is the module's single most useful habit — drilled until it's reflex.
