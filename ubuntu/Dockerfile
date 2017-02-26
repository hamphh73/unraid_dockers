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

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update Image
RUN apt-get update -qq && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
	
EXPOSE 22

VOLUME /data \
       /logs
	   
