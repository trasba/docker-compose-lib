# Caddyfile

```
# Define a matcher for allowed IP ranges (LAN and Tailscale)
(local_net) {
    @local_subnet {
#          remote_ip ::/0 # make public
          remote_ip 2a02::1/64
          remote_ip 192.168.0.0/24
          remote_ip 100.64.0.0/10  # Tailscale IP range
	  remote_ip 2a03::1 # additional servers
    }
}

# code-server
hp.{$SITE_HOSTNAME} {
	import local_net
		handle @local_subnet {	        
			route {
				reverse_proxy homepage:3000
			}
	}
	handle {
		respond "Access Denied" 403
	}
}
```

# config

## config/docker.yaml

```
---
# For configuration options and examples, please see:
# https://gethomepage.dev/configs/docker/

my-docker:
  host: dockerproxy
  port: 2375
```

## config/docker.yaml

```
---
# For configuration options and examples, please see:
# https://gethomepage.dev/configs/services/

- host:
    - Public Services :
        - jellyfin:
            icon: https://cdn.jsdelivr.net/gh/selfhst/icons/svg/jellyfin.svg
            href: https://jf.kapi6.t00s.de/
            server: my-docker
            container: jellyfin
		- ...
```