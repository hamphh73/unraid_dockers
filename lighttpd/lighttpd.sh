#!/bin/bash

if [ ! -f "/data/lighttpd.conf" ]; then
  cp /home/lighttpd.conf /data/lighttpd.conf
  chown nobody:users /data/lighttpd.conf
  chmod 777 /data/lighttpd.conf
fi

if [ ! -d "/data/www/" ]; then
  mkdir /data/www
  chown -R nobody:users /data/www/
  chmod 777 /data/www
fi

umask 000
exec /usr/sbin/lighttpd -D -f /data/lighttpd.conf