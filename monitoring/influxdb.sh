#!/bin/bash
umask 000

if [ ! -d "/data/influxdb/data/" ]; then
	mkdir -p /data/influxdb/data/meta
	mkdir -p /data/influxdb/data/db
	mkdir -p /data/influxdb/data/wal
	
	chown -R nobody:users /data/influxdb/data/
	chmod -R 777 /data/influxdb/data/
fi

if [ ! -d "/data/influxdb/config/" ]; then
	mkdir -p /data/influxdb/config
	cp /etc/influxdb/influxdb.conf /data/influxdb/config/
	
	chown -R nobody:users /data/influxdb/config/
	chmod -R 777 /data/influxdb/config/
fi
cp -f /etc/influxdb/influxdb.conf /data/influxdb/config/influxdb.conf.example

if [ ! -d "/logs/monitoring/influxdb/" ]; then
	mkdir -p /logs/monitoring/influxdb
	
	chown -R nobody:users /logs/monitoring/influxdb
	chmod -R 777 /logs/monitoring/influxdb
fi

exec /sbin/setuser nobody /usr/bin/influxd -config /data/influxdb/config/influxdb.conf
