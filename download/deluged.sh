#!/bin/bash
umask 000
exec /sbin/setuser nobody /usr/local/bin/deluged -d -c /data/deluge -l /logs/deluged.log -L info