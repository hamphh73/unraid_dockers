#!/bin/bash

for dir in addons configurations contexts webapps; do
	if [ ! -d "/data/openhab/$dir/" ]; then
		mkdir -p /data/openhab/$dir/
		cp -r /opt/openhab/$dir.org/* /data/openhab/$dir/
		chown -R nobody:users /data/openhab/$dir
	fi
done

if [ ! -d "/data/openhab/workspace/" ]; then
	mkdir /data/openhab/workspace/
	chown -R nobody:users /data/openhab/workspace/
fi

if [ ! -d "/logs/openhab/" ]; then
	mkdir /logs/openhab/
	chown -R nobody:users /logs/openhab/
fi

if [ -f "/data/openhab/configurations/addons.list" ]; then
	version=`cat /opt/openhab/version.txt`
	rm -f /data/openhab/addons/*
	while read addon; do
		if [ $addon ]; then
			ln -s /opt/openhab-addons/$addon-$version.jar /data/openhab/addons/
		fi
	done </data/openhab/configurations/addons.list
fi
