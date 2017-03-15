FROM phusion/baseimage:0.9.19
MAINTAINER hamphh <docker@hampelhh.de>

EXPOSE 3306

VOLUME /data \
	   /logs

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
RUN apt-get update -qq && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
	
# Install mariadb
RUN apt-get install -qy mariadb-server mariadb-client
RUN mv /etc/mysql/my.cnf /etc/mysql/my.cnf.org
ADD my.etc.cnf /etc/mysql/my.cnf
RUN chown nobody:users /etc/mysql/my.cnf && chmod 644 /etc/mysql/my.cnf
ADD my.conf.cnf /home/my.cnf

# Clean up
RUN rm -rf /tmp/* /var/tmp/*

#Start mariadb when container starts
RUN mkdir -p /etc/service/mariadb
ADD mariadb.sh /etc/service/mariadb/run
RUN chmod +x /etc/service/mariadb/run
