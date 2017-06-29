#!/bin/bash

for dir in var etc; do
	if [ ! -d "/data/$dir/" ]; then
		mkdir -p /data/$dir/
		chown nobody:users /data/$dir
	fi
done

if ! cmp -s /opt/splunk/etc.org/splunk.version /data/etc/splunk.version; then
	cp -r /opt/splunk/etc.org/* /data/etc/
fi

umask 000
exec /sbin/setuser nobody /opt/splunk/bin/splunk start --nodaemon --accept-license