#!/bin/bash

for dir in addons configurations contexts webapps; do
	if [ ! -d "/data/openhab/$dir/" ]; then
		mkdir -p /data/openhab/$dir/
		cp -r /opt/openhab/$dir.org/* /data/openhab/$dir/
		chown -R nobody:users /data/openhab/$dir
		chmod -R 777 /data/openhab/$dir
	fi
done

for dir in workspace data additional_addons; do
	if [ ! -d "/data/openhab/$dir/" ]; then
		mkdir /data/openhab/$dir/
		chown -R nobody:users /data/openhab/$dir/
		chmod -R 777 /data/openhab/$dir
	fi
done

if [ ! -d "/logs/openhab/" ]; then
	mkdir /logs/openhab/
	chown -R nobody:users /logs/openhab/
	chmod -R 777 /logs/openhab/
fi

rm -f /data/openhab/addons/*
if [ -f "/data/openhab/configurations/addons.list" ]; then
	version=`cat /opt/openhab/version.txt`
	while read addon; do
		if [ $addon ]; then
			ln -s /opt/openhab-addons/$addon-$version.jar /data/openhab/addons/
		fi
	done </data/openhab/configurations/addons.list
fi
cp -s /data/openhab/additional_addons/* /data/openhab/addons/
