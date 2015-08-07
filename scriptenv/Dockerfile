FROM debian:jessie
MAINTAINER hamphh <docker@hampelhh.de>
ENV DEBIAN_FRONTEND noninteractive

ENV HOME /root

# User für unraid
RUN usermod -u 99 nobody && \
	usermod -g 100 nobody

# UTF-8
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8 && \
    apt-get remove -y locales

ENV LANG C.UTF-8
	
RUN apt-get update -qq && \
	echo deb http://www.deb-multimedia.org jessie main non-free >>/etc/apt/sources.list && \
	apt-get update -qq && \
	apt-get install -qy --force-yes deb-multimedia-keyring && \
	apt-get update -qq && \
	apt-get install -qy python3 python3-requests ffmpeg ufraw-batch

VOLUME /data \
	/scripts

ENTRYPOINT ["python3"]
CMD ["--version"]
