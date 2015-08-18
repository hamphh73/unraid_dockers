#!/bin/bash

if [ ! -d "/config/privoxy/" ]; then
  cp -r /root/privoxy /config/
  chown -R nobody:users /config/privoxy
fi

if [ ! -d "/config/tor/" ]; then
  cp -r /root/tor /config/
  chown -R nobody:users /config/tor
fi
