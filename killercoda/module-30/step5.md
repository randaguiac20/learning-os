# Step 5 — Modular arithmetic and the pigeonhole principle

Discrete math's last thread: **number theory**. **Modular arithmetic** (`a mod n` = the remainder — "clock
math") is the engine under two things you've already used — **crypto** (M24) and **hashing** (M32) — and the
**pigeonhole principle** proves *why hash collisions are inevitable*.

```bash
cd ~/math-lab
```{{exec}}

```bash
python3 - <<'EOF'
from math import comb, gcd
print("gcd(48, 18) =", gcd(48, 18))       # Euclid's algorithm -> 6
print("7^4 mod 13  =", pow(7, 4, 13))     # modular exponentiation: crypto's one-way engine (M24)
print("C(5,2)      =", comb(5, 2))        # combinations: 10 unordered choices of 2 from 5
EOF
```{{exec}}

`pow(7, 4, 13)` is **modular exponentiation** — easy forward, but reversing it (the discrete logarithm) is
believed **hard**. That one-way asymmetry is what makes M24's public-key crypto possible.

Now the **pigeonhole principle**: put `n` items into `m < n` boxes and *some box must hold ≥ 2*. Map 11 keys
into 10 hash buckets and watch a collision appear — provably, not by luck:

```bash
python3 - <<'EOF'
buckets = {}
for key in range(11):                 # 11 keys
    b = key % 10                       # into 10 buckets (mod maps key -> bucket)
    buckets.setdefault(b, []).append(key)
collision = any(len(keys) >= 2 for keys in buckets.values())
print("buckets:", buckets)
print("a bucket with >= 2 keys?", collision)   # True — pigeonhole guarantees it
EOF
```{{exec}}

`mod` is how a hash maps a key to a bucket (M32), and the pigeonhole principle is **why hash collisions
provably exist** — 11 keys cannot fit 10 buckets without a repeat. That's discrete math *proving* a fact
testing could only ever suggest.
