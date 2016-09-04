#!/bin/bash
umask 000
rm -rf /opt/openhab/runtime/karaf/instances/*
exec /sbin/setuser nobody /opt/openhab/start.sh server