#!/bin/bash

cd /etc/influxdb
sed -i.bak "s:dir = \"/var/lib/influxdb/meta\":dir = \"/data/data/meta\":" influxdb.conf
sed -i.bak "s:dir = \"/var/lib/influxdb/data\":dir = \"/data/data/db\":" influxdb.conf
sed -i.bak "s:wal-dir = \"/var/lib/influxdb/wal\":wal-dir = \"/data/data/wal\":" influxdb.conf
rm influxdb.conf.bak

rm -f /var/log/influxdb
ln ln -s /logs/monitoring/influxdb/ /var/log/influxdb