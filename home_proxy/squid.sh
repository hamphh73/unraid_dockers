#!/bin/bash
umask 000
exec  /sbin/setuser nobody /usr/local/squid/sbin/squid -N
