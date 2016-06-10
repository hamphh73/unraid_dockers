#!/bin/bash

# Raise Max File Descriptors for Elasticsearch
printf '*    soft nofile 64000\n*    hard nofile 64000\nroot soft nofile 64000\nroot hard nofile 64000' >> /etc/security/limits.conf
echo session required pam_limits.so >> /etc/pam.d/common-session
echo session required pam_limits.so >> /etc/pam.d/common-session-noninteractive

# Config
echo cluster.name: el_graylog >> /opt/elasticsearch/config/elasticsearch.yml
echo node.name: el_graylog1 >> /opt/elasticsearch/config/elasticsearch.yml
echo script.inline: false >> /opt/elasticsearch/config/elasticsearch.yml
echo script.indexed: false >> /opt/elasticsearch/config/elasticsearch.yml
echo script.file: false >> /opt/elasticsearch/config/elasticsearch.yml



