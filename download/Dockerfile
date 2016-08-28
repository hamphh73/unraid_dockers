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

#Disable the SSH server
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Add Multiverse
RUN sed -i "s/xenial universe/xenial universe multiverse/g" /etc/apt/sources.list
RUN sed -i "s/xenial-updates universe/xenial-updates universe multiverse/g" /etc/apt/sources.list
	
# Update Image
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
	
# Install base
RUN apt-get install -qy wget git python 
	
# Install deluge
RUN apt-get install -qy python-twisted python-openssl python-setuptools intltool python-xdg python-chardet geoip-database python-libtorrent python-glade2 xdg-utils python-mako
ENV DELUGE_VERSION 1.3.13
RUN cd /tmp && wget -q http://download.deluge-torrent.org/source/deluge-${DELUGE_VERSION}.tar.gz && \
	tar xzvf deluge-${DELUGE_VERSION}.tar.gz && cd deluge-${DELUGE_VERSION} && \
	python setup.py build && sudo python setup.py install
	
# Install Couchpotato
RUN cd /opt && git clone https://github.com/RuudBurger/CouchPotatoServer.git

# Install pyload
RUN apt-get install -qy python-crypto python-pycurl python-imaging python-beaker tesseract-ocr tesseract-ocr-eng gocr unrar python-django rhino
RUN cd /opt && git clone https://github.com/pyload/pyload.git
	
# Clean up
RUN apt-get purge -qq wget git python-setuptools && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy config
ADD config/ /root/

EXPOSE 8112 5050 8000 9666

VOLUME /data \
       /logs \
	   /downloads

# Initialize on boot
RUN mkdir -p /etc/my_init.d
ADD initialize.sh /etc/my_init.d/initialize.sh
RUN chmod +x /etc/my_init.d/initialize.sh
	   
#Start deluged when container starts
RUN mkdir -p /etc/service/deluged
ADD deluged.sh /etc/service/deluged/run
RUN chmod +x /etc/service/deluged/run

#Start deluge-web when container starts
RUN mkdir -p /etc/service/deluge-web
ADD deluge-web.sh /etc/service/deluge-web/run
RUN chmod +x /etc/service/deluge-web/run

#Start couchpotato when container starts
RUN mkdir -p /etc/service/couchpotato
ADD couchpotato.sh /etc/service/couchpotato/run
RUN chmod +x /etc/service/couchpotato/run

#Start pyload when container starts
RUN mkdir -p /etc/service/pyload
ADD pyload.sh /etc/service/pyload/run
RUN chmod +x /etc/service/pyload/run

