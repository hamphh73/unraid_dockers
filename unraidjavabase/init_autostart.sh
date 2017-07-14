#!/bin/bash

if [ ! -f "/data/start.sh" ] && [ -d "/etc/service/autostart" ]; then
	rm -r /etc/service/autostart
fi

if [ -f "/data/start.sh" ] && [ ! -d "/etc/service/autostart" ]; then
	mkdir -p /etc/service/autostart
	cp /home/autostart.sh etc/service/autostart/run
	chmod +x /etc/service/autostart/run
fi

