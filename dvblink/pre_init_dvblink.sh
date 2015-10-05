#!/bin/bash

for dir in channel_files common database licenses temp transponders xmltv; do
	if [ -d "/opt/DVBLink/$dir/" ]; then
		mv /opt/DVBLink/$dir /opt/DVBLink/$dir.org
	fi
	ln -s /data/$dir/ /opt/DVBLink/$dir
done

rm -rf /opt/DVBLink/RecordedTV/
ln -s /recordings/ /opt/DVBLink/RecordedTV

mv /usr/local/bin/dvblink/config /usr/local/bin/dvblink/config.org
ln -s /data/config/ /usr/local/bin/dvblink/config

for logfile in dvblink_reg.log dvblink_server.log dvblink_webserver.log; do
	rm -f /usr/local/bin/dvblink/$logfile
	ln -s /logs/dvblink/$logfile /usr/local/bin/dvblink/$logfile
done
