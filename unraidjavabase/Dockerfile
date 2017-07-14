FROM hamphh/unraidbase:latest

# Install Java
ENV JRE_VERSION jre1.8.0_131
ENV JRE_URL http://javadl.oracle.com/webapps/download/AutoDL?BundleId=220305_d54c1d3a095b4ff2b6607d096fa80163
RUN cd /tmp && wget -O java ${JRE_URL} && \
	tar xzvf java && mkdir /opt/Oracle_Java &&  cp -r ${JRE_VERSION} /opt/Oracle_Java/${JRE_VERSION} && \
	update-alternatives --install "/usr/bin/java" "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" 1 && \
	update-alternatives --install "/usr/bin/javaws" "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws" 1 && \
	update-alternatives --set "java" "/opt/Oracle_Java/${JRE_VERSION}/bin/java" && \
	update-alternatives --set "javaws" "/opt/Oracle_Java/${JRE_VERSION}/bin/javaws"

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD autostart.sh /home/autostart.sh

# Check autostart at startup
RUN mkdir -p /etc/my_init.d
ADD init_autostart.sh /etc/my_init.d/init_autostart.sh
RUN chmod +x /etc/my_init.d/init_autostart.sh

