#!/bin/bash
umask 000
exec  /usr/local/sbin/privoxy --no-daemon --user nobody /config/privoxy/config
