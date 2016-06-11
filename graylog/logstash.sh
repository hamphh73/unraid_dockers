#!/bin/bash
umask 000

if [ ! -f "/data/logstash.conf/" ]; then
	cp /opt/logstash/logstash.conf /data/logstash.conf
	chown nobody:users /data/logstash.conf
	chmod 777 /data/logstash.conf
fi

sv start graylog || exit 1

exec /sbin/setuser nobody /opt/logstash/bin/logstash –f /data/logstash.conf --auto-reload
