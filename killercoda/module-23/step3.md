# Step 3 — strace the failing syscall, fix the root cause

Point the wiretap at the file syscalls and watch the program try to open its config:

```bash
strace -f -e trace=file ~/debug-lab/report.sh 2>&1 | grep -i 'report.conf'
```{{exec}}

Read the line ending in `= -1 ENOENT`. It shows the **exact path** the program passed to `openat()` — and
it's `.../debug-lab/etc/report.conf`, **not** the `~/debug-lab/report.conf` you can see with `ls`. The file
exists; the program just looks somewhere else. This is the classic **"works on my machine"** bug: an
`ENOENT` that survives an `ls` because the path the code opens isn't the path you're looking at.

The **root cause** is the missing config *at the path the program actually reads*. Fix that — put the
config where it's looked for:

```bash
mkdir -p ~/debug-lab/etc
```{{exec}}

```bash
cp ~/debug-lab/report.conf ~/debug-lab/etc/report.conf
```{{exec}}

Now **verify against the original symptom** (rule 9 — re-run the exact thing that failed):

```bash
~/debug-lab/report.sh; echo "exit=$?"
```{{exec}}

You should see `Report OK — threshold=42` and `exit=0`. You fixed the *cause* (a misplaced config), not a
*symptom*, and you proved it by re-running the original failure.

Click **Check** to verify `report.sh` now exits 0 with the right threshold.
