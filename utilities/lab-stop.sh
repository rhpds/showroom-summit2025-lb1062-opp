#!/usr/bin/env bash
#

UTILITIES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=container-engine.sh
source "$UTILITIES_DIR/container-engine.sh"
ENGINE="$(container_engine)" || exit 1

echo "Stopping serve process (using $ENGINE)..."
"$ENGINE" kill showroom-httpd 2>/dev/null || true
echo "Stopped serve process."
