FROM phusion/baseimage:0.9.19
MAINTAINER hamphh <docker@hampelhh.de>

EXPOSE 1900 8895 23423

VOLUME /data \
	   /logs \
	   /media

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

# Update Image and install basics
RUN apt-get update -qq && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
	apt-get install -qy wget
	
# Install Java
ENV JRE_VERSION jre1.8.0_121
ENV JRE_FILE jre-8u121-linux-x64.tar.gz
ENV JRE_URL http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/${JRE_FILE}
RUN cd /tmp && wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JRE_URL} && \
	tar xzvf ${JRE_FILE} && mkdir /opt/Oracle_Java &&  cp -r ${JRE_VERSION} /opt/Oracle_Java/${JRE_VERSION} && \
	update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws" 1 && \
	update-alternatives --set "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" && \
	update-alternatives --set "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws"

# Install Serviio
## Install dependencies
RUN apt-get install -qy ffmpeg dcraw
## Install Serviio
ENV SERVIIO_VERSION 1.8
RUN cd /tmp && \
	wget -q http://download.serviio.org/releases/serviio-${SERVIIO_VERSION}-linux.tar.gz && \
	tar xzvf serviio-${SERVIIO_VERSION}-linux.tar.gz && \
	cp -r serviio-${SERVIIO_VERSION} /opt/serviio
## Pre-Initialize Serviio
ADD pre_init_serviio.sh /home/pre_init_serviio.sh
RUN chmod +x /home/pre_init_serviio.sh
RUN /home/pre_init_serviio.sh

# Clean up
RUN rm -rf /tmp/* /var/tmp/*

# Initialize serviio on boot
RUN mkdir -p /etc/my_init.d
ADD init_serviio.sh /etc/my_init.d/init_serviio.sh
RUN chmod +x /etc/my_init.d/init_serviio.sh

#Start serviio when container starts
RUN mkdir -p /etc/service/serviio
ADD serviio.sh /etc/service/serviio/run
RUN chmod +x /etc/service/serviio/run
