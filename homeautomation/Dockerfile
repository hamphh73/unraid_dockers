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
	
# Install dependencies
RUN apt-get update -qq && \
	apt-get install -qy \
	wget unzip build-essential sqlite3 libsqlite3-dev libreadline6 libreadline6-dev g++-4.7 unzip p7zip-full libgcrypt11 libgcrypt-dev libgpg-error0 libgpg-error-dev libgnutlsxx27 libgnutls-dev libxml2-utils liblzo2-dev python-lzo
	
ENV HOMEGEAR_VERSION 0.5.25

# Install homegear
RUN cd /tmp && wget -q http://homegear.eu/packages/Debian/wheezy/homegear_${HOMEGEAR_VERSION}.orig.tar.gz && \
	tar xzvf homegear_${HOMEGEAR_VERSION}.orig.tar.gz && cd homegear-${HOMEGEAR_VERSION} && \
	make config=release

# Initialize homegear
ADD pre_init_homegear.sh /home/pre_init_homegear.sh
RUN chmod +x /home/pre_init_homegear.sh
RUN /home/pre_init_homegear.sh

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
	
ENV OPENHAB_VERSION 1.7.1

RUN cd /tmp && wget -q https://bintray.com/artifact/download/openhab/bin/distribution-${OPENHAB_VERSION}-runtime.zip && \
	wget -q https://bintray.com/artifact/download/openhab/bin/distribution-${OPENHAB_VERSION}-addons.zip && \
	unzip distribution-${OPENHAB_VERSION}-runtime.zip -d /opt/openhab && \
	unzip distribution-${OPENHAB_VERSION}-addons.zip -d /opt/openhab-addons && \
	echo ${OPENHAB_VERSION} > /opt/openhab/version.txt

# Initialize openhab
ADD pre_init_openhab.sh /home/pre_init_openhab.sh
RUN chmod +x /home/pre_init_openhab.sh
RUN /home/pre_init_openhab.sh
	
# Clean up
RUN apt-get purge -qq wget unzip build-essential && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 2001 2002 2003 8080

VOLUME /data \
	   /logs
	   
# Initialize and start homegear on boot
RUN mkdir -p /etc/my_init.d
ADD init_homegear.sh /etc/my_init.d/init_homegear.sh
RUN chmod +x /etc/my_init.d/init_homegear.sh
	   
# Initialize openhab on boot
RUN mkdir -p /etc/my_init.d
ADD init_openhab.sh /etc/my_init.d/init_openhab.sh
RUN chmod +x /etc/my_init.d/init_openhab.sh

#Start openhab when container starts
RUN mkdir -p /etc/service/openhab
ADD openhab.sh /etc/service/openhab/run
RUN chmod +x /etc/service/openhab/run
