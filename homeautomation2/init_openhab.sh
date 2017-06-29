#!/bin/bash

for dir in addons conf userdata; do
	if [ ! -d "/data/openhab/$dir/" ]; then
		mkdir -p /data/openhab/$dir/
		cp -r /opt/openhab/$dir.org/* /data/openhab/$dir/
		chown -R nobody:users /data/openhab/$dir
		chmod -R 777 /data/openhab/$dir
	fi
done

if [ ! -d "/logs/openhab/" ]; then
	mkdir -p /logs/openhab/
	chown -R nobody:users /logs/openhab/
	chmod -R 777 /logs/openhab/
fi

if [ ! -L "/data/openhab/userdata/logs" ]; then
	rm -rf /data/openhab/userdata/logs
	ln -s /logs/openhab/ /data/openhab/userdata/logs
fi

CurrentVersion="$(awk '/openhab-distro/{print $3}' "/opt/openhab/userdata/etc/version.properties")"
DockerVersion="$(awk '/openhab-distro/{print $3}' "/opt/openhab/userdata.org/etc/version.properties")"

if [ "$DockerVersion" != "$CurrentVersion" ]; then
	"/opt/openhab/runtime/bin/update" "$DockerVersion" "/opt/openhab"  ;
fi
