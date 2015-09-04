#!/bin/bash
umask 000
rm -f /usr/local/var/run/dansguardian.pid
exec /sbin/setuser nobody /usr/local/sbin/dansguardian
