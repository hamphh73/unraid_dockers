#!/bin/bash
umask 000

if [ ! -f "/data/logstash.conf" ]; then
	cp /opt/logstash/logstash.conf /data/logstash.conf
	chown nobody:users /data/logstash.conf
	chmod 777 /data/logstash.conf
fi

if [ ! -d "/logs/graylog/" ]; then
  mkdir /logs/graylog
  chown nobody:users /logs/graylog
  chmod 777 /logs/graylog
fi

# Start Logstash directly (doesn't work with runit)
/opt/logstash/bin/logstash agent –f /data/logstash.conf -l /logs/graylog/logstash.log --auto-reload
