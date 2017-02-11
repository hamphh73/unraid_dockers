#!/bin/bash

cp -rf /opt/serviio/library/* /data/

if [ ! -d "/logs/serviio/" ]; then
	mkdir -p /logs/serviio/
	chown -R nobody:users /logs/serviio/
	chmod -R 777 /logs/serviio/
fi
