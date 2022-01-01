[魔改代码开源](https://github.com/ChisBread/transmission_pt_edition)

[各平台安装包下载](https://github.com/ChisBread/transmission_pt_edition/releases) 

自行编译各个平台套件, 请看howtobuild文件夹

# 免责声明

- **使用修改版客户端可能会导致你的账户被封禁。请务必了解使用修改版客户端带来的风险。**
- 修改版客户端仅供研究学习使用，本人不对使用本项目造成的任何后果负责。

# 介绍

- 快速hash校验
  - 相比跳过校验的优势: 校验文件存在性、校验每个文件的头尾pieces、每N个pieces抽样校验一次, 尽可能保证安全
  - r6版本更新：发现校验不一致则回退到普通校验再校验一次, 进一步增强安全性
  - r7版本更新：对比现有种子的info-hash和file-list, 如果有完全一致的，则取消抽检(超快速)
- 性能/稳定性优化
  - 去除文件数量限制(某些系统下似乎不起作用)
  - 增加随机汇报特性
  - 开启了O3优化, 理论上会更快(暂时未发现奇怪的现象)
- 多平台支持
  - docker: 提供x86_64与armhf的docker镜像，满足大部分平台需求 (**chisbread/transmission:version-3.00-r10 版本支持UID和GID！**)
  - 群晖: 提供DSM6.1~7.0+几乎所有型号架构的spk，提供免重装升级脚本
  - 威联通: 提供qpkg，官方群内有升级教程
  - Windows: 提供Windows版本免安装包，由于稳定性欠佳，仅供体验使用
# 使用256倍速快速校验
- 使用方式: **快速校验默认为开启状态，不需要任何操作 不需要任何操作 不需要任何操作**
- 关闭方式: 选中任意任务, 点击上方工具栏"获取更多peer"开启/关闭全局快速校验
- 注意事项: 不要开启快速校验未完成的种子(比如下载了一半删种重下)!!!
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/switch_1.png)

# 简单教程
免重装补丁、docker、安装包的简单教程
## 群晖免重装补丁

确定群晖为**x86_64架构**, 且TR版本为**Transmission v3.0**, DSM版本为6.2.3或7.0, 按以下教程操作, 重启套件后生效

```bash
wget -O - https://raw.githubusercontent.com/ChisBread/transmission_skip_patch/master/patchspk.sh --no-check-certificate | bash
```

国内用户使用gitee备用链接

```
wget -O - https://gitee.com/chisbread/transmission_skip_patch/raw/master/patchspk.sh --no-check-certificate | bash
```

![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/patch_1.jpg)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/patch_2.jpg)

- 群晖套件WebUI更新命令(带批量单种限速)
使用方法同上
```
 curl -s https://raw.githubusercontent.com/ronggang/transmission-web-control/master/release/install-tr-control-cn.sh | sed 's/VERSION=.*wget.*releases.latest.*/VERSION="master"/g' | bash -s auto >> /tmp/install-tr-control-cn-log.txt 2>&1
```
## docker(以群晖为例)
- 支持架构: x86_64, armhf(猫盘可用)
- 特点: 预装了最新增强版WebUI(支持批量单种限速等功能), 可以使用环境变量配置user, password, rpc-port和peer-port
  - 建议种子超过5000，就使用不同的rpc-port和peer-port启动一个新的容器, 确保WebUI不卡顿
- 其它平台可能需要命令行等方式, 详情见[dockerhub](https://hub.docker.com/repository/docker/chisbread/transmission)
- 默认账号密码均为transmission, 请及时修改
-  (**chisbread/transmission:version-3.00-r10 版本支持UID和GID！**)，从r10开始，USER,PASS改为TR_USER,TR_PASS

![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/docker_1.png)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/docker_2.png)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/docker_3.png)

## 安装包(群晖/威联通/Windows)
- 群晖全系列产品支持, 威联通只支持x86_64架构(注意. 威联通套件的账号密码均为qnap)
- 直接安装对应的套件
  - [各平台安装包下载](https://github.com/ChisBread/transmission_pt_edition/releases) 
  - [群晖CPU架构速查](https://kb.synology.cn/zh-cn/DSM/tutorial/What_kind_of_CPU_does_my_NAS_have)


# 感谢
- [ronggang/transmission-web-control](https://github.com/ronggang/transmission-web-control)
- [TonyRL/docker-transmission-skip-hash-check](https://github.com/TonyRL/docker-transmission-skip-hash-check)
- [blackyau/Transmission_SkipHashChek](https://github.com/blackyau/Transmission_SkipHashChek/)
- [linuxserver/docker-transmission](https://github.com/linuxserver/docker-transmission)
- [superlukia/transmission-2.92_skiphashcheck](https://github.com/superlukia/transmission-2.92_skiphashcheck)
