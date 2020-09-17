## 部署MongoDB副本集群
### 环境准备
* 安装docker，安装docker-compose
* 生产环境最好是将不同的节点部署在不同的服务器上

### 生成keyFile
* MongoDB使用keyfile认证，副本集中的每个mongod实例使用keyfile内容作为认证其他成员的共享密码。mongod实例只有拥有正确的keyfile才可以加入副本集。
* keyFile的内容必须是6到1024个字符的长度，且副本集所有成员的keyFile内容必须相同。
* 有一点要注意是的：在UNIX系统中，keyFile必须没有组权限或完全权限（也就是权限要设置成X00的形式）。Windows系统中，keyFile权限没有被检查。
* 可以使用任意方法生成keyFile。例如，如下操作使用openssl生成复杂的随机的1024个字符串。然后使用chmod修改文件权限，只给文件拥有者提供读权限。
这是MongoDB官方推荐keyFile的生成方式：
```
# 400权限是要保证安全性，否则mongod启动会报错
openssl rand -base64 756 > mongodb.key
chmod 400 mongodb.key
```
* 每一个副本集成员都要使用相同的keyFile文件

### 安装mongodb与配置副本
#### docker-compose安装启动
* 编写docker-compose.yml文件，参考文件：https://github.com/huangronaldo/docker/edit/master/mongodb/docker-compose.yml
* 执行docker-compose启动
```
docker-compose up -d
```

#### 配置副本集
* docker exec命令进入容器: `docker exec -it mongo01 /bin/bash`
* mongo命令进入mongodb: `mongo -u root -p mongodb`
* mongo初始化命令初始化:
```
rs.initiate({
    _id: "mongos",
    members: [
        { _id : 0, host : "192.168.0.53:27017" },
        { _id : 1, host : "192.168.0.53:27018" },
        { _id : 2, host : "192.168.0.53:27019" }
    ]
});

# 如果显示如下，则表示执行初始化OK
{ "ok" : 1 }
```
* rs.status()查看当前副本集状态

#### 新增副本节点
* 使用docker-compose新增副本节点
```
version: '3'

services:
  mongodb:
    image: mongo
    restart: always
    container_name: mongo04
    volumes:
      - /app/mongodb/mongo04/data/db:/data/db
      - /app/mongodb/mongodb.key:/data/mongodb.key
    ports:
      - 27020:27017
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: mongodb
    command: mongod --replSet mongos --keyFile /data/mongodb.key
    entrypoint:
      - bash
      - -c
      - |
        chmod 400 /data/mongodb.key
        chown 999:999 /data/mongodb.key
        exec docker-entrypoint.sh $$@
```
* 进入mongo主节点添加副本节点
```
rs.add("192.168.0.53:27020")
```
