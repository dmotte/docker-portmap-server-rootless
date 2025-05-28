#!/bin/sh

set -ex

keepalive_interval=${KEEPALIVE_INTERVAL:-30}
permit_listen=${PERMIT_LISTEN:?}

################################################################################

# Create the temporary directory for host keys generation
mkdir -p ~/sshd/etc/ssh

# Get host keys from the volume
install -m600 -t ~/sshd/etc/ssh /ssh-host-keys/ssh_host_*_key 2>/dev/null || :
install -m644 -t ~/sshd/etc/ssh /ssh-host-keys/ssh_host_*_key.pub 2>/dev/null || :

# Generate the missing host keys
ssh-keygen -Af ~/sshd

# Move the host keys out of the temporary directory
mv -t ~/sshd ~/sshd/etc/ssh/*
rm -r ~/sshd/etc

# Copy the (previously missing) generated host keys to the volume
cp -nt/ssh-host-keys ~/sshd/ssh_host_*_key 2>/dev/null || :
cp -nt/ssh-host-keys ~/sshd/ssh_host_*_key.pub 2>/dev/null || :

################################################################################

if [ -z "$(find /ssh-client-keys -mindepth 1 -maxdepth 1 -type f -name \*.pub)" ]; then
    # If ssh-keygen fails, the /ssh-client-keys directory is probably mounted
    # in read-only mode
    ssh-keygen -t ed25519 -C portmap -N '' \
        -f /ssh-client-keys/ssh_client_key || :
fi

# shellcheck disable=SC3001
install -Tm600 <(cat /ssh-client-keys/*.pub 2>/dev/null || :) \
    ~/.ssh/authorized_keys

################################################################################

# Start the OpenSSH Server with "exec" to ensure it receives all the stop
# signals correctly
exec /usr/sbin/sshd -Def ~/sshd/sshd_config \
    -oClientAliveInterval="$keepalive_interval" \
    -oPermitListen="$permit_listen" \
    "$@"
