# Caddyfile

```
# ddns-updater basic
ddns.{$SITE_HOSTNAME} {
        reverse_proxy ddns-updater:8000
}

# ddns-updater with authorization 
ddns.{$SITE_HOSTNAME} {
        route {
                authorize with admin_policy
                reverse_proxy ddns-updater:8000
        }
}
```

# data/config.json

```
{
    "settings": [
        {
            "provider": "cloudflare",
            "zone_identifier": "<zone_id>",
            "domain": "<example.domain.com>",
            "ttl": 1,
            "token": "<api_token>",
            "ip_version": "ipv6"
        }
    ]
}
```