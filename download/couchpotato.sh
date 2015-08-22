#!/bin/bash
umask 000
exec /sbin/setuser nobody python /opt/CouchPotatoServer/CouchPotato.py --data_dir /data/couchpotato