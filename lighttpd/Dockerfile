FROM phusion/baseimage:0.9.21
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
	
# Install lighttpd
RUN apt-get install -qy lighttpd
ADD lighttpd.conf /home/lighttpd.conf

# Clean up
RUN apt-get purge -qq wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

VOLUME /data \
       /logs
	   
#Start lighttpd when container starts
RUN mkdir -p /etc/service/lighttpd
ADD lighttpd.sh /etc/service/lighttpd/run
RUN chmod +x /etc/service/lighttpd/run
