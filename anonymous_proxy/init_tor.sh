#!/bin/bash

if [ ! -d "/data/tor/" ]; then
  mkdir -p /data/tor
  chown -R nobody:users /data/tor
fi
