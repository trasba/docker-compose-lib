# Jellyfin Media Server

A unified, declarative Docker Compose template designed for deploying a highly-performant Jellyfin media server via automated GitOps pipelines (e.g., Portainer Stacks) or direct local compose orchestration.

By leveraging robust user namespace mapping (`PUID`/`PGID`), localized timezone alignment, and modular volume mappings, this configuration delivers a seamless, self-hosted media streaming experience. It supports optional network-level discovery ports (DLNA/UDP) and hardware-accelerated transcoding wrappers (Intel QuickSync/VAAPI) to ensure low-overhead, high-fidelity playback.

## 🛠️ 1. Host System Prerequisites

Before launching the container, ensure the following conditions are met on your host machine:

1. **Volume Path Permission Alignment:**
   Ensure the host directories mapped to `JELLYFIN_CONFIG_DIR` and `JELLYFIN_MEDIA_DIR` are readable and writeable by the user defined in your `PUID` and `PGID` parameters (typically `1000:1000`).
   ```bash
   # Example: Adjust permissions for configuration directory
   mkdir -p /home/trasba/.trasba/docker/jellyfin/config
   chown -R 1000:1000 /home/trasba/.trasba/docker/jellyfin/config
   ```


## 🎛️ 2. Environment Variables Matrix (`.env`)

Configure your localized deployment by populating an `.env` file or defining environment variables within your container management interface (such as Portainer).

### Reference Specification

|                          |                           |                                                                          |
| ------------------------ | ------------------------- | ------------------------------------------------------------------------ |
| **Variable**             | **Default Value**         | **Description**                                                          |
| `JELLYFIN_CONTAINER_NAME`| `jellyfin`                | Explicit resource identity tag for the container.                        |
| `PUID`                   | `1000`                    | User ID mapping to control host-level file access permissions.           |
| `PGID`                   | `1000`                    | Group ID mapping to control host-level file access permissions.          |
| `TZ`                     | `Europe/Berlin`           | System-wide runtime timezone injection.                                  |
| `JELLYFIN_PUBLISHED_SERVER_URL` | _Optional_         | Optional published server URL for autodiscovery by external clients.    |
| `JELLYFIN_CONFIG_DIR`    | `/home/${USER:-trasba}/.trasba/docker/jellyfin/config` | Host path mapping for persistent configuration data. |
| `JELLYFIN_MEDIA_DIR`     | `/home/${USER:-trasba}/.trasba/docker/jellyfin/media`  | Host path mapping for primary media files.           |
| `CADDY_NETWORK`          | `caddy`                   | Name of the external Docker network shared with your reverse proxy.      |

## 🚀 3. Deployment Sequence

### Step 1: Initialize the Stack

Spin up the stack using Docker Compose:

```bash
docker compose up -d
```

### Step 2: Complete Setup Wizard

Once the container is healthy, navigate to the web interface using your browser:

```
http://<your-host-ip>:8096
```

Follow the configuration prompt to set up your administrator account and specify library paths mapped under the internal `/data` path.

### Step 3: Hardware Acceleration Configuration (Optional)

To enable GPU-based hardware-accelerated transcoding (Intel QuickSync/VAAPI), launch the stack using the GPU-specific template instead of the base configuration:

* **Using CLI:**
  ```bash
  docker compose -f docker-compose-gpu.yml up -d
  ```

* **Using Portainer (Git Stack):**
  Change the **Compose path** configuration in your Portainer stack settings from `jellyfin/docker-compose.yml` to `jellyfin/docker-compose-gpu.yml`.

Once deployed, access the Jellyfin dashboard as an administrator, navigate to **Dashboard > Playback > Transcoding**, select your hardware acceleration method (e.g., Intel QuickSync or VAAPI), and save your changes.

## 🌐 4. Reverse Proxy Integration (Caddy)

Since the container's ports are commented out by default to keep the service private, you should route web traffic using Caddy. 

Add the following reverse proxy block to your host's `Caddyfile`:

```caddy
jellyfin.yourdomain.com {
    reverse_proxy jellyfin:8096
}
```

Ensure both your Caddy container and Jellyfin container are attached to the same Docker network (which defaults to `caddy`).
