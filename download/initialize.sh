#!/bin/bash

if [ ! -d "/data/deluge/" ]; then
  cp -r /root/deluge /data/
  chown -R nobody:users /data/deluge
fi

if [ ! -d "/data/couchpotato/" ]; then
  cp -r /root/couchpotato /data/
  chown -R nobody:users /data/couchpotato
fi

if [ ! -d "/data/pyload/" ]; then
  cp -r /root/pyload /data/
  chown -R nobody:users /data/pyload
fi
