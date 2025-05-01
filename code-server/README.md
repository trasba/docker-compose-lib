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
cs.{$SITE_HOSTNAME} {
	import local_net
		handle @local_subnet {	        
			authenticate with myportal
			route {
				authorize with admin_policy # additional security think e.g. any device from the lan could access otherwise
			        reverse_proxy code-server:8443
			}
	}
	handle {
		respond "Access Denied" 403
	}
}
```