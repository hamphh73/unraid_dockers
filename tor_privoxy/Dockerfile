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

ENV PRIVOXY_VERSION 3.0.23
ENV TOR_VERSION 0.1
	
# Update Image
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
	
# Install dependencies, build
RUN apt-get install -qy git build-essential automake libevent-dev libssl-dev

# Compile && install Privoxy
RUN cd /tmp && \
	wget -q -O http://sourceforge.net/projects/ijbswa/files/Sources/${PRIVOXY_VERSION}%20%28stable%29/privoxy-${PRIVOXY_VERSION}-stable-src.tar.gz && \
	tar xzvf privoxy-${PRIVOXY_VERSION}-stable-src.tar.gz && cd privoxy-${PRIVOXY_VERSION}-stable && \
	autoheader && autoconf && ./configure && make && make install USER=nobody GROUP=nobody
	
# Compile && install Tor
RUN cd /tmp && git clone https://git.torproject.org/tor.git && \
	cd tor && ./autogen.sh && ./configure --disable-asciidoc && make && make install && \
	cp /usr/local/etc/tor/torrc.sample /usr/local/etc/tor/torrc
	
# Clean up
RUN apt-get purge -qq build-essential pkg-config git automake && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configure Privoxy using Tor
RUN echo "forward-socks5t             /     127.0.0.1:9050 ." >> /etc/privoxy/config

EXPOSE 8118 9050

VOLUME /etc/privoxy \
       /usr/local/etc/tor \
	   /var/log/privoxy \
	   /var/log/tor
	   
#Start Privoxy when container starts
RUN mkdir -p /etc/service/privoxy
ADD privoxy.sh /etc/service/privoxy/run
RUN chmod +x /etc/service/privoxy/run

#Start Tor when container starts
RUN mkdir -p /etc/service/tor
ADD tor.sh /etc/service/tor/run
RUN chmod +x /etc/service/tor/run
