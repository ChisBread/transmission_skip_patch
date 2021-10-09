[魔改代码开源](https://github.com/ChisBread/transmission_pt_edition)

# 免责声明

- **使用修改版客户端可能会导致你的账户被封禁。请务必了解使用修改版客户端带来的风险。**
- 修改版客户端仅供研究学习使用，本人不对使用本项目造成的任何后果负责。

# 介绍

- 通过魔改transmission代码实现的快速hash校验;
  - 相比跳过校验的优势: 校验文件存在性、校验每个文件的头尾pieces、每N个pieces抽样校验一次, 尽可能保证安全
  - r6版本更新：发现校验不一致则回退到普通校验再校验一次, 进一步增强安全性
  - r7版本更新：对比现有种子的info-hash和file-list, 如果有完全一致的，则取消抽检(超快速)
- 去除文件数量限制
- 增加随机汇报特性
- 开启了O3优化, 理论上会更快(暂时未发现奇怪的现象)
- 提供docker、群晖spk以及免重装升级脚本

# 使用256倍速快速校验
- 注意事项: 不要开启快速校验未完成的种子(比如下载了一半删种重下)!!!
- 使用方式: **快速校验默认为开启状态**
- 关闭方式: 选中任意任务, 点击上方工具栏"获取更多peer"开启/关闭全局快速校验
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/switch_1.png)

# 安装方式
[各平台安装包下载](https://github.com/ChisBread/transmission_pt_edition/releases)

## 群晖docker
- 特点: 预装了最新增强版WebUI(支持批量单种限速等功能), 可以使用环境变量配置user, password, rpc-port和peer-port
  - 建议种子超过5000，就使用不同的rpc-port和peer-port启动一个新的容器, 确保WebUI不卡顿
- 其它平台可能需要命令行等方式, 详情见[链接](https://hub.docker.com/repository/docker/chisbread/transmission)
- 默认账号密码均为transmission, 请及时修改

![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/docker_1.png)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/docker_2.png)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/docker_3.png)

## 群晖套件

- 直接安装对应的套件

| - | DSM6.2.3 | DSM7.0 | 备注 |
| :--------  | :-----  | :----  | :----:  |
| x86_64 | ✓ | ✓ | 已测试 |
| ARMv5(88f6281) | ✓ | - | 未测试 |
| ARMv7 | - | ✓ | 未测试 |

- 免重装补丁

确定群晖为**x86架构**, 且版本为**Transmission v3.0**, 按以下教程操作, 重启套件后生效

```bash
wget -O - https://raw.githubusercontent.com/ChisBread/transmission_skip_patch/master/patchspk.sh | bash
```

国内用户使用gitee备用链接

```
wget -O - https://gitee.com/chisbread/transmission_skip_patch/raw/master/patchspk.sh | bash
```

![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/patch_1.jpg)
![image](https://github.com/ChisBread/transmission_skip_patch/raw/master/%20resource/patch_2.jpg)

- 群晖套件WebUI更新命令(带批量单种限速)
使用方法同上
```
 curl -s https://raw.githubusercontent.com/ronggang/transmission-web-control/master/release/install-tr-control-cn.sh | sed 's/VERSION=.*wget.*releases.latest.*/VERSION="master"/g' | bash -s auto >> /tmp/install-tr-control-cn-log.txt 2>&1
```
## 感谢
- [ronggang/transmission-web-control](https://github.com/ronggang/transmission-web-control)
- [TonyRL/docker-transmission-skip-hash-check](https://github.com/TonyRL/docker-transmission-skip-hash-check)
- [blackyau/Transmission_SkipHashChek](https://github.com/blackyau/Transmission_SkipHashChek/)
- [linuxserver/docker-transmission](https://github.com/linuxserver/docker-transmission)
- [superlukia/transmission-2.92_skiphashcheck](https://github.com/superlukia/transmission-2.92_skiphashcheck)
