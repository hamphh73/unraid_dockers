#!/bin/bash

if [ ! -f "/data/mosquitto.conf" ]; then
	cp /usr/local/etc/mosquitto/mosquitto.conf /data/
fi