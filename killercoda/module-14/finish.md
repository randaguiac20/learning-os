# Done — the invisible layer, now inspectable

In about 30 minutes you:

- Read your machine's **network identity** — interfaces, IP addresses, MACs, the route table, the ARP
  cache — with the `ip` suite, from the link layer up.
- Resolved names with **`dig`**, watched a TTL count down (caching, live), and **faked a name** with an
  `/etc/hosts` override that beat DNS.
- Started a real **listener** and read the socket directory with `ss -tlnp` — port, process, and bind
  address.
- Drove a request with **`curl -v`** and read it as a transcript — name → TCP → HTTP, end to end.
- Watched the **actual packets** on loopback with `tcpdump`: the SYN / SYN-ACK / ACK handshake, the
  plaintext HTTP, the FIN — encapsulation made visible — and ran the **five-step debugging ladder**.

**Back on the lesson page:** do the *Self-Check* (recall + teach-back) and tick the *Mastery checklist*.
When every box is honestly true, you've closed **Stage 4** — and Netscope v1.0, which turns this
knowledge into shipped software, is the stage's proof.

> The one-sentence takeaway: **M14 makes the invisible layer inspectable — names, routes, ports, and
> packets each with a tool and a failure mode — the network stops being magic and becomes a system you
> can interrogate.**
