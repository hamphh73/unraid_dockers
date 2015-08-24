#!/bin/bash
umask 000
exec  /usr/bin/homegear -c /data/homegear/config -s nobody users
