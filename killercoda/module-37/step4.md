# Step 4 — `tofu plan` — read the diff before you change anything

`plan` compares your **desired state** (`main.tf`) against **reality** (nothing exists yet) and prints
exactly what it *would* do — without doing it:

```bash
cd ~/iac-lab
tofu plan
```{{exec}}

Read the output carefully:

- Lines marked **`+`** are resources OpenTofu will **create**. You should see `random_pet.server` and
  `local_file.note`.
- The summary line reads **`Plan: 2 to add, 0 to change, 0 to destroy`**.

**Reading the plan every time is the whole discipline.** This is "look before you leap" for
infrastructure — in real cloud, `plan` is where you catch *"wait, that change would destroy the
production database"* **before** it happens. Nothing has been created yet; `plan` is a dry run.

No **Check** on this step — `plan` changes nothing, so there's nothing to verify yet. On to `apply`.
