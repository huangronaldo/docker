# Zabbix 监控企业实战
## Zabbix 入门简介
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

## Zabbix 监控组件和流程
  Zabbix监控组件主要由三大部分组成：zabbix server端、zabbix proxy、agent客户端，其中zabbix server端包含web gui、database、zabbix server。

## Zabbix 监控概念
  * 主机（host）：被监控的网络设备，可以写IP或者DNS
  * 主机组（host group）：主机组用于管理主机，可以批量设置权限
  * 监控项（item）：具体监控想，items值由独立的keys进行识别
  * 触发器（trigger）：为某个items设置触发器，达到触发器会执行action动作
  * 事件（event）：例如达到某个触发器，称之为一个事件
  * 动作（action）：对于特定事件事先定义的处理方法，默认可以发送信息以及发送命令
  * 报警升级（escalation）：发送警报或执行远程命令的自定义方案，如隔5min发送一次警报，共发送5次
  * 媒介（media）：发送通知等方式，可以支持mail / sms / scripts等
  * 通知（notification）：通过设置的媒介向用户发送的有关某事件的信息
  * 远程命令（remote command）：达到触发器，可以在被监控端执行命令
  * 模板（template）：可以快速监控被监控端，模块包含item、trigger、graph、screen、application
  * Web场景（Web scenario）：用于检测web站点可用性，监控HTTP关键词
  * Web签订（frontend）：zabbix 的web接口
  * 图形（graph）：监控图像
  * 屏幕（screens）：屏幕显示
  * 幻灯（slide show）：幻灯显示
  
  
## 安装zabbix（docker-compose方式）
> Zabbix监控平台部署，至少需要安装4个组件：zabbix server、zabbix web、databases、zabbix agent。

> 官方docker安装文档：https://github.com/zabbix/zabbix-docker

* 下载 docker-compose.yml 与 环境配置信息文件
* 执行安装命令`docker-compose up -d`
* 登录http://127.0.0.1:8081/ ，默认账号密码：Admin/zabbix

## Zabbix 配置文件详解
  Zabbix监控系统组件分为server / proxy / agentd 端，对各组件的参数进行详细了解，能够更加深入理解 Zabbix 监控功能以及对 Zabbix 进行调优，3个组件的常用参数详情如下：
  * zabbix_server.conf 配置文件参数详解如下：
    * DBHost：数据库主机地址
    * DBName：数据库名称
    * DBUser：数据库用户
    * DBPassword：数据库密码
    * DBPort：数据库端口
    * AlertScriptsPath：告警脚本存放路径
    * CacheSize：存储监控数据的缓存
    * CacheUpdateFrequency：更新一次缓存时间
    * DebugLevel：日志级别
    * LogFile：日志文件
    * LogFileSize：日志文件大小，超过自动切割
    * LogSlowQueries：数据库慢查询记录，单位为ms
    * PidFile：PID文件
    * ProxyConfigFrequency：proxy被动模式下，server用多少秒同步配置文件至proxy
    * ProxyDataFrequency：被动模式下，server间隔多少秒向proxy请求历史数据
    * StartDiscoverers：发现规则线程数
    * Timeout：连接超时时间
    * TrendCacheSize：历史数据缓存大小
    * User：Zabbix 运行的用户
    * HistoryCacheSize：历史记录缓存大小
    * ListenIP：监听本机的IP地址
    * ListenPort：监听端口
    * LoadModule：模块名称
    * LoadModulePath：模块路径
  * zabbix_proxy.conf 配置文件参数详解如下：
    * ProxyMode：proxy工作模式，默认为主动模式，主动发送数据至server
    * Server：指定Server端地址
    * ServerPort：server端端口
    * Hostname：proxy代理端
    * DBHost：数据库主机地址
    * DBName：数据库名称
    * DBUser：数据库用户
    * DBPassword：数据库密码
    * DBPort：数据库端口
    * DBSocket：proxy数据库socket路径
    * DataSenderFrequency：proxy向server发送数据的时间间隔
    * StartPollers：proxy线程池数量
    * StartDiscoverers：发现规则线程数
    * CacheSize：内存缓存配置
    * StartDBSyncers：同步数据线程数
    * HistoryCacheSize：历史数据缓存大小
    * LogSlowQueries：慢查询日志记录，单位为ms
    * Timeout：连接超时时间
  * zabbix_agentd.conf 配置文件参数详解如下：
    * EnableRemoteCommands：运行服务器端远程至客户端执行命令或者脚本
    * Hostname：客户端主机名
    * ListenIP：监听的IP地址
    * ListenPort：客户端监听端口
    * LoadModulePath：模块路径
    * LogFile：日志文件路径
    * PidFile：PID文件
    * Server：指定server IP地址
    * ServerActive： zabbix主动监控server IP地址
    * StartAgents：agent启动进程，如果为0，表示禁用被动监控
    * Timeout：超时时间
    * User：运行zabbix的用户
    * UserParameter：用户自定义key
    * BufferSize：缓冲区大小
    * DebugLevel：日志级别
  
    
    

