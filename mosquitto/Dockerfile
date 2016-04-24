FROM phusion/baseimage:0.9.16
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
RUN apt-get update -qq && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Install dependencies
RUN apt-get install -qy build-essential wget libssl-dev cmake

# Build and install mosquitto
ENV MOSQUITTO_VERSION 1.4.8
RUN cd /tmp && wget http://mosquitto.org/files/source/mosquitto-${MOSQUITTO_VERSION}.tar.gz && \
	tar xzvf mosquitto-${MOSQUITTO_VERSION}.tar.gz && cd mosquitto-${MOSQUITTO_VERSION} && \
	mkdir build && cd build && cmake .. -DOPENSSL_ROOT_DIR=/usr/bin/openssl && make && make install

# Clean up
RUN apt-get purge -qq wget build-essential cmake && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 1883

VOLUME /data \
       /logs
	   
# Initialize mosquitto
ADD pre_init_mosquitto.sh /home/pre_init_mosquitto.sh
RUN chmod +x /home/pre_init_mosquitto.sh
RUN /home/pre_init_mosquitto.sh

# Initialize mosquitto on boot
RUN mkdir -p /etc/my_init.d
ADD init_mosquitto.sh /etc/my_init.d/init_mosquitto.sh
RUN chmod +x /etc/my_init.d/init_mosquitto.sh

#Start mosquitto when container starts
RUN mkdir -p /etc/service/mosquitto
ADD mosquitto.sh /etc/service/mosquitto/run
RUN chmod +x /etc/service/mosquitto/run
