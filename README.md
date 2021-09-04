# 介绍
通过魔改transmission代码实现的跳过hash校验
请确认满足以下使用条件
- 群晖6.2.3
- transmission为SynologyCommunity套件v3.0版
# 使用方式
ssh 到群晖
安装补丁
```
sudo su
git clone https://github.com/ChisBread/transmission_skip_patch
cd transmission_skip_patch && sh install.sh
```
跳过验证: 选中校验中的任务, 点击"获取更多peer"跳过校验