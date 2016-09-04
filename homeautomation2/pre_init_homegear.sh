#!/bin/bash

# move sec-Data
mkdir -p /etc/homegear.sec
mv /etc/homegear/homegear.key /etc/homegear.sec/
mv /etc/homegear/dh1024.pem /etc/homegear.sec/

# link etc/homegear to data
mv /etc/homegear /etc/homegear.org
ln -s /data/homegear/conf/ /etc/homegear

# customize main.conf
cd /etc/homegear.org

#sed -i.bak "s:# runAsUser = .*:runAsUser = nobody:" main.conf
#sed -i.bak "s:# runAsGroup = .*:runAsGroup = users:" main.conf
sed -i.bak "s:keyPath = /etc/homegear/homegear.key:keyPath = /etc/homegear.sec/homegear.key:" main.conf
sed -i.bak "s:dhParamPath = /etc/homegear/dh1024.pem:dhParamPath = /etc/homegear.sec/dh1024.pem:" main.conf
sed -i.bak "s:workingDirectory = .*:workingDirectory = /data/homegear/work:" main.conf
sed -i.bak "s:socketPath = .*:socketPath = /data/homegear/work:" main.conf
sed -i.bak "s:dataPath = .*:dataPath = /data/homegear/data:" main.conf
sed -i.bak "s:# dataPathPermissions = .*:dataPathPermissions = 775:" main.conf
sed -i.bak "s:logfilePath = .*:logfilePath = /logs/homegear:" main.conf
sed -i.bak "s:scriptPath = .*:scriptPath = /data/homegear/scripts:" main.conf
sed -i.bak "s:# scriptPathPermissions = .*:scriptPathPermissions = 775:" main.conf
sed -i.bak "s:tempPath = .*:tempPath = /data/homegear/work:" main.conf

rm main.conf.bak

#update firmware
cd /usr/share/homegear/firmware/
exec ./GetFirmwareUpdatesHomeMaticBidCoS.sh
