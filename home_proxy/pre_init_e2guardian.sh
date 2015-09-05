#!/bin/bash

mv /usr/local/etc/e2guardian /usr/local/etc/e2guardian.org
ln -s /data/e2guardian/ /usr/local/etc/e2guardian

chown -R nobody:users /usr/local/var/run/

# customize e2guardian.conf
cd /usr/local/etc/e2guardian.org/
sed -i.bak "s:language = 'ukenglish':language = 'german':" e2guardian.conf
sed -i.bak "s:filterports = 8080:filterports = 8081:" e2guardian.conf
sed -i.bak "s:#loglocation = '/usr/local/var/log/e2guardian/access.log':loglocation = '/logs/home_proxy/e2guardian.log':" e2guardian.conf
sed -i.bak "s:nodaemon = off:nodaemon = on:" e2guardian.conf
sed -i.bak "s:#daemonuser = 'nobody':daemonuser = 'nobody':" e2guardian.conf
sed -i.bak "s:#daemongroup = 'nobody':daemongroup = 'users':" e2guardian.conf
rm e2guardian.conf.bak
