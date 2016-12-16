#!/bin/bash

if [ ! -d "/logs/nextcloud/mysql/" ]; then
	mkdir -p /logs/nextcloud/mysql/
	chown -R nobody:users /logs/nextcloud/mysql/
	chmod -R 777 /logs/nextcloud/mysql/
fi

if [ ! -d "/data/mysql/" ]; then
	mkdir -p /data/mysql/
	chown -R nobody:users /data/mysql/
	chmod -R 777 /data/mysql/

	echo "mysql_install_db"
	mysql_install_db --datadir=/data/mysql
	sleep 2

	echo "start mysql"
	mysqld_safe --skip-syslog --datadir=/data/mysql --log-error=/logs/nextcloud/mysql/error.log &
	sleep 2

	echo "init databases"
	mysql --user=root <<-_SQL_
	  create database nextcloud;
	  create user nextclouduser@localhost identified by '${nextcloud_db_password}';
	  grant all privileges on nextcloud.* to nextclouduser@localhost identified by '${nextcloud_db_password}';
	  
	  UPDATE mysql.user SET Password=PASSWORD('${mariadb_root_password}') WHERE User='root';
	  DELETE FROM mysql.user WHERE User='';
	  DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	  DROP DATABASE IF EXISTS test;
	  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	  FLUSH PRIVILEGES;
	_SQL_
	
	sleep 2
	echo "shutdown"
	mysqladmin --user=root shutdown
	
	sleep 2
fi

rm -f /home/mysql.pid
rm -f /home/mysql.sock

echo "start service"
exec /usr/bin/mysqld_safe --skip-syslog --datadir=/data/mysql --log-error=/logs/nextcloud/mysql/error.log