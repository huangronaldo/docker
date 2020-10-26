# docker-compose模拟部署keepalived + haproxy + nginx

## docker-compose
1. keepalived + nginx（一主一备 共2台） 
2. haproxy（1台）

# 配置文件详解

* nginx 配置文件查看上级目录nginx
* keepalived配置文件
```
global_defs { # 全局定义，这里关于邮箱的都删掉了现在用不到
   smtp_connect_timeout 30 # 连接超时时间
   router_id LVS_01  # 名称，两个服务器不能一样
}
vrrp_script chk_nginx {
    script "pidof nginx" # 检测nginx是否存活
    interval 2 # 2秒
}

vrrp_instance VI_1 {
    state MASTER # 定义为主服务器
    interface eth0 # 承载漂移ip的网卡
    virtual_router_id 33 # 定义一个热备组，可以认为这是33号热备组
    priority 200 # 主服务器优先级要比备服务器高
    advert_int 1 # 1秒互相通告一次，检查对方存活
    unicast_src_ip 172.20.128.2 # 本机IP
    unicast_peer {
        172.20.128.3 # 单播IP
    }
    
    authentication {
        auth_type PASS # 认证类型
        auth_pass letmein # 认证密码
    }
    
    virtual_ipaddress {
        172.20.128.4/24 dev eth0 # 漂移IP和网卡
    }

    track_script { # 检查脚本
        chk_nginx
    }
}
```

* haproxy.cfg配置
```
global
    log 127.0.0.1 local0 # 本机日志级别
    maxconn 4096 # 最大并发连接数
    daemon # 以守护进程的方式运行
    nbproc 4

defaults
    log 127.0.0.1 local3 # 表示用global模块中定义的日志配置
    mode http # http模式
    option dontlognull # 保证HAProxy不记录上级负载均衡发送过来的用于检测状态没有数据的心跳包
    option redispatch
    retries 2
    maxconn 2000
    balance roundrobin
    timeout connect 5000ms
    timeout client 5000ms
    timeout server 5000ms

frontend main
    bind *:6301  # 监听本服务器
    default_backend webserver

backend webserver
    balance roundrobin # 轮询
    server ngxin_master 172.20.128.4:80 check inter 2000 rise 2 fall 5
```
