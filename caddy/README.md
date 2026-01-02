# Caddyfile (examples)

## for local testing (no certs will be generated)

```
:80 {
  root * /usr/share/caddy
  file_server
}
```

## reverse proxy

```
# homepage dashboard
hp.{$SITE_HOSTNAME} {
  reverse_proxy homepage:3000
}
```

## reverse proxy with access only from specific ip's

```
# Define a matcher for allowed IP ranges (LAN and Tailscale)
(local_net) {
  @local_subnet {
#    remote_ip ::/0 # make public
#    remote_ip fc00::/7 # all ULA (private ipv6)
  remote_ip 2a02:8075::/59 # e.g. router
  remote_ip 192.168.0.0/24 # ipv4 LAN
  remote_ip 100.64.0.0/10  # Tailscale IP range
  remote_ip 2a03:3333:43:14:42e:e3aa:faa3:128c # e.g. specific host with static ipv6
  remote_ip fd2b:9081:7053::/48 # ipv6 LAN
  }
}

# homepage dashboard
hp.{$SITE_HOSTNAME} {
  import local_net
    handle @local_subnet {
      reverse_proxy homepage:3000
    }
    handle {
      respond "Access Denied. Your IP address is: {http.request.remote.host}" 403
    }
}
```
