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
	
ENV DANS_GUARDIAN_VERSION 2.12.0.3

# Install privoxy dependencies
RUN apt-get install -qy pkg-config libpcre3-dev

# Install DansGuardian
RUN cd /tmp && \
	wget -q http://downloads.sourceforge.net/project/dansguardian/dansguardian-${DANS_GUARDIAN_VERSION}.tar.bz2 && \
	tar --bzip2 -xvf dansguardian-${DANS_GUARDIAN_VERSION}.tar.bz2 && cd dansguardian-${DANS_GUARDIAN_VERSION} && \
	./configure && make && make install
	 
ENV SQUID_VERSION 3.5.7
	 
RUN apt-get install -qy libpam0g-dev libldap-dev

# Install Squid
RUN cd /tmp && \
	wget -q http://www.squid-cache.org/Versions/v3/3.5/squid-${SQUID_VERSION}.tar.gz && \
	tar xzvf squid-${SQUID_VERSION}.tar.gz && cd squid-${SQUID_VERSION} && \
	./configure --enable-auth --enable-auth-basic="PAM LDAP" && make && make install && \
	chmod u+s /usr/local/squid/libexec/basic_pam_auth
ADD squid /etc/pam.d/squid
	
# Clean up
RUN apt-get purge -qq wget build-essential pkg-config automake && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Pre-Initialize privoxy
ADD pre_init_privoxy.sh /home/pre_init_privoxy.sh
RUN chmod +x /home/pre_init_privoxy.sh
RUN /home/pre_init_privoxy.sh

# Pre-Initialize squid
ADD pre_init_squid.sh /home/pre_init_squid.sh
ADD squid.conf.append /home/squid.conf.append
RUN chmod +x /home/pre_init_squid.sh
RUN /home/pre_init_squid.sh

# Pre-Initialize dansguardian
ADD pre_init_dansguardian.sh /home/pre_init_dansguardian.sh
RUN chmod +x /home/pre_init_dansguardian.sh
RUN /home/pre_init_dansguardian.sh

EXPOSE 8081 3128

VOLUME /data \
	   /logs

# Initialize privoxy on boot
RUN mkdir -p /etc/my_init.d
ADD init_privoxy.sh /etc/my_init.d/init_privoxy.sh
RUN chmod +x /etc/my_init.d/init_privoxy.sh
	   
# Initialize squid on boot
RUN mkdir -p /etc/my_init.d
ADD init_squid.sh /etc/my_init.d/init_squid.sh
RUN chmod +x /etc/my_init.d/init_squid.sh
	   
# Initialize dansguardian on boot
RUN mkdir -p /etc/my_init.d
ADD init_dansguardian.sh /etc/my_init.d/init_dansguardian.sh
RUN chmod +x /etc/my_init.d/init_dansguardian.sh

#Start Privoxy when container starts
RUN mkdir -p /etc/service/privoxy
ADD privoxy.sh /etc/service/privoxy/run
RUN chmod +x /etc/service/privoxy/run

#Start Squid when container starts
RUN mkdir -p /etc/service/squid
ADD squid.sh /etc/service/squid/run
RUN chmod +x /etc/service/squid/run

#Start DansGuardian when container starts
RUN mkdir -p /etc/service/dansguardian
ADD dansguardian.sh /etc/service/dansguardian/run
RUN chmod +x /etc/service/dansguardian/run
