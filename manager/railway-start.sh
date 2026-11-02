#!/bin/sh
# Railway start wrapper for CPA Manager Plus: always bind Railway's PORT (fallback 18317).
# The upstream image bakes HTTP_ADDR=0.0.0.0:18317, so it is overridden here; set CPAMP_HTTP_ADDR to force another address.
set -e
export HTTP_ADDR="${CPAMP_HTTP_ADDR:-0.0.0.0:${PORT:-18317}}"
mkdir -p /data
exec cpa-manager-plus "$@"
