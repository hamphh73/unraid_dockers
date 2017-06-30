FROM phusion/baseimage:0.9.22
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

# Update Image and install basics
RUN apt-get update -qq && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
	apt-get install -qy wget
	
# Install splunk
RUN cd /tmp && wget -q -O splunklight.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.6.1&product=splunk_light&filename=splunklight-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz&wget=true' && \
	tar xvzf splunklight.tgz && mkdir /opt/splunk && cp -r splunk /opt/ && chown -R nobody:users /opt/splunk
RUN ln -s /data/var/ /opt/splunk/var && mv /opt/splunk/etc /opt/splunk/etc.org && ln -s /data/etc/ /opt/splunk/etc
ADD splunk-launch.conf /home/
	
# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8000

VOLUME /logs \
	   /data
	   
#Start splunk
RUN mkdir -p /etc/service/splunk
ADD splunk.sh /etc/service/splunk/run
RUN chmod +x /etc/service/splunk/run
