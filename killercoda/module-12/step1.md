# Step 1 — Meet the interpreter: values, types, variables

First, a workspace. Everything you write lives here:

```bash
mkdir -p ~/learning/py && cd ~/learning/py
```{{exec}}

The interpreter is a process — check which version you're running:

```bash
python3 --version
```{{exec}}

**Every value has a type**, and the type decides what operations mean. Ask each value what it is:

```bash
python3 -c 'print(type(5), type(3.14), type("hi"), type(True), type(None))'
```{{exec}}

**Variables are names bound to objects** — and a name can rebind to a value of a *different* type
(dynamic typing):

```bash
python3 -c 'x = 5; print(x, type(x)); x = "now text"; print(x, type(x))'
```{{exec}}

Now the single most important model in the language. `b = a` does **not** copy — it makes a **second
name** for the **same** object. Mutate through one and the other sees it (this is *aliasing*):

```bash
python3 -c 'a = [1, 2, 3]; b = a; b.append(4); print("a:", a, "b:", b)'
```{{exec}}

Both print `[1, 2, 3, 4]`. To get an independent **copy**, slice it — a *new* object:

```bash
python3 -c 'a = [1, 2, 3]; c = a[:]; c.append(9); print("a:", a, "c:", c)'
```{{exec}}

Here `a` stays `[1, 2, 3]`. Assignment **binds**, it never copies. Hold this "sticky notes on objects, not
boxes" picture — it predicts every aliasing bug you will ever meet.

> `python3` on its own opens the interactive **REPL** (`>>>`) — your experiment bench. Type `exit()` to
> leave it. We'll drive this lab with `python3 -c '...'` and program files so every result is repeatable.
