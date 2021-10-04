#!/bin/bash
#清理
_term() {
  echo "Caught SIGTERM signal!"
  echo "Tell the transmission session to shut down."
  pid=`cat /var/transmission.pid`
  if [ ! -z "$USER" ] && [ ! -z "$PASS" ]; then
    /usr/bin/transmission-remote $RPCPORT -n "$USER":"$PASS" --exit
  else
    /usr/bin/transmission-remote $RPCPORT --exit
  fi
  # terminate when the transmission-daemon process dies
  tail --pid=${pid} -f /dev/null
}
trap _term SIGTERM
#初始化
if [ ! -f "/config/settings.json" ]; then
    cp /settings.json /config/settings.json
fi
if [ ! -f "/usr/share/transmission/web/index.html" ]; then
    mv /usr/share/transmission/web/transmission-web-control-master/src/* /usr/share/transmission/web/
fi
#用户
if [ ! -z "$USER" ] && [ ! -z "$PASS" ]; then
	sed -i '/rpc-authentication-required/c\    "rpc-authentication-required": true,' /config/settings.json
	sed -i "/rpc-username/c\    \"rpc-username\": \"$USER\"," /config/settings.json
	sed -i "/rpc-password/c\    \"rpc-password\": \"$PASS\"," /config/settings.json
else
	sed -i '/rpc-authentication-required/c\    "rpc-authentication-required": false,' /config/settings.json
	sed -i "/rpc-username/c\    \"rpc-username\": \"$USER\"," /config/settings.json
	sed -i "/rpc-password/c\    \"rpc-password\": \"$PASS\"," /config/settings.json
fi
#端口
if [ ! -z "$RPCPORT" ]; then
	sed -i "/rpc-port/c\    \"rpc-port\": $RPCPORT," /config/settings.json
fi
if [ ! -z "$PEERPORT" ] ; then
	sed -i "/peer-port/c\    \"peer-port\": $PEERPORT," /config/settings.json
fi
: >/config/transmission.log
tail -f /config/transmission.log &
transmission-daemon -g /config -c /watch -e /config/transmission.log -x /var/transmission.pid -f &
wait
