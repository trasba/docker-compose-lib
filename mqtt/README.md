# config/mosquitto.conf
```
listener 1883
allow_anonymous true

connection <host>-bridge
address <example.com>:<1883>
remote_username <username>
remote_password <password>
remote_clientid <remote_client_id>
notifications true

#bridge topics
topic $SYS/broker/uptime out 0 "" <host>/

persistence true
persistence_location /mosquitto/data/

# --- Logging Settings ---
# Direct log output to a file.
log_dest file /mosquitto/log/mosquitto.log

# You can also add more log levels if needed for debugging:
# log_type debug
# log_type error
# log_type warning
# log_type notice
# log_type information
# log_type subscribe
# log_type unsubscribe
# log_type websockets
# log_type all
```