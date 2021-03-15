#!/usr/bin/env python3
'''
init mosquitto.conf, creates bridge to central mqtt server,
can be used e.g. as heartbeat monitor
'''

import os
from pathlib import Path
import click
from dotenv import load_dotenv


@click.command()
@click.option("--silent/--no-silent", "-s/", default=False, help="Use .env file and run silently.")
def main(silent):
    ''' init mosquitto.conf, creates bridge to central mqtt server '''
    # set destination path = own path + relative path
    dest_dir = os.path.dirname(os.path.realpath(__file__)) + '/config'
    dest_path = (
        os.path.dirname(os.path.realpath(__file__)) +
        '/config/mosquitto.conf')
    # ### load dotenv
    load_dotenv()
    conf = {}
    values = ['connection', 'address', 'username', 'password', 'client_id']
    for value in values:
        conf[value] = str(os.getenv(value) or '')

    if not silent:
        print("Enter mqtt information")
        for key, value in conf.items():
            conf[key] = str(input(key + f': {value}? ') or value)

    mosquitto_conf = (
        '# Plain MQTT protocol\n'
        'listener 1883\n'
        f'connection {conf["connection"]}\n'
        f'address {conf["address"]}\n'
        f'remote_username {conf["client_id"]}\n'
        f'remote_password {conf["password"]}\n'
        f'remote_clientid {conf["client_id"]}\n'
        'notifications true\n'
        '\n'
        '#bridge topics\n'
        f'topic $SYS/broker/uptime out 0 "" {conf["client_id"]}'
    )

    Path(dest_dir).mkdir(parents=True, exist_ok=True)
    data = open(dest_path, "w", newline='\n')
    data.write(mosquitto_conf)
    data.close()
    print(f'mosquitto.conf file created in {dest_path}')


if __name__ == "__main__":
    main() # pylint: disable=no-value-for-parameter
