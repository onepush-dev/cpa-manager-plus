#!/bin/bash
# Railway start wrapper for CLIProxyAPI.
# - first boot: writes /app/data/config.yaml (remote management on, client API key from CPA_API_KEY,
#   OAuth credentials in /app/data/auths, usage statistics on for CPA Manager Plus)
# - every boot: keeps server.port in sync with Railway's PORT
# The management key comes from MANAGEMENT_PASSWORD (env always wins over config.yaml).
set -euo pipefail
DATA="${CPA_DATA_DIR:-/app/data}"
LISTEN_PORT="${PORT:-8317}"
CFG="$DATA/config.yaml"
mkdir -p "$DATA/auths" "$DATA/logs" "$DATA/plugins"
if [ ! -s "$CFG" ]; then
  echo "[railway] first boot: writing $CFG"
  {
    echo 'config-version: 8'
    echo 'server:'
    echo '  host: ""'
    echo "  port: $LISTEN_PORT"
    echo 'management:'
    echo '  allow-remote: true'
    echo '  secret-key: ""'
    echo '  disable-control-panel: false'
    echo 'access:'
    if [ -n "${CPA_API_KEY:-}" ]; then echo '  api-keys:'; echo "    - \"$CPA_API_KEY\""; else echo '  api-keys: []'; fi
    echo 'oauth:'
    echo "  auth-dir: \"$DATA/auths\""
    echo 'observability:'
    echo '  logs:'
    echo '    debug: false'
    echo '    logging-to-file: false'
    echo '    request-log: false'
    echo '  usage:'
    echo '    usage-statistics-enabled: true'
    echo '    redis-usage-queue-retention-seconds: 600'
    echo 'plugins:'
    echo '  enabled: false'
    echo "  dir: \"$DATA/plugins\""
  } > "$CFG"
else
  # keep the listener on Railway's PORT (first "  port:" line is server.port)
  sed -i -E "0,/^  port: [0-9]+/s//  port: $LISTEN_PORT/" "$CFG"
fi
if [ -z "${MANAGEMENT_PASSWORD:-}" ]; then
  echo "[railway] WARNING: MANAGEMENT_PASSWORD is empty; the management API (and CPA Manager Plus) will be disabled" >&2
fi
cd /CLIProxyAPI
exec ./CLIProxyAPI -config "$CFG"
