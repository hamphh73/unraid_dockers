#!/bin/bash
umask 000

if [ ! -d "/data/graylog-collector-sidecar/" ]; then
	mkdir -p /data/graylog-collector-sidecar/generated
	cp /home/collector_sidecar.yml /data/graylog-collector-sidecar/collector_sidecar.yml
	chown -R nobody:users /data/graylog-collector-sidecar/
	chmod -R 777 /data/graylog-collector-sidecar/
fi

if [ ! -d "/logs/graylog/" ]; then
  mkdir -p /logs/graylog
  chown nobody:users /logs/graylog
  chmod 777 /logs/graylog
fi

sleep 10
exec /usr/bin/graylog-collector-sidecar -c /data/graylog-collector-sidecar/collector_sidecar.yml
