#!/bin/sh
CONF=/etc/config/qpkg.conf
QPKG_NAME="TransmissionPT3"
QPKG_ROOT=`/sbin/getcfg $QPKG_NAME Install_Path -f ${CONF}`
export QNAP_QPKG=$QPKG_NAME
export QPKG_ROOT QPKG_NAME


export HOME=$QPKG_ROOT


export SHELL=/bin/sh
export LC_ALL=en_US.UTF-8
export USER=admin
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export PIDF=/var/run/transmissionbt.pid
killall -9 transmission-daemon

case "$1" in
  start)
    ENABLED=$(/sbin/getcfg $QPKG_NAME Enable -u -d FALSE -f $CONF)
    if [ "$ENABLED" != "TRUE" ]; then
        echo "$QPKG_NAME is disabled."
        exit 1
    fi

/bin/ln -sf $QPKG_ROOT /opt/$QPKG_NAME
export LD_LIBRARY_PATH=$QPKG_ROOT/lib:$LD_LIBRARY_PATH
export TRANSMISSION_WEB_HOME=$QPKG_ROOT/share/transmission/web
export CURL_CA_BUNDLE=$QPKG_ROOT/etc/ssl/certs/ca-certificates.crt
cd $QPKG_ROOT/bin
ldd ./transmission-daemon > $QPKG_ROOT/etc/transmission.log
./transmission-daemon -g $QPKG_ROOT/etc -e $QPKG_ROOT/etc/transmission.log -x /var/run/transmission.pid -f &
echo $! > $PIDF



    ;;

  stop)
    

ID=$(more /var/run/transmissionbt.pid)

        if [ -e $PIDF ]; then
            kill -9 $ID
            rm -f $PIDF
        fi

killall -9 transmission-daemon

rm -rf /opt/$QPKG_NAME  


    ;;

  restart)
    $0 stop
    $0 start
    ;;

  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac

exit 0
