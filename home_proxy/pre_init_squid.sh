#!/bin/bash

mv /usr/local/squid/etc /usr/local/squid/etc.org
ln -s /data/squid/config/ /usr/local/squid/etc

rm -r /usr/local/squid/var/cache/squid
ln -s /data/squid/data/ /usr/local/squid/var/cache/squid

rm -r /usr/local/squid/var/logs
ln -s /logs/home_proxy/squid/ /usr/local/squid/var/logs

# customize config
cat /home/squid.conf.append >> /usr/local/squid/etc.org/squid.conf