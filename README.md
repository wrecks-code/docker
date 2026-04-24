# docker

Personal Docker setup running on a Lenovo ThinkCentre M720Q.

## Structure

```
stacks/    # Docker Compose stacks, one folder per service
scripts/   # Automation and maintenance scripts
```

## Stacks

| Stack | Description |
|---|---|
| adguardhome | DNS filtering and ad blocking |
| arcane | Game library manager |
| bentopdf | PDF tools |
| beszel | System monitoring |
| castsponsorskip | SponsorBlock for cast devices |
| cloudflared-tunnel | Cloudflare Tunnel for external access |
| comics | Comics server and metadata management (Komga) |
| configarr | Config management for arr apps |
| cronmaster | Cron job scheduler UI |
| dawarich | Location history and travel journal |
| deezerdownloader | Music downloader |
| dockge | Docker stack management UI |
| dockhand | Docker container management |
| dockpeek | Docker container monitoring |
| dozzle | Real-time Docker log viewer |
| drop | Game collection tracker |
| filebrowser | Web-based file manager |
| flatnotes | Flat-file notes app |
| ghost | Blog and CMS |
| homeassistant | Home automation |
| homepage | Dashboard |
| immich | Photo and video backup |
| joplin | Note-taking with server sync |
| karakeep | Bookmark and read-later manager |
| localai | Local LLMs via Ollama and Open WebUI |
| memos | Quick notes and micro-blogging |
| n8n | Workflow automation |
| ntfy | Push notifications |
| paperless-ngx | Document management |
| pihole | DNS-level ad blocking |
| qdirstat | Disk usage analyzer |
| searxng | Self-hosted meta search engine |
| servarr | Arr stack (Sonarr, Radarr, SABnzbd, etc.) |
| speedtest-tracker | Internet speed monitoring |
| tailscale | VPN mesh network |
| traefik | Reverse proxy with TLS |
| twingate | Zero-trust remote access |
| uptime-kuma | Service uptime monitoring |
| vaultwarden | Password manager (Bitwarden-compatible) |
| watchtower | Automatic Docker image updates |
| zerobyte | File sharing |

## Scripts

| Script | Description |
|---|---|
| `backup-stacks-github.sh` | Sync stacks and scripts to this repo |
| `backup-docker-appdata.sh` | Stop containers, backup appdata to USB, upload to MEGA |
| `mirror-stacks-folder-to-mega.sh` | Mirror stacks folder to MEGA |
| `system-update.sh` | Unattended system update and reboot if required |
