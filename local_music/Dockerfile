FROM ubuntu:trusty
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

# Update Image
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Install Prerequisites
RUN apt-get install -qy wget git lame python python-dev python-pip libasound2-dev libreadline-dev

ENV LIBSPOT libspotify-12.1.51-Linux-x86_64-release

RUN	cd /tmp && wget --no-check-certificate https://developer.spotify.com/download/libspotify/${LIBSPOT}.tar.gz && \
	tar -xvf ${LIBSPOT}.tar.gz && cd ${LIBSPOT} && make install && \
	pip install -I pyspotify==1.11 && pip install -I eyed3 && \
	cd /home && git clone https://github.com/olreti/spori
	
RUN sed -i.bak "s/printstr(\"\\\\r Recording/#printstr(\"\\\\r Recording/" /home/spori/jbripper.py && \
	sed -i.bak "s/name()/name().encode(\"utf-8\")/" /home/spori/jukebox.py && \
	rm /home/spori/*.bak
	
# Clean up
RUN apt-get purge -qq wget git && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
VOLUME /data \
	/logs
	
ADD init.sh /home/init.sh
RUN chmod +x /home/init.sh

ADD get_local.sh /home/get_local.sh
RUN chmod +x /home/get_local.sh

ADD get_local.list.template /home/get_local.list.template

CMD ["/home/get_local.sh"]
