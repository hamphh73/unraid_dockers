#!/bin/bash

cd /tmp
wget http://www.shallalist.de/Downloads/shallalist.tar.gz
tar -xzf shallalist.tar.gz -C /usr/local/etc/e2guardian/lists/
chown -R nobody:users /usr/local/etc/e2guardian/lists/BL
chmod -R 777 /usr/local/etc/e2guardian/lists/BL
rm shallalist.tar.gz
/usr/local/sbin/e2guardian -g
