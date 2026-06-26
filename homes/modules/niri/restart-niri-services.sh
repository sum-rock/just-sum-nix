#!/usr/bin/env bash
set -euo pipefail

echo "Reloading niri config..."
niri msg action load-config-file

echo "Restarting waybar..."
pkill waybar 2>/dev/null || true
sleep 0.5
waybar &
disown

echo "Restarting walker..."
systemctl --user restart walker

echo "Done."
