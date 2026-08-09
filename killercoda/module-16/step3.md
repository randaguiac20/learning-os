# Step 3 — Write a Dockerfile and build an image

An **image** is built from a **Dockerfile** — a recipe read top to bottom, one layer per instruction.
Make a build directory and a page to serve:

```bash
mkdir -p ~/docker-lab && cd ~/docker-lab
```{{exec}}

```bash
echo '<h1>Hello from my own image</h1>' > index.html
```{{exec}}

Write a tiny Dockerfile: base image, copy our file in, document the port:

```bash
printf 'FROM nginx:alpine\nCOPY index.html /usr/share/nginx/html/index.html\nEXPOSE 80\n' > Dockerfile
```{{exec}}

See it:

```bash
cat Dockerfile
```{{exec}}

Build it into an image named `hello-web` — the `.` is the **build context** (the files) sent to the
engine:

```bash
docker build -t hello-web .
```{{exec}}

Your image now exists locally — confirm and read its layers:

```bash
docker images hello-web
```{{exec}}

```bash
docker history hello-web
```{{exec}}

`FROM` pinned the base, `COPY` added your file as a layer, and `EXPOSE` only **documents** port 80 — it
publishes nothing (that's Step 4's `-p`).

Click **Check** to verify the `hello-web` image was built.
