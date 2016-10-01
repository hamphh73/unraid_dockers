FROM phusion/baseimage:0.9.19
MAINTAINER hamphh <docker@hampelhh.de>

# Set correct environment variables
ENV DEBIAN_FRONTEND=noninteractive HOME="/root" TERM=xterm LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

# Set the locale
RUN locale-gen en_US.UTF-8

# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody && \
	usermod -g 100 nobody && \
	usermod -d /home nobody && \
	chown -R nobody:users /home

#Disable the SSH server
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update Image
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Install prerequisits
RUN apt-get install -qy wget pwgen
	
# MongoDB
ENV MONGO_DB_VERSION 3.2.9
RUN cd /tmp && wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-${MONGO_DB_VERSION}.tgz && \
	tar -zxvf mongodb-linux-x86_64-${MONGO_DB_VERSION}.tgz && \
	mkdir /opt/mongodb && cp -R -n mongodb-linux-x86_64-${MONGO_DB_VERSION}/* /opt/mongodb/ && \
	chown -R nobody:users /opt/mongodb/ && chmod -R 777 /opt/mongodb/
	
# Java
ENV JRE_VERSION jre1.8.0_101
ENV JRE_FILE jre-8u101-linux-x64.tar.gz
ENV JRE_URL http://download.oracle.com/otn-pub/java/jdk/8u101-b13/${JRE_FILE}
RUN cd /tmp && wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JRE_URL} && \
	tar xzvf ${JRE_FILE} && mkdir /opt/Oracle_Java &&  cp -r ${JRE_VERSION} /opt/Oracle_Java/${JRE_VERSION} && \
	update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws" 1 && \
	update-alternatives --set "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" && \
	update-alternatives --set "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws"

# Elasticsearch
ENV ELASTIC_VERSION 2.4.0
RUN cd /tmp && wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ELASTIC_VERSION}/elasticsearch-${ELASTIC_VERSION}.tar.gz && \
	tar -xvf elasticsearch-${ELASTIC_VERSION}.tar.gz && mkdir /opt/elasticsearch && cp -R -n elasticsearch-${ELASTIC_VERSION}/* /opt/elasticsearch/ && \
	chown -R nobody:users /opt/elasticsearch/ && chmod -R 777 /opt/elasticsearch/
ADD init_elasticsearch.sh /home/init_elasticsearch.sh
RUN chmod +x /home/init_elasticsearch.sh
RUN /home/init_elasticsearch.sh

# Graylog
ENV GRAYLOG_VERSION 2.1.1
RUN cd /tmp && wget https://packages.graylog2.org/releases/graylog/graylog-${GRAYLOG_VERSION}.tgz && \
	tar xvfz graylog-${GRAYLOG_VERSION}.tgz && mkdir /opt/graylog && cp -R -n graylog-${GRAYLOG_VERSION}/* /opt/graylog/ && \
	chown -R nobody:users /opt/graylog/ && chmod -R 777 /opt/graylog/
ADD init_graylog.sh /home/init_graylog.sh
RUN chmod +x /home/init_graylog.sh
RUN /home/init_graylog.sh

# Graylog Collector Sidecar
ENV GL_COLLECTOR_SIDECAR_VERSION 0.0.9
ENV GL_COLLECTOR_SIDECAR_SUBVERSION 1
RUN cd /tmp && wget https://github.com/Graylog2/collector-sidecar/releases/download/${GL_COLLECTOR_SIDECAR_VERSION}/collector-sidecar_${GL_COLLECTOR_SIDECAR_VERSION}-${GL_COLLECTOR_SIDECAR_SUBVERSION}_amd64.deb && \
	dpkg -i collector-sidecar_${GL_COLLECTOR_SIDECAR_VERSION}-${GL_COLLECTOR_SIDECAR_SUBVERSION}_amd64.deb
ADD collector_sidecar.yml /home/collector_sidecar.yml
	
# Clean up
RUN apt-get purge -qq wget pwgen && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9000 12900-12910

VOLUME /logs \
	   /data
	   
# Start Services
RUN mkdir -p /etc/service/mongodb
ADD mongodb.sh /etc/service/mongodb/run
RUN chmod +x /etc/service/mongodb/run

RUN mkdir -p /etc/service/elasticsearch
ADD elasticsearch.sh /etc/service/elasticsearch/run
RUN chmod +x /etc/service/elasticsearch/run

RUN mkdir -p /etc/service/graylog
ADD graylog.sh /etc/service/graylog/run
RUN chmod +x /etc/service/graylog/run

RUN mkdir -p /etc/service/graylog-collector-sidecar
ADD graylog-collector-sidecar.sh /etc/service/graylog-collector-sidecar/run
RUN chmod +x /etc/service/graylog-collector-sidecar/run
