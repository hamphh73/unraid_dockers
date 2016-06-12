#!/bin/bash
umask 000

if [ ! -d "/data/logstash/" ]; then
	mkdir -p /data/logstash/data
	cp /opt/logstash/logstash.conf /data/logstash/logstash.conf
	chown -R nobody:users /data/logstash/
	chmod -R 777 /data/logstash/
fi

if [ ! -d "/logs/graylog/" ]; then
  mkdir /logs/graylog
  chown nobody:users /logs/graylog
  chmod 777 /logs/graylog
fi

export HOME=/data/logstash/data/
TRACE_OPTS=

if [ -n "$LOGSTASH_TRACE" ]; then
	TRACE_OPTS=--debug
fi

exec /opt/logstash/bin/logstash agent $TRACE_OPTS --config /data/logstash/logstash.conf --auto-reload
