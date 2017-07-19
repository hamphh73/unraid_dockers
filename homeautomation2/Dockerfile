FROM hamphh/unraidjavabase:latest

EXPOSE 2001 2002 2003 8080

# Install homegear	
RUN wget https://homegear.eu/packages/Release.key && apt-key add Release.key && rm Release.key
RUN echo 'deb https://homegear.eu/packages/Ubuntu/ xenial/' >> /etc/apt/sources.list.d/homegear.list 
RUN apt-get update -qq
RUN apt-get install -qy homegear homegear-homematicbidcos
# Pre-Initialize homegear
ADD pre_init_homegear.sh /home/pre_init_homegear.sh
RUN chmod +x /home/pre_init_homegear.sh
RUN /home/pre_init_homegear.sh

# Install OpenHab
ENV OPENHAB_VERSION 2.1.0
RUN cd /tmp && \
	wget -q -O openhab.zip https://bintray.com/openhab/mvn/download_file?file_path=org%2Fopenhab%2Fdistro%2Fopenhab%2F${OPENHAB_VERSION}%2Fopenhab-${OPENHAB_VERSION}.zip && \
	unzip openhab.zip -d /opt/openhab
# Pre-Initialize OpenHab
ADD pre_init_openhab.sh /home/pre_init_openhab.sh
RUN chmod +x /home/pre_init_openhab.sh
RUN /home/pre_init_openhab.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

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
