#!/bin/bash
umask 000

for dir in channel_files common database licenses temp transponders xmltv; do
	if [ ! -d "/data/$dir/" ]; then
		mkdir -p /data/$dir/
		if [ -d "/opt/DVBLink/$dir.org/" ]; then
			cp -r /opt/DVBLink/$dir.org/* /data/$dir/
		fi
		chmod -R 777 /data/$dir
	fi
done

if [ ! -d "/recordings/thumbnails/" ]; then
	mkdir -p /recordings/thumbnails/
	chmod -R 777 /recordings/thumbnails
fi

if [ ! -d "/data/config/" ]; then
	mkdir -p /data/config/
	cp -r /usr/local/bin/dvblink/config.org/* /data/config/
	chmod -R 777 /data/config
fi

if [ ! -d "/logs/dvblink/" ]; then
	mkdir -p /logs/dvblink/
	chmod -R 777 /logs/dvblink/
fi

mkdir -p /timeshift
mount -t ramfs ramfs /timeshift
chmod 777 /timeshift

dbus-daemon --system --fork
/usr/local/bin/dvblink/start2.sh