#!/bin/bash

if [ ! -d "/data/homegear/" ]; then
  mkdir -p /data/homegear/config/templates
  cp /etc/homegear/* /data/homegear/config/
  mkdir -p /data/homegear/data/templates
  cp -r /var/lib/homegear/scripts /data/homegear/data/
  chown -R nobody:users /data/homegear
  mkdir /logs/homegear
  chown -R nobody:users /logs/homegear
fi

cp -u /etc/homegear/* /data/homegear/config/templates
chown -R nobody:users /data/homegear/config/templates

cp -r -u /var/lib/homegear/scripts /data/homegear/data/templates
chown -R nobody:users /data/homegear/data/templates