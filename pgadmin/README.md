# pgAdmin 4 with Caddy Proxy

A containerized deployment of pgAdmin 4 using Docker Compose, optimized for flexibility with environment variables and persistent storage.

## Prerequisites

### External Network

This configuration uses an **external** network named `caddy`. Before starting the stack, ensure this network exists:
```bash
docker network create caddy
```

### Environment Configuration

You must create a `.env` file to store your credentials. Use the provided `.env.example` as a template:
```bash
cp .env.example .env
```

#### Mandatory Variables

The following variables in your `.env` file must be defined for the container to initialize properly:

- **PGADMIN_EMAIL**: The login email address for the pgAdmin web interface
- **PGADMIN_PW**: A strong password for the pgAdmin account

#### Optional Variables

If these are not set in your `.env`, the system will automatically use these fallback values:

- **USER**: Defaults to `trasba` (used for the volume path: `/home/trasba/.trasba/...`)
- **TZ**: Defaults to `Europe/Berlin`
- **CADDY_NETWORK**: Defaults to `caddy`

## Deployment

Start the service in detached mode:
```bash
docker compose up -d
```

## Caddyfile Configuration

Add the following block to your Caddyfile to expose the interface:
```
pga.{$SITE_HOSTNAME} {
    reverse_proxy pgadmin:80
}
```

## Data Persistence

To ensure your server definitions and settings are saved, the container maps a local volume on your host machine:
```
/home/${USER:-trasba}/.trasba/docker/pgadmin/data
```

> **Note**: If you change the `USER` variable in your `.env`, ensure the host path exists or that Docker has the necessary permissions to create the directory structure.