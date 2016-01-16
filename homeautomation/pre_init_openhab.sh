#!/bin/bash

for dir in addons configurations contexts webapps; do
	mv /opt/openhab/$dir /opt/openhab/$dir.org
	ln -s /data/openhab/$dir/ /opt/openhab/$dir
done

ln -s /data/openhab/workspace/ /opt/openhab/workspace
#ln -s /data/openhab/data/ /opt/openhab/etc/rrd4j
ln -s /logs/openhab/ /opt/openhab/logs
