FROM phusion/baseimage:0.9.16
MAINTAINER hamphh <docker@hampelhh.de>
ENV DEBIAN_FRONTEND noninteractive

#Disable the SSH server
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Change uid & gid to match Unraid
RUN usermod -u 99 nobody && \
    usermod -g 100 nobody

# Install dependencies, build and install tvheadend
RUN apt-get update -qq && \
	apt-get install -qy \
	build-essential git pkg-config libssl-dev bzip2 wget \
	python gettext && \
	cd /tmp && git clone https://github.com/tvheadend/tvheadend.git && cd tvheadend && \
	./configure --disable-hdhomerun_client --disable-libav && make && make install && \
	rm -r /tmp/tvheadend && apt-get purge -qq build-essential pkg-config git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9981 9982

VOLUME /config \
       /recordings \
	   /data

# Add tv_grab_wg to /usr/bin/
ADD tv_grab_wg tv_grab_file /usr/bin/
RUN chmod +x /usr/bin/tv_grab_*

#Start tvheadend when container starts
RUN mkdir -p /etc/service/tvheadend
ADD tvheadend /etc/service/tvheadend/run
RUN chmod +x /etc/service/tvheadend/run
