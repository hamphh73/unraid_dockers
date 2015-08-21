#!/bin/bash
exec /sbin/setuser nobody /usr/local/bin/deluge-web -c /data/deluge -l /logs/deluge-web.log -L info