#!/bin/bash

if [ ! -d "/data/dansguardian/" ]; then
	mkdir -p /data/dansguardian
	cp -r /usr/local/etc/dansguardian.org/* /data/dansguardian
	
	chown -R nobody:users /data/dansguardian
	chmod -R 777 /data/dansguardian
fi

if [ ! -d "/logs/home_proxy/" ]; then
	mkdir /logs/home_proxy/
	chown -R nobody:users /logs/home_proxy/
	chmod -R 777 /logs/home_proxy/
fi
