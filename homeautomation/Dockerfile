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

ENV HOMEGEAR_VERSION 0.5.25

# Update Image
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
	
# Install dependencies, build and install homegear
RUN apt-get update -qq && \
	apt-get install -qy \
	wget wget build-essential sqlite3 libsqlite3-dev libreadline6 libreadline6-dev g++-4.7 unzip p7zip-full libgcrypt11 libgcrypt-dev libgpg-error0 libgpg-error-dev libgnutlsxx27 libgnutls-dev libxml2-utils liblzo2-dev python-lzo && \
	cd /tmp && wget -q http://homegear.eu/packages/Debian/wheezy/homegear_${HOMEGEAR_VERSION}.orig.tar.gz && \
	tar xzvf homegear_${HOMEGEAR_VERSION}.orig.tar.gz && cd homegear-${HOMEGEAR_VERSION} && \
	make config=release
	
# Initialize homegear
ADD pre_init_homegear.sh /home/pre_init_homegear.sh
RUN chmod +x /home/pre_init_homegear.sh
RUN /home/pre_init_homegear.sh

# Clean up
RUN apt-get purge -qq wget build-essential && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 2001 2002 2003

VOLUME /data \
	   /logs
	   
# Initialize on boot
RUN mkdir -p /etc/my_init.d
ADD initialize.sh /etc/my_init.d/initialize.sh
RUN chmod +x /etc/my_init.d/initialize.sh
	   
#Start homegear when container starts
RUN mkdir -p /etc/service/homegear
ADD homegear.sh /etc/service/homegear/run
RUN chmod +x /etc/service/homegear/run
