#!/bin/bash
rm -f /var/run/homegear/homegear.pid
exec /usr/bin/homegear -p /var/run/homegear/homegear.pid -c /data/homegear/conf
