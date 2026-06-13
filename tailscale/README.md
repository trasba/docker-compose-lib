# test 02

# Tailscale / Headscale Subnet Router & Exit Node

A unified, declarative Docker Compose template designed for deploying highly available Tailscale subnet routers and global exit nodes via automated GitOps pipelines (e.g., Portainer Stacks).

By leveraging native kernel-level `nftables` processing, explicit dual-stack (`IPv6`) packet bridging, and transparent port reverse-proxying, this template ensures seamless network forwarding behind restrictive environments like Carrier-Grade NAT (CGNAT) or mobile cellular gateways.

## 🛠️ 1. Host System Prerequisites

Before starting the container, the host OS must be verified for dual-stack packet forwarding capability and Docker Engine network pooling.

Execute the remote diagnostic utility directly from this repository to check your system's compliance:

Bash

```
curl -sSL https://raw.githubusercontent.com/trasba/docker-compose-lib/main/tailscale/verify-host.sh | bash
```

> 💡 **Note:** If the diagnostic utility reports an incomplete state, apply the custom terminal actions it provides to establish structural forwarding rules before proceeding.

## 🎛️ 2. Environment Variables Matrix (`.env`)

Configure your localized deployment by populating an `.env` file or defining advanced environment variables within your container management interface.

### Reference Specification

|                          |                           |                                                                          |
| ------------------------ | ------------------------- | ------------------------------------------------------------------------ |
| **Variable**             | **Default Value**         | **Description**                                                          |
| `TS_CONTAINER_NAME`      | `tailscale-subnet-router` | Explicit resource identity tag for the container.                        |
| `TS_HOSTNAME`            | _Required_                | Unique registration identity label on the coordination panel.            |
| `TS_ROUTES`              | _Optional_                | Comma-separated target networks to advertise (e.g., `192.168.1.0/24`).   |
| `TS_ACCEPT_ROUTES`       | `false`                   | Set to `false` on infrastructure links to protect against routing loops. |
| `TS_ACCEPT_DNS`          | `false`                   | Overrides native fallback DNS maps inside the network namespace.         |
| `TS_USERSPACE`           | `false`                   | Bypasses userspace tun wrappers to utilize high-speed kernel processing. |
| `TS_DEBUG_FIREWALL_MODE` | `nftables`                | Bypasses obsolete `iptables-legacy` layers during initialization.        |
| `TS_LOGIN_SERVER`        | _Required_                | Explicit coordination URL of your control plane server.                  |
| `TS_EXTRA_ARGS`          | _Optional_                | Appends core startup parameters (e.g., `--advertise-exit-node`).         |
| `TS_DEST_IP`             | _Optional_                | Targets an absolute host-level IP for transparent port mappings.         |
| `TZ`                     | `Europe/Berlin`           | System-wide runtime timezone injection.                                  |
| `TS_DATA_DIR`            | `./tailscale`             | Persistent volume target where structural state keys are archived.       |

## 🚀 3. Deployment & Authentication Sequence

### Step 1: Initialize the Stack

Spin up the stack using Docker Compose:

Bash

```
docker compose up -d
```

### Step 2: Register on the Control Plane

After first initialization, the node must perform cryptographic authentication against your coordination server (Tailscale or Headscale).

1.  Inspect the live container output strings:Bash

    ```
    docker logs tailscale-subnet-router
    ```

2.  Extract the printed unique authentication string and navigate to your control server:

    ```
    https://<your-control-server>/register/node:<auth-string>
    ```

3.  Authorize the registration command on your dashboard to securely join the node to the tailnet interface.

### Step 3: Authorize Routing Resources

If you configured `TS_ROUTES` or appended exit node capability flags inside your variables file, the target boundaries remain locked until explicitly allowed by an administrator:

- **Tailscale Admin Console:** Open your network dashboard, find the newly authenticated machine, click **Edit Route Settings**, and toggle the checkboxes for the advertised paths or exit node services.
- **Headscale CLI:** Execute the authorization string on your deployment console machine:Bash
  ```
  headscale routes enable -i <node-id> -r "your.target.subnet.range/mask"
  ```
