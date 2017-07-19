FROM hamphh/unraidjavabase:latest

EXPOSE 1900 8895 23423

VOLUME /media

# Install Serviio

## Install dependencies
RUN apt-get update -qq
RUN apt-get install -qy ffmpeg dcraw

## Install Serviio
ENV SERVIIO_VERSION 1.8
RUN cd /tmp && \
	wget -q http://download.serviio.org/releases/serviio-${SERVIIO_VERSION}-linux.tar.gz && \
	tar xzvf serviio-${SERVIIO_VERSION}-linux.tar.gz && \
	cp -r serviio-${SERVIIO_VERSION} /opt/serviio

## Pre-Initialize Serviio
ADD pre_init_serviio.sh /home/pre_init_serviio.sh
RUN chmod +x /home/pre_init_serviio.sh
RUN /home/pre_init_serviio.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Initialize serviio on boot
RUN mkdir -p /etc/my_init.d
ADD init_serviio.sh /etc/my_init.d/init_serviio.sh
RUN chmod +x /etc/my_init.d/init_serviio.sh

#Start serviio when container starts
RUN mkdir -p /etc/service/serviio
ADD serviio.sh /etc/service/serviio/run
RUN chmod +x /etc/service/serviio/run
