# Step 1 — Install the serving deps

A model server needs two things: a **gateway** framework and something to run it. FastAPI is the gateway;
uvicorn is the ASGI server that serves it. No GPU libraries — the model is a plain Python function, so the
whole stack is tiny.

Confirm Python is here, then install pip:

```bash
python3 --version
```{{exec}}

```bash
apt-get update -qq && apt-get install -y python3-pip
```{{exec}}

Install FastAPI and uvicorn (the fallback handles newer, externally-managed Python):

```bash
pip install fastapi uvicorn 2>/dev/null || pip install --break-system-packages fastapi uvicorn
```{{exec}}

Make a project directory to work in:

```bash
mkdir -p ~/ai-serve && cd ~/ai-serve
```{{exec}}

Prove the import works:

```bash
python3 -c "import fastapi, uvicorn; print('fastapi', fastapi.__version__)"
```{{exec}}

You now have everything a real inference gateway needs, minus the accelerator. On a GPU box you'd add
`llama-cpp-python` or `vllm` here — the shape of the rest of this lab wouldn't change.
