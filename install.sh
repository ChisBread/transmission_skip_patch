#!/bin/bash
/var/packages/transmission/target/bin/transmission-daemon -V 2>&1|grep 'transmission-daemon 3.00 (bb6b5a062e)'
if [ $? -ne 0 ]; then
    echo 'transmission 版本必须为3.0 (SynologyCommunity版)'
    exit 1
else
    echo '该版本可以打补丁'
fi
patch_bin(){
    mkdir -p /tmp/trans_patch/
    cp $1/bin.tar /tmp/trans_patch/
    cd /tmp/trans_patch/ && tar xvf bin.tar
    chmod 777 bin/*
    chown sc-transmission:transmission bin/*
    echo '备份 /var/packages/transmission/target/bin --->>> /var/packages/transmission/target/bin.bak'
    cp -r /var/packages/transmission/target/bin /var/packages/transmission/target/bin.bak
    echo '打补丁...'
    cp bin/* /var/packages/transmission/target/bin/
    if [ $? -ne 0 ]; then
        echo '请停止transmission套件后重试'
        exit 1
    fi
    echo '打补丁成功! 使用方法: 选中校验中的任务, 点击"获取更多peer"跳过校验'
}
uname -a|grep 'x86_64'
if [ $? -eq 0 ]; then
    patch_bin 'v3.0_x64'
else
    echo '尚未支持该架构'
    exit 1
fi