#!/bin/bash

mv /opt/serviio/library /opt/serviio/library.org
ln -s /data/ /opt/serviio/library

ln -s /logs/serviio/ /opt/serviio/log
