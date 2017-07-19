FROM hamphh/unraidbase:latest

EXPOSE 8000

# Install splunk
RUN cd /tmp && wget -q -O splunklight.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=6.6.1&product=splunk_light&filename=splunklight-6.6.1-aeae3fe0c5af-Linux-x86_64.tgz&wget=true' && \
	tar xvzf splunklight.tgz && mkdir /opt/splunk && cp -r splunk /opt/ && chown -R nobody:users /opt/splunk
RUN ln -s /data/var/ /opt/splunk/var && mv /opt/splunk/etc /opt/splunk/etc.org && ln -s /data/etc/ /opt/splunk/etc
ADD splunk-launch.conf /home/
	
# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Start splunk
RUN mkdir -p /etc/service/splunk
ADD splunk.sh /etc/service/splunk/run
RUN chmod +x /etc/service/splunk/run
