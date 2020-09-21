## docker-compose部署mariadb主从复制模式
### docker-compose
> 主库：数据目录（包含日志）：/app/mariadb/mm01/，配置文件：/app/mariadb/mm01/my.cnf，开放端口：3306

> 从库：数据目录（包含日志）：/app/mariadb/ms01/，配置文件：/app/mariadb/ms01/my.cnf，开放端口：3307

```
version: '3'

services:
  mariadb01:
    image: mariadb:10.4.13
    container_name: mm01
    restart: always
    environment:
      TZ: Asia/Shanghai
      MYSQL_ROOT_PASSWORD: '12345678'
    ports:
      - "3306:3306"
    networks:
      - mariadb
    volumes:
      - /app/mariadb/mm01/datadir:/var/lib/mysql
      - /app/mariadb/mm01/my.cnf:/etc/mysql/my.cnf

  mariadb02:
    image: mariadb:10.4.13
    container_name: ms01
    restart: always
    environment:
      TZ: Asia/Shanghai
      MYSQL_ROOT_PASSWORD: '12345678'
    ports:
      - "3307:3306"
    networks:
      - mariadb
    volumes:
      - /app/mariadb/ms01/datadir:/var/lib/mysql
      - /app/mariadb/ms01/my.cnf:/etc/mysql/my.cnf        

networks:
  mariadb:
    driver: bridge        
```

### 配置my.cnf
> 详细配置查看目录下文件

* 开启拆分表数据存储
```
# [mysqld] 在mysqld下修改
# 开启拆分表数据存储
innodb_file_per_table	= 1
# 开启skip_name_resolve
skip_name_resolve = ON
```
* 开启binlog
```
# [mysqld] 在mysqld下修改
log_bin			= /var/lib/mysql/binlog/mariadb-bin
log_bin_index		= /var/lib/mysql/binlog/mariadb-bin.index
expire_logs_days	= 10
max_binlog_size         = 100M
```

* 修改server-id
```
# 集群下不能相同
server-id =1 
```
* 从库增加如下配置
```
# [mysqld] 在mysqld下修改
# slaves
relay_log		= /app/mysql/datadir/binlog/relay-bin
relay_log_index		= /app/mysql/datadir/binlog/relay-bin.index
relay_log_info_file	= /app/mysql/datadir/binlog/relay-bin.info
# 禁止写操作,防止误操作
read_only		= ON
```

### docker-compose启动
```
docker-compose up -d
```

### 配置主库
* 连接进入主库
```
mysql -uroot -p12345678 -P3306 127.0.0.1 
```
* 创建同步用户
```
grant replication slave,replication client on *.* to 'slave_user'@'%' identified by 'slave_user_2020';
flush privileges;
# 查看主服务器的状态信息,在从服务器中要用到
show master status\G
---------------------------
File: master-bin.000001
Position: 676

```
### 配置从库
* 连接进入从库
```
mysql -uroot -p12345678 -P3307 127.0.0.1 
```
* 配置同步主库信息
```
# master_log_file 和master_log_pos对应主库信息
change master to master_host='172.20.0.1',master_user='slave_user',
master_password='slave_user_2020',master_log_file='master-bin.000001',master_log_pos=676;
start slave;
# 查看从库同步状态
show slave status\G 
---------------------------
```
