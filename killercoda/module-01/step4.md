# Step 4 — Your first script

Four inspection commands in a text file *is a real program*. Build it.

Create `myinfo.sh`:

```bash
cat > myinfo.sh <<'EOF'
#!/bin/bash
echo "=== Kernel ==="; uname -r
echo "=== CPU ==="; lscpu | grep -E 'Model name|^CPU\(s\)'
echo "=== Memory ==="; free -h | awk 'NR==1 || /Mem:/'
echo "=== Disks ==="; df -h --output=source,size,pcent,target -x tmpfs -x devtmpfs | head
EOF
```{{exec}}

Make it executable and run it:

```bash
chmod +x myinfo.sh
./myinfo.sh
```{{exec}}

Two ideas you just used for real:

- The **shebang** (`#!/bin/bash`) tells the kernel which interpreter to load.
- The **execute bit** (`chmod +x`) is a filesystem permission — without it, the kernel refuses to run the file.

This little script is the seed of the "System Caretaker" project you grow in Stage 2.

Click **Check** to verify `myinfo.sh` exists, is executable, and runs.
