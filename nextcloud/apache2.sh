#!/bin/bash

if [ ! -d "/logs/nextcloud/apache2/" ]; then
	mkdir -p /logs/nextcloud/apache2/
	chown -R nobody:users /logs/nextcloud/apache2/
	chmod -R 777 /logs/nextcloud/apache2/
fi

mkdir -p /data/app/
rsync -r --update /opt/nextcloud/* /data/app
chown -R nobody:users /data/app/
chmod -R 777 /data/app/


if [ ! -d "/data/data/" ]; then
	mkdir -p /data/data/
	chown -R nobody:users /data/data/
	chmod -R 777 /data/data/
fi

rm -f /var/run/apache2/apache2.pid
exec /usr/sbin/apachectl -DFOREGROUND