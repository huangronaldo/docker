# Zabbix 监控企业实战
## zabbix 入门简介
  Zabbix 是一个基于web界面的提供分布式监控的企业级开源解决方案，zabbix能监控各种网络参数，保证服务器系统安全稳定运行，并提供灵活的通知机制以让SA快速定位并解决存在的各种问题。zabbix分布式监控系统优点如下：
  * 支持自动发现服务器和网络设备
  * 支持底层自动发现
  * 分布式的监控体系和集中的web管理
  * 支持主动监控和被动监控模式
  * 服务器端支持多种操作系统：Linux，Solari，hp-ux，aix，FreeBSD，OpenBSD，MAC等
  * agent客户端支持多种操作系统：Linux，Solari，hp-ux，aix，FreeBSD，OpenBSD，Windows等
  * 基于SNMP/IPMI接口，zabbix agent方式监控客户端
  * 安全的用户认证及权限配置
  * 基于web的管理方式，支持自由的自定义事件和右键发送
  * 高水平的业务视图监控资源，支持日志审计/资产管理等功能
  * 支持高水平API二次开发/脚本监控，自定义key定义，自动化运维整合调用

## zabbix 监控组件和流程
  zabbix监控组件主要由三大部分组成：zabbix server端、zabbix proxy、agent客户端，其中zabbix server端包含web gui、database、zabbix server。
 

  
## 安装zabbix（docker-compose方式）
> 官方docker安装文档：https://github.com/zabbix/zabbix-docker

* 下载 docker-compose.yml 与 环境配置信息文件
* 执行安装命令`docker-compose up -d`
* 登录http://127.0.0.1:8081/ ，默认账号密码：Admin/zabbix
