#!/bin/bash

if [ ! -d "/data/privoxy/" ]; then
	mkdir -p /data/privoxy/
	cp -r /usr/local/etc/privoxy.org/* /data/privoxy/
	chown -R nobody:users /data/privoxy
	chmod -R 777 /data/privoxy
fi