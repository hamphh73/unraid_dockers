#!/bin/bash
umask 000
rm -f /var/run/mosquitto.pid
exec /usr/local/sbin/mosquitto -c /data/mosquitto.conf