#!/usr/bin/env bash
set -euo pipefail

echo "Hello from .github/scripts/hello.sh"
echo "pwd=$(pwd)"
echo "date=$(date -Is)"

echo "== env (subset) =="
for k in GITHUB_EVENT_NAME GITHUB_REF GITHUB_SHA GITHUB_ACTOR GITHUB_WORKSPACE; do
  printf "%s=%s\n" "$k" "${!k-}"
done
