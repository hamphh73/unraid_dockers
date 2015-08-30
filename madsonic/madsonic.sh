#!/bin/bash
umask 000
exec /sbin/setuser nobody /opt/madsonic/madsonic.sh --home=/data --default-music-folder=/media
