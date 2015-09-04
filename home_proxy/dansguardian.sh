#!/bin/bash
umask 000
exec /sbin/setuser nobody /usr/local/sbin/dansguardian
