# Docker Compose Media Server

A complete media server setup with Traefik reverse proxy, including Jellyfin, Sonarr, Radarr, Bazarr, Lidarr, Prowlarr, Jellyseer, Homarr, and qBittorrent with VPN support.

## Quick Setup

### 1. Run the Setup Script

```bash
./setup.sh
```

This interactive script will:
- Configure your timezone and hostname
- Set up directory paths for media and configs
- Configure VPN settings for qBittorrent
- Create necessary directories
- Generate the `.env` file

### 2. Start the Services

```bash
docker-compose up -d
```

### 3. Configure Local DNS

Add your hostname to your local DNS or hosts file:

**Linux/macOS:**
```bash
echo "192.168.1.100 your-hostname.local" | sudo tee -a /etc/hosts
```

**Windows:**
Add to `C:\Windows\System32\drivers\etc\hosts`:
```
192.168.1.100 your-hostname.local
```

## Service Access

Once configured, access your services at:

- **Traefik Dashboard**: `http://localhost:8081`
- **Jellyfin**: `http://your-hostname.local/jellyfin`
- **Radarr**: `http://your-hostname.local/radarr`
- **Sonarr**: `http://your-hostname.local/sonarr`
- **Bazarr**: `http://your-hostname.local/bazarr`
- **Lidarr**: `http://your-hostname.local/lidarr`
- **Prowlarr**: `http://your-hostname.local/prowlarr`
- **Jellyseer**: `http://your-hostname.local/jellyseer`
- **Homarr**: `http://your-hostname.local/homarr`
- **qBittorrent**: `http://your-hostname.local/qbittorrent`

## Manual Configuration

If you prefer manual setup:

1. Copy `.env.sample` to `.env`
2. Edit `.env` with your settings
3. Run `./create-volumes.sh` to create directories
4. Run `docker-compose up -d`

## Directory Structure

The setup creates the following structure:

```
/your-config-dir/
├── prowlarr/
├── radarr/
├── sonarr/
├── bazarr/
├── lidarr/
├── jellyfin/
├── jellyseer/
├── homarr/
├── gluetun/
└── qbittorent/

/your-media-dir/
├── movies/
├── tv/
├── music/
└── downloads/
```


## Troubleshooting

### Docker Version Issues

Found that docker version >= 28.0.0 makes containers using gluetun lose connection in Raspbian

To check you current version run
apt list --installed docker-ce

 To downgrade your docker to 27.5.1, run:

sudo apt install docker-compose-plugin=2.32.4-1~debian.12~bookworm docker-ce-cli=5:27.5.1-1~debian.12~bookworm docker-buildx-plugin=0.20.0-1~debian.12~bookworm docker-ce=5:27.5.1-1~debian.12~bookworm docker-ce-rootless-extras=5:27.5.1-1~debian.12~bookworm

Run sudo systemctl restart docker and check if this fixed your problem.

To make sure these packages don't upgrade, run:

sudo apt-mark hold docker-compose-plugin=2.32.4-1~debian.12~bookworm docker-ce-cli=5:27.5.1-1~debian.12~bookworm docker-buildx-plugin=0.20.0-1~debian.12~bookworm docker-ce=5:27.5.1-1~debian.12~bookworm docker-ce-rootless-extras=5:27.5.1-1~debian.12~bookworm

If you ever want them to start upgrading again, run the same command with unhold instead of hold 