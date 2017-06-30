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

if ! cmp -s /opt/openhab/userdata/etc/version.properties /opt/openhab/userdata.org/etc/version.properties; then
	mkdir -p /tmp/openhab
	cp /opt/openhab/runtime/bin/update /tmp/openhab/
	sed -i.bak "s:read -r answer:answer=y:" /tmp/openhab/update
	sed -i.bak "s:> \"\$TempDir/update\":> \"\$TempDir/update.new\":" /tmp/openhab/update
	chmod a+x /tmp/openhab/update

	DockerVersion="$(awk '/openhab-distro/{print $3}' "/opt/openhab/userdata.org/etc/version.properties")"
	"/tmp/openhab/update" "$DockerVersion" "/opt/openhab"  ;
	
	chown -R nobody:users /opt/openhab
	chown -R nobody:users /data/openhab
fi
