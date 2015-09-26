#!/bin/bash

umask 000

if [ ! -d "/data/music/" ]; then
  mkdir /data/music
  chmod a+wx /data/music
fi

if [ ! -f "/data/get_local.list.template" ]; then
  cp /home/get_local.list.template /data/get_local.list.template
  chmod a+w /data/get_local.list.template
fi

cp /data/spotify_appkey.key /home/spori/
cp -n /home/init.sh /data/init.sh
chmod a+w /data/init.sh

. /data/init.sh

if [ -f "/data/get_local.list" ]; then
	rm -f /logs/local_music.log
	while read url; do
		if [ $url ]; then
			/home/spori/jbripper.py -d -u $user -p $pwd -U $url -O /data/music -I >> /logs/local_music.log
		fi
	done </data/get_local.list
	
	mv /data/get_local.list /data/get_local.list.old
fi
