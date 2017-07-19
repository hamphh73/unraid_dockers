FROM hamphh/unraidbase:latest

EXPOSE 3000 8083 8086

# InfluxDB
ENV INFLUXDB_VERSION 1.2.4
RUN cd /tmp && wget https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUXDB_VERSION}_amd64.deb && \
	dpkg -i influxdb_${INFLUXDB_VERSION}_amd64.deb
ADD init_influxdb.sh /home/init_influxdb.sh
RUN chmod +x /home/init_influxdb.sh
RUN /home/init_influxdb.sh

# Grafana
ENV GRAFANA_VERSION 4.4.1
RUN apt-get update -qq
RUN apt-get install -qy adduser libfontconfig
RUN cd /tmp && wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-${GRAFANA_VERSION}.linux-x64.tar.gz && \
	tar xzvf grafana-${GRAFANA_VERSION}.linux-x64.tar.gz && cp -r grafana-${GRAFANA_VERSION}/ /opt/grafana/
ADD init_grafana.sh /home/init_grafana.sh
RUN chmod +x /home/init_grafana.sh
RUN /home/init_grafana.sh

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Start Services
RUN mkdir -p /etc/service/influxdb
ADD influxdb.sh /etc/service/influxdb/run
RUN chmod +x /etc/service/influxdb/run

RUN mkdir -p /etc/service/grafana
ADD grafana.sh /etc/service/grafana/run
RUN chmod +x /etc/service/grafana/run
