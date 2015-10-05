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
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Install dvblink
RUN apt-get install -qy dbus
ENV DVBLINK=dvblink-server-pc-linux-ubuntu-x86_64-5.5.0.deb
ADD ${DVBLINK} /tmp/${DVBLINK}
RUN cd /tmp && dpkg -i ${DVBLINK}

ADD pre_init_dvblink.sh /tmp/pre_init_dvblink.sh
RUN chmod +x /tmp/pre_init_dvblink.sh
RUN /tmp/pre_init_dvblink.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#EXPOSE 9981 9982

VOLUME /recordings \
	   /data \
	   /logs
	   
# Init and Start DVBLink when container starts
RUN mkdir -p /etc/my_init.d
ADD dvblink.sh /etc/my_init.d/dvblink.sh
RUN chmod +x /etc/my_init.d/dvblink.sh
  
