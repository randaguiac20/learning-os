# Step 4 — Make a request, end to end

Now put the pieces together: request the server by the **name** you defined in step 2 (`lab.local`,
resolved through `/etc/hosts`), and read the whole exchange with `-v`:

```bash
curl -v http://lab.local:8080/
```{{exec}}

Read `curl -v` like a transcript:

- Lines beginning `*` are curl's own notes (it resolved `lab.local` to `127.0.0.1`, then connected).
- Lines beginning `>` are what **you sent** — the request line and headers.
- Lines beginning `<` are what the **server said** — the status line and response headers.

Three layers just cooperated: the **name** resolved locally, **TCP** connected to `127.0.0.1:8080`, and
**HTTP** carried the request as plain, readable text. Headers only:

```bash
curl -sI http://lab.local:8080/
```{{exec}}

Prove the request also works by raw IP — the name was just a convenience the resolver expanded:

```bash
curl -sI http://127.0.0.1:8080/
```{{exec}}

Both work: `lab.local` and `127.0.0.1` are the same destination, reached two ways (a name vs an address).

Click **Check** to verify `lab.local` resolves to loopback and the server answers through it.
