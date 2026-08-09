# Step 4 — Feel the cache: row-major vs column-major

Same instructions, same data, same total work — but **access order** decides the speed. Build a tiny C
timer that sums a 64 MB matrix two ways: along rows (sequential, cache-friendly) and down columns
(strided, cache-hostile). Write the program:

```bash
cat > ~/perf-lab/locality.c <<'EOF'
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#define N 4096
int main(int argc, char **argv) {
    int *a = malloc((size_t)N*N*sizeof(int));
    memset(a, 1, (size_t)N*N*sizeof(int));
    int col = (argc > 1 && strcmp(argv[1], "col") == 0);
    struct timespec s, e; long long sum = 0;
    clock_gettime(CLOCK_MONOTONIC, &s);
    if (col) { for (int j=0;j<N;j++) for (int i=0;i<N;i++) sum += a[(size_t)i*N+j]; }
    else     { for (int i=0;i<N;i++) for (int j=0;j<N;j++) sum += a[(size_t)i*N+j]; }
    clock_gettime(CLOCK_MONOTONIC, &e);
    double t = (e.tv_sec-s.tv_sec) + (e.tv_nsec-s.tv_nsec)/1e9;
    printf("%s_major_seconds %.4f\n", col ? "col" : "row", t);
    return (int)(sum & 1);
}
EOF
```{{exec}}

Compile it (with optimization, so the loop is real work — not the demo's overhead):

```bash
gcc -O2 -o ~/perf-lab/locality ~/perf-lab/locality.c
```{{exec}}

Run both and append the timings to a log:

```bash
~/perf-lab/locality row | tee -a ~/perf-lab/locality.log
```{{exec}}

```bash
~/perf-lab/locality col | tee -a ~/perf-lab/locality.log
```{{exec}}

**Look at the two numbers, then record which was faster** — column-major jumps 16 KB per step and misses
the cache, so row-major should win (usually several times over):

```bash
echo "faster=row" | tee -a ~/perf-lab/locality.log
```{{exec}}

That gap is the **memory wall, felt** — a cache miss costs ~100 ns (~300+ instructions). If you have
`perf`, `perf stat -e cache-misses ~/perf-lab/locality col` shows the misses that cause it.

Click **Check** to verify both timings were recorded and your `faster=` verdict matches the numbers.
