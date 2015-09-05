#!/bin/bash

if [ ! -d "/data/e2guardian/" ]; then
	mkdir -p /data/e2guardian
	cp -r /usr/local/etc/e2guardian.org/* /data/e2guardian
	
	chown -R nobody:users /data/e2guardian
	chmod -R 777 /data/e2guardian
fi

if [ ! -d "/logs/home_proxy/" ]; then
	mkdir /logs/home_proxy/
	chown -R nobody:users /logs/home_proxy/
	chmod -R 777 /logs/home_proxy/
fi
