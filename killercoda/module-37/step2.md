# Step 2 — Write your first config (main.tf)

IaC starts by **describing what you want** — the *desired state* — in a config file. Make a working
directory and write `main.tf`:

```bash
mkdir -p ~/iac-lab && cd ~/iac-lab
```{{exec}}

```bash
cat > main.tf <<'HCL'
terraform {
  required_providers {
    random = { source = "hashicorp/random" }
    local  = { source = "hashicorp/local"  }
  }
}

# A resource with NO cloud and NO cost — a random pet name.
resource "random_pet" "server" {
  length = 2
}

# A REAL local file, its content driven by the resource above.
resource "local_file" "note" {
  filename = "${path.module}/server-name.txt"
  content  = "Provisioned server: ${random_pet.server.id}\n"
}
HCL
```{{exec}}

```bash
cat main.tf
```{{exec}}

**Read the config:**

- The `terraform { required_providers ... }` block declares which **providers** (plugins) this config
  needs — here `random` and `local`. In real cloud you'd add `aws`, `azurerm`, or `google` here.
- `resource "random_pet" "server"` declares a resource you *want to exist*. You never say *how* to make
  it — OpenTofu figures that out.
- `local_file.note` references `random_pet.server.id`, so its content **depends on** the pet name.
  OpenTofu reads that dependency and creates them in the right order.

You described the destination. The next commands compute and apply the route.
