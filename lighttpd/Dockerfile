FROM hamphh/unraidbase:latest

EXPOSE 80

# Install lighttpd
RUN apt-get update -qq
RUN apt-get install -qy lighttpd
ADD lighttpd.conf /home/lighttpd.conf

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	   
#Start lighttpd when container starts
RUN mkdir -p /etc/service/lighttpd
ADD lighttpd.sh /etc/service/lighttpd/run
RUN chmod +x /etc/service/lighttpd/run
