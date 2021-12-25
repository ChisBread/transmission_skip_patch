#!/bin/bash
#清理
_term() {
  echo "Caught SIGTERM signal!"
  echo "Tell the transmission session to shut down."
  pid=`cat /var/transmission.pid`
  if [ ! -z "$TR_USER" ] && [ ! -z "$TR_PASS" ]; then
    /usr/bin/transmission-remote $RPCPORT -n "$TR_USER":"$TR_PASS" --exit
  else
    /usr/bin/transmission-remote $RPCPORT --exit
  fi
  # terminate when the transmission-daemon process dies
  tail --pid=${pid} -f /dev/null
}
#以abc用户执行此脚本
if [ ! -z "$UID" ] && [ ! -z "$GID" ] && ( [ "$USER" != "abc" ] || [ `id -u $USER` != "$UID" ] || [ `id -g $USER` != "$GID" ] ); then
  if id -u abc >/dev/null 2>&1 ; then
      groupmod -o -g $GID abc
      usermod -o -u $UID -g abc abc
  else
      groupadd -o -g $GID abc  
      useradd -o -u $UID -g abc abc
  fi
  : >/var/transmission.pid
  chown abc:abc /var/transmission.pid
  trap _term SIGTERM SIGINT
  su abc -c "USER=abc /start.sh"
  exit
fi
######abc 执行######
#初始化
if [ ! -f "/config/settings.json" ]; then
    cp /settings.json /config/settings.json
fi
if [ ! -f "/usr/share/transmission/web/index.html" ]; then
    mv /usr/share/transmission/web/transmission-web-control-master/src/* /usr/share/transmission/web/
fi
#用户
echo "TR_URSER=$TR_USER,TR_PASS=$TR_PASS"
if [ ! -z "$TR_USER" ] && [ ! -z "$TR_PASS" ]; then
	sed -i '/rpc-authentication-required/c\    "rpc-authentication-required": true,' /config/settings.json
	sed -i "/rpc-username/c\    \"rpc-username\": \"$TR_USER\"," /config/settings.json
	sed -i "/rpc-password/c\    \"rpc-password\": \"$TR_PASS\"," /config/settings.json
else
	sed -i '/rpc-authentication-required/c\    "rpc-authentication-required": false,' /config/settings.json
	sed -i "/rpc-username/c\    \"rpc-username\": \"$TR_USER\"," /config/settings.json
	sed -i "/rpc-password/c\    \"rpc-password\": \"$TR_PASS\"," /config/settings.json
fi
#端口
echo "RPCPORT=$RPCPORT,PEERPORT=$PEERPORT"
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
