#!/bin/bash

cd /opt/grafana/conf
sed -i.bak "s:;data = .*:data = /data/grafana/data:" sample.ini
sed -i.bak "s:;logs = .*:logs = /logs/monitoring/grafana:" sample.ini
sed -i.bak "s:;plugins = .*:plugins = /data/grafana/plugins:" sample.ini
rm sample.ini.bak