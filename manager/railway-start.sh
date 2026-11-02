#!/bin/sh
# Railway start wrapper for CPA Manager Plus: bind Railway's PORT unless HTTP_ADDR is set.
set -e
if [ -z "${HTTP_ADDR:-}" ]; then
  export HTTP_ADDR="0.0.0.0:${PORT:-18317}"
fi
mkdir -p /data
exec cpa-manager-plus "$@"
