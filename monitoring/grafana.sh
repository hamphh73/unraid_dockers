#!/bin/bash
umask 000

if [ ! -d "/data/grafana/data/" ]; then
	mkdir -p /data/grafana/data
	
	chown -R nobody:users /data/grafana/data/
	chmod -R 777 /data/grafana/data/
fi

if [ ! -d "/data/grafana/plugins/" ]; then
	mkdir -p /data/grafana/plugins
	
	chown -R nobody:users /data/grafana/plugins/
	chmod -R 777 /data/grafana/plugins/
fi

if [ ! -d "/data/grafana/config/" ]; then
	mkdir -p /data/grafana/config
	cp /opt/grafana/conf/sample.ini /data/grafana/config/grafana.ini
	
	chown -R nobody:users /data/grafana/config/
	chmod -R 777 /data/grafana/config/
fi
cp -f /opt/grafana/conf/sample.ini /data/grafana/config/

if [ ! -d "/logs/monitoring/grafana/" ]; then
	mkdir -p /logs/monitoring/grafana
	
	chown -R nobody:users /logs/monitoring/grafana
	chmod -R 777 /logs/monitoring/grafana
fi


exec /sbin/setuser nobody /opt/grafana/bin/grafana-server -config /data/grafana/config/grafana.ini -homepath /opt/grafana web
