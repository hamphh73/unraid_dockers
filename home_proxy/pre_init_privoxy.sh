#!/bin/bash

mv /usr/local/etc/privoxy /usr/local/etc/privoxy.org
ln -s /data/privoxy/ /usr/local/etc/privoxy

# customize config
cd /usr/local/etc/privoxy.org/
sed -i.bak "s:logdir /var/log/privoxy:logdir /logs:" config
sed -i.bak "s:logfile logfile:logfile privoxy.log:" config
#sed -i.bak "s:#debug     1:debug     1:" config
#sed -i.bak "s/listen-address  127.0.0.1:8118/listen-address  0.0.0.0:8118/" config
rm config.bak
