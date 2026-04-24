#!/bin/bash
set -Eeuo pipefail

STACKS_ROOT="/opt/docker/stacks"
APPDATA_ROOT="/opt/docker/appdata"
BACKUP_DEST="/mnt/usb-hdd/docker/backup/appdata"

EXCLUDES=(--exclude="logs/" --exclude="log/" --exclude="cache/" --exclude="tmp/")

if [[ "$BACKUP_DEST" == /mnt/* ]]; then
    echo "[CLEAN] Wipe $BACKUP_DEST..."
    rm -rf "${BACKUP_DEST:?}"/*
else
    echo "[ERR] Pfad unsicher!" && exit 1
fi

find "$STACKS_ROOT" -maxdepth 2 -type f \( -name "compose.yaml" -o -name "docker-compose.yml" \) | while read -r compose_file; do

    stack_name=$(basename "$(dirname "$compose_file")")

    if docker compose -f "$compose_file" config --format json 2>/dev/null | grep -q '"container_name": *"cronmaster"'; then
        echo "[SKIP] $stack_name: cronmaster-Stack."
        continue
    fi

    if [ -z "$(docker compose -f "$compose_file" ps --services --status running)" ]; then
        continue
    fi

    TARGET_FOLDERS=()
    USE_STACK_FOLDER=false

    if [ -d "$APPDATA_ROOT/$stack_name" ]; then
        USE_STACK_FOLDER=true
        TARGET_FOLDERS+=("$stack_name")
    else
        container_names=$(docker compose -f "$compose_file" config --format json | grep -oP '"container_name":\s*"\K[^"]+')
        for c_name in $container_names; do
            if [ -d "$APPDATA_ROOT/$c_name" ]; then
                TARGET_FOLDERS+=("$c_name")
            fi
        done
    fi

    if [ ${#TARGET_FOLDERS[@]} -eq 0 ]; then
        echo "[SKIP] $stack_name: keine passenden appdata-Ordner gefunden."
        continue
    fi

    echo "[START] $stack_name..."
    docker compose -f "$compose_file" stop

    for folder in "${TARGET_FOLDERS[@]}"; do
        echo "  -> Rsync: $folder"
        mkdir -p "$BACKUP_DEST/$folder"
        rsync -a --delete "${EXCLUDES[@]}" "$APPDATA_ROOT/$folder/" "$BACKUP_DEST/$folder/"
    done

    docker compose -f "$compose_file" start
    echo "[DONE] $stack_name wieder online."
done

echo "Lokales Backup abgeschlossen."

rclone --config /home/wreck/.config/rclone/rclone.conf sync /mnt/usb-hdd/docker/backup/appdata mega:Docker_Backup/appdata --progress
