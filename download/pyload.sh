#!/bin/bash
umask 000
exec /sbin/setuser nobody python /opt/pyload/pyLoadCore.py --configdir=/data/pyload