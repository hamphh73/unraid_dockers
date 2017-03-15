#!/bin/bash

if [ ! -d "/logs/mysql/" ]; then
	mkdir -p /logs/mysql/
	chown -R nobody:users /logs/mysql/
	chmod -R 777 /logs/mysql/
fi

if [ ! -d "/data/data/" ]; then
	mkdir -p /data/data/
	chown -R nobody:users /data/data/
	chmod -R 777 /data/data/

	echo "mysql_install_db"
	mysql_install_db --user=nobody --datadir=/data/data
	sleep 2

	echo "Database created. Granting access to 'root' ruser for all hosts."
	mysqld_safe --skip-syslog --datadir=/data/data --log-error=/logs/mysql/error.log &
	sleep 2
	mysql --user=root <<-_SQL_
	  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
	  UPDATE mysql.user SET Password=PASSWORD('${mariadb_root_password}') WHERE User='root';
	  DELETE FROM mysql.user WHERE User='';
	  DROP DATABASE IF EXISTS test;
	  DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	  FLUSH PRIVILEGES;
	_SQL_

	
	
	mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION"
	
	sleep 2
	echo "shutdown"
	mysqladmin shutdown
	
	sleep 2
fi

if [ ! -d "/data/conf/" ]; then
	mkdir -p /data/conf/
	chown -R nobody:users /data/conf/
	chmod -R 777 /data/conf/
fi

if [ ! -f "/data/conf/my.cnf" ]; then
	cp /home/my.cnf /data/conf/
	chown nobody:users /data/conf/my.cnf
	chmod 644 /data/conf/my.cnf
fi


rm -f /home/mysql.pid
rm -f /home/mysql.sock

echo "start service"
exec /usr/bin/mysqld_safe --defaults-file=/data/conf/my.cnf --datadir=/data/data --log-error=/logs/mysql/error.log --skip-syslog