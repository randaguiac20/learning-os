# Step 4 — Converge with Ansible

Cron *runs* a script; **Ansible** lets you *declare state* and have the tool converge to it — idempotence
as a product, not a discipline you hand-maintain. A play is a list of desired states; each **module**
(`file`, `copy`, `lineinfile`) checks reality and acts only on the drift.

Write a play declaring three independent resources:

```bash
cat > ~/automation-lab/play.yml <<'EOF'
- name: Converge the workshop state
  hosts: localhost
  connection: local
  gather_facts: no
  vars:
    base: "{{ lookup('env', 'HOME') }}/automation-lab/managed"
  tasks:
    - name: Ensure the managed directory exists
      file:
        path: "{{ base }}"
        state: directory
        mode: '0755'
    - name: Ensure app.conf has exactly this content
      copy:
        dest: "{{ base }}/app.conf"
        mode: '0644'
        content: |
          # Managed by Ansible — do not edit by hand
          role = worker
          retries = 3
    - name: Ensure a single owner line exists in notes.txt
      lineinfile:
        path: "{{ base }}/notes.txt"
        line: "owner = automation-lab"
        create: yes
EOF
```{{exec}}

Run it against localhost with **no SSH** (`-i localhost,` is an inline inventory; `-c local` skips SSH).
The **first** run changes things:

```bash
ansible-playbook -i localhost, -c local ~/automation-lab/play.yml
```{{exec}}

Read the **PLAY RECAP** — `changed=3`. Now run the **exact same command again**:

```bash
ansible-playbook -i localhost, -c local ~/automation-lab/play.yml
```{{exec}}

`changed=0` on the second run is idempotence *proven by the tool*: you declared state, Ansible diffed
reality and did nothing. Try the **dry run** too — it predicts changes without making any:

```bash
ansible-playbook -i localhost, -c local --check --diff ~/automation-lab/play.yml
```{{exec}}

Click **Check** to verify the play applied its state and is idempotent (a fresh run reports `changed=0`).
