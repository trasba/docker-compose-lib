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
jp.{$SITE_HOSTNAME} {
	import local_net
		handle @local_subnet {	        
			route {
				reverse_proxy jupyter:8888
			}
	}
	handle {
		respond "Access Denied" 403
	}
}
```

# Build docker image

It is assumed that you build the image with the Dockerfile provided.  
You can e.g. build it with portainer using this url: `https://raw.githubusercontent.com/trasba/docker-compose-lib/refs/heads/main/jupyter/Dockerfile`  
Make sure the tag `trasba/scipy-notebook:latest` is correct