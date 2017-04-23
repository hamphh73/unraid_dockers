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
	
# Install dependencies, build and install tvheadend
ENV TVH_BRANCH release/4.2
RUN apt-get install -qy build-essential git pkg-config libssl-dev bzip2 wget python gettext cmake && \
	cd /tmp && git clone https://github.com/tvheadend/tvheadend.git && cd tvheadend && \
	git checkout ${TVH_BRANCH} &&./configure --disable-hdhomerun_client --disable-libav && make && make install


# Clean up
RUN apt-get purge -qq wget pkg-config build-essential && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9981 9982

VOLUME /config \
       /recordings \
	   /data
	   
# Add tv_grab_wg to /usr/bin/
ADD tv_grab_wg tv_grab_file /usr/bin/
RUN chmod +x /usr/bin/tv_grab_*

#Start tvheadend when container starts
RUN mkdir -p /etc/service/tvheadend
ADD tvheadend.sh /etc/service/tvheadend/run
RUN chmod +x /etc/service/tvheadend/run
