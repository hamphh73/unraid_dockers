#!/bin/bash

sed -i "s:node_id_file = /etc/graylog/server/node-id:node_id_file = /data/graylog/server/node-id:" /opt/graylog/graylog.conf.example
ps=$(pwgen -N 1 -s 96)
sed -i "s:password_secret =:password_secret = $ps:" /opt/graylog/graylog.conf.example
pw=$(echo -n admin | shasum -a 256)
sed -i "s:root_password_sha2 =:root_password_sha2 = $pw:" /opt/graylog/graylog.conf.example
sed -i "s#rest_listen_uri =.*/#rest_listen_uri = http://0.0.0.0:9000/api/#" /opt/graylog/graylog.conf.example
sed -i "s+#web_listen_uri =.*/+web_listen_uri = http://0.0.0.0:9000/+" /opt/graylog/graylog.conf.example
sed -i "s:elasticsearch_shards = 4:elasticsearch_shards = 1:" /opt/graylog/graylog.conf.example
sed -i "s:#elasticsearch_cluster_name = graylog:elasticsearch_cluster_name = el_graylog:" /opt/graylog/graylog.conf.example
sed -i "s:#elasticsearch_discovery_zen_ping_multicast_enabled = false:elasticsearch_discovery_zen_ping_multicast_enabled = false:" /opt/graylog/graylog.conf.example

