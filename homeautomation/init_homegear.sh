#!/bin/bash

if [ ! -d "/data/homegear/" ]; then
  mkdir -p /data/homegear/config
  chmod 777 /data/homegear/config
  
  cp /etc/homegear/*.conf /data/homegear/config/
  chmod 666 /data/homegear/config/*.conf
  
  mkdir -p /data/homegear/data
  chmod 777 /data/homegear/data
  
  cp -r /var/lib/homegear/scripts /data/homegear/data/scripts
  chmod -R 777 /data/homegear/data/scripts
fi

if [ ! -d "/logs/homegear/" ]; then
  mkdir /logs/homegear
  chmod 777 /logs/homegear
fi

if [ ! -d "/data/homegear/config/templates/" ]; then
	mkdir /data/homegear/config/templates
	chmod 777 /data/homegear/config/templates
fi
cp -u /etc/homegear/*.conf /data/homegear/config/templates
chmod 666 /data/homegear/config/templates/*.conf

if [ ! -d "/data/homegear/data/templates/" ]; then
	mkdir /data/homegear/data/templates
	chmod 777 /data/homegear/data/templates
fi
cp -r -u /var/lib/homegear/scripts /data/homegear/data/templates
chmod -R 777 /data/homegear/data/templates/scripts

# Start Homegear directly (doesn't work with runit)
/usr/bin/homegear -d -c /data/homegear/config
