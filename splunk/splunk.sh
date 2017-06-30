#!/bin/bash

for dir in var etc; do
	if [ ! -d "/data/$dir/" ]; then
		mkdir -p /data/$dir/
		chown nobody:users /data/$dir
	fi
done

if ! cmp -s /opt/splunk/etc.org/splunk.version /data/etc/splunk.version; then
	cp -r /opt/splunk/etc.org/* /data/etc/
	chown -R nobody:users /data/etc
fi

if [ ! -f "/data/etc/splunk-launch.conf" ]; then
	cp /home/splunk-launch.conf /data/etc/
	chown nobody:users /data/etc/splunk-launch.conf
fi

umask 000
exec /sbin/setuser nobody /opt/splunk/bin/splunk start --nodaemon --accept-license