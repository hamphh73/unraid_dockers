#!/bin/bash
umask 000

if [ ! -d "/data/graylog/" ]; then
	mkdir -p /data/graylog
	cp /opt/graylog/graylog.conf.example /data/graylog/graylog.conf
	sed -i "s+#rest_transport_uri = http://192.168.1.1:12900/+rest_transport_uri = $REST_TRANSPORT_URI+" /data/graylog/graylog.conf
	
	chown -R nobody:users /data/graylog/
	chmod -R 777 /data/graylog/
fi

if [ ! -d "/logs/graylog/" ]; then
	mkdir -p /logs/graylog
	
	chown -R nobody:users /logs/graylog
	chmod -R 777 /logs/graylog
fi

sv start mongodb || exit 1
sv start elasticsearch || exit 1

export GRAYLOG_CONF=/data/graylog/graylog.conf
export LOG_FILE=/logs/graylog/graylog-server.log

rm -f /tmp/graylog.pid

exec /sbin/setuser nobody /opt/graylog/bin/graylogctl run
