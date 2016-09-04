FROM phusion/baseimage:0.9.19
MAINTAINER hamphh <docker@hampelhh.de>

EXPOSE 2001 2002 2003 8080

VOLUME /data \
	   /logs

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
	apt-get install -qy wget unzip
	
# Install homegear	
RUN wget https://homegear.eu/packages/Release.key && apt-key add Release.key && rm Release.key
RUN echo 'deb https://homegear.eu/packages/Ubuntu/ xenial/' >> /etc/apt/sources.list.d/homegear.list 
RUN apt-get update -qq
RUN apt-get install -qy homegear homegear-homematicbidcos
# Pre-Initialize homegear
ADD pre_init_homegear.sh /home/pre_init_homegear.sh
RUN chmod +x /home/pre_init_homegear.sh
RUN /home/pre_init_homegear.sh

# Install Java
ENV JRE_VERSION jre1.8.0_101
ENV JRE_FILE jre-8u101-linux-x64.tar.gz
ENV JRE_URL http://download.oracle.com/otn-pub/java/jdk/8u101-b13/${JRE_FILE}
RUN cd /tmp && wget -q --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" ${JRE_URL} && \
	tar xzvf ${JRE_FILE} && mkdir /opt/Oracle_Java &&  cp -r ${JRE_VERSION} /opt/Oracle_Java/${JRE_VERSION} && \
	update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws" 1 && \
	update-alternatives --set "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" && \
	update-alternatives --set "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws"

# Install OpenHab
ENV OPENHAB_VERSION 2.0.0-SNAPSHOT
RUN cd /tmp && \
	wget -q https://openhab.ci.cloudbees.com/job/openHAB-Distribution/lastSuccessfulBuild/artifact/distributions/openhab-offline/target/openhab-offline-${OPENHAB_VERSION}.zip && \
	unzip openhab-offline-${OPENHAB_VERSION} -d /opt/openhab
# Pre-Initialize OpenHab
ADD pre_init_openhab.sh /home/pre_init_openhab.sh
RUN chmod +x /home/pre_init_openhab.sh
RUN /home/pre_init_openhab.sh

# Clean up
RUN rm -rf /tmp/* /var/tmp/*

# Initialize homegear on boot
RUN mkdir -p /etc/my_init.d
ADD init_homegear.sh /etc/my_init.d/init_homegear.sh
RUN chmod +x /etc/my_init.d/init_homegear.sh

# Initialize OpenHab on boot
RUN mkdir -p /etc/my_init.d
ADD init_openhab.sh /etc/my_init.d/init_openhab.sh
RUN chmod +x /etc/my_init.d/init_openhab.sh

#Start homegear when container starts
RUN mkdir -p /etc/service/homegear
ADD homegear.sh /etc/service/homegear/run
RUN chmod +x /etc/service/homegear/run

#Start openhab when container starts
RUN mkdir -p /etc/service/openhab
ADD openhab.sh /etc/service/openhab/run
RUN chmod +x /etc/service/openhab/run
