#!/bin/bash

sv start mariadb || exit 1

if [ ! -d "/logs/nextcloud/apache2/" ]; then
	mkdir -p /logs/nextcloud/apache2/
	chown -R nobody:users /logs/nextcloud/apache2/
	chmod -R 777 /logs/nextcloud/apache2/
fi

if [ ! -d "/data/nextcloud/" ]; then
	mkdir -p /data/nextcloud/
	chown -R nobody:users /data/nextcloud/
	chmod -R 777 /data/nextcloud/
fi

rm -f /var/run/apache2/apache2.pid
exec /usr/sbin/apachectl -DFOREGROUND