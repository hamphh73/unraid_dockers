#!/bin/bash
umask 000

if [ ! -d "/data/mongodb/" ]; then
	mkdir -p /data/mongodb/
	chown -R nobody:users /data/mongodb/
	chmod -R 777 /data/mongodb/
fi

if [ ! -d "/logs/graylog/" ]; then
	mkdir -p /logs/graylog
	
	chown -R nobody:users /logs/graylog
	chmod -R 777 /logs/graylog
fi

exec /sbin/setuser nobody /opt/mongodb/bin/mongod --dbpath /data/mongodb --logpath /logs/graylog/mongodb.log
