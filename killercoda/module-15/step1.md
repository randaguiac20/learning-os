# Step 1 — Set up the workshop

Install the scheduler and the config-management tool, start the cron daemon, and build your sandbox.

Install `cron` and `ansible` (one `apt-get`), then start cron:

```bash
sudo apt-get update -qq && sudo apt-get install -y cron ansible
```{{exec}}

```bash
sudo service cron start
```{{exec}}

Build the throwaway sandbox — all work lives here:

```bash
mkdir -p ~/automation-lab && cd ~/automation-lab
```{{exec}}

```bash
pwd
```{{exec}}

Confirm Ansible is really installed:

```bash
ansible --version | head -1
```{{exec}}

`cron` is the scheduler; `ansible` is the config-management tool you'll use in Step 4. In production you
would reach for **systemd timers** (they log to journald and catch up missed runs) — but a container has
no `systemd` running as PID 1, so this lab uses **cron**, which runs anywhere. The engineering concepts —
idempotence, evidence, testing before arming — are identical either way.
