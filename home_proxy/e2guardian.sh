#!/bin/bash
umask 000
rm -f /usr/local/var/run/e2guardian.pid
exec /sbin/setuser nobody /usr/local/sbin/e2guardian
