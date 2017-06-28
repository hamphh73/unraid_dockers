#!/bin/bash
umask 000
exec /sbin/setuser nobody /opt/splunk/bin/splunk start --nodaemon --accept-license