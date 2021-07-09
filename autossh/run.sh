#!/usr/bin/env bashio
set -e

# https://github.com/hassio-addons/bashio

bashio::log.info "Public key:"

cat /root/.ssh/id_rsa.pub

TUNNEL_HOST=$(bashio::config 'tunnel_host')
TUNNEL_USER=device
TUNNEL_PORT=55001
MONITOR_PORT=0
KEY_PATH=/root/.ssh/id_rsa
TUNNEL_REMOTE_STRING=$(bashio::config 'tunnel_remote_string')


AUTOSSH_ARGS="-M $MONITOR_PORT "
SSH_ARGS="-nNTv -o ServerAliveInterval=60 -o ServerAliveCountMax=3 -o IdentitiesOnly=yes -o StrictHostKeyChecking=no -i $KEY_PATH -R $TUNNEL_REMOTE_STRING $TUNNEL_USER@$TUNNEL_HOST"
DAEMON_ARGS=" $AUTOSSH_ARGS $SSH_ARGS"

echo "#!/usr/bin/env bashio" > go.sh
echo "AUTOSSH_DEBUG=1 autossh" "$DAEMON_ARGS" >> go.sh
cat go.sh
chmod +x ./go.sh

./go.sh