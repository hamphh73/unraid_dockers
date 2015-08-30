#!/bin/bash
umask 000
exec /sbin/setuser nobody /usr/local/bin/tor -f /usr/local/etc/tor/torrc
