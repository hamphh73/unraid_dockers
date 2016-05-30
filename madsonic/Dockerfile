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
RUN apt-get install -qy wget

ENV JRE_VERSION jre1.8.0_60
ENV JRE_FILE jre-8u60-linux-x64.tar.gz
ENV JRE_URL http://download.oracle.com/otn-pub/java/jdk/8u60-b27/${JRE_FILE}

# Install Java
RUN cd /tmp && wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JRE_URL} && \
	tar xzvf ${JRE_FILE} && mkdir /opt/Oracle_Java &&  cp -r ${JRE_VERSION} /opt/Oracle_Java/${JRE_VERSION} && \
	update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws" 1 && \
	update-alternatives --set "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" && \
	update-alternatives --set "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws"
	
ENV MADSONIC_FILE 20160505_madsonic-6.1.8280-standalone.tar.gz

RUN cd /tmp && wget -q http://madsonic.org/download/6.1/${MADSONIC_FILE} && \
	mkdir /opt/madsonic && cd /opt/madsonic && tar xzvf /tmp/${MADSONIC_FILE} && \
	mv madsonic.sh madsonic.sh.org && tr -d '\r' < madsonic.sh.org > madsonic.sh && rm madsonic.sh.org && \
	chmod a+x madsonic.sh

# Clean up
RUN apt-get purge -qq wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4040

VOLUME /media \
	   /data
	   
	   
# Start madsonic on boot
RUN mkdir -p /etc/my_init.d
ADD madsonic.sh /etc/my_init.d/madsonic.sh
RUN chmod +x /etc/my_init.d/madsonic.sh
