# Docker — hands-on

You have a real Linux **VM** in the terminal on the right — a full machine with its own kernel, so
**Docker really runs here** (a browser container-in-a-container would not be enough). In the next
half-hour you'll:

- run a container and **prove it is just an ordinary process** on the host,
- write a **Dockerfile**, `docker build` it into an **image**, and run that image,
- **publish a port** and persist data in a **named volume**,
- and bring up a **2-service `docker compose` rig** whose services find each other **by name**.

The one idea to hold onto: a container is **not** a mini-VM. It is a single process wearing namespaces
(its own view of files/network) and cgroups (its limits), on the **shared** host kernel.

> Tip: **type every command yourself** — don't paste. Typing is part of how the memory forms, and reading
> each command before it runs is a habit worth building.

Click **START** to begin.
