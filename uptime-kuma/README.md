# Caddyfile

```
# uptime-kuma basic
uk.{$SITE_HOSTNAME} {
        reverse_proxy uptime-kuma:3001
}
```