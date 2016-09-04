#!/bin/bash

chown -R nobody:users /opt/openhab

for dir in addons conf userdata; do
	mv /opt/openhab/$dir /opt/openhab/$dir.org
	ln -s /data/openhab/$dir/ /opt/openhab/$dir
done
