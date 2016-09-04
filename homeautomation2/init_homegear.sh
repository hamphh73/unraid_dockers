#!/bin/bash

if [ ! -d "/data/homegear/" ]; then
  mkdir -p /data/homegear/work
  chown -R nobody:users /data/homegear/work/
  chmod 777 /data/homegear/work
  
  mkdir -p /data/homegear/data
  chown -R nobody:users /data/homegear/data/
  chmod 777 /data/homegear/data

  cp -r /var/lib/homegear/scripts /data/homegear/scripts
  chown -R nobody:users /data/homegear/scripts/
  chmod -R 777 /data/homegear/scripts

  cp -r /etc/homegear.org /data/homegear/conf
  chown -R nobody:users /data/homegear/conf/
  chmod -R 777 /data/homegear/conf
fi

if [ ! -d "/logs/homegear/" ]; then
  mkdir /logs/homegear
  chown -R nobody:users /logs/homegear/
  chmod 777 /logs/homegear
fi

if [ ! -d "/data/homegear/conf/templates/" ]; then
	mkdir -p /data/homegear/conf/templates
	chmod 777 /data/homegear/conf/templates
fi
cp -ru /etc/homegear.org/* /data/homegear/conf/templates
chown -R nobody:users /data/homegear/conf/templates/
chmod -R 777 /data/homegear/conf/templates

if [ ! -d "/data/homegear/scripts/templates/" ]; then
	mkdir -p /data/homegear/scripts/templates
	chmod -R 777 /data/homegear/scripts/templates
fi
cp -ru /var/lib/homegear/scripts/* /data/homegear/scripts/templates
chown -R nobody:users /data/homegear/scripts/templates/
chmod -R 777 /data/homegear/scripts/templates

# Start Homegear directly (doesn't work with runit)
#rm -f /var/run/homegear/homegear.pid
#/usr/bin/homegear -d -p /var/run/homegear/homegear.pid -c /data/homegear/config
