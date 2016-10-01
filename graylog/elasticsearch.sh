#!/bin/bash
umask 000

if [ ! -d "/data/elasticsearch/" ]; then
	mkdir -p /data/elasticsearch/data
	mkdir -p /data/elasticsearch/plugins
	cp -r /opt/elasticsearch/config/ /data/elasticsearch/
	
	chown -R nobody:users /data/elasticsearch/
	chmod -R 777 /data/elasticsearch/
fi

if [ ! -d "/logs/graylog/" ]; then
	mkdir -p /logs/graylog
	
	chown -R nobody:users /logs/graylog
	chmod -R 777 /logs/graylog
fi

exec /sbin/setuser nobody /opt/elasticsearch/bin/elasticsearch --path.data /data/elasticsearch/data --path.conf /data/elasticsearch --path.logs /logs/graylog --path.plugins /data/elasticsearch/plugins
