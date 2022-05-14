[魔改代码开源](https://github.com/ChisBread/transmission_pt_edition)

自行编译各个平台套件, 请看howtobuild文件夹

- p.s. 目前由于Docker Hub限制，导致使用镜像加速器后无法获取最新官方镜像。请暂时去掉加速器配置，直接连接Docker Hub获取。

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
  - [dockerhub](https://hub.docker.com/r/chisbread/transmission); [各平台安装包下载](https://github.com/ChisBread/transmission_pt_edition/releases) 
  - docker: 提供amd64,armv7,arm64的docker镜像，满足大部分平台需求; 兼容linuxserver/transmission, 可直接替换
  - 群晖: 提供DSM6.1~7.0+几乎所有型号架构的spk，提供免重装升级脚本
  - 威联通: (r12版之前)提供qpkg，官方群内有升级教程
  - Windows: (r12版之前)提供Windows版本免安装包，由于稳定性欠佳，仅供体验使用
# 使用256倍速快速校验
- 使用方式: **快速校验默认为开启状态，不需要任何操作 不需要任何操作 不需要任何操作**
- 关闭方式: 点击任务栏"TPE: 已启用", 变成"TPE: 已禁用"则成功关闭
- 注意事项: 不要开启快速校验未完成的种子(比如下载了一半删种重下)!!!

# 简单教程
免重装补丁、docker、安装包的简单教程
## 群晖/威联通套件
- 下载安装包覆盖安装即可
## docker(以群晖为例)
- 支持架构: amd64,armv7,arm64(N1小钢炮、猫盘均可用)
- 特点: 可以使用环境变量配置user, password, rpc-port和peer-port
  - 建议种子超过5000，就使用不同的rpc-port和peer-port启动一个新的容器, 确保WebUI不卡顿
- 其它平台可能需要命令行等方式, 详情见[dockerhub](https://hub.docker.com/repository/docker/chisbread/transmission)
- 默认无账号密码, 安全起见请及时修改

![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/docker_1.png)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/docker_2.png)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/resource/docker_3.png)

# 感谢
- [ronggang/transmission-web-control](https://github.com/ronggang/transmission-web-control)
- [TonyRL/docker-transmission-skip-hash-check](https://github.com/TonyRL/docker-transmission-skip-hash-check)
- [blackyau/Transmission_SkipHashChek](https://github.com/blackyau/Transmission_SkipHashChek/)
- [linuxserver/docker-transmission](https://github.com/linuxserver/docker-transmission)
- [superlukia/transmission-2.92_skiphashcheck](https://github.com/superlukia/transmission-2.92_skiphashcheck)
