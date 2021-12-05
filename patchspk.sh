#!/bin/bash
if [ $USER != 'root' ];then
    echo '请执行命令:'
    echo '    sudo su'
    echo '以root用户执行本脚本'
    exit 1
fi
TRROOT='/var/packages/transmission/target'

if [ ! -d $TRROOT ]; then
  echo '找不到transmission安装路径'
  exit 1
fi
echo '找到目标路径: '$TRROOT
SPK_D=''
_=`uname -a |grep '4.4.59+'`
if [ $? -eq 0 ]; then
    echo '系统为DSM6.x'
    SPK_D='transmission_skip_patch-master/spks/transmission_x64-6.2.3_3.00-19.spk'  
else
    echo '系统为DSM7.0'
    SPK_D='transmission_skip_patch-master/spks/transmission_x64-7.0_3.00-19.spk'
fi
rm -rf /tmp/transmission_skip_patch
mkdir -p /tmp/transmission_skip_patch
cd /tmp/transmission_skip_patch
wget https://github.com/ChisBread/transmission_skip_patch/archive/refs/heads/master.tar.gz --no-check-certificate && tar zxf master.tar.gz
mv ${SPK_D} tr.spk && tar xf tr.spk && tar xf package.tgz
if [ ! -x "bin/transmission-daemon" ]; then
    echo 'bin/transmission-daemon 不存在,请检查网络是否能访问github'
    exit 1
else
    TR_USER=`ls -l /var/packages/transmission/target/bin/transmission-daemon|awk '{print $3":"$4}'`
    chown $TR_USER bin/transmission-daemon && chmod 777 bin/transmission-daemon
    cp ${TRROOT}/bin/transmission-daemon ${TRROOT}/bin/transmission-daemon.bak
    chown $TR_USER ${TRROOT}/bin/transmission-daemon.bak
    echo '备份至:'${TRROOT}'/bin/transmission-daemon.bak'
    mv bin/transmission-daemon ${TRROOT}/bin/
    echo '成功打上补丁,重启transmission即可'
fi
