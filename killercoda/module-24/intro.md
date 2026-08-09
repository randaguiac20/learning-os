# Security — harden a box you own

You have a **throwaway Linux VM** in the terminal on the right, with root available via `sudo`. This is
a machine you own and can afford to lock yourself out of — the only kind of box you practice hardening
on.

In the next few minutes you'll run the **hardening loop**: enumerate the attack surface with
instruments (not memory), add a **least-privilege** user, fix an over-permissioned secret and a
**SUID-root** surprise, stand up a **default-deny** firewall the lockout-safe way, and harden `sshd` —
**verifying every change**, one at a time.

> **The laws of this lab:** one change at a time · re-check after each · allow the door (SSH) **before**
> you close the firewall · `sshd -t` **before** you reload. Test the door before you close it behind you.

Click **START** to begin.
