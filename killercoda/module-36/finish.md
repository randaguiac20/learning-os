# Done — you built a real API

In under 35 minutes you:

- **Designed** an `/items` resource on paper first — resources as nouns, methods as verbs.
- **Built** it in FastAPI with the **correct status codes**: `201` on create, `404` on missing.
- **Validated** input with **Pydantic** — a bad body is rejected with `422`, not crashed on (`500`).
- **Protected** a route with a token — the same `DELETE` is `401` without it and `200` with it (authn).
- **Read** the **auto-generated OpenAPI** contract the framework built from your type hints.

That is the difference between "returning JSON from a function" and an **API**: a designed contract with
correct methods, honest status codes, validated input, and auth — the JSON is the easy part.

**Back on the lesson page:** do the *Solo Lab* (add `PUT`, pagination, authorization vs authentication,
and versioning), then the *Self-Check* and the *Mastery checklist*. When every box is honestly true,
you've closed **Stage 12 (Data & Software Engineering)** and Module 37 (Cloud Platforms) becomes current.

> The one-sentence takeaway: **an API is a contract with consumers you don't control — correct status
> codes, validation, auth, and versioning are what make it a service instead of a script.**
