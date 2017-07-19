FROM hamphh/unraidbase:latest

EXPOSE 3306

# Install mariadb
RUN apt-get update -qq
RUN apt-get install -qy mariadb-server mariadb-client
RUN mv /etc/mysql/my.cnf /etc/mysql/my.cnf.org
ADD my.etc.cnf /etc/mysql/my.cnf
RUN chown nobody:users /etc/mysql/my.cnf && chmod 644 /etc/mysql/my.cnf
ADD my.conf.cnf /home/my.cnf

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Start mariadb when container starts
RUN mkdir -p /etc/service/mariadb
ADD mariadb.sh /etc/service/mariadb/run
RUN chmod +x /etc/service/mariadb/run
