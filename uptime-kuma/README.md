# Caddyfile

```
# uptime-kuma basic
uk.{$SITE_HOSTNAME} {
        reverse_proxy uptime-kuma:3001
}
```

```
# uptime-kuma via local_net
uk.{$SITE_HOSTNAME} {
	import local_net
		handle @local_subnet {	        
			route {
				reverse_proxy uptime-kuma:3001
			}
	}
	handle {
		respond "Access Denied. Your IP address is: {http.request.remote.host}" 403
	}
}
```