FROM hamphh/unraidbase:latest

EXPOSE 80

RUN apt-get update -qq

# Install apache2
RUN apt-get install -qy apache2 apache2-utils
RUN chown nobody:users /var/www/html/ -R
ADD nextcloud.conf /etc/apache2/sites-available/nextcloud.conf
RUN ln -s /etc/apache2/sites-available/nextcloud.conf /etc/apache2/sites-enabled/nextcloud.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD pre_init_apache2.sh /home/pre_init_apache2.sh
RUN chmod +x /home/pre_init_apache2.sh
RUN /home/pre_init_apache2.sh

# Install php7
RUN apt-get install -qy php7.0-fpm php7.0-mysql php7.0-common php7.0-gd php7.0-json php7.0-cli \
	php7.0-curl libapache2-mod-php7.0 php7.0-zip php7.0-xml php7.0-mbstring
# Enable the Apache modules
RUN a2enmod php7.0 && a2enmod rewrite && a2enmod headers && a2enmod env && a2enmod dir && \
	a2enmod mime && a2enmod setenvif && a2enmod ssl

# Install nextcloud
ENV NC_VERSION 12.0.0
RUN apt-get install -qy smbclient rsync
RUN cd /tmp && wget -q https://download.nextcloud.com/server/releases/nextcloud-${NC_VERSION}.zip && \
	unzip nextcloud-${NC_VERSION}.zip && cp -r nextcloud /opt/ && ln -s /data/app/ /var/www/nextcloud

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Start apache2 when container starts
RUN mkdir -p /etc/service/apache2
ADD apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run
