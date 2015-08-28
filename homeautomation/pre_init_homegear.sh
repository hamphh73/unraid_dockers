#!/bin/bash

mkdir /etc/homegear

cd /tmp/homegear-${HOMEGEAR_VERSION}
cp Miscellaneous/*.conf /etc/homegear
cp Miscellaneous/homegear.limits /etc/security/limits.d/homegear
cp Miscellaneous/logrotate /etc/logrotate.d/homegear
chmod +x Miscellaneous/GetDeviceFiles.sh
sync
mkdir -p /var/lib/homegear/modules
cp -R Miscellaneous/firmwareDir/ /var/lib/homegear/firmware
chmod -R 750 /var/lib/homegear

# Update firmware-Data
Miscellaneous/GetDeviceFiles.sh
sed -i.bak "s/homegear:homegear/root:root/" /var/lib/homegear/firmware/GetFirmwareUpdates.sh
rm /var/lib/homegear/firmware/GetFirmwareUpdates.sh.bak
/var/lib/homegear/firmware/GetFirmwareUpdates.sh
cp -R Miscellaneous/Device\ Description\ Files/INSTEON/ /etc/homegear/devices/2
cp -R Miscellaneous/Device\ Description\ Files/MAX/ /etc/homegear/devices/4
cp -R Miscellaneous/Device\ Description\ Files/Philips\ hue/ /etc/homegear/devices/5

# Setup script-dir
mkdir /var/lib/homegear/scripts
cd /var/lib/homegear/scripts
wget http://homegear.eu/downloads/Homegear_PHP_XMLRPC_Client.zip
unzip Homegear_PHP_XMLRPC_Client.zip
rm Homegear_PHP_XMLRPC_Client.zip

# Generate certificates for SSL connections
openssl genrsa -out /etc/homegear/homegear.key 2048
openssl req -batch -new -key /etc/homegear/homegear.key -out /etc/homegear/homegear.csr
openssl x509 -req -in /etc/homegear/homegear.csr -signkey /etc/homegear/homegear.key -out /etc/homegear/homegear.crt
rm /etc/homegear/homegear.csr
chmod 400 /etc/homegear/homegear.key
openssl dhparam -check -text -5 1024 -out /etc/homegear/dh1024.pem
chmod 400 /etc/homegear/dh1024.pem

# Install homegear
cd /tmp/homegear-${HOMEGEAR_VERSION}
cp bin/Release/homegear /usr/bin
chmod 755 /usr/bin/homegear
cp lib/Modules/Release/libhomematicbidcos.so /var/lib/homegear/modules/mod_homematicbidcos.so
cp lib/Modules/Release/libhomematicwired.so /var/lib/homegear/modules/mod_homematicwired.so
cp lib/Modules/Release/libmax.so /var/lib/homegear/modules/mod_max.so
cp lib/Modules/Release/libinsteon.so /var/lib/homegear/modules/mod_insteon.so
cp lib/Modules/Release/libphilipshue.so /var/lib/homegear/modules/mod_philipshue.so

# customize main.conf
cd /etc/homegear
sed -i.bak "s:databasePath = .*:databasePath = /data/homegear/data/db.sql:" main.conf
sed -i.bak "s:logfilePath = .*:logfilePath = /logs/homegear:" main.conf
sed -i.bak "s:clientSettingsPath = .*:clientSettingsPath = /data/homegear/config/rpcclients.conf:" main.conf
sed -i.bak "s:serverSettingsPath = .*:serverSettingsPath = /data/homegear/config/rpcservers.conf:" main.conf
sed -i.bak "s:physicalInterfaceSettingsPath = .*:physicalInterfaceSettingsPath = /data/homegear/config/physicalinterfaces.conf:" main.conf
sed -i.bak "s:scriptPath = .*:scriptPath = /data/homegear/data/scripts:" main.conf
rm main.conf.bak