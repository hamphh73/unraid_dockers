#!/bin/bash
umask 000
exec  /usr/local/sbin/privoxy --no-daemon --user nobody /usr/local/etc/privoxy/config
