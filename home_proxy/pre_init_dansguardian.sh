#!/bin/bash

mv /usr/local/etc/dansguardian /usr/local/etc/dansguardian.org
ln -s /data/dansguardian/ /usr/local/etc/dansguardian

chown -R nobody:users /usr/local/var/run/

# customize config
cd /usr/local/etc/dansguardian.org/
sed -i.bak "s:language = 'ukenglish':language = 'german':" dansguardian.conf
sed -i.bak "s:filterports = 8080:filterports = 8081:" dansguardian.conf
sed -i.bak "s:#loglocation = '/usr/local/var/log/dansguardian/access.log':loglocation = '/logs/home_proxy/dansguardian.log':" dansguardian.conf
sed -i.bak "s:nodaemon = off:nodaemon = on:" dansguardian.conf
sed -i.bak "s:#daemonuser = 'nobody':daemonuser = 'nobody':" dansguardian.conf
sed -i.bak "s:#daemongroup = 'nobody':daemongroup = 'users':" dansguardian.conf
rm dansguardian.conf.bak
