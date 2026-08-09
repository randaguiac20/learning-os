#!/bin/bash
# Killercoda step verifier: pass (exit 0) when the host firewall is default-deny inbound with SSH
# explicitly allowed, and sshd is hardened (keys-only, no root login) and passes its syntax test.

# --- Firewall: default-deny incoming + an explicit SSH allow ---
if ! command -v ufw >/dev/null 2>&1; then
  echo "ufw is not installed — install and configure it in Step 4."
  exit 1
fi

# Default incoming policy must be DROP/deny. ufw stores this in /etc/default/ufw.
if ! grep -Eq '^DEFAULT_INPUT_POLICY="(DROP|REJECT)"' /etc/default/ufw 2>/dev/null; then
  echo "Firewall default incoming policy is not deny — run: sudo ufw default deny incoming"
  exit 1
fi

# The firewall must be enabled.
if ! grep -Eq '^ENABLED=yes' /etc/ufw/ufw.conf 2>/dev/null; then
  echo "Firewall is not enabled — run: sudo ufw --force enable"
  exit 1
fi

# SSH must be explicitly allowed (OpenSSH app profile or port 22).
ufw_status=$(ufw status 2>/dev/null)
if ! echo "$ufw_status" | grep -Eiq '(OpenSSH|22(/tcp)?)[[:space:]]+ALLOW'; then
  echo "SSH is not explicitly allowed through the firewall — run: sudo ufw allow OpenSSH"
  exit 1
fi

# --- sshd: keys-only, no root login, valid config ---
# Prefer the daemon's own view of the effective, merged config; fall back to grepping the files.
effective=$(sshd -T 2>/dev/null)
if [ -n "$effective" ]; then
  echo "$effective" | grep -qi '^passwordauthentication no' || {
    echo "sshd still allows password auth — set 'PasswordAuthentication no' (e.g. in /etc/ssh/sshd_config.d/99-hardening.conf)"; exit 1; }
  echo "$effective" | grep -qi '^permitrootlogin no' || {
    echo "sshd still permits root login — set 'PermitRootLogin no'"; exit 1; }
else
  grep -REiq '^[[:space:]]*PasswordAuthentication[[:space:]]+no' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/ 2>/dev/null || {
    echo "PasswordAuthentication no not found in sshd config"; exit 1; }
  grep -REiq '^[[:space:]]*PermitRootLogin[[:space:]]+no' /etc/ssh/sshd_config /etc/ssh/sshd_config.d/ 2>/dev/null || {
    echo "PermitRootLogin no not found in sshd config"; exit 1; }
fi

# The config must actually parse — the check you run before every reload.
if ! sshd -t 2>/dev/null; then
  echo "sshd -t failed — the config has a syntax error; fix it before reloading."
  exit 1
fi

echo "Verified: firewall is default-deny inbound with SSH allowed, and sshd is keys-only, no-root, and passes sshd -t. The doors are locked."
exit 0
