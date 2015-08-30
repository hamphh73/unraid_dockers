#!/bin/bash

# customize config
cd /usr/local/etc/privoxy/
sed -i.bak "s:logdir /var/log/privoxy:logdir /logs:" config
sed -i.bak "s:logfile logfile:logfile privoxy.log:" config
#sed -i.bak "s:#debug     1:debug     1:" config
sed -i.bak "s/listen-address  127.0.0.1:8118/listen-address  0.0.0.0:8118/" config
rm config.bak
