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
	
# Install build dependencies
RUN apt-get install -qy wget build-essential

ENV PRIVOXY_VERSION 3.0.23

# Install privoxy dependencies
RUN apt-get install -qy automake zlib1g-dev

# Compile && install Privoxy
RUN cd /tmp && \
	wget -q http://sourceforge.net/projects/ijbswa/files/Sources/${PRIVOXY_VERSION}%20%28stable%29/privoxy-${PRIVOXY_VERSION}-stable-src.tar.gz && \
	tar xzvf privoxy-${PRIVOXY_VERSION}-stable-src.tar.gz && cd privoxy-${PRIVOXY_VERSION}-stable && \
	autoheader && autoconf && \
	./configure  --disable-toggle  --disable-editor  --disable-force --with-user=nobody --with-group=users && \
	make && make install
	
# Initialize privoxy
ADD pre_init_privoxy.sh /home/pre_init_privoxy.sh
RUN chmod +x /home/pre_init_privoxy.sh
RUN /home/pre_init_privoxy.sh

#### --------------- tor -------------- #####
	
ENV TOR_VERSION 0.2.6.10

# Install tor dependencies
RUN apt-get install -qy libevent-dev libssl-dev

# Compile && install Tor
RUN cd /tmp && wget -q https://www.torproject.org/dist/tor-${TOR_VERSION}.tar.gz && \
	tar xzvf tor-${TOR_VERSION}.tar.gz && cd tor-${TOR_VERSION} && \
	./configure --disable-asciidoc && make && make install
	
# Initialize tor
ADD pre_init_tor.sh /home/pre_init_tor.sh
RUN chmod +x /home/pre_init_tor.sh
RUN /home/pre_init_tor.sh

# Clean up
RUN apt-get purge -qq wget build-essential automake && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8119 9050

VOLUME /data \
	   /logs

# Initialize tor on boot
RUN mkdir -p /etc/my_init.d
ADD init_tor.sh /etc/my_init.d/init_tor.sh
RUN chmod +x /etc/my_init.d/init_tor.sh

#Start Privoxy when container starts
RUN mkdir -p /etc/service/privoxy
ADD privoxy.sh /etc/service/privoxy/run
RUN chmod +x /etc/service/privoxy/run

#Start Tor when container starts
RUN mkdir -p /etc/service/tor
ADD tor.sh /etc/service/tor/run
RUN chmod +x /etc/service/tor/run
