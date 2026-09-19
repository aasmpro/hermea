#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
plugin_dir="$root_dir/plugins/omarchy/hermea"
output_dir="$root_dir/.dist/omarchy/hermea"

rm -rf "$output_dir"
mkdir -p "$output_dir"
tar --exclude='__pycache__' --exclude='*.pyc' --exclude='.git' \
  -cf - -C "$plugin_dir" . | tar -xf - -C "$output_dir"

omarchy plugin validate "$output_dir"
echo "Packaged standalone plugin: $output_dir"
