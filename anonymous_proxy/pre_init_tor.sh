#!/bin/bash

# customize config
cd /usr/local/etc/tor/
mv torrc.sample torrc
sed -i.bak "s/#SocksPort 9050/SocksPort 0.0.0.0:9050/" torrc
sed -i.bak "s:#Log notice file /usr/local/var/log/tor/notices.log:Log notice file /logs/tor.log:" torrc
sed -i.bak "s:#DataDirectory /usr/local/var/lib/tor:DataDirectory /data/tor:" torrc
rm torrc.bak
