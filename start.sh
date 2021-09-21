#!/bin/bash
if [ ! -x "/config/settings.json" ]; then
    _=`mkdir /config`
    cp /settings.json /config/settings.json
fi
transmission-daemon -g /config -e /config/transmission.log -x /var/transmission.pid
sleep 2
tail --pid=`cat /var/transmission.pid` -f /dev/null