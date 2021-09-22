#!/bin/bash
wget --no-check-certificate https://github.com/ronggang/transmission-web-control/raw/master/release/install-tr-control-cn.sh -O /install-tr-control-cn.sh
/usr/bin/expect <<-EOF
set time 30
spawn bash /install-tr-control-cn.sh /user/share/transmission/
expect {
"*:" { send "1\r"; }
}
expect eof
EOF