# Step 5 — The run-twice license, recapped

Look at everything you built through the lens of the **seven organs** of a production job.

The **trigger** (the schedule):

```bash
crontab -l
```{{exec}}

The **evidence** (what the job did, on its own):

```bash
cat ~/automation-lab/heartbeat.log
```{{exec}}

The **action's result** — the state Ansible converged:

```bash
ls -R ~/automation-lab/managed
```{{exec}}

And the **idempotence** proof once more, straight from the recap:

```bash
ansible-playbook -i localhost, -c local ~/automation-lab/play.yml | grep -A1 'PLAY RECAP'
```{{exec}}

You proved idempotence **two ways** — by hand (the run-twice diff in Step 2) and by tool (Ansible's
`changed=0`). That proof is the *license to schedule*: only a job that survives its own second run belongs
on a timer.

The organs you didn't wire here — a **guard** (`flock` against overlap), a **failure path** (`OnFailure=`
/ a notification), and the **silence alarm** (a freshness / dead-man's check) — are the difference between
this lab and a system you'd trust at 3 a.m. The Solo Lab's stretch challenge builds that silence alarm by
hand. That's Module 15, hands-on.
