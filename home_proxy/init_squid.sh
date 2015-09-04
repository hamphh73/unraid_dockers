#!/bin/bash

if [ ! -d "/data/squid/" ]; then
	mkdir -p /data/squid/config
	cp -r /usr/local/squid/etc.org/* /data/squid/config
	
	mkdir -p /data/squid/data
	
	chown -R nobody:users /data/squid
	chmod -R 777 /data/squid
fi

if [ ! -d "/logs/home_proxy/squid/" ]; then
	mkdir /logs/home_proxy/squid/
	chown -R nobody:users /logs/home_proxy/squid/
	chmod -R 777 /logs/home_proxy/squid
fi
