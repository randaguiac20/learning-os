# Backend & API Engineering — hands-on

You have a real Linux machine on the right. In the next few minutes you'll build a **REST API**
(Representational State Transfer — the HTTP style where resources are nouns and methods are verbs) with
**FastAPI**, a Python web framework, and exercise it with `curl`.

You will build an `/items` resource that does the professional things a demo skips:

- **Correct HTTP status codes** — `201` on create, `404` on missing, `422` on invalid input.
- **Request validation** with **Pydantic** — bad input is rejected at the boundary, automatically.
- **A token-protected route** — the same request is `401` without a token and `200` with one.
- **Auto-generated OpenAPI docs** — the API documents itself.

> Design first: we sketch the resource, methods, and status codes *before* writing code — that paper
> design is the contract. Then we build it and hit every endpoint by hand to *feel* the request/response.

Click **START** to begin.
