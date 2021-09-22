#!/bin/bash
if [ ! -x "/config/settings.json" ]; then
    cp /settings.json /config/settings.json
fi
transmission-daemon -g /config -e /config/transmission.log -x /var/transmission.pid
sleep 2
tail -f /config/transmission.log