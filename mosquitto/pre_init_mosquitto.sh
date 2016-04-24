#!/bin/bash

# customize mosquitto.conf
cd /usr/local/etc/mosquitto/
sed -i.bak "s:#pid_file:pid_file /var/run/mosquitto.pid:" mosquitto.conf
sed -i.bak "s:#log_dest stderr:log_dest file /logs/mosquitto.log:" mosquitto.conf
sed -i.bak "s:#user mosquitto:user nobody:" mosquitto.conf
rm mosquitto.conf.bak
