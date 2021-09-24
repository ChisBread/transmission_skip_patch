[魔改代码开源](https://github.com/ChisBread/transmission_pt_edition)
# 声明
- 本项目为个人测试使用，不对使用中遇到的任何问题负责
- 安全性: 在IYUU辅种,或者多站发种时使用,安全性最高
# 介绍
- 通过魔改transmission代码实现的快速hash校验; 
    - 相比跳过校验的优势: 校验文件存在性、校验种子文件的头尾pieces、每N个pieces抽样校验一次, 尽可能保证安全
- 去除文件数量限制
- 增加随机汇报特性
# 使用快速校验
- 256倍速
- 使用方式: 选中任意任务, 点击上方工具栏"获取更多peer"开启/关闭全局快速校验
# 安装方式
## docker安装
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/docker_1.png)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/docker_2.png)
详情见[链接](https://hub.docker.com/repository/docker/chisbread/transmission)
## 群晖套件
- 1.重装: 直接安装对应的套件
    - 系统: 支持DSM6.x, DSM7.0
    - 架构: 支持x86_64, ARMv7(未测试)
- 2.免重装: 确定群晖为x86架构, 且Transmission版本为v3.0, 按以下教程操作, 重启套件后生效
- 复制以下命令
```bash
wget -O - https://raw.githubusercontent.com/ChisBread/transmission_skip_patch/master/patchspk.sh | bash
```
- gitee备用链接（国内用户使用）
```
wget -O - https://gitee.com/chisbread/transmission_skip_patch/raw/master/patchspk.sh | bash
```
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/patch_1.jpg)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/patch_2.jpg)

## 感谢
[TonyRL/docker-transmission-skip-hash-check](https://github.com/TonyRL/docker-transmission-skip-hash-check)
[blackyau/Transmission_SkipHashChek](https://github.com/blackyau/Transmission_SkipHashChek/)
[linuxserver/docker-transmission](https://github.com/linuxserver/docker-transmission)
[superlukia/transmission-2.92_skiphashcheck](https://github.com/superlukia/transmission-2.92_skiphashcheck)