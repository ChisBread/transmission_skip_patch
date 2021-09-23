#!/bin/bash
if [ $USER != 'root' ];then
    echo '请执行命令:'
    echo '    sudo su'
    echo '以root用户执行本脚本'
    exit 1
fi
TRROOT='/volume1/@appstore/transmission'
for i in $(seq 2 32)
do   
if [ ! -d $TRROOT ]; then
    TRROOT='/volume'$i'/@appstore/transmission'
else
    break
fi
done
if [ ! -d $TRROOT ]; then
  echo '找不到transmission安装路径'
  exit 1
fi
echo '找到目标路径: '$TRROOT
SPK_D=''
_=`uname -a |grep '4.4.59+'`
if [ $? -eq 0 ]; then
    echo '系统为DSM6.x'
    SPK_D='https://github.com/ChisBread/transmission_skip_patch/raw/master/spks/transmission_x64-6.2.3_3.00-19.spk'  
else
    echo '系统为DSM7.0'
    SPK_D='https://github.com/ChisBread/transmission_skip_patch/raw/master/spks/transmission_x64-7.0_3.00-19.spk'
fi
mkdir -p /tmp/transmission_skip_patch
cd /tmp/transmission_skip_patch
wget --no-check-certificate ${SPK_D} -O tr.spk && tar xf tr.spk && tar xf package.tgz
chown sc-transmission:transmission bin/transmission-daemon && chmod 777 bin/transmission-daemon

cp ${TRROOT}/bin/transmission-daemon ${TRROOT}/bin/transmission-daemon.bak
echo '备份至:'${TRROOT}'/bin/transmission-daemon.bak'
mv bin/transmission-daemon ${TRROOT}/bin/
echo '成功打上补丁,重启transmission即可'
