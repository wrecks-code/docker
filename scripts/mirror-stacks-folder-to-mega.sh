#!/bin/bash
set -Eeuo pipefail

STACKS_ROOT="/opt/docker/stacks"
RCLONE_DEST="mega:Docker_Backup/stacks"

EXCLUDES=(
  --exclude=".git/"
  --exclude=".DS_Store"
  --exclude="**/node_modules/"
  --exclude="**/__pycache__/"
)

echo "[START] Upload stacks zu MEGA..."

rclone --config /home/wreck/.config/rclone/rclone.conf sync \
  "$STACKS_ROOT" \
  "$RCLONE_DEST" \
  "${EXCLUDES[@]}" \
  --progress

echo "[DONE]"
