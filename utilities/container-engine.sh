#!/usr/bin/env bash
# Resolve container engine: CONTAINER_ENGINE env, then podman, then docker.

container_engine() {
  if [[ -n "${CONTAINER_ENGINE:-}" ]]; then
    if command -v "$CONTAINER_ENGINE" &>/dev/null; then
      echo "$CONTAINER_ENGINE"
      return 0
    fi
    echo "Error: CONTAINER_ENGINE='$CONTAINER_ENGINE' is not available in PATH." >&2
    return 1
  fi
  if command -v podman &>/dev/null; then
    echo podman
    return 0
  fi
  if command -v docker &>/dev/null; then
    echo docker
    return 0
  fi
  echo "Error: neither podman nor docker found in PATH. Install one or set CONTAINER_ENGINE." >&2
  return 1
}
