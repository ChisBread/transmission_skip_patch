#!/bin/bash
if [ ! -x "/config/settings.json" ]; then
    cp /settings.json /config/settings.json
fi
if [ ! -x "/usr/share/transmission/web/index.html" ]; then
    mv /usr/share/transmission/web/transmission-web-control-master/src/* /usr/share/transmission/web/
fi
transmission-daemon -g /config -e /config/transmission.log -x /var/transmission.pid
sleep 2
tail -f /config/transmission.log