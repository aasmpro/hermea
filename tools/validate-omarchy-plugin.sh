#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
plugin_dir="$root_dir/plugins/omarchy/hermea"

jq empty "$plugin_dir/manifest.json"
bash -n "$plugin_dir/open-dashboard.sh"
omarchy plugin validate "$plugin_dir"
python3 -B -m unittest discover -s "$plugin_dir/tests" -v

if command -v qmllint >/dev/null 2>&1; then
  qmllint -I "${OMARCHY_PATH:?OMARCHY_PATH is required for qmllint}/shell" \
    "$plugin_dir/BarWidget.qml" "$plugin_dir/Panel.qml"
else
  echo "qmllint is unavailable; skipped QML lint." >&2
fi
