#!/bin/bash

# customize main.conf
cd /etc/apache2

sed -i.bak "s:export APACHE_RUN_USER=www-data:export APACHE_RUN_USER=nobody:" envvars
sed -i.bak "s:export APACHE_RUN_GROUP=www-data:export APACHE_RUN_GROUP=users:" envvars
sed -i.bak "s:export APACHE_LOG_DIR=/var/log/apache2$SUFFIX:export APACHE_LOG_DIR=/logs/nextcloud/apache2:" envvars

rm envvars.bak