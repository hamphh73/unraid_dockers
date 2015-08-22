#!/bin/bash
umask 000
exec /sbin/setuser nobody python3 "$@"