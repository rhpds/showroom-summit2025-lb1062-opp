#!/usr/bin/env bash
#

UTILITIES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=container-engine.sh
source "$UTILITIES_DIR/container-engine.sh"
ENGINE="$(container_engine)" || exit 1

echo "Killing pod (using $ENGINE)..."

"$ENGINE" kill showroom-httpd 2>/dev/null || true

echo "Removing old site..."
rm -rf ./www/*
echo "Old site removed"

echo "Building new site"
npx antora --fetch default-site.yml

echo "Starting serve process (using $ENGINE)..."

"$ENGINE" run -d --rm --name showroom-httpd -p 8080:8080 \
  -v "./www:/var/www/html/:z" \
  registry.access.redhat.com/ubi9/httpd-24:1-301

echo "Serving lab content on http://localhost:8080/index.html"
