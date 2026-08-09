# Step 1 — Install the toolkit and read the spec sheet

Install the instruments (`stress-ng` for load, `sysstat` for `mpstat`/`pidstat`, `time` for
`/usr/bin/time -v`, `gcc` to compile the cache demo):

```bash
sudo apt-get update -qq
```{{exec}}

```bash
sudo apt-get install -y stress-ng sysstat linux-tools-common time gcc
```{{exec}}

Now read the machine's spec sheet — the hardware you're about to instrument:

```bash
lscpu
```{{exec}}

Find YOUR cache sizes — everything downstream is "which level of the hierarchy am I hitting?":

```bash
lscpu | grep -i cache
```{{exec}}

How many logical CPUs? This is what load generation will target:

```bash
nproc
```{{exec}}

**Copy your L1/L2/L3 sizes into the latency ladder** (from the lesson): L1 ~1 ns · L2 ~4 ns · L3 ~15 ns
· **DRAM ~60–100 ns** (~100× L1). Those numbers are the map for the rest of the lab.
