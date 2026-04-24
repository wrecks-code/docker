#!/bin/bash
set -e

TARGET_USER="wreck"
REPO_DIR="/opt/docker/docker-repo"

if [ "$(id -un)" != "$TARGET_USER" ]; then
  exec sudo -u "$TARGET_USER" "$0" "$@"
fi

rsync -a --delete /opt/docker/stacks/ "$REPO_DIR/stacks/"
rsync -a --delete /opt/docker/scripts/ "$REPO_DIR/scripts/"

cd "$REPO_DIR"

git add .

if ! git diff-index --quiet HEAD; then
  git commit -m "Update stacks and scripts: $(date +'%Y-%m-%d %H:%M')"
  git push origin main
fi
